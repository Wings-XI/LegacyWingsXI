-----------------------------------
-- Area: Fei'Yin
--   NM: Altedour I Tavnazia
--       WHM Quest "Pieuje's Decision"
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/utils")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:addMod(tpz.mod.DMGMAGIC,-70)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.MP_DRAIN)
end

function onMobFight(mob, target)
    local TP = (100 - mob:getHPP()) * 0.5
    if mob:getMod(tpz.mod.REGAIN) ~= utils.clamp(TP, 1, 100) then
        mob:setMod(tpz.mod.REGAIN, utils.clamp(TP, 1, 100))
    end
end

function onMobDeath(mob, player, isKiller)
end
