---------------------------------------------------
-- Eerie Eye
-- silence + amnesia
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")
require("scripts/globals/msg")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local returnEffect = tpz.effect.NONE
    local duration = 30
    local mpCost = 134
    local ele = tpz.magic.ele.LIGHT
    local bonus = pet:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR) - 10
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,ele,tpz.skill.ENFEEBLING_MAGIC,bonus)
    
    -- https://wikiwiki.jp/ffxi/%E5%8F%AC%E5%96%9A%E9%AD%94%E6%B3%95
    -- TL;DR 30s silence and 10s amnesia and amnesia is fire element
    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(tpz.effect.SILENCE, 1, 0, duration * resist) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            local resist2 = applyResistanceAbility(pet,target,tpz.magic.ele.FIRE,tpz.skill.ENFEEBLING_MAGIC,bonus)
            -- WINGSCUSTOM require 2 successful resistance checks (and actual application of SILENCE)
            if resist * resist2 >= 1 and target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, duration * resist2 / 3) then
                returnEffect = tpz.effect.AMNESIA
            else
                returnEffect = tpz.effect.SILENCE
            end
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    pet:getMaster():addMP(-mpCost)
    return returnEffect
end