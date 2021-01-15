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
    local dMND = pet:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    
    --Power
    -- Lowest ~7.3%
    -- Highest ~29.2%
    local power = utils.clamp(math.floor(dMND * 73 / 5) + 1825, 730, 2920)
    power = calculatePotency(power, tpz.skill.ENFEEBLING_MAGIC, pet, target)
    
    --Duration
    local duration = calculateDuration(90, tpz.skill.ENFEEBLING_MAGIC, 6, pet, target)
    
    local bonus = dMND
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,2,tpz.skill.ENFEEBLING_MAGIC,bonus)
    duration = duration * resist
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.SLOW, target))
    
    if resist >= 0.5 then --Do it!
        if target:addStatusEffect(tpz.effect.SLOW, power, 0, duration, 0, 1) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
        else
            skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        end
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    return tpz.effect.SLOW
end
