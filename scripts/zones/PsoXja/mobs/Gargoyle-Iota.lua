-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")

function onMobDeath(mob, player, isKiller)
    if
        GetMobByID(ID.mob.GARGOYLE_IOTA):isDead() and
        GetMobByID(ID.mob.GARGOYLE_KAPPA):isDead() and
        player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED
    then
        player:setCharVar("Gargoyles_Killed", 1)
    end
end

function onMobDespawn(mob)
end
