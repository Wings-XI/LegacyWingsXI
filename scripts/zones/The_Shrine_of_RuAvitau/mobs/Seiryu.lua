-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
	mob:setMod(tpz.mod.REGAIN, 150)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENAERO)
end

function onMobFight(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false then
        mob:SetMobAbilityEnabled(true);
    else
        mob:SetMobAbilityEnabled(false);
    end
end

function onMonsterMagicPrepare(mob, target)
    if mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false then
        local rnd = math.random()
        if (rnd < 0.5) then
            return 186 -- aeroga 3
        elseif (rnd < 0.7) then
            return 157 -- aero 4
        elseif (rnd < 0.9) then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end
    return 0 -- Still need a return, so use 0 when not casting
end

function onMobDeath(mob, player, isKiller)
end
