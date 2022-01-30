---------------------------------------------------
--
-- Logic for Nyzul Isle Armoury Crates
--
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/instance")
require("scripts/globals/npc_util")
require("scripts/globals/nyzul_isle_data")
require("scripts/globals/appraisal")
local ID = require("scripts/zones/Nyzul_Isle/IDs")

---------------------------------------------------
tpz = tpz or {}
tpz.nyzul_isle_armoury_crates = tpz.nyzul_isle_armoury_crates or {}

--------------------------------------------------------
-- Constants for configuring randomness
--------------------------------------------------------
local ARMOURY_CRATE_CHANCE = 5 -- chance for a non-NM to drop an Armoury Crate with temp items
local numTempItemsInFreeFloorChance = {100, 95, 75, 50, 30, 20, 10, 5} -- chance to see 1, 2, 3... 8, items in a chest on a free floor

--------------------------------------------------------
-- Constants
--------------------------------------------------------
local NM_START_ID = 17092824
local NM_STOP_ID = 17092913

--------------------------------------------------------
--  Local data tables
--------------------------------------------------------

local tempItems = {
    4146, -- Revitalizer (available in chests in addition to all the buyable temps)
    4147, -- Body Boost
    4200, -- Mana Boost
    5385, -- Barbarian
    5386, -- Fighter
    5387, -- Oracle
    5388, -- Assasin
    5389, -- Spy
    5390, -- Braver
    5391, -- Soldier
    5392, -- Champion
    5393, -- Monarch
    5394, -- Gnostic
    5395, -- Cleric
    5396, -- Shepard
    5397, -- Sprinter
    5431, -- Dusty Poition
    5432, -- Dusty Ether
    5433, -- Dusty Elixir
    5434, -- Fanatics
    5435, -- Fools 
    5436, -- Dusty Reraise
    5437, -- Strange Milk
    5438, -- Strange Juice
    5439, -- Vicars
    5440, -- Dusty Wing
}

local appraisalMappings = {
    [17092824] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_BAT_EYE},
    [17092825] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_SHADOW_EYE},
    [17092826] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_BOMB_KING},
    [17092827] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_JUGGLER_HECATOMB},
    [17092828] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_SMOTHERING_SCHMIDT},
    [17092829] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_HELLION},
    [17092830] = {id = tpz.appraisalUtil.questionMarkItems.FOOTWEAR, appraisal = tpz.appraisalUtil.Origin.NYZUL_LEAPING_LIZZY},
    [17092831] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT},
    [17092832] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_JAGGEDY_EARED_JACK},
    [17092833] = {id = tpz.appraisalUtil.questionMarkItems.FOOTWEAR, appraisal = tpz.appraisalUtil.Origin.NYZUL_CACTUAR_CANTAUTOR},
    [17092834] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_GARGANTUA},
    [17092835] = {id = tpz.appraisalUtil.questionMarkItems.BOW, appraisal = tpz.appraisalUtil.Origin.NYZUL_GYRE_CARLIN},
    [17092836] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_ASPHYXIATED_AMSEL},
    [17092837] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_FROSTMANE},
    [17092838] = {id = tpz.appraisalUtil.questionMarkItems.GLOVES, appraisal = tpz.appraisalUtil.Origin.NYZUL_PEALLAIDH},
    [17092839] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_CARNERO},
    [17092840] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_FALCATUS_ARANEI},
    [17092841] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_EMERGENT_ELM},

    [17092842] = {id = tpz.appraisalUtil.questionMarkItems.CAPE, appraisal = tpz.appraisalUtil.Origin.NYZUL_OLD_TWO_WINGS},
    [17092843] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_AIATAR},
    [17092844] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_INTULO},
    [17092845] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_ORCTRAP},
    [17092846] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_VALKURM_EMPEROR},
    [17092847] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_CRUSHED_KRAUSE},
    [17092848] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_STINGING_SOPHIE},
    [17092849] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_SERPOPARD_ISHTAR},
    [17092850] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_WESTERN_SHADOW},
    [17092851] = {id = tpz.appraisalUtil.questionMarkItems.SHIELD, appraisal = tpz.appraisalUtil.Origin.NYZUL_BLOODTEAR_BALDURF},
    [17092852] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_ZIZZY_ZILLAH},
    [17092853] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_ELLYLLON},
    [17092854] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_MISCHIEVOUS_MICHOLAS},
    [17092855] = {id = tpz.appraisalUtil.questionMarkItems.EARRING, appraisal = tpz.appraisalUtil.Origin.NYZUL_LEECH_KING},
    [17092856] = {id = tpz.appraisalUtil.questionMarkItems.BOW, appraisal = tpz.appraisalUtil.Origin.NYZUL_EASTERN_SHADOW},
    [17092857] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_NUNYENUNC},
    [17092858] = {id = tpz.appraisalUtil.questionMarkItems.BOW, appraisal = tpz.appraisalUtil.Origin.NYZUL_HELLDIVER},
    [17092859] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TAISAIJIN},

    [17092860] = {id = tpz.appraisalUtil.questionMarkItems.SHIELD, appraisal = tpz.appraisalUtil.Origin.NYZUL_FUNGUS_BEETLE},
    [17092861] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_FRIAR_RUSH},
    [17092862] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_PULVERIZED_PFEFFER},
    [17092863] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_ARGUS},
    [17092864] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_BLOODPOOL_VORAX},
    [17092865] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_NIGHTMARE_VASE},
    [17092866] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_DAGGERCLAW_DRACOS},
    [17092867] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_NORTHERN_SHADOW},
    [17092868] = {id = tpz.appraisalUtil.questionMarkItems.CAPE, appraisal = tpz.appraisalUtil.Origin.NYZUL_FRAELISSA},
    [17092869] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_ROC},
    [17092870] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_SABOTENDER_BAILARIN},
    [17092871] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_AQUARIUS},
    [17092872] = {id = tpz.appraisalUtil.questionMarkItems.GLOVES, appraisal = tpz.appraisalUtil.Origin.NYZUL_ENERGETIC_ERUCA},
    [17092873] = {id = tpz.appraisalUtil.questionMarkItems.CAPE, appraisal = tpz.appraisalUtil.Origin.NYZUL_SPINY_SPIPI},
    [17092874] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TRICKSTER_KINETIX},
    [17092875] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_DROOLING_DAISY},
    [17092876] = {id = tpz.appraisalUtil.questionMarkItems.FOOTWEAR, appraisal = tpz.appraisalUtil.Origin.NYZUL_BONNACON},
    [17092877] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TAISAIJIN},

    [17092878] = {id = tpz.appraisalUtil.questionMarkItems.CAPE, appraisal = tpz.appraisalUtil.Origin.NYZUL_GOLDEN_BAT},
    [17092879] = {id = tpz.appraisalUtil.questionMarkItems.SHIELD, appraisal = tpz.appraisalUtil.Origin.NYZUL_STEELFLEECE_BALDARICH},
    [17092880] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_SABOTENDER_MARIACHI},
    [17092881] = {id = tpz.appraisalUtil.questionMarkItems.BOW, appraisal = tpz.appraisalUtil.Origin.NYZUL_UNGUR},
    [17092882] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_SWAMFISK},
    [17092883] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_BUBURIMBOO},
    [17092884] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_KEEPER_OF_HALIDOM},
    [17092885] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_SERKET},
    [17092886] = {id = tpz.appraisalUtil.questionMarkItems.NECKLACE, appraisal = tpz.appraisalUtil.Origin.NYZUL_DUNE_WIDOW},
    [17092887] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_ODQAN},
    [17092888] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_BURNED_BERGMANN},
    [17092889] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT},
    [17092890] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TYRANNIC_TUNNOK},
    [17092891] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_BLOODSUCKER},
    [17092892] = {id = tpz.appraisalUtil.questionMarkItems.FOOTWEAR, appraisal = tpz.appraisalUtil.Origin.NYZUL_TOTTERING_TOBY},
    [17092893] = {id = tpz.appraisalUtil.questionMarkItems.SHIELD, appraisal = tpz.appraisalUtil.Origin.NYZUL_SOUTHERN_SHADOW},
    [17092894] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_SHARP_EARED_ROPIPI},
    [17092895] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TAISAIJIN},

    [17092896] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_PANZER_PERCIVAL},
    [17092897] = {id = tpz.appraisalUtil.questionMarkItems.POLEARM, appraisal = tpz.appraisalUtil.Origin.NYZUL_VOUIVRE},
    [17092898] = {id = tpz.appraisalUtil.questionMarkItems.SASH, appraisal = tpz.appraisalUtil.Origin.NYZUL_JOLLY_GREEN},
    [17092899] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TUMBLING_TRUFFLE},
    [17092900] = {id = tpz.appraisalUtil.questionMarkItems.EARRING, appraisal = tpz.appraisalUtil.Origin.NYZUL_CAPRICIOUS_CASSIE},
    [17092901] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_AMIKIRI},
    [17092902] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_STRAY_MARY},
    [17092903] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_SEWER_SYRUP},
    [17092904] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_UNUT},
    [17092905] = {id = tpz.appraisalUtil.questionMarkItems.FOOTWEAR, appraisal = tpz.appraisalUtil.Origin.NYZUL_SIMURGH},
    [17092906] = {id = tpz.appraisalUtil.questionMarkItems.SHIELD, appraisal = tpz.appraisalUtil.Origin.NYZUL_PELICAN},
    [17092907] = {id = tpz.appraisalUtil.questionMarkItems.SWORD, appraisal = tpz.appraisalUtil.Origin.NYZUL_CARGO_CRAB_COLIN},
    [17092908] = {id = tpz.appraisalUtil.questionMarkItems.RING, appraisal = tpz.appraisalUtil.Origin.NYZUL_WOUNDED_WURFEL},
    [17092909] = {id = tpz.appraisalUtil.questionMarkItems.AXE, appraisal = tpz.appraisalUtil.Origin.NYZUL_PEG_POWLER},
    [17092910] = {id = tpz.appraisalUtil.questionMarkItems.DAGGER, appraisal = tpz.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT},
    [17092911] = {id = tpz.appraisalUtil.questionMarkItems.BOX, appraisal = tpz.appraisalUtil.Origin.NYZUL_JADED_JODY},
    [17092912] = {id = tpz.appraisalUtil.questionMarkItems.EARRING, appraisal = tpz.appraisalUtil.Origin.NYZUL_MAIGHDEAN_UAINE},
    [17092913] = {id = tpz.appraisalUtil.questionMarkItems.HEADPIECE, appraisal = tpz.appraisalUtil.Origin.NYZUL_TAISAIJIN},
}

------------------------------------------------------------------------------------------
-- Finds an available Armoury Crate NPC
-- returns the available crate NPC or nil if one is not available
------------------------------------------------------------------------------------------
local function getAvailableCrateNPC(mobIsNM, instance)
    local crateNPC = nil
    local possibleCrates = {}
    if mobIsNM then
        possibleCrates = tpz.nyzul_isle_data.npcLists.Armoury_Crates_For_NMs
    else
        possibleCrates = tpz.nyzul_isle_data.npcLists.Armoury_Crates
    end

    for _,v in pairs(possibleCrates) do
        local npc = GetNPCByID(v, instance)
        if (npc ~= nil and npc:getStatus() ~= tpz.status.NORMAL) then
            
            crateNPC = npc
            break
        end
    end
    return crateNPC
end

----------------------------------------------------------------------------------
-- Despawn the Crate and reset Local Vars
----------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.despawnArmouryCrate = function(npc)
    npc:resetLocalVars()
    npc:timer(1000, function(npc) npc:entityAnimationPacket("kesu") end)
    npc:timer(2000, function(npc) npc:setStatus(tpz.status.DISAPPEAR) end)
end

----------------------------------------------------------------------------------
--  Will return the item from the crate by index - or 0
----------------------------------------------------------------------------------
local function getTempItemFromCrate(npc, index)
    local tempItems = {}
    local crateItemVarName
    local itemID = 0
    
    for i=1,8 do
        crateItemVarName = string.format("Nyzul_CrateItem" ..i.. "")
        itemID = npc:getLocalVar(crateItemVarName)
        if (itemID > 0) then
            table.insert(tempItems, itemID)
        end
    end

    if (#tempItems == 0 or index > #tempItems) then
        return 0
    end

    return tempItems[index]
end

----------------------------------------------------------------------------------
--  Will remove the item crate
----------------------------------------------------------------------------------
local function removeTempItemFromCrate(npc, itemIDToRemove)
    local tempItems = {}
    local crateItemVarName
    local itemID = 0

    for i=1,8 do
        crateItemVarName = string.format("Nyzul_CrateItem" ..i.. "")
        itemID = npc:getLocalVar(crateItemVarName)
        if (itemID == itemIDToRemove) then
            npc:setLocalVar(crateItemVarName, 0)
            break
        end
    end
end

----------------------------------------------------------------------------------
-- Checks if a temp item crate is empty and despawns if it is
----------------------------------------------------------------------------------
local function checkTempItemChestIsEmpty(npc)
    local item1 = npc:getLocalVar("Nyzul_CrateItem1")
    local item2 = npc:getLocalVar("Nyzul_CrateItem2")
    local item3 = npc:getLocalVar("Nyzul_CrateItem3")
    local item4 = npc:getLocalVar("Nyzul_CrateItem4")
    local item5 = npc:getLocalVar("Nyzul_CrateItem5")
    local item6 = npc:getLocalVar("Nyzul_CrateItem6")
    local item7 = npc:getLocalVar("Nyzul_CrateItem7")
    local item8 = npc:getLocalVar("Nyzul_CrateItem8")

    if (item1 == 0 and item2 == 0 and item3 == 0 and item4 == 0 and
        item5 == 0 and item6 == 0 and item7 == 0 and item8 == 0) then
        tpz.nyzul_isle_armoury_crates.despawnArmouryCrate(npc)
    end
end

------------------------------------------------------------------------------------------
-- Spawns an Armoury Crate if required (NM) or by chance on mob death
------------------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.spawnArmouryCrateOnMobDeath = function (mob, x, y, z, r)
    local mobIsNM = mob:isNM()
    local npc = getAvailableCrateNPC(mobIsNM, mob:getInstance())
    local spawnChest = false
    
    if npc == nil then
        return
    end

    npc:resetLocalVars()
    npc:setAnimation(0)
    npc:AnimationSub(12)

    if (mobIsNM and mob:getID() >= NM_START_ID and mob:getID() <= NM_STOP_ID) then
        npc:setLocalVar("Nyzul_CrateNmId", mob:getID())
        spawnChest = true
    elseif (math.random(100) <= ARMOURY_CRATE_CHANCE and not mobIsNM) then
        npc:setLocalVar("Nyzul_CrateItem1", tempItems[math.random(#tempItems)])
        spawnChest = true
    end

    if(spawnChest) then
        npc:setPos(x, y, z, r)
        npc:setStatus(tpz.status.NORMAL)
        npc:entityAnimationPacket("deru")
    end

end

------------------------------------------------------------------------------------------
-- Spawns an Armoury Crate for a Free Floor
------------------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.spawnArmouryCrateForFreeFloor = function (instance, spawnPoint)
    local npc = getAvailableCrateNPC(false, instance)
    
    if npc == nil then
        return
    end

    npc:resetLocalVars()
    npc:setAnimation(0)
    npc:AnimationSub(12)

    local numItemsRandom = math.random(100)
    local tempItemsLeft = {}

    for _,value in pairs(tempItems) do
        table.insert(tempItemsLeft, value)
    end

    for i=1,8 do
        if (numItemsRandom <= numTempItemsInFreeFloorChance[i]) then
            local crateItemVarName = string.format("Nyzul_CrateItem" ..i.. "")
            local crateItemIndex = math.random(#tempItemsLeft)
            local crateItemID = tempItemsLeft[crateItemIndex]
            npc:setLocalVar(crateItemVarName, crateItemID)
            table.remove(tempItemsLeft, crateItemIndex)
        else
            break
        end
    end

    npc:setPos(spawnPoint.x, spawnPoint.y, spawnPoint.z, math.random(1, 359))
    npc:setStatus(tpz.status.NORMAL)
    npc:entityAnimationPacket("deru")
end

------------------------------------------------------------------------------------------
-- Called when an armoury crate is triggered
------------------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.onTrigger = function(player, npc)
    local nmCrateID = npc:getLocalVar("Nyzul_CrateNmId")
    if(npc:AnimationSub() ~= 13) then
        npc:AnimationSub(13)
    end

    if(nmCrateID > 0) then
        local chars = player:getInstance():getChars()
        if (npc:getLocalVar("Nyzul_CrateNmId") > 0 and player:addItem(appraisalMappings[nmCrateID])) then
            for _, v in pairs(chars) do
                v:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, appraisalMappings[nmCrateID].id)
            end
            tpz.nyzul_isle_armoury_crates.despawnArmouryCrate(npc)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, appraisalMappings[nmCrateID].id)
        end
    else
        local locked = npc:getLocalVar("Nyzul_ArmouryCrateLock")
        if (locked > 0) then
            player:PrintToPlayer("Armoury Crates are locked while players are using the Rune Of Transfer.", 0x1F)
            return
        end

        local item1 = getTempItemFromCrate(npc, 1)
        local item2 = 0
        if (item1 > 0) then item2 = getTempItemFromCrate(npc, 2) end
        local item3 = 0
        if (item2 > 0) then item3 = getTempItemFromCrate(npc, 3) end
        local item4 = 0
        if (item3 > 0) then item4 = getTempItemFromCrate(npc, 4) end
        local item5 = 0
        if (item4 > 0) then item5 = getTempItemFromCrate(npc, 5) end
        local item6 = 0
        if (item5 > 0) then item6 = getTempItemFromCrate(npc, 6) end
        local item7 = 0
        if (item6 > 0) then item7 = getTempItemFromCrate(npc, 7) end
        local item8 = 0
        if (item7 > 0) then item8 = getTempItemFromCrate(npc, 8) end
        local quantity = 1 -- sticking with 1 for now - can expand to add multiples later
        local bitshiftedQuantity = bit.lshift(quantity, 16) -- message params are split between hi and lo words. The top 16 bits are quantity.  The bottom 16 bits are the item id

        local param1 = 0
        local param2 = 0
        local param3 = 0
        local param4 = 0
        local param5 = 0
        local param6 = 0
        local param7 = 0
        local param8 = 0

        if(item1 > 0) then param1 = bitshiftedQuantity + item1 end
        if(item2 > 0) then param2 = bitshiftedQuantity + item2 end
        if(item3 > 0) then param3 = bitshiftedQuantity + item3 end
        if(item4 > 0) then param4 = bitshiftedQuantity + item4 end
        if(item5 > 0) then param5 = bitshiftedQuantity + item5 end
        if(item6 > 0) then param6 = bitshiftedQuantity + item6 end
        if(item7 > 0) then param7 = bitshiftedQuantity + item7 end
        if(item8 > 0) then param8 = bitshiftedQuantity + item8 end

        player:startEvent(2, param1, param2, param3, param4, param5, param6, param7, param8)
        --giveTempItem
    end
    
end

------------------------------------------------------------------------------------------
-- Called when an armoury event is updated (which is never)
------------------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.onEventUpdate = function(player, csid, option)
end

------------------------------------------------------------------------------------------
-- Called when an armoury event is finished
------------------------------------------------------------------------------------------
tpz.nyzul_isle_armoury_crates.onEventFinish = function(player, csid, option)
    local npc = player:getEventTarget()
    
    if (csid == 2 and option >= 1 and option <= 8) then
        local tempItemID = getTempItemFromCrate(npc, option)

        if tempItemID == 0 then
            return -- possibly multiple players trying to get the same item
        end

        if player:hasItem(tempItemID, 3) then
            player:messageSpecial(ID.text.ALREADY_HAVE_TEMP)
            return 
        elseif (player:addTempItem(tempItemID)) then
            removeTempItemFromCrate(npc, tempItemID)
            checkTempItemChestIsEmpty(npc)
            local chars = player:getInstance():getChars()
            for _, v in pairs(chars) do
                v:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, tempItemID)
            end
        end
    end
end