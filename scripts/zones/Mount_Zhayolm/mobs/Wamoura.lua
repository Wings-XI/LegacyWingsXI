-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Wamoura
-- Note: PH for Ignamoth
-----------------------------------
local ID = require("scripts/zones/Mount_Zhayolm/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    if not evolvedFromPrince(mob) then
        mob:setTrueDetection(0) -- according to wiki, the naturally spawning Wamoura do not have true detection
    end
end

function onMobDeath(mob)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.IGNAMOTH_PH, 10, 7200) -- 2 hours
    if evolvedFromPrince(mob) then
        local princeID = mob:getID() - 1
        DisallowRespawn(princeID, false)
    end
end

function evolvedFromPrince(mob)
    local evolved = false
    local mobId = mob:getID()

    for i,v in pairs(ID.mob.EVOLVING_WAMOURA_PRINCES) do
        if mobId == v+1 then
            evolved = true
        end
    end

    return evolved    
end
