-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Drahbah
-- Standard Info NPC
-----------------------------------
require("scripts/globals/appraisal")
require("scripts/globals/npc_util")

local gilToPay = 500

function onTrade(player, npc, trade)
    local appraisalCsid = 679
    tpz.appraisalUtil.appraiseItem(player, npc, trade, gilToPay, appraisalCsid)
end

function onTrigger(player, npc)
    player:startEvent(678, gilToPay)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local appraisalCsid = 679
    tpz.appraisalUtil.appraisalOnEventFinish(player, csid, option, gilToPay, appraisalCsid)
end