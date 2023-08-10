--
-- Mog House related functions
--

require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/zone")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/events/amkhelpers")
------------------------------------
-- Mog Locker constants
------------------------------------
MOGLOCKER_START_TS = 1009810800 -- unix timestamp for 2001/12/31 15:00
MOGLOCKER_ALZAHBI_VALID_DAYS = 7
MOGLOCKER_ALLAREAS_VALID_DAYS = 5
MOGLOCKER_ACCESS_TYPE_ALZAHBI = 0
MOGLOCKER_ACCESS_TYPE_ALLAREAS = 1
MOGLOCKER_PLAYERVAR_ACCESS_TYPE = "mog-locker-access-type"
MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP = "mog-locker-expiry-timestamp"

function isInMogHouseInHomeNation(player)
    if not player:isInMogHouse() then
        return false
    end

    local currentZone = player:getZoneID()
    local nation = player:getNation()
    
    if nation == tpz.nation.BASTOK then
        if currentZone >= tpz.zone.BASTOK_MINES and currentZone <= tpz.zone.METALWORKS then
            return true
        end
    elseif nation == tpz.nation.SANDORIA then
        if currentZone >= tpz.zone.SOUTHERN_SAN_DORIA and currentZone <= tpz.zone.CHATEAU_DORAGUILLE then
            return true
        end
    else -- Windurst
        if currentZone >= tpz.zone.WINDURST_WATERS and currentZone <= tpz.zone.WINDURST_WOODS then
            return true
        end
    end
    return false
end

function moogleTrade(player, npc, trade)
    if player:isInMogHouse() then
        local numBronze = trade:getItemQty(2184)
        -- Trading Imperial Bronze Piece to Moogle 
        if numBronze > 0 then
            if addMogLockerExpiryTime(player, numBronze) then
                -- Remove Imperial Bronze Piece
                player:tradeComplete()
                -- Show new lease time
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 2, getMogLockerExpiryTimestamp(player))
            end
        end

        -- A Moogle Kupo d'Etat Mission 2
        if
            isInMogHouseInHomeNation(player) and
            player:getCurrentMission(AMK) == tpz.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP and
            npcUtil.tradeHasExactly(trade, {2757, 2758, 2759})
        then
            player:confirmTrade()
            player:startEvent(30024)
        end

        local giveMoogleABreak = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK)
        local theMooglePicnic = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_MOOGLE_PICNIC)
        local moogleInTheWild = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD)

        -- Mog Safe Expansion Quest 1 - Give a Moogle a Break - Trading Power Bow and Beetle Ring
        if
            giveMoogleABreak == QUEST_ACCEPTED and
            npcUtil.tradeHas(trade, {17161, 13457})
        then
            player:startEvent(30007)
            player:setCharVar("MogSafe_waitJPMidnight", JstMidnight())
        -- Mog Safe Expansion Quest 2 - The Moogle's Picnic! - Trading Selbina Butter and Shrimp Lure 
        elseif
            theMooglePicnic == QUEST_ACCEPTED and
            npcUtil.tradeHas(trade, {17402, 615})
        then
            player:startEvent(30011)
            player:setCharVar("MogSafe_waitJPMidnight", JstMidnight())
        -- Mog Safe Expansion Quest 3 - Moogles in the Wild - Trading Raptor Mantle and Wool Hat 
        elseif
            moogleInTheWild == QUEST_ACCEPTED and
            npcUtil.tradeHas(trade, {13593, 12474})
        then
            player:startEvent(30015)
            player:setCharVar("MogSafe_waitJPMidnight", JstMidnight())
        end
        return true
    end
    return false
end

function moogleTrigger(player, npc)
    if player:isInMogHouse() then
        local lockerTs = getMogLockerExpiryTimestamp(player)
        -- Mog Locker expiry time messages
        if lockerTs ~= nil then
            if lockerTs == -1 then -- expired
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 1, 2184)
            else
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET, lockerTs)
            end
        end

        local homeNationFameLevel = player:getFameLevel(player:getNation())
        local pNation = player:getNation()
        local giveMoogleABreak = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK)
        local theMooglePicnic = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_MOOGLE_PICNIC)
        local moogleInTheWild = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD)
        local unexpectedTreasure = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNEXPECTED_TREASURE)
        -- Moghouse Tutorial
        if player:getCharVar("MoghouseExplication") == 1 then
            player:startEvent(30000)
        -- A Moogle Kupo d'Etat Mission 1
        elseif
            ENABLE_AMK == 1 and
            isInMogHouseInHomeNation(player) and
            player:getMainLvl() >= 10 and
            player:getCurrentMission(AMK) == tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT
        then
            player:startEvent(30023)
        -- Mog Safe Expansion Quest 1 - Give a Moogle a Break | Requirement: Fame Level 3 in Home Nation | Reward: +10 Mog Safe space
        elseif player:getLocalVar("QuestSeen") == 0 and giveMoogleABreak == QUEST_AVAILABLE and homeNationFameLevel >= 3 and 
        player:getCharVar("[MS1]BedPlaced") ~= 0 and player:getCharVar("[MS1]BedPlaced") ~= getConquestTally() then
            player:startEvent(30005, 0, 0, 0, 5, 0, 17161, 13457)
        elseif player:getLocalVar("QuestSeen") == 0 and giveMoogleABreak == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 1 then
            player:startEvent(30006, 0, 0, 0, 0, 0, 17161, 13457)
        elseif player:getLocalVar("QuestSeen") == 0 and giveMoogleABreak == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 2 and
        player:getCharVar("MogSafe_waitJPMidnight") < os.time() then
            player:startEvent(30008)
        -- Mog Safe Expansion Quest 2 - The Moogle's Picnic! | Requirement: Fame Level 5 in Home Nation | Reward: +10 Mog Safe space
        elseif player:getLocalVar("QuestSeen") == 0 and theMooglePicnic == QUEST_AVAILABLE and homeNationFameLevel >= 5 and giveMoogleABreak == QUEST_COMPLETED and 
        player:getCharVar("[MS2]BedPlaced") ~= 0 and player:getCharVar("[MS2]BedPlaced") ~= getConquestTally() then
            player:startEvent(30009, 0, 0, 0, 4, 0, 17402, 615)
        elseif player:getLocalVar("QuestSeen") == 0 and theMooglePicnic == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 1 then
            player:startEvent(30010, 0, 0, 0, 0, 0, 17402, 615)
        elseif player:getLocalVar("QuestSeen") == 0 and theMooglePicnic == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 2 and
        player:getCharVar("MogSafe_waitJPMidnight") < os.time() then
            player:startEvent(30012)
        -- Mog Safe Expansion Quest 3 - Moogles in the Wild | Requirement: Fame Level 7 in Home Nation | Reward: +10 Mog Safe space
        elseif player:getLocalVar("QuestSeen") == 0 and moogleInTheWild == QUEST_AVAILABLE and homeNationFameLevel >= 7 and theMooglePicnic == QUEST_COMPLETED and 
        player:getCharVar("[MS3]BedPlaced") ~= 0 and player:getCharVar("[MS3]BedPlaced") ~= getConquestTally() then
            player:startEvent(30013, 0, 0, 0, 6, 0, 13593, 12474)
        elseif player:getLocalVar("QuestSeen") == 0 and moogleInTheWild == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 1 then
            player:startEvent(30014, 0, 0, 0, 0, 0, 13593, 12474)
        elseif player:getLocalVar("QuestSeen") == 0 and moogleInTheWild == QUEST_ACCEPTED and player:getCharVar("MogSafeProgress") == 2 and
        player:getCharVar("MogSafe_waitJPMidnight") < os.time() then
            player:startEvent(30016)
        -- Unexpected Treasure Quest | Requirement: San d'Oria Fame Level 4 | Reward: 12,000g
        elseif player:getLocalVar("[UT]QuestSeen") == 0 and unexpectedTreasure == QUEST_AVAILABLE and player:getFameLevel(SANDORIA) >= 4 and
        player:getCharVar("CupboardPlaced") == 1 then 
            player:startEvent(30003, 0, 0, 15, 57, 160)
        -- Furniture Quests - https://ffxiclopedia.fandom.com/wiki/Furniture_Quest
        -- Armoire | Requirement: Fame Level 7 in Home Nation | Reward: Scroll of Protect IV 
        elseif player:getCharVar("ArmoirePlaced") ~= 0 and player:getCharVar("ArmoirePlaced") ~= getConquestTally() and
        player:getCharVar("ProtectIVObtained") == 0 and homeNationFameLevel >= 7 then 
            player:startEvent(30003, 0, 0, 5, 61)
        -- Beverage Barrel | Requirement: Nation 1st or 2nd place in Conquest Tally | Reward: Grape Juice *Repeatable every week*
        elseif player:getCharVar("BeverageBarrelPlaced") ~= 0 and player:getCharVar("BeverageBarrelPlaced") ~= getConquestTally() and
        player:getCharVar("GrapeJuiceObtained") ~= getConquestTally() and getNationRank(pNation) ~= 3 then 
            player:startEvent(30003, 0, 0, 11, 96)
        -- Bureau | Requirement: Fame Level 7 in Home Nation | Reward: Scroll of Protectra IV
        elseif player:getCharVar("BureauPlaced") ~= 0 and player:getCharVar("BureauPlaced") ~= getConquestTally() and
        player:getCharVar("ProtectraIVObtained") == 0 and homeNationFameLevel >= 7 then 
            player:startEvent(30003, 0, 0, 4, 30)
        -- Copy of Lines and Space (painting) | Requirement: Fame Level 3 in Home Nation | Reward: Onyx
        elseif player:getCharVar("LinesAndSpacePlaced") ~= 0 and player:getCharVar("LinesAndSpacePlaced") ~= getConquestTally() and
        player:getCharVar("OnyxObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 7, 190)
        -- Oak Bed | Requirement: Fame Level 3 in Home Nation | Reward: Ether 
        elseif player:getCharVar("OakBedPlaced") ~= 0 and player:getCharVar("OakBedPlaced") ~= getConquestTally() and 
        player:getCharVar("EtherObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 1, 3)
        -- Simple Bed | Requirement: Fame Level 3 in Home Nation | Reward: Iron Ore x4 
        elseif player:getCharVar("SimpleBedPlaced") ~= 0 and player:getCharVar("SimpleBedPlaced") ~= getConquestTally() and 
        player:getCharVar("IronOreObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 2, 2)
        -- Stationery Set | Requirement: Fame Level 2 in Home Nation | Reward: Scroll of Scop's Operetta
        elseif player:getCharVar("StationerySetPlaced") ~= 0 and player:getCharVar("StationerySetPlaced") ~= getConquestTally() and 
        player:getCharVar("ScopsOperettaObtained") == 0 and homeNationFameLevel >= 2 then 
            player:startEvent(30003, 0, 0, 10, 131)
        -- Tarutaru Desk | Requirement: Fame Level 3 in Home Nation | Reward: Hi-Potion 
        elseif player:getCharVar("TarutaruDeskPlaced") ~= 0 and player:getCharVar("TarutaruDeskPlaced") ~= getConquestTally() and 
        player:getCharVar("HiPotionObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 3, 26)
        -- Water Cask | Requirement: Nation 1st or 2nd place in Conquest Tally | Reward: Distilled Water *Repeatable every week*    
        elseif player:getCharVar("WaterCaskPlaced") ~= 0 and player:getCharVar("WaterCaskPlaced") ~= getConquestTally() and 
        player:getCharVar("DistilledWaterObtained") ~= getConquestTally() and getNationRank(pNation) ~= 3 then 
            player:startEvent(30003, 0, 0, 6, 93)
        -- White Jar | Requirement: Fame Level 3 in Home Nation | Reward: Paralyze Potion 
        elseif player:getCharVar("WhiteJarPlaced") ~= 0 and player:getCharVar("WhiteJarPlaced") ~= getConquestTally() and 
        player:getCharVar("ParalyzePotionObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 9, 110)
        -- Wicker Box | Requirement: Fame Level 3 in Home Nation | Reward: Horn Quiver 
        elseif player:getCharVar("WickerBoxPlaced") ~= 0 and player:getCharVar("WickerBoxPlaced") ~= getConquestTally() and 
        player:getCharVar("HornQuiverObtained") == 0 and homeNationFameLevel >= 3 then 
            player:startEvent(30003, 0, 0, 8, 43) 
        else
            player:sendMenu(1)
        end

        -- Starlight Celebration Furniture Quests
        if isStarlightEnabled() ~= 0 then
            local HolidayTree = player:getCharVar("HolidayTree")
            local SandOrianTree = player:getCharVar("SandOrianTree")
            local BastokanTree = player:getCharVar("BastokanTree")
            local WindurstianTree = player:getCharVar("WindurstianTree")
            local DreamHatObtained = player:getCharVar("DreamHatObtained")
            -- Home Nation Tree | Reward: Dream Hat +1
            if HolidayTree == 1 and DreamHatObtained ~= getConquestTally() then
                if player:hasItem(15179) == false and SandOrianTree == 1 then
                    player:startEvent(30017, 0, 0, 0, 86)
                elseif player:hasItem(15179) == false and BastokanTree == 1 then
                    player:startEvent(30017, 0, 0, 0, 115)
                elseif player:hasItem(15179) == false and WindurstianTree == 1 then
                    player:startEvent(30017, 0, 0, 0, 116)
                end
            -- Dream Platter | Reward: Buche au Chocolat + Roast Turkey *Repeatable during Starlight Festival*
            elseif player:getCharVar("DreamPlatterPlaced") == 1 and player:getCharVar("RoastTurkeyObtained") ~= getConquestTally() then 
                player:startEvent(30018, 0, 0, 0, 140)
                player:setCharVar("RoastTurkeyObtained", getConquestTally())    
            -- Dream Coffer | Reward: Gateau Aux Fraises + Candy Ring *Repeatable during Starlight Festival*
            elseif player:getCharVar("DreamCofferPlaced") == 1 and player:getCharVar("CandyRingObtained") ~= getConquestTally() then 
                player:startEvent(30019, 0, 0, 0, 141)
                player:setCharVar("CandyRingObtained", getConquestTally())
            -- Dream Stocking | Reward: Candy Cane + Black Pudding *Repeatable during Starlight Festival*
            elseif player:getCharVar("DreamStockingPlaced") == 1 and player:getCharVar("BlackPuddingObtained") ~= getConquestTally() then 
                player:startEvent(30020, 0, 0, 0, 155)
                player:setCharVar("BlackPuddingObtained", getConquestTally())
            end
        end
        return true   
    end
    return false
end

function moogleEventUpdate(player, csid, option)
    if player:isInMogHouse() then
        return true
    end
    return false
end

function moogleEventFinish(player, csid, option)
    local homeNationFameLevel = player:getFameLevel(player:getNation())
    local pNation = player:getNation()
    
    if player:isInMogHouse() then
        -- Moghouse Tutorial
        if csid == 30000 then
            player:setCharVar("MoghouseExplication", 0)
        --A Moogle Kupo d'Etat Mission 1
        elseif csid == 30023 then
            player:completeMission(AMK, tpz.mission.id.amk.A_MOOGLE_KUPO_DETAT)
            player:addMission(AMK, tpz.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP)
        -- A Moogle Kupo d'Etat Mission 2
        elseif csid == 30024 then
            player:tradeComplete()
            npcUtil.giveKeyItem(player, tpz.ki.WHITE_CORAL_KEY)
            player:completeMission(AMK, tpz.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP)
            player:addMission(AMK, tpz.mission.id.amk.HASTEN_IN_A_JAM_IN_JEUNO)
        -- Mog Safe Expansion Quest 1 - Give a Moogle a Break
        elseif csid == 30005 and option == 1 then
            player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK)
            player:setLocalVar("QuestSeen", 1)
            player:setCharVar("[MS1]BedPlaced", 0)
            player:setCharVar("MogSafeProgress", 1)
        elseif csid == 30005 and option == 2 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30006 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30007 then
            player:tradeComplete()
            player:setCharVar("MogSafeProgress", 2)
        elseif csid == 30008 then
            player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK)
            player:changeContainerSize(tpz.inv.MOGSAFE, 10)
            player:addTitle(tpz.title.MOGS_KIND_MASTER)
            player:setCharVar("MogSafeProgress", 0)
            player:setCharVar("MogSafe_waitJPMidnight", 0)
        -- Mog Safe Expansion Quest 2 - The Moogle's Picnic!
        elseif csid == 30009 and option == 1 then
            player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_MOOGLE_PICNIC)
            player:setLocalVar("QuestSeen", 1)
            player:setCharVar("[MS2]BedPlaced", 0)
            player:setCharVar("MogSafeProgress", 1)
        elseif csid == 30009 and option == 2 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30010 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30011 then
            player:tradeComplete()
            player:setCharVar("MogSafeProgress", 2)
        elseif csid == 30012 then
            player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.THE_MOOGLE_PICNIC)
            player:changeContainerSize(tpz.inv.MOGSAFE, 10)
            player:addTitle(tpz.title.MOGS_EXCEPTIONALLY_KIND_MASTER)
            player:setCharVar("MogSafeProgress", 0)
            player:setCharVar("MogSafe_waitJPMidnight", 0)
        -- Mog Safe Expansion Quest 3 - Moogles in the Wild
        elseif csid == 30013 and option == 1 then
            player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD)
            player:setLocalVar("QuestSeen", 1)
            player:setCharVar("[MS3]BedPlaced", 0)
            player:setCharVar("MogSafeProgress", 1)
        elseif csid == 30013 and option == 2 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30014 then
            player:setLocalVar("QuestSeen", 1)
        elseif csid == 30015 then
            player:tradeComplete()
            player:setCharVar("MogSafeProgress", 2)
        elseif csid == 30016 then
            player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.MOOGLES_IN_THE_WILD)
            player:changeContainerSize(tpz.inv.MOGSAFE, 10)
            player:addTitle(tpz.title.MOGS_LOVING_MASTER)
            player:setCharVar("MogSafeProgress", 0)
            player:setCharVar("MogSafe_waitJPMidnight", 0)
        -- Unexpected Treasure Quest
        elseif csid == 30003 and player:getLocalVar("[UT]QuestSeen") == 0 and player:getCharVar("CupboardPlaced") == 1 then
            player:addKeyItem(tpz.keyItem.SMALL_TEACUP)
            player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, tpz.keyItem.SMALL_TEACUP)
            player:setLocalVar("[UT]QuestSeen", 1)
        -- Furniture Quests - https://ffxiclopedia.fandom.com/wiki/Furniture_Quest
        -- Armoire 
        elseif csid == 30003 and player:getCharVar("ArmoirePlaced") ~= 0 and player:getCharVar("ArmoirePlaced") ~= getConquestTally() and 
        player:getCharVar("ProtectIVObtained") == 0 and homeNationFameLevel >= 7 then
            player:addItem(4654) -- Scroll of Protect IV
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4654)
            player:setCharVar("ProtectIVObtained", 1)
            player:setCharVar("ArmoirePlaced", 0)
        -- Beverage Barrel *Repeatable every week*
        elseif csid == 30003 and player:getCharVar("BeverageBarrelPlaced") ~= 0 and player:getCharVar("BeverageBarrelPlaced") ~= getConquestTally() and 
        player:getCharVar("GrapeJuiceObtained") ~= getConquestTally() and getNationRank(pNation) ~= 3 then
            player:addItem(4441) -- Grape Juice
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4441)
            player:setCharVar("GrapeJuiceObtained", getConquestTally())
        -- Bureau
        elseif csid == 30003 and player:getCharVar("BureauPlaced") ~= 0 and player:getCharVar("BureauPlaced") ~= getConquestTally() and 
        player:getCharVar("ProtectraIVObtained") == 0 and homeNationFameLevel >= 7 then
            player:addItem(4736) -- Scroll of Protectra IV
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4736)
            player:setCharVar("ProtectraIVObtained", 1)
            player:setCharVar("BureauPlaced", 0)
        -- Copy of Lines and Space (painting)
        elseif csid == 30003 and player:getCharVar("LinesAndSpacePlaced") ~= 0 and player:getCharVar("LinesAndSpacePlaced") ~= getConquestTally() and 
        player:getCharVar("OnyxObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(799) -- Onyx 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 799)
            player:setCharVar("OnyxObtained", 1)
            player:setCharVar("LinesAndSpacePlaced", 0)
        -- Oak Bed
        elseif csid == 30003 and player:getCharVar("OakBedPlaced") ~= 0 and player:getCharVar("OakBedPlaced") ~= getConquestTally() and 
        player:getCharVar("EtherObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(4128) -- Ether 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4128)
            player:setCharVar("EtherObtained", 1)
            player:setCharVar("OakBedPlaced", 0)
        -- Simple Bed 
        elseif csid == 30003 and player:getCharVar("SimpleBedPlaced") ~= 0 and player:getCharVar("SimpleBedPlaced") ~= getConquestTally() and 
        player:getCharVar("IronOreObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(643, 4) -- Iron Ore x4 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 643)
            player:setCharVar("IronOreObtained", 1)
            player:setCharVar("SimpleBedPlaced", 0)
        -- Stationery Set 
        elseif csid == 30003 and player:getCharVar("StationerySetPlaced") ~= 0 and player:getCharVar("StationerySetPlaced") ~= getConquestTally() and 
        player:getCharVar("ScopsOperettaObtained") == 0 and homeNationFameLevel >= 2 then
            player:addItem(5017) -- Scroll of Scop's Operetta 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5017)
            player:setCharVar("ScopsOperettaObtained", 1)
            player:setCharVar("StationerySetPlaced", 0)
        -- Tarutaru Desk 
        elseif csid == 30003 and player:getCharVar("TarutaruDeskPlaced") ~= 0 and player:getCharVar("TarutaruDeskPlaced") ~= getConquestTally() and 
        player:getCharVar("HiPotionObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(4116) -- Hi-Potion
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4116)
            player:setCharVar("HiPotionObtained", 1)
            player:setCharVar("TarutaruDeskPlaced", 0)
        -- Water Cask
        elseif csid == 30003 and player:getCharVar("WaterCaskPlaced") ~= 0 and player:getCharVar("WaterCaskPlaced") ~= getConquestTally() and 
        player:getCharVar("DistilledWaterObtained") ~= getConquestTally() and getNationRank(pNation) ~= 3 then
            player:addItem(4509) -- Distilled Water
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4509)
            player:setCharVar("DistilledWaterObtained", getConquestTally())
        -- White Jar 
        elseif csid == 30003 and player:getCharVar("WhiteJarPlaced") ~= 0 and player:getCharVar("WhiteJarPlaced") ~= getConquestTally() and 
        player:getCharVar("ParalyzePotionObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(4159) -- Paralyze Potion
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4159)
            player:setCharVar("ParalyzePotionObtained", 1)
            player:setCharVar("WhiteJarPlaced", 0)
        -- Wicker Box 
        elseif csid == 30003 and player:getCharVar("WickerBoxPlaced") ~= 0 and player:getCharVar("WickerBoxPlaced") ~= getConquestTally() and 
        player:getCharVar("HornQuiverObtained") == 0 and homeNationFameLevel >= 3 then
            player:addItem(4222) -- Horn Quiver
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 4222)
            player:setCharVar("HornQuiverObtained", 1)
            player:setCharVar("WickerBoxPlaced", 0)
        -- Starlight Celebration - Home Nation Tree
        elseif csid == 30017 then
            player:addItem(15179) -- Dream Hat +1
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 15179)
            player:setCharVar("DreamHatObtained", getConquestTally())
        -- Starlight Celebration - Dream Platter *Repeatable during Starlight Festival*
        elseif csid == 30018 then
            player:addItem(5550) -- Roll of Buche au Chocolat 
            player:addItem(5620) -- Roast Turkey 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5550)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5620)
            player:setCharVar("RoastTurkeyObtained", getConquestTally())    
        -- Starlight Celebration - Dream Coffer *Repeatable during Starlight Festival*
        elseif csid == 30019 then
            player:addItem(5542) -- Gateau Aux Fraises 
            player:addItem(5621) -- Candy Ring 
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5542)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5621)
            player:setCharVar("CandyRingObtained", getConquestTally())
        -- Starlight Celebration - Dream Stocking *Repeatable during Starlight Festival*
        elseif csid == 30020 then
            player:addItem(5622) -- Candy Cane
            player:addItem(5552) -- Black Pudding
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5622)
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, 5552)
            player:setCharVar("BlackPuddingObtained", getConquestTally())
        end
        return true
    end
    return false
end

-- Unlocks the mog locker for the player. Returns the 'expired' timestamp (-1)
function unlockMogLocker(player)
    player:setCharVar(MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP, -1)
    local currentSize = player:getContainerSize(tpz.inv.MOGLOCKER)
    if currentSize == 0 then -- Do this check in case some servers auto-set 80 slots for mog locker items
        player:changeContainerSize(tpz.inv.MOGLOCKER, 30)
    end
    return -1
end

-- Sets the mog locker access type (all areas or Alzahbi only). Returns the new access type.
function setMogLockerAccessType(player, accessType)
    player:setCharVar(MOGLOCKER_PLAYERVAR_ACCESS_TYPE, accessType)
    return accessType
end

-- Gets the mog locker access type (all areas or Alzahbi only). Returns the new access type.
function getMogLockerAccessType(player)
    return player:getCharVar(MOGLOCKER_PLAYERVAR_ACCESS_TYPE)
end

-- Adds time to your mog locker, given the number of bronze coins. The amount of time per bronze is affected by the access type.
-- The expiry time itself is the number of seconds past 2001/12/31 15:00. Returns true if time was added successfully, false otherwise.
function addMogLockerExpiryTime(player, numBronze)
    local accessType = getMogLockerAccessType(player)
    local numDaysPerBronze = 5
    if accessType == MOGLOCKER_ACCESS_TYPE_ALZAHBI then
        numDaysPerBronze = 7
    end

    local currentTs = getMogLockerExpiryTimestamp(player)
    if currentTs == nil then
        -- print("Unable to add time: player hasn't unlocked mog locker.")
        return false
    end

    if currentTs == -1 then
        currentTs = os.time() - MOGLOCKER_START_TS
    end

    local timeIncrease = 60 * 60 * 24 * numDaysPerBronze * numBronze
    local newTs = currentTs + timeIncrease

    player:setCharVar(MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP, newTs)
    -- Send an inventory size packet to enable the items if they weren't
    player:changeContainerSize(tpz.inv.MOGLOCKER, 0)
    return true
end

-- Gets the expiry time for your locker. A return value of -1 is expired. A return value of nil means mog locker hasn't been unlocked.
function getMogLockerExpiryTimestamp(player)
    local expiryTime = player:getCharVar(MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP)

    if (expiryTime == 0) then
        return nil
    end

    local now = os.time() - MOGLOCKER_START_TS
    if now > expiryTime then
        player:setCharVar(MOGLOCKER_PLAYERVAR_EXPIRY_TIMESTAMP, -1)
        return -1
    end

    return expiryTime
end
