-----------------------------------
-- Area: Windurst Woods
-- NPC:  Linkshell_Concierge_A
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/settings")
require("scripts/globals/concierge")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    LinkShellConciergeEventTrigger(player, npc, 0, tpz.lsconciergetype.NEWPLAYERS)
end

function onEventUpdate(player, csid, option)
    LinkShellConciergeEventUpdate(player, csid, option, ID.text.ITEM_CANNOT_BE_OBTAINED, ID.text.LS_CONCIERGE_SAME_DAY) 
end

function onEventFinish(player, csid, option)
    LinkShellConciergeEventFinish(player, csid, option, ID.text.LS_CONCIERGE_REGISTERED1, ID.text.LS_CONCIERGE_REGISTERED2, ID.text.LS_CONCIERGE_ALREADY_LISTED, ID.text.LS_CONCIERGE_LISTING_CANCEL, ID.text.ITEM_OBTAINED, ID.text.NOT_HAVE_ENOUGH_GIL)
end
