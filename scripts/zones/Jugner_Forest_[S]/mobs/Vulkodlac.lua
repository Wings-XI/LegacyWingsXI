------------------------------
-- Area: Jugner Forest [S]
--   NM: Vulkodlac
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/job_special")}
------------------------------


function onMobWeaponSkillPrepare(mob,player)
    local rnd = math.random()

    if rnd < 0.7 then
        return 2176 -- Asuran Claws
    else
        return 2175 -- Nox Blast
    end
end


function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 485)
end
