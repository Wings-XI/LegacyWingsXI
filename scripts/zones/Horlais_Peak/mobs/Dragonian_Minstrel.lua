-----------------------------------
-- Area: Horlais Peak
--  Mob: Dragonian Minstrel
-- KSNM30
-- TODO: Chaos Blade effect gets stronger after they use their respective 2-hour.
--       50% HP/MP reduction pre-2 hour and 75% HP/MP reduction post-2 hour.
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.SOUL_VOICE,
                endCode = function(mob)
                    mob:addMod(tpz.mod.ATT, 200)
                end,
            },
        },
    })
end

function onMobDeath(mob, player, isKiller)
end

function onMobWeaponSkillPrepare(mob, target)
    if (mob:hasStatusEffect(tpz.effect.SILENCE) == true) then
        return 647 -- Chaos Blade
    end
    
    local random = math.random(1 , 4)
    if (random == 1) then
        return 647 -- Chaos Blade
    elseif (random == 2) then
        return 651 -- Lodesong
    elseif (random == 3) then
        return 650 -- Thornsong
    else
        return 649 -- Voidsong
    end
end