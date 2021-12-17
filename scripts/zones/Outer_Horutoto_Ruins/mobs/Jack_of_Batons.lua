-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Batons
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("popTime", os.time())   
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobRoam(mob)
    if os.time() - mob:getLocalVar("popTime") > 120 then
        DespawnMob(mob:getID())
    end    
end

function onMobDeath(mob, player, isKiller)
    local coins = GetMobByID(ID.mob.JACK_OF_COINS)
    local cups = GetMobByID(ID.mob.JACK_OF_CUPS)
    local swords = GetMobByID(ID.mob.JACK_OF_SWORDS)

    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.FULL_MOON_FOUNTAIN and player:getCharVar("MissionStatus") == 1 then
        if not swords:isAlive() and not coins:isAlive() and not cups:isAlive() then
            player:setCharVar("MissionStatus", 2)
        end    
    end
end
