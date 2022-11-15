-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Cuirasser
-- Author: Spaceballs / Chiefy
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------


mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
-- DRK should use souleater
-- They will use the ranged attack Zarraqa frequently, which ignores shadows.

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end