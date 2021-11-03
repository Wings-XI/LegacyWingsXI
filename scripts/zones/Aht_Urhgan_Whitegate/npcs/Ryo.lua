-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/znm")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.znm.ryo.onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.znm.ryo.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.znm.ryo.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.znm.ryo.onEventFinish(player, csid, option)
end
