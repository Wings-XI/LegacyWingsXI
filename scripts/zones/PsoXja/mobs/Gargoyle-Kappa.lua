-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle-Kappa
-----------------------------------

require("scripts/globals/status")
local ID = require("scripts/zones/PsoXja/IDs")

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRES, 30)
    mob:setMod(tpz.mod.GRAVITYRES, 30)
    mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 1, 0, 0)
end

function onMobFight(mob, target)
-- every 30sec will switch between magic resist and invincible
    local changeTime = mob:getLocalVar("switchTime")

    if mob:isAlive() and (mob:getBattleTime() - changeTime > 30) then
        if mob:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
            mob:delStatusEffectSilent(tpz.effect.PHYSICAL_SHIELD)
            mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 1, 0, 0)
            mob:useMobAbility(604)
        else
            mob:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
            mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 1, 0, 0)
            mob:useMobAbility(603)
        end
        mob:setLocalVar("switchTime", mob:getBattleTime())
    end
end

function onMobDeath(mob, player, isKiller)
    if GetMobByID(ID.mob.GARGOYLE_IOTA):isDead() and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED
    then
        player:setCharVar("Gargoyles_Killed", 1)
        GetNPCByID(16814499):setAnimation(8)
    end
end

function onMobDisengage(mob)
    DespawnMob(mob:getID(), 30)
end

function onMobEngaged(mob, target)
    if not GetMobByID(ID.mob.GARGOYLE_IOTA):isDead() then
    GetMobByID(ID.mob.GARGOYLE_IOTA):updateEnmity(target)
    end
end


function onMobDespawn(mob)
    GetNPCByID(16814499):setAnimation(8)
end
