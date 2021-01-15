-----------------------------------
-- Ability: Killer Instinct
-- Grants your pet's Killer effect to party members within area of effect. 
-- Also grants the associated Circle effect (handled within the effect itself)
-- Obtained: Beastmaster Level 75 (merit)
-- Recast Time: 15minutes
-- Duration: 1minute
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player,target,ability)
    local pet = player:getPet()
    if not pet then
        return tpz.msg.basic.REQUIRES_A_PET,0
    elseif not player:isJugPet() and pet:getObjType() ~= tpz.objType.MOB then
        return tpz.msg.basic.REQUIRES_A_PET,0
    end
    return 0,0
end

function onUseAbility(player,target,ability,action)
    local pet = player:getPet()
    local killerMod = 224
    local selectedMod = false
    
    while killerMod >= tpz.mod.VERMIN_KILLER and killerMod <= tpz.mod.LUMINION_KILLER and selectedMod == false do
        local check = pet:getMod(killerMod)
        if check > 0 then
            selectedMod = true
        else
            killerMod = killerMod + 1
        end
    end
    
    if killerMod <= tpz.mod.LUMINION_KILLER then
        if target:hasStatusEffect(tpz.effect.KILLER_INSTINCT) then
            target:delStatusEffect(tpz.effect.KILLER_INSTINCT)
        end
        target:addStatusEffect(tpz.effect.KILLER_INSTINCT,killerMod,0,60)
    end
    
    return 0
end
