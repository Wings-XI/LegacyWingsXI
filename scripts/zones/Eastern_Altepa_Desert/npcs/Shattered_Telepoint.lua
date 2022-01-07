-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Dim POrtal
-- OOE
-----------------------------------

function onSpawn(npc)
    npc:setStatus(tpz.status.INVISIBLE)
end

function onTrigger(player, npc)
    npc:setStatus(tpz.status.INVISIBLE)
end