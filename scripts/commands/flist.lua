---------------------------------------------------------------------------------------------------
-- func: addkeyitem <ID> <player>
-- desc: Adds a key item to the player.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "ssssssssss"
};

function error(player, msg)
    --player:PrintToPlayer(msg);
    --player:PrintToPlayer("!addkeyitem <key item ID> {player}");
end;

function onTrigger(player, string1, string2, string3, string4, string5, string6, string7, string8, string9, string10)
	
	if (string1 == nil) then
		string1 = "FLnull"
	end
	
	if (string2 == nil) then
		string2 = "FLnull"
	end
	
	if (string3 == nil) then
		string3 = "FLnull"
	end
	
	if (string4 ~= nil) then
		string3 = string3 .. " " .. string4
	end
	
	if (string5 ~= nil) then
		string3 = string3 .. " " .. string5
	end
	
	if (string6 ~= nil) then
		string3 = string3 .. " " .. string6
	end
	
	if (string7 ~= nil) then
		string3 = string3 .. " " .. string7
	end
	
	if (string8 ~= nil) then
		string3 = string3 .. " " .. string8
	end
	
	if (string9 ~= nil) then
		string3 = string3 .. " " .. string9
	end
	
	if (string10 ~= nil) then
		string3 = string3 .. " " .. string10
	end
	
    player:friendListMain(string1,string2,string3)
	
end;
