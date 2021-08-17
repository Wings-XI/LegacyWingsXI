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

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:addListener("DEATH", "AERN_DEATH", function(mob)
        local timesReraised = mob:getLocalVar("AERN_RERAISES")

        if(math.random (1, 10) < 10) then
            -- reraise
            local target = mob:getTarget()
            local targetid = 0
            if target then
                targetid = target:getShortID()
            end
            mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
            mob:timer(9000, function(mob, targetid, timesReraised)
                mob:setHP(mob:getMaxHP())
                mob:AnimationSub(3)
                mob:resetAI()
                mob:stun(3000)
                local new_target = mob:getEntity(targetid)
                if new_target and mob:checkDistance(new_target) < 40 then
                    mob:updateClaim(new_target)
                    mob:updateEnmity(new_target)
                end
                mob:triggerListener("AERN_RERAISE", mob, timesReraised)
            end)
        else
            -- death
            mob:setMobMod(tpz.mobMod.NO_DROPS, 0)
            DespawnMob(aernA)
            DespawnMob(aernB)
        end

    end)
    mob:addListener("AERN_RERAISE", "IX_DRK_RERAISE", function(mob, timesReraised)
        mob:setLocalVar("AERN_RERAISES", timesReraised + 1)
        mob:timer(5000, function(mob)
            mob:AnimationSub(1)
        end)
    end)
end

function onMobEngaged(mob, target)
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
end