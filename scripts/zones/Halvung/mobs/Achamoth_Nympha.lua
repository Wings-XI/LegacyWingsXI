-----------------------------------
-- Area: Halvung
--  Mob: Achamoth Nympha
-- Author: Spaceballs
-----------------------------------

-- Max of 2 adds TOTAL
-- Should be very resistant to sleep

local ID = require("scripts/zones/Halvung/IDs")

function onMobDeath(mob)

end

function onMobDespawn(mob)
    local mother = GetMobByID(ID.mob.ACHAMOTH)
    if mother:isSpawned() then
        mother:setLocalVar("bigAdds", mother:getLocalVar("bigAdds") - 1)
    end
end