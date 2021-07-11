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
    end
    if mob:getMainJob() == tpz.job.BST then
        mob:setLocalVar("petID", mob:getID() +1)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobWeaponSkill(player, mob, skill, action)
    local skillId = skill:getID()
    if skillId == 1733 or skillId == 1923 or skillId == 2361 then
        if (math.random(100) < 80) then
            local instance = mob:getInstance()
            for i, gateid in ipairs(ID.mob[IMPERIAL_AGENT_RESCUE].GATES) do
                local gate = instance:getEntity(bit.band(gateid, 0xFFF), tpz.objType.MOB)
                if gate and gate:isAlive() and mob:checkDistance(gate) <= 10 and mob:isFacing(gate) then
                    gate:triggerListener("WEAPONSKILL_TAKE", gate, skillId)
                end
            end
        end
    end
end
