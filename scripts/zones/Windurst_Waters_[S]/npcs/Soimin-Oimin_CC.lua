-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Soimin-Oimin, C.C.
-- Type: Campaign Arbiter
-- !pos -51.010 -6.276 213.678 94
-----------------------------------
require("scripts/globals/campaign")
-----------------------------------

local campaignEvent = 456

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCampaignAllegiance() == 0 then
        player:startEvent(452)
    else
        tpz.campaign.campaignArbiterOnTrigger(player, npc, campaignEvent)        
    end
end

function onEventUpdate(player, csid, option)
    tpz.campaign.campaignArbiterOnEventUpdate(player, csid, option, campaignEvent)
end

function onEventFinish(player, csid, option)
    tpz.campaign.campaignArbiterOnEventFinish(player, csid, option, campaignEvent)
end
