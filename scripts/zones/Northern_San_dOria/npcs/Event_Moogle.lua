-----------------------------------------------------------
--             Area: Northern San d'Oria                 --
--                     NPC: Moogle                       --
--         Involved in Event Related Questlines          --
-----------------------------------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------------------------
function onTrade(player, npc, trade)
    if isStarlightEnabled() ~= 0 then
        onStarlightCardTrade(player, trade, npc)
    end
end

function onTrigger(player, npc)
    if isStarlightEnabled() ~= 0 then
        onStarLightCardTrigger(player, npc)
    end
end