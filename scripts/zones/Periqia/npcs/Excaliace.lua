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

local ONPATH_SPEED = 40
local RUNAWAY_SPEED = 60
local STOP_SPEED = 0

function onSpawn(npc)
    npc:initNpcAi()
    npc:setLocalVar("topRoomsOption", math.random(2,3))
    npc:setLocalVar("middleRoomsOption", math.random(4,5))
    npc:setLocalVar("bottomRoomsOption", math.random(6,7))
    npc:setLocalVar("lowerForkOption", math.random(8,9))
    npc:setLocalVar("pathProgressMask", 0) -- 0 = Incomplete  1 = Complete
        -- bit 0: Mission Start [1]
        -- bit 1: Top Rooms Option Completed [2]
        -- bit 2: Middle Rooms Option Completed [4]
        -- bit 3: Bottom Rooms Option Completed [8]
        -- bit 4: Lower Fork Option Completed (Mission PASS) [16] **Currently NOT Used**
    npc:setLocalVar("chatMessage", 0)
    npc:setLocalVar("runMessage", 0)
    npc:setLocalVar("runTimeCheck", os.time())
    npc:setLocalVar("pathPoint", 1)
    -- TODODEMOS add  new var
    npc:setLocalVar("moveStatus", 0)  -- 0 = Walking Forward, 1 = Running Back, 2 = Stop
    npc:setLocalVar("missionStarted", 0) -- boolean to know if the escort of the npc start yet or not
    npc:setLocalVar("pathLeg", 0) -- Legs of the path (first level of the path table)
    npc:setLocalVar("pathPoint", 1) -- points of the path (second level of the path table)
    npc:setLocalVar("nextCharsNearbyCheckTime", os.time())
end

-- function checkForNearbyMobs(npc, mobs)
--     local pathProgressMask = npc:getLocalVar("pathProgressMask")
--     -- TODODEMOS not sure if that var is really usefull
--     -- should have a boolean runway and ignore all condition
--     -- if npc:runaway == 1 then skip this method
--     local moveStatus = npc:getLocalVar("moveStatus")

--     for _, enemy in pairs(mobs) do
--         if npc:checkDistance(enemy) < 12 and enemy:isSpawned() then
--             if moveStatus ~= 1 then
--                 npc:setLocalVar("runTimer", os.time() + math.random(20,40))
--                 npc:setLocalVar("moveStatus", 1)
--                 npc:setLocalVar("runStart", 1)
--                 if enemy:isEngaged() then
--                     npc:showText(npc,ID.text.EXCALIACE_MOB_ENGAGED)
--                 else
--                     -- TODODEMOS is that a good idea, if someone bring a debaucher, waht happen ?
--                     -- Should save last checkpoint ? or not save anything like  pugil/Debaucher
--                     if enemy:getFamily() == 77 then -- crab
--                         if pathProgressMask == 7 then
--                             npc:setLocalVar("pathPoint", 38) -- save checkpoint Bottom Rooms Option
--                         elseif pathProgressMask == 3 then
--                             npc:setLocalVar("pathPoint", 34)-- save checkpoint Middle Rooms Option
--                         elseif pathProgressMask == 1 then
--                             npc:setLocalVar("pathPoint", 30) -- save checkpoint Top Rooms Option
--                         end
--                         npc:setLocalVar("pathLeg", 1)
--                         npc:showText(npc,ID.text.EXCALIACE_CRAB1)
--                     elseif enemy:getFamily() == 197 then -- pugil
--                         npc:showText(npc,ID.text.EXCALIACE_PUGIL1)
--                     elseif enemy:getFamily() == 86 then -- doomed
--                         npc:showText(npc,ID.text.EXCALIACE_DEBAUCHER1)
--                     end

--                     npc:speed(RUNAWAY_SPEED)
--                 end
--             end
--         end
--     end
-- end

function checkForNearbyPlayers(npc, chars)
    local nextCharsNearbyCheckTime = npc:getLocalVar("nextCharsNearbyCheckTime") -- time when the next checkForNearbyPlayers can happen

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
            if moveStatus == 1 then
                npc:speed(STOP_SPEED)
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 15)
                npc:timer(2000, function(npc) npc:showText(npc,ID.text.EXCALIACE_TIRED) end)
                npc:timer(6000, function(npc) npc:showText(npc,ID.text.EXCALIACE_CAUGHT) end)
                npc:timer(8000, function(npc) 
                    npc:setLocalVar("moveStatus", 0)
                    npc:speed(ONPATH_SPEED)
                end)
            elseif moveStatus == 0 then
                npc:speed(STOP_SPEED)
                npc:setLocalVar("moveStatus", 2)
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 8)
                npc:timer(1000, function(npc) npc:showText(npc,ID.text.EXCALIACE_TOO_CLOSE) end)
            else
                npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 4)
            end

        elseif rangeFollow == false and moveStatus ~= 1 then
            npc:showText(npc,ID.text.EXCALIACE_RUN)
            npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + math.random(20,30))
            npc:setLocalVar("moveStatus", 1)
            npc:speed(RUNAWAY_SPEED)
        elseif rangeFollow == true and moveStatus == 2 then
            npc:setLocalVar("nextCharsNearbyCheckTime", os.time() + 4)
            npc:setLocalVar("moveStatus", 0)
            npc:speed(ONPATH_SPEED)
        end
    end
 end

function followPathForward(npc)


    if npc:atPoint(path[0][#path[0]]) then --and bit.band(pathProgressMask, bit.lshift(1,0)) == 0 then
        npc:setLocalVar("pathLeg", 1)
        npc:setLocalVar("pathPoint", 19)
    elseif npc:atPoint(path[1][30])then
        -- add wait for each of those step
        npc:setLocalVar("pathLeg", topRoomsOption)
        npc:setLocalVar("pathPoint", 1)
    elseif npc:atPoint(path[topRoomsOption][7]) then
        npc:setLocalVar("pathLeg", 1)
        npc:setLocalVar("pathPoint", 30)
    elseif npc:atPoint(path[1][34]) then
        npc:setLocalVar("pathLeg", middleRoomsOption)
        npc:setLocalVar("pathPoint", 1)
    elseif npc:atPoint(path[middleRoomsOption][7]) then
        npc:setLocalVar("pathLeg", 1)
        npc:setLocalVar("pathPoint", 34)
    elseif npc:atPoint(path[1][38]) then
        npc:setLocalVar("pathLeg", bottomRoomsOption)
        npc:setLocalVar("pathPoint", 1)
    elseif npc:atPoint(path[bottomRoomsOption][7]) then
        npc:setLocalVar("pathLeg", 1)
        npc:setLocalVar("pathPoint", 38)
    elseif npc:atPoint(path[1][#path[1]]) then
        npc:setLocalVar("pathLeg", lowerForkOption)
        npc:setLocalVar("pathPoint", 1)
    elseif npc:atPoint(path[lowerForkOption][#path[lowerForkOption]]) then
        npc:showText(npc,ID.text.EXCALIACE_END1)
        npc:showText(npc,ID.text.EXCALIACE_END2)
        npc:setLocalVar("missionActive", 3) -- End Mission
    end
end

function onTrack(npc)
    local instance = npc:getInstance()
    local chars = instance:getChars()
    local mobs = instance:getMobs()
    local missionStarted = npc:getLocalVar("missionStarted")
    local moveStatus = npc:getLocalVar("moveStatus") 
    local pathLeg = npc:getLocalVar("pathLeg")
    local pathPoint = npc:getLocalVar("pathPoint")
    local topRoomsOption = npc:getLocalVar("topRoomsOption")
    local middleRoomsOption = npc:getLocalVar("middleRoomsOption")
    local bottomRoomsOption = npc:getLocalVar("bottomRoomsOption")
    local lowerForkOption = npc:getLocalVar("lowerForkOption")
    
    -- local missionActive = npc:getLocalVar("missionActive")
    -- local pathLeg = npc:getLocalVar("pathLeg")
    -- local pathPoint = npc:getLocalVar("pathPoint") -- TODODEMOS Save of the checkpoint before running away
    -- local pathProgressMask = npc:getLocalVar("pathProgressMask")
    

    -- local lowerForkOption = npc:getLocalVar("lowerForkOption")
    -- local chatMessage = npc:getLocalVar("chatMessage") -- 0 = No Msg Sent, 1 = Msg Sent
    -- local moveStatus = npc:getLocalVar("moveStatus") -- 0 = Walking Forward, 1 = Running Back
    -- local runTimeCheck = npc:getLocalVar("runTimeCheck")
    -- local moveLock = npc:getLocalVar("moveLock") -- 0 = npc canNOT move, 1 = npc can move
    -- local lockToggle = npc:getLocalVar("lockToggle")
    -- local runTimer = npc:getLocalVar("runTimer")
    -- local runStart = npc:getLocalVar("runStart")
    -- local constantMove = npc:getLocalVar("constantMove") -- 0 = npc canNOT move, 1 = npc can move
    -- local rangeClose = false
    -- local rangeStop = false
    -- local rangeFollow = false

    -- -- -- check if player or mobs nearby (run away or stop)
    -- -- if pathProgressMask > 0 and missionActive == 1 then
    -- --     checkForNearbyMobs(npc, mobs)
    -- --     checkForNearbyPlayers(npc, chars)
    -- -- end


    if missionStarted == 0 then     -- Start the Escort Mission
        for _, players in pairs(chars) do
            if npc:checkDistance(players) < 10 then
                npc:showText(npc,ID.text.EXCALIACE_START)
                npc:setLocalVar("missionStarted", 1)
                npc:pathThrough(path[pathLeg][pathPoint])
            end
        end
    else
        --checkForNearbyPlayers(npc, chars)

        pathPoint = utils.clamp(pathPoint, 1, #path[pathLeg]) -- pathPoint cannot be 0

        if moveStatus == 0 then -- moving forward
            if npc:atPoint(path[pathLeg][pathPoint]) then -- if the npc reach it s current pos on the path

                followPathForward(npc)
                npc:setLocalVar("pathPoint", pathPoint+1)
                local pathLeg = npc:getLocalVar("pathLeg")
                local pathPoint = npc:getLocalVar("pathPoint")

                -- TODO change of legs and reset point

                -- Move to point

                printf("Leg:%i Point:%i",pathLeg, pathPoint)


                npc:pathThrough(path[pathLeg][pathPoint])
            end
        elseif moveStatus == 1 then -- run away
            if npc:atPoint(path[pathLeg][pathPoint]) then
                npc:setLocalVar("pathPoint", pathPoint-1)
            -- TODO change of legs and reset point

                -- Move to point
                local pathLeg = npc:getLocalVar("pathLeg")
                local pathPoint = npc:getLocalVar("pathPoint")
                npc:pathThrough(path[pathLeg][pathPoint])
            end
        else -- if not moving
            -- do nothing ?
        end




    --         if moveStatus == 0 then
    --             npc:setLocalVar("pathPoint", pathPoint+1)
    --         else
    --             if runTimer >= os.time() then
    --                 npc:setLocalVar("pathPoint", pathPoint-1)
    end



    --         else moveStatus == 1 (Running)
    --         else
    --             if npc:atPoint(path[1][1]) then
    --             npc reached the escape point - FAIL mission
    --                 npc:showText(npc,ID.text.EXCALIACE_ESCAPE)
    --                 npc:setLocalVar("missionActive", 3) -- End Mission
    --                 npc:setLocalVar("moveLock", 0) -- stop Movement and condition checks
    --                 instance:fail()
    --             elseif npc:atPoint(path[topRoomsOption][1]) then
    --                 npc:setLocalVar("pathLeg", 1)
    --                 npc:setLocalVar("pathPoint", 30)
    --             elseif npc:atPoint(path[middleRoomsOption][1]) then
    --                 npc:setLocalVar("pathLeg", 1)
    --                 npc:setLocalVar("pathPoint", 34)
    --             elseif npc:atPoint(path[bottomRoomsOption][1]) then
    --                 npc:setLocalVar("pathLeg", 1)
    --                 npc:setLocalVar("pathPoint", 38)
    --             elseif npc:atPoint(path[lowerForkOption][1]) then
    --                 npc:setLocalVar("pathLeg", 1)
    --                 npc:setLocalVar("pathPoint", #path[1])
    --             end
    --         end
    --     npc not at assigned point yet so move there
    --     else
    --         npc:pathThrough(path[pathLeg][pathPoint])
    --     end
    -- end
end
