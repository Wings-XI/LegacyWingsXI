-----------------------------------
-- Area: Lower Delkfutt's Tower
-- NPC: Seed Afterglow
-- Notes: Gives KI for A Crystaline Prophecy (ACP10)
-- !pos 520 0.574 -80 184
-- !pos 460 -15.854 50 184
-- !pos 480 -31.425 0 184
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local yPos = npc:getYPos()

    player:messageSpecial(ID.text.STONE_GLITTERS)
    if player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
        if (yPos > 0 and yPos < 1) then
            if (player:hasKeyItem(tpz.ki.AMICITIA_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.AMICITIA_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AMICITIA_STONE)
            end
        elseif (yPos > -16 and yPos < -15) then
            if (player:hasKeyItem(tpz.ki.VERITAS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.VERITAS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VERITAS_STONE)
            end
        elseif (yPos > -32 and yPos < -31) then
            if (player:hasKeyItem(tpz.ki.SAPIENTIA_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.SAPIENTIA_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SAPIENTIA_STONE)
            end
        end
    end

    -- MessageID - 4
    -- 7748 no sync
    -- 7748, get ki
    -- 7748 7749 have ki
    -- player:addKeyItem(tpz.ki.LIGHT_OF_MEA)
    -- A stone glitters before you
    -- player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
    -- player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AMICITIA_STONE)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
