-----------------------------------
-- Area: GM_Home
-- NPC:  Linkshell_Concierge
-----------------------------------
local ID = require("scripts/zones/GM_Home/IDs")
require("scripts/globals/settings")
require("scripts/globals/concierge")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Has 3 NPCs, as there's no way of knowing how they behave on retail
    -- we'll just have all list everything.
    LinkShellConciergeEventTrigger(player, npc, 0, tpz.lsconciergetype.EVERYTHING)
end

function onEventUpdate(player, csid, option)
    LinkShellConciergeEventUpdate(player, csid, option, ID.text.ITEM_CANNOT_BE_OBTAINED, ID.text.LS_CONCIERGE_SAME_DAY) 
end

function onEventFinish(player, csid, option)
    LinkShellConciergeEventFinish(player, csid, option, ID.text.LS_CONCIERGE_REGISTERED1, ID.text.LS_CONCIERGE_REGISTERED2, ID.text.LS_CONCIERGE_ALREADY_LISTED, ID.text.LS_CONCIERGE_LISTING_CANCEL, ID.text.ITEM_OBTAINED, ID.text.NOT_HAVE_ENOUGH_GIL)
end
