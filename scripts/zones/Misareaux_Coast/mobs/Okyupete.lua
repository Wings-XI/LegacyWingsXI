------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 500)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 400 then
        mob:useMobAbility(401)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 446)
end
