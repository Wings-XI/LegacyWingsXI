-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Warder (NIN, WHM)
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------

function onMobSpawn(mob)
    if mob:getMainJob() == tpz.job.NIN then
        mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
        mob:setLocalVar("BreakChance", 0) -- Nin mobs dont have a weapon to break
    elseif mob:getMainJob() == tpz.job.BST then
        SpawnMob(mob:getID() +1, mob:getInstance())
    end
end

function onMobFight(mob, target)
    if mob:getMainJob() == tpz.job.BST then
        local pet = GetMobByID(mob:getID() +1, mob:getInstance())
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobSkillFinished(mob, target, skill)
    local skillId = skill:getID()
    if skillId == 1733 or skillId == 1923 or skillId == 2361 or skillId == 1736 then
        if (math.random(100) < 80) then
            local instance = mob:getInstance()
            for i, gateid in ipairs(ID.mob[IMPERIAL_AGENT_RESCUE].GATES) do
                local gate = instance:getEntity(bit.band(gateid, 0xFFF), tpz.objType.MOB)
                if gate and gate:isAlive() and mob:checkDistance(gate) <= 10 and mob:isFacing(gate) then
                    gate:hideName(false)
                    gate:timer(1, function(gate)  gate:hideName(true) end)
                    gate:timer(2000, function(gate)  gate:triggerListener("WEAPONSKILL_TAKE", gate, skillId) end)
                    return  gate:getShortID()
                end
            end
        end
    end
    return 0
end
