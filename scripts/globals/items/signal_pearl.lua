-----------------------------------------
-- ID: 14810
-- Item: Signal Pearl
-- Calls forth an adventuring fellow
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if target:getFellow() ~= nil or target:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        or target:hasStatusEffect(tpz.effect.LEVEL_SYNC) or
        AdventuringFellow_Enabled == nil or AdventuringFellow_Enabled == 0 then
            return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if not target:canUseMisc(tpz.zoneMisc.FELLOW) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    
    local wotg_unlock = target:getFellowValue("wotg_unlock")
    
    if (target:getContinentID()==3 and wotg_unlock == 0) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    target:spawnFellow(target:getFellowValue("fellowid"))
    target:setFellowValue("bond", target:getFellowValue("bond")+1)
end