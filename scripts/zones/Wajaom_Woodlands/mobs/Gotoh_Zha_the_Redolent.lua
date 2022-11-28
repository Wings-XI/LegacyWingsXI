-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: T3 ZNM - Gotoh Zha the Redolent
-- Author: Spaceballs / Chiefy (Edits from Topaz, real credit is theirs)
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/status")


-- 2-hour map
local JobTo2Hour = {
    [tpz.job.WHM] = tpz.jsa.BENEDICTION,
    [tpz.job.BLM] = tpz.jsa.MANAFONT
}



function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setLocalVar("[rage]timer", 5400) -- 90 minutes
    mob:setMod(tpz.mod.UFASTCAST, 50)
end

function onMobSpawn(mob)

    mob:setLocalVar("BreakChance", 5)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setMod(tpz.mod.FASTCAST, 25)
    mob:setLocalVar("BLM", math.random(66,80))
    mob:setLocalVar("BLMused", 0)
    mob:setLocalVar("WHM", math.random(1,50))
    mob:setLocalVar("WHMused", 0)
    mob:setLocalVar("[rage]timer", 5400) -- 90 minutes
    mob:setSpellList(296) -- Set BLM spell list
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = math.random(66, 95)},
            {id = tpz.jsa.BENEDICTION, hpp = 0},
        },
    })


end

function onMobFight(mob, target)
    if mob:AnimationSub() == 1 and mob:getLocalVar("jobChanged") == 0 then
        mob:setLocalVar("jobChanged", 1)
        mob:setSpellList(297) -- Set WHM spell list.
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MANAFONT, hpp = 0},
                {id = tpz.jsa.BENEDICTION, hpp = math.random(5, 50)},
            },
        })
    end

    if mob:hasStatusEffect(tpz.effect.MANAFONT) == 1 then
            mob:setMobMod(tpz.mobMod.MAGIC_COOL, 5)
        elseif mob:hasStatusEffect(tpz.effect.MANAFONT) == 0 then
            mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
        end
end

function onCriticalHit(mob)
    local RND = math.random(1, 100)
    if mob:AnimationSub() == 0 and RND <= 5 then
        mob:AnimationSub(1)
    end
end

function onWeaponskillHit(mob, attacker, weaponskill)
    local RND = math.random(1, 100)
    if mob:AnimationSub() == 0 and RND <= 5 then
        mob:AnimationSub(1)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1924 then
        mob:useMobAbility(1926)
    end
end



function onMobDeath(mob, killer)
end