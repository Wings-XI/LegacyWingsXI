-----------------------------------
-- Area: Dyna-Bubu
--  Mob: Apoc Beast Wyvern
-----------------------------------
-- mixins = {require("scripts/mixins/families/avatar")}
-----------------------------------

function onMobInitialize(mob)
end

function onMobRoam(mob)
    local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
    local apocBeast = GetMobByID(ID.mob.Apocalyptic_Beast)
    if apocBeast:isAlive() and apocBeast:isEngaged() then
        mob:updateEnmity(apocBeast:getTarget())
    else
        local petOffset = mob:getID() - ID.mob.Dragons_Wyverns[1] + 1
        -- path X yalms away from previous pet, copied from mother globe
        mob:pathTo(apocBeast:getXPos() + 0.75 * petOffset, apocBeast:getYPos(), apocBeast:getZPos()  + 0.75 * petOffset)
    end
end
