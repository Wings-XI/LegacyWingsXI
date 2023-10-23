-----------------------------------
--
--  Artisan Moogles
--
-----------------------------------
require('scripts/globals/zone')
require('scripts/globals/status')
require('scripts/globals/settings')
-----------------------------------

tpz = tpz or {}
tpz.artisan = tpz.artisan or {}

local event = {
    [tpz.zone.BASTOK_MARKETS] = 544,
    [tpz.zone.WINDURST_WOODS] = 833,
    [tpz.zone.RULUDE_GARDENS] = 10162,
    [tpz.zone.SOUTHERN_SAN_DORIA] = 960
}
local menuFlags = {
    expand = 0x8,
    abags = 0x4,
    aexpand = 0x2,
}

tpz.artisan.moogleOnTrigger = function(player, npc)
    local zoneid = player:getZoneID()
    local csid = event[zoneid]
    local varname = string.format("[artisan]visited_%i", zoneid)
    local menuMask = 0
    local sackSize = player:getContainerSize(tpz.inv.MOGSACK)
    local mogVisited = (sackSize > 0 or player:getCharVar(varname) > 0) and 1 or 0
    if mogVisited == 0 then player:setCharVar(varname, 1) end
    if sackSize > 0 then
        sackSize = sackSize + 1
    else
        menuMask = menuFlags.expand + menuFlags.aexpand
    end
    player:startEvent(csid, 0, 0, 0, sackSize, 0, 0, menuMask, mogVisited)
end

tpz.artisan.moogleOnUpdate = function(player, csid, option)

    if option == 1 then -- Buy sack
        if player:getContainerSize(tpz.inv.MOGSACK) ~= 0 then
            -- Only one sack per adventurer
            local sackSize = player:getContainerSize(tpz.inv.MOGSACK)
            player:updateEvent((sackSize-30)/5, 0, 0, sackSize+1, 0, 0, 0, 1)
        elseif player:getGil() >= 9980 then
            player:delGil(9980)
            player:changeContainerSize(tpz.inv.MOGSACK, 30)
            player:setLocalVar("[artisan]newpurchase", 1)
            player:updateEvent(0, 0, 0, 30+1, 0, 0, 0, 2)
        end
        
    elseif option == 2 then -- Expand sack
        local sackSize = player:getContainerSize(tpz.inv.MOGSACK)
        local gobbieSize = player:getContainerSize(tpz.inv.INVENTORY)
        local gobbieCanUpgrade = gobbieSize < 80 and 1 or 0
        local newpurchase = player:getLocalVar("[artisan]newpurchase")
        if sackSize < gobbieSize and sackSize > 0 then
            player:changeContainerSize(tpz.inv.MOGSACK, gobbieSize - sackSize)
            if newpurchase == 0 then
                gobbieCanUpgrade = 2
            end
        end
        if newpurchase ~= 0 then
            if gobbieSize >= 80 then
                gobbieCanUpgrade = 0
            elseif gobbieSize > 30 then
                gobbieCanUpgrade = 2
            else
                gobbieCanUpgrade = 3
            end
        end
        player:updateEvent((gobbieSize-30)/5, 0, 0, player:getContainerSize(tpz.inv.MOGSACK)+1, 0, 0, gobbieCanUpgrade, 0)
        player:setLocalVar("[artisan]newpurchase", 0)

    elseif option == 3 then -- Client requests sack + scroll status
        local scrollAvail = 0
        if ARTISAN_MOOGLES_GIVE_SCROLLS == 1 then
            scrollAvail = player:getCharVar("[artisan]nextScroll") < JstMidnight() and 1 or 0
        end
        local sackSize = player:getContainerSize(tpz.inv.MOGSACK)
        if sackSize > 0 then sackSize = sackSize + 1 end
        player:updateEvent(0, 0, 0, sackSize, 0, 0, 0, scrollAvail)

    elseif option == 4 then -- Main dialogue
        local scrollAvail = 0
        if ARTISAN_MOOGLES_GIVE_SCROLLS == 1 then
            scrollAvail = player:getCharVar("[artisan]nextScroll") < JstMidnight() and 1 or 0
        end
        local sackSize = player:getContainerSize(tpz.inv.MOGSACK)
        if sackSize > 0 then sackSize = sackSize + 1 end
        player:updateEvent(0, 0, player:getGil(), sackSize, 0, 0, 0, scrollAvail)
    end
end

tpz.artisan.moogleOnFinish = function(player, csid, option)
    local zone = zones[player:getZoneID()]

    if option == 99 and ARTISAN_MOOGLES_GIVE_SCROLLS == 1 then -- Get Scroll
        if player:getCharVar("[artisan]nextScroll") < JstMidnight() then
            if player:addItem(4181) then
                player:messageSpecial(zone.text.ITEM_OBTAINED, 4181)
                player:setCharVar("[artisan]nextScroll", JstMidnight())
            else
                player:messageSpecial(zone.text.ITEM_CANNOT_BE_OBTAINED, 4181)
            end
        end

        if player:getCharVar("[NomadBon]Ticket") == 0 then
            local ticket = string.format("%u%u%u%u%u",
                math.random(1,9),
                math.random(0,9),
                math.random(0,9),
                math.random(0,9),
                math.random(0,9)
            )
            player:setCharVar("[NomadBon]Ticket", tonumber(ticket))
            player:setCharVar("[NomadBon]TimeStamp", os.time())
        end

        player:PrintToPlayer(string.format( "Your Mog Bonanza Kupon number is %u!", player:getCharVar("[NomadBon]Ticket" )))
    end
end