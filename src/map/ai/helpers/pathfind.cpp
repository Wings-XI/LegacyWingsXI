﻿/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

// REVERTED NAVMESH CHANGES FROM TOPAZ AFTER ISSUES

#include "pathfind.h"
#include "../../entities/baseentity.h"
#include "../../entities/mobentity.h"
#include "../../../common/utils.h"
#include "../../zone.h"

namespace
{
    bool arePositionsClose(const position_t& a, const position_t& b)
    {
        return distance(a, b) < 1.0f;
    }
} // namespace

CPathFind::CPathFind(CBaseEntity* PTarget)
: m_POwner(PTarget)
, m_pathFlags(0)
, m_carefulPathing(false)
{
    Clear();
}

CPathFind::~CPathFind()
{
    m_POwner = nullptr;
    Clear();
}

bool CPathFind::RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;
    Clear();

    m_roamFlags = roamFlags;

    if (isNavMeshEnabled())
    {

        if (FindRandomPath(point, maxRadius, maxTurns, roamFlags))
        {
            return true;
        }
        else
        {
            Clear();
            return false;
        }
    }
    else
    {
        // no point worm roaming cause it'll move one inch
        if (m_roamFlags & ROAMFLAG_WORM)
        {
            Clear();
            return false;
        }

        m_points.push_back({point.x - 1 + rand() % 2, point.y, point.z - 1 + rand() % 2, 0, 0});

    }

    return true;
}

bool CPathFind::PathTo(const position_t& point, uint8 pathFlags, bool clear)
{
    TracyZoneScoped;
    // don't follow a new path if the current path has script flag and new path doesn't
    if (IsFollowingPath() && (m_pathFlags & PATHFLAG_SCRIPT) && !(pathFlags & PATHFLAG_SCRIPT))
        return false;

    if (clear)
    {
        Clear();
    }

    m_pathFlags = pathFlags;

    if (isNavMeshEnabled())
    {
        // TODO mobs might literally not be able to get to some places with this?
        // if (m_carefulPathing){
        //     m_POwner->loc.zone->m_navMesh->snapToValidPosition(m_POwner->loc.p);
        // }

        bool result = false;

        if (m_pathFlags & PATHFLAG_WALLHACK)
        {
            result = FindClosestPath(m_POwner->loc.p, point);
        }
        else
        {
            result = FindPath(m_POwner->loc.p, point);
        }

        if (!result)
        {
            Clear();
        }

        return result;
    }
    else
    {
        m_points.push_back(point);
    }

    return true;
}

bool CPathFind::PathInRange(const position_t& point, float range, uint8 pathFlags /*= 0*/, bool clear /*= true*/)
{
    TracyZoneScoped;
    if (clear)
    {
        Clear();
    }
    m_distanceFromPoint = range;
    bool result = PathTo(point, pathFlags, false);
    PrunePathWithin(range);
    return result;
}

bool CPathFind::PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();
    //position_t* lastPoint = &point;

    //float randomRadian = tpzrand::GetRandomNumber<float>(0, 2 * (float)M_PI);
    //lastPoint->x += cosf(randomRadian) * distanceFromPoint;
    //lastPoint->z += sinf(randomRadian) * distanceFromPoint;

    // save for sliding logic
    m_originalPoint     = point;
    m_distanceFromPoint = distanceFromPoint;

    // Don't clear path so
    // original point / distance are kept
    return PathTo(point, pathFlags, false);
}

bool CPathFind::PathThrough(std::vector<position_t>&& points, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    m_pathFlags = pathFlags;

    AddPoints(std::move(points), m_pathFlags & PATHFLAG_REVERSE);

    return true;
}

bool CPathFind::WarpTo(const position_t& point, float maxDistance)
{
    TracyZoneScoped;
    Clear();

    position_t newPoint = nearPosition(point, maxDistance, (float)M_PI);

    m_POwner->loc.p.x      = newPoint.x;
    m_POwner->loc.p.y      = newPoint.y;
    m_POwner->loc.p.z      = newPoint.z;
    m_POwner->loc.p.moving = 0;

    LookAt(point);
    m_POwner->updatemask |= UPDATE_POS;

    return true;
}

bool CPathFind::isNavMeshEnabled()
{
    return m_POwner->loc.zone && m_POwner->loc.zone->m_navMesh != nullptr;
}

bool CPathFind::ValidPosition(const position_t& pos)
{
    TracyZoneScoped;
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->validPosition(pos);
    }
    else
    {
        return true;
    }
}

void CPathFind::LimitDistance(float maxLength)
{
    m_maxDistance = maxLength;
}

void CPathFind::StopWithin(float within)
{
    TracyZoneScoped;
    if (!IsFollowingPath()) return;
    // TODO: cut up path

    position_t& lastPoint = m_points.back();
    position_t* secondLastPoint = nullptr;

    if (m_points.size() == 1)
    {
        secondLastPoint = &m_POwner->loc.p;
        }
    else
    {
        secondLastPoint = &m_points[m_points.size() - 2];
    }

    float distanceTo = distance(lastPoint, *secondLastPoint);

    if (distanceTo > within)
    {
        // reduce last point to stop within the given number
        float radians = atanf((secondLastPoint->z - lastPoint.z) / (secondLastPoint->x - lastPoint.x)) * (float)(M_PI / 180.0f);

        lastPoint.x -= cosf(radians) * within;
        lastPoint.z -= sinf(radians) * within;
        }
        else
        {
        // i'm already there, stop moving
        if (m_points.size() == 1)
        {
            Clear();
        }
        else
        {
            // remove last point, it'll make me too close
            m_points.pop_back();
        }
    }
}

void CPathFind::PrunePathWithin(float within)
{
    TracyZoneScoped;

    if (!IsFollowingPath())
    {
        return;
    }

    position_t* targetPoint     = &m_points.back();
    position_t* secondLastPoint = nullptr;

    while (m_points.size() > 1)
    {
        secondLastPoint = &m_points.end()[-2];

        if (distance(*targetPoint, *secondLastPoint) > within)
        {
            break;
        }
        m_points.erase(m_points.end() - 2);
    }
}

void CPathFind::FollowPath()
{
    TracyZoneScoped;
    if (!IsFollowingPath())
    {
        return;
    }

    m_onPoint = false;

    // move mob to next point
    position_t targetPoint = m_points[m_currentPoint];
    position_t startingPoint = m_POwner->loc.p;

    float origDistanceMoved = m_distanceMoved;
    StepTo(targetPoint, m_pathFlags & PATHFLAG_RUN);

    if (isNavMeshEnabled() && m_carefulPathing)
    {
        // - when careful pathing is enabled on a mob, it snaps to nearest navmesh every `StepTo`
        //    - If the next point in its pathlist cannot be raycast, it increments a counter `CarefulPathSnapCount`
        //    - if that counter gets past a threshold
        //    -  `CarefulPathSnapMax`, the path is cleared and mob is snapped away from the destination a bit and repathed
        //      - would like to maybe pathfind to the middle point in the list of its remaining pathpoints (`nextPoint = m_points[(int16)(( m_currentPoint + m_points.size() - 1) / 2)];`)
        //    - Another variable, `CarefulPathSnapMin`, is incremented. This is actually the requisit number of failed aforementioned raycasts.
        //    - This essentially lets a mob's path get sloppier if it continuously gets stuck
        //    - For example: pathing Anantaboga back and forth between zoneline near his spawn and the tunnels towards o.crabs got `CarefulPathSnapMin` up to 10, but he still pathed pretty cleanly (cut some corners but never bounced down to the water level, etc)
        //    - Note that in these changes, raycast has a check for a new concept, `CNavMesh::onSameFloor`. This is, i think, the main thing being relied on when the next pathpoint's raycast failure is determined up above
        if (m_POwner->objtype == TYPE_MOB && static_cast<CMobEntity*>(m_POwner)->GetBattleTargetID() != 0)
        {
            if (m_currentPoint == 0 && origDistanceMoved == 0)// when mob is close to destination, reset sloppy pathing (i.e. when path is recently cleared)
            {
                ShowDebug("Mob %s (%u) is now resetting careful pathing sloppiness\n", m_POwner->GetName(), m_POwner->id);
                m_POwner->SetLocalVar("CarefulPathSnapMax", 10);
                m_POwner->SetLocalVar("CarefulPathSnapMin", 1);
            }

        }
        else
        {
            // do not snapTo while not in combat
            m_POwner->SetLocalVar("CarefulPathSnapMax", 1);
            m_POwner->SetLocalVar("CarefulPathSnapMin", 0);
        }

        // loosen the meaning of "careful pathing" to only snap so many times if you can't raycast to the next pathPoint
        if (m_POwner->GetLocalVar("CarefulPathSnapMax") > 1 &&
            !m_POwner->loc.zone->m_navMesh->raycast(startingPoint, targetPoint, false))
        {
            m_POwner->SetLocalVar("CarefulPathSnapCount", m_POwner->GetLocalVar("CarefulPathSnapCount") + 1);
        }
        else
        {
            m_POwner->SetLocalVar("CarefulPathSnapCount", 0);
        }

        // Snap mob to closest navmesh every StepTo, unless we've hit our limit on snapping when unable to raycast to next point
        // do not re-path if not in combat
        if (m_POwner->GetLocalVar("CarefulPathSnapCount") < m_POwner->GetLocalVar("CarefulPathSnapMax") ||
            m_POwner->GetLocalVar("CarefulPathSnapMax") <= 1)
        {
            // When snapping, get sloppier over time by skipping the first few Steps when unable to raycast to next point
            // But only skip the snapto after a few un-raycastable pathpoints
            if (m_POwner->GetLocalVar("CarefulPathSnapCount") >= m_POwner->GetLocalVar("CarefulPathSnapMin") - 4 &&
                m_POwner->GetLocalVar("CarefulPathSnapMax") > 1)
            {
                m_POwner->loc.zone->m_navMesh->snapToValidPosition(m_POwner->loc.p);
            }
        }
        else
        {
            ShowDebug("Mob %s (%u) snapped %u times and is resetting path\n", m_POwner->GetName(), m_POwner->id, m_POwner->GetLocalVar("CarefulPathSnapCount"));
            m_POwner->SetLocalVar("CarefulPathSnapMax", m_POwner->GetLocalVar("CarefulPathSnapMax") + 1);
            m_POwner->SetLocalVar("CarefulPathSnapMin", m_POwner->GetLocalVar("CarefulPathSnapMin") + 1);

            // recalculate path by:
            // -- backpedaling a few yalms away from the destination, snap to valid point, then clear path
            targetPoint = m_points[m_points.size() - 1];
            // below can NaN if points are close enough
            if (abs(targetPoint.x - m_POwner->loc.p.x) > .1f)
                m_POwner->loc.p.x += 2 * (targetPoint.x - m_POwner->loc.p.x) / abs(targetPoint.x - m_POwner->loc.p.x);
            if (abs(targetPoint.z - m_POwner->loc.p.z) > .1f)
                m_POwner->loc.p.z += 2 * (targetPoint.z - m_POwner->loc.p.z) / abs(targetPoint.z - m_POwner->loc.p.z);
            m_POwner->loc.zone->m_navMesh->snapToValidPosition(m_POwner->loc.p);
            startingPoint = m_POwner->loc.p;
            Clear();
            FindClosestPath(startingPoint, targetPoint);
            m_POwner->SetLocalVar("CarefulPathSnapCount", 0);
            return;
        }
    }

    if (m_maxDistance && m_distanceMoved >= m_maxDistance)
    {
        // if I have a max distance, check to stop me
        Clear();

        m_onPoint = true;
    }
    else if (AtPoint(targetPoint))
    {
        m_currentPoint++;

        if (m_currentPoint >= (int16)m_points.size())
        {
            FinishedPath();
        }

        m_onPoint = true;
    }
}

void CPathFind::StepTo(const position_t& pos, bool run)
{
    TracyZoneScoped;
    float speed = GetRealSpeed() + m_POwner->GetLocalVar("CarefulPathSnapCount");

    // TODO should this be /20 for everyone?
    float stepDistance = speed / 24.5f; // 40 ms means 4 units per second, so 1.6 units per step (server tick rate is 2.5/sec)
    if (m_carefulPathing){
        // increase step distance slightly since we snap positions every tick
        stepDistance = speed / 20.0f;
    }

    int8 mode = 2;

    if (!run)
    {
        mode = 1;
        stepDistance /= 2;
    }

    float distanceTo = distance(m_POwner->loc.p, pos);
    float diff_y       = pos.y - m_POwner->loc.p.y;

    // face point mob is moving towards
    LookAt(pos);

    if (distanceTo <= m_distanceFromPoint + stepDistance)
    {
        m_distanceMoved += distanceTo - m_distanceFromPoint;

        if (m_distanceFromPoint == 0)
        {
            m_POwner->loc.p.x = pos.x;
            m_POwner->loc.p.y = pos.y;
            m_POwner->loc.p.z = pos.z;
        }
        else
        {
            float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

            m_POwner->loc.p.x += cosf(radians) * (distanceTo - m_distanceFromPoint);
            m_POwner->loc.p.z += sinf(radians) * (distanceTo - m_distanceFromPoint);
            if (abs(diff_y) > .5f)
            {
                // Don't step too far vertically by simply utilizing the slope
                float new_y = m_POwner->loc.p.y + stepDistance * (pos.y - m_POwner->loc.p.y) / distance(m_POwner->loc.p, pos, true);
                float min_y = (pos.y + m_POwner->loc.p.y - abs(pos.y - m_POwner->loc.p.y)) / 2;
                float max_y = (pos.y + m_POwner->loc.p.y + abs(pos.y - m_POwner->loc.p.y)) / 2;
                // clamp new_y between start and end vertical position
                new_y             = new_y < min_y ? min_y : new_y;
                m_POwner->loc.p.y = new_y > max_y ? max_y : new_y;
            }
            else
            {
                m_POwner->loc.p.y = pos.y;
            }
        }
    }
    else
    {
        m_distanceMoved += stepDistance;
        // take a step towards target point
        float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

        m_POwner->loc.p.x += cosf(radians) * stepDistance;
        m_POwner->loc.p.z += sinf(radians) * stepDistance;
        if (abs(diff_y) > .5f)
        {
            // Don't step too far vertically by simply utilizing the slope
            float new_y = m_POwner->loc.p.y + stepDistance * (pos.y - m_POwner->loc.p.y) / distance(m_POwner->loc.p, pos, true);
            float min_y = (pos.y + m_POwner->loc.p.y - abs(pos.y - m_POwner->loc.p.y)) / 2;
            float max_y = (pos.y + m_POwner->loc.p.y + abs(pos.y - m_POwner->loc.p.y)) / 2;
            // clamp new_y between start and end vertical position
            new_y             = new_y < min_y ? min_y : new_y;
            m_POwner->loc.p.y = new_y > max_y ? max_y : new_y;
        }
        else
        {
            m_POwner->loc.p.y = pos.y;
        }
    }


    m_POwner->loc.p.moving += (uint16)((0x36 * ((float)speed / 0x28)) - (0x14 * (mode - 1)));

    if (m_POwner->loc.p.moving > 0x2fff)
    {
        m_POwner->loc.p.moving = 0;
    }

    m_POwner->updatemask |= UPDATE_POS;
}

bool CPathFind::FindPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;

    if (m_points.empty())
    {
        ShowNavError("CPathFind::FindPath Entity (%s - %d) could not find path\n", m_POwner->GetName(), m_POwner->id);
        return false;
    }

    return true;
}

bool CPathFind::FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;

    if (!isNavMeshEnabled())
    {
        return false;
    }

    auto m_turnLength = tpzrand::GetRandomNumber((int)maxTurns) + 1;

    position_t startPosition = start;

    // find end points for turns
    for (int8 i = 0; i < m_turnLength; i++) {
        // look for new point centered around the last point
        auto status = m_POwner->loc.zone->m_navMesh->findRandomPosition(startPosition, maxRadius);

        // couldn't find one point so just break out
        if (status.first != 0) {
            return false;
        }

        m_turnPoints.push_back(status.second);
        // setting this chains the roaming points, drawing circles around each subsequent roaming turn
        // startPosition = m_turnPoints[i];
    }
    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, m_turnPoints[0]);
    m_currentPoint = 0;

    if (m_points.empty())
    {
        return false;
    }

    return true;
}

bool CPathFind::FindClosestPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;
    // Even with careful pathing I don't think we need to limit the endpoint
    //if (!m_carefulPathing ||
    //    m_points.empty() ||
    //    distanceSquared(GetDestination(), end) >= 5 * 5) { // so carefulpathing-enabled mobs don't hop across navmesh paths instead of walking around
        m_points.push_back(end);  // this prevents exploits with navmesh / impassible terrain
    //}

    return true;
}

void CPathFind::LookAt(const position_t& point)
{
    // Avoid unpredictable results if we're too close.
    if (!distanceWithin(m_POwner->loc.p, point, 0.1f, true))
    {
        m_POwner->loc.p.rotation = worldAngle(m_POwner->loc.p, point);
        m_POwner->updatemask |= UPDATE_POS;
    }
}

bool CPathFind::OnPoint()
{
    return m_onPoint;
}

float CPathFind::GetRealSpeed()
{
    uint8 realSpeed = m_POwner->speed;

    // 'GetSpeed()' factors in movement bonuses such as map confs and modifiers.
    // Lets not factor in player map conf or mod's to non players.
    // (Mobs should just have speed set directly instead, and NPC's don't have mods)
    // Twilight: Let's revert that so we don't break the gravity spell when cast on mobs
    if (m_POwner->objtype != TYPE_NPC)
    {
        realSpeed = ((CBattleEntity*)m_POwner)->GetSpeed();
    }

    // Lets not check mob things on non mobs
    if (m_POwner->objtype == TYPE_MOB)
    {
        if (realSpeed == 0 && (m_roamFlags & ROAMFLAG_WORM))
        {
            realSpeed = 20;
        }
        else if (m_POwner->animation == ANIMATION_ATTACK)
        {
            realSpeed = realSpeed + map_config.mob_speed_mod;
        }
    }

    return realSpeed;
}

bool CPathFind::IsFollowingPath()
{
    return !m_points.empty();
}

bool CPathFind::IsFollowingScriptedPath()
{
    return IsFollowingPath() && m_pathFlags & PATHFLAG_SCRIPT;
}

bool CPathFind::AtPoint(const position_t& pos)
{
    if (m_distanceFromPoint == 0)
    {
        return distanceWithin(m_POwner->loc.p, pos, 0.1f);
    }
    else
    {
        return distanceWithin(m_POwner->loc.p, pos, m_distanceFromPoint + 0.2f);
    }
}

bool CPathFind::InWater()
{
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->inWater(m_POwner->loc.p);
    }

    return false;
}

bool CPathFind::CanSeePoint(const position_t& point, bool lookOffMesh)
{
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->raycast(m_POwner->loc.p, point, lookOffMesh);
    }

    return true;
}

const position_t& CPathFind::GetDestination() const
{
    return m_points.back();
}

void CPathFind::SetCarefulPathing(bool careful)
{
    m_carefulPathing = careful;
}

void CPathFind::Clear()
{
    m_distanceFromPoint = 0;
    m_pathFlags = 0;
    m_roamFlags = 0;
    m_points.clear();

    m_currentPoint = 0;
    m_maxDistance = 0;
    m_distanceMoved = 0;

    m_onPoint = true;

    m_currentTurn = 0;
    m_turnPoints.clear();
}

void CPathFind::AddPoints(std::vector<position_t>&& points, bool reverse)
{
    if (points.size() > MAX_PATH_POINTS)
    {
        ShowWarning("CPathFind::AddPoints Given too many points (%d). Limiting to max (%d)\n", points.size(), MAX_PATH_POINTS);
        points.resize(MAX_PATH_POINTS);
    }

    m_points = std::move(points);

    if (reverse)
        std::reverse(m_points.begin(), m_points.end());
}

void CPathFind::FinishedPath()
{
    m_currentTurn++;

    // turning is only available to navmeshed maps
    if (m_currentTurn < m_turnPoints.size() && isNavMeshEnabled())
    {
        // move on to next turn
        position_t& nextTurn = m_turnPoints[m_currentTurn];

        bool result = FindPath(m_POwner->loc.p, nextTurn);

        if (!result)
        {
            Clear();
        }
    }
    else
    {
        Clear();
    }
}
