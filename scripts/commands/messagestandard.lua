---------------------------------------------------------------------------------------------------
-- func: messagestandard
-- desc: Injects a message standard packet.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "ii"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!messagestandard <message ID> {param}")
end

function onTrigger(player, msgId, param1)
    -- validate msgId
    if (msgId == nil) then
        error(player, "You must provide a message ID.")
        return
    end

    --local target = player:getCursorTarget()
    --if target == nil then
    --    target = player
    --end

    -- inject message packet
    player:messageStandard(msgId, param1)
end
