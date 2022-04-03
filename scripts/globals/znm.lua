-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper         : !additem 18721
-- Blank Soul Plate    : !additem 18722
-- Soultrapper 2000    : !additem 18724
-- Blank HS Soul Plate : !additem 18725
-- Soul Plate          : !additem 2477
-- Sanraku & Ryo       : !pos -127.0 0.9 22.6 50
-----------------------------------
-- require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
require("scripts/globals/pankration")
require("scripts/globals/utils")
---------------------------------------------------------------------------------
local FAUNA_LIMIT = 7500 -- Zeni handed out per Fauna (NM)
local SUBJECT_OF_INTEREST_LIMIT = 10000 -- Zeni handed out per SubjectsOfInterest
---------------------------------------------------------------------------------

local lures =
{
    2580, 2581, 2582, 2577, 2578, 2579, 2574, 2575, 2576,
    2573, 2590, 2591, 2592, 2587, 2588, 2589, 2584, 2585,
    2586, 2583, 2600, 2601, 2602, 2597, 2598, 2599, 2594,
    2595, 2596, 2593, 2572
}

local seals =
{
    tpz.ki.MAROON_SEAL, tpz.ki.MAROON_SEAL, tpz.ki.MAROON_SEAL,
    tpz.ki.APPLE_GREEN_SEAL,tpz.ki.APPLE_GREEN_SEAL,tpz.ki.APPLE_GREEN_SEAL,
    tpz.ki.CHARCOAL_GREY_SEAL, tpz.ki.DEEP_PURPLE_SEAL, tpz.ki.CHESTNUT_COLORED_SEAL,
    tpz.ki.LILAC_COLORED_SEAL,
    tpz.ki.CERISE_SEAL,tpz.ki.CERISE_SEAL,tpz.ki.CERISE_SEAL,
    tpz.ki.SALMON_COLORED_SEAL,tpz.ki.SALMON_COLORED_SEAL,tpz.ki.SALMON_COLORED_SEAL,
    tpz.ki.PURPLISH_GREY_SEAL, tpz.ki.GOLD_COLORED_SEAL, tpz.ki.COPPER_COLORED_SEAL,
    tpz.ki.BRIGHT_BLUE_SEAL,
    tpz.ki.PINE_GREEN_SEAL,tpz.ki.PINE_GREEN_SEAL,tpz.ki.PINE_GREEN_SEAL,
    tpz.ki.AMBER_COLORED_SEAL,tpz.ki.AMBER_COLORED_SEAL,tpz.ki.AMBER_COLORED_SEAL,
    tpz.ki.FALLOW_COLORED_SEAL,tpz.ki.TAUPE_COLORED_SEAL,tpz.ki.SIENNA_COLORED_SEAL,
    tpz.ki.LAVENDER_COLORED_SEAL
}

tpz = tpz or {}
tpz.znm = tpz.znm or {}

tpz.items = tpz.items or {}
tpz.items["BLANK_SOUL_PLATE"] = 18722
tpz.items["BLANK_HIGH_SPEED_SOUL_PLATE"] = 18725
tpz.items["SOUL_PLATE"] = 2477


tpz.znm.updatePopItemCosts = function()
    for k,item in pairs(lures) do
        local itemVarName = string.format("[ZNM]PopItemCost" ..item.. "")
        local currentUpcharge = GetServerVariable(itemVarName)
        if (currentUpcharge > 0) then
            SetServerVariable(itemVarName, currentUpcharge - 100)
        end
    end
end

-----------------------------------
-- Sanraku's Interests - Genus
-----------------------------------
tpz.znm.subjectsOfInterest = tpz.znm.subjectsOfInterest or {}
-- aquans
tpz.znm.subjectsOfInterest[0] = {75, 76, 77, 372, 400} -- crab 
tpz.znm.subjectsOfInterest[1] = {197} -- pugil
tpz.znm.subjectsOfInterest[2] = {218, 219} -- sea monk
tpz.znm.subjectsOfInterest[3] = {312, 191} -- orobon
-- amorphs
tpz.znm.subjectsOfInterest[4] = {396, 276, 258} -- worm
tpz.znm.subjectsOfInterest[5] = {172, 369} -- leech
tpz.znm.subjectsOfInterest[6] = {290, 66, 67, 228, 229, 230} -- slime
tpz.znm.subjectsOfInterest[7] = {299, 112} -- flan
-- arcana
tpz.znm.subjectsOfInterest[8] = {56, 82, 232} -- bomb
tpz.znm.subjectsOfInterest[9] = {68, 69} -- cluster bomb
-- undead
tpz.znm.subjectsOfInterest[10] = {52, 121} -- ghost
tpz.znm.subjectsOfInterest[11] = {88, 89, 227} -- skeleton
tpz.znm.subjectsOfInterest[12] = {86} -- doomed
-- vermin
tpz.znm.subjectsOfInterest[13] = {64, 293} -- chigoe
tpz.znm.subjectsOfInterest[14] = {235} -- spider
tpz.znm.subjectsOfInterest[15] = {48} -- bee
tpz.znm.subjectsOfInterest[16] = {79, 107, 108} -- crawler
tpz.znm.subjectsOfInterest[17] = {254, 289} -- wamoura larvae
tpz.znm.subjectsOfInterest[18] = {113, 374, 375} -- fly
tpz.znm.subjectsOfInterest[19] = {81} -- diremite
tpz.znm.subjectsOfInterest[20] = {217, 273, 274} -- scorpion
tpz.znm.subjectsOfInterest[21] = {253} -- wamoura
-- demon
tpz.znm.subjectsOfInterest[22] = {165, 166, 301} -- imp
-- dragon
tpz.znm.subjectsOfInterest[23] = {198, 286} -- puk
tpz.znm.subjectsOfInterest[24] = {266, 331, 278} -- wyvren
tpz.znm.subjectsOfInterest[25] = {298, 87} -- dragon
-- birds
tpz.znm.subjectsOfInterest[26] = {46} -- bat
tpz.znm.subjectsOfInterest[27] = {47} -- flock bat
tpz.znm.subjectsOfInterest[28] = {72, 287} -- colibri
tpz.znm.subjectsOfInterest[29] = {55} -- bird
tpz.znm.subjectsOfInterest[30] = {27, 294} -- apkallu
tpz.znm.subjectsOfInterest[31] = {70} -- cockatrice
-- beast
tpz.znm.subjectsOfInterest[32] = {167, 226} -- sheep
tpz.znm.subjectsOfInterest[33] = {242} -- tiger
tpz.znm.subjectsOfInterest[34] = {180, 371} -- marid
tpz.znm.subjectsOfInterest[35] = {208} -- ram
-- plantoid
tpz.znm.subjectsOfInterest[36] = {437, 216} -- sapling
tpz.znm.subjectsOfInterest[37] = {114} -- flytrap
tpz.znm.subjectsOfInterest[38] = {116} -- funguar
tpz.znm.subjectsOfInterest[39] = {464} -- treant
tpz.znm.subjectsOfInterest[40] = {296, 186} -- morbol
-- lizard
tpz.znm.subjectsOfInterest[41] = {438, 97, 174} -- lizard
tpz.znm.subjectsOfInterest[42] = {210, 376, 377} -- raptor
tpz.znm.subjectsOfInterest[43] = {58} -- bugard
tpz.znm.subjectsOfInterest[44] = {306, 257} -- wivre
-- elemental
tpz.znm.subjectsOfInterest[45] = {102} -- fire
tpz.znm.subjectsOfInterest[46] = {103} -- ice
tpz.znm.subjectsOfInterest[47] = {99} -- wind
tpz.znm.subjectsOfInterest[48] = {101} -- earth
tpz.znm.subjectsOfInterest[49] = {105} -- thunder
tpz.znm.subjectsOfInterest[50] = {106} -- water
tpz.znm.subjectsOfInterest[51] = {100} -- dark -- notably no light ele
-- beastmen
tpz.znm.subjectsOfInterest[52] = {184} -- moblin
tpz.znm.subjectsOfInterest[53] = {196, 297} -- poroggo 
tpz.znm.subjectsOfInterest[54] = {213} -- sahagin 
tpz.znm.subjectsOfInterest[55] = {305, 176, 285, 177} -- mamool ja
tpz.znm.subjectsOfInterest[56] = {310, 171, 469} -- lamia
tpz.znm.subjectsOfInterest[57] = {182} -- merrow
tpz.znm.subjectsOfInterest[58] = {288, 199} -- qiqirn
tpz.znm.subjectsOfInterest[59] = {308, 246, 326} -- troll
-- undead part 2
tpz.znm.subjectsOfInterest[60] = {203, 204, 205} -- qutrub
-- demon part 2
tpz.znm.subjectsOfInterest[61] = {233} -- soulflayer


tpz.znm.changeSubjectsOfInterest = function()
    local subjectsOfInterestKey = math.random(#tpz.znm.subjectsOfInterest)
    SetServerVariable("[ZNM]SubjectsOfInterest", subjectsOfInterestKey)
    SetServerVariable("[ZNM]SubOfInterestLimit", SUBJECT_OF_INTEREST_LIMIT)

    local ecosystem = tpz.ecosystem.ERROR
    if (subjectsOfInterestKey >= 0 and subjectsOfInterestKey <= 3) then
        ecosystem = tpz.ecosystem.AQUAN
    elseif (subjectsOfInterestKey >= 4 and subjectsOfInterestKey <= 7) then
        ecosystem = tpz.ecosystem.AMORPH
    elseif (subjectsOfInterestKey >= 8 and subjectsOfInterestKey <= 9) then
        ecosystem = tpz.ecosystem.ARCANA
    elseif (subjectsOfInterestKey >= 10 and subjectsOfInterestKey <= 12) or (subjectsOfInterestKey == 60) then
        ecosystem = tpz.ecosystem.UNDEAD
    elseif (subjectsOfInterestKey >= 13 and subjectsOfInterestKey <= 21) then
        ecosystem = tpz.ecosystem.VERMIN
    elseif (subjectsOfInterestKey == 22 or subjectsOfInterestKey == 61) then
        ecosystem = tpz.ecosystem.DEMON
    elseif (subjectsOfInterestKey >= 23 and subjectsOfInterestKey <= 25) then
        ecosystem = tpz.ecosystem.DRAGON
    elseif (subjectsOfInterestKey >= 26 and subjectsOfInterestKey <= 31) then
        ecosystem = tpz.ecosystem.BIRD
    elseif (subjectsOfInterestKey >= 32 and subjectsOfInterestKey <= 35) then
        ecosystem = tpz.ecosystem.BEAST
    elseif (subjectsOfInterestKey >= 36 and subjectsOfInterestKey <= 40) then
        ecosystem = tpz.ecosystem.PLANTOID
    elseif (subjectsOfInterestKey >= 41 and subjectsOfInterestKey <= 44) then
        ecosystem = tpz.ecosystem.LIZARD
    elseif (subjectsOfInterestKey >= 45 and subjectsOfInterestKey <= 51) then
        ecosystem = tpz.ecosystem.ELEMENTAL
    elseif (subjectsOfInterestKey >= 52 and subjectsOfInterestKey <= 59) then
        ecosystem = tpz.ecosystem.BEASTMEN
    end

    SetServerVariable("[ZNM]Ecosystem", ecosystem)
end

local function updateSubOfInterestLimit(zeni)
    local remainingLimit = GetServerVariable("[ZNM]SubOfInterestLimit")
    remainingLimit = remainingLimit - zeni
    if (remainingLimit > 0) then
        SetServerVariable("[ZNM]SubOfInterestLimit", remainingLimit)
    else
        tpz.znm.changeSubjectsOfInterest()
    end
end
-----------------------------------
-- Sanraku's Fauna - Specific NMs/Mobs
-----------------------------------
tpz.znm.faunaKeys = tpz.znm.faunaKeys or {}
-- Please update this whenever new content is added that enabled new fauna.  New assaults, salvage, einherjar, ISNM, Ashu Talif, etc
tpz.znm.faunaKeys = {0, 1, 2, 3, 8, 34, 35, 36, 37, 38, 39, 52, 53, 54} 

tpz.znm.fauna = tpz.znm.fauna or {}
--== HNMs ==
tpz.znm.fauna[0] = {17101201} -- a khimaira that dwells in Caederva Mire.
tpz.znm.fauna[1] = {17027458} -- a cerberus that dwells in Mount Zhayolm.
tpz.znm.fauna[2] = {16986355} -- a hydra that dwells in the Wajaom Woodlands.

--== Assault - Ilrusi Atoll ==
tpz.znm.fauna[3] = {17002505, 17002506, 17002507, 17002508, 17002509, 17002510,
                    17002511, 17002512, 17002513, 17002514, 17002515, 17002516} -- a mimic that dwells in the Ilrusi Atoll. - Golden Salvage
--[[4 - an imp that dwells in the Ilrusi Atoll. - Demolition Duty
5 - an orobon that dwells in the Ilrusi Atoll. - Desperately Seeking Cephalopods
6 - a khimaira that dwells in the Ilrusi Atoll. - Bellerophon's Bliss
7 - a Moblin that dwells in the Ilrusi Atoll. - Bellerophon's Bliss]]

--== Assault - Periqia ==
tpz.znm.fauna[8] = {17006594, 17006595, 17006596, 17006597, 17006598,
                    17006599, 17006600, 17006601, 17006602} -- a crab that dwells in Periqia. - Seagull Grounded 
--[[9 - a ghost that dwells in Periqia. - Requiem 
10 - an imp that dwells in Periqia. - Shooting Down the Baron
11 - a Qiqirn that dwells in Periqia. - Defuse the Threat
12 - a dvergr that dwells in Periqia. - The Price is Right

== Assault - Lebros Cavern ==
13 - a dragon that dwells in the Lebros Cavern. - Evade and Escape
14 - a wamoura that dwells in the Lebros Cavern. - Wamoura Farm Raid
15 - a Cerberus that dwells in the Lebros Cavern. - Better Than One
16 - a fire elemental that dwells in the Lebros Cavern. - Better Than One

== Assault - Mamool Ja Training Grounds ==
17 - a wyvern that dwells in the Mamool Ja Training Grounds. - Blitzkrieg
18 - a cockatrice that dwells in the Mamool Ja Training Grounds. - Blitzkrieg
19 - a marid that dwells in the Mamool Ja Training Grounds. - Marids in the Mist
20 - a Poroggo that dwells in the Mamool Ja Training Grounds. - Azure Ailments
21 - a Qiqirn that dwells in the Mamool Ja Training Grounds. - Azure Ailments
22 - a leech that dwells in the Mamool Ja Training Grounds. - Azure Ailments
23 - a hydra that dwells in the Mamool Ja Training Grounds. - The Susanoo Shuffle

== Assault - Leujaoam Sanctum ==
24 - a rabbit that dwells in the Leujaoam Sanctum. - Shanarha Grass Conservation
25 - an imp that dwells in the Leujaoam Sanctum. - Supplies Recovery
26 - a vampyr that dwells in the Leujaoam Sanctum. - Bloody Rondo

== The Ashu Talif ==
27 - an Opo-opo ithat dwells in the Ashu Talif. - Targeting the Captain

== ISNM ==
28 - an imp that dwells in Talacca Cove. - Call to Arms
29 - a orobon that dwells in Talacca Cove. - Compliments to the Chef
30 - a wamoura larvae that dwells in the Navukgo Execution Chamber. - Tough Nut to Crack
31 - a flan that dwells in the Navukgo Execution Chamber. - Happy Caster
32 - a colibri that dwells in the Jade Sepulcher. - Making a Mockery
33 - a puk that dwells in the Jade Sepulcher. - Shadows of the Mind]]

--== Nyzul Isle ==
tpz.znm.fauna[34] = {17092999} -- a adamantoise that dwells in Nyzul Isle.
tpz.znm.fauna[35] = {17093000} -- a behemoth that dwells in Nyzul Isle.
tpz.znm.fauna[36] = {17093001} -- a wyrm that dwells in Nyzul Isle.
tpz.znm.fauna[37] = {17093002} -- a khimaira that dwells in Nyzul Isle.
tpz.znm.fauna[38] = {17093004} -- a cerberus that dwells in Nyzul Isle.
tpz.znm.fauna[39] = {17093003} -- a hydra that dwells in Nyzul Isle.

--[[== Salvage ==
40 - the legendary creature that dwells deep within the Zhayolm Remnants.
41 - an imp that dwells in the Zhayolm Remnants.
42 - the legendary creature that dwells deep within the Arrapago Remnants.
43 - a flan that dwells in the Arrapago Remnants.
44 - the legendary creature that dwells deep within the Bhaflau Remnants.
45 - a soulflayer that dwells in the Bhaflau Remnants.
46 - the legendary creature that dwells deep within the Silver Sea Remnants.
47 - a Poroggo that dwells in the Silver Sea Remnants.

== Einherjar ==
48 - the creature guarding the first wing of the Hazhalm Testing Grounds.
49 - the creature guarding the second wing of the Hazhalm Testing Grounds.
50 - the creature guarding the third wing of the Hazhalm Testing Grounds.
51 - the legendary creature that dwells deep within the Hazhalm Testing Grounds.]]

--== Besieged Leaders ==
tpz.znm.fauna[52] = {17043875} -- the shimmering scales of an overlord of the Mamool Ja Savages.
tpz.znm.fauna[53] = {17031592} -- the rippling physique of a general of the Troll Mercenaries.
tpz.znm.fauna[54] = {16998862} -- the bewitching beauty of a general of the Undead Swarm.

tpz.znm.changeFauna = function()
    local faunaKey = math.random(#tpz.znm.faunaKeys)
    SetServerVariable("[ZNM]Fauna", faunaKey)
    SetServerVariable("[ZNM]FaunaLimit", FAUNA_LIMIT)
end

local function updateFaunaLimit(zeni)
    local remainingLimit = GetServerVariable("[ZNM]FaunaLimit")
    remainingLimit = remainingLimit - zeni
    if (remainingLimit > 0) then
        SetServerVariable("[ZNM]FaunaLimit", remainingLimit)
    else
        tpz.znm.changeFauna()
    end
end

--------------------------------------------------------------------
-- Gets the Fauna and Subject of Interest that will match on turn in
--------------------------------------------------------------------
local function getMatchingFaunaAndSubjectsOfInterest(target)
    local faunaMatch = 62 -- 61 is max possible match
    local subjectsOfInterestMatch = 55 -- 54 is max possible match
    local familyID = target:getFamily()
    local mobID = target:getID()

    for i=1, #tpz.znm.faunaKeys do
        for k,v in pairs(tpz.znm.fauna[tpz.znm.faunaKeys[i]]) do
            if (mobID == v) then
                faunaMatch = i
            end
        end
    end

    for i=0, #tpz.znm.subjectsOfInterest do
        for k,v in pairs(tpz.znm.subjectsOfInterest[i]) do
            if (familyID == v) then
                subjectsOfInterestMatch = i
            end
        end
    end

    return faunaMatch, subjectsOfInterestMatch
end

-----------------------------------
-- Soultrapper
-----------------------------------
tpz.znm.soultrapper = tpz.znm.soultrapper or {}

tpz.znm.soultrapper.onItemCheck = function(target, user)
    if not user:isFacing(target) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    local id = user:getEquipID(tpz.slot.AMMO)
    if
        id ~= tpz.items.BLANK_SOUL_PLATE and
        id ~= tpz.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    if user:getFreeSlotsCount() == 0 then
        return tpz.msg.basic.FULL_INVENTORY
    end

    return 0
end

-- Good source for in era values https://www.bluegartr.com/threads/63949-Zeni-per-Image-rates
-- Key rate points
-- Aw'Euvhi Card NMs - 65-67ish - never match sub/fauna
-- Genbu - no match, Mid 80s
-- High Level large mobs - mid 40s no match sub/fauna
-- Bees/etc - 16ish with no match
tpz.znm.soultrapper.getZeniValue = function(target, user, showDebugMessage)
    local hpp = target:getHPP()
    local isFacing = target:isFacing(user)
    local targetLevel = target:getMainLvl()
    local isNM = target:isNM() -- ToDo consider if we should handle things like MOBTYPE_EVENT, MOBTYPE_BATTLEFIELD, and CHECK_AS_NM
    local distance = user:checkDistance(target)
    local modelSize = target:getModelSize()
    local isBeingIrresponsible = (user:getInstance() ~= nil) or (user:getBattlefield() ~= nil)

    if (showDebugMessage == nil) then
        showDebugMessage = false
    end

    local zeni = 0
    -- no claim  = little to no zeni
    if (not user:isMobOwner(target) or hpp == 100) then
        zeni = math.random(1,5)
    else
        -- base for small size mobs
        zeni = 16 
        -- large model mobs get a bonus, possibly up to 50 but based on working backwards from known subjects (Genbu, Aw'euvhi, etc it appears to be 2.5x)
        if (modelSize > 0) then
            zeni = zeni * 2.5
        end

        -- Level Component
        if (targetLevel > 75) then
            zeni = zeni + (targetLevel - 75)
        end

        -- NM/Rarity Component -- appears to be very substantial, outweighing even SubjectsOfInterest partial matches
        if isNM then
            local nmBonus = 0
            if (modelSize > 0) then
                nmBonus = 30
            else
                -- seems that small NMs get a bit bigger bonus, perhaps to offset the low base to begin with
                nmBonus = 40
            end
            zeni = zeni + nmBonus

            if isBeingIrresponsible then
                -- what are you doing taking pictures? you are in a battle?!
                -- proto-omega, salvalge bosses, etc all give more points than would be expected
                zeni = zeni + 20
            end
        end

        -- Distance Component
        if (distance > 5) then
            zeni = zeni * 0.5
        end

        -- Angle/Facing Component
        if not isFacing then
            zeni = zeni * 0.5
        end

         -- HP% Component    
        if (hpp > 50) then
            zeni = zeni * 0.25
        elseif (hpp > 25) then
            zeni = zeni * 0.50
        elseif (hpp > 5) then
            zeni = zeni * 0.75
        end

        -- per bgwiki - https://www.bg-wiki.com/ffxi/Category:Pankration#Purchasing_Items
        -- HS Soul Plate should allow for faster activation - not a bonus on points
        --[[if user:getEquipID(tpz.slot.AMMO) == tpz.items.BLANK_HIGH_SPEED_SOUL_PLATE then
            zeni = zeni * 1.5
        end]]

        -- safeguard, should never be possible but lets not deduct zeni, eh?
        if (zeni <= 0) then
            zeni = math.random(1, 5)
        end
        -- Sanitize Zeni
        zeni = math.floor(zeni) -- Remove any floating point information
    end
    
    if (showDebugMessage) then
        user:PrintToPlayer(string.format( "Zeni for Mob %s is %d!", target:getName(), zeni))
        user:PrintToPlayer(string.format( "MobSize [%d] HPP: [%d] isFacing: [%s] LevelOffset: [%d] Distance: [%d] isNM: [%s] hasClaim: [%s] isBeingIrresponsible: [%s]",
                                           modelSize, hpp, isFacing, (targetLevel - 75), distance, isNM, not (not user:isMobOwner(target) or hpp == 100), isBeingIrresponsible ))
    end

    return zeni
end

tpz.znm.soultrapper.onItemUse = function(target, item, user)
    -- TODO: There should be a failure chance - but finding any kind of rate seems difficult
    -- https://wikiwiki.jp/ffxi/NM/%E8%8A%B1%E9%B3%A5%E9%A2%A8%E6%9C%88#p1c57836
    -- Is there a message?

    -- Determine Zeni starting value
    local zeni = tpz.znm.soultrapper.getZeniValue(target, user)

    -- Pick a skill totally at random...
    local skillIndex, skillEntry = utils.randomEntry(tpz.pankration.feralSkills)

    local faunaMatch, subjectsOfInterestMatch = getMatchingFaunaAndSubjectsOfInterest(target)

    -- Add plate
    local plate = user:addSoulPlate(target:getName(), faunaMatch, subjectsOfInterestMatch, target:getSystem(), zeni, skillIndex, skillEntry.fp)
    local data = plate:getSoulPlateData()
    -- utils.unused(data)
end

-----------------------------------
-- Ryo
-----------------------------------
tpz.znm.ryo = tpz.znm.ryo or {}

tpz.znm.ryo.onTrade = function(player, npc, trade)
    if npcUtil.tradeHasExactly(trade, tpz.items.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", plateData.zeni)
        player:startEvent(914)
    end
end

tpz.znm.ryo.onTrigger = function(player, npc)
    player:startEvent(913)
end

tpz.znm.ryo.onEventUpdate = function(player, csid, option)
    if csid == 914 then
        local zeniValue = player:getLocalVar("[ZNM][Ryo]SoulPlateValue")
        player:setLocalVar("[ZNM][Ryo]SoulPlateValue", 0)
        player:updateEvent(zeniValue)
    elseif csid == 913 then
        if option == 300 then
            player:updateEvent(player:getCurrency("zeni_point"), 0)
        elseif option == 200 then
            -- SubjectsOfInterest
            player:updateEvent(GetServerVariable("[ZNM]SubjectsOfInterest"))
        elseif option == 201 then
            -- Fauna
            player:updateEvent(GetServerVariable("[ZNM]Fauna"))
        elseif option == 400 then
            -- Islets dialog
             player:setLocalVar("[ZNM][Ryo]IsletDiscussion", 1)
        end
    end
end

tpz.znm.ryo.onEventFinish = function(player, csid, option)
end

-----------------------------------
-- Sanraku
-----------------------------------
tpz.znm.sanraku = tpz.znm.sanraku or {}

local platesTradedToday = function(player)
    local currentDay = VanadielDayAbsolute()
    local storedDay = player:getCharVar("[ZNM][Sanraku]TradingDay")

    if currentDay ~= storedDay then
        player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
        player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
        return 0
    end

    return player:getCharVar("[ZNM][Sanraku]TradedPlates")
end

local function calculateZeniBonus(plateData)
    local zeni = plateData.zeni
    local faunaMatch = plateData.fauna
    local subOfInterestMatch = plateData.subOfInterest
    local ecosystem = plateData.ecoSystem

    local faunaKey = GetServerVariable("[ZNM]SubjectsOfInterest")
    local subjectsOfInterestKey = GetServerVariable("[ZNM]Fauna")

    if (faunaKey == 0) then
        faunaKey = 1 -- if there is no subject of interest var, take the first index for now
    end

    local isCurrentFauna = false
    local isCurrentSubjectsOfInterest = false
    local isCurrentEcoSytem = false

    if (GetServerVariable("[ZNM]SubjectsOfInterest") == subOfInterestMatch) then
        isCurrentSubjectsOfInterest = true
        zeni = zeni + 25
    end

    if (GetServerVariable("[ZNM]Ecosystem") == ecosystem) then
        isCurrentEcoSytem = true
        zeni = zeni + 25
    end

    if (GetServerVariable("[ZNM]Fauna") == faunaMatch) then
        isCurrentFauna = true
        zeni = zeni + 50
    end

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    -- Add a little randomness
    zeni = zeni + math.random(-5, 5)
    -- clamp - highest reports in era are ~100ish
    zeni = utils.clamp(zeni, 1, 105)

    return zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem
end

tpz.znm.sanraku.onTrade = function(player, npc, trade)
    if not player:hasKeyItem(tpz.ki.RHAPSODY_IN_AZURE) then
        if platesTradedToday(player) >= 10 then
            -- TODO: A message here? -- no message found in events
            return
        end
    else -- If you have the KI, clear out the tracking vars!
        player:setCharVar("[ZNM][Sanraku]TradingDay", 0)
        player:setCharVar("[ZNM][Sanraku]TradedPlates", 0)
    end

    if npcUtil.tradeHasExactly(trade, tpz.items.SOUL_PLATE) then
        -- Cache the soulplate value on the player
        local item = trade:getItem(0)
        local plateData = item:getSoulPlateData()
        local zeni, isCurrentSubjectsOfInterest, isCurrentFauna, isCurrentEcoSytem = calculateZeniBonus(plateData)
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", zeni)

        if (isCurrentSubjectsOfInterest or isCurrentEcoSytem) then
            updateSubOfInterestLimit(zeni)
        end

        if (isCurrentFauna) then
            updateFaunaLimit(zeni)
        end
        player:startEvent(910, zeni)
    else
        -- taken from sanraku.lua
        znm = -1
        found = false

        while znm <= 30 and not(found) do
            znm = znm + 1
            found = trade:hasItemQty(trophies[znm + 1],1)
        end

        if (found) then
            znm = znm + 1

            if player:hasKeyItem(seals[znm]) == false then
                player:tradeComplete()
                player:addKeyItem(seals[znm])
                player:startEvent(912, 0, 0, 0, seals[znm])
            else
                player:messageSpecial(ID.text.SANCTION + 8,seals[znm]) -- You already possess .. (not sure this is authentic)
            end
        end
    end
end

------------------------------------------------------------
-- Gets the allowed ZNMs for a player based on KIs
-- pulled from Sanraku.lua
------------------------------------------------------------
local function getAllowedZNMs(player)
    local param = 2140136440 -- Defaut bitmask, Tier 1 ZNM Menu + don't ask option

    -- Tinnin Path
    if player:hasKeyItem(tpz.ki.MAROON_SEAL) and ZNM_Tier2 == 1 then
        param = param - 0x38 -- unlocks Tinnin path tier 2 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.APPLE_GREEN_SEAL) and ZNM_Tier3 == 1 then
        param = param - 0x1C0 -- unlocks Tinnin path tier 3 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.CHARCOAL_GREY_SEAL) and player:hasKeyItem(tpz.ki.DEEP_PURPLE_SEAL) and player:hasKeyItem(tpz.ki.CHESTNUT_COLORED_SEAL) and ZNM_Tier4 == 1 then
        param = param - 0x200 -- unlocks Tinnin.
    end

    -- Sarameya Path
    if player:hasKeyItem(tpz.ki.CERISE_SEAL) and ZNM_Tier2 == 1 then
        param = param - 0xE000 -- unlocks Sarameya path tier 2 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.SALMON_COLORED_SEAL) and ZNM_Tier3 == 1 then
        param = param - 0x70000 -- unlocks Sarameya path tier 3 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.PURPLISH_GREY_SEAL) and player:hasKeyItem(tpz.ki.GOLD_COLORED_SEAL) and player:hasKeyItem(tpz.ki.COPPER_COLORED_SEAL) and ZNM_Tier4 == 1 then
        param = param - 0x80000 -- unlocks Sarameya.
    end

    -- Tyger Path
    if player:hasKeyItem(tpz.ki.PINE_GREEN_SEAL) and ZNM_Tier2 == 1 then
        param = param - 0x3800000 -- unlocks Tyger path tier 2 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.AMBER_COLORED_SEAL) and ZNM_Tier3 == 1 then
        param = param - 0x1C000000 -- unlocks Tyger path tier 3 ZNMs.
    end
    if player:hasKeyItem(tpz.ki.TAUPE_COLORED_SEAL) and player:hasKeyItem(tpz.ki.FALLOW_COLORED_SEAL) and player:hasKeyItem(tpz.ki.SIENNA_COLORED_SEAL) and ZNM_Tier4 == 1 then
        param = param - 0x20000000 -- unlocks Tyger.
    end

    if player:hasKeyItem(tpz.ki.LILAC_COLORED_SEAL) and player:hasKeyItem(tpz.ki.BRIGHT_BLUE_SEAL) and player:hasKeyItem(tpz.ki.LAVENDER_COLORED_SEAL) and ZNM_Tier5 == 1 then
        param = param - 0x40000000 -- unlocks Pandemonium Warden.
    end

    return param
end

tpz.znm.sanraku.onTrigger = function(player, npc)
    if (player:getCharVar("[ZNM]SanrakuIntro") == 0) then
        -- 908: First time introduction
        player:startEvent(908)
    else
        -- 909: Further interactions - param0 = 1 - allowed mobs filter param1 = reduce costs from 500 to 50
        local param = getAllowedZNMs(player)
        player:startEvent(909, param)
    end
end

tpz.znm.sanraku.onEventUpdate = function(player, csid, option)
    -- taken from sanraku.lua
     if csid == 909 then
        local zeni = player:getCurrency("zeni_point")

        if option >= 300 and option <= 302 then
            if option == 300 then
                salt = tpz.ki.SICKLEMOON_SALT
            elseif option == 301 then
                salt = tpz.ki.SILVER_SEA_SALT
            elseif option == 302 then
                salt = tpz.ki.CYAN_DEEP_SALT
            end
            if zeni < 500 then
                player:updateEvent(2,500) -- not enough zeni
            elseif player:hasKeyItem(salt) then
                player:updateEvent(3,500) -- has salt already
            else
                player:updateEvent(1,500,0,salt)
                player:addKeyItem(salt)
                player:delCurrency("zeni_point", 500)
            end
        else -- player is interested in buying a pop item.
            

            n = option % 10
            if n <= 2 then
                if option == 130 or option == 440 then
                    tier = 5
                else
                    tier = 1
                end
            elseif n >= 3 and n <= 5 then
                tier = 2
            elseif n >= 6 and n <= 8 then
                tier = 3
            else
                tier = 4
            end
           

            if option >= 100 and option <= 130 then
                item = lures[option-99]
                local itemVarName = string.format("[ZNM]PopItemCost" ..item.. "")
                cost = tier * 1000 +  GetServerVariable(itemVarName)
                player:updateEvent(0,0,0,0,0,0,cost)

            elseif option >= 400 and option <=440 then
                if option == 440 then
                    option = 430
                end

                item = lures[option-399]

                if option == 430 then -- Pandemonium Warden
                    keyitem1 = tpz.ki.LILAC_COLORED_SEAL keyitem2 = tpz.ki.BRIGHT_BLUE_SEAL keyitem3 = tpz.ki.LAVENDER_COLORED_SEAL
                elseif option == 409 then -- Tinnin
                    keyitem1 = tpz.ki.CHARCOAL_GREY_SEAL keyitem2 = tpz.ki.DEEP_PURPLE_SEAL keyitem3 = tpz.ki.CHESTNUT_COLORED_SEAL
                elseif option == 419 then -- Sarameya
                    keyitem1 = tpz.ki.PURPLISH_GREY_SEAL keyitem2 = tpz.ki.GOLD_COLORED_SEAL keyitem3 = tpz.ki.COPPER_COLORED_SEAL
                elseif option == 429 then -- Tyger
                    keyitem1 = tpz.ki.TAUPE_COLORED_SEAL keyitem2 = tpz.ki.FALLOW_COLORED_SEAL keyitem3 = tpz.ki.SIENNA_COLORED_SEAL
                else
                    keyitem1 = seals[option - 402] keyitem2 = nil keyitem3 = nil
                end

                if cost > zeni then
                    player:updateEvent(2, cost, item, keyitem1,keyitem2,keyitem3) -- you don't have enough zeni.
                elseif player:addItem(item) then
                    if keyitem1 ~= nil then
                        player:delKeyItem(keyitem1)
                    end
                    if keyitem2 ~= nil then
                        player:delKeyItem(keyitem2)
                    end
                    if keyitem3 ~= nil then
                        player:delKeyItem(keyitem3)
                    end

                    player:updateEvent(1, cost, item, keyitem1,keyitem2,keyitem3)
                    player:delCurrency("zeni_point", cost)
                    local itemVarName = string.format("[ZNM]PopItemCost" ..item.. "")
                    local currentUpcharge = GetServerVariable(itemVarName)
                    SetServerVariable(itemVarName, currentUpcharge + 100)
                else
                    player:updateEvent(4, cost, item, keyitem1,keyitem2,keyitem3) -- Cannot obtain.
                end
            elseif option == 500 or option == 1 then -- player has declined to buy a pop item
                local allowIslet = 0
                allowIslet = player:getCharVar("[ZNM][Ryo]IsletDiscussion")
                player:updateEvent(allowIslet)
            end
        end
    end
end

tpz.znm.sanraku.onEventFinish = function(player, csid, option)
    if csid == 910 then
        player:confirmTrade()
        player:setCharVar("[ZNM][Sanraku]TradingDay", VanadielDayAbsolute())
        player:addCharVar("[ZNM][Sanraku]TradedPlates", 1)

        local zeniValue = player:getLocalVar("[ZNM][Sanraku]SoulPlateValue")
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", 0)

        player:addCurrency("zeni_point", zeniValue)
    elseif csid == 908 then
        player:setCharVar("[ZNM]SanrakuIntro", 1)
    end

end
