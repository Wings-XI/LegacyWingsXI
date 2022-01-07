------------------------------
-- Area: Caedarva Mire
--   NM: Vidhuwa the Wrathborn
--   http://wiki.ffo.jp/html/18805.html
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/magic")
------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.RESBUILD_STUN, 5)
    -- Enhanced Movement Speed
    mob:setMod(tpz.mod.MOVE, 25)
    -- takes ~3s to cast AOE flood
    mob:setMod(tpz.mod.UFASTCAST, 75)
    -- said to spam tp moves/barrage of tp moves
    mob:setMod(tpz.mod.REGAIN, 100)
    -- this NM casts an AOE flood in 3s, every ~20 seconds
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)

    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 65, power = 40})
end

function onMobSpawn(mob)
    -- if this NM's STANDBACK_COOL is not 0 - he will chain cast while people are out of melee range
    -- Hilarious - but prob too mean
    -- Note: STANDBACK_COOL is the amount of time to subtract from MAGIC_COOL (or SPECIAL_COOL) when the current target is more than 5 yalms away
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 0)
end

function onSpellPrecast(mob, spell)
    -- flood casted by Vidhuwa is AOE
    spell:setAoE(tpz.magic.aoe.RADIAL)
    spell:setRadius(10)
end

function onMobWeaponSkillPrepare(mob, target)
    -- only uses Immortal Shield and Mind Blast
    if ((mob:getMod(tpz.mod.RAMPART_STONESKIN) == 0) and (math.random(1,2) == 2)) then
        return 1965 -- Immortal Shield
    end

    return 1963 -- Mind Blast
end

function onMonsterMagicPrepare(mob, target)
    -- only casts flood
    return 214
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 471)
end
