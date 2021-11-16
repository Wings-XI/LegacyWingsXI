-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/znm")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if ZNM_Enabled == 1 then
        tpz.znm.ryo.onTrade(player, npc, trade)
    end
end

function onTrigger(player, npc)
    if ZNM_Enabled == 1 then
        tpz.znm.ryo.onTrigger(player, npc)
    end
end

function onEventUpdate(player, csid, option)
    if ZNM_Enabled == 1 then
        tpz.znm.ryo.onEventUpdate(player, csid, option)
    end
end

function onEventFinish(player, csid, option)
    if ZNM_Enabled == 1 then
        tpz.znm.ryo.onEventFinish(player, csid, option)
    end
end
