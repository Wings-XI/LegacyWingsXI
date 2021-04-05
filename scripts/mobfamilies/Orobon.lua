-----------------------------------
--  Family: Orobon
--  Behavior: 10% chance to break 
--  eyestalks on crit
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/toau")
-----------------------------------

function onMobFamilyInitialize(mob)
    tpz.toau.mobSpecialHook("OROBON", mob, 10, function(mob)
        local isBroken = mob:getLocalVar("LureBroken")
        if not isBroken and mob:AnimationSub() == 0 then
            mob:setLocalVar("LureBroken", 1)
            mob:AnimationSub(1)
        end
    end)

    mob:addListener("DEATH", "OROBON_DEATH", function(mob, killer)
        if mob:getLocalVar("LureBroken") > 0 then
            local numLures = math.random(1,2)
            for _ = 1, numLures do
                killer:addTreasure(2154, mob)
            end
        end
    end)
end
