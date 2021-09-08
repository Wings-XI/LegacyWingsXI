------------------------------
-- Area: Sauromugue Champaign
--   NM: Bashe
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 273)
end

function onMobWeaponSkillPrepare(mob, target)
    return 370 -- only uses Baleful Gaze
end
