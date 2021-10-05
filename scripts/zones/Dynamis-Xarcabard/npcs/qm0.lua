-----------------------------------
-- Area: Dynamis-Xarcabard
--  NPC: ??? (qm0)
-- Note: Grants Win KI after killing Dynamis Lord
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    local currTime = os.time()
    if npc:getLocalVar("lastActivation") + 5 > currTime then return end
    npc:setLocalVar("lastActivation", currTime)
    
    -- to fix issues with these QMs bugging out and giving wrong key items/deleting key items/not giving out key items
    -- they can only be activated every 5 seconds and will grant EVERYONE in range the key item
    -- because the issue is rooted in a big mob of people spam-activating the NPC at the same time
    -- a proper fix will require a full re-write of the cs/event system in core (much like Eden did)
    
    local nearbyPlayers = npc:getPlayersInRange(50)
    if nearbyPlayers == nil then return end
    local ID = require("scripts/zones/Dynamis-Bastok/IDs")
    
    for _,v in ipairs(nearbyPlayers) do
        if v:hasKeyItem(tpz.ki.HYDRA_CORPS_BATTLE_STANDARD) == false then
            v:addKeyItem(tpz.ki.HYDRA_CORPS_BATTLE_STANDARD)
            v:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HYDRA_CORPS_BATTLE_STANDARD)
        end
    end
end
