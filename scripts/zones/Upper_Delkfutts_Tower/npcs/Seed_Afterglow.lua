-----------------------------------
-- Area: Upper Delkfutt's Tower
-- NPC: Seed Afterglow
-- Notes: Gives KI for A Crystaline Prophecy (ACP10)
-- !pos -360 -143.425 -40 158
-- !pos -300 -159.852 50 158
-- !pos -300 -175.425 50 158
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)
    if ENABLE_ACP == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local yPos = npc:getYPos()

    player:messageSpecial(ID.text.STONE_GLITTERS)
    if player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
        if (yPos > -144 and yPos < -143) then
            if (player:hasKeyItem(tpz.ki.CONSTANTIA_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.CONSTANTIA_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CONSTANTIA_STONE)
            end
        elseif (yPos > -160 and yPos < -159) then
            if (player:hasKeyItem(tpz.ki.SPEI_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.SPEI_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SPEI_STONE)
            end
        elseif (yPos > -176 and yPos < -175) then
            if (player:hasKeyItem(tpz.ki.SALUS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.SALUS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SALUS_STONE)
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
