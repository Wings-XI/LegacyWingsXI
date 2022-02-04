-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghanraam
-- Type: "Nyzul Weapon/Salvage Armor Storer, "
-- !pos 108.773 -6.999 -51.297 50
-- ToDo event 816 - 7 tells the player that they have stored all armor pieces - this is not implemented yet
-- ToDo event 816 - 8 tells a player that they already own the armor they are trying to craft - this is not implemented yet
-----------------------------------
require("scripts/globals/equipment")
require("scripts/globals/npc_util")
-----------------------------------

--[[
    IMPORTANT NOTE: According to wiki - on retail Ghanraam can only store 1 set of armor components at a time.  I did not find support
                    for this in the dissassembled events or string tables.  Therefore I have implemented Ghanraam to be able to store
                    all 5 armor sets at once.
                    Players must change the active set by talking with Ghranraam to with in order to change what armor set can be retrieved or crafted.
                    Additional PrintToPlayer messaging can be added if testing finds this to be non-obvious.

    Potential problem scenario introduced by allowing storage of all 5 sets:
        - Player has Usukane selected as the current armor set
        - Player has all 3 armor pieces stored to make Usukane Head
        - Player has 2/3 armor pieces stored to make Ares Head
        - Player gets their Ares Head Drop from salvage, rushes to Ghanraam and trades it in.
        - Ghanraam tells they player they now have all the Ares Head pieces!  Excitement!
        - Player trades mats to craft _a head piece_ to Ghanraam
        - Ghanraam tells the player "congrats, your USUKANE head will be ready soon"
        - Player is mad, they meant to craft Ares

        - We could change the current set whenever a player trades in an armor piece - but is that better?
]]

--[[
    CS List
    - 814 - Introduction CS
    - 815 - Default - info/retrieve
    - 826 - Your armor is being crafted.
    - 827 - Here is your completed armor. 
    - 893 - Introduction to weapons CS
    - 816 - Extremely flexible CS based on param 2
      - Param 0 - Ares-0/Skadi-1/Usukane-2/Marduk-3/Morrigan-4
      - Param 1 - Head-0/Body-1/Hands-2/Legs-3/Feet-4
      - Param 2 - Message
        - 0  - Invalid
        - 1  - "I see you have all the items required for the <set> <slot>." - Perhpas when trading in the last of the 3 piece set
        - 2  - "This is most certainly armor from the Ruins of Alzadaal. Soon you will have all the items required to create the <set> <slot>." - Perhaps when trading anything _but_ the last of 3 piece set
        - 3  - "You have yet to bring me all of the necessary items.<07>I will ask for my fee once you have everything ready." - Perhaps if you try to trade currency/mats early?
        - 4  - "I will require the entire fee all at once, if you would be so kind." - perhaps if the trade doesnt match any material amounts
        - 5  - "Yes, this should cover my expenses for ordering the <set> <slot>.   I will set the artisans to work at once." - perhaps traded the correct currency
        - 6  - "Please, I do not wish to cheapen the value of my gallery with multiple displays of the same armor." - Trading armor already stored
        - 7  - "My gallery is now fit to bursting with rare and wondrous armor.<07>I feel positively dizzy. I suppose it is time for you to prepare my fee." - Perhaps when you trade him all pieces for all armour?
        - 8  - "These are the items required to create the <set> <slot>.  But it appears, my greedy friend, that you already own this particular part." - Perhaps when you own the item that corresponds to the traded items
        - 9  - "I have not a single spare display case remaining, I'm afraid. My collection of legendary weapons is perfect and complete!<07>I must say, the daily care of these artifacts is quite demanding...though I do love it so!" - Perhaps when all weapons are traded in
        - 10 - "That weapon already graces my gallery, my treasure-hunting friend. I need but one of each!" - When trading a weapon already stored
        - 11 - "This is a weapon found in the ruins!? Simply breathtaking!" - Traded a weapon and accepted (with fee)
        - 12 - "Like I've told you before, I typically only store pieces of armor in my gallery. The special attention and care a fine weapon requires will cost you an extra <currency>" - Trade a weapon w/o fee
]]

local function checkForWeapon(trade, withCurrency)
    local IMPERIAL_BRONZE_PIECE = 2184
    local itemsToCheckFor = {}
    -- create table of traded items, with key/val of itemId/itemQty
    for weaponIndex = 1, 20 do
        itemsToCheckFor = {}
        table.insert(itemsToCheckFor, BaseNyzulWeapons[weaponIndex])
        if (withCurrency) then
            table.insert(itemsToCheckFor, IMPERIAL_BRONZE_PIECE)
        end

        if npcUtil.tradeHasExactly(trade, itemsToCheckFor) then
            return weaponIndex
        end
    end

    return 0
end

local function checkForArmor(trade)
    for armorSet = 1, 5 do
        for armorIndex = 1, 15 do
            if (armorSet == 1) then
                if npcUtil.tradeHasExactly(trade, AresComponents[armorIndex]) then
                    return armorIndex, armorSet
                end
            elseif (armorSet == 2) then
                if npcUtil.tradeHasExactly(trade, SkadiComponents[armorIndex]) then
                    return armorIndex, armorSet
                end
            elseif (armorSet == 3) then
                if npcUtil.tradeHasExactly(trade, UsukaneComponents[armorIndex]) then
                    return armorIndex, armorSet
                end
            elseif (armorSet == 4) then
                if npcUtil.tradeHasExactly(trade, MardukComponents[armorIndex]) then
                    return armorIndex, armorSet
                end
            elseif (armorSet == 5) then
                if npcUtil.tradeHasExactly(trade, MorriganComponents[armorIndex]) then
                    return armorIndex, armorSet
                end
            end
        end
    end

    return 0, 0
end


local function getStoredArmorByArmorSet(player, armorSet)
    local storedArmor = 0

    -- Retail has a limitation to only allow storage of one armor set at a time
    -- I think we can relax that limit and allow storage of all

    if (armorSet == 1) then
        storedArmor = player:getCharVar("Ghanraam_StoredAres")
    elseif (armorSet == 2) then
        storedArmor = player:getCharVar("Ghanraam_StoredSkadi")
    elseif (armorSet == 3) then
        storedArmor = player:getCharVar("Ghanraam_StoredUsukane")
    elseif (armorSet == 4) then
        storedArmor = player:getCharVar("Ghanraam_StoredMarduk")
    elseif (armorSet == 5) then
        storedArmor = player:getCharVar("Ghanraam_StoredMorrigan")
    end

    return storedArmor
end

local function setStoredArmorByArmorSet(player, armorSet, newStoredArmor)

    -- Retail has a limitation to only allow storage of one armor set at a time
    -- I think we can relax that limit and allow storage of all

    if (armorSet == 1) then
        player:setCharVar("Ghanraam_StoredAres", newStoredArmor)
    elseif (armorSet == 2) then
        player:setCharVar("Ghanraam_StoredSkadi", newStoredArmor)
    elseif (armorSet == 3) then
        player:setCharVar("Ghanraam_StoredUsukane", newStoredArmor)
    elseif (armorSet == 4) then
        player:setCharVar("Ghanraam_StoredMarduk", newStoredArmor)
    elseif (armorSet == 5) then
        player:setCharVar("Ghanraam_StoredMorrigan", newStoredArmor)
    end
end

local function getEquipSlotByArmorIndex(armorIndex)
    if (armorIndex >= 1 and armorIndex <= 3) then
        return 1 -- Head
    elseif (armorIndex >= 4 and armorIndex <= 6) then
        return 2 -- Body
    elseif (armorIndex >= 7 and armorIndex <= 9) then
        return 3 -- Hands
    elseif (armorIndex >= 10 and armorIndex <= 12) then
        return 4 -- Legs
    elseif (armorIndex >= 13 and armorIndex <= 15) then
        return 5 -- Feet
    end
end

local function isArmorPieceComplete(player, armorSet, equipSlot)
    local storedArmor = getStoredArmorByArmorSet(player, armorSet)
    -- armor is stored sequentially, 15 at x, 25 at x +1, 35 at x+2
    local upperBound = equipSlot * 3
    local lowerBound = upperBound - 2

    for index = lowerBound, upperBound do
        if (bit.band(storedArmor, bit.lshift(1, index - 1)) == 0) then
            -- a piece is missing
            return false
        end
    end

    return true
end

local function checkForMaterialsAndCurrency(trade)
    local materials = {
        747,  -- Orichalcum Ingot     - Head
        686,  -- Imperial Wootz Ingot - Body
        730,  -- Bloodwood Lumber    - Hands
        2289, -- Wamoura Cloth        - Legs
        2152, -- Marid Leather        - Feet
    }
    local IMPERIAL_GOLD_PIECE = 2187 -- all

    local equipSlot = 0
    local completeMatsAndCurrency = false
    -- check for 6 of any crafting mat
    for material = 1, 5 do
        if (npcUtil.tradeHas(trade, {{materials[material], 6}}, false, false)) then
            if (completeMatsAndCurrency == false) then
                completeMatsAndCurrency = true
                -- the index of material corresponds to Head/Body/Hands/Legs/Feet
                equipSlot = material
            else
                -- We have found multiple sets of materials - bail out
                equipSlot = 0
                completeMatsAndCurrency = false
                return 0, completeMatsAndCurrency
            end
        end
    end
    -- check for 10 IMPERIAL_GOLD_PIECE iff the material check passed
    if (completeMatsAndCurrency and (equipSlot > 0)) then
        if (not npcUtil.tradeHasExactly(trade, {{materials[equipSlot], 6},{IMPERIAL_GOLD_PIECE, 10}})) then
            equipSlot = 0
            completeMatsAndCurrency = false
        end
    end

    return equipSlot, completeMatsAndCurrency
end

local function getSalvageArmorBySetAndEquipSlot(armorSet, equipSlot)
    if (armorSet == 1) then
        return AresArmorSet[equipSlot]
    elseif (armorSet == 2) then
        return SkadiArmorSet[equipSlot]
    elseif (armorSet == 3) then
        return UsukaneArmorSet[equipSlot]
    elseif (armorSet == 4) then
        return MardukArmorSet[equipSlot]
    elseif (armorSet == 5) then
        return MorriganArmorSet[equipSlot]
    end
end

local function removeStoredPiecesForCrafting(player, armorSet, equipSlot)
    local storedArmor = getStoredArmorByArmorSet(player, armorSet)
    local upperBound = equipSlot * 3
    local lowerBound = upperBound - 2

    for index = lowerBound, upperBound do
        storedArmor = bit.bxor(storedArmor, bit.lshift(1, index - 1))
    end
    setStoredArmorByArmorSet(player, armorSet, storedArmor)
end

function onTrade(player, npc, trade)

    local ALL_WEAPONS = 1048575
    local currentSet = player:getCharVar("Ghanraam_CurrentSet")

    -- Only accept trades if players have gotten both basic introductions
    if ((player:getCharVar("Ghanraam_BasicIntro") > 0) and (player:getCharVar("Ghanraam_WeaponIntro") > 0)) then
        if (player:getCharVar("Ghanraam_CraftingInProgress") > 0) then
            -- if a crafting is in progress - Ghanraam ignores attempts to do anything else per wiki
            player:startEvent(826)
        end

        local weaponIndex = 0
        local armorIndex = 0
        local armorSet = 0
        
        -- weapon with no currency 
        weaponIndex = checkForWeapon(trade, false)
        if (weaponIndex > 0) then
            -- remind the player of the fee and weaponskill points wipe
            player:startEvent(816, 0, 0, 12)
            -- handled a weapon
            return
        end

        -- weapon with currency
        weaponIndex = checkForWeapon(trade, true)
        if (weaponIndex > 0) then
            local storedWeapons = player:getCharVar("Ghanraam_StoredWeapons")
            if (bit.band(storedWeapons, weaponIndex) > 0) then
                -- player has this weapon stored
                player:startEvent(816, 0, 0, 10)
            else
                -- accept trade, update storage
                player:setCharVar("Ghanraam_StoredWeapons", bit.bxor(storedWeapons, (bit.lshift(1, weaponIndex - 1))))
                player:confirmTrade()
                if (player:getCharVar("Ghanraam_StoredWeapons") == ALL_WEAPONS) then
                    -- all weapons have been stored
                    player:startEvent(816, 0, 0, 9)
                else
                    -- the weapon is stored
                    player:startEvent(816, 0, 0, 11)
                end
            end
            -- handled a weapon
            return
        end

        armorIndex, armorSet = checkForArmor(trade)
        -- trade contains a single armor
        if (armorIndex > 0) then
            local storedArmor = getStoredArmorByArmorSet(player, armorSet)
            if (bit.band(storedArmor, bit.lshift(1, armorIndex - 1)) > 0) then
                -- trade has armor but already stored
                player:startEvent(816, 0, 0, 6)
            else
                -- update storage, accept trade
                setStoredArmorByArmorSet(player, armorSet, bit.bxor(storedArmor, (bit.lshift(1, armorIndex - 1))))
                player:confirmTrade()
                local equipSlot = getEquipSlotByArmorIndex(armorIndex)

                if (isArmorPieceComplete(player, armorSet, equipSlot)) then
                    -- Armor completed a piece
                    player:startEvent(816, armorSet - 1, equipSlot - 1, 1)
                else
                    -- Armor does not complete a piece
                    player:startEvent(816, armorSet - 1, equipSlot - 1, 2)
                end

                if (currentSet == 0) then
                    -- since the player traded us an armor piece and has never chosen an armor set, lets pick the set associated with the piece
                    player:setCharVar("Ghanraam_CurrentSet", armorSet)
                end
            end
            -- handled an armor
            return
        end

        local equipSlot = 0
        local completeMatsAndCurrency = false
        -- checking for currency and mats
        equipSlot, completeMatsAndCurrency = checkForMaterialsAndCurrency(trade)

        if (currentSet > 0 and completeMatsAndCurrency) then
            -- mats are complete for an equipSlot and there is a selected armor set
            if (isArmorPieceComplete(player, currentSet, equipSlot)) then
                -- all mats in trade and all 3 pieces stored
                -- remove 3 pieces from storage
                removeStoredPiecesForCrafting(player, currentSet, equipSlot)
                -- get item ID to craft
                local itemToBeCrafted = getSalvageArmorBySetAndEquipSlot(currentSet, equipSlot)
                player:confirmTrade()
                player:setCharVar("Ghanraam_CraftingInProgress", itemToBeCrafted)
                -- in era pickup is Midnight
                player:setCharVar("Ghanraam_PickUp", JstMidnight())
                player:startEvent(816, currentSet - 1, equipSlot - 1, 5)
            else
                -- all 3 pieces not stored 
                player:startEvent(816, currentSet - 1, equipSlot - 1, 3)
            end
        else
            -- this acts as the default catchall for trading anything other than correct combinations
            player:startEvent(816, 0, 0, 4)
        end
    end
end

function onTrigger(player, npc)
    local firstIntro = player:getCharVar("Ghanraam_BasicIntro")
    local weaponIntro = player:getCharVar("Ghanraam_WeaponIntro")
    local selectedArmorSet = player:getCharVar("Ghanraam_CurrentSet")
    local craftingInProgress = player:getCharVar("Ghanraam_CraftingInProgress")
    local pickupReady = player:getCharVar("Ghanraam_PickUp") < os.time()

    if (firstIntro == 0) then
        player:startEvent(814)
    elseif (weaponIntro == 0) then
        player:startEvent(893)
    elseif ((craftingInProgress > 0) and (not pickupReady)) then
        -- if a crafting is in progress - Ghanraam ignores attempts to do anything else per wiki
        player:startEvent(826)
    elseif ((craftingInProgress > 0) and pickupReady) then
        player:startEvent(827)
    else
        -- Param 1 = selected set
        player:startEvent(815, 0, selectedArmorSet)
    end
end

local function sendEventUpdateForWeapons(player)
    local storedWeapons = player:getCharVar("Ghanraam_StoredWeapons")
    local isWeaponStored = 0
    if (storedWeapons > 0) then
        isWeaponStored = 1
    end
    -- Weapons are broken up by page. 8 on the firt and second page, 4 on the last.
    local storedWeaponsPage1 = bit.band(storedWeapons, 255)
    local storedWeaponsPage2 = bit.band(bit.rshift(storedWeapons, 8), 255)
    local storedWeaponsPage3 = bit.rshift(storedWeapons, 16)

    player:updateEvent(storedWeaponsPage1, storedWeaponsPage2, storedWeaponsPage3, isWeaponStored)
end

local function sendEventUpdateForSetSelection(player, selectedSet)
    -- ToDo:  There is another updateEvent we can send which triggers "It appears you already have this armor on your person." - perhaps this for players who have completed an entire armor set?
    local currentSet = player:getCharVar("Ghanraam_CurrentSet")
    if (currentSet == 0) then
        -- no selected set - good to go - return param 1 as 0
        player:setCharVar("Ghanraam_CurrentSet", selectedSet)
        player:updateEvent(0, 0)
    elseif (currentSet == selectedSet) then
        -- This is set the player already has selected - return param 1 as the selected set
        player:updateEvent(0, selectedSet)
    else
        -- player wants to change sets - return param0 as the current set (starting from 0) and param1 as not-0, not 1-5, and not 6.  So 7 is safe
        player:updateEvent(currentSet - 1, 7)
    end
end

local function getSalvageCompoenentItemID(armorIndex, currentSet)
    if (currentSet == 1) then
        return AresComponents[armorIndex]
    elseif (currentSet == 2) then
        return SkadiComponents[armorIndex]
    elseif (currentSet == 3) then
        return UsukaneComponents[armorIndex]
    elseif (currentSet == 4) then
        return MardukComponents[armorIndex]
    elseif (currentSet == 5) then
        return MorriganComponents[armorIndex]
    end
end

local function sendEventUpdateForArmor(player)
    local currentSet = player:getCharVar("Ghanraam_CurrentSet")
    if (currentSet == 0) then
        -- no armor set selected yet
        player:updateEvent(0, 0, 0, 0)
    end
    local storedArmor = getStoredArmorByArmorSet(player, currentSet)

    local isArmorStored = 0
    if (storedArmor > 0) then
        isArmorStored = 1
    end

    local storedArmorPage1 = bit.band(storedArmor, 255)
    local storedArmorPage2 = bit.rshift(storedArmor, 8)
    -- param 0 = first 8
    -- param 1 = next 7
    -- param 2 = armor set 1/2/3/4/5
    -- param 3 = any armor stored? 0 = no

    player:updateEvent(storedArmorPage1, storedArmorPage2, currentSet, isArmorStored)
end

function onEventUpdate(player, csid, option)
    if (csid == 815 and option == 1) then
        -- selected Ares
       sendEventUpdateForSetSelection(player, 1)
    elseif (csid == 815 and option == 2) then
        -- changed to Ares from another
        player:setCharVar("Ghanraam_CurrentSet", 1)
    elseif (csid == 815 and option == 3) then
        -- selected Skadi
        sendEventUpdateForSetSelection(player, 2)
    elseif (csid == 815 and option == 4) then
        -- changed to Skadi from another
        player:setCharVar("Ghanraam_CurrentSet", 2)
    elseif (csid == 815 and option == 5) then
        -- selected Usukane
        sendEventUpdateForSetSelection(player, 3)
    elseif (csid == 815 and option == 6) then
        -- changed to Usukane from another
        player:setCharVar("Ghanraam_CurrentSet", 3)
    elseif (csid == 815 and option == 7) then
        -- selected Marduk
        sendEventUpdateForSetSelection(player, 4)
    elseif (csid == 815 and option == 8) then
        -- changed to Marduk from another
        player:setCharVar("Ghanraam_CurrentSet", 4)
    elseif (csid == 815 and option == 9) then
        -- selected Morrigan
        sendEventUpdateForSetSelection(player, 5)
    elseif (csid == 815 and option == 10) then
        -- changed to Morrigan from another
        player:setCharVar("Ghanraam_CurrentSet", 5)
    elseif (csid == 815 and option == 11) then
        -- Retrieve Armor Menu
        sendEventUpdateForArmor(player)
    elseif (csid == 815 and option == 27) then
        -- Retrieve Weapon Menu
        sendEventUpdateForWeapons(player)
    elseif (csid == 815 and option >= 12 and option <= 26) then
        -- Retrieve Armor
        local currentSet = player:getCharVar("Ghanraam_CurrentSet")
        local storedArmor = getStoredArmorByArmorSet(player, currentSet)
        local armorIndex = option - 11
        local itemRetrieved = getSalvageCompoenentItemID(armorIndex, currentSet)

        -- verify server side that the armor returned to the server is in fact stored
        if (bit.band(storedArmor, bit.lshift(1, armorIndex - 1)) > 0) then
            if (npcUtil.giveItem(player, itemRetrieved)) then
                local newStoredArmor = bit.bxor(storedArmor, bit.lshift(1, armorIndex - 1))
                setStoredArmorByArmorSet(player, currentSet, newStoredArmor)
            end
        end

    elseif (csid == 815 and option >= 28 and option <= 47) then
        -- Retrieve Weapon
        local storedWeapons = player:getCharVar("Ghanraam_StoredWeapons")
        local weaponJob = option - 27

        -- verify server side that the weapon returned to the server is in fact stored
        if (bit.band(storedWeapons, bit.lshift(1, weaponJob - 1)) > 0) then
            if (npcUtil.giveItem(player, BaseNyzulWeapons[weaponJob])) then
                local newStoredWeapons = bit.bxor(storedWeapons, bit.lshift(1, weaponJob - 1))
                player:setCharVar("Ghanraam_StoredWeapons", newStoredWeapons)
            end
        end

        sendEventUpdateForWeapons(player)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 814) then
        player:setCharVar("Ghanraam_BasicIntro", 1)
    elseif (csid == 893) then
        player:setCharVar("Ghanraam_WeaponIntro", 1)
    elseif (csid == 827) then
        -- Give player the item crafted
        local craftingInProgress = player:getCharVar("Ghanraam_CraftingInProgress")
        if (npcUtil.giveItem(player, craftingInProgress)) then
            player:setCharVar("Ghanraam_CraftingInProgress", 0)
        end
    end
end
