-----------------------------------
-- Area: Wajaom Woodlands
--   NM: Chelicerata
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/families/chigoe")}
-----------------------------------
-- https://ffxiclopedia.fandom.com/wiki/Chelicerata
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)

    -- Check triple attck etc.
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 449)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SLOW)
end