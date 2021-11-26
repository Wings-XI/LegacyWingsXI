-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Watisa
-- Type: Chocobo Renter
-- !pos -201 -11 93 51
-----------------------------------
require("scripts/globals/chocobo")
-----------------------------------

local eventSucceed = 9
local eventFail    = 10

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
