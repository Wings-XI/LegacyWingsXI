-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Judgmental Julika
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setDamage(150) -- hits for ~300 on a nin, crits of 450+
end

function onMobWeaponSkillPrepare(mob, target)
    return 319 -- only uses bad breath
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 75, power = math.random(15,39)}) -- high chance (not 100) low power drain
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 490)
end