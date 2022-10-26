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
    mob:speed(140)
    mob:SetAutoAttackEnabled(false)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setTP(0)
end


function onMobFight(mob)
    mob:setMod(tpz.mod.REGAIN, 1250)
end