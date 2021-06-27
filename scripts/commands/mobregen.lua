---------------------------------------------------------------------------------------------------
-- func: mobregen
-- desc: gives a mob regen+500 for an hour. good for testing damage/mechanics on a punching bag.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 3,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if targ ~= nil and targ:isMob() then
        local regen = targ:getStatusEffect(tpz.effect.REGEN)
        targ:delStatusEffect(tpz.effect.REGEN)
        if regen == nil or regen:getPower() ~= 500 then -- it's toggleable
            targ:addStatusEffect(tpz.effect.REGEN, 500, 0, 3600)
            player:PrintToPlayer("Gave target mob super Regen.")
        else
            player:PrintToPlayer("Removed target mob's super Regen.")
        end
    else
        player:PrintToPlayer("Must select a target monster using in game cursor first.")
    end
end
