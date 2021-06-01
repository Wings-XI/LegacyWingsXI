-----------------------------------
-- Area: Xarcabard
--   NM: Boreal Tiger
-- Involved in Quests: Atop the Highest Mountains
-- !pos 341 -29 370 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_INCLUDE_PARTY, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 15)
    -- Failsafe to make sure NPC is down when NM is up
    if OLDSCHOOL_G2 then
        GetNPCByID(ID.npc.BOREAL_TIGER_QM):showNPC(0)
    end
end

function onMobDeath(mob, player, isKiller)
    if OLDSCHOOL_G2 then
        -- show ??? for desired duration
        -- notify people on the quest who need the KI
        GetNPCByID(ID.npc.BOREAL_TIGER_QM):showNPC(FRIGICITE_TIME)
        if
            not player:hasKeyItem(tpz.ki.ROUND_FRIGICITE) and
            player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED
        then
            player:messageSpecial(ID.text.BLOCKS_OF_ICE)
        end
    end
end
