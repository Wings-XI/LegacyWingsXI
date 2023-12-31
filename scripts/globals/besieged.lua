-----------------------------------
--
--     Functions for Besieged system
--
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/missions")
-----------------------------------

tpz = tpz or {}
tpz.besieged = tpz.besieged or {}

tpz.besieged.onTrade = function(player, npc, trade)
    local expRings =
    {
    [15761] = {price=350, charges=7},
    [15762] = {price=700, charges=7},
    [15763] = {price=600, charges=3},
    }
    local item = trade:getItemId()
    local tradeConfirmed = false
    local mOffset  = zones[player:getZoneID()].text.BESIGED_RECHARGE
    if not tradeConfirmed and expRings[item] and npcUtil.tradeHas(trade, item) then
        if BYPASS_EXP_RING_ONE_PER_WEEK == 1 or player:getCharVar("CONQUEST_RING_RECHARGE") < os.time() then
            local ring = expRings[item]

            if player:getCurrency("imperial_standing") >= ring.price then
                player:delCurrency("imperial_standing", ring.price)
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

tpz.besieged.onTrigger = function(player, npc, eventBase)
    local mercRank = tpz.besieged.getMercenaryRank(player)
    if mercRank == 0 then
        player:startEvent(eventBase + 1, npc)
    else
        local maps = getMapBitmask(player)
        player:startEvent(eventBase, player:getCurrency("imperial_standing"), maps, mercRank, 0, unpack(getImperialDefenseStats()))
    end
end

tpz.besieged.onEventUpdate = function(player, csid, option)
    local itemId = getISPItem(option)

    if itemId == 4181 then
        player:PrintToPlayer("NOTICE: WotG era cost for the Scroll of Instant Warp is 750 IS.",29)
    elseif itemId == 4182 then
        player:PrintToPlayer("NOTICE: WotG era cost for the Scroll of Instant Reraise is 500 IS.",29)
    end


    if itemId and option < 0x40000000 then
        local maps = getMapBitmask(player)
        player:updateEvent(player:getCurrency("imperial_standing"), maps, tpz.besieged.getMercenaryRank(player), player:canEquipItem(itemId) and 2 or 1, unpack(getImperialDefenseStats()))
    end
end

tpz.besieged.onEventFinish = function(player, csid, option)
    local ID = zones[player:getZoneID()]
    local ISP = player:getCurrency("imperial_standing")
    if (option == 0 or option == 16 or option == 32 or option == 48) and player:hasCompletedMission(TOAU,1) then -- immortal sentries
        -- Sanction
        if option ~= 0 then
            player:delCurrency("imperial_standing", 100)
        end

        player:delStatusEffectsByFlag(tpz.effectFlag.INFLUENCE, true)
        local duration = getSanctionDuration(player)
        local subPower = 0 -- getImperialDefenseStats()
        player:addStatusEffect(tpz.effect.SANCTION, option / 16, 0, duration, subPower)
        player:messageSpecial(ID.text.SANCTION)
    elseif bit.band(option, 0xFF) == 17 then
        -- Player bought a map
        if ISP >= 1000 then
            local ki = tpz.ki.MAP_OF_MAMOOK + bit.rshift(option, 8)
            npcUtil.giveKeyItem(player, ki)
            player:delCurrency("imperial_standing", 1000)
        else
            player:PrintToPlayer("Your Imperial Standing is too low to purchase that item.", 29)
        end
    elseif option < 0x40000000 then
        -- Player bought an item
        local item, price = getISPItem(option)
        if item and ISP >= price then
            if npcUtil.giveItem(player, item) then
                player:delCurrency("imperial_standing", price)
            end
        else
            player:PrintToPlayer(string.format("Your Imperial Standing is too low to purchase that item (WOTG cost is %u).", price), 29)
        end
    end
end

-----------------------------------------------------------------
-- Variable for addTeleport and getRegionPoint
-----------------------------------------------------------------
LEUJAOAM_ASSAULT_POINT = 0
MAMOOL_ASSAULT_POINT = 1
LEBROS_ASSAULT_POINT = 2
PERIQIA_ASSAULT_POINT = 3
ILRUSI_ASSAULT_POINT = 4
NYZUL_ISLE_ASSAULT_POINT = 5

tpz.besieged.addRunicPortal = function(player, portal)
    player:addTeleport(tpz.teleport.type.RUNIC_PORTAL, portal)
end

tpz.besieged.hasRunicPortal = function(player, portal)
    return player:hasTeleport(tpz.teleport.type.RUNIC_PORTAL, portal)
end

tpz.besieged.hasAssaultOrders = function(player)
    local event = 0
    local keyitem = 0

    for i = 0, 4 do
        local ki = tpz.ki.LEUJAOAM_ASSAULT_ORDERS + i
        if player:hasKeyItem(ki) then
            event = 120 + i
            keyitem = ki
            break
        end
    end

    -- NYZUL_ISLE_ASSAULT_ORDERS ID is non sequential
    if player:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) then
        event = 125
        keyitem = tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS
    end

    return event, keyitem
end

-- TODO: Implement Astral Candescence
tpz.besieged.getAstralCandescence = function()
    return 1 -- Hardcoded to 1 for now
end

tpz.besieged.badges = { 780, 783, 784, 794, 795, 825, 826, 827, 894, 900, 909 }

tpz.besieged.getMercenaryRank = function(player)
    local rank = 0

    for _, v in ipairs(tpz.besieged.badges) do
        if player:hasKeyItem(v) then
            rank = rank + 1
        end
    end

    return rank
end

local assaultLevels =
{
    50, 50, 60, 60, 60, 70, 70, 70, 70, 70,
    60, 60, 70, 60, 70, 50, 70, 70, 70, 70,
    50, 60, 70, 70, 70, 60, 70, 70, 70, 70,
    70, 70, 70, 60, 70, 50, 60, 70, 70, 70,
    60, 70, 70, 50, 60, 70, 60, 70, 70, 70,
    75, 99
}

function getRecommendedAssaultLevel(assaultid)
    return assaultLevels[assaultid]
end

function getMapBitmask(player)
    local mamook = player:hasKeyItem(tpz.ki.MAP_OF_MAMOOK) and 1 or 0 -- Map of Mammok
    local halvung = player:hasKeyItem(tpz.ki.MAP_OF_HALVUNG) and 2 or 0 -- Map of Halvung
    local arrapago = player:hasKeyItem(tpz.ki.MAP_OF_ARRAPAGO_REEF) and 4 or 0 -- Map of Arrapago Reef
    local astral = bit.lshift(tpz.besieged.getAstralCandescence(), 31) -- Include astral candescence in the top byte

    return bit.bor(mamook, halvung, arrapago, astral)
end

-----------------------------------------------------------------------------------
-- function getSanctionDuration(player) returns the duration of the sanction effect
-- in seconds. Duration is known to go up with mercenary rank but data published on
-- ffxi wiki (http://wiki.ffxiclopedia.org/wiki/Sanction) is unclear and even
-- contradictory (the page on the AC http://wiki.ffxiclopedia.org/wiki/Astral_Candescence
-- says that duration is 3-8 hours with the AC, 1-3 hours without the AC while the Sanction
-- page says it's 3-6 hours with th AC.)
--
-- I decided to use the formula duration (with AC) = 3 hours + (mercenary rank - 1) * 20 minutes.
-----------------------------------------------------------------------------------
function getSanctionDuration(player)
    local duration = 10800 + 1200 * (tpz.besieged.getMercenaryRank(player) - 1)

    if tpz.besieged.getAstralCandescence() == 0 then
        duration = duration / 2
    end

    return duration
end

-----------------------------------------------------------------------------------
-- function getImperialDefenseStats() returns:
-- *how many successive times Al Zahbi has been defended
-- *Imperial Defense Value
-- *Total number of imperial victories
-- *Total number of beastmen victories.
-- hardcoded constants for now until we have a Besieged system.
-----------------------------------------------------------------------------------
function getImperialDefenseStats()
    local successiveWins = 0
    local defenseBonus = 0
    local imperialWins = 0
    local beastmanWins = 0
    return { successiveWins, defenseBonus, imperialWins, beastmanWins }
end

------------------------------------------------------------------------------
-- function getISPItem(i) returns the item ID and cost of the imperial standing
-- points item indexed by i (the same value  as that used by the vendor event.)
-------------------------------------------------------------------------------
function getISPItem(i)
    local IS_item =
    {
        -- Common Items
        [1] = {id = 4182, price = 500}, -- scroll of Instant Reraise
        [4097] = {id = 4181, price = 750}, -- scroll of Instant Warp
        [8193] = {id = 2230, price = 100}, -- lambent fire cell
        [12289] = {id = 2231, price = 100}, -- lambent water cell
        [16385] = {id = 2232, price = 100}, -- lambent earth cell
        [20481] = {id = 2233, price = 100}, -- lambent wind cell
        [24577] = {id = 19021, price = 20000}, -- katana strap
        [28673] = {id = 19022, price = 20000}, -- axe grip
        [32769] = {id = 19023, price = 20000}, -- staff strap
        --[36865] = {id = 3307, price = 5000}, -- heat capacitor
        --[40961] = {id = 3308, price = 5000}, -- power cooler
        --[45057] = {id = 3309, price = 5000}, -- barrage turbine
        --[53249] = {id = 3311, price = 5000}, -- galvanizer
        [57345] = {id = 6409, price = 50000},
        -- Private Second Class
        -- Map Key Items (handled separately)
        -- Private First Class
        [33] = {id = 18689, price = 2000}, -- volunteer's dart
        [289] = {id = 18690, price = 2000}, -- mercenary's dart
        [545] = {id = 18691, price = 2000}, -- Imperial dart
        -- Superior Private
        [49] = {id = 18692, price = 4000}, -- Mamoolbane
        [305] = {id = 18693, price = 4000}, -- Lamiabane
        [561] = {id = 18694, price = 4000}, -- Trollbane
        [817] = {id = 15810, price = 4000}, -- Luzaf's ring
        -- Lance Corporal
        [65] = {id = 15698, price = 8000}, -- sneaking boots
        [321] = {id = 15560, price = 8000}, -- trooper's ring
        [577] = {id = 16168, price = 8000}, -- sentinel shield
        -- Corporal
        [81] = {id = 18703, price = 16000}, -- shark gun
        [337] = {id = 18742, price = 16000}, -- puppet claws
        [593] = {id = 17723, price = 16000}, -- singh kilij
        -- Sergeant
        [97] = {id = 15622, price = 24000}, -- mercenary's trousers
        [353] = {id = 15790, price = 24000}, -- multiple ring
        [609] = {id = 15981, price = 24000}, -- haten earring
        -- Sergeant Major
        [113] = {id = 15623, price = 32000}, -- volunteer's brais
        [369] = {id = 15982, price = 32000}, -- priest's earring
        [625] = {id = 15983, price = 32000}, -- chaotic earring
        -- Chief Sergeant
        [129] = {id = 17741, price = 40000}, -- perdu hanger
        [385] = {id = 18943, price = 40000}, -- perdu sickle
        [641] = {id = 18850, price = 40000}, -- perdu wand
        [897] = {id = 18717, price = 40000}, -- perdu bow
        -- Second Lieutenant
        [145] = {id = 16602, price = 48000}, -- perdu sword
        [401] = {id = 18425, price = 48000}, -- perdu blade
        [657] = {id = 18491, price = 48000}, -- perdu voulge
        [913] = {id = 18588, price = 48000}, -- perdu staff
        [1169] = {id = 18718, price = 48000}, -- perdu crossbow
        -- First Lieutenant
        [161] = {id = 16271, price = 56000}, -- lieutenant's gorget
        [417] = {id = 15912, price = 56000}, -- lieutenant's sash
        [673] = {id = 16230, price = 56000} -- lieutenant's cape
    }
    local item = IS_item[i]
    if item then
        return item.id, item.price
    end

    return nil
end
