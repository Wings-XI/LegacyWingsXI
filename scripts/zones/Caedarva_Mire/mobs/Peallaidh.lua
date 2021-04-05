-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
require("scripts/globals/hunts")
-- mixins = { require("scripts/mixins/behavior_spawn_chigoe") }
-- TODO: Spawn chigoes (need ids) and other karakul also need

-- function onMobSpawn(mob)
--     mob:setLocalVar("[chigoe]pool", x)
--     mob:setLocalVar("[chigoe]perAbility", 2)
-- end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 468)
end
