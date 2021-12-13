-----------------------------------------------------------------------
-- func: yell
--       yell IAgree
-- desc: show the yell rules and perform opt-in when requested
-----------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function onTrigger(player, iAgree)
    local hasReadRules = player:getCharVar("YellReadRules") ~= 0
    local isOptedIn = player:getCharVar("YellOptedIn") ~= 0
    local muteTime = player:getCharVar("YellMuteTime")
    local yellBan = player:getCharVar("YellBan")

    local currentTime = os.time()

    local isMuted = (muteTime > currentTime) or (yellBan ~= 0)

    if hasReadRules and not isMuted and not isOptedIn and string.lower(iAgree or '') == 'iagree' then
        player:PrintToPlayer("You are now permitted to use the /yell command. Go forth and be excellent to each other.")
        player:setCharVar("YellOptedIn", 1)
        return
    end

    player:PrintToPlayer("The /yell command is a privilege subject to the rules found on the WingsXI website.")

    player:PrintToPlayer("Players that fail to follow the /yell rules may have their /yell privilege revoked.", 29)
    player:PrintToPlayer("Website: https://www.wingsxi.com/wings/index.php?page=rules", 29)

    if muteTime > currentTime then
        player:PrintToPlayer("NOTICE: You are currently muted and unable to use the /yell command.", 29)
    else
        if not isOptedIn then
            player:PrintToPlayer("Please type \"!yell iagree\" if you have read and agree to the rules and wish to use /yell.", 29)
        end

        -- Mark them as having read the rules.
        player:setCharVar("YellReadRules", 1)
    end
end
