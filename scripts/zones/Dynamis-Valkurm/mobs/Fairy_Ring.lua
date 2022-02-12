-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Fairy Ring
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)

    -- Set Mods
    mob:setMod(tpz.mod.MOVE, 100)
    mob:addMod(tpz.mod.REGAIN, 1250)
    mob:SetAutoAttackEnabled(false)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end