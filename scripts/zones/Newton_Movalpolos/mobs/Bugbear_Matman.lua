------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGAIN, 50)
end

function onMobWeaponSkillPrepare(mob, target)
	local rnd = math.random()

	if mob:getHPP() <= 30 and rnd > 0.4 then
	    return 358
	end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 248)
end
