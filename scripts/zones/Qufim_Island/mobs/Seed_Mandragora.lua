-----------------------------------
-- Area: Qufim Island
--  Mob: Seed Mandragora
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onMobInitialize(mob)
    -- Takes 3x damage
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 30)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:addListener("DEATH", "DEATH_", function(mob, killer)
        if killer then
            local target = mob:getTarget()
            mob:timer(math.random(8000, 10000), function(mob)
                local mandragoraKilled = killer:getCharVar("SEED_MANDY")
                local spawnMandragora = true

                -- Limit the amount of mandragora to spawn when getting close to 30
                if mandragoraKilled >= 26 and mob:getID() == ID.mob.SEED_MANDRAGORA[1] then
                    spawnMandragora = false
                elseif mandragoraKilled >= 27 and mob:getID() == ID.mob.SEED_MANDRAGORA[2] then
                    spawnMandragora = false
                elseif mandragoraKilled >= 28 and mob:getID() == ID.mob.SEED_MANDRAGORA[3] then
                    spawnMandragora = false
                elseif mandragoraKilled >= 29 and mob:getID() == ID.mob.SEED_MANDRAGORA[4] then
                    spawnMandragora = false
                elseif mandragoraKilled >= 30 and mob:getID() == ID.mob.SEED_MANDRAGORA[5] then
                    spawnMandragora = false
                end

                if spawnMandragora then
                    mob:spawn()
                    if target and target:isAlive() and mob:checkDistance(target) < 40 then
                        mob:updateEnmity(target)
                    elseif killer:isAlive() and mob:checkDistance(killer) < 40 then
                        mob:updateEnmity(killer)
                    else
                        local partySize = killer:getPartySize()
                        local i = 1
                        for _, partyMember in pairs(killer:getAlliance()) do
                            if partyMember:isAlive() and mob:checkDistance(partyMember) < 40 then
                                mob:updateEnmity(partyMember)
                                break
                            elseif i == partySize then
                                mob:disengage()
                            end
                            i = i + 1
                        end
                    end
                end
            end)
        end  
    end)
end

function onMobSpawn(mob)
    mob:removeListener("DEATH_SPAWN_CASKET")
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 1800)
end

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 30)
end

function onMobDeath(mob, player, isKiller)
    local missionACP = player:getCurrentMission(ACP)
    local now = tonumber(os.date("%j"))
    local SR = player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
    local SC = player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
    local SV = player:hasKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
    local amberKey = player:hasKeyItem(tpz.ki.AMBER_KEY)
    local lastAmber = player:getCharVar("LastAmberKey") -- When last Amber key was obtained
    local lastViridian = player:getCharVar("LastViridianKey") -- When last Viridian key was obtained

    local mandragoraKilled = player:getCharVar("SEED_MANDY")
    mandragoraKilled = mandragoraKilled + 1 -- Add this one to death counter
    player:setCharVar("SEED_MANDY", mandragoraKilled)

    if mandragoraKilled == 30 then
        player:delStatusEffect(tpz.effect.CONFRONTATION)

        if SR and SC and SV and now ~= lastViridian and now ~= lastAmber and not amberKey then
            player:delKeyItem(tpz.ki.SEEDSPALL_ROSEUM)
            player:delKeyItem(tpz.ki.SEEDSPALL_CAERULUM)
            player:delKeyItem(tpz.ki.SEEDSPALL_VIRIDIS)
            player:addExp(500)
            player:addKeyItem(tpz.ki.AMBER_KEY)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AMBER_KEY)
            player:setCharVar("LastAmberKey", os.date("%j"))
        end

        -- Reset if on a farther mission so they skip the cs
        if missionACP ~= tpz.mission.id.acp.GATHERER_OF_LIGHT_II then
            player:setCharVar("SEED_MANDY", 99)
        end
    end

    if isKiller then
        DespawnMob(mob:getID())
    end
end