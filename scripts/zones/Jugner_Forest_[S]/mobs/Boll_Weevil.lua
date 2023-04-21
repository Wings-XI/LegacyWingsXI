-----------------------------------
-- Area: Jugner_Forest_[S]
--   NM: Boll Weevil
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 33)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.BLIND)
end

function onMobEngaged(mob)
    mob:setMod(tpz.mod.REGAIN, 500)
end

function onMobRoam(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setTP(0)
end

function onMobWeaponSkillPrepare(mob, target)
    if math.random(2) == 1 then
        return 340
    end
end
function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 483)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end
