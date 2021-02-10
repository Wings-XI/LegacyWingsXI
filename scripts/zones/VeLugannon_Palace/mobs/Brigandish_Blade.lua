-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setUnkillable(true)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TERROR, {chance = 30})
end

function onMobFight(mob, target)
    if mob:getHP() < 50 then
        mob:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
        mob:addStatusEffect(tpz.effect.MAGIC_SHIELD, 0, 1, 0, 0)
    end
end

function onMobDeath(mob, player, isKiller)
    GetNPCByID(ID.npc.QM3):setLocalVar("PillarCharged", 1)
end
