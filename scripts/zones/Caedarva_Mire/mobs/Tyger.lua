-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Tyger
-- !pos -766 -12 632 79
-- Spawn with Singed Buffalo: !additembyid 2593
-- Wiki: https://ffxiclopedia.fandom.com/wiki/Tyger
-----------------------------------
require("scripts/globals/status")
-----------------------------------
--[[
    very simple, what are we missing?
    ]]
function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRES, 30)
    mob:setMod(tpz.mod.BINDRES, 30)
    mob:setMod(tpz.mod.GRAVITYRES, 30)
    -- ? mob:setMod(tpz.mod.ATT, 200)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobSkillFinished(mob, target, skill)
    if skill:getID() == 3267 then -- howl
        mob:useMobAbility(2024) -- Tourbillion
    end
end

function onMobDeath(mob, player, isKiller)
end