---------------------------------------------------------------------------------------------------
-- func: unstuck
-- desc: Self service recovery from stuck under the map situations
---------------------------------------------------------------------------------------------------

require("scripts/globals/settings")

cmdprops =
{
    permission = 0,
    parameters = ""
}

function onTrigger(player)
    -- We keep a count on the number of uses of this command to check if
    -- people abuse it for free warps
    player:setCharVar("UnstuckUses", player:getCharVar("UnstuckUses") + 1)
    
    -- Give them absolute terror for a while, which discourages frequent use and
    -- also prevents the possibility of use to escape aggro
    player:addStatusEffect(28, 9999, 3, UNSTUCK_WAIT, 0, 0)
	
	-- Don't let people use this command to escape from jail (but let them waste time waiting)
	if player:getCharVar("inJail") == 0 then
		-- Will warp then once their terror ends
		player:queue(UNSTUCK_WAIT + 3, function(player)
			player:warp()
		end)
	else
		player:queue(UNSTUCK_WAIT + 3, function(player)
			player:PrintToPlayer("Nice try!")
		end)
	end
	
    -- Let them know what's hapening
    local time_nice = ""
    if UNSTUCK_WAIT >= 60 then
        time_nice = string.format("%d minutes", math.floor(UNSTUCK_WAIT / 60))
    else
        time_nice = string.format("%d seconds", UNSTUCK_WAIT)
    end
    player:PrintToPlayer(string.format("Unstuck mode actvated, you will be warped to your homepoint in %s.", time_nice))
end
