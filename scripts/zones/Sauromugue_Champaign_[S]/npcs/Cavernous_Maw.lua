-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Cavernous Maw
-- !pos 369 8 -227 98
-- Teleports Players to Sauromugue_Champaign
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign_[S]/IDs")
require("scripts/globals/maws")
require("scripts/globals/teleports")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- if the player has this maw teleport already, has an adventuring fellow, but does not have wotg adventuring fellow access, time to get it
    local hasMaw = player:hasTeleport(tpz.teleport.type.PAST_MAW, 2)
    local bond = player:getFellowValue("bond")
    local wotg_unlock = player:getFellowValue("wotg_unlock")
   
    if (hasMaw == true and bond ~= nil and wotg_unlock~=nil and wotg_unlock ~= 1) then
        local styleParam    = getStyleParam(player)
        local lookParam     = getLookParam(player)
        local fellowParam   = getFellowParam(player)

        player:startEvent(265, 0, 0, 0, 0, 0, styleParam, lookParam, fellowParam)
    else
        tpz.maws.onTrigger(player, npc)
    end
end

function onEventUpdate(player, csid, option)
    -- player:PrintToPlayer(string.format( "onEventUpdate csid %s option %s", csid, option ))
    if (csid == 265) then
        local styleParam    = getStyleParam(player)
        local lookParam     = getLookParam(player)
        local fellowParam   = getFellowParam(player)

        -- ToDo: get actual look to display, not some rando galka
        player:updateEvent(0, 0, 0, 0, 0, styleParam, lookParam, fellowParam)
    end
end

function onEventFinish(player, csid, option)
    player:PrintToPlayer(string.format( "onEventFinish csid %s option %s", csid, option ))
    if (csid == 265) then
        player:messageSpecial(ID.text.CAN_SUMMON_FELLOW_WOTG)
        player:setFellowValue("wotg_unlock", 1)
        local mawDestination = { 366.858,   8.545, -228.861,  95, 120}
        player:timer(500, function(player) player:setPos(unpack(mawDestination)) end)
    else
        tpz.maws.onEventFinish(player, csid, option)
    end
    
end
