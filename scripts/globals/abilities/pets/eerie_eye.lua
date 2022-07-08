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
    local mpCost = 134
    local bonus = pet:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR) - 10
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,7,tpz.skill.ENFEEBLING_MAGIC,bonus)
    
    if resist >= 0.5 and math.random() < 0.9 then --Do it!
        if target:addStatusEffect(tpz.effect.SILENCE, 1, 0, 30) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            if resist == 1 and math.random() < 0.8 and target:addStatusEffect(tpz.effect.AMNESIA, 1, 0, 30) then
                return tpz.effect.AMNESIA
            else
                return tpz.effect.SILENCE
            end
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    pet:getMaster():addMP(-mpCost)
    return tpz.effect.SILENCE
end