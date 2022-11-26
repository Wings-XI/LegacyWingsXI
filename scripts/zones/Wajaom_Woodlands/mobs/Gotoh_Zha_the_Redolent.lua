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
end

function onMobSpawn(mob)
    mob:setLocalVar("WarmUp", 0)
    --[[mob:setLocalVar("BreakChance", 5)]]
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:setLocalVar("BLM", math.random(66,80))
    mob:setLocalVar("BLMused", 0)
    mob:setLocalVar("WHM", math.random(1,50))
    mob:setLocalVar("WHMused", 0)
    mob:setLocalVar("[rage]timer", 5400) -- 90 minutes
    mob:setSpellList(296) -- Set BLM spell list
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = math.random(66, 95)},
            {id = tpz.jsa.BENEDICTION, hpp = 0},
        },
    })


end

function onMobFight(mob, target)
    now = os.time()
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
    if skill:getID() == 1924 then -- Warmup
        mob:setLocalVar("WarmUp", 1)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 5300 ) -- groundburst only skill list
    end

    if skill:getID() == 1926 then -- Groundburst
        mob:setLocalVar("WarmUp", 0)
        mob:setMobMod(tpz.mobMod.SKILL_LIST, 205) -- normal skill list
    end
end

function onMobDeath(mob, killer)
end