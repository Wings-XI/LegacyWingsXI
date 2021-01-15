---------------------------------------------------------------------------------------------------
-- func: tp <amount>
-- desc: 
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = "i"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!tp <amount>");
end;

function onTrigger(player, tp)

    -- validate amount
    if (tp == nil or tonumber(tp) == nil) then
        error(player, "You must provide an amount.");
        return;
    elseif (tp < 0) then
        error(player, "Invalid amount.");
        return;
    end

    local target = player:getCursorTarget()

    -- set tp
    if target and target:isMob() then
        target:setTP(tp)
    else
        error("must target a monster first!")
    end
    
end;