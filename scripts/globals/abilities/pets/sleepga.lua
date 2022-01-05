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

    if target:isUndead() and target:getFamily() ~= 52 and target:getFamily() ~= 121 then -- non-ghost undead
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return tpz.effect.SLEEP_I
    end

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    local bonus = pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,5,tpz.skill.ENFEEBLING_MAGIC,bonus)
    
    local duration = math.ceil(60 * resist * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target))
    if resist >= 0.5 then --Do it!
        if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, duration) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
    
    return tpz.effect.SLEEP_I
end
