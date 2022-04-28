-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Mieuseloir B Enchelles
-- !pos 120 0 104 80
-----------------------------------
------------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- Stand in text until we get a capture
    player:showText(npc, 11801) -- You have the look of a fine warrior. It is a pity you are not one of my Crimson Wolves.
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
