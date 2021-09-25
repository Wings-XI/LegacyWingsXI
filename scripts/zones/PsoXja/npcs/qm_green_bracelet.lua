-----------------------------------
-- Area: Pso'xja
--  NPC: ???
-- !pos -329.980 28.300 -163.000 9
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED then
        if not player:hasKeyItem(tpz.ki.GREEN_BRACELET) then
            if not GetMobByID(ID.mob.GARGOYLE_MU):isSpawned() and not GetMobByID(ID.mob.GARGOYLE_LAMBDA):isSpawned() then
                if player:getCharVar("Gargoyles_Killed") == 1 then
                    player:addKeyItem(tpz.ki.GREEN_BRACELET)
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GREEN_BRACELET)
                    player:setCharVar("Gargoyles_Killed", 0)
                else
                    npc:messageName(ID.text.TRAP_ACTIVATED, player)
                    GetNPCByID(16814502):setAnimation(9)
                    SpawnMob(ID.mob.GARGOYLE_MU):updateClaim(player)
                    SpawnMob(ID.mob.GARGOYLE_LAMBDA):updateClaim(player)
                end
            else
                player:messageSpecial(ID.text.COMPARTMENT_LOCKED)
            end
        else
            player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
