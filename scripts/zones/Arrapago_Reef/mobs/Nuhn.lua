-----------------------------------
--   Area: Arrapago Reef
--    Mob: T3 ZNM - Nuhn
-- Author: Spaceballs / Chiefy
-----------------------------------

mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}


-- Full disclosure, there JP wiki and NA wiki does mention there being 2 phaes to the fight but I could find 0 video evidence.
-- I have taken some "artistic liberties", in all the videos I saw Nuhn only spammed Dnash/Deathgnash - so I assumed that maybe 1%
-- of the time, he will use Hypnic Lamp instead and go into the other phase. I gave him a 10% chance on WS to return to phase 1.
-- verify
-- can use hypnic lamp, aoe "gaze" sleep, seaspray (slow 2), vile belth (silence/plague), leeching current, gnash, deathgnash, seismic tail
--Susceptible to Slow II, Gravity, Poison, Paralyze, Lullaby, and Repose. Bind and Elegy


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.ATK, 1500)
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("Phase", 1)                       
end   

function onMobWeaponSkillPrepare(mob)
    local phase = mob:getLocalVar("phase")
    local chance = math.random(1,100)
    local hpp = mob:getHPP()
    if phase == 1 then
        if chance == 1 -- very small chance to use hypnic lamp
            return 2222 -- hypnic lamp
        else
            if hpp >=50 then
                return 1111 -- Deathgnash
            else
                return 0000 -- Gnash
            end
        end
    else
        if chance > 90
            return 3333 --seismic tail
        end
    end
end


function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2222 then -- hypnic lamp
        mob:setLocalVar("phase", 2)
        mob:setMod(tpz.mod.REGAIN, 1000)
    end

    if skill:getID() == 3333 then -- seismic tail
        mob:setLocalVar("phase", 1)
        mob:setMod(tpz.mod.REGAIN, 0)
    end
end