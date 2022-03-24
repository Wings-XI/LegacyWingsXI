-----------------------------------
-- Area: Ru'Aun Gardens
--   NM: Byakko
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
	mob:setMod(tpz.mod.TRIPLE_ATTACK, 40)
    GetNPCByID(ID.npc.BYAKKO_PORTAL):setAnimation(tpz.animation.CLOSE_DOOR)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENLIGHT)
end

function onMobDeath(mob, player, isKiller)
    player:showText(mob, ID.text.SKY_GOD_OFFSET + 12)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.BYAKKO_PORTAL):setAnimation(tpz.animation.OPEN_DOOR)
end