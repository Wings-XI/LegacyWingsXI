-----------------------------------
-- Tutorial Mini-Quest
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------

tpz = tpz or {}
tpz.tutorial = tpz.tutorial or {}

tpz.tutorial.onTrigger = function(player, npc, npc_event_offset, nation_offset)
    local stage = player:getCharVar("TutorialProgress")

    if player:hasKeyItem(tpz.ki.CONQUEST_PROMOTION_VOUCHER) and player:hasItem(15761) == false and player:hasItem(15762) == false and player:hasItem(15763) == false and (player:getFreeSlotsCount() > 1) then
        npcUtil.giveItem(player, 15761)
        player:delKeyItem(tpz.ki.CONQUEST_PROMOTION_VOUCHER)
    elseif stage == 0 then
        player:startEvent(npc_event_offset + 17)
    else
        local mLevel = player:getMainLvl()
        if stage == 1 then
            player:startEvent(npc_event_offset)
        elseif stage == 2 then
            if not player:hasStatusEffect(tpz.effect.SIGNET) then
                player:startEvent(npc_event_offset + 1)
            else
                player:startEvent(npc_event_offset + 2)
            end
        elseif stage == 3 then
            if not player:hasStatusEffect(tpz.effect.FOOD) then
                player:startEvent(npc_event_offset + 3)
            else
                player:startEvent(npc_event_offset + 4)
            end
        elseif stage == 4 then
            local isSkilled = false
            for i = tpz.skill.HAND_TO_HAND, tpz.skill.STAFF do
                if player:getSkillLevel(i) >= 5 then
                    isSkilled = true
                    break
                end
            end
            if not isSkilled then
                player:startEvent(npc_event_offset + 5)
            else
                player:startEvent(npc_event_offset + 6)
            end
        elseif stage == 5 then
            player:startEvent(npc_event_offset + 7)
        elseif stage == 6 then
            player:startEvent(npc_event_offset + 8, 0, 0, 0, tpz.ki.CONQUEST_PROMOTION_VOUCHER, 0, 0, 0)
        elseif stage == 7 then
            if mLevel < 4 then
                player:startEvent(npc_event_offset + 9)
            else
                player:startEvent(npc_event_offset + 10, 0, 0, nation_offset, 0, 0, 0, 0, 0)
            end
        elseif stage == 8 then
            player:startEvent(npc_event_offset + 11, 0, 0, nation_offset, 0, 0, 0, 0, 0)
        elseif stage == 9 then
            player:startEvent(npc_event_offset + 12, 800*EXP_RATE, 0, nation_offset, 0, 0, 0, 0, 0)
        elseif stage == 10 then
            if mLevel < 10 then
                player:startEvent(npc_event_offset + 13, 0, 0, nation_offset, 0, 0, 0, 0, 0)
            else
                player:startEvent(npc_event_offset + 14, 0, 1000*GIL_RATE, nation_offset, 0, 0, 0, 0, 0)
            end
        elseif stage == 11 then
            if not player:hasKeyItem(tpz.ki.HOLLA_GATE_CRYSTAL + nation_offset) then
                player:startEvent(npc_event_offset + 15, tpz.ki.HOLLA_GATE_CRYSTAL + nation_offset, 0, nation_offset, 0, 0, 0, 0, 0)
            else
                player:startEvent(npc_event_offset + 16, tpz.ki.HOLLA_GATE_CRYSTAL + nation_offset, 1000*EXP_RATE, 1789, 3, 0, 0, 0, 0)
            end
        end
    end
end

tpz.tutorial.onAuctionTrigger = function(player)
    if player:getCharVar("TutorialProgress") == 5 then
        player:setCharVar("TutorialProgress", 6)
    end
end

tpz.tutorial.onEventFinish = function(player, csid, option, npc_event_offset, nation_offset)
    if csid == npc_event_offset then
        player:setCharVar("TutorialProgress", 2)
    elseif csid == (npc_event_offset + 2) then
        if npcUtil.giveItem(player, {{4376, 6}}) then
            player:setCharVar("TutorialProgress", 3)
        else
            player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
        end
    elseif csid == (npc_event_offset + 4) then
        player:setCharVar("TutorialProgress", 4)
    elseif csid == (npc_event_offset + 6) then
        if player:getZoneID() == tpz.zone.WINDURST_WOODS then
            if npcUtil.giveItem(player, {{4101, 1}, {4570, 1}, {4370, 1}}) then
                player:setCharVar("TutorialProgress", 5)
            else
                player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
            end
        elseif player:getZoneID() == tpz.zone.BASTOK_MARKETS then
            if npcUtil.giveItem(player, {{4096, 1}, {926, 1}, {4370, 1}}) then
                player:setCharVar("TutorialProgress", 5)
            else
                player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
            end
        elseif player:getZoneID() == tpz.zone.SOUTHERN_SAN_DORIA then
            if npcUtil.giveItem(player, {{4096, 1}, {936, 1}, {4358, 1}}) then
                player:setCharVar("TutorialProgress", 5)
            else
                player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
            end
        end
    elseif csid == (npc_event_offset + 8) then
        npcUtil.giveKeyItem(player, tpz.ki.CONQUEST_PROMOTION_VOUCHER)
        player:setCharVar("TutorialProgress", 7)
        player:PrintToPlayer("NOTICE: Talk to this SAME NPC again with a free inventory slot to get a Chariot Band.",29)
    elseif csid == (npc_event_offset + 10) then
        if npcUtil.giveItem(player, 16003) then
            player:setCharVar("TutorialProgress", 8)
        else
            player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
        end
    elseif csid == (npc_event_offset + 12) then
        player:addExp(800 * EXP_RATE)
        player:setCharVar("TutorialProgress", 10)
    elseif csid == (npc_event_offset + 14) then
        npcUtil.giveCurrency(player, 'gil', 1000 * GIL_RATE)
        player:setCharVar("TutorialProgress", 11)
    elseif csid == (npc_event_offset + 16) then
        if npcUtil.giveItem(player, {{1789, 3}}) then
            player:addExp(1000*EXP_RATE)
            player:setCharVar("TutorialProgress", 0)
        else
            player:PrintToPlayer("NOTICE: Tutorial CANNOT continue until you receive this item.",29)
        end
    end
end

tpz.tutorial.onMobDeath = function(player)
    if player and player:getCharVar("TutorialProgress") == 8 then
        player:setCharVar("TutorialProgress", 9)
    end
end
