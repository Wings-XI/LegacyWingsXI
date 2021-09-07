-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Flesh Eater
-- BCNM: The Worm's Turn
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()

    if rnd < 0.4
	then
    return 190 -- Stonega II
    elseif rnd < 0.7 then
        return 189 -- Stonega
    elseif rnd < 0.8 then
        return 238 -- Rasp
	elseif rnd < 0.9 then
        return 258 -- Bind
    else
        return 159 -- Stone
    end
end

function onMobDeath(mob, player, isKiller)
end
