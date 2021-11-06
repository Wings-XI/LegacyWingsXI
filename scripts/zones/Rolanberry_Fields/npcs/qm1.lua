-----------------------------------
-- Area: Rolanberry Fields
--  NPC: qm1 (???)
-- !pos -686.216 -31.556 -369.723 110
-- Notes: Spawns Chuglix Berrypaws for ACP mission "Gatherer of Light (I)"
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onSpawn(npc)
    if ENABLE_ACP == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not GetMobByID(ID.mob.CHUGLIX_BERRYPAWS):isSpawned() and player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) and not player:hasKeyItem(tpz.ki.SEEDSPALL_CAERULUM) and not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY) then
        player:messageSpecial(ID.text.FOREBODING)
        SpawnMob(ID.mob.CHUGLIX_BERRYPAWS):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS) -- NOTHING_OUT_OF_ORDINARY
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
