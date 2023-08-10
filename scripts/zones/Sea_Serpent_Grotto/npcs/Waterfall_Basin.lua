-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Waterfall Basin
-- Mission: A Moogle Kupo d'Etat mission 8: Lender Beware Read the Fine Print
-- !pos 104.888 0.482 -114.185
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/wsquest")
-----------------------------------

function onTrigger(player, npc)
    -- AMK 8
    if
        player:getCurrentMission(AMK) == tpz.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT and
        player:getCharVar("[AMK]7_LenderProgress") == 1
    then
        player:startEvent(20)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventFinish(player, csid, option)
    if csid == 20 then
        player:setCharVar("[AMK]7_LenderProgress", 2)
    end
end