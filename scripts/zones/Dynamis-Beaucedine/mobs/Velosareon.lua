-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Velosareon
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
    mob:setMaxHPP(325)

    params.specials = { }
    params.specials.skill = { }
    params.specials.skill.id = familyEES[mob:getFamily()]
    params.specials.skill.hpp = 95

    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, hpp = 95},
            {id = tpz.jsa.MEIKYO_SHISUI, hpp = 95},
            {id = familyEES[mob:getFamily()], hpp = 75},
        },
    })

end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)
end