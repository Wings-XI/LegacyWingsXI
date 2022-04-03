-----------------------------------
-- Area: The Sanctuary of Zi'tah
--   NM: Skeleton Scuffer
--   A Shantotto Ascension NM
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLASHRES, 0)
    mob:setMod(tpz.mod.H2HRES, 1000)
    mob:setMod(tpz.mod.IMPACTRES, 1000)
    mob:setMod(tpz.mod.PIERCERES, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGRANGE, -100)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("Disengage", os.time()+195)
end

function onMobFight(mob, target)
    local disengage = mob:getLocalVar("Disengage")
    if os.time() > disengage then
        DespawnMob(mob:getID())
    end
end

function onMobRoam(mob)
    local hour = VanadielHour()
    if hour >= 7 and hour < 17 then
        DespawnMob(mob:getID())
    end
end

function onMobDeath(mob, player, isKiller)
    mob:setLocalVar("respawn", os.time() + 120)
    for _, member in pairs(player:getParty()) do
        local chance = math.random(1,2)
        if chance == 1 and member:hasKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT) == false and member:getCurrentMission(ASA) == tpz.mission.id.asa.SHANTOTTO_IN_CHAINS then
            member:addKeyItem(tpz.ki.LUMINOUS_RED_FRAGMENT)
            member:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LUMINOUS_RED_FRAGMENT)
        end
    end
end