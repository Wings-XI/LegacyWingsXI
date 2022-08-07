-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Lividroot Amooshah
-- https://ffxiclopedia.fandom.com/wiki/Lividroot_Amooshah
-- https://wikiwiki.jp/ffxi/NM/%E8%8A%B1%E9%B3%A5%E9%A2%A8%E6%9C%88/%E3%83%9E%E3%83%A0%E3%83%BC%E3%82%B8%E3%83%A3%E8%95%83%E5%9B%BD%E8%BB%8D
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

local function phaseChange(mob)
    -- shouldn't happen, but let's make sure we do not exceed phase 4
    local phase = mob:getLocalVar("phase") + 1
    mob:setLocalVar("phase", phase)

    -- disable and disappear for a second
    mob:setStatus(tpz.status.INVISIBLE)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)

    mob:timer(1000, function(mob)
        mob:setStatus(tpz.status.UPDATE)
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
    end)

    -- fill hp and gets a buff every phase changes
    mob:setHP(mob:getMaxHP())
    mob:addMod(tpz.mod.DMGPHYS, -10)
    mob:addMod(tpz.mod.MEVA, 25)

    if phase > 3 then
        -- final phase
        mob:setUnkillable(false)
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)

    -- immune to sleep and high res to slow/elegy
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.SLOWRES, 80)

    -- slowly builds resistance to gravity and bind
    mob:setMod(tpz.mod.RESBUILD_BIND, 15)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 15)

    -- has regain and endrain
    mob:setMod(tpz.mod.REGAIN, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 4500)
    mob:setLocalVar("phase", 1)
    mob:setLocalVar("phaseChange", 0)
    mob:setUnkillable(true)
end

function onMobFight(mob, target)
    if mob:getHP() == 1 and mob:getLocalVar("phase") < 4 and mob:getLocalVar("phaseChange") == 0 then
        -- trigger the phase change
        mob:setLocalVar("phaseChange", 1)
        mob:setTP(3000)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getLocalVar("phaseChange") > 0 then
        return 317
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, { chance = 75, power = math.random(24, 49) })
end

function onMobWeaponSkill(target, mob, skill)
    if mob:getLocalVar("phaseChange") == 1 and mob:getLocalVar("phase") < 4 and skill:getID() == 317 then
        -- phase changed was triggered
        mob:setLocalVar("phaseChange", 0)
        phaseChange(mob)
    end
end

function onMobDeath(mob, player, isKiller)
end