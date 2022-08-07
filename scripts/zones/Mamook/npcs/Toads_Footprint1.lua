-----------------------------------
-- Area: Mamook
-- NPC: Toads Footprint
-- !pos -42.7575 5.9660 -100.5741
-----------------------------------
local ID = require("scripts/zones/Mamook/IDs")
require("scripts/globals/npc_util")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local princeandhopper = player:getCharVar("princeandhopper")
    if princeandhopper == 3 then
        player:startEvent(223)
    elseif princeandhopper == 4 then
        local mobs =
        {
            ID.mob.MIKILULU,
            ID.mob.MIKIRURU,
            ID.mob.NIKILULU,
            ID.mob.MIKILURU,
            ID.mob.MIKIRULU,
            ID.mob.POROGGO_CASANOVA,
        }
        if npcUtil.popFromQM(player, npc, mobs, {hide = 1}) then
            player:messageSpecial(ID.text.DRAWS_NEAR)
        end
    elseif princeandhopper == 5 then
        player:startEvent(225)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 223 then
        player:setCharVar("princeandhopper", 4)
    elseif csid == 225 then
        player:setCharVar("princeandhopper", 6)
    end
end
