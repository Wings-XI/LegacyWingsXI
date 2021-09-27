-----------------------------------------------------------
--                Area: Windurst Waters                  --
--                     NPC: Moogle                       --
--         Involved in Event Related Questlines          --
-----------------------------------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/events/starlight_festivals")
-----------------------------------------------------------
function onTrade(player, npc)
    if isStarlightEnabled() ~= 0 then
        onStarlightCardTrade(player, trade, npc)
    end
end

function onTrigger(player, npc)
    if isStarlightEnabled() ~= 0 then
        onStarLightCardTrigger(player, npc)
    end
end