---------------------------------------------------
-- Whispers of Ire
-- Delivers an area attack that drains 1-6 stats
-- TODO: Enable it to be used on self to remove debuffs
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local pool = mob:getPool()
    if -- Blighting Brand, Nightmare Weapons
        pool == 5730 or
        mob:getZone():getType() == tpz.zoneType.DYNAMIS
    then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    if -- Blighting Brand, remove all debuffs
        mob:getPool() == 5730 and
        math.random(2) == 1
    then
        local debuffCount = 0
        for _, effect in ipairs(mob:getStatusEffects()) do
            if
                bit.band(effect:getFlag(), tpz.effectFlag.WALTZABLE) == tpz.effectFlag.WALTZABLE or
                bit.band(effect:getFlag(), tpz.effectFlag.ERASABLE) == tpz.effectFlag.ERASABLE
            then
                debuffCount = debuffCount + 1
            end
        end
        if debuffCount > 0 then
            mob:delStatusEffectsByFlag(tpz.effectFlag.ERASABLE, false)
            mob:delStatusEffectsByFlag(tpz.effectFlag.WALTZABLE, false)
            skill:setMsg(tpz.msg.basic.NONE)
            return
        end
    end

    local effects =
    {
        tpz.effect.STR_DOWN,
        tpz.effect.DEX_DOWN,
        tpz.effect.VIT_DOWN,
        tpz.effect.AGI_DOWN,
        tpz.effect.INT_DOWN,
        tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN,
    }

    local drained = math.random(2, 6)

    for i=1, drained do
        local typeEffect = table.remove(effects, math.random(1, #effects))
        skill:setMsg(MobDrainAttribute(mob, target, typeEffect, 26, 3, 80))
    end

    return drained
end
