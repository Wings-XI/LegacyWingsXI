-----------------------------------
-- Area: Gustav tunnel (212)
-- NPC: Outcropping
-- Mission: Enemy of the Empire (II) - A Shantotto Ascension
-- !pos -134.658 -11.366 -185.199
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Gustav_Tunnel/IDs")

function onTrigger(player, npc)
    local spoken = player:getCharVar("ASA_spoken")
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and
    player:hasKeyItem(tpz.ki.BLACK_BOOK) and spoken == 0 then
        player:startEvent(13)
        player:setCharVar("ASA_spoken", 1)
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and
    player:hasKeyItem(tpz.ki.BLACK_BOOK) and spoken == 1 then
        player:startEvent(15)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local mobs = {ID.mob.RENFRED, ID.mob.GORATTZ, ID.mob.BOMPUPU}
    local QM = GetNPCByID(ID.npc.OUTCROPPING_QM)

    if csid == 15 and option == 1 then
        QM:setStatus(tpz.status.DISAPPEAR)
        player:messageSpecial(ID.text.BATTLE_TIME, 30)
        player:delKeyItem(tpz.ki.BLACK_BOOK)
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.BLACK_BOOK)
        player:addPartyEffect(276, 10, 0, 0) -- Add Confrontation Status to allow attacking the mobs
        npcUtil.popFromQM(player, QM, mobs, {
            claim = true,
            hide = 1
        })
    end
end
