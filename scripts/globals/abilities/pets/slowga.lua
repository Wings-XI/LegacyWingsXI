---------------------------------------------
-- Slowga
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
require("scripts/globals/magic")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 48
    local dMND = pet:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLOWRES) >= 100 then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return tpz.effect.SLOW
    end
    
    --Power
    -- Lowest ~7.3%
    -- Highest ~29.2%
    local power = utils.clamp(math.floor(dMND * 73 / 5) + 1825, 730, 2920)
    power = calculatePotency(power, tpz.skill.ENFEEBLING_MAGIC, pet, target)
    
    local bonus = dMND
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,2,tpz.skill.ENFEEBLING_MAGIC,bonus) * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target)
    
    local duration = math.ceil(calculateDuration(90, tpz.skill.ENFEEBLING_MAGIC, 6, pet, target) * resist)
    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(tpz.effect.SLOW, power, 0, duration, 0, 1) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return tpz.effect.SLOW
end
