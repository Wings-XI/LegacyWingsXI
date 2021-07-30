--------------------------------------------------------------
--  Family: Djinn
--  Behavior: When taking damage which matches with the
--            element of the day - the Djinn recieves 1K TP
--------------------------------------------------------------
require("scripts/globals/status")
--------------------------------------------------------------

function onMobFamilyInitialize(mob)
    mob:addListener("TAKE_DAMAGE", "DJINN_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        local offset = 5 -- Vanadiel Days go from Fire=1 to Dark=8.  DamageType goes from 0 to 13, With Fire=6 and Dark=13
        -- Ignoring attackType.NONE so dot ticks dont trigger
        if (attackType ~= tpz.attackType.NONE and VanadielDayElement() + offset == damageType) then
            mob:addTP(1000)
        end
    end)
end
