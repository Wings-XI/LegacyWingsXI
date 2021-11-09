-----------------------------------
-- Area: Batallia Downs
--  Mob: Goblin Gambler
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 2, tpz.regime.type.FIELDS)

    if not player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD) and player:getCurrentMission(ACP) >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I then
        -- Guesstimating 15% chance
        if math.random(100) >= 85 then
            player:addKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
        end
    end

end
