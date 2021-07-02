-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Yuvalbaux, R.K.
-- Type: Campaign Arbiter
-- !pos TODO
-----------------------------------
require("scripts/globals/campaign")
-----------------------------------

local campaignEvent = 454

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCampaignAllegiance() == 0 then
        player:startEvent(450)
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
