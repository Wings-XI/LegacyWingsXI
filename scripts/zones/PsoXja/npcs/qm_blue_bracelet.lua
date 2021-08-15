-----------------------------------
-- Area: Pso'xja
--  NPC: ???
-- !pos -282.742 -3.600 -210.000 9
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")

local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_REPUTATION_IN_RUINS) == QUEST_ACCEPTED then
        if not player:hasKeyItem(tpz.ki.BLUE_BRACELET) then
            if not GetMobByID(ID.mob.GARGOYLE_IOTA):isSpawned() and not GetMobByID(ID.mob.GARGOYLE_KAPPA):isSpawned() then
                if player:getCharVar("Gargoyles_Killed") == 1 then
                    --player:addKeyItem(tpz.ki.BLUE_BRACELET)
                    --player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLUE_BRACELET)
                    player:setCharVar("Gargoyles_Killed", 0)
                else
                    npc:messageName(ID.text.TRAP_ACTIVATED, player)
                    GetNPCByID(16814499):setAnimation(9)
                    SpawnMob(ID.mob.GARGOYLE_IOTA):updateClaim(player)
                    SpawnMob(ID.mob.GARGOYLE_KAPPA):updateClaim(player)
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
