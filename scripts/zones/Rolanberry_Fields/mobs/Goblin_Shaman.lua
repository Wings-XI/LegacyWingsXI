-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Goblin Shaman
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 86, 2, tpz.regime.type.FIELDS)

    if not player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE) and player:getCurrentMission(ACP) >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I then
        -- Guesstimating 15% chance
        if math.random(100) >= 85 then
            player:addKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
        end
    end
end
