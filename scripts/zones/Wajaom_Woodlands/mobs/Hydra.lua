-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
require("scripts/globals/titles")
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CLAIM_SHIELD, 1)
end

function onMobFight(mob, target)

    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()

    if (headgrow < battletime and broken > 4) then
        mob:AnimationSub(broken - 1)
        mob:setLocalVar("headgrow", battletime + 300)
    end

end

function onCriticalHit(mob)

    local rand = math.random()
    local battletime = mob:getBattleTime()
    local headgrow = mob:getLocalVar("headgrow")
    local headbreak = mob:getLocalVar("headbreak")
    local broken = mob:AnimationSub()

    if (rand <= 0.15 and battletime >= headbreak and broken < 6) then
        mob:AnimationSub(broken + 1)
        mob:setLocalVar("headgrow", battletime + math.random(120, 240))
        mob:setLocalVar("headbreak", battletime + 300)
    end

end

function onMobDeath(mob, player, isKiller)

    player:addTitle(tpz.title.HYDRA_HEADHUNTER)

end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
	local respawn = math.random(48,72)*3600 -- 48 to 72 hours in 60min windows
    mob:setRespawnTime(respawn)
	SetServerVariable("HydraRespawn",(os.time() + respawn))
end

