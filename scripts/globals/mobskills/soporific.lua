---------------------------------------------
-- Dream Flower
-- 15' AoE sleep
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if mob:getID() == (16937576 or 16937577 or 16937578) then
        local effect = tpz.effect.SLEEP_I
        local resist = applyPlayerResistance(mob, nil, target, mob:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), 1, tpz.magic.ele.DARK)

        local duration = math.ceil(60 + math.floor(31*math.random()) * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target)) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90
        if resist >= 0.5 then
            target:delStatusEffectSilent(effect)
            target:delStatusEffectSilent(tpz.effect.LULLABY)
            target:delStatusEffectSilent(tpz.effect.SLEEP_I)
            target:delStatusEffectSilent(tpz.effect.POISON)
            local dotdmg = 50
            if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(effect, 1, 0, duration, 25, 25, 1) then -- subid/subpower for poison detection on wakup function
                target:addStatusEffect(tpz.effect.POISON, dotdmg, 3, duration, 0, 15, 2)
                skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            else
                skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
            end
        else
            skill:setMsg(tpz.msg.basic.SKILL_MISS)
        end

        return effect
    else
        local typeEffect = tpz.effect.SLEEP_I

        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))

        return typeEffect
    end
end
