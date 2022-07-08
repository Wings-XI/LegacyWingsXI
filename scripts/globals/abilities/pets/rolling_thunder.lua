---------------------------------------------
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/summon")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local mpCost = 52
    local bonus = getSummoningSkillOverCap(pet)
    if bonus > 90 then
        bonus = 90
    end
    
    local smnlvl = 1
    if pet:getMaster() ~= nil then
        if (pet:getMaster()):getMainJob() == tpz.job.SMN then
            smnlvl = (pet:getMaster()):getMainLvl()
        elseif (pet:getMaster()):getSubJob() == tpz.job.SMN then
            smnlvl = (pet:getMaster()):getSubLvl()
        end
    end

    local magicskill = utils.getSkillLvl(1, math.min(smnlvl,target:getMainLvl()))

    local potency = 3 + ((6*magicskill)/100)
    if (magicskill>200) then
        potency = 5 + ((5*magicskill)/100)
    end

    local typeEffect = tpz.effect.ENTHUNDER

    skill:setMsg(MobBuffMove(target, typeEffect, potency, 0, 60+bonus))
    
    pet:getMaster():addMP(-mpCost)
    return typeEffect
end
