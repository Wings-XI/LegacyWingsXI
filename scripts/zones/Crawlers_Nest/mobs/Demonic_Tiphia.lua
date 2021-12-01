-----------------------------------
-- Area: Crawlers' Nest (197)
--  Mob: Demonic Tiphia
-----------------------------------
require("scripts/globals/hunts")

function onMobSpawn(mob)
    mob:setMod(tpz.mod.RESBUILD_SILENCE, 10)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 10)
end

function onMobFight(mob)
    local delay = mob:getLocalVar("delay")
    if delay > 25 and mob:actionQueueEmpty() == true and mob:getHPP() <= 50 then -- Uses Cure V repeatedly on cooldown below 50% health
        mob:castSpell(5) -- Cure V
        mob:setLocalVar("delay", 0)
    else
        mob:setLocalVar("delay", delay+1)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 236)
end
