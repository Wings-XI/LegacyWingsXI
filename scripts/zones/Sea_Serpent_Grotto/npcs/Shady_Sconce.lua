-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Shady Sconce
-- Mission: A Moogle Kupo d'Etat mission 8: Lender Beware Read the Fine Print
-- !pos -179.563 24.093 274.055
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/wsquest")
-----------------------------------

function onTrigger(player, npc)
    -- AMK 8
    if
        player:getCurrentMission(AMK) == tpz.mission.id.amk.LENDER_BEWARE_READ_THE_FINE_PRINT and
        player:getCharVar("[AMK]7_LenderProgress") == 0
    then
        player:startEvent(19, 176)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventFinish(player, csid, option)
    if csid == 19 and option == 1 then
        player:setCharVar("[AMK]7_LenderProgress", 1)
    end
end