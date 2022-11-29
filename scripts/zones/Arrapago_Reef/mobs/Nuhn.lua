-----------------------------------
--   Area: Arrapago Reef
--    Mob: T3 ZNM - Nuhn
-- Author: Spaceballs
-----------------------------------

mixins ={require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/status")



-- Full disclosure, there JP wiki and NA wiki does mention there being 2 phaes to the fight but I could find 0 video evidence.
-- I have taken some "artistic liberties", in all the videos I saw Nuhn only spammed Dnash/Deathgnash - so I assumed that maybe 1-5%
-- of the time, he will use Hypnic Lamp instead and go into the other phase.


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.ATT, 1500)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = -1},
            
        },
    })
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("Phase", 1)  
    mob:setLocalVar("Changed",0)                     
end   

function onMobFight(mob, target)
    if mob:getLocalVar("Changed") == 1 then
        if mob:getLocalVar("Phase") == 2 then  
            mob:setMod(tpz.mod.REGAIN, 1000)
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 5306)
        else
            mob:setTP(0)
            mob:delMod(tpz.mod.REGAIN, 1000)
            mob:setMobMod(tpz.mobMod.SKILL_LIST, 5305)
        end
        mob:setLocalVar("Changed", 0)
    end
end

function onMobWeaponSkill(target, mob, skill)
  
end

