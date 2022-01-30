------------------------------
-- Area: Jugner Forest [S]
--   NM: Voirloup
------------------------------
-- note: the Gnole family mixin is NOT used for this mob - he should always stand
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
------------------------------

function onMobWeaponSkillPrepare(mob, target)
    -- per wiki only uses Nox Blast Kamehameha
    return 2175 -- Nox_Blast ID
end

function onMobInitialize(mob)
    -- per capture immune to Stun, Grav, Bind
    mob:setMod(tpz.mod.STUNRESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    -- per this link - sleep immune https://wikiwiki.jp/ffxi/Verup/091110/NM/%E3%82%A2%E3%83%AB%E3%82%BF%E3%83%8A%E3%82%A8%E3%83%AA%E3%82%A2#rc846534
    -- link also claims stun/grav/bind immune - but a high resist rate would present as immune and all other sources list as high res
    -- A capture would remove the ambiguity
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)

    -- per wiki additional effect stun
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    -- per wiki, double attack
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
end

function onMobSpawn(mob)
 -- with MA 120 - almost identically matches the swing speed on capture
    mob:setMod(tpz.mod.MARTIAL_ARTS, 120)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 486)
end
