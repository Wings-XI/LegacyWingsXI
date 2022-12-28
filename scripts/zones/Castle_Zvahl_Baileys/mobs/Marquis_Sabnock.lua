------------------------------
-- Area: Castle Zvahl Baileys
--   NM: Marquis Sabnock
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobWeaponSkillPrepare(mob, target)
    return 1149
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 352)
end
