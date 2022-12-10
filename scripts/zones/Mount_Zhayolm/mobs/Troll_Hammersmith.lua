-----------------------------------
--   Area: Mount Zhayolm
--    Mob: Troll Hammersmith
-- Author: Spaceballs
--   Note: Pet of Khromasoul Bhurborlor
-----------------------------------


mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")

function onMobWeaponSkillPrepare(mob)
    if math.random() < .5 then
        return 2083
    end
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 500)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
end
function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end

function onMobRoam(mob)
    local ID = require("scripts/zones/Mount_Zhayolm/IDs")
    local mother = GetMobByID(ID.mob.KHROMASOUL_BHURBORLOR)
    if mother:isSpawned() and mother:getCurrentAction() == tpz.act.ENGAGED then
        mob:updateEnmity(mother:getTarget())
    end
end