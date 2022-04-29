-----------------------------------
-- Area: GM Home
--  NPC: Fame
-- Raises fame in starting cities and Norg
-- License: GPLv3
-----------------------------------

require("scripts/globals/log_ids")

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    player:startEvent(21);
end;

function onEventUpdate(player, csid, option)
end;

function onEventFinish(player, csid, option)
	if (option < 0 or option >= 400) then
		return
	end
	nationid = math.floor(option / 100)
	famerank = option % 100

	if (nationid == 0) then nation = SANDORIA
	elseif (nationid == 1) then nation = BASTOK
	elseif (nationid == 2) then nation = WINDURST
	elseif (nationid == 3) then nation = NORG
	else return
	end

	if (famerank == 0 or famerank == 1) then fame = 0
	elseif (famerank == 2) then fame = 50
	elseif (famerank == 3) then fame = 125
	elseif (famerank == 4) then fame = 225
	elseif (famerank == 5) then fame = 325
	elseif (famerank == 6) then fame = 425
	elseif (famerank == 7) then fame = 488
	elseif (famerank == 8) then fame = 550
	elseif (famerank == 9) then fame = 613
	else return
	end

	player:setFame(nation, fame)
	player:setFame(JEUNO, math.floor((player:getFame(SANDORIA) + player:getFame(BASTOK) + player:getFame(WINDURST))/3))
	player:messageSpecial(7056, nationid, famerank)
end
