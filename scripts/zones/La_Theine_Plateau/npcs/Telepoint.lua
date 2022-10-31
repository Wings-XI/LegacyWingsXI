-----------------------------------
-- Area: La Theine Plateau
--  NPC: Telepoint
-- !pos 420.000 19.104 20.000 102
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/anniversary")
-----------------------------------

function onTrade(player, npc, trade)
    -- trade any normal crystal for a faded crystal
    local item = trade:getItemId()
    if trade:getItemCount() == 1 and item >= 4096 and item <= 4103 and npcUtil.giveItem(player, 613) then
        player:tradeComplete()
    else
        local retval = anniversary.onTrade(player, npc, trade)
        if retval == 1 then
            anniversary.onTrigger(player, npc)
        elseif retval == 2 then
            anniversary.spawnNM(player, npc)
        end
    end
end

function onTrigger(player, npc)
    if player:getCharVar("AnnyEvent2020") == 5 and player:getCharVar("AnnyEvent2020_holla") == 0 and Anniversary_Event_2021 == 1 then
        if player:getFreeSlotsCount() > 0 then
            player:setCharVar("AnnyEvent2020_holla", 1)
            player:addItem(4240)
            player:PrintToPlayer("A piece of the telepoint crystal fragments off..", 0xD)
            player:messageSpecial((ID.text.ITEM_OBTAINED), 4240)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4240)
        end
    elseif not player:hasKeyItem(tpz.ki.HOLLA_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, tpz.ki.HOLLA_GATE_CRYSTAL)
    else
        local retval = anniversary.onTrigger(player, npc)
        if retval == 0 then
            player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
        elseif retval == 2 then
            anniversary.spawnNM(player, npc)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
