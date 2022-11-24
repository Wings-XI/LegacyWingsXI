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


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setLocalVar("[rage]timer", 5400) -- 90 minutes
end

function onMobSpawn(mob)
    mob:setLocalVar("WarmUp", 0)
    mob:setLocalVar("Manafont", 0)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)     
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = math.random(66, 95)},
            {id = tpz.jsa.BENEDICTION, hpp = 0},
        },
    })
    mob:setSpellList(296) -- Set BLM spell list
end

function onMobFight(mob, target)
    local manafont = mob:getLocalVar("Manafont")
    if mob:AnimationSub() == 1 and mob:getLocalVar("jobChanged") == 0 then
        mob:setLocalVar("jobChanged", 1)
        mob:setSpellList(297) -- Set WHM spell list.
        -- set new JSA parameters
        tpz.mix.jobSpecial.config(mob, {
            specials =
            {
                {id = tpz.jsa.MANAFONT, hpp = 0},
                {id = tpz.jsa.BENEDICTION, hpp = math.random(25, 50)},
            },
        })
    end

    if mob:hasStatusEffect(tpz.effect.MANAFONT) == 1 and manafont = 0 then
        mob:setMobMod(tpz.mobMod.MAGIC_COOL, 5)
        mob:setLocalVar("Manafont", 1)
    elseif mob:hasStatusEffect(tpz.effect.MANAFONT) == 0 and manafont = 1 then
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

function onMobWeaponSkillPrepare(mob)
    local warmup = mob:getLocalVar("WarmUp")
-- if we used warm up already, groundburst it
    if warmup == 1
        return 0000 -- ASCAR Groundburst
        mob:setLocalVar("WarmUp", 0)
    end
-- If it tries to use groundburst before warmup, use warmup instead
    if skill:getID() == 0000 and warmup == 0 then -- ASCAR GoundBurst
        return 1111 -- ASCAR Warmup
    end
end

function onMobDeath(mob, killer)
end
