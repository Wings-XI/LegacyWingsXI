-----------------------------------
-- Area: La Vaule [S]
-- NPC:  Reinforced Gateway
-- Inside BCNM 1 for Purple the New Black
-- !pos -114.386 -3.599 -179.804 85
-------------------------------------
require("scripts/globals/bcnm")
require("scripts/globals/missions")
-------------------------------------

function onTrigger(player, npc)
    if EventTriggerBCNM(player, npc) then
        return
    end
end

function onEventUpdate(player, csid, option, extras)
    local res = EventUpdateBCNM(player, csid, option, extras)
    return res
end

function onEventFinish(player, csid, option)
     if EventFinishBCNM(player, csid, option) then
        return
    end
end