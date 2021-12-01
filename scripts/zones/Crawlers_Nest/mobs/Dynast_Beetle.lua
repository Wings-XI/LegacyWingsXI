-----------------------------------
-- Area: Crawlers' Nest (197)
--   NM: Dynast Beetle
-----------------------------------
require("scripts/globals/hunts")

function onMobWeaponSkill(target, mob, skill)
    -- Uses Rhino Guard followed by Rhino Attack frequently.
    local skillId = skill:getID()

    if skillId == 341 then
        mob:useMobAbility(340)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 237)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
