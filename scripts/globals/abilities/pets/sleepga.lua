-----------------------------------------
-- Sleepga
-----------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/summon")
-----------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local bonus = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,5,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = 60 * resist
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.SLEEP, target))
    
    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        resist = 1/16
    end
    
    if resist >= 0.5 then --Do it!
        if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.JA_MISS_2)
    end
    
    return tpz.effect.SLEEP_I
end
