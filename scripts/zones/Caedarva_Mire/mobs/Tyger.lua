-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Tyger
-- !pos -766 -12 632 79
-- Spawn with Singed Buffalo: !additem 2593
-----------------------------------
require("scripts/globals/status")
-----------------------------------
--[[Howls (visible animation) a few seconds before using Tourbillion
, making it easy to avoid damage by casting your shadows in time to absorb all three hits.]]

-- We can try using sara's howl animation to see if it works, its technically a TP move.
-- Eden has Khim howling, we don't, so we would have to dig around and find the animation for this if saras looks weird.
function onMobSpawn(mob)
    mob:addMod(tpz.mod.SLEEPRES, 30)
    mob:addMod(tpz.mod.BINDRES, 30)
    mob:addMod(tpz.mod.GRAVITYRES, 30)
    mob:addMod(tpz.mod.ATT, 200)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobSkillFinished(mob, target, skill)
    if skill:getID() == 4262 then -- howl
        mob:useMobAbility(2024) -- Torb
    end
end

function onMobDeath(mob, player, isKiller)
end