-----------------------------------
-- Area: Boneyard Gully
--  Mob: Nepionic Bladmall
--  ENM: Shell We Dance?
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobSpawn(mob)
end

function onMobFight(mob,target)
    local bfID  = mob:getBattlefield():getArea()
    local bladmall_id = GetMobByID(ID.shellWeDance[bfID].BLADMALL_ID)
    if bladmall_id:getHPP() <= 60 then
        if not mob:hasStatusEffect(tpz.effect.SILENCE) and mob:actionQueueEmpty() then
            if mob:getLocalVar("cooldown") == 0 then
                mob:castSpell(4, GetMobByID(ID.shellWeDance[bfID].BLADMALL_ID))--cure IV on Bladmall only if HP <= 60%
                mob:setLocalVar("cooldown", 20)
            end
        else
            mob:setLocalVar("cooldown", 20)
        end
    end
    if mob:getLocalVar("cooldown") > 0 then
        mob:setLocalVar("cooldown", mob:getLocalVar("cooldown") - 1)
    end
end

function onMobDeath(mob, player, isKiller)
end