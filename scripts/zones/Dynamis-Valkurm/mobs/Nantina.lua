-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Nant'ina
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
    -- Set Mods
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

function onMobWeaponSkillPrepare(mob, target)
    local charmchance = math.random(1, 100)

    if charmchance <= 10 then
        return 1619 -- Attractant
    else
        if mob:getHPP() > 25 then
            return 1617
        else
            return 1618
        end
    end
end