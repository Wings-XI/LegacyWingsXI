---------------------------------------------------------------------------------------------------
-- func: getcombatstats
-- desc:
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local targ = player:getCursorTarget()
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s's stats: acc %u, delay %u, dmg %u, dmgtype: %s", targ:getName(), targ:getACC(), targ:getWeaponDelay() * 60 / 1000, targ:getWeaponDmg(), targ:getWeaponDamageType(0)))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end

