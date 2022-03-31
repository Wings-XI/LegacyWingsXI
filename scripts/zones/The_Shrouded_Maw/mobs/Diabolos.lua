-----------------------------------
-- Area: The Shrouded Maw
--  Mob: Diabolos
-----------------------------------
local ID = require("scripts/zones/The_Shrouded_Maw/IDs")

-- TODO: CoP Diabolos
-- 1) Make the diremites in the pit all aggro said player that falls into region. Should have a respawn time of 10 seconds.
-- 2) Diremites also shouldnt follow you back to the fight area if you make it there. Should despawn and respawn instantly if all players
--    make it back to the Diabolos floor area.
-- 3) ANIMATION Packet ids for instance 2 and 3 are wrong (needs guesswork). Sounds working.
--    Update 2018-01-02 these no longer seem to work for any instance. neither animation nor sound.

-- TODO: Diabolos Prime
-- Note: Diabolos Prime fight drops all tiles at once.


function onMobSpawn(mob)
     local dBase = ID.mob.DIABOLOS_OFFSET
    local dPrimeBase = dBase + 27
    local triggerVal = math.random(35,75)
    if mob:getID() >= dPrimeBase then dBase = dPrimeBase end  -- Prime "block" of mobs is offset 27 from CoP mobs
        
    local area = utils.clamp((mob:getID() - dBase) / 7 + 1, 1, 3)

    mob:setLocalVar("TileTriggerHPP", triggerVal) -- Starting point for tile drops
    mob:setLocalVar("Area", area)

    -- Only add these for the CoP Diabolos NOT Prime
    local copDiabolos = ID.mob.DIABOLOS_OFFSET
    if mob:getID() >= copDiabolos and mob:getID() <= copDiabolos + 14 then  -- three possible instances of Diabolos
        mob:addMod(tpz.mod.INT, -50)
        mob:addMod(tpz.mod.MND, -50)
        mob:addMod(tpz.mod.ATTP, -15)
        mob:addMod(tpz.mod.DEFP, -15)
        mob:addMod(tpz.mod.MDEF, -40)
    end
end

function onMobFight(mob, target)
    local area = mob:getLocalVar("Area") - 1 
    local trigger = mob:getLocalVar("TileTriggerHPP")
    
    local tileDrops =
        {   -- {Animation Area 1, Animation Area 2, Animation Area 3}
            {"byc8", "bya8", "byb8"},
            {"byc7", "bya7", "byb7"},
            {"byc6", "bya6", "byb6"},
            {"byc5", "bya5", "byb5"},
            {"byc4", "bya4", "byb4"},
            {"byc3", "bya3", "byb3"},
            {"byc2", "bya2", "byb2"},
            {"byc1", "bya1", "byb1"},
        }

    local hpp = math.floor(mob:getHP()*100/mob:getMaxHP())
    if hpp < trigger then   -- Trigger the tile drop events
        mob:setLocalVar("TileTriggerHPP", -1)            -- Prevent tiles from being dropped twice
        local tileBase = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (area) * 8
 
        for offset, animationSet in ipairs(tileDrops) do
            local tileId = tileBase + offset - 1
            local tile = GetNPCByID(tileId)

            if tile:getLocalVar("Dropped") ~= tpz.anim.OPEN_DOOR then
                tile:setLocalVar("Dropped", tpz.anim.OPEN_DOOR)
                SendEntityVisualPacket(tileId, animationSet[area + 1], 4)     -- Animation for floor dropping
                SendEntityVisualPacket(tileId, "s123", 4)          -- Tile dropping sound
 
                tile:timer(2750, function(tile)                 -- 2.7s second delay (ish)
                    tile:updateToEntireZone(tpz.status.NORMAL, tpz.anim.OPEN_DOOR)       -- Floor opens
                end)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
