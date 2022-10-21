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