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
-----------------------------------

tpz = tpz or {}
tpz.znm = tpz.znm or {}

tpz.items = tpz.items or {}
tpz.items["BLANK_SOUL_PLATE"] = 18722
tpz.items["BLANK_HIGH_SPEED_SOUL_PLATE"] = 18725
tpz.items["SOUL_PLATE"] = 2477


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
tpz.znm.subjectsOfInterest[60] = {203, 204, 205} -- qutrub -- we treat these as undead famliy
-- demon part 2
tpz.znm.subjectsOfInterest[61] = {233} -- soulflayer


tpz.znm.subjectsOfInterest.changeSubjectsOfInterest = function()
    local subjectsOfInterestKey = math.random(#tpz.znm.subjectsOfInterest)
    printf("subjectsOfInterestKey %s", subjectsOfInterestKey)
    SetServerVariable("[ZNM]SubjectsOfInterest", subjectsOfInterestKey)
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

tpz.znm.fauna.changeFauna = function()
    local faunaKey = math.random(#tpz.znm.faunaKeys)
    printf("faunaKey %s", faunaKey)
    SetServerVariable("[ZNM]Fauna", faunaKey)
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
tpz.znm.soultrapper.getZeniValue = function(target, user, item)
    local hpp = target:getHPP()
    local isNM = target:isNM() -- ToDo consider if we should handle things like MOBTYPE_EVENT, MOBTYPE_BATTLEFIELD, and CHECK_AS_NM
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)

    -- no claim  = little to no zeni
    if (not user:isMobOwner(target)) then
        return  math.random(1,5)
    end

    -- Starting value
    local zeni = 5

    -- Level Component
    -- TODO there appears to be a level component

    -- HP% Component
    local hpMultiplier = math.min(100 / hpp, 5)
    if hpp <= 5 then
        hpMultiplier = 10 -- ToDo this is too high - some in era values were sub 30 for  mob with hp under 5%
    end
    zeni = zeni * hpMultiplier

    -- NM/Rarity Component
    if isNM then
        zeni = zeni * 1.5
    end

    -- Distance Component
    zeni = zeni * utils.clamp((1 / distance) * 2, 1, 2)

    -- Angle/Facing Component
    if isFacing then
        zeni = zeni * 1.5
    end

    -- Bonus for HS Soul Plate
    -- per bgwiki - https://www.bg-wiki.com/ffxi/Category:Pankration#Purchasing_Items
    -- HS Soul Plate should allow for faster activation - not a bonus on points
    --[[if user:getEquipID(tpz.slot.AMMO) == tpz.items.BLANK_HIGH_SPEED_SOUL_PLATE then
        zeni = zeni * 1.5
    end]]

    -- Add a little randomness
    zeni = zeni + math.random(0, 5)

    -- Sanitize Zeni
    zeni = math.floor(zeni) -- Remove any floating point information
    zeni = utils.clamp(zeni, 1, 100)

    printf("zeni is %s", zeni)
    return zeni
end

tpz.znm.soultrapper.onItemUse = function(target, item, user)
    -- TODO: There should be a failure chance - but finding any kind of rate seems difficult
    -- Determine Zeni starting value
    local zeni = tpz.znm.soultrapper.getZeniValue(target, user, item)

    -- Pick a skill totally at random...
    local skillIndex, skillEntry = utils.randomEntry(tpz.pankration.feralSkills)

    -- Add plate
    local plate = user:addSoulPlate(target:getName(), target:getID(), zeni, skillIndex, skillEntry.fp)
    -- local data = plate:getSoulPlateData()
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

local calculateZeniBonus = function(plateData)
    local zeni = plateData.zeni
    local targetID = plateData.mobID
    local faunaKey = GetServerVariable("[ZNM]SubjectsOfInterest")
    local subjectsOfInterestKey = GetServerVariable("[ZNM]Fauna")

    if (faunaKey == 0) then
        faunaKey = 1 -- if there is no subject of interest var, take the first index for now
    end

     -- Fauna Component
    local isCurrentFauna = false
    for k,v in pairs(tpz.znm.fauna[tpz.znm.faunaKeys[faunaKey]]) do
        if targetID == v then
            isCurrentFauna = true
            break
        end
    end

    -- SubjectsOfInterest Component
    local isCurrentSubjectsOfInterest = false
    for k,v in pairs(tpz.znm.subjectsOfInterest[subjectsOfInterestKey]) do
        if family == v then
            isCurrentSubjectsOfInterest = true
            break
        end
    end

    -- this needs to be done on trade
    if isCurrentSubjectsOfInterest then
        zeni = zeni * 1.25
    elseif isCurrentFauna then
        zeni = zeni * 1.5
    end

    return zeni, isCurrentSubjectsOfInterest, isCurrentFauna
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
        local zeni, isCurrentSubjectsOfInterest, isCurrentFauna = calculateZeniBonus(plateData)
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", zeni)
        if (isCurrentSubjectsOfInterest) then
            -- Check to update (assumed to be a limit of turn ins or paid out zeni)
        end

        if (isCurrentFauna) then
            -- Check to update (assumed to be a limit of turn ins or paid out zeni)
        end
        player:startEvent(910, zeni)
    end
end

tpz.znm.sanraku.onTrigger = function(player, npc)
    -- 908: First time introduction
    -- 909: Further interactions - param0 = 1 - allow IsletDiscussion
end

tpz.znm.sanraku.onEventUpdate = function(player, csid, option)
end

tpz.znm.sanraku.onEventFinish = function(player, csid, option)
    if csid == 910 then
        player:confirmTrade()
        player:setCharVar("[ZNM][Sanraku]TradingDay", VanadielDayAbsolute())
        player:addCharVar("[ZNM][Sanraku]TradedPlates", 1)

        local zeniValue = player:getLocalVar("[ZNM][Sanraku]SoulPlateValue")
        player:setLocalVar("[ZNM][Sanraku]SoulPlateValue", 0)

        player:addCurrency("zeni_point", zeniValue)
    end
end
