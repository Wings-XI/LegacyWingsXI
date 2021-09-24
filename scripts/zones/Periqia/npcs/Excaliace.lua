-----------------------------------
-- Area: Periqia
--  NPC: Excaliace
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
require("scripts/globals/besieged")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
-----------------------------------

local path =
{
    [0] =
    {
        [0]  = {-322, -16, 380}, -- Spawn Pos
        [1]  = {-309, -16, 378},
        [2]  = {-307, -16, 374},
        [3]  = {-300, -16, 366}, -- START
    },
    [1] = -- main pathing
    {
        [1]  = {-243, -16, 420}, -- END Mission Fail
        [2]  = {-250, -16, 419},
        [3]  = {-254, -16, 413},
        [4]  = {-261, -16, 411},
        [5]  = {-266, -16, 415},
        [6]  = {-271, -16, 419},
        [7]  = {-277, -16, 420},
        [8]  = {-285, -16, 420},
        [9]  = {-292, -16, 424},
        [10] = {-299, -16, 429},
        [11] = {-304, -16, 420},
        [12] = {-301, -16, 411},
        [13] = {-300, -16, 403},
        [14] = {-301, -16, 395},
        [15] = {-303, -16, 388},
        [16] = {-300, -16, 381},
        [17] = {-296, -16, 376},
        [18] = {-297, -16, 371},
        [19] = {-300, -16, 366}, -- START
        [20] = {-300, -16, 355},
        [21] = {-302, -16, 342},
        [22] = {-314, -16, 341},
        [23] = {-326, -16, 341},
        [24] = {-333, -16, 345},
        [25] = {-340, -16, 349},
        [26] = {-344, -16, 340},
        [27] = {-341, -16, 330},
        [28] = {-340, -16, 320},
        [29] = {-341, -16, 308},
        [30] = {-340, -16, 300}, -- Top Rooms Option
        [31] = {-341, -16, 293},
        [32] = {-340, -16, 284},
        [33] = {-340, -16, 273},
        [34] = {-340, -16, 262}, -- Middle Rooms Option
        [35] = {-340, -16, 252},
        [36] = {-340, -16, 240},
        [37] = {-340, -16, 229},
        [38] = {-341, -16, 221}, -- Bottom Rooms Option
        [39] = {-340, -16, 209},
        [40] = {-340, -17, 201},
        [41] = {-340, -17, 192}, -- Lower Fork Option
    },
    [2] = -- Top Rooms Right path
    {
        [1]  = {-344, -16, 300},
        [2]  = {-349, -16, 300},
        [3]  = {-358, -16, 300},
        [4]  = {-366, -16, 300},
        [5]  = {-373, -16, 300},
        [6]  = {-380, -16, 300},
        [7]  = {-387, -16, 300}, -- Room End Point
    },
    [3] = -- Top Rooms Left path
    {
        [1]  = {-336, -16, 300},
        [2]  = {-329, -16, 300},
        [3]  = {-323, -16, 300},
        [4]  = {-313, -16, 300},
        [5]  = {-302, -16, 300},
        [6]  = {-297, -16, 300},
        [7]  = {-290, -16, 300}, -- Room End Point
    },
    [4] = -- Middle Rooms Right path
    {
        [1]  = {-344, -16, 260},
        [2]  = {-349, -16, 260},
        [3]  = {-358, -16, 260},
        [4]  = {-366, -16, 260},
        [5]  = {-373, -16, 260},
        [6]  = {-380, -16, 260},
        [7]  = {-387, -16, 260}, -- Room End Point
    },
    [5] = -- Middle Rooms Left path
    {
        [1]  = {-335, -16, 260},
        [2]  = {-329, -16, 260},
        [3]  = {-323, -16, 260},
        [4]  = {-313, -16, 260},
        [5]  = {-302, -16, 260},
        [6]  = {-297, -16, 260},
        [7]  = {-290, -16, 260}, -- Room End Point
    },
    [6] = -- Bottom Rooms Right path
    {
        [1]  = {-344, -16, 220},
        [2]  = {-349, -16, 220},
        [3]  = {-358, -16, 220},
        [4]  = {-366, -16, 220},
        [5]  = {-373, -16, 220},
        [6]  = {-380, -16, 220},
        [7]  = {-387, -16, 220}, -- Room End Point
    },
    [7] = -- Bottom Rooms Left path
    {
        [1]  = {-335, -16, 220},
        [2]  = {-329, -16, 220},
        [3]  = {-323, -16, 220},
        [4]  = {-313, -16, 220},
        [5]  = {-302, -16, 220},
        [6]  = {-297, -16, 220},
        [7]  = {-290, -16, 220}, -- Room End Point
    },
    [8] = -- Lower Fork Right Path
    {
        [1]  = {-346, -17, 189},
        [2]  = {-351, -17, 184},
        [3]  = {-357, -17, 180},
        [4]  = {-367, -17, 180},
        [5]  = {-377, -17, 178},
        [6]  = {-381, -17, 169},
        [7]  = {-380, -17, 161},
        [8]  = {-380, -17, 151},
        [9]  = {-386, -17, 146},
        [10] = {-389, -17, 141},
        [11] = {-386, -17, 135},
        [12] = {-381, -17, 129},
        [13] = {-380, -17, 119},
        [14] = {-380, -17, 114},
        [15] = {-377, -17, 108},
        [16] = {-379, -17, 102},
        [17] = {-383, -17,  98},
        [18] = {-383, -17,  93},
        [19] = {-381, -17,  86},
        [20] = {-380, -17,  77}, -- common path start
        [21] = {-378, -17,  67},
        [22] = {-376, -17,  59},
        [23] = {-379, -17,  52},
        [24] = {-385, -17,  52},
        [25] = {-389, -17,  58},
        [26] = {-395, -17,  60},
        [27] = {-403, -17,  61},
        [28] = {-410, -17,  62},
        [29] = {-417, -17,  68},
        [30] = {-423, -17,  66},
        [31] = {-424, -17,  57},
        [32] = {-420, -17,  48},
        [33] = {-419, -17,  40},
        [34] = {-419, -17,  33},
        [35] = {-414, -17,  26},
        [36] = {-409, -17,  19},
        [37] = {-411, -17,  14},
        [38] = {-416, -17,  10},
        [39] = {-420, -17,   5},
        [40] = {-420, -17,  -3},
        [41] = {-419, -17, -12},
        [42] = {-416, -17, -21},
        [43] = {-420, -17, -28},
        [44] = {-426, -17, -27},
        [45] = {-432, -17, -21},
        [46] = {-439, -17, -20},
        [47] = {-445, -17, -20},
        [48] = {-451, -17, -26},
        [49] = {-460, -10, -30},
        [50] = {-461, -10, -40},
        [51] = {-460, -10, -50},
        [52] = {-462, -10, -60},
        [53] = {-467, -10, -63},
        [54] = {-478, -10, -63},
        [55] = {-481, -10, -71},
        [56] = {-486, -10, -76},
        [57] = {-485, -10, -75}, -- END Mission Complete
    },
    [9] = -- Lower Fork Left Path
    {
        [1]  = {-336, -16, 190},
        [2]  = {-332, -16, 185},
        [3]  = {-324, -16, 180},
        [4]  = {-315, -16, 180},
        [5]  = {-308, -16, 179},
        [6]  = {-302, -16, 174},
        [7]  = {-300, -16, 169},
        [8]  = {-300, -16, 162},
        [9]  = {-300, -16, 155},
        [10] = {-295, -16, 150},
        [11] = {-293, -16, 146},
        [12] = {-296, -16, 142},
        [13] = {-302, -16, 138},
        [14] = {-306, -16, 137},
        [15] = {-314, -16, 139},
        [16] = {-320, -16, 140},
        [17] = {-332, -16, 140},
        [18] = {-341, -16, 135},
        [19] = {-341, -16, 129},
        [20] = {-340, -16, 120},
        [21] = {-340, -16, 111},
        [22] = {-341, -16, 105},
        [23] = {-346, -16, 102},
        [24] = {-355, -16, 101},
        [25] = {-364, -16, 100},
        [26] = {-370, -16,  97},
        [27] = {-374, -16,  93},
        [28] = {-378, -16,  87},
        [29] = {-380, -16,  83},
        [30] = {-380, -17,  77}, -- common path start
        [31] = {-378, -17,  67},
        [32] = {-376, -17,  59},
        [33] = {-379, -17,  52},
        [34] = {-385, -17,  52},
        [35] = {-389, -17,  58},
        [36] = {-395, -17,  60},
        [37] = {-403, -17,  61},
        [38] = {-410, -17,  62},
        [39] = {-417, -17,  68},
        [40] = {-423, -17,  66},
        [41] = {-424, -17,  57},
        [42] = {-420, -17,  48},
        [43] = {-419, -17,  40},
        [44] = {-419, -17,  33},
        [45] = {-414, -17,  26},
        [46] = {-409, -17,  19},
        [47] = {-411, -17,  14},
        [48] = {-416, -17,  10},
        [49] = {-420, -17,   5},
        [50] = {-420, -17,  -3},
        [51] = {-419, -17, -12},
        [52] = {-416, -17, -21},
        [53] = {-420, -17, -28},
        [54] = {-426, -17, -27},
        [55] = {-432, -17, -21},
        [56] = {-439, -17, -20},
        [57] = {-445, -17, -20},
        [58] = {-451, -17, -26},
        [59] = {-460, -10, -30},
        [60] = {-461, -10, -40},
        [61] = {-460, -10, -50},
        [62] = {-462, -10, -60},
        [63] = {-467, -10, -63},
        [64] = {-478, -10, -63},
        [65] = {-481, -10, -71},
        [66] = {-486, -10, -76},
        [67] = {-485, -10, -75}, -- END Mission Complete
    },
}
local ONPATH_SPEED = 40
local RUNAWAY_SPEED = 60
local STOP_SPEED = 0

function onSpawn(npc)
    npc:setAllegiance(1)
    npc:initNpcAi()
    npc:setLocalVar("moveStatus", 0)  -- 0 = Walking Forward, 1 = Running Back, 2 = Stop
    npc:setLocalVar("missionStarted", 0) -- boolean to know if the escort of the npc start yet or not
    npc:setLocalVar("pathLeg", 0) -- Legs of the path (first level of the path table)
    npc:setLocalVar("pathPoint", 1) -- points of the path (second level of the path table)
    npc:setLocalVar("topRoomsOption", math.random(2,3)) -- 2 top left room, 3 top right room
    npc:setLocalVar("middleRoomsOption", math.random(4,5)) -- 4 middle left room, 5 middle right room
    npc:setLocalVar("bottomRoomsOption", math.random(6,7)) -- 6 bottom left room, 7 bottom right room
    npc:setLocalVar("lowerForkOption", math.random(8,9)) -- 8 lower fork left, 9 lower fork right
    npc:setLocalVar("nextCharsNearbyCheckTime", os.time()) -- next time a check if player is nearby can happen
    npc:setLocalVar("crabRoomDone", 0) -- flag use to know if npc already explore a crab room (to not redo it)
end

function checkForNearbyMobs(npc, mobs)
    local moveStatus = npc:getLocalVar("moveStatus")
    local pathLeg = npc:getLocalVar("pathLeg")

    for _, enemy in pairs(mobs) do
        if npc:checkDistance(enemy) < 12 and enemy:isSpawned() and pathLeg ~= 0 then 
            if moveStatus ~= 1 then          
                if enemy:isEngaged() then
                    npc:showText(npc,ID.text.EXCALIACE_MOB_ENGAGED) -- Over to you.
                    npc:speed(ONPATH_SPEED)
                else
                    if enemy:getFamily() == 77 then -- crab
                        npc:showText(npc,ID.text.EXCALIACE_CRAB1) -- What's this guy up to?
                    elseif enemy:getFamily() == 197 then -- pugil
                        npc:showText(npc,ID.text.EXCALIACE_PUGIL1) -- Wh-what the...!?
                    elseif enemy:getFamily() == 86 then -- doomed
                        npc:showText(npc,ID.text.EXCALIACE_DEBAUCHER1) -- H-help!!!
                    end
                    npc:speed(RUNAWAY_SPEED)
                end
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + math.random(20,30))
                npc:setLocalVar("moveStatus", 1)
            end
        end
    end
end

function checkForNearbyPlayers(npc, chars)
    local nextCharsNearbyCheckTime = npc:getLocalVar("nextCharsNearbyCheckTime")
    local pathLeg = npc:getLocalVar("pathLeg")
    local instance = npc:getInstance()

    if nextCharsNearbyCheckTime <= os.time() then
        local rangeFacing = false  -- a player is facing him and is less than 5 and excaliace is facing this player
        local rangeFollow = false -- a player is less than 10 away from him (prevent him from running away)

        for _, player in pairs(chars) do
            if npc:checkDistance(player) < 5 and npc:isFacing(player) and player:isFacing(npc) then
                rangeFacing = true
            end
            if npc:checkDistance(player) < 10 then -- check if at least 1 player is around the npc
                rangeFollow = true
            end
        end

        local moveStatus = npc:getLocalVar("moveStatus")
        if rangeFacing == true then
            if moveStatus == 0 then
                npc:speed(STOP_SPEED)
                npc:setLocalVar("moveStatus", 2)
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 8)
                npc:timer(1000, function(npc) npc:showText(npc,ID.text.EXCALIACE_TOO_CLOSE) end)
            else
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 4)
            end

        elseif rangeFollow == false and moveStatus ~= 1 and pathLeg ~= 0 then
            npc:showText(npc,ID.text.EXCALIACE_RUN)
            npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + math.random(30,40))
            npc:setLocalVar("moveStatus", 1)
            npc:speed(RUNAWAY_SPEED)
        elseif rangeFollow == true and moveStatus == 2 then
            npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 4)
            npc:setLocalVar("moveStatus", 0)
            npc:speed(ONPATH_SPEED)
        elseif rangeFollow == true and moveStatus == 1 then
            local stopDuration = math.random(30,40)

            npc:speed(STOP_SPEED)
            npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + stopDuration +2)
            npc:timer(2000, function(npc) npc:showText(npc,ID.text.EXCALIACE_TIRED) end)
            npc:timer(4000, function(npc) npc:showText(npc,ID.text.EXCALIACE_CAUGHT) end)
            npc:timer(stopDuration * 1000, function(npc)
                defineNextLegAndPointWhenMovingForwardAndMoveToIt(npc)
                npc:setLocalVar("moveStatus", 0)
                npc:speed(ONPATH_SPEED)
            end)
        end
    end
end

function takeABreakWhileMovingForward(npc)
    local stopDuration = math.random(10,15)

    npc:speed(STOP_SPEED)
    npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + stopDuration +2)
    npc:timer(stopDuration * 1000, function(npc) 
        npc:speed(ONPATH_SPEED)
    end)
end

function defineNextLegAndPointWhenMovingForwardAndMoveToIt(npc)
    local topRoomsOption = npc:getLocalVar("topRoomsOption")
    local middleRoomsOption = npc:getLocalVar("middleRoomsOption")
    local bottomRoomsOption = npc:getLocalVar("bottomRoomsOption")
    local lowerForkOption = npc:getLocalVar("lowerForkOption")
    local crabRoomDone = npc:getLocalVar("crabRoomDone")
    local pathLeg = npc:getLocalVar("pathLeg")
    local pathPoint = npc:getLocalVar("pathPoint")
    local instance = npc:getInstance()

    if npc:atPoint(path[0][#path[0]]) then -- leave the start path to join the main path
        pathLeg = 1
        pathPoint = 20
    elseif npc:atPoint(path[1][30]) and crabRoomDone < 1 then
        pathLeg = topRoomsOption
        pathPoint = 2
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[topRoomsOption][7]) then
        pathLeg = 1
        pathPoint = 30
        npc:setLocalVar("crabRoomDone", 1)
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[1][34]) and crabRoomDone < 2 then
        pathLeg = middleRoomsOption
        pathPoint = 2
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[middleRoomsOption][7]) then
        pathLeg = 1
        pathPoint = 34
        npc:setLocalVar("crabRoomDone", 2)
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[1][38]) and crabRoomDone < 3 then
        pathLeg = bottomRoomsOption
        pathPoint = 2
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[bottomRoomsOption][7]) then
        pathLeg = 1
        pathPoint = 38
        npc:setLocalVar("crabRoomDone", 3)
        takeABreakWhileMovingForward(npc)
    elseif npc:atPoint(path[1][#path[1]]) then
        pathLeg = lowerForkOption
        pathPoint = 2
    elseif npc:atPoint(path[lowerForkOption][#path[lowerForkOption]]) and instance:getProgress() == 0 then
        npc:showText(npc,ID.text.EXCALIACE_END1)
        npc:showText(npc,ID.text.EXCALIACE_END2)
        instance:setProgress(1) -- End Mission win
    else
        pathPoint = pathPoint+1
    end

    pathPoint = utils.clamp(pathPoint, 1, #path[pathLeg]) -- pathPoint cannot be 0 or more than tab range
    npc:pathThrough(path[pathLeg][pathPoint]) -- move to next pathpoint
    npc:setLocalVar("pathLeg", pathLeg) -- save new pathLeg
    npc:setLocalVar("pathPoint", pathPoint) -- save new PathPoint
end

function defineNextLegAndPointWhenRunningAwayAndMoveToIt(npc)
    local topRoomsOption = npc:getLocalVar("topRoomsOption")
    local middleRoomsOption = npc:getLocalVar("middleRoomsOption")
    local bottomRoomsOption = npc:getLocalVar("bottomRoomsOption")
    local lowerForkOption = npc:getLocalVar("lowerForkOption")
    local pathLeg = npc:getLocalVar("pathLeg")
    local pathPoint = npc:getLocalVar("pathPoint")
    local instance = npc:getInstance()

    if npc:atPoint(path[1][1]) then -- npc reached the escape point - FAIL mission
        npc:showText(npc,ID.text.EXCALIACE_ESCAPE)
        instance:fail() -- End Mission fail
    elseif npc:atPoint(path[topRoomsOption][1]) then
        pathLeg = 1
        pathPoint = 30
    elseif npc:atPoint(path[middleRoomsOption][1]) then
        pathLeg = 1
        pathPoint = 34
    elseif npc:atPoint(path[bottomRoomsOption][1]) then
        pathLeg = 1
        pathPoint = 38
    elseif npc:atPoint(path[lowerForkOption][1]) then
        pathLeg = 1
        pathPoint = #path[1]
    else
        pathPoint = pathPoint-1
    end

    pathPoint = utils.clamp(pathPoint, 1, #path[pathLeg]) -- pathPoint cannot be 0 or more than tab range
    npc:pathThrough(path[pathLeg][pathPoint]) -- move to next pathpoint
    npc:setLocalVar("pathLeg", pathLeg) -- save new pathLeg
    npc:setLocalVar("pathPoint", pathPoint) -- save new PathPoint
end

function onTrack(npc)
    local instance = npc:getInstance()
    local chars = instance:getChars()
    local mobs = instance:getMobs()
    local missionStarted = npc:getLocalVar("missionStarted")
    local moveStatus = npc:getLocalVar("moveStatus") 
    local pathLeg = npc:getLocalVar("pathLeg")
    local pathPoint = npc:getLocalVar("pathPoint")

    if missionStarted == 0 then     -- Start the Escort Mission
        for _, players in pairs(chars) do
            if npc:checkDistance(players) < 10 then
                npc:showText(npc,ID.text.EXCALIACE_START)
                npc:setLocalVar("missionStarted", 1)
                npc:pathThrough(path[pathLeg][pathPoint])
            end
        end
    elseif instance:getProgress() == 0 then
        checkForNearbyMobs(npc, mobs)
        checkForNearbyPlayers(npc, chars)

        if moveStatus == 0 then -- moving forward
            if npc:atPoint(path[pathLeg][pathPoint]) then
                defineNextLegAndPointWhenMovingForwardAndMoveToIt(npc)
            end
        elseif moveStatus == 1 then -- run away
            if npc:atPoint(path[pathLeg][pathPoint]) then
                defineNextLegAndPointWhenRunningAwayAndMoveToIt(npc)
            end
        end
    end
end
