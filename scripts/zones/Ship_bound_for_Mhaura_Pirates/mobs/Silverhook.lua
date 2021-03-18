-----------------------------------
-- Area: Ship bound for Mhaura (Pirates)
--  Mob: Silverhook
-----------------------------------
local ID = require("scripts/zones/Ship_bound_for_Mhaura_Pirates/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.MDEF, 50)
end

function onMobDeath(mob, player)

end

function onMobDespawn(mob, player)
    GetMobByID(ID.mob.SHIP_WIGHT):setLocalVar("respawnTime", os.time() + 60)
    mob:setLocalVar("killed", 1)
end