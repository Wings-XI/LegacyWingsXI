----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Wahid
-- Type: Quest NPC (A Jeweler's Lament)
-- Todo: Add quest.  Only adding chatter on initial commit.
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:startEvent(336)
end