---------------------------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")
require("scripts/globals/msg")
require("scripts/globals/magic")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local mpCost = 61
    local duration = 35
    local bonus = pet:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR) - 10
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + getSummoningSkillOverCap(pet)
    end

    local resist = applyResistanceAbility(pet,target,tpz.magic.element.LIGHT,tpz.skill.ENFEEBLING_MAGIC,bonus)
    skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)

    duration = math.ceil(duration * resist * tryBuildResistance(tpz.mod.RESBUILD_LULLABY, target))
    if resist >= 0.5 then --Do it!
        if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(tpz.effect.LULLABY, 1, 0, duration) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            -- WINGSCUSTOM require 2 successful resistance checks (and actual application of SLEEP)
            local resist2 = applyResistanceAbility(pet,target,tpz.magic.element.LIGHT,tpz.skill.ENFEEBLING_MAGIC,bonus)
            if resist * resist2 >= 1 and not target:isNM() then
                target:setTP(0)
            end
        end
    end
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.SLEEP_I
end