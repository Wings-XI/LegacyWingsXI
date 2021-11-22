----------------------------------------
-- Campaign global
----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/zone")
require("scripts/globals/status")
----------------------------------------

tpz = tpz or {}
tpz.campaign = tpz.campaign or {}

-- -------------------------------------------------------------------
-- getMedalRank()
-- Returns the numerical Campaign Medal of the player.
-- -------------------------------------------------------------------

function getMedalRank(player)
    local rank = 0
    local medals =
    {
         924, 925, 926, 927, 928, 929, 930,
         931, 932, 933, 934, 935, 936, 937,
         938, 939, 940, 941, 942, 943
    }
    while (player:hasKeyItem(medals[rank + 1]) == true) do
        rank = rank + 1
    end
    return rank
end

-- -------------------------------------------------------------------
-- get[nation]NotesItem()
-- Returns the item ID and cost of the Allied Notes indexed item
-- (the same value as that used by the vendor event)
-- Format:
-- ListName_AN_item[optionID] = itemID -- ItemName
-- ListName_AN_price[optionID] = cost -- ItemName
-- -------------------------------------------------------------------

-- Prices for Players not Allied with the Nation --
function getSandOriaNotesItem(i)
    local SandOria_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14584, price = 1500}, -- Iron Ram jack coat
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 16172, price = 4500}, -- Iron Ram Shield
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14581, price = 15000}, -- Iron Ram Chainmain
        [274] = {id = 15005, price = 10500}, -- Iron Ram Mufflers
        [530] = {id = 15749, price = 10500}, -- Iron Ram Sollerets
        [786] = {id = 16141, price = 10500}, -- Iron Ram Helm
        [1042] = {id = 16312, price = 10500}, -- Iron Ram Breeches
        -- Emblems Service
        [34] = {id = 16312, price = 30000}, -- Iron Ram Horn
        [290] = {id = 16312, price = 30000}, -- Iron Ram Lance
        [546] = {id = 16312, price = 30000}, -- Iron Ram Pick
        [802] = {id = 16312, price = 60000}, -- Iron Ram Sallet
        [1058] = {id = 16312, price = 60000}, -- Iron Ram Dastanas
        -- Wings Service
        [50] = {id = 15755, price = 75000}, -- Iron Ram Greaves
        [306] = {id = 16315, price = 75000}, -- Iron Ram Hose
        -- Medals Service
        [66] = {id = 15844, price = 45000}, -- Patronus Ring
        [322] = {id = 15966, price = 45000}, -- Fox Earring
        [578] = {id = 15961, price = 45000}, -- Temple Earring
        [834] = {id = 15934, price = 45000}, -- Crimson Belt
        [1090] = {id = 19041, price = 45000}, -- Rose Strap
        [1346] = {id = 15488, price = 112500}, -- Iron Ram Hauberk
        [1602] = {id = 11356, price = 15000}, -- Royal Guard Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Griffinclaw
        [338] = {id = 11636, price = 75000} -- Royal Knight Sigil Ring
    }
    local item = SandOria_AN[i]
    return item.id, item.price
end

function getBastokNotesItem(i)
    local Bastok_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14585, price = 1500}, -- Fourth Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 18727, price = 4500}, -- Fourth Gun
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14582, price = 15000}, -- Fourth Cuirass
        [274] = {id = 15006, price = 10500}, -- Fourth Gauntlets
        [530] = {id = 15750, price = 10500}, -- Fourth Sabatons
        [786] = {id = 16142, price = 10500}, -- Fourth Armet
        [1042] = {id = 16313, price = 10500}, -- Fourth Cuisses
        -- Emblems Service
        [34] = {id = 18494, price = 30000}, -- Fourth Toporok
        [290] = {id = 18854, price = 30000}, -- Fourth Mace
        [546] = {id = 18946, price = 30000}, -- Fourth Zaghnal
        [802] = {id = 16147, price = 60000}, -- Fourth Haube
        [1058] = {id = 15010, price = 60000}, -- Fourth Hentzes
        -- Wings Service
        [50] = {id = 15756, price = 75000}, -- Fourth Schuhs
        [306] = {id = 16316, price = 75000}, -- Fourth Schoss
        -- Medals Service
        [66] = {id = 16291, price = 45000}, -- Shield Collar
        [322] = {id = 18734, price = 45000}, -- Sturm's Report
        [578] = {id = 18735, price = 45000}, -- Sonia's Plectrum
        [834] = {id = 16292, price = 45000}, -- Bull Necklace
        [1090] = {id = 16258, price = 45000}, -- Arrestor Mantle
        [1346] = {id = 14589, price = 112500}, -- Fourth Division Brunne
        [1602] = {id = 11357, price = 15000}, -- Mythril Musketeer Livery
        -- Medal of Altana
        [82] = {id = 17685, price = 150000}, -- Lex Talionis
        [338] = {id = 11545, price = 75000} -- Fourth Mantle
    }
    local item = Bastok_AN[i]
    return item.id, item.price
end

function getWindurstNotesItem(i)
    local Windurst_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14586, price = 1500}, -- Cobra Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 19150, price = 4500}, -- Cobra CLaymore
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14583, price = 15000}, -- Cobra Coat
        [274] = {id = 15007, price = 10500}, -- Cobra Cuffs
        [530] = {id = 15751, price = 10500}, -- Cobra Pigaches
        [786] = {id = 16143, price = 10500}, -- Cobra Hat
        [1042] = {id = 16314, price = 10500}, -- Cobra Slops
        -- Emblems Service
        [34] = {id = 18756, price = 30000}, -- Cobra Unit Baghnakhs
        [290] = {id = 19100, price = 30000}, -- Cobra Unit Knife
        [546] = {id = 18728, price = 30000}, -- Cobra Unit Bow
        [802] = {id = 16149, price = 60000}, -- Cobra Unit Cloche
        [1058] = {id = 15011, price = 60000}, -- Cobra Unit Mittens
        -- Wings Service
        [50] = {id = 15757, price = 75000}, -- Cobra Unit Leggings
        [306] = {id = 16317, price = 75000}, -- Cobra Unit Subligar
        [580] = {id = 15758, price = 75000}, -- Cobra Unit Crackows
        [1001] = {id = 16318, price = 75000}, -- Cobra Unit Trews
        -- Medals Service
        [66] = {id = 15935, price = 45000}, -- Capricornian Rope
        [322] = {id = 15936, price = 45000}, -- Earthly Belt
        [578] = {id = 16293, price = 45000}, -- Cougar Pendant
        [834] = {id = 16294, price = 45000}, -- Crocodile Collar
        [1090] = {id = 19041, price = 45000}, -- Ariesian Grip
        [1346] = {id = 19042, price = 112500}, -- Cobra Unit Harness
        [1602] = {id = 11358, price = 15000}, -- Patriarch Protector Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Samudra
        [338] = {id = 11636, price = 75000} -- Mercenary Major Charm
    }
    local item = Windurst_AN[i]
    return item.id, item.price
end

-- Prices for Players Allied with the Nation --
function getSandOriaNotesItemAllegience(i)
    local SandOria_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14584, price = 1000}, -- Iron Ram jack coat
        [770] = {id = 14587, price = 1000}, -- Pilgrim Tunica
        [1026] = {id = 16172, price = 3000}, -- Iron Ram Shield
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14581, price = 10000}, -- Iron Ram Chainmain
        [274] = {id = 15005, price = 7000}, -- Iron Ram Mufflers
        [530] = {id = 15749, price = 7000}, -- Iron Ram Sollerets
        [786] = {id = 16141, price = 7000}, -- Iron Ram Helm
        [1042] = {id = 16312, price = 7000}, -- Iron Ram Breeches
        -- Emblems Service
        [34] = {id = 16312, price = 20000}, -- Iron Ram Horn
        [290] = {id = 16312, price = 20000}, -- Iron Ram Lance
        [546] = {id = 16312, price = 20000}, -- Iron Ram Pick
        [802] = {id = 16312, price = 40000}, -- Iron Ram Sallet
        [1058] = {id = 16312, price = 40000}, -- Iron Ram Dastanas
        -- Wings Service
        [50] = {id = 15755, price = 50000}, -- Iron Ram Greaves
        [306] = {id = 16315, price = 50000}, -- Iron Ram Hose
        -- Medals Service
        [66] = {id = 15844, price = 30000}, -- Patronus Ring
        [322] = {id = 15966, price = 30000}, -- Fox Earring
        [578] = {id = 15961, price = 30000}, -- Temple Earring
        [834] = {id = 15934, price = 30000}, -- Crimson Belt
        [1090] = {id = 19041, price = 30000}, -- Rose Strap
        [1346] = {id = 15488, price = 75000}, -- Iron Ram Hauberk
        [1602] = {id = 11356, price = 10000}, -- Royal Guard Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 100000}, -- Griffinclaw
        [338] = {id = 11636, price = 50000} -- Royal Knight Sigil Ring
    }
    local item = SandOria_AN[i]
    return item.id, item.price
end

function getBastokNotesItemAllegience(i)
    local Bastok_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14585, price = 1000}, -- Fourth Tunica
        [770] = {id = 14587, price = 1000}, -- Pilgrim Tunica
        [1026] = {id = 18727, price = 3000}, -- Fourth Gun
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14582, price = 10000}, -- Fourth Cuirass
        [274] = {id = 15006, price = 7000}, -- Fourth Gauntlets
        [530] = {id = 15750, price = 7000}, -- Fourth Sabatons
        [786] = {id = 16142, price = 7000}, -- Fourth Armet
        [1042] = {id = 16313, price = 7000}, -- Fourth Cuisses
        -- Emblems Service
        [34] = {id = 18494, price = 20000}, -- Fourth Toporok
        [290] = {id = 18854, price = 20000}, -- Fourth Mace
        [546] = {id = 18946, price = 20000}, -- Fourth Zaghnal
        [802] = {id = 16147, price = 40000}, -- Fourth Haube
        [1058] = {id = 15010, price = 40000}, -- Fourth Hentzes
        -- Wings Service
        [50] = {id = 15756, price = 50000}, -- Fourth Schuhs
        [306] = {id = 16316, price = 50000}, -- Fourth Schoss
        -- Medals Service
        [66] = {id = 16291, price = 30000}, -- Shield Collar
        [322] = {id = 18734, price = 30000}, -- Sturm's Report
        [578] = {id = 18735, price = 30000}, -- Sonia's Plectrum
        [834] = {id = 16292, price = 30000}, -- Bull Necklace
        [1090] = {id = 16258, price = 30000}, -- Arrestor Mantle
        [1346] = {id = 14589, price = 75000}, -- Fourth Division Brunne
        [1602] = {id = 11357, price = 10000}, -- Mythril Musketeer Livery
        -- Medal of Altana
        [82] = {id = 17685, price = 100000}, -- Lex Talionis
        [338] = {id = 11545, price = 50000} -- Fourth Mantle
    }
    local item = Bastok_AN[i]
    return item.id, item.price
end

function getWindurstNotesItemAllegience(i)
    local Windurst_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14586, price = 1500}, -- Cobra Tunica
        [770] = {id = 14587, price = 1000}, -- Pilgrim Tunica
        [1026] = {id = 19150, price = 3000}, -- Cobra CLaymore
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2562] = {id = 6408, price = 50000}, -- Portable Container
        -- Stars Service
        [18] = {id = 14583, price = 10000}, -- Cobra Coat
        [274] = {id = 15007, price = 7000}, -- Cobra Cuffs
        [530] = {id = 15751, price = 7000}, -- Cobra Pigaches
        [786] = {id = 16143, price = 7000}, -- Cobra Hat
        [1042] = {id = 16314, price = 7000}, -- Cobra Slops
        -- Emblems Service
        [34] = {id = 18756, price = 20000}, -- Cobra Unit Baghnakhs
        [290] = {id = 19100, price = 20000}, -- Cobra Unit Knife
        [546] = {id = 18728, price = 20000}, -- Cobra Unit Bow
        [802] = {id = 16149, price = 40000}, -- Cobra Unit Cloche
        [1058] = {id = 15011, price = 40000}, -- Cobra Unit Mittens
        -- Wings Service
        [50] = {id = 15757, price = 50000}, -- Cobra Unit Leggings
        [306] = {id = 16317, price = 50000}, -- Cobra Unit Subligar
        [580] = {id = 15758, price = 50000}, -- Cobra Unit Crackows
        [1001] = {id = 16318, price = 50000}, -- Cobra Unit Trews
        -- Medals Service
        [66] = {id = 15935, price = 30000}, -- Capricornian Rope
        [322] = {id = 15936, price = 30000}, -- Earthly Belt
        [578] = {id = 16293, price = 30000}, -- Cougar Pendant
        [834] = {id = 16294, price = 30000}, -- Crocodile Collar
        [1090] = {id = 19041, price = 30000}, -- Ariesian Grip
        [1346] = {id = 19042, price = 75000}, -- Cobra Unit Harness
        [1602] = {id = 11358, price = 10000}, -- Patriarch Protector Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 100000}, -- Samudra
        [338] = {id = 11636, price = 50000} -- Mercenary Major Charm
    }
    local item = Windurst_AN[i]
    return item.id, item.price
end

-------------------------------------------------------------------------
-- tpz.campaign.onTrade(player, npc, trade)
-- Used for trading EXP bands to NPCs for recharges.
-- Mirrors work done in conquest.lua to ensure the system is consistent.
-- Function is added in campaign.lua to shorten per npc lua scripts.
-------------------------------------------------------------------------
tpz.campaign.onTrade = function(player, npc, trade)
    local expRings =
    {
    [15761] = {price=350, charges=7},
    [15762] = {price=700, charges=7},
    [15763] = {price=600, charges=3},
    }
    local item = trade:getItemId()
    local tradeConfirmed = false
    local mOffset  = zones[player:getZoneID()].text.CAMPAIGN_RECHARGE
    if not tradeConfirmed and expRings[item] and npcUtil.tradeHas(trade, item) then
        if BYPASS_EXP_RING_ONE_PER_WEEK == 1 or player:getCharVar("CONQUEST_RING_RECHARGE") < os.time() then
            local ring = expRings[item]

            if player:getCurrency("allied_notes") >= ring.price then
                player:delCurrency("allied_notes", ring.price)
                player:confirmTrade()
                player:addItem(item)
                player:setCharVar("CONQUEST_RING_RECHARGE", getConquestTally())
                player:showText(npc, mOffset + 3, item, ring.price, ring.charges) -- "Your ring is now fully recharged."
            else
                player:showText(npc, mOffset + 0, item, ring.price) -- "You do not have the required conquest points to recharge."
            end
         else
            player:showText(npc, mOffset + 1, item) -- "Please be aware that you can only purchase or recharge <item> once during the period between each conquest results tally.
        end
    end
end

-- -------------------------------------------------------------------
-- getSigilTimeStamp(player)
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------
function getSigilTimeStamp(player)
    local timeStamp = 0 -- zero'd till math is done.

    -- TODO: calculate time stamp for menu display of when it wears off

    return timeStamp
end

--------------------------------------------------
-- Campaign Zones enum
-- Used to drive Campaign Teleport Menus and logic
--------------------------------------------------
campaignZone = {
    XARCABARD_S             = 1,
    BEAUCEDINE_GLACIER_S    = 2,
    BATALLIA_DOWNS_S        = 3,
    ROLANBERRY_FIELDS_S     = 4,
    SAUROMUGUE_CHAMPAIGN_S  = 5,
    JUGNER_FOREST_S         = 6,
    PASHHOW_MARSHLANDS_S    = 7,
    MERIPHATAUD_MOUNTAINS_S = 8,
    VUNKERL_INLET_S         = 9,
    GRAUBERG_S              = 10,
    FORT_KARUGO_NARUGO_S    = 11,
    EAST_RONFAURE_S         = 12,
    NORTH_GUSTABERG_S       = 13,
    WEST_SARUTABARUTA_S     = 14,
    SOUTHERN_SAN_DORIA_S    = 15,
    BASTOK_MARKETS_S        = 16,
    WINDURST_WATERS_S       = 17,
    GARLAIGE_CITADEL_S      = 18,
    CRAWLERS_NEST_S         = 19,
    THE_ELDIEME_NECROPOLIS_S = 20
}


-----------------------------------
-- (PUBLIC) Past nation teleport
-----------------------------------

-- ----------------------------------------------------------------------------
-- teleporterOnTrigger()
-- Triggered when a campaign teleport NPC is triggered
-- Will perform initial campaign teleport setup by providing allegiance and AN
-- ----------------------------------------------------------------------------
tpz.campaign.teleporterOnTrigger = function(player, teleporterNation, teleporterEvent)
    -- Priming event - sends allegiance and current allied notes
    local campaignAllegiance = player:getCampaignAllegiance()  -- 0 = none, 1 = San d'Oria Iron Rams, 2 = Bastok Fighting Fourth, 3 = Windurst Cobras
    player:startEvent(teleporterEvent, campaignAllegiance, 0, player:getCurrency("allied_notes"))
end

-- ----------------------------------------------------------------------------
-- teleporterOnEventUpdate()
-- Triggered when a campaign teleport NPC provides an update
-- Will provide allowed zones and their control (control is future) on intiial update (50)
-- Will provide fee required on destination selection
-- ----------------------------------------------------------------------------
tpz.campaign.teleporterOnEventUpdate = function(player, csid, option, teleporterNation, teleporterEvent)
    if csid == teleporterEvent and option == 50 then
        -- TODO:Campgain_Control - We dont have control modeled yet - until we do, do not show control in the teleport menu
        local ownershipFlags1 = 0 -- Xarc to Pashhow
        local ownershipFlags2 = 0 -- Meriphataud to West Saru
        local ownershipFlags3 = 0 -- Garliage, Crawlers, and Eldime

        local campaignAllegiance = player:getCampaignAllegiance()
        local allowedTeleports = getAllowedCampaignTeleports(player)

        -- Update with allowed teleports and ownership
        player:updateEvent(allowedTeleports, ownershipFlags1, ownershipFlags2, ownershipFlags3, campaignAllegiance, 4, 1, 0) -- TODO research on the last 3 params
    elseif csid == teleporterEvent and option <= 20 and option >= 1 then
        -- interestingly - the handling of not enough AN is done client side
        -- we could add an anti-cheat mechanism on envent finish to ensure no exploitation
        local fee = tpz.campaign.teleportFee(player, teleporterNation, option)
        player:updateEvent(0, fee)
    end
end

-- ----------------------------------------------------------------------------
-- teleporterOnEventFinish()
-- Triggered when a campaign teleport NPC provides an EventFinish
-- Will deduct AN and teleport player when provided a destination option
-- ----------------------------------------------------------------------------
tpz.campaign.teleporterOnEventFinish = function(player, csid, option, teleporterNation, teleporterEvent)
    if csid == teleporterEvent and option <= 20 and option >= 1 then
        local fee = tpz.campaign.teleportFee(player, teleporterNation, option)
        if player:getCurrency("allied_notes") >= fee then
            player:delCurrency("allied_notes", fee)
            -- TODO:Campaign_Control - We dont have control modeled yet - until we do there is only one telepoint per zone
            -- Once control is modeled - 2 telepoint per zone - one for nation controlled one for beastmen controlled
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.CAMPAIGN, 0, 1, 0, option)
        end
    end
end

-- ----------------------------------------------------------------------------
-- teleportFee()
-- Determines fee for a player teleporting from the teleport nation to the destination
-- ----------------------------------------------------------------------------
tpz.campaign.teleportFee = function(player, teleporterNation, destination)
    -- TODO:Campgain_Control - We dont have control modeled yet - until we do, we cannot calculate cost based on control
    -- Cost Source: https://ffxiclopedia.fandom.com/wiki/Allied_Notes#Teleportation

    local campaignAllegiance = player:getCampaignAllegiance()

    local fee = 0
    -- Calculate distance fee
    if destination >= campaignZone.EAST_RONFAURE_S and destination <= campaignZone.WEST_SARUTABARUTA_S then
        fee = 20
    elseif destination >= campaignZone.VUNKERL_INLET_S and destination <= campaignZone.FORT_KARUGO_NARUGO_S then
        fee = 30
    elseif destination >= campaignZone.JUGNER_FOREST_S and destination <= campaignZone.MERIPHATAUD_MOUNTAINS_S then
        fee = 40
    elseif destination >= campaignZone.BATALLIA_DOWNS_S and destination <= campaignZone.SAUROMUGUE_CHAMPAIGN_S then
        fee = 50
    elseif destination >= campaignZone.XARCABARD_S and destination <= campaignZone.BEAUCEDINE_GLACIER_S then
        fee = 60
    elseif destination >= campaignZone.GARLAIGE_CITADEL_S and destination <= campaignZone.THE_ELDIEME_NECROPOLIS_S then
        -- have not found documentation on the cost of these zones other than that they are enabled
        -- going by the "distance from home nation" trend, these zones are one step further than Rolanberry/Batallia/Sauromugue
        fee = 60
    end

    -- Calculate control cost - Until control is modeled treat all zones as allied controlled
    fee = fee + 20
    -- if not getCampaignZoneControl(destination) == campaignAllegiance then -- controlled by player's allegiance
        -- if getCampaingZoneControl(destination) == 0 then  -- Beastmen Controlled
        --      -- fee = fee + 40
        -- else -- Allied controlled
        --      -- fee = fee + 20
        -- end
    -- end
    if campaignAllegiance ~= teleporterNation then
        fee = fee * 1.2
    end
   
    return fee
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnTrigger()
-- Triggered when a campaign NPC is interacted with
-- ----------------------------------------------------------------------------
tpz.campaign.campaignArbiterOnTrigger = function(player, npc, campaignEvent)
    -- Priming event - sends allegiance and current allied notes
    -- 32 will hide teleportation
    -- 4 will show New Allied Tags and allow you to get new allied tags
    -- 4 and 8 will show New Allied Tags and not allow you to get new tags (medal has expired)
    -- 16 enables Performance Assessment and Union Registration
    -- 1 will reduce the Retrace cost, signaling ownership
    local campaignAllegiance = player:getCampaignAllegiance()
    local menuOptions = 0
    menuOptions = menuOptions + showTeleportOption(npc, campaignAllegiance)
    menuOptions = menuOptions + doesNpcMatchAllegiance(player, campaignEvent)

    player:startEvent(campaignEvent, campaignAllegiance, menuOptions, player:getCurrency("allied_notes"))
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnEventUpdate()
-- Triggered when a campaign arbiter provides an update
-- ----------------------------------------------------------------------------
tpz.campaign.campaignArbiterOnEventUpdate = function(player, csid, option, campaignEvent)
    --printf("campaignArbiterOnEventUpdate - csid %u  option %u", csid, option)
end

-- ----------------------------------------------------------------------------
-- campaignArbiterOnEventFinish()
-- Triggered when a campaign arbiter provides an finish
-- ----------------------------------------------------------------------------
tpz.campaign.campaignArbiterOnEventFinish = function(player, csid, option, campaignEvent)
    local fee = 0

    if csid == 454 and option == 1 then
        -- Sandorian Retrace NPC (TK/RK)
        if doesNpcMatchAllegiance(player, campaignEvent) then
            fee = 10
        else
            fee = 30
        end
        deductFeeAndRetrace(player, fee)
    elseif csid == 455 and option == 1 then
        -- Bastokan Retrace NPC (LC/IM)
        if doesNpcMatchAllegiance(player, campaignEvent) then
            fee = 10
        else
            fee = 30
        end
        deductFeeAndRetrace(player, fee)
    elseif csid == 456 and option == 1 then
        -- Windurstian Retrace NPC (CC/MC)
        if doesNpcMatchAllegiance(player, campaignEvent) then
            fee = 10
        else
            fee = 30
        end
        deductFeeAndRetrace(player, fee)
    elseif csid == 457 and option == 1 then
        -- Juenonian Retrace NPC (CA) -- we cannot match - we are paying 50
        fee = 50
        deductFeeAndRetrace(player, fee)
    end    
end

function deductFeeAndRetrace(player, fee)
    if player:getCurrency("allied_notes") >= fee then
        player:delCurrency("allied_notes", fee)
        player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.RETRACE, 0, 1)
    end
end

-- -----------------------------------------------------------------------------------------------
-- getAllowedCampaignTeleports()
-- Returns the WotG allowed teleport zones that the player has previously visted in a set of bits
-- -----------------------------------------------------------------------------------------------
function getAllowedCampaignTeleports(player)
    -- This works for now, but could move to pull PChar->m_ZonesList, unpack the array, and apply a mask
    -- note that diiferent array indexes and bits are used for storage - see packet_system::SmallPacket0x00A - ln302
    -- PChar->m_ZonesList[PChar->getZone() >> 3] |= (1 << (PChar->getZone() % 8));

    local allowedTeleports = 0
    if player:isZoneVisited(tpz.zone.XARCABARD_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.XARCABARD_S))
    end
    if player:isZoneVisited(tpz.zone.BEAUCEDINE_GLACIER_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.BEAUCEDINE_GLACIER_S))
    end
    if player:isZoneVisited(tpz.zone.BATALLIA_DOWNS_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.BATALLIA_DOWNS_S))
    end
    if player:isZoneVisited(tpz.zone.ROLANBERRY_FIELDS_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.ROLANBERRY_FIELDS_S))
    end
    if player:isZoneVisited(tpz.zone.SAUROMUGUE_CHAMPAIGN_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.SAUROMUGUE_CHAMPAIGN_S))
    end
    if player:isZoneVisited(tpz.zone.JUGNER_FOREST_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.JUGNER_FOREST_S))
    end
    if player:isZoneVisited(tpz.zone.PASHHOW_MARSHLANDS_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.PASHHOW_MARSHLANDS_S))
    end
    if player:isZoneVisited(tpz.zone.MERIPHATAUD_MOUNTAINS_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.MERIPHATAUD_MOUNTAINS_S))
    end
    if player:isZoneVisited(tpz.zone.VUNKERL_INLET_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.VUNKERL_INLET_S))
    end
    if player:isZoneVisited(tpz.zone.GRAUBERG_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.GRAUBERG_S))
    end
    if player:isZoneVisited(tpz.zone.FORT_KARUGO_NARUGO_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.FORT_KARUGO_NARUGO_S))
    end
    if player:isZoneVisited(tpz.zone.EAST_RONFAURE_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.EAST_RONFAURE_S))
    end
    if player:isZoneVisited(tpz.zone.NORTH_GUSTABERG_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.NORTH_GUSTABERG_S))
    end
    if player:isZoneVisited(tpz.zone.WEST_SARUTABARUTA_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.WEST_SARUTABARUTA_S))
    end
    -- Note: There is a gap here for bits 15, 16, and 17.  The menu supports but does not use these slots for the 3 WotG Towns
    if player:isZoneVisited(tpz.zone.GARLAIGE_CITADEL_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.GARLAIGE_CITADEL_S))
    end
    if player:isZoneVisited(tpz.zone.CRAWLERS_NEST_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.CRAWLERS_NEST_S))
    end
    if player:isZoneVisited(tpz.zone.THE_ELDIEME_NECROPOLIS_S) then
        allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1,campaignZone.THE_ELDIEME_NECROPOLIS_S))
    end

    if allowedTeleports == 0 then
        -- If a player manages to get to a CA in town w/o going through any past zones - dont show an empty menu - show a "no thanks option"
        allowedTeleports = 1
    end

    return allowedTeleports
 end

 ----------------------------------------------------------------------------------------------------------
 -- showTeleportOption
 -- returns 32 (the hide teleport option flag value) if the npc is in the zone the player would retrace to
 ----------------------------------------------------------------------------------------------------------
 function showTeleportOption(npc, campaignAllegiance)
    -- Note all CampaignNPCs should reject players with no allegiance
    local menuOptions = 0
    if (npc:getZoneID() == tpz.zone.BASTOK_MARKETS_S and campaignAllegiance == 2) or
        (npc:getZoneID() == tpz.zone.SOUTHERN_SAN_DORIA_S and campaignAllegiance == 1) or
        (npc:getZoneID() == tpz.zone.WINDURST_WATERS_S and campaignAllegiance == 3) then
            menuOptions = 32
    end
    return menuOptions
 end

 function doesNpcMatchAllegiance(player, campaignEvent)
    local campaignAllegiance = player:getCampaignAllegiance()
    local returnVal = 0
    -- TODO turn the 454, 455, 456, 457 into an ENUM for readability
    if campaignEvent == 454 and campaignAllegiance == 1 then
        returnVal = 1
    elseif campaignEvent == 455 and campaignAllegiance == 2 then
        returnVal = 1
    elseif campaignEvent == 456 and campaignAllegiance == 3 then
        returnVal = 1
    elseif campaignEvent == 457 then -- Jeuno CA implies Beastmen control
        returnVal = 0
    end

    return returnVal
 end