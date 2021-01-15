---------------------------------------------------
-- Mewing Lullaby
-- aoe light based sleep and lowers mob TP to zero
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
    local bonus = pet:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR) - 10
    if pet:getMaster() ~= nil and (pet:getMaster()):isPC() then
        bonus = bonus + (pet:getMaster()):getMerit(1284) * 2 + getSummoningSkillOverCap(pet)
    end
    
    local resist = applyResistanceAbility(pet,target,7,tpz.skill.ENFEEBLING_MAGIC,bonus)
    local duration = 30 * resist
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.LULLABY, target))
    skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    
    if resist >= 0.5 then --Do it!
        if not (target:hasImmunity(1) or hasSleepEffects(target)) and target:addStatusEffect(tpz.effect.LULLABY, 1, 0, duration) then
            skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
            local resist2 = applyResistanceAbility(pet,target,7,tpz.skill.ENFEEBLING_MAGIC,bonus)
            if (resist2 >= 0.5 and (not target:isNM() or resist2 == 1.0)) then
                target:setTP(0)
            end
        end
    end
    
    return tpz.effect.SLEEP_I
end