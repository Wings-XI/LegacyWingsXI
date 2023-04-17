-----------------------------------
-- Area: Horlais Peak
--  Mob: Gerjis
-- BCNM: Eye of the Tiger
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.EVA, 50)
end

function onMobFight(mob, target)
    local chance = 10
    if (math.random(100) < chance) then
        target:dispelStatusEffect()
    end
end

function onMobDeath(mob, player, isKiller)
end
