------------------------------------
-- Dynamis
------------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
------------------------------------

dynamis = {}

--[[
[zone] =
{
    csBit    = the bit in the Dynamis_Status player variable that records whether player has beaten this dynamis
               this bit number is also given to the start Dynamis event and message.
    csSand   = event ID for cutscene where Cornelia gives you the vial of shrouded sand
    csWin    = event ID for cutscene after you have beaten this Dynamis
    csDyna   = event ID for entering Dynamis
    winVar   = variable used to denote players who have beaten this Dynamis, but not yet viewed the cutscene
    winKI    = key item given as reward for this Dynamis
    enterPos = coordinates where player will be placed when entering this Dynamis
    reqs     = function that returns true if player meets requirements for entering this Dynamis
               minimum level and timer are checked separately
}
--]]

-- todo, just put me in dynaInfo
dynamis.entryInfo =
{
    [tpz.zone.SOUTHERN_SAN_DORIA] =
    {
        csBit = 1,
        csSand = 686,
        csWin = 698,
        csDyna = 685,
        winVar = "DynaSandoria_Win",
        hasEnteredVar = "DynaSandoria_HasEntered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos = {161.838, -2.000, 161.673, 93, 185},
        reqs = function(player) return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) end,
    },
    [tpz.zone.BASTOK_MINES] =
    {
        csBit = 2,
        csSand = 203,
        csWin = 215,
        csDyna = 201,
        winVar = "DynaBastok_Win",
        hasEnteredVar = "DynaBastok_HasEntered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_EYEGLASS,
        enterPos = {116.482, 0.994, -72.121, 128, 186},
        reqs = function(player) return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) end,
    },
    [tpz.zone.WINDURST_WALLS] =
    {
        csBit = 3,
        csSand = 455,
        csWin = 465,
        csDyna = 452,
        winVar = "DynaWindurst_Win",
        hasEnteredVar = "DynaWindurst_HasEntered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_LANTERN,
        enterPos = {-221.988, 1.000, -120.184, 0, 187},
        reqs = function(player) return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) end,
    },
    [tpz.zone.RULUDE_GARDENS] =
    {
        csBit = 4,
        csSand = 10016,
        csWin = 10026,
        csDyna = 10012,
        winVar = "DynaJeuno_Win",
        hasEnteredVar = "DynaJeuno_HasEntered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_TACTICAL_MAP,
        enterPos = {48.930, 10.002, -71.032, 195, 188},
        reqs = function(player) return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) end,
    },
    [tpz.zone.BEAUCEDINE_GLACIER] =
    {
        csBit = 5,
        csWin = 134,
        csDyna = 119,
        winVar = "DynaBeaucedine_Win",
        hasEnteredVar = "DynaBeaucedine_HasEntered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_INSIGNIA,
        enterPos = {-284.751, -39.923, -422.948, 235, 134},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                   player:hasKeyItem(tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER) and
                   player:hasKeyItem(tpz.ki.HYDRA_CORPS_EYEGLASS) and
                   player:hasKeyItem(tpz.ki.HYDRA_CORPS_LANTERN) and
                   player:hasKeyItem(tpz.ki.HYDRA_CORPS_TACTICAL_MAP)
        end,
    },
    [tpz.zone.XARCABARD] =
    {
        csBit = 6,
        csWin = 32,
        csDyna = 16,
        winVar = "DynaXarcabard_Win",
        hasEnteredVar = "DynaXarcabard_HasEntered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos = {569.312, -0.098, -270.158, 90, 135},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                   player:hasKeyItem(tpz.ki.HYDRA_CORPS_INSIGNIA)
        end,
    },
    [tpz.zone.VALKURM_DUNES] =
    {
        csBit = 7,
        csFirst = 33,
        csWin = 39,
        csDyna = 58,
        winVar = "DynaValkurm_Win",
        hasEnteredVar = "DynaValkurm_HasEntered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_VALKURM_SLIVER,
        enterPos = {100, -8, 131, 47, 39},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                  (player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) or FREE_COP_DYNAMIS == 1)
        end,
    },
    [tpz.zone.BUBURIMU_PENINSULA] =
    {
        csBit = 8,
        csFirst = 40,
        csWin = 46,
        csDyna = 22,
        winVar = "DynaBuburimu_Win",
        hasEnteredVar = "DynaBuburimu_HasEntered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_BUBURIMU_SLIVER,
        enterPos = {155, -1, -169, 170, 40},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                  (player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) or FREE_COP_DYNAMIS == 1)
        end,
    },
    [tpz.zone.QUFIM_ISLAND] =
    {
        csBit = 9,
        csFirst = 22,
        csWin = 28,
        csDyna = 3,
        winVar = "DynaQufim_Win",
        hasEnteredVar = "DynaQufim_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_QUFIM_SLIVER,
        enterPos = {-19, -17, 104, 253, 41},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                  (player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) or FREE_COP_DYNAMIS == 1)
        end,
    },
    [tpz.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit = 10,
        csFirst = 614,
        csWin = 615,
        csDyna = 588,
        winVar = "DynaTavnazia_Win",
        hasEnteredVar = "DynaTavnazia_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos = {0.1, -7, -21, 190, 42},
        reqs = function(player)
            return player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) and
                   player:hasKeyItem(tpz.ki.DYNAMIS_BUBURIMU_SLIVER) and
                   player:hasKeyItem(tpz.ki.DYNAMIS_QUFIM_SLIVER) and
                   player:hasKeyItem(tpz.ki.DYNAMIS_VALKURM_SLIVER) and
                  (player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) or FREE_COP_DYNAMIS == 1)
        end,
    },
}

dynamis.dynaInfo =
{
    [tpz.zone.DYNAMIS_SAN_DORIA] =
    {
        winVar = "DynaSandoria_Win",
        hasEnteredVar = "DynaSandoria_HasEntered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        winTitle = tpz.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        entryPos = {161.838, -2.000, 161.673, 93, tpz.zone.DYNAMIS_SAN_DORIA},
        ejectPos = {161.000, -2.000, 161.000, 94, tpz.zone.SOUTHERN_SAN_DORIA},
    },
    [tpz.zone.SOUTHERN_SAN_DORIA] = 
    {
        dynaZone = tpz.zone.DYNAMIS_SAN_DORIA,
        dynaZoneMessageParam = 1,
    },
    [tpz.zone.DYNAMIS_BASTOK] =
    {
        winVar = "DynaBastok_Win",
        hasEnteredVar = "DynaBastok_HasEntered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_EYEGLASS,
        winTitle = tpz.title.DYNAMIS_BASTOK_INTERLOPER,
        entryPos = {116.482, 0.994, -72.121, 128, tpz.zone.DYNAMIS_BASTOK},
        ejectPos = {112.000, 0.994, -72.000, 127, tpz.zone.BASTOK_MINES},
    },
    [tpz.zone.BASTOK_MINES] = 
    {
        dynaZone = tpz.zone.DYNAMIS_BASTOK,
        dynaZoneMessageParam = 2,
    },
    [tpz.zone.DYNAMIS_WINDURST] =
    {
        winVar = "DynaWindurst_Win",
        hasEnteredVar = "DynaWindurst_HasEntered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_LANTERN,
        winTitle = tpz.title.DYNAMIS_WINDURST_INTERLOPER,
        entryPos = {-221.988, 1.000, -120.184, 0 , tpz.zone.DYNAMIS_WINDURST},
        ejectPos = {-217.000, 1.000, -119.000, 94, tpz.zone.WINDURST_WALLS},
    },
    [tpz.zone.WINDURST_WALLS] = 
    {
        dynaZone = tpz.zone.DYNAMIS_WINDURST,
        dynaZoneMessageParam = 3,
    },
    [tpz.zone.DYNAMIS_JEUNO] =
    {
        winVar = "DynaJeuno_Win",
        hasEnteredVar = "DynaJeuno_HasEntered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_TACTICAL_MAP,
        winTitle = tpz.title.DYNAMIS_JEUNO_INTERLOPER,
        entryPos = {48.930, 10.002, -71.032, 195, tpz.zone.DYNAMIS_JEUNO},
        ejectPos = {48.930, 10.002, -71.032, 195, tpz.zone.RULUDE_GARDENS},
    },
    [tpz.zone.RULUDE_GARDENS] = 
    {
        dynaZone = tpz.zone.DYNAMIS_JEUNO,
        dynaZoneMessageParam = 4,
    },
    [tpz.zone.DYNAMIS_BEAUCEDINE] =
    {
        winVar = "DynaBeaucedine_Win",
        hasEnteredVar = "DynaBeaucedine_HasEntered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_INSIGNIA,
        winTitle = tpz.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
        entryPos = {-284.751, -39.923, -422.948, 235, tpz.zone.RULUDE_GARDENS},
        ejectPos = {-284.751, -39.923, -422.948, 235, tpz.zone.BEAUCEDINE_GLACIER},
    },
    [tpz.zone.BEAUCEDINE_GLACIER] = 
    {
        dynaZone = tpz.zone.DYNAMIS_BEAUCEDINE,
        dynaZoneMessageParam = 5,
    },
    [tpz.zone.DYNAMIS_XARCABARD] =
    {
        winVar = "DynaXarcabard_Win",
        hasEnteredVar = "DynaXarcabard_HasEntered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_BATTLE_STANDARD,
        winTitle = tpz.title.DYNAMIS_XARCABARD_INTERLOPER,
        entryPos = {569.312, -0.098, -270.158, 90, tpz.zone.DYNAMIS_XARCABARD},
        ejectPos = {569.312, -0.098, -270.158, 90, tpz.zone.XARCABARD},
    },
    [tpz.zone.XARCABARD] = 
    {
        dynaZone = tpz.zone.DYNAMIS_XARCABARD,
        dynaZoneMessageParam = 6,
    },
    [tpz.zone.DYNAMIS_VALKURM] =
    {
        winVar = "DynaValkurm_Win",
        hasEnteredVar = "DynaValkurm_HasEntered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_VALKURM_SLIVER,
        winTitle = tpz.title.DYNAMIS_VALKURM_INTERLOPER,
        entryPos = {100, -8, 131, 47, tpz.zone.DYNAMIS_VALKURM},
        ejectPos = {119, -9, 131, 52, tpz.zone.VALKURM_DUNES},
    },
    [tpz.zone.VALKURM_DUNES] = 
    {
        dynaZone = tpz.zone.DYNAMIS_VALKURM,
        dynaZoneMessageParam = 7,
    },
    [tpz.zone.DYNAMIS_BUBURIMU] =
    {
        winVar = "DynaBuburimu_Win",
        hasEnteredVar = "DynaBuburimu_HasEntered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_BUBURIMU_SLIVER,
        winTitle = tpz.title.DYNAMIS_BUBURIMU_INTERLOPER,
        entryPos = {155, -1, -169, 170, tpz.zone.DYNAMIS_BUBURIMU},
        ejectPos = {154, -1, -170, 190, tpz.zone.BUBURIMU_PENINSULA},
    },
    [tpz.zone.BUBURIMU_PENINSULA] = 
    {
        dynaZone = tpz.zone.DYNAMIS_BUBURIMU,
        dynaZoneMessageParam = 8,
    },
    [tpz.zone.DYNAMIS_QUFIM] =
    {
        winVar = "DynaQufim_Win",
        hasEnteredVar = "DynaQufim_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_QUFIM_SLIVER,
        winTitle = tpz.title.DYNAMIS_QUFIM_INTERLOPER,
        entryPos = {-19, -17, 104, 253, tpz.zone.DYNAMIS_QUFIM},
        ejectPos = { 18, -19, 162, 240, tpz.zone.QUFIM_ISLAND},
    },
    [tpz.zone.QUFIM_ISLAND] = 
    {
        dynaZone = tpz.zone.DYNAMIS_QUFIM,
        dynaZoneMessageParam = 9,
    },
    [tpz.zone.DYNAMIS_TAVNAZIA] =
    {
        winVar = "DynaTavnazia_Win",
        hasEnteredVar = "DynaTavnazia_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_TAVNAZIA_SLIVER,
        winTitle = tpz.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        entryPos = {0.1, -7, -21, 190, tpz.zone.DYNAMIS_TAVNAZIA},
        ejectPos = {0  , -7, -23, 195, tpz.zone.TAVNAZIAN_SAFEHOLD},
    },
    [tpz.zone.TAVNAZIAN_SAFEHOLD] = 
    {
        dynaZone = tpz.zone.DYNAMIS_TAVNAZIA,
        dynaZoneMessageParam = 10,
    },
    
}

dynamis.eyes =
{
    NONE    = 0,
    RED     = 1,
    BLUE    = 2,
    GREEN   = 3,
}

dynamis.timeless = 4236
dynamis.perpetual = 4237
dynamis.min_lvl = 65
dynamis.reservation_cancel = 180
dynamis.reentry_days = 3
dynamis.maxchars = 64

dynamis.entryNpcOnTrigger = function(player, npc)
    -- todo: generalize the function function onTrigger(player, npc) in bastok_mines Trail_Markings.lua
end

dynamis.entryNpcOnEventFinish = function(player, csid, option)
    -- todo: generalize the function onEventFinish(player, csid, option) in bastok_mines Trail_Markings.lua
end

dynamis.zoneOnInitialize = function(zone)
    
end

dynamis.zoneOnZoneIn = function(player, prevZone)
    local zoneId = player:getZoneID()
    local info = dynamis.dynaInfo[zoneId]
    local ID = zones[zoneId]
    
    -- usually happens when zoning in with !zone command
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then player:setPos(info.entryPos[1],info.entryPos[2],info.entryPos[3],info.entryPos[4]) end
    
    if player:verifyHoldsValidHourglass() == true then
        player:updateHourglassExpireTime()
        player:timer(1000, function(player)
            player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, math.floor(GetDynaTimeRemaining(zoneId)/60), 1)
            if player:dynaCurrencyAutoDropEnabled() == true then player:PrintToPlayer("As the original registrant of this instance, Dynamis currencies will auto-drop to you when possible (use !currency to opt out).",29) end
        end)
        if player:getCharVar("DynaBypassWeakness") == 0 then player:addStatusEffect(tpz.effect.WEAKNESS, 1, 3, 60*15) end
        player:setCharVar("DynaBypassWeakness", 0)
    end
    
    return -1
end

dynamis.spawnWave = function(mobList, waveNumber)
    local iStart = 4096*4096+(4096*mobList.zoneID)
    local i = iStart
    local iEnd = iStart + 1023
    
    while i <= iEnd do
        if mobList[i] ~= nil and mobList[i].waves ~= nil and mobList[i].waves[waveNumber] ~= nil and GetMobByID(i):isSpawned() == false then SpawnMob(i) end
        i = i + 1
    end
end

dynamis.statueOnSpawn = function(mob, eyes) -- says statue but this is also called by anything that spawn children mobs (like ahriman)
    mob:setLocalVar("dynaReadyToSpawnChildren", 1)
    mob:AnimationSub(eyes)
end

dynamis.statueOnDeath = function(mob, player, isKiller)
    local eyes = mob:AnimationSub()
    
    if isKiller and (eyes == dynamis.eyes.BLUE or eyes == dynamis.eyes.GREEN) then
        -- MP or HP refill
        local zone = mob:getZone()
        local players = zone:getPlayers()
        for name, player in pairs(players) do
            if mob:checkDistance(player) < 30 then
                if eyes == dynamis.eyes.BLUE then
                    local amt = player:getMaxMP() - player:getMP()
                    player:restoreMP(amt)
                    player:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, amt)
                else
                    local amt = player:getMaxHP() - player:getHP()
                    player:restoreHP(amt)
                    player:messageBasic(tpz.msg.basic.RECOVERS_HP, 0, amt)
                end
            end
        end
    end
end

dynamis.statueOnEngaged = function(mob, target, mobList, randomChildrenList)
    if mob:getLocalVar("dynaReadyToSpawnChildren") == 0 then return end
    mob:setLocalVar("dynaReadyToSpawnChildren", 0)
    
    local mobID = mob:getID()
    local specificChildrenList = nil
    local randomChildrenCount = nil
    if mobList[mobID] ~= nil then
        randomChildrenCount = mobList[mobID].randomChildrenCount
        specificChildrenList = mobList[mobID].specificChildren
    end
    
    local i = 1
    while specificChildrenList ~= nil and specificChildrenList[i] ~= nil do
        local child = GetMobByID(specificChildrenList[i])
        if mobList[specificChildrenList[i]].pos == nil then child:setSpawn(mob:getXPos()+math.random()*2-1, mob:getYPos(), mob:getZPos()+math.random()*2-1, mob:getRotPos()) end
        SpawnMob(specificChildrenList[i]):updateEnmity(target)
        i = i + 1
    end
    i = 1
    while randomChildrenList ~= nil and randomChildrenCount ~= nil and randomChildrenCount > 0 do
        local originalRoll = math.random(1,#randomChildrenList)
        local roll = originalRoll
        while GetMobByID(randomChildrenList[roll]):isSpawned() == true and roll ~= nil do
            roll = roll + 1
            if roll > #randomChildrenList then roll = 1 end
            if roll == originalRoll then roll = nil end
        end
        if roll ~= nil then
            local child = GetMobByID(randomChildrenList[roll])
            local home = child:getSpawnPos()
            local randomSpawn = false
            if home.x == 1 and home.y == 1 and home.z == 1 then
                child:setSpawn(mob:getXPos()+math.random()*2-1, mob:getYPos(), mob:getZPos()+math.random()*2-1, mob:getRotPos())
                randomSpawn = true
            end
            SpawnMob(randomChildrenList[roll]):updateEnmity(target)
            if randomSpawn == true then child:setLocalVar("clearSpawnPosOnDeath", 1) end
        else
            break
        end
        randomChildrenCount = randomChildrenCount - 1
    end
end

dynamis.mobOnRoamAction = function(mob)
    
end

dynamis.mobOnDeath = function (mob, mobList, msg)
    local mobID = mob:getID()
    if mobList[mobID] ~= nil and mobList[mobID].timeExtension ~= nil then mob:addTimeToDynamis(mobList[mobID].timeExtension, msg) end
    if child:getLocalVar("clearSpawnPosOnDeath") == 1 then mob:setSpawn(1,1,1,0) end
    
    local i = 2
    local j = 1
    local mobFound = false
    while mobList.waveDefeatRequirements[i] ~= nil and mobFound == false do
        while mobList.waveDefeatRequirements[i][j] ~= nil do
            if mobList.waveDefeatRequirements[i][j] == mobID then
                mobFound = true
                i = i - 1
                break
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end
    
    if mobFound == true then -- mob's defeat is a requirement for wave number i
        mob:setLocalVar("dynaIsDefeatedForWaveReq", 1)
        local allReqsMet = true
        while mobList.waveDefeatRequirements[i][j] ~= nil do
            if GetMobByID(mobList.waveDefeatRequirements[i][j]):getLocalVar("dynaIsDefeatedForWaveReq") == 0 then
                allReqsMet = false
                break
            end
            j = j + 1
        end
        if allReqsMet == true then dynamis.spawnWave(mobList, i) end
    end
end

dynamis.mobOnRoam = function(mob)
    local home = mob:getSpawnPos()
    local location = mob:getPos()
    mob:pathTo(home.x, home.y, home.z)
    if location.x == home.x and location.y == home.y and location.z == home.z and location.rot ~= home.rot then mob:setPos(location.x, location.y, location.z, home.rot) end
end

dynamis.qmOnTrade = function(player, npc, trade) -- i think this is for Xarcabard, so remember to update this once we start work on that
    local npcId = npc:getID()
    local zoneId = npc:getZoneID()
    local ID = zones[zoneId]
    local QM = ID.npc.QM

    if QM then
        local info = QM[npcId]

        if info then
            for _, v in pairs(info.trade) do
                if npcUtil.tradeHasExactly(trade, v.item) then
                    local mobId
                    if type(v.mob) == "table" then
                        mobId = v.mob[math.random(#v.mob)]
                    else
                        mobId = v.mob
                    end
                    if mobId and npcUtil.popFromQM(player, npc, mobId, {hide = 0, radius = 2}) then
                        player:confirmTrade()
                    end
                    break
                end
            end
        else
            printf("[dynamis.qmOnTrade] called on in zone %i on npc %i (%s) that does not appear in QM data.", zoneId, npcId, npc:getName())
        end
    else
        printf("[dynamis.qmOnTrade] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.", npcId, npc:getName(), zoneId)
    end
end

dynamis.qmOnTrigger = function(player, npc)
    local npcId = npc:getID()
    local zoneId = npc:getZoneID()
    local ID = zones[zoneId]
    local QM = ID.npc.QM

    if QM then
        local info = QM[npcId]

        if info then
            if info.param then
                player:startEvent(102, unpack(info.param))
            elseif info.trade and #info.trade == 1 and info.trade[1].item and type(info.trade[1].item) == "number" and ID.text.OMINOUS_PRESENCE then
                player:messageSpecial(ID.text.OMINOUS_PRESENCE, info.trade[1].item)
            end
        else
            printf("[dynamis.qmOnTrigger] called on in zone %i on npc %i (%s) that does not appear in QM data.", zoneId, npcId, npc:getName())
        end
    else
        printf("[dynamis.qmOnTrigger] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.", npcId, npc:getName(), zoneId)
    end
end

--------------------------------------------------
-- getDynamisMapList
-- Produces a bitmask for the goblin ancient currency NPCs
--------------------------------------------------

function getDynamisMapList(player)
    local bitmask = 0
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_SANDORIA) == true) then
        bitmask = bitmask + 2
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BASTOK) == true) then
        bitmask = bitmask + 4
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_WINDURST) == true) then
        bitmask = bitmask + 8
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_JEUNO) == true) then
        bitmask = bitmask + 16
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BEAUCEDINE) == true) then
        bitmask = bitmask + 32
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_XARCABARD) == true) then
        bitmask = bitmask + 64
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_VALKURM) == true) then
        bitmask = bitmask + 128
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BUBURIMU) == true) then
        bitmask = bitmask + 256
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_QUFIM) == true) then
        bitmask = bitmask + 512
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_TAVNAZIA) == true) then
        bitmask = bitmask + 1024
    end

    return bitmask
end