------------------------------------------
-- Ginger Custard
-- Nyzul Isle
-- Absorbs Light and Fire
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:addMod(tpz.mod.FIRE_ABSORB, 100)
    mob:addMod(tpz.mod.LIGHT_ABSORB, 100)
end

function onCastStarting(mob, spell)
    if (mob:getLocalVar("Xenoglossia") > 0) then
        mob:setLocalVar("Xenoglossia", 0)
        spell:castTime(1)
    end
end

function onMobDeath(mob, player, isKiller)
end
