---------------------------------------------------------------------------------------------------
-- func: getZeniValue
-- desc: Gives the Zeni Value of a mob if the user was to take a picture.
--       Does not include Sanraku's SubjectOfInterest or Fauna bonuses.
---------------------------------------------------------------------------------------------------
require("scripts/globals/znm")
-------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(player)
    local target = player:getCursorTarget()
    if (target ~= nil or target:isMob() == false) then
        local showDebugMessage = true
        player:PrintToPlayer(string.format("%d", tpz.znm.soultrapper.getZeniValue(target, player, showDebugMessage)))
    else
        player:PrintToPlayer("Must select a mob target using in game cursor first.")
    end
end
