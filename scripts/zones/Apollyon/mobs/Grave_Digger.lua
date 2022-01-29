-----------------------------------
-- Area: Apollyon SE
--  Mob: Grave Digger
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.H2HRES, 1500)
    mob:setMod(tpz.mod.IMPACTRES, 1500)
    mob:setMod(tpz.mod.PIERCERES, 0)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller, noKiller)

    local battlefield = mob:getBattlefield()

    if isKiller or noKiller then
        tpz.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_SE_PORTAL[3])
    end
end