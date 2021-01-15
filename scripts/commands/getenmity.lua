---------------------------------------------------------------------------------------------------
-- func: getmod <modID>
-- desc: gets a mod by ID on the player or cursor target
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = ""
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getenmity")
end

function onTrigger(player)
    
    local targ = player:getCursorTarget()
    
    if targ == nil then
        error(player, "you must select a target with the cursor first")
    end
    
    player:PrintToPlayer(string.format("your enmity against %s is ... CE = %u ... VE = %u", targ:getName(), targ:getCE(player), targ:getVE(player)))
    
end
