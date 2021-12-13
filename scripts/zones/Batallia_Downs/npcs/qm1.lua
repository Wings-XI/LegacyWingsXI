-----------------------------------
-- Area: Batallia Downs
--  NPC: qm1 (???)
-- !pos -407.526 -23.507 412.544 105
-- Notes: Spawns Vegnix Greenthumb for ACP mission "Gatherer of Light (I)"
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onSpawn(npc)
    if ENABLE_ACP == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not GetMobByID(ID.mob.VEGNIX_GREENTHUMB):isSpawned() and player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and not player:hasKeyItem(tpz.ki.SEEDSPALL_ROSEUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:messageSpecial(ID.text.FOREBODING)
        SpawnMob(ID.mob.VEGNIX_GREENTHUMB):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS) -- NOTHING_OUT_OF_ORDINARY
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
