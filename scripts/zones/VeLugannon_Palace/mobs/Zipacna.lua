-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Zipacna
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/pathfind")
-----------------------------------

local zipPathblue = {
    -237, 16, 420, -- Start (Downstairs)
    -254, 13, 420,
    -259, 11, 414,
    -260, 6, 392,
    -257, 4, 380,
    -238, 0, 379,
    -215, 0, 379,
    -208, 0, 385,
    -196, 0, 391,
    -186, 0, 380,
    -165, 0, 379, -- Before Middle Door (F-4)
    -133, 0, 380, -- After Middle Door (F-4)
    -134, 0, 379,
    -128, 0, 385,
    -119, 0, 418,
    -105, 0, 459  -- Final Door before (H-3)
}

local zipPathblue_Reverse = {
    -105, 0, 459,  -- Final Door before (H-3)
    -119, 0, 418,
    -128, 0, 385,
    -134, 0, 379,
    -133, 0, 380, -- After Middle Door (F-4)
    -165, 0, 379, -- Before Middle Door (F-4)
    -186, 0, 380,
    -196, 0, 391,
    -208, 0, 385,
    -215, 0, 379,
    -238, 0, 379,
    -257, 4, 380,
    -260, 6, 392,
    -259, 11, 414,
    -254, 13, 420,
    -237, 16, 420, -- Start (Downstairs)
}

local zipPathmiddle_toYellow = {
    -76, 0, 460, -- From Blue Door (H-3)
    -66, 0, 459,
    -59, 0, 453,
    -59, 0, 420,
    -26, 0, 420,
    0, 0, 420,
    27, 0, 420,
    58, 0, 420,
    60, 0, 430,
    60, 0, 454,
    74, 0, 460 -- From Yellow Door (H-3)
}

local zipPathmiddle_toBlue = {
    74, 0, 460, -- From Yellow Door (H-3)
    60, 0, 454,
    60, 0, 430,
    58, 0, 420,
    27, 0, 420,
    0, 0, 420,
    -26, 0, 420,
    -59, 0, 420,
    -59, 0, 453,
    -66, 0, 459,
    -76, 0, 460 -- From Blue Door (H-3)
}

local zipPathyellow = {
    139, 16, 418, -- Start (Downstairs)
    139, 16, 385,
    154, 16, 380,
    213, 16, 380,
    219, 16, 390,
    219, 16, 413,
    232, 16, 420,
    253, 13, 420,
    260, 11, 412,
    260, 5, 385,
    253, 3, 380,
    238, 0, 380,
    213, 0, 380,
    205, 0, 391,
    187, 0, 381,
    164, 0, 379, -- Before Middle Door (J-4)
    132, 0, 380, -- After Middle DOor (J-4)
    128, 0, 386,
    121, 0, 413, 
    109, 0, 456,
    105, 0, 459 -- Final Door before (H-3)
}

local zipPathyellow_Reverse = {
    105, 0, 459, -- Final Door before (H-3)
    109, 0, 456,
    121, 0, 413,
    128, 0, 386, 
    132, 0, 380, -- After Middle DOor (J-4)
    164, 0, 379, -- Before Middle Door (J-4)
    187, 0, 381,
    205, 0, 391,
    213, 0, 380,
    238, 0, 380,
    253, 3, 380,
    260, 5, 385,
    260, 11, 412,
    253, 13, 420,
    232, 16, 420,
    219, 16, 413,
    219, 16, 390,
    213, 16, 380,
    154, 16, 380,
    139, 16, 385,
    139, 16, 418, -- Start (Downstairs)
}

local travellocation = {
    blue = 1,
    middle = 2,
    yellow = 3
}

function onMobSpawn(mob)
    mob:setLocalVar("Traveling", travellocation.blue)
    onMobRoam(mob)
end

function onPath(mob)
    local gate = nil
    local now = os.time()
    local traveling = mob:getLocalVar("Traveling")
    local previousPath = mob:getLocalVar("PreviousPath")

    switch (traveling): caseof
    {
        [1] = function()
            if mob:atPoint(tpz.path.last(zipPathblue)) and previousPath == travellocation.blue then
                gate = GetNPCByID(ID.npc.H3_BLUE_GATE)
                if gate:getAnimation() == tpz.anim.CLOSE_DOOR then
                    mob:pathThrough(tpz.path.first(zipPathblue_Reverse))
                    tpz.path.patrol(mob, zipPathblue_Reverse)
                else
                    mob:setLocalVar("Traveling", travellocation.middle)
                    mob:setLocalVar("PreviousPath", travellocation.blue)
                    mob:pathThrough(tpz.path.first(zipPathmiddle_toYellow))
                    tpz.path.patrol(mob, zipPathmiddle_toYellow)
                end
            elseif mob:atPoint(tpz.path.last(zipPathblue)) and previousPath == travellocation.middle then
                tpz.path.patrol(mob, zipPathblue_Reverse)
            elseif mob:atPoint(tpz.path.first(zipPathblue)) then
                mob:setLocalVar("Traveling", travellocation.blue)
                mob:setLocalVar("PreviousPath", 1)
                mob:pathThrough(tpz.path.first(zipPathblue))
                tpz.path.patrol(mob, zipPathblue)
            end
        end,
        [2] = function()
            -- Coming from Yellow|Middle to Blue Gate
            if mob:atPoint(tpz.path.last(zipPathmiddle_toBlue)) then
                if traveling == travellocation.middle and previousPath == travellocation.yellow then
                    gate = GetNPCByID(ID.npc.H3_BLUE_GATE)
                    if gate:getAnimation() == tpz.anim.CLOSE_DOOR then
                        -- Traveling through middle and arrived at a close blue gate
                        -- Return through middle to yellow gate
                        mob:setLocalVar("PreviousPath", travellocation.blue)
                        mob:pathThrough(tpz.path.first(zipPathmiddle_toYellow))
                        tpz.path.patrol(mob, zipPathmiddle_toYellow)
                    else
                        -- Continue on to the blue path to the starting point of blue
                        mob:setLocalVar("Traveling", travellocation.blue)
                        mob:setLocalVar("PreviousPath", travellocation.middle)
                        mob:pathThrough(tpz.path.first(zipPathblue_Reverse))
                        tpz.path.patrol(mob, zipPathblue_Reverse)
                    end
                else
                    tpz.path.patrol(mob, zipPathmiddle_toYellow)
                end
            -- Coming from Blue|Middle to Yellow Gate
            elseif mob:atPoint(tpz.path.last(zipPathmiddle_toYellow)) then
                if traveling == travellocation.middle and previousPath == travellocation.blue then
                    gate = GetNPCByID(ID.npc.H3_YELLOW_GATE)
                    if gate:getAnimation() == tpz.anim.CLOSE_DOOR then
                        -- Traveling through middle and arrived at a close yellow gate
                        -- Return through middle to blue gate
                        mob:setLocalVar("PreviousPath", travellocation.yellow)
                        mob:pathThrough(tpz.path.first(zipPathmiddle_toBlue))
                        tpz.path.patrol(mob, zipPathmiddle_toBlue)
                    else
                        -- Continue on to the yellow path to the starting point of yellow
                        mob:setLocalVar("Traveling", travellocation.yellow)
                        mob:setLocalVar("PreviousPath", travellocation.middle)
                        mob:pathThrough(tpz.path.first(zipPathyellow_Reverse))
                        tpz.path.patrol(mob, zipPathyellow_Reverse)
                    end
                else
                    tpz.path.patrol(mob, zipPathmiddle_toBlue)
                end
            end
        end,
        [3] = function()
            if mob:atPoint(tpz.path.last(zipPathyellow)) and previousPath == travellocation.yellow then
                gate = GetNPCByID(ID.npc.H3_YELLOW_GATE)
                if gate:getAnimation() == tpz.anim.CLOSE_DOOR then
                    mob:pathThrough(tpz.path.first(zipPathyellow_Reverse))
                    tpz.path.patrol(mob, zipPathyellow_Reverse)
                else
                    mob:setLocalVar("Traveling", travellocation.middle)
                    mob:setLocalVar("PreviousPath", travellocation.yellow)
                    mob:pathThrough(tpz.path.first(zipPathmiddle_toBlue))
                    tpz.path.patrol(mob, zipPathmiddle_toBlue)
                end
            elseif mob:atPoint(tpz.path.last(zipPathyellow)) and previousPath == travellocation.middle then
                tpz.path.patrol(mob, zipPathyellow_Reverse)
            elseif mob:atPoint(tpz.path.first(zipPathyellow)) then
                mob:setLocalVar("Traveling", travellocation.yellow)
                mob:setLocalVar("PreviousPath", 3)
                mob:pathThrough(tpz.path.first(zipPathyellow))
                tpz.path.patrol(mob, zipPathyellow)
            end
        end,
    }
end

function onMobRoam(mob)
    -- move to start position if not moving
    if mob:isFollowingPath() == false then
        local traveling = mob:getLocalVar("Traveling")
        local previousPath = mob:getLocalVar("PreviousPath")
        switch (traveling): caseof
        {
            [1] = function()
                mob:setLocalVar("PreviousPath", travellocation.blue)
                mob:pathThrough(tpz.path.first(zipPathblue))
            end,
            [2] = function()
            end,
            [3] = function()
                mob:setLocalVar("PreviousPath", travellocation.yellow)
                mob:pathThrough(tpz.path.first(zipPathyellow))
            end,
        }
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(10800, 14400)) -- respawn 3-4 hrs
end
