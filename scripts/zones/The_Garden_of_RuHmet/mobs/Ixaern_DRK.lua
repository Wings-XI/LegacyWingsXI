-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Ix'aern DRK
-- !pos -240 5.00 440 35
-- !pos -280 5.00 240 35
-- !pos -560 5.00 239 35
-- !pos -600 5.00 440 35
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

local aernA = 16921019
local aernB = 16921020
local msgTiers = {
    [3] = "The Ix'Aern looks weakened.",
    [10] = "The Ix'Aern looks like it's in rough shape.",
    [54] = "The Ix'Aern looks like it can barely hold it together."
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:addListener("DEATH", "AERN_DEATH", function(mob, killer)
        if killer then
            if(math.random (1, 10) < 10) then
                -- reraise
                mob:setLocalVar("AERN_RERAISES", mob:getLocalVar("AERN_RERAISES") + 1)
                mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
                local target = mob:getTarget()
                mob:timer(9000, function(mob)
                    mob:setHP(mob:getMaxHP())
                    mob:setMP(mob:getMaxMP())
                    mob:AnimationSub(3)
                    mob:resetAI()
                    mob:stun(3000)
                    if target and target:isAlive() and mob:checkDistance(target) < 40 then
                        mob:updateClaim(target)
                        mob:updateEnmity(target)
                    elseif killer:isAlive() and mob:checkDistance(killer) < 40 then
                        mob:updateClaim(killer)
                        mob:updateEnmity(killer)
                    else
                        local partySize = killer:getPartySize()
                        local i = 1
                        for _, partyMember in pairs(killer:getAlliance()) do
                            if partyMember:isAlive() and mob:checkDistance(partyMember) < 40 then
                                mob:updateClaim(partyMember)
                                mob:updateEnmity(partyMember)
                                break
                            elseif i == partySize then
                                mob:disengage()
                            end
                            i = i + 1
                        end
                    end
                    mob:triggerListener("AERN_RERAISE", mob)
                end)
            else
                -- death
                mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
                DespawnMob(aernA)
                DespawnMob(aernB)
            end
        end
    end)
    mob:addListener("AERN_RERAISE", "IX_DRK_RERAISE", function(mob)
        mob:timer(5000, function(mob)
            mob:AnimationSub(1)
        end)
    end)
end

function onMobEngaged(mob, target)
    -- WINGSCUSTOM: reduce max hp based on # of reraises
    local rrcount = math.abs(mob:getLocalVar("AERN_RERAISES"))
    HPPreduction = math.ceil(110 - 15 * math.log(1 + rrcount))
    HPPreduction = utils.clamp(HPPreduction, 10, 100)
    if HPPreduction < 95 then
        mob:setMod(tpz.mod.HPP, -100 + HPPreduction)
        mob:updateHealth()
        if target:isPC() then
            local msgIndex = 0
            if rrcount >= 54 then
                msgIndex = 54
            elseif rrcount >= 10 then
                msgIndex = 10
            elseif rrcount >= 3 then
                msgIndex = 3
            end

            if msgIndex > 0 then
                target:PrintToArea(msgTiers[msgIndex] .. string.format(" (%s)", rrcount), tpz.msg.channel.SYSTEM_3, tpz.msg.area.SAY)
            end
        end
    end

    local mobID = mob:getID()
    for i = mobID+1, mobID+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            m:updateEnmity(target)
        end
    end
end

function onMobSpawn(mob)
    mob:AnimationSub(1)

    tpz.mix.jobSpecial.config(mob, {
        delay = 60,
        specials =
        {
            {
                id = tpz.jsa.BLOOD_WEAPON_IXDRK,
                hpp = 100,
                cooldown = 180,
                endCode = function(mob)
                    mob:SetMagicCastingEnabled(false)
                    mob:timer(30000, function(mob)
                        mob:SetMagicCastingEnabled(true)
                    end)
                end,
            }
        }
    })
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setLocalVar("AERN_RERAISES", 0)

    local mobId = mob:getID()
    for i = mobId + 1, mobId + 2 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
    
    local qmDrk = GetNPCByID(ID.npc.QM_IXAERN_DRK)
    qmDrk:setLocalVar("nextMove", os.time() + 1800 + FORCE_SPAWN_QM_RESET_TIME) -- 30 minutes from now, once the QM respawns
    -- the QM's position and hate were already reset when the mob popped, we just need this here in the despawn function for the correct respawn timing
end