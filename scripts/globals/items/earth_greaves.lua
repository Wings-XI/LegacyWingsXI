-----------------------------------------
-- ID: 15708
-- Item: earth_greaves Earth Greaves
-- Item Effect: Grants Wyvren Stoneskin (200)  
-- Duration: Not stated on wiki
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if (target:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    else
        if (target:getPet():getStatusEffect(tpz.effect.STONESKIN) ~= nil or target:getPetID() ~= tpz.pet.id.WYVERN) then
            return tpz.msg.basic.ITEM_UNABLE_TO_USE
        else
            return 0, 0
        end
    end
end

function onItemUse(target)
    local wyvern = target:getPet()
    if (wyvern ~= nil) then
        wyvern:addStatusEffect(tpz.effect.STONESKIN, 200, 0, 180, 0, 0, 0)
    end
end

