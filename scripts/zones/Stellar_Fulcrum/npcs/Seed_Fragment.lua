-----------------------------------
-- Area: Stellar Fulcrum
-- NPC: Seed Fragment
-- Notes: Gives player Omnis Stone KI for A Crystaline Prophecy (ACP10)
-- !pos -528.94 0.254 0.89 179
-----------------------------------
local ID = require("scripts/zones/Stellar_Fulcrum/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.GEMSTONE_SHIMMERS)

    if player:getCurrentMission(ACP) >= tpz.mission.id.acp.BANISHING_THE_ECHO then
        if (
            player:hasKeyItem(tpz.ki.AMICITIA_STONE) and
            player:hasKeyItem(tpz.ki.VERITAS_STONE) and
            player:hasKeyItem(tpz.ki.SAPIENTIA_STONE) and
            player:hasKeyItem(tpz.ki.SANCTITAS_STONE) and
            player:hasKeyItem(tpz.ki.FELICITAS_STONE) and
            player:hasKeyItem(tpz.ki.DIVITIA_STONE) and
            player:hasKeyItem(tpz.ki.STUDIUM_STONE) and
            player:hasKeyItem(tpz.ki.AMORIS_STONE) and
            player:hasKeyItem(tpz.ki.CARITAS_STONE) and
            player:hasKeyItem(tpz.ki.CONSTANTIA_STONE) and
            player:hasKeyItem(tpz.ki.SPEI_STONE) and
            player:hasKeyItem(tpz.ki.SALUS_STONE)
        ) then
            player:messageSpecial(ID.text.GEMSTONE_FUSE)
            player:delKeyItem(tpz.ki.AMICITIA_STONE)
            player:delKeyItem(tpz.ki.VERITAS_STONE)
            player:delKeyItem(tpz.ki.SAPIENTIA_STONE)
            player:delKeyItem(tpz.ki.SANCTITAS_STONE)
            player:delKeyItem(tpz.ki.FELICITAS_STONE)
            player:delKeyItem(tpz.ki.DIVITIA_STONE)
            player:delKeyItem(tpz.ki.STUDIUM_STONE)
            player:delKeyItem(tpz.ki.AMORIS_STONE)
            player:delKeyItem(tpz.ki.CARITAS_STONE)
            player:delKeyItem(tpz.ki.CONSTANTIA_STONE)
            player:delKeyItem(tpz.ki.SPEI_STONE)
            player:delKeyItem(tpz.ki.SALUS_STONE)
            player:addKeyItem(tpz.ki.OMNIS_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OMNIS_STONE)
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end