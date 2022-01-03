-----------------------------------
--    Starlight Celebrations     --
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
------------------------------------

------------------
-- Event Status --
------------------
function isStarlightEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    if ((month == 12 and day >= 12) or STARLIGHT_YEAR_ROUND) then -- According to wiki Startlight Festival is December 12 - December 31.
        if (STARLIGHT_2007 == 1) then
            option = 1
        end
    end

    return option
end

--------------------------------
-- For the Children Sub-Quest --
--------------------------------
function onStarlightSmilebringersTrade(player, trade, npc)
    local zone = player:getZoneName()
    local ID = zones[player:getZoneID()]
    local contentEnabled = isStarlightEnabled()
    local item = trade:getItemId()

    ------------------
    -- 2007 Edition --
    ------------------
    if (contentEnabled == 1) then
        ----------------------
        -- Presents Allowed --
        ----------------------
        local presents_table = {1742, 1743, 1744, 1745}
        local fireworks_table = {
            4215, -- Popstar
            4216, -- Brilliant Snow
            4217, -- Sparkling Hand
            4218, -- Air Rider
            4167, -- Cracker
            4168, -- Twinkle Shower
            4169, -- Little Comet
        }
        ---------------
        -- Hat Check --
        ---------------
        local head = player:getEquipID(tpz.slot.HEAD)

        for itemInList = 1, #presents_table do
            
            if (item == presents_table[itemInList] and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) < 9)) then
                player:showText(npc, ID.text.GIFT_THANK_YOU)
                player:messageSpecial(ID.text.BARRELS_JOY_TO_CHILDREN)
                player:addFame(HOLIDAY, 31)
                player:tradeComplete()
            elseif (item == fireworks_table[itemInList] and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) < 9)) then
                player:showText(npc, ID.text.GIFT_THANK_YOU)
                player:messageSpecial(ID.text.JOY_TO_CHILDREN)
                player:addFame(HOLIDAY, 15)
                player:tradeComplete()
            elseif ((item == presents_table[itemInList]) and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) >= 9)) or ((item == fireworks_table[itemInList]) and (head == 15179 or head == 15178) and (player:getFameLevel(HOLIDAY) >= 9))  then
                player:showText(npc, ID.text.ONLY_TWO_HANDS)
            end

        end
    end
end

----------------------------------------------------------------
-- Apply Zone Decorations, Vendors, and Additional Event NPCs --
----------------------------------------------------------------
function applyStarlightDecorations(zoneid)
    if isStarlightEnabled() ~= 0 then
        local decoration = zones[zoneid].npc.STARLIGHT_DECORATIONS
        if decoration then
            for id, decoration in pairs(decoration) do
                local npc = GetNPCByID(id)
                if npc then
                    npc:setStatus(tpz.status.NORMAL)
                    local npcstatus = npc:getStatus()
                end
            end
        end
    end
end