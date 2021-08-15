-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle
-----------------------------------

require("scripts/globals/status")
local ID = require("scripts/zones/PsoXja/IDs")

function onMobInitialize(mob)
    mob:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
end

function onMobFight( mob, target )
    local hpp = mob:getHPP()

    --if hpp <= 80 and hpp > 60  then
    --    mob:deleteStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
end

function onMobDeath(mob, player, isKiller)
    if
        GetMobByID(ID.mob.GARGOYLE_IOTA):isDead() and
        GetMobByID(ID.mob.GARGOYLE_KAPPA):isDead() and
        player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED
    then
        player:setCharVar("Gargoyles_Killed", 1)
        GetNPCByID(16814499):setAnimation(8)
    end
end

function onMobDespawn(mob)
end
