-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local pet = player:getPet()
    if not pet then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif not player:isJugPet() and pet:getObjType() ~= tpz.objType.MOB then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    elseif pet:getLocalVar("ReceivedFamiliar") == 1 then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    local pet = player:getPet()
	pet:setLocalVar("ReceivedFamiliar", 1)
    local seconds = math.random(1600,1800)
    
    -- pets powers increase!
    ability:setMsg(tpz.msg.basic.FAMILIAR_PC)
    
    pet:setLocalVar("familiar",1)
    pet:addMod(tpz.mod.ATTP, 15)
    pet:addMod(tpz.mod.ACC, 20)
    pet:addMod(tpz.mod.EVA, 10)
    pet:addMod(tpz.mod.DEFP, 10)
    pet:addMod(tpz.mod.HPP, 10)
    pet:addCharmTime(seconds) -- internal check here, if its a called pet it will do nothing
    
    
    pet:addListener("DESPAWN", "FAMILIAR_DESPAWN", function(mob, target)
        pet:setLocalVar("familiar",0)
    end)
    
    pet:queue(seconds*1000, function(pet)
        if pet:getLocalVar("familiar") == 1 then
            pet:setLocalVar("familiar",0)
            pet:delMod(tpz.mod.ATTP, 15)
            pet:delMod(tpz.mod.ACC, 20)
            pet:delMod(tpz.mod.EVA, 10)
            pet:delMod(tpz.mod.DEFP, 10)
            pet:delMod(tpz.mod.HPP, 10)
        end
    end)

    return 0
end
