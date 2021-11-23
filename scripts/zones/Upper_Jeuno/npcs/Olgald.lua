-----------------------------------
-- Area: Upper Jeuno
--   NPC: Olgald
-- Type: Standard NPC
-- !pos -53.072 -1 103.380 244
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

function onTrade(player, npc, trade)

    --------------------------- Male to Female --------------------------------

    local traded

    if trade:hasItemQty(16138, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(16139)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16139)
        traded = 16139
    elseif trade:hasItemQty(14578, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(14579)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14579)
        traded = 14579
    elseif trade:hasItemQty(15002, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15003)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15003)
        traded = 15003
    elseif trade:hasItemQty(15659, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15660)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15660)
        traded = 15660
    elseif trade:hasItemQty(15746, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15747)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15747)
        traded = 15747
    ------------------------ Female to Male --------------------------------

    elseif trade:hasItemQty(16139, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(16138)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 16138)
        traded = 16138
    elseif trade:hasItemQty(14579, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(14578)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14578)
        traded = 14578
    elseif trade:hasItemQty(15003, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15002)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15002)
        traded = 15002
    elseif trade:hasItemQty(15660, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15659)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15659)
        traded = 15659
    elseif trade:hasItemQty(15747, 1) and player:getFreeSlotsCount() > 0 and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:PrintToPlayer("Olgald : Ah, well we are all fine with accepting the new you.. Here you go.", 0xD)
        player:addItem(15746)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 15746)
        traded = 15746
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, traded)
    end
end

function onTrigger(player, npc)

    if (player:getCharVar("dancerTailorCS") == 1) then
        player:startEvent(10167)
    elseif (player:getCharVar("comebackQueenCS") == 1) then
        player:startEvent(10146)
    elseif (player:getCharVar("comebackQueenCS") == 3) then
        player:startEvent(10150)
    elseif (player:getCharVar("comebackQueenCS") == 5) then --player cleared Laila's story
        player:startEvent(10156)
    else
        player:startEvent(10122)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10167) then
        player:setCharVar("dancerTailorCS", 2)
    end
end
