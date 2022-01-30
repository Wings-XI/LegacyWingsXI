--------------------------------------------------------------
--  Family: Soulflayer
--  Behavior: Updates the animation sub of Soulflayer mobs based on TP moves
--------------------------------------------------------------
require("scripts/globals/status")
--------------------------------------------------------------

local function updateShieldAnimation(mob)
    -- MAGICAL dmg was taken - therefore the shield is down
    if (mob:AnimationSub() > 0) then
        mob:AnimationSub(0)
    end
end

function onMobFamilyInitialize(mob)
    mob:addListener("TAKE_DAMAGE", "SOULFLAYER_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.MAGICAL then
            updateShieldAnimation(mob)
        end
        -- about to die
        if (amount > mob:getHP()) then
            mob:AnimationSub(0)
        end
    end)
end
