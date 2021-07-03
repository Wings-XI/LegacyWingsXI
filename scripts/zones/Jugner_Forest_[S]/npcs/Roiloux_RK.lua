-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Roiloux, R.K.
-- Type: Campaign Arbiter
-- !pos 70.493 -0.602 -9.185 82
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