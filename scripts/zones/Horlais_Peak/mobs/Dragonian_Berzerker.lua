-----------------------------------
-- Area: Horlais Peak
--  Mob: Dragonian Berzerker
-- KSNM30
-- TODO: Chaos Blade effect gets stronger after they use their respective 2-hour.
--       50% HP/MP reduction pre-2 hour and 75% HP/MP reduction post-2 hour.
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MIGHTY_STRIKES,
                endCode = function(mob)
                    mob:addMod(tpz.mod.ATT, 200)
                end,
            },
        },
    })
end

function onMobWeaponSkillPrepare(mob, target)
    local random = math.random(1,3)
    if (random == 1) then
        return 647 -- Chaos Blade
    elseif (random == 2) then
        return 645 -- Body Slam
    else
        return 646 -- Heavy Stomp
    end
end

function onMobDeath(mob, player, isKiller)
end
