-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Clone of Glaciers
-- ASA10 Battaru Royale
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.UDMGPHYS, -100)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
    mob:setMod(tpz.mod.UDMGRANGE, -100)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)

    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = math.random(40,70)},
        },
    })
end

function onMobEngaged(mob, target)
    local immunity = mob:getLocalVar("Immunity")

    if immunity == 1 then
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
    end
end

function onMobDeath(mob, player, isKiller)
end
