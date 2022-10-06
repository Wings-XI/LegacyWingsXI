-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Jaded Jody
-----------------------------------
mixins = { require("scripts/mixins/families/ameretat"), }
require("scripts/globals/hunts")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 448)
end