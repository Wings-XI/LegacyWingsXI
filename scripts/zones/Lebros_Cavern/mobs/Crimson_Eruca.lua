-----------------------------------
-- Area: Lebros Cavern
--  Mob: Crimson Eruca
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    -- TODO: Handle resists
	-- mob:addResist({ tpz.resist.ENFEEBLING_LIGHTSLEEP, 25, 0 })
    -- mob:addResist({ tpz.resist.ENFEEBLING_DARKSLEEP, 25, 0 })
    -- mob:addResist({ tpz.resist.ENFEEBLING_GRAVITY, 25, 0 })
    -- mob:addResist({ tpz.resist.ENFEEBLING_BIND, 25, 0 })
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end