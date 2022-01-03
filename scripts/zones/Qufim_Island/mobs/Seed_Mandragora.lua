-----------------------------------
-- Area: Qufim Island
--  Mob: Seed Mandragora
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 10)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:addListener("DEATH", "DEATH_", function(mob, killer)
        if killer then
            local target = mob:getTarget()
            mob:timer(math.random(8000, 10000), function(mob)
                local mandragoraKilled = killer:getCharVar("SEED_MANDY")
                local spawnMandragora = true

                if mandragoraKilled >= 30 then
                    spawnMandragora = false
                end

                if spawnMandragora then
                    mob:spawn()
                    if target and target:isAlive() then
                        mob:updateEnmity(target)
                    elseif killer:isAlive() then
                        mob:updateEnmity(killer)
                    else
                        local partySize = killer:getPartySize()
                        local i = 1
                        for _, partyMember in pairs(killer:getAlliance()) do
                            if partyMember:isAlive() then
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
    mob:addMod(tpz.mod.DMG, 200)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 75)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 1800)

    mob:timer(math.random(2000), function(mob)
        local hasTarget = mob:getTarget()

        -- If no target, see if any mandy has a target
        if not hasTarget then
            for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
                local mandragora = GetMobByID(id)
                if mandragora:isSpawned() then  
                    local target = mandragora:getTarget()
                    if target then
                        mob:updateEnmity(target)
                        hasTarget = true
                        break
                    end
                end
            end
        end

        -- if still no target, despawn everything
        if not hasTarget then
            for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
               DespawnMob(id)
            end
        end
    end)
end

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 10)
end

function onMobFight(mob, target)
    if mob:checkDistance(-120.342, -19.471, 306.661) > 30 then     -- If players wander too far, end confrontation
        for _, partyMember in pairs(target:getAlliance()) do
            partyMember:delStatusEffect(tpz.effect.CONFRONTATION)
        end

        for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
            DespawnMob(id)
        end
    end

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

        if isKiller then
            for i, id in ipairs(ID.mob.SEED_MANDRAGORA) do
                local mandragora = GetMobByID(id)
                if mandragora:isSpawned() then    
                    DespawnMob(id)
                end
            end
        end
    elseif isKiller then
        DespawnMob(mob:getID())
    end
end