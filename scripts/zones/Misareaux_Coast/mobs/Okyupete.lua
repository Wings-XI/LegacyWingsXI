------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobFight(mob, player)
    mob:setMod(tpz.mod.REGAIN, (1000 - (8 * mob:getHPP())))
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 400 then
        mob:useMobAbility(401)
    end
end

function onMobDisengage(mob, player)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 446)
end
