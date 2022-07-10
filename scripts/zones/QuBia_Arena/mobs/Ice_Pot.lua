-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ice Pot
-- BCNM: E-vase-ive Action
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.MATT, 75)
    mob:setMod(tpz.mod.DEFP, 75)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
end

function onMobSpawn(mob)
    -- uses Chainspell multiple times
    tpz.mix.jobSpecial.config(mob, {
        chance = 100,
        specials =
        {
            { id = tpz.jsa.CHAINSPELL, cooldown = math.random(120, 150), hpp = math.random(85, 95) },
        },
    })
end

function onMobEngaged(mob, target)
    local mobId = mob:getID()

    -- despawn other pots
    local instance = mob:getBattlefield():getArea()
    local instanceOffset = ID.mob.E_VASE_IVE_ACTION_OFFSET + (7 * (instance - 1))

    for i = instanceOffset, instanceOffset + 5 do
        if mobId ~= i then
            DespawnMob(i)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    -- 10% chances to stun
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, { chance = 10, duration = math.random(2, 5) })
end

function onMobDeath(mob, player, isKiller)
end