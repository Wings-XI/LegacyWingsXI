-----------------------------------
-- Area: Lower Jeuno
--  NPC: Taza
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4881,10304,
        4658,26244,
        4735,19200,
        4739,14080,
        4740,26244,
        4685,15120,
        4686, 9600,
        4699,15120,
        4700, 9600,
        4867,18720,
        4769,19932,
        4779,22682,
        4764,27744,
        4754,33306,
        4759,39368,
        4774,45930,
    }
    
    --[[
    Scroll of Sleepga 10,304 - 11,200 (ID:4881)
    Scroll of Shell III 26,244 (ID:4658)
    Scroll of Protectra III 19,200 (ID:4735)
    Scroll of Shellra II 14,080 (ID:4739)
    Scroll of Shellra III 26,244 (ID:4740)
    Scroll of Barpetrify 15,120 (ID:4685)
    Scroll of Barvirus 9,600 (ID:4686)
    Scroll of Barpetra 15,120 (ID:4699)
    Scroll of Barvira 9,600 (ID:4700)
    Scroll of Sleep II 18,720 (ID:4867)
    Scroll of Stone III 19,932 (ID:4769)
    Scroll of Water III 22,682 (ID:4779)
    Scroll of Aero III 27,744 (ID:4764)
    Scroll of Fire III 33,306 (ID:4754)
    Scroll of Blizzard III 39,368 (ID:4759)
    Scroll of Thunder III 45,930 (ID:4774)
    ]]

    player:showText(npc, ID.text.TAZA_SHOP_DIALOG)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
