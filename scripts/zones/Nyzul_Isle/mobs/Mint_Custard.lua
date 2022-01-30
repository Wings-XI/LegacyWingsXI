------------------------------------------
-- Mint Custard
-- Nyzul Isle
-- Absorbs Lightning
------------------------------------------
require("scripts/globals/status")
------------------------------------------
function onMobInitialize(mob)
    mob:addMod(tpz.mod.LTNG_ABSORB, 100)
end

function onCastStarting(mob, spell)
    if (mob:getLocalVar("Xenoglossia") > 0) then
        mob:setLocalVar("Xenoglossia", 0)
        spell:castTime(1)
    end
end

function onMobDeath(mob, player, isKiller)
end
