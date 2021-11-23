-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Camereine
-- Type: Chocobo Renter
-- !pos -12.3 1.4 -98 230
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 599
local eventFail    = 602

function onTrade(player, npc, trade)
    tpz.chocobo.renterOnTrade(player, npc, trade, eventSucceed, eventFail)
end

function onTrigger(player, npc)
    tpz.chocobo.renterOnTrigger(player, eventSucceed, eventFail)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.chocobo.renterOnEventFinish(player, csid, option, eventSucceed)
end
