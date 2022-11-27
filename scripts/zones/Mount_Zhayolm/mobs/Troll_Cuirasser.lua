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
function onMobSpawn(mob)
    mob:setLocalVar("clock", os.time() + math.random(10,30))
end

function onMobFight(mob, target)
    if os.time() >= mob:getLocalVar("clock") then
        mob:useMobAbility(709)
        mob:setLocalVar("clock", os.time() + math.random(65,85))
    end
end

--[[function onMobFight(mob, target)
    mob:getID()
    mob:useJobAbility(561, mob:getID()) --453 561 49
end]]

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end