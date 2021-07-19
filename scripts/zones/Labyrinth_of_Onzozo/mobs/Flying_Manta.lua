-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Flying Manta
-- Note: PH for Lord of Onzozo and Peg Powler
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
mixins =
{
    require("scripts/mixins/rage")
}
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    if mob:getID() == 17649730 then
        mob:setLocalVar("[rage]timer", 600) -- 10 minutes
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 774, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.LORD_OF_ONZOZO_PH, 4, 57600) -- 16 hours minimum lottery
    tpz.mob.phOnDespawn(mob, ID.mob.PEG_POWLER_PH, 4, 7200) -- 2 hours minimum lottery
end
