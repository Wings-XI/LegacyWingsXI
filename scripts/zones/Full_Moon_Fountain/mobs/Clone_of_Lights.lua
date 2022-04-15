-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Clone of Lights
-- ASA10 Battaru Royale
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.LIGHTDEF, 200)
    mob:setMod(tpz.mod.REGEN, 500)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)

    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = math.random(40,70)},
        },
    })
end

function onMobEngaged(mob, target)
    local immunity = mob:getLocalVar("Immunity")

    if immunity == 1 then
        mob:setMod(tpz.mod.REGEN, 0)
    end
end

function onMobDeath(mob, player, isKiller)
end
