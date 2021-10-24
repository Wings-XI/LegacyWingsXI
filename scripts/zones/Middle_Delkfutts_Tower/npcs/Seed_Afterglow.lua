-----------------------------------
-- Area: Middle Delkfutt's Tower
-- NPC: Seed Afterglow
-- Notes: Gives KI for A Crystaline Prophecy (ACP10)
-- !pos 20 -47.601 -60 157
-- !pos -40 -63.425 80 157
-- !pos -60 -79.601 20 157
-- !pos -420 -95.425 -20 157
-- !pos -385 -111.425 25 157
-- !pos -450 -127.854 20 157
-----------------------------------
local ID = require("scripts/zones/Middle_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local yPos = npc:getYPos()

    player:messageSpecial(ID.text.STONE_GLITTERS)
    if player:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION) then
        if (yPos > -48 and yPos < -47) then
            if (player:hasKeyItem(tpz.ki.SANCTITAS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.SANCTITAS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SANCTITAS_STONE)
            end
        elseif (yPos > -64 and yPos < -63) then
            if (player:hasKeyItem(tpz.ki.FELICITAS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.FELICITAS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.FELICITAS_STONE)
            end
        elseif (yPos > -80 and yPos < -79) then
            if (player:hasKeyItem(tpz.ki.DIVITIA_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.DIVITIA_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DIVITIA_STONE)
            end
        elseif (yPos > -96 and yPos < -95) then
            if (player:hasKeyItem(tpz.ki.STUDIUM_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.STUDIUM_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.STUDIUM_STONE)
            end
        elseif (yPos > -112 and yPos < -111) then
            if (player:hasKeyItem(tpz.ki.AMORIS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.AMORIS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AMORIS_STONE)
            end
        elseif (yPos > -128 and yPos < -127) then
            if (player:hasKeyItem(tpz.ki.CARITAS_STONE)) then
                player:messageSpecial(ID.text.STONE_ILLUSION)
            else
                player:addKeyItem(tpz.ki.CARITAS_STONE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CARITAS_STONE)
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
