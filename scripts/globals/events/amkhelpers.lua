-- TODO: Headers
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/zone")
local OHR_ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
local QS_ID = require("scripts/zones/Quicksand_Caves/IDs")
local XARC_ID = require("scripts/zones/Xarcabard/IDs")
local BEAUC_ID = require("scripts/zones/Beaucedine_Glacier/IDs")

amkHelpers = amkHelpers or {}

-- AMK mission 4 - Welcome! To My Decrepit Domicile
-- key items obtainable anytime after completing quest, but squintrox limits once per day
amkHelpers.helmTrade = function(player, helmType)
    local amkChance = 8
    local regionId = player:getCurrentRegion()
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE and
        tpz.expansionRegion.ORIGINAL_ROTZ[regionId] and
        math.random(100) <= amkChance
    then
        local helmMapping = {
            [tpz.helm.type.MINING] = tpz.ki.STURDY_METAL_STRIP,
            [tpz.helm.type.LOGGING] = tpz.ki.PIECE_OF_RUGGED_TREE_BARK,
            [tpz.helm.type.HARVESTING] = tpz.ki.SAVORY_LAMB_ROAST,
        }
        if
            helmMapping[helmType] ~= nil and
            not player:hasKeyItem(helmMapping[helmType])
        then
            npcUtil.giveKeyItem(player, helmMapping[helmType])
        end
    end
end

-- AMK mission 6 - An Errand! The Professor's Price (Cardian fight)
amkHelpers.cardianOrbDrop = function(mob, player)
    local currentMission_AMK = player:getCurrentMission(AMK)
    if currentMission_AMK < tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE then return false end

    local orbs = {
        [61] =  tpz.ki.ORB_OF_BATONS,
        [509] = tpz.ki.ORB_OF_COINS,
        [510] = tpz.ki.ORB_OF_CUPS,
        [511] = tpz.ki.ORB_OF_SWORDS,
    }

    if mob:getLocalVar("[AMK]5_dropOrb") == 0 then
        local chance = math.random(1000)
        local reqChance = 10 * 0.5 * mob:getMainLvl() + 4 * (utils.clamp(#player:getAlliance(), 1, 6) - 6)
        -- printf("reqChance: %d, chance: %d", reqChance, chance)
        if chance < reqChance then
            mob:setLocalVar("[AMK]5_dropOrb", 1)
        else
            mob:setLocalVar("[AMK]5_dropOrb", 2)
        end
    end

    local orb = orbs[mob:getFamily()]

    if
        orb and
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE and
        not player:hasKeyItem(orb) and
        mob:getLocalVar("[AMK]5_dropOrb") == 1
    then
        npcUtil.giveKeyItem(player, orb)
        return true
    end
    return false
end

-- reports number of orbs a player has for custom cardian encounter
-- pass 1 to remove orbs as well
amkHelpers.getOrbs = function(player, remove)
    local orbs = {count = 0}
    for orb = tpz.ki.ORB_OF_SWORDS, tpz.ki.ORB_OF_COINS, 1 do
        if player:hasKeyItem(orb) then
            orbs.count = orbs.count + 1
            orbs[orb] = 1
            if remove == 1 then
                player:delKeyItem(orb)
                player:messageSpecial(OHR_ID.text.KEYITEM_LOST, orb)
            end
        end
    end
    return orbs
end

local confrontationTimer
confrontationTimer = function(npc)
    local player = GetPlayerByID(npc:getLocalVar("[AMK]5_fightInitiator"))
    local receivedWarning = 1
    if player then
        receivedWarning = player:getLocalVar("[AMK]5_cardianWarning")
    else
        return
    end
    local mobsLeft = 0
    local playersLeft = 0
    local playersOutOfRange = 0
    local result = 0
    local reason = nil
    if npc:getLocalVar("[AMK]forceFail") == 1 then
        result = result + 1
        reason = 'deaggro'
    end
    local confrontationEnd = function(winResult, reason)
        for _, mobID in pairs(OHR_ID.mob.CUSTOM_CARDIANS) do
            DespawnMob(mobID)
        end
        local player = GetPlayerByID(npc:getLocalVar("[AMK]5_fightInitiator"))
        if player then
            for _, end_member in pairs(player:getAlliance()) do
                end_member:delStatusEffect(tpz.effect.CONFRONTATION)
                end_member:delStatusEffect(tpz.effect.LEVEL_RESTRICTION)
                if winResult == true then
                    if end_member:getLocalVar("[AMK]5_deservesWin") == 1 then
                        if end_member:getCurrentMission(AMK) == tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE then
                            npcUtil.giveKeyItem(end_member, tpz.ki.RIPE_STARFRUIT)
                        end
                        npcUtil.giveKeyItem(end_member, tpz.ki.PEACH_CORAL_KEY)
                    end
                    end_member:addExp(500)
                elseif reason == "distance" then
                    end_member:messageSpecial(OHR_ID.text.VENTURED_FAR_DISENGAGE)
                end
                end_member:setLocalVar("[AMK]5_cardianWarning", 0)
                end_member:setLocalVar("[AMK]5_deservesWin", 0)
            end
        end
        npc:setLocalVar("[AMK]5_fightInitiator", 0)
        npc:setLocalVar("[AMK]forceFail", 0)
    end

    for _, mobID in pairs(OHR_ID.mob.CUSTOM_CARDIANS) do
        if GetMobByID(mobID):isAlive() then
            mobsLeft = mobsLeft + 1
        end
    end

    -- Confirm all members are within battlefield range
    for _, member in pairs(player:getAlliance()) do
        if member:hasStatusEffect(tpz.effect.CONFRONTATION) then
            if member:isAlive() then
                playersLeft = playersLeft + 1
            end
            if member:checkDistance(npc) > 50 then
                if receivedWarning == 1 then
                    result = result + 1
                    reason = 'distance'
                else
                    member:messageSpecial(OHR_ID.text.VENTURED_FAR_WARNING)
                    -- set variable on the initial player
                    playersOutOfRange = playersOutOfRange + 1
                    player:setLocalVar("[AMK]5_cardianWarning", 1)
                end
            end
        end
    end
    if playersOutOfRange == 0 then
        -- set variable on the initial player
        player:setLocalVar("[AMK]5_cardianWarning", 0)
    end

    -- Confirm all players alive and initiating player still in zone
    if playersLeft == 0 then
        result = result + 1
    end

    if player:getZoneID() ~= tpz.zone.OUTER_HORUTOTO_RUINS then
        reason = 'distance'
        result = result + 1
    end

    -- Win Condition
    if result > 0 then
        confrontationEnd(false, reason)
    elseif playersLeft > 0 and mobsLeft == 0 then
        confrontationEnd(true, reason)
    end

    -- Reset timer
    -- always runs one more tick, but should exit immediately at the top of confrontationTimer
    npc:timer(5 * 1000, function(npc)
        confrontationTimer(npc)
    end)
end

-- AMK mission 7 - An Errand! The Professor's Price
-- key item(s) obtainable anytime after completing quest, but squintrox limits once per day
amkHelpers.cardianOnTrigger = function(player, npc)
    if player:getCurrentMission(AMK) >= tpz.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE and not player:hasKeyItem(tpz.ki.RIPE_STARFRUIT) then
        if amkHelpers.getOrbs(player, 0).count > 0 then
            player:startEvent(100)
        else
            player:messageSpecial(OHR_ID.text.IF_HAD_ORBS, tpz.ki.ORB_OF_SWORDS, tpz.ki.ORB_OF_CUPS, tpz.ki.ORB_OF_BATONS, tpz.ki.ORB_OF_COINS)
        end
    else
        player:messageSpecial(OHR_ID.text.DEVICE_NOT_WORKING)
    end
end

amkHelpers.cardianOnEventFinish = function(player, csid, option)
    if not (csid == 100 and option == 1) then return end
    local npc = GetNPCByID(OHR_ID.npc.QM1)
    local party = player:getAlliance()
    local numCardians = {
        -- defines how many custom cardians to pull from OHR.mobs.CUSTOM_CARDIANS, a table of non-sequential mobids
        [1] = 20,
        [2] = 15,
        [3] = 10,
        [4] = 5,
    }

    local playerOrbs = amkHelpers.getOrbs(player, 0)
    local numToSpawn = numCardians[playerOrbs.count]

    local mobs = {}
    for cardianId = 1, numToSpawn do
        table.insert(mobs, OHR_ID.mob.CUSTOM_CARDIANS[cardianId])
    end

    for _, member in pairs(party) do
        -- add all party members within 50 yalms
        if member:getZoneID() == player:getZoneID() and member:checkDistance(npc) <= 50 then
            member:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 75, 0, 0)
            -- 30 - minute time limit. When status wears, mobs disengage and despawn
            member:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 30 * 60)
            member:despawnPet()

            -- Check who in the fight has at least one orb to receive credit on win
            local memberOrbs = amkHelpers.getOrbs(member, 1)
            if memberOrbs.count > 0 then
                member:setLocalVar("[AMK]5_deservesWin", 1)
            end
        end
    end

    -- Resistances based on orbs player had, stored on QM to be set on each cardian on spawn
    npc:setLocalVar("[AMK]5_orb_swords", 0)
    npc:setLocalVar("[AMK]5_orb_cups", 0)
    npc:setLocalVar("[AMK]5_orb_batons", 0)
    npc:setLocalVar("[AMK]5_orb_coins", 0)
    if playerOrbs[tpz.ki.ORB_OF_SWORDS] == 1 then
        npc:setLocalVar("[AMK]5_orb_swords", 1)
    end
    if playerOrbs[tpz.ki.ORB_OF_CUPS] == 1 then
        npc:setLocalVar("[AMK]5_orb_cups", 1)
    end
    if playerOrbs[tpz.ki.ORB_OF_BATONS] == 1 then
        npc:setLocalVar("[AMK]5_orb_batons", 1)
    end
    if playerOrbs[tpz.ki.ORB_OF_COINS] == 1 then
        npc:setLocalVar("[AMK]5_orb_coins", 1)
    end

    -- Vary the cardians' jobs between rdm, whm, and blm and add confrontation effect
    for _, mobID in pairs(mobs) do
        local mob = GetMobByID(mobID)
        local job = tpz.job.WHM + (mobID % 3)
        local sjob = tpz.job.WHM + ((mobID + 1) % 3)

        mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 0)
        mob:changeJob(job)
        mob:changesJob(sjob)
        mob:setSpellList(job - 2)
    end

    -- pops all mobs in list then respawns QM when they are all gone
    npcUtil.popFromQM(player, npc, mobs, { look = true, claim = true, hide = 1} )
    npc:setLocalVar("[AMK]5_fightInitiator", player:getID())
    npc:setLocalVar("[AMK]forceFail", 0)
    confrontationTimer(npc)
end

-- AMK mission 7 - Shock! An Arrant Abuse of Authority
    -- WINGSCUSTOM: Some values are custom, not listed on wiki.
    -- Wiki correct locations are denoted by their corresponding map coordinates (eg. (F-11))
amkHelpers.digSites = {
    [tpz.zone.VALKURM_DUNES] =
    {
        { x = -518.039, z = 133.930 },
        { x = 237.421, z = -153.886 },
        { x = 912.032, z = -324.621 },
    },
    [tpz.zone.JUGNER_FOREST] =
    {
        { x = -359.881, z = 27.948 },
        { x = -73.022, z = 349.066 },
        { x = 212.000, z = -91.000 },
    },
    [tpz.zone.KONSCHTAT_HIGHLANDS] =
    {
        { x = 558.450, z = 458.885 },
        { x = -352.037, z = 27.853 },
        { x = -319.470, z = -350.070 },
        { x = -150.686, z = -709.612 },
    },
    [tpz.zone.PASHHOW_MARSHLANDS] =
    {
        { x = 275.196, z = 413.774 },
        { x = -64.840, z = 121.987 },
        { x = 214.593, z = -264.132 },
    },
    [tpz.zone.TAHRONGI_CANYON] =
    {
        { x = 209.773, z = 401.845 },
        { x = -359.840, z = 158.644 },
        { x = 80.678, z = -434.589 },
    },
    [tpz.zone.BUBURIMU_PENINSULA] =
    {
        { x = -8.216, z = -272.361 },
        { x = 194.909, z = 79.212 },
        { x = -16.117, z = 247.111 },
    },
    [tpz.zone.MERIPHATAUD_MOUNTAINS] =
    {
        { x = 534.076, z = 612.650 },
        { x = 608.206, z = -512.886 },
        { x = 169.780, z = 169.583 },
    },
    [tpz.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        { x = -439.047, z = 122.349 }, -- (E-8)
        { x = -343.491, z = 133.725 }, -- (F-8) test this one
        { x = -177.383, z = -279.362 }, -- (G-10)
        { x = 13.719, z = 88.664 }, -- (H-8)
        { x = 20.483, z = -146.541 }, -- (H-9)
        { x = 236.046, z = -273.312 }, -- (I-10)
        { x = 275.428, z = 159.460 },-- (J-7)
    },
    [tpz.zone.YUHTUNGA_JUNGLE] =
    {
        { x = -555.544, z = -80.067 }, -- (E-9)
        { x = -438.777, z = -388.825 }, -- (F-11)
        { x = -402.770, z = -259.826 }, -- (F-10)
        { x = -201.421, z = -438.868 }, -- (G-11)
        { x = 294.342, z = 211.039 }, -- (J-7)
        { x = 122.505, z = 432.139 }, -- (I-6)
        { x = -122.441, z = 444.200 }, -- (H-6)
        { x = -130.948, z = 203.126 }, -- (H-7)
    },
    [tpz.zone.YHOATOR_JUNGLE] =
    {
        { x = -2.428, z = -359.037 }, -- (H-10)
        { x = -397.683, z = -260.857 }, -- (F-9)
        { x = -385.761, z = -383.388 }, -- (F-10)
        { x = 93.417, z = -96.931 }, -- (I-8)
        { x = -83.513, z = 224.256 }, -- (H-6)
        { x = -231.969, z = -144.198 }, -- (G-9)
    },
    [tpz.zone.WESTERN_ALTEPA_DESERT] =
    {
        { x = -400.274, z = 71.055 }, -- (F-7)
        { x = -559.809, z = -357.840 },
        { x = -460.332, z = -725.726 },
        { x = -811.215, z = -643.663 },
        { x = -220.780, z = -674.947 },
        { x = -261.211, z = 13.288 },
        { x = -197.272, z = 372.010 },
        { x = 674.245, z = 46.084 }, -- (M-7)
        { x = -0.805, z = 354.229 }, -- (I-5)
        { x = 334.699, z = 105.761 }, -- (K-7)
    },
    [tpz.zone.EASTERN_ALTEPA_DESERT] =
    {
        { x = -309.358, z = 49.217 }, -- (F-8)
        { x = 419.165, z = 38.675 }, -- (J-8)
        { x = 368.639, z = -208.379 }, -- (J-9)
        { x = 29.012, z = -401.275 }, -- (H-10)
        { x = -209.142, z = 290.642 }, -- (F-6)
        { x = 20.214, z = 73.494 }, -- (H-8)
        { x = -218.196, z = 4.195 }, -- (F-8)
        { x = 85.507, z = 313.316}, -- (H-6)
        { x = 469.810, z = 222.405 }, -- (J-7)
        { x = -214.823, z = -185.996 }, -- (F-9)
    },
}

-- AMK06 and AMK07 - Select/lookup the digging zone
amkHelpers.getDiggingZone = function(player)
    local digZone = player:getCharVar("[AMK]6_diggingZone")
    if digZone == 0 or amkHelpers.digSites[digZone] == nil then
        local count = 0
        local digSitesSize = 0
        for k,v in pairs(amkHelpers.digSites) do digSitesSize = digSitesSize + 1 end
        local randval = math.random(digSitesSize)
        for k,v in pairs(amkHelpers.digSites) do
            count = count + 1
            if count == randval then
                digZone = k
                break
            end
        end
        player:setCharVar("[AMK]6_diggingZone", digZone)
    end
    return digZone
end

-- called every chocobo dig in any zone, exits if zone is not valid or player is not eligible for key item
amkHelpers.chocoboDig = function(player, zoneID, text)
    local playerPos = player:getPos()
    local digZoneID = amkHelpers.getDiggingZone(player)
    local digSpot = player:getLocalVar("[AMK]6_diggingSpot")
    -- printf("got here, digzone: %s, digzoneid: %s zoneID: %s, shockprogress: %s", digZoneID, digZoneID, zoneID, shockProgress)

    if
        player:getCurrentMission(AMK) < tpz.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY or
        player:hasKeyItem(tpz.ki.MOLDY_WORMEATEN_CHEST) or
        digZoneID ~= zoneID
    then
        -- printf("returning false")
        return false
    elseif digSpot == 0 then
        -- printf("shock: %s, needed to zone: %s", shockProgress, player:needToZone())
        player:needToZone(true)
        player:setLocalVar("[AMK]6_diggingSpot", math.random(#amkHelpers.digSites[digZoneID]))
        digSpot = player:getLocalVar("[AMK]6_diggingSpot")
    end

    -- Distance between points
    local playerX = playerPos.x
    local playerZ = playerPos.z
    local targetX = amkHelpers.digSites[digZoneID][digSpot].x
    local targetZ = amkHelpers.digSites[digZoneID][digSpot].z
    local dx = playerX - targetX
    local dy = targetZ - playerZ
    local distance = math.sqrt(math.pow(targetX - playerX, 2) + math.pow(targetZ - playerZ, 2))

    -- Success!
    if distance <= 4 then
        npcUtil.giveKeyItem(player, tpz.ki.MOLDY_WORMEATEN_CHEST)
        player:setCharVar("[AMK]6_diggingZone", 0)
        return true
    end

    -- Angle between points
    -- NOTE: ALIGNED TO EAST! DUE EAST = 0
    local theta = math.atan2(dy, dx)
    local angle = (theta * 180/math.pi + 202.5) % 360
    local direction = math.floor(angle * (8/360))

    -- Your Chocobo is pulling at the bit
    -- You Sense that it is leading you to the [compass direction]
    player:messageSpecial(text.AMK_DIGGING_OFFSET + 6, direction)

    -- No additional hint (Approx: 201'+ from target)
    if distance > 200 then
    -- You have a hunch this area would be favored by moogles... (Approx. 81-200' from target or two map grids)
    elseif distance > 120 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 5, direction)
    -- You have a vague feeling that a moogle would enjoy traversing this terrain... (Approx. 51-80' from target)
    elseif distance > 80 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 4, direction)
    -- You suspect that the scenery around here would be to a moogle's liking... (Approx. 21-50' from target)
    elseif distance > 50 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 3, direction)
    -- You have a feeling your moogle friend has been through this way... (Approx. 11-20' from target)
    elseif distance > 20 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 2, direction)
    -- You get the distinct sense that your moogle friend frequents this spot... (Approx. 5-10' from target)
    elseif distance > 10 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 1, direction)
    -- You are convinced that your moogle friend has been digging in the immediate vicinity. (Less than 5' from target)
    elseif distance > 6 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET, direction)
    end

    return false
end

-- AMK Mission 9 - Marker sites in quicksands
amkHelpers.getMarkerSet = function(player)
    local markerSet = player:getCharVar('[AMK]8_rescueMarkerSet')
    if markerSet == 0 then
        markerSet = math.random(10)
        player:setCharVar('[AMK]8_rescueMarkerSet', markerSet)
    end
    return markerSet
end

amkHelpers.markers = {
    -- [qm#] = marker ID
    [1]  = 17629660,
    [8]  = 17629744,
    [9]  = 17629745,
    [10] = 17629746,
    [11] = 17629747,
    [12] = 17629748,
    [13] = 17629749,
    [14] = 17629750,
    [15] = 17629751,
    [16] = 17629752,
    [17] = 17629753,
    [18] = 17629754,
    [19] = 17629755,
    [20] = 17629756,
    [21] = 17629757,
    [22] = 17629758,
    [23] = 17629759,
    [24] = 17629760,
    [26] = 17629762,
    [27] = 17629763,
}

amkHelpers.markerSets = {
    {1, 8, 11, 13, 14, 17, 20, 26, 27},
    {9, 10, 12, 15, 17, 19, 22, 23, 24},
    {8, 12, 13, 14, 16, 18, 21, 26, 27},
    {1, 9, 10, 11, 14, 15, 16, 23, 24},
    {8, 10, 13, 14, 17, 18, 19, 21, 27},
    {1, 9, 11, 12, 14, 15, 20, 24, 26},
    {8, 11, 13, 16, 17, 18, 21, 22, 23},
    {1, 9, 10, 12, 14, 19, 20, 23, 27},
    {8, 10, 13, 15, 16, 17, 22, 24, 26},
    {8, 11, 12, 18, 19, 20, 21, 24, 27},
}

-- Mission 9 - Rescue! A Moogle's Labor of Love
-- marker set is the index of the markerSets above, which correspond to the NPC ids above that
amkHelpers.qmAMKOnTrigger = function(player, npc)
    local markerSet = player:getCharVar("[AMK]8_rescueMarkerSet")
    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE and
        player:getCharVar('[AMK]8_rescueProgress') == 2 and
        markerSet ~= 0
    then
        local item = 0
        for i = 1, 9 do
            if npc:getID() == amkHelpers.markers[amkHelpers.markerSets[markerSet][i]] then
                item = tpz.ki.STONE_OFFSET + i
            end
        end
        if
            item ~= 0 and
            (not player:hasKeyItem(item))
        then
            npcUtil.giveKeyItem(player, item)
        else
            player:messageSpecial(QS_ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:messageSpecial(QS_ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

-- Mission 13 (index 12) - Puzzles!!!
-- Puzzle 1
amkHelpers.pipSets = {
    -- { Pips
    --     [1] = NW, [4] = NE,
    --     [2] = W,  [5] = E,
    --     [3] = SW, [6] = SE,
    -- },
    { -- 0
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 2,
        [3] = 4, [6] = 3,
    },
    { -- 1
        [1] = 1, [4] = 3,
        [2] = 1, [5] = 4,
        [3] = 1, [6] = 3,
    },
    { -- 2
        [1] = 0, [4] = 7,
        [2] = 5, [5] = 6,
        [3] = 4, [6] = 3,
    },
    { -- 3
        [1] = 2, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 2, [6] = 3,
    },
    { -- 4
        [1] = 6, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 1, [6] = 3,
    },
    { -- 5
        [1] = 1, [4] = 0,
        [2] = 2, [5] = 3,
        [3] = 5, [6] = 4,
    },
    { -- 6
        [1] = 1, [4] = 0,
        [2] = 2, [5] = 3,
        [3] = 3, [6] = 4,
    },
    { -- 7
        [1] = 4, [4] = 3,
        [2] = 1, [5] = 4,
        [3] = 1, [6] = 3,
    },
    { -- 8
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 4, [6] = 3,
    },
    { -- 9
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 1, [6] = 3,
    },

}

-- Pips have the following order: NW, W, SW, NE, E, SE
-- note that the [AMK]12_puzzle_1_pipSet variable is offset by 1 to avoid index 0
amkHelpers.pipTrigger = function(player, npc, offset)
    local map = tpz.ki.MAP_OF_THE_NORTHLANDS_AREA
    local pos = npc:getPos()
    local pipSet = player:getCharVar("[AMK]12_puzzle_1_pipSet")
    local PIP_CS_OFFSET = 509

    if
        player:getCurrentMission(AMK) >= tpz.mission.id.amk.A_CHALLENGE_YOU_COULD_BE_A_WINNER and
        player:hasKeyItem(tpz.ki.MAP_OF_THE_NORTHLANDS_AREA) and
        player:getCharVar("[AMK]12_puzzle") == 1 and
        pipSet > 0 and
        player:needToZone()
    then
        local element = amkHelpers.pipSets[pipSet][offset]
        -- the event handles placing the pip on the map with the proper element
        player:startEvent(PIP_CS_OFFSET + offset, pos.x * 1000, pos.z * 1000, pos.y * 1000, element, map)
    else
        player:messageSpecial(BEAUC_ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

-- Puzzle 2 ------------
-- CSID 200 trigger params: question number, correct answer (stoogeNum), previous stooge, stooge location, time limit, current time, player ID?
-- CSID 200 update params:  answer 1, location 1, answer 2, location 2, cs moogle location, time limit, current time, player id?
-- trivia locations: 0 = option one, 1 = option two, 2 = option three
-- Stooge CS locations: 1 = option one, 2 = option two, 3 = option three
-- Variables are named as 'option' if 0-indexed, as 'stooge' if 1-indexed
------------------------

-- Assigns or retrieves question set, then converts set of three ints to mask 
-- to store as a char var, and returns question set as table of ints
amkHelpers.getTriviaQuestions = function(player)
    local q_nums = amkHelpers.getTriviaQuestionKeys()
    local mask = player:getCharVar("[AMK]12_puzzle_2_q_mask")
    if mask == 0 then
        local q = amkHelpers.getTriviaQuestionKeys()
        for i=1, 3 do
            local num = table.remove(q, math.random(1, #q))
            mask = mask + 2 ^ num
        end
        player:setCharVar("[AMK]12_puzzle_2_q_mask", mask)
    end
    local questions = {}
    for i=1, #q_nums do
        if bit.band(mask, 2 ^ q_nums[i]) > 0 then
            table.insert(questions, q_nums[i])
        end
    end
    return questions -- table{int, int, int}
end

amkHelpers.getTriviaQuestionKeys = function()
    local keys = {}
    for key, _ in pairs(amkHelpers.triviaQuestions) do
        table.insert(keys, key)
    end
    return keys
end

-- returns -1 or 1 to offset the wrong answer randomly
local sign = function() return math.random(1,2) == 1 and -1 or 1 end

-- structured list of the trivia questions
amkHelpers.triviaQuestions = {
     -- TODO: figure out way to add questions 4, 6, 7, 8, and 9

    -- 0 : Add your current hit points to your current magic points, and you get…?
    [0] = function(player)
        local right = player:getHP() + player:getMP()
        local wrong = right + (sign() * 10)
        return {right, wrong}
    end,
    -- 1 : The sum total of each and every one of your job levels is?
    [1] = function(player)
        local job_total = 0
        for i = tpz.job.WAR, tpz.job.RUN do
            job_total = job_total + player:getJobLevel(i)
        end
        local right = job_total
        local wrong = right + (sign() * math.random(1, 15))
        return {right, wrong}
    end,
    -- 2 : The sum total of each of your crafting skill levels is?
    [2] = function(player)
        local craft_total = 0
        for i = tpz.skill.WOODWORKING, tpz.skill.COOKING do
            craft_total = craft_total + player:getCharSkillLevel(i) / 10
        end
        local right = craft_total
        local wrong = right + (sign() * math.random(1, 10))
        wrong = utils.clamp(wrong, 0, wrong)
        return {right, wrong}
    end,
    -- 3 : The sum total of each one of your current elemental resistance levels is?
    [3] = function(player)
        local element_total = 0
        for i = tpz.mod.FIRERES, tpz.mod.DARKRES do
            element_total = element_total + player:getMod(i)
        end
        local right = element_total
        local wrong = right + (sign() * math.random(1, 10))
        return {right, wrong}
    end,
    -- 4 : The total number of foes you’ve felled is?
    -- 5 : Multiply your current attack and defense, and what do you get!?
    [5] = function(player)
        local right = player:getStat(tpz.mod.ATT) * player:getStat(tpz.mod.DEF)
        local wrong = right + (sign() * math.random(21, 88))
        return {right, wrong}
    end,
    -- 6 : The total number of times you’ve strolled through the doors of your Mog House is?
    -- 7 : The total number of times you’ve been incapacitated by your enemies is?
    -- 8 : The total number of times you’ve participated in a party is?
    -- 9 : The total number of times you’ve affiliated yourself with an alliance is?
}

amkHelpers.resetPuzzleVars = function(player)
    player:setCharVar("[AMK]12_puzzle_2_progress", 0)
    player:setCharVar("[AMK]12_puzzle_2_time_limit", 0)
    player:setCharVar("[AMK]12_puzzle_2_q_mask", 0)
    player:setCharVar("[AMK]12_puzzle_2_correct", 0)
    player:setCharVar("[AMK]12_puzzle_2_prev_option", 0)
    player:setCharVar("[AMK]12_puzzle_2_q_stooge", 0)
end

-- handles mappings for which option NPC each choice sends you to
local optionStooges = {
    [17236359] = { option = 0, stoogeNum = 1, answerOne = 1, answerTwo = 2},
    [17236360] = { option = 1, stoogeNum = 2, answerOne = 0, answerTwo = 2},
    [17236361] = { option = 2, stoogeNum = 3, answerOne = 0, answerTwo = 1},
}

amkHelpers.puzzleTwoOnEventTrigger = function(player, npc)
    local progress = player:getCharVar("[AMK]12_puzzle_2_progress")
    local timeLimit = player:getCharVar("[AMK]12_puzzle_2_time_limit")
    local correctStooge = player:getCharVar("[AMK]12_puzzle_2_correct")
    local previousOption = player:getCharVar("[AMK]12_puzzle_2_prev_option")
    local playerQuestions = amkHelpers.getTriviaQuestions(player)
    local currentQuestion = playerQuestions[progress]
    local stoogeNum = optionStooges[npc:getID()].stoogeNum

    -- DEBUG
    -- player:PrintToPlayer(string.format("progress: %s, time_lim: %s, currentq: %s, correctoption: %s, prev option: %s",
    --                                     progress,     timeLimit,   currentQuestion, correctStooge,   previousOption))

    if
        ENABLE_AMK == 1 and
        player:getCharVar("[AMK]12_puzzle") == 2
    then
        if
            progress == 0 or
            player:needToZone() == false
        then
            progress = 1
            player:setCharVar("[AMK]12_puzzle_2_progress", 1)
        end

        if previousOption == stoogeNum then
            -- TODO: repeat question text
        elseif player:hasKeyItem(tpz.ki.TRIVIA_CHALLENGE_KUPON) == true then
            player:setCharVar("[AMK]12_puzzle_2_q_stooge", npc:getID()) -- Save the moogle id to retrieve in update
            player:startEvent(200, progress, currentQuestion, correctStooge, previousOption,
                            stoogeNum, timeLimit, os.time(), player:getID())
            if timeLimit > 0 and timeLimit < os.time() then
                amkHelpers.resetPuzzleVars(player)
            end
        else
            player:startEvent(200, 11)
        end
    else
        player:messageSpecial(XARC_ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

amkHelpers.puzzleTwoOnEventUpdate = function(player, csid, option)
    local npcID = player:getCharVar("[AMK]12_puzzle_2_q_stooge")
    local answerOptionOne = optionStooges[npcID].answerOne
    local answerOptionTwo = optionStooges[npcID].answerTwo
    local thisOption = optionStooges[npcID].option

    if
        csid == 200 and
        option >= 1 and
        option <= 3
    then
        player:needToZone(true)
        local timeLimit = os.time() + 180
        local playerQuestions = amkHelpers.getTriviaQuestions(player)
        local currentQuestion = playerQuestions[player:getCharVar("[AMK]12_puzzle_2_progress")]
        local answers = amkHelpers.triviaQuestions[currentQuestion](player)
        local answerOne = math.random(1,2)
        local answerTwo = 1
        local correctOption = answerOptionTwo
        if answerOne == 1 then
            answerTwo = 2
            correctOption = answerOptionOne
        end

        player:setCharVar("[AMK]12_puzzle_2_correct", correctOption + 1)
        player:setCharVar("[AMK]12_puzzle_2_time_limit", timeLimit)
        player:setCharVar("[AMK]12_puzzle_2_prev_option", thisOption + 1)

        player:updateEvent(
            answers[answerOne], answerOptionOne, answers[answerTwo], answerOptionTwo,
            currentQuestion, timeLimit, os.time(), player:getID()
        )
    elseif option == 11 then
        -- Lost game, reset all vars
        amkHelpers.resetPuzzleVars(player)
        player:messageSpecial(math.random(XARC_ID.text.INCORRECT_NO_GIFTS, XARC_ID.text.EXACTLY_WRONG))
    end
end

amkHelpers.puzzleTwoOnEventFinish = function(player, csid, option)
    local progress = player:getCharVar("[AMK]12_puzzle_2_progress")
    if csid == 200 then
        if option == 1 then
            player:setCharVar("[AMK]12_puzzle_2_progress", progress + 1)
        elseif option == 2 and progress == 4 then
            -- Won game, reset all vars
            amkHelpers.resetPuzzleVars(player)
            npcUtil.giveKeyItem(player, tpz.ki.GAUNTLET_CHALLENGE_KUPON)
            player:setCharVar("[AMK]12_puzzle_2_progress", 10)
            -- Advance var to puzzle 3, set initial value to 1
            player:setCharVar("[AMK]12_puzzle", 3)
            player:setCharVar("[AMK]12_puzzle_3_stoogeArg", 1)
        end
    end
end