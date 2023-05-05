-----------------------------------
-- Area: Port Bastok
--  NPC: Numa
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/shop")

-- WINGSCUSTOM trade equal parts of each individual ninjutsu tool for unified tool counterparts
local toolList =   {
    -- UCHITAKE,TSURARA, KAWAHORI_OGI,MAKIBISHI, HIRAISHIN,  MIZU_DEPPO  --inoshishinofuda
    {{ 1161,    1164,    1167,       1170,       1173,       1176},      2971}, -- singles
    {{ 5308,    5309,    5310,       5311,       5312,       5313},      5867}, -- toolbags
    -- RYUNO,   MOKUJIN, SANJAKU_TENUGUI,    KABENRO,    SHINOBI_TABI,   SHIHEI  --shikanofuda (excluded Ranka and Furusumi)
    {{  2644,   2970,    2553,               2642,       1194,           1179},  2972}, -- singles
    {{  5865,   5866,    5417,               5863,       5319,           5314},  5868}, -- toolbags
    -- KODOKU,  KAGINAWA,JUSATSU,            SAIRUI_RAN  --chonofuda (excluded Soshi and Jinko)
    {{ 1191,    1185,    1182,               1188},      2973}, -- singles
    {{ 5318,    5316,    5315,               5317},      5869}, -- toolbags
}


function onTrade(player, npc, trade)
    local toolIndex = -1
    local toolCount = -1
    local invalidTrade = false

    -- discern the desired unified tool, but do not confirm the trade items
    for i = 1, #toolList, 1 do
        if npcUtil.tradeHas(trade, toolList[i][1][1], false, false) then
            toolIndex = i
            break
        end
    end

    if toolIndex == -1 then
        return
    end

    -- find the tool quantity
    for i = 0, 8, 1 do
        local itemId = trade:getItemId(i)
        if itemId > 0 then
            itemQty = trade:getSlotQty(i)
            if toolCount == -1 then
                toolCount = itemQty
            else
                if toolCount ~= itemQty then
                    invalidTrade = true
                end
            end
        end
    end

    if invalidTrade then
        player:PrintToPlayer(string.format("%s : You must trade equal parts of all types of crafted tools", npc:getName()), 0xD)
        return
    end

    -- Ensure exact tool counts, but again do not confirm the trade items
    for i = 1, #toolList[toolIndex][1], 1 do
        printf("tool %u count %u",toolList[toolIndex][1][i],toolCount)
        if not npcUtil.tradeHas(trade, toolList[toolIndex][1][i], false, false) then
            invalidTrade = true
            break
        end
    end

    if invalidTrade then
        player:PrintToPlayer(string.format("%s : You must trade all %u types of crafted tools", npc:getName(), #toolList[toolIndex][1]), 0xD)
        return
    end

    -- make the trade
    -- take trade first to clear space for unified items
    player:tradeComplete()
    player:messageSpecial(ID.text.ITEM_OBTAINED, toolList[toolIndex][2])
    for i = 1, #toolList[toolIndex][1] do
        player:addItem(toolList[toolIndex][2], toolCount)
    end
end

function onTrigger(player, npc)
    local stock =
    {
        12457, 5079, 1,    -- Cotton Hachimaki
        12585, 7654, 1,    -- Cotton Dogi
        12713, 4212, 1,    -- Cotton Tekko
        12841, 6133, 1,    -- Cotton Sitabaki
        12969, 3924, 1,    -- Cotton Kyahan
        13205, 3825, 1,    -- Silver Obi
        12456,  759, 2,    -- Hachimaki
        12584, 1145, 2,    -- Kenpogi
        12712,  630, 2,    -- Tekko
        12840,  915, 2,    -- Sitabaki
        12968,  584, 2,    -- Kyahan
        704,    132, 2,    -- Bamboo Stick
        605,    180, 3,    -- Pickaxe
        5867, 13500, 3,    -- Toolbag (Ino)
        5868, 18000, 3,    -- Toolbag (Shika)
        5869, 18000, 3,    -- Toolbag (Cho)
    }

    player:PrintToPlayer(string.format("%s : Trade equal parts of individual Ninjutsu tools to get the unified tools!", npc:getName()), 0xD)
    player:showText(npc, ID.text.NUMA_SHOP_DIALOG)
    tpz.shop.nation(player, stock, tpz.nation.BASTOK)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
