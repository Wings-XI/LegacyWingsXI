-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Goublefaupe
-- Note: Attestation Mini-Boss
-----------------------------------

-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 134

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil)
    dynamis.setNMStats(mob)
    
    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = 95},
        },
    })
end

function onMobWeaponSkillPrepare(mob, target)
	local charm = 710
	if math.random() < 0.2 then
		return charm
	else
		return 0
	end
end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end