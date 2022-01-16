-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Shredded Samson
-- BCNM: Celery
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.SLASHRES, 1500)
    mob:setMod(tpz.mod.H2HRES, 200)
    mob:setMod(tpz.mod.IMPACTRES, 200)
end

function onMobWeaponSkillPrepare(mob, target)

	return 1339

end

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    DespawnMob(mobId - 1)
    DespawnMob(mobId + 1)
    DespawnMob(mobId + 2)
end


function onMobDeath(mob, player, isKiller)
    mob:getBattlefield():win()
end
