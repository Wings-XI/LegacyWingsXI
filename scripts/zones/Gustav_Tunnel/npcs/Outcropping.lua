-----------------------------------
-- Area: Gustav tunnel (212)
-- NPC: Outcropping
-- Mission: Enemy of the Empire (II) - A Shantotto Ascension
-- !pos -134.658 -11.366 -185.199
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Gustav_Tunnel/IDs")

function onTrigger(player, npc)
    local phase = player:getCharVar("ASA_enemyPhase")
    if player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and
    player:hasKeyItem(tpz.ki.BLACK_BOOK) and phase == 0 then
        player:startEvent(13)
        player:setCharVar("ASA_enemyPhase", 1)
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and
    player:hasKeyItem(tpz.ki.BLACK_BOOK) and phase == 1 then
        player:startEvent(15)
    elseif player:getCurrentMission(ASA) == tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and
    phase == 2 then
        -- Known issue with event 14 even on retail that black screens when using Windower/Ashita
        -- Placed all logic into trigger to ensure players move to next mission
        player:PrintToPlayer("NOTICE: Cutscene is not displayed due to a known issue from retail causing Ashita/Windower users to get locked in a black screen.",29)
        player:PrintToPlayer("You are now on the mission Sugar Coated Subterfuge.",29)
        player:completeMission(ASA, tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II)
        player:addMission(ASA, tpz.mission.id.asa.SUGAR_COATED_SUBTERFUGE)
    else
        player:messageSpecial(ID.text.OUTCROPPING)
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
        for _, member in pairs(player:getAlliance()) do
            if member:hasKeyItem(tpz.ki.BLACK_BOOK) then
                member:setLocalVar("hadBook", 1)
                member:delKeyItem(tpz.ki.BLACK_BOOK)
            end
        end
        player:messageSpecial(ID.text.KEYITEM_LOST, tpz.ki.BLACK_BOOK)
        player:addPartyEffect(276, 10, 0, 0) -- Add Confrontation Status to allow attacking the mobs
        npcUtil.popFromQM(player, QM, mobs, {
            claim = true,
            hide = 1
        })
    end
end
