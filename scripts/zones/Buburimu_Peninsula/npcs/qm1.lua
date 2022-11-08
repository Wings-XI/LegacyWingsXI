---------------------------------------
-- Area: Buburimu Peninsula
--  NPC: qm1 (???)
-- !pos: -87 20 -336
--   ID: 17261187
--
-- Involved in quest: Brigand's Chart
---------------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/quests")
local buburimuID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/fishing/fishing_accessories")
require("scripts/globals/fishing/fishing_types")
-----------------------------------

npcs = npcs or {}
npcs.qm1 = npcs.qm1 or {}

local brigandschart = {
    Loot = {
        [1] =  17007, -- Dwarf Pugil
        [2] =  190,   -- Lines and Space
        [3] =  105,   -- Sky Pot
        [4] =  91,    -- Blue Pitcher
        [5] =  220,   -- Wooden Flowerpot
        [6] =  656,   -- Beastcoin
        [7] =  750,   -- Silver Beastcoin
        [8] =  748,   -- Gold Beastcoin
        [9] =  749,   -- Mythril Beastcoin
        [10] = 751,   -- Platinum Beastcoin
        [11] = 1455,  -- One Byne Bill
        [12] = 1452,  -- Ordelle Bronzepiece
        [13] = 1449,  -- Tukuku Whiteshell
        [14] = 16537, -- Mythril Sword
        [15] = 12522, -- Rusty Cap
        [16] = 14117, -- Rusty Leggings
        [17] = 14242, -- Rusty Subligar
        [18] = 65535  -- 500 gil
    },

    tempitems = {
        [1]  = 4148, -- Antidoate
        [2]  = 4112, -- Potion
        [3]  = 4113, -- Potion +1
        [4]  = 4114, -- Potion +2
        [5]  = 4115, -- Potion +3
        [6]  = 4206, -- Catholicon
        [7]  = 4202, -- Daedalus Wing
        [8]  = 4151, -- Echo Drops
        [9]  = 4174, -- Elixir
        [10] = 4128, -- Ether
        [11] = 4129, -- Ether +1
        [12] = 4130, -- Ether +2
        [13] = 4131, -- Ether +3
        [14] = 4150, -- Eye Drops
        [15] = 4301, -- Pear au Lait
        [16] = 4164, -- Prism Powder
        [17] = 4155, -- Remedy
        [18] = 4165, -- Silent Oil
        [19] = 4425, -- Tomato Juice
    }
}

function onTrade(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, 1873) then
        local questActive = GetNPCByID(buburimuID.npc.QM1):getLocalVar("BCQActive")
        if questActive == 0 then
            player:messageSpecial(buburimuID.text.BRIGANDS_CHART_QUEST.RETURN_CHART, 1873)
            player:startEvent(902)
        end
    end
end

function onTrigger(player, npc)
    player:messageSpecial(buburimuID.text.BRIGANDS_CHART_QUEST.LONG_AGO)
end

function onEventUpdate(player, csid, option)
    if csid == 902 then -- Brigand's Chart Quest
        if option == 0 then -- accepted quest
            if GetNPCByID(buburimuID.npc.QM1):getLocalVar('BCQActive') == 0 then
                startQuest(player)
            else
                player:release()
            end
        end
    end
end

function startQuest(player)
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    QMnpc:setStatus(tpz.status.DISAPPEAR)
    player:confirmTrade()
    player:delStatusEffectSilent(tpz.effect.LEVEL_SYNC)
    player:delStatusEffectsByFlag(tpz.effectFlag.DISPELABLE)
    removeTempItems(player)
    player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION,20,0,0)
    player:setLocalVar("BCQ", 1)
    QMnpc:setLocalVar("BCQActive", 1)
    QMnpc:setLocalVar("BCQPlayer", player:getID())
    startMusic(player)

    for i = 1, #buburimuID.npc.JADE_ETUI do
        GetNPCByID(buburimuID.npc.JADE_ETUI[i]):setStatus(tpz.status.DISAPPEAR)
        GetNPCByID(buburimuID.npc.JADE_ETUI[i]):setLocalVar('open', 0)
    end
end

function removeTempItems(player)
    for k, v in pairs(brigandschart.tempitems) do
        if player:hasItem(v, 3) then
            player:delItem(v, 1, tpz.inventoryLocation.TEMPITEMS)
        end
    end
end

function startMusic(player)
    player:ChangeMusic(0, 136)
    player:ChangeMusic(1, 136)
    player:ChangeMusic(2, 136)
    player:ChangeMusic(3, 136)
end

function onEventFinish(player, csid, option)
    if csid == 902 then -- Brigand's Chart Quest
        if option == 0 then -- initial dialogue completed
            continueQuest(player)
        end
    end
end

function continueQuest(player)
    spawnNPCs()
    
    local bcqhume  = GetNPCByID(buburimuID.npc.BCQ_GHOST)
    local msgID = buburimuID.text.BRIGANDS_CHART_QUEST.MY_PENGUIN_RING

    bcqhume:timer(1000, function(bcqhume) showNextMessage(msgID) end)
    bcqhume:timer(60000, function(bcqhume) showNextMessage(msgID + 1) end)
    bcqhume:timer(90000, function(bcqhume) showNextMessage(msgID + 2) end)
    bcqhume:timer(120000, function(bcqhume) showNextMessage(msgID + 3) end)
    bcqhume:timer(150000, function(bcqhume) showNextMessage(msgID + 4) end)
    bcqhume:timer(170000, function(bcqhume) showNextMessage(msgID + 5) end)
    player:timer(180000, function(player) questCleanup(player) end)
end

function spawnNPCs()
    GetNPCByID(buburimuID.npc.BCQ_GHOST):setStatus(tpz.status.NORMAL)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):entityAnimationPacket('efon')
end

function showNextMessage(msgID)
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    if QMnpc:getLocalVar("BCQActive") == 1 then
        local shimmering = GetNPCByID(buburimuID.npc.BCQ_SHIMMER)
        local pr = fishing.rings.PENGUIN

        shimmering:showText(QMnpc, msgID, pr)
    end
end

function questCleanup(player)
    showNextMessage(buburimuID.text.BRIGANDS_CHART_QUEST.IT_CANT_BE)
    
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    if QMnpc:getLocalVar("BCQActive") == 1 then
        if player ~= nil then
            endQuest(player)
        else
            endQuest(nil)
        end
    end
end

function endQuest(player)
    if player ~= nil then
        player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        player:setLocalVar("BCQ", 0)
        endMusic(player)
    end
    despawnNPCs()
    initialize()
end

function endMusic(player)
    player:ChangeMusic(0, 0)
    player:ChangeMusic(1, 0)
    player:ChangeMusic(2, 101)
    player:ChangeMusic(3, 103)
end

function despawnNPCs()
    GetNPCByID(buburimuID.npc.BCQ_GHOST):setStatus(tpz.status.DISAPPEAR)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):entityAnimationPacket('efof')
end

function initialize()
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    QMnpc:setLocalVar("BCQActive", 0)
    QMnpc:setLocalVar("BCQPlayer", 0)
    QMnpc:setLocalVar("BCQChestsOpened", 0)
    QMnpc:setLocalVar("BCQPenguinObtained", 0)
    QMnpc:setStatus(tpz.status.NORMAL)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):setStatus(tpz.status.NORMAL)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):entityAnimationPacket('efof')
    for i = 1, #buburimuID.npc.JADE_ETUI do
        local npc = GetNPCByID(buburimuID.npc.JADE_ETUI[i])
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:setLocalVar('open', 0)
    end
end

function openChest(player, npc)
    incChestsOpened()
    local treasure = pickTreasure()
    if treasure == 65535 then    -- gil
        npcUtil.giveGil(player, 500)
    elseif treasure == fishing.rings.PENGUIN then -- give 3 Yellow Globes with Penguin Ring
        player:addTreasure(4403, npc)
        player:addTreasure(4403, npc)
        player:addTreasure(4403, npc)
        player:addTreasure(treasure, npc)
        winQuest(player)
    else
        player:addTreasure(treasure, npc)
    end
end

function incChestsOpened()
    local chestsOpened = getChestsOpened()
    GetNPCByID(buburimuID.npc.QM1):setLocalVar("BCQChestsOpened", chestsOpened + 1)
end

function getChestsOpened()
    return GetNPCByID(buburimuID.npc.QM1):getLocalVar("BCQChestsOpened")
end

function pickTreasure()
    local chestCount = getChestsOpened()
    local gotPenguin = isPenguinObtained()
    local randomLoot = 0
    
    if gotPenguin == false and chestCount >= 4 then
        local ringChance = 30
        if chestCount >= 5 then
            ringChance = 60
        end
        if math.random(1,100) < ringChance then
            setPenguinObtained()
            gotPenguin = true
            return fishing.rings.PENGUIN --Penguin Ring
        else                     -- choose random loot
            randomLoot = math.random(1, #brigandschart.Loot)
            return brigandschart.Loot[randomLoot]
        end
    else
        randomLoot = math.random(1, #brigandschart.Loot)
        return brigandschart.Loot[randomLoot]
    end
end

function isPenguinObtained()
    return GetNPCByID(buburimuID.npc.QM1):getLocalVar("BCQPenguinObtained") == 1
end

function setPenguinObtained()
    GetNPCByID(buburimuID.npc.QM1):setLocalVar("BCQPenguinObtained", 1)
end

function winQuest(player)
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    endQuest(player)
    player:showText(QMnpc, buburimuID.text.BRIGANDS_CHART_QUEST.ITS_BACK_NOW)
end

-------------------------------
--Public Functions
-------------------------------

npcs.qm1.initialize = function()
    local QMnpc = GetNPCByID(buburimuID.npc.QM1)
    QMnpc:setLocalVar("BCQActive", 0)
    QMnpc:setLocalVar("BCQPlayer", 0)
    QMnpc:setLocalVar("BCQChestsOpened", 0)
    QMnpc:setLocalVar("BCQPenguinObtained", 0)
    QMnpc:setStatus(tpz.status.NORMAL)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):setStatus(tpz.status.NORMAL)
    GetNPCByID(buburimuID.npc.BCQ_SHIMMER):entityAnimationPacket('efof')
    for i = 1, #buburimuID.npc.JADE_ETUI do
        local npc = GetNPCByID(buburimuID.npc.JADE_ETUI[i])
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:setLocalVar('open', 0)
    end
end

npcs.qm1.openChest = function(player, npc)
    incChestsOpened()
    local treasure = pickTreasure()
    if treasure == 65535 then    -- gil
        npcUtil.giveGil(player, 500)
    elseif treasure == fishing.rings.PENGUIN then -- give 3 Yellow Globes with Penguin Ring
        player:addTreasure(4403, npc)
        player:addTreasure(4403, npc)
        player:addTreasure(4403, npc)
        player:addTreasure(treasure, npc)
        winQuest(player)
    else
        player:addTreasure(treasure, npc)
    end
end

npcs.qm1.endQuest = function(player)
    if player ~= nil then
        player:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        player:setLocalVar("BCQ", 0)
        endMusic(player)
    end
    despawnNPCs()
    initialize()
end

npcs.qm1.getAvailableJadeEtui = function()
    for i = 1, #buburimuID.npc.JADE_ETUI do
        local chest = GetNPCByID(buburimuID.npc.JADE_ETUI[i])
        if chest:getStatus() == tpz.status.DISAPPEAR then
            return buburimuID.npc.JADE_ETUI[i]
        end
    end
    return 0
end

npcs.qm1.pufferPugilAvailable = function()
    local puffer = GetMobByID(buburimuID.mob.PUFFER_PUGIL)
    local pufferSpawned = puffer:isSpawned()
    return pufferSpawned == false
end