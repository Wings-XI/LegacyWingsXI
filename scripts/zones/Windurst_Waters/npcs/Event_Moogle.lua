-----------------------------------------------------------
--                Area: Windurst Waters                  --
--                     NPC: Moogle                       --
--         Involved in Event Related Questlines          --
-----------------------------------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/events/starlight_festivals")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
-----------------------------------------------------------
function onTrade(player, npc, trade)
    onStarlightMoogleTrade(player, npc, trade)
end

function onTrigger(player, npc)
    onStarlightMoogleTrigger(player, npc)
end