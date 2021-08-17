-----------------------------------
-- Area: Misareaux Coast
--  Mob: Boggelmann
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 15)
    mob:setMod(tpz.mod.RESBUILD_BIND, 15)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        chance = 50, -- does not always use 2hr
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, hpp = 25},
        },
    })
    mob:addMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 70) -- highly resistant to sleep but not immune
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Boggelmann_KILL") == 0) then
        player:setCharVar("COP_Boggelmann_KILL", 1)
    end
end
