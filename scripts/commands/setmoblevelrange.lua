---------------------------------------------------------------------------------------------------
-- func: setmoblevel
-- desc: Sets the target monsters level.
---------------------------------------------------------------------------------------------------
require("scripts/globals/msg")

cmdprops =
{
    permission = 3,
    parameters = "ii"
}


function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setmoblevelrange <level>")
end

function onTrigger(player, minlv, maxlv)
    local target = player:getCursorTarget()
    
    if minlv == nil then
        minlv = 1
    end
    if maxlv == nil then
        maxlv = 1
    end
    
    -- set level
    if target and target:isMob() then
        target:setMobLevelRange(minlv,maxlv)
        player:PrintToPlayer(string.format("%s's level range has been set to %u~%u.", target:getName(), minlv, maxlv, tpz.msg.channel.SYSTEM_3))
    else
        error("must target a monster first!")
    end
end
