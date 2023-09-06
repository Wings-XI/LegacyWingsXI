-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: Blank (Transformations Quest)
-- !pos -529.704 0.000 649.682 72
-----------------------------------
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local transformationsProgress = player:getCharVar("TransformationsProgress")
    -- TRANSFORMATIONS
    if transformationsProgress == 4 then
        player:startEvent(4)
    elseif transformationsProgress == 5 then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 4 then
        npcUtil.popFromQM(player, GetNPCByID(ID.npc.NEPIONIC_QM), ID.mob.NEPIONIC_SOULFLAYER, {hide = 1})
    elseif csid == 5 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.TRANSFORMATIONS, {
            item = 15265,
            title = tpz.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
            var = {"TransformationsProgress"}
        })
    end
end