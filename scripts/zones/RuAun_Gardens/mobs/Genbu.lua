-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Genbu
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(tpz.mod.COUNTER, 25)
end

function onMobSpawn(mob)
    GetNPCByID(ID.npc.GENBU_PORTAL):setAnimation(tpz.animation.CLOSE_DOOR)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER)
end

function onMobDeath(mob, player, isKiller)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 6)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.GENBU_PORTAL):setAnimation(tpz.animation.OPEN_DOOR)
end
