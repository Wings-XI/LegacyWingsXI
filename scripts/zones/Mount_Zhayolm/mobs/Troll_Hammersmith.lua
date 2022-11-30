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
end
function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller)
end