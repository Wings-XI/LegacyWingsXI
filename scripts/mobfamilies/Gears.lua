--------------------------------------------------------------
--  Family: Gears
--  Behavior: Updates the animation sub and mob skill list of Gears based on loss of hp 
--------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/gears")
--------------------------------------------------------------
--[[
    Gears
    AnimationSub(0) = 3 Gears
    AnimationSub(1) = 2 Gears
    AnimationSub(2) = 1 Gear

    Gears lose a gear at 50% and another at 25%
    Restoral can cause a Gears to regain a gear
    Gears TP moves are different depending on the number of Gears
    More Gears "alive" = More powerful TP moves

    Need to
        - catch hp falling through threasholds (take_damage)
        - catch hp raising (WEAPONSKILL_USE)  Could I make restoral take negative damage?
        - Swap skill lists and AnimationSubs


]]

function onMobFamilyInitialize(mob)
    mob:addListener("TAKE_DAMAGE", "GEARS_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        local currentHP = mob:getHP()
        local maxHP = mob:getMaxHP()
        
        -- If the mob dies, who cares
        if ((currentHP - amount) <= 0 ) then
            return
        end
        
        -- This is called before the damage is applied - so calculate the predicted HPP
        local predictedHPP = math.floor(100 * ((currentHP - amount) / maxHP))
        local currentAnimationSub = mob:AnimationSub()
        printf("currentHP %s - maxHP %s - amount %s - predictedHPP %s - currentAnimationSub %s", currentHP, maxHP, amount, predictedHPP, currentAnimationSub)

        if (predictedHPP <= 25) and (not (currentAnimationSub == 2)) then
            -- 1 Gear remaining
            printf("going to 1 gear remaining")
            tpz.gears.updateNumberOfGears(mob, 2)
        elseif (predictedHPP <= 50) and (not (currentAnimationSub == 1)) then
            -- 2 Gears remaining
            printf("going to 2 gear remaining")
            tpz.gears.updateNumberOfGears(mob, 1)
        end
    end)
end