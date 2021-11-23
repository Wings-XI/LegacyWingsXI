-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Lycopodium
-----------------------------------
mixins = {require("scripts/mixins/families/lycopodium")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
end

function onMobDeath(mob, player, isKiller)
end