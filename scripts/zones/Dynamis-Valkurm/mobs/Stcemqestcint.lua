-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Stcemqestcint
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end


function onMobEngaged(mob, target)
    mob:setMod(tpz.mod.REGAIN, 500)
    mob:setTP(0)
end