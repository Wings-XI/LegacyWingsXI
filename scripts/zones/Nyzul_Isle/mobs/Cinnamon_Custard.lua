------------------------------------------
-- Cinnamon Custard
-- Nyzul Isle
-- Absorbs Water
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:addMod(tpz.mod.WATER_ABSORB, 100)
end

function onCastStarting(mob, spell)
    if (mob:getLocalVar("Xenoglossia") > 0) then
        mob:setLocalVar("Xenoglossia", 0)
        spell:castTime(1)
    end
end

function onMobDeath(mob, player, isKiller)
end
