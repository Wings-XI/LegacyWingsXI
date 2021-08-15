-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle
-----------------------------------

require("scripts/globals/status")
local ID = require("scripts/zones/PsoXja/IDs")

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRES, 30)
    mob:setMod(tpz.mod.GRAVITYRES, 30)
    mob:setMod(tpz.mod.THUNDERRES, -27)
    mob:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
end

function onMobFight(mob, target)
-- every 30sec will switch between magic resist and invincible
    local changeTime = mob:getLocalVar("switchTime")

    if (mob:getBattleTime() - changeTime > 30) then
        if mob:isAlive() and mob:hasStatusEffect(tpz.effect.INVINCIBLE) then
            mob:delStatusEffect(tpz.effect.INVINCIBLE)
            applyFullMagicRes(mob)
            mob:setAnimation(433)
        else
            mob:addStatusEffect(tpz.effect.INVINCIBLE, 1, 0, 0)
            removeFullMagicRes(mob)
            mob:setAnimation(432)
        mob:setLocalVar("switchTime", mob:getBattleTime())
    end
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

function applyFullMagicRes(mob, target)
    mob:setMod(tpz.mod.FIRERES, 1000)
    mob:setMod(tpz.mod.ICERES, 1000)
    mob:setMod(tpz.mod.WINDRES, 1000)
    mob:setMod(tpz.mod.EARTHRES, 1000)
    mob:setMod(tpz.mod.THUNDERRES, 1000)
    mob:setMod(tpz.mod.WATERRES, 1000)
    mob:setMod(tpz.mod.LIGHTRES, 1000)
    mob:setMod(tpz.mod.DARKRES, 1000)
    mob:setMod(tpz.mod.PARALYZERESTRAIT, 100)
    mob:setMod(tpz.mod.BLINDRESTRAIT, 100)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.VIRUSRESTRAIT, 100)
    mob:setMod(tpz.mod.PETRIFYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.CURSERESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.SLOWRESTRAIT, 100)
    mob:setMod(tpz.mod.STUNRESTRAIT, 100)
    mob:setMod(tpz.mod.CHARMRESTRAIT, 100)
    mob:setMod(tpz.mod.AMNESIARESTRAIT, 100)
    mob:setMod(tpz.mod.DEATHRESTRAIT, 100)
end

function removeFullMagicRes(mob, target)
    mob:delMod(tpz.mod.FIRERES)
    mob:delMod(tpz.mod.ICERES)
    mob:delMod(tpz.mod.WINDRES)
    mob:delMod(tpz.mod.EARTHRES)
    mob:delMod(tpz.mod.THUNDERRES)
    mob:delMod(tpz.mod.WATERRES)
    mob:delMod(tpz.mod.LIGHTRES)
    mob:delMod(tpz.mod.DARKRES)
    mob:delMod(tpz.mod.PARALYZERESTRAIT)
    mob:delMod(tpz.mod.BLINDRESTRAIT)
    mob:delMod(tpz.mod.SILENCERESTRAIT)
    mob:delMod(tpz.mod.VIRUSRESTRAIT)
    mob:delMod(tpz.mod.PETRIFYRESTRAIT)
    mob:delMod(tpz.mod.BINDRESTRAIT)
    mob:delMod(tpz.mod.CURSERESTRAIT)
    mob:delMod(tpz.mod.GRAVITYRESTRAIT)
    mob:delMod(tpz.mod.SLOWRESTRAIT)
    mob:delMod(tpz.mod.STUNRESTRAIT)
    mob:delMod(tpz.mod.CHARMRESTRAIT)
    mob:delMod(tpz.mod.AMNESIARESTRAIT)
    mob:delMod(tpz.mod.DEATHRESTRAIT)
end