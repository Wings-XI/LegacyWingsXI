-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Artilleryman
-- Author: Spaceballs / Chiefy
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------


mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
-- They will use the ranged attack Zarraqa frequently, which ignores shadows.

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end