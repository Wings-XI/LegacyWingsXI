-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
-- Mob: Qiqirn Mine
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/allyassist")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/instance")
-----------------------------------

function onMobSpawn(mob)
    local instance = mob:getInstance()
    local players = instance:getChars()
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)

    for i, v in pairs(players) do
        v:messageSpecial(ID.text.MINE_COUNTDOWN,10)
        mob:timer(5000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 5) end)
        mob:timer(6000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 4) end)
        mob:timer(7000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 3) end)
        mob:timer(8000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 2) end)
        mob:timer(9000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 1) end)
        mob:timer(10000, function(mob) v:messageSpecial(ID.text.MINE_COUNTDOWN, 0) end)
        mob:timer(10000, function(mob) 
            if mob:getTarget():getTarget() ~= nil then
                mob:useMobAbility(1838) 
            end
        end)
        mob:timer(12000, function(mob) mob:setHP(0) end)
    end
end

function onMobSkillFinished(mob, target, skill)
    if target:getTarget() ~= nil then
        local skillId = skill:getID()
        local wallid = target:getTarget():getID()
        local instance = target:getInstance()
        local wall = instance:getEntity(bit.band(wallid, 0xFFF), tpz.objType.MOB)
        wall:timer(2000, function(wall) wall:triggerListener("WEAPONSKILL_TAKE", wall, skillId) end)
        return wall:getShortID()
    end
    return 0
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)

end
