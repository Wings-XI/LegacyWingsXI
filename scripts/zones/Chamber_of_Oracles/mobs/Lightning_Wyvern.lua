-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Lightning Wyvern
-- KSNM: Eye of the Storm
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 17)
	mob:setMod(tpz.mod.SLEEPRES, 256) -- Will not sleep without Elemental Seal per wiki.
	mob:addMod(tpz.mod.MAIN_DMG_RATING, 80) -- Increased base damage slightly per player feedback and sources saying mobs hit pretty hard.
end

function onMobEngaged(mob, target)
    mob:useMobAbility(815)
    mob:setMod(tpz.mod.REGAIN, 100)
end

function onMobFight(mob, target)

end

function onMobDeath(mob, player, isKiller)
end

