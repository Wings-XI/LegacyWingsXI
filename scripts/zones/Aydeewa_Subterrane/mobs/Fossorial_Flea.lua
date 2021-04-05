-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Fossorial Flea
-----------------------------------
mixins = {require("scripts/mixins/families/chigoe")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobDeath(mob, player, isKiller)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.DISEASE)
end