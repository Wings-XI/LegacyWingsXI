---------------------------------------
-- Armoury Crates in Nyzul Isle
---------------------------------------
require("scripts/globals/nyzul_isle_armoury_crates")
---------------------------------------
function onTrigger(player, npc)
	tpz.nyzul_isle_armoury_crates.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
	tpz.nyzul_isle_armoury_crates.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
	tpz.nyzul_isle_armoury_crates.onEventFinish(player, csid, option, npc)
end