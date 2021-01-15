-----------------------------------------
-- ID: 
-- Item: Walahra Water
-- Item Effect: heals 5% mp and hp
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local heal = math.floor(target:getMaxHP()/20)
    local healmp = math.floor(target:getMaxMP()/20)
    local missing = target:getMaxHP() - target:getHP()
    local missingmp = target:getMaxMP() - target:getMP()
    
    if heal > missing then
        heal = missing
    end
    if healmp > missingmp then
        healmp = missingmp
    end
    
    target:addHP(heal)
    target:addMP(healmp)
    
    return
end
