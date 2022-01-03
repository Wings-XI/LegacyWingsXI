-----------------------------------------
-- ID: 11290
-- Item: tidal talisman
--
-----------------------------------------

function tidalGetDestZone(target)
    local destZone = 0
    local zone = target:getZoneID()

    if (zone == 241 or zone == 242 or zone == 240 or zone == 239 or zone == 238) then -- Item is used in Windurst
        destZone = 243 -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 237 or zone == 236 or zone == 235 or zone == 234) then -- Item is used in Bastok
        destZone = 243 -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 233 or zone == 232 or zone == 231 or zone == 230) then -- Item is used in San d'Oria
        destZone = 243 -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 243 or zone == 245 or zone == 244 or zone == 246) then -- Item is used in Jeuno
        if target:hasKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM) then
            destZone = 250 -- player/s end up in Kazham
        end
    elseif (zone == 250) then -- Item is used in Kazham
        destZone = 243 -- Player/s will end up at Ru'Lude Gardens
    elseif (zone == 248) then -- Item is used in Selbina
        destZone = 249 -- player/s end up at Mhaura
    elseif (zone == 249) then -- Item is used in Mhaura
        destZone = 248 -- player/s end up in Selbina
    elseif (zone == 50) then -- Item is used in Aht Urhgan Whitegate
        destZone = 53 -- player/s end up in Nashmau
    elseif (zone == 53) then -- Item is used in Nashmu
        destZone = 50 -- player/s ends up at Aht Urahgan Whitegate
    end
    
    return destZone

end
    
function onItemCheck(target)
    local result = 56
    local destZone = tidalGetDestZone(target)
    
    if destZone ~= 0 and target:isZoneVisited(destZone) then
        result = 0
    end

    return result
end

function onItemUse(target)
    local zone = target:getZoneID()
    local destZone = tidalGetDestZone(target)

    if (target:checkDistance(target:getXPos(), target:getYPos(), target:getZPos()) <= 5) and not target:isInMogHouse() then -- I am within 5 yalms, teleport me.
        if destZone == 0 or target:isZoneVisited(destZone) == false then
            return
        end

        if (zone == 241 or zone == 242 or zone == 240 or zone == 239 or zone == 238) then -- Item is used in Windurst
            target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
        elseif (zone == 237 or zone == 236 or zone == 235 or zone == 234) then -- Item is used in Bastok
            target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
        elseif (zone == 233 or zone == 232 or zone == 231 or zone == 230) then -- Item is used in San d'Oria
            target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
        elseif (zone == 243 or zone == 245 or zone == 244 or zone == 246) then -- Item is used in Jeuno
            if target:hasKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM) then
                target:setPos(-33, -8, -71, 97, 250) -- player/s end up in Kazham
            end
        elseif (zone == 250) then -- Item is used in Kazham
            target:setPos(0, 3, 2, 64, 243) -- Player/s will end up at Ru'Lude Gardens
        elseif (zone == 248) then -- Item is used in Selbina
            target:setPos(0, -8, 59, 62, 249) -- player/s end up at Mhaura
        elseif (zone == 249) then -- Item is used in Mhaura
            target:setPos(18, -14, 79, 62, 248) -- player/s end up in Selbina
        elseif (zone == 50) then -- Item is used in Aht Urhgan Whitegate
            target:setPos(12, -6, 31, 63, 53) -- player/s end up in Nashmau
        elseif (zone == 53) then -- Item is used in Nashmu
            target:setPos(-73, 0, 0, 252, 50) -- player/s ends up at Aht Urahgan Whitegate
        end
    else
        return -- Do not teleport me, I am too far away.
    end
end
