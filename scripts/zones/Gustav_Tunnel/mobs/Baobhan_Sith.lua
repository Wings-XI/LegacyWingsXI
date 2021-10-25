-----------------------------------
-- Area: Gustav Tunnel
--   NM: Baobhan Sith
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    -- In the 2 YouTube videos available of this NM, he always dropped 12000 gil, wiki states "~12000 gil".
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 12000)
    -- "Immune to Silence, Stun, Dispel, Bind." - https://ffxiclopedia.fandom.com/wiki/Baobhan_Sith
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    mob:addMod(tpz.mod.DARKRES, 1000)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 1000) 
    mob:addMod(tpz.mod.SILENCERESTRAIT, 1000) 
    mob:addMod(tpz.mod.BINDRESTRAIT, 1000)
    mob:addMod(tpz.mod.STUNRESTRAIT, 1000)
    -- "Attacks possess Additional Effect: Terror."
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TERROR, {chance = 10})
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end 

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 425)
end
