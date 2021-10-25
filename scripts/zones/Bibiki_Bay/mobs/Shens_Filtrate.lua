-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen's Filtrate - Shen Elemental
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGEN, 120)
end

function onMobDeath(mob, player, isKiller)
    SetServerVariable("[Shen]Filtrate Death", 1)
end