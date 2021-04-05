-----------------------------------
--  Family: Marid
--  Behavior: 20% chance to break
--  a tusk on crit, adding a tusk
--  to the loot pool.
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/toau")
-----------------------------------

function onMobFamilyInitialize(mob)
    tpz.toau.mobSpecialHook("MARID", mob, 20, function(mob)
        local broken = mob:getLocalVar("TuskBroken")
        if broken < 2 then
            broken = broken + 1
            mob:setLocalVar("TuskBroken", broken)
            mob:AnimationSub(broken)
        end
    end)

    mob:addListener("DEATH", "MARID_DEATH", function(mob, killer)
        if killer then
            local broken = mob:getLocalVar("TuskBroken")
            if broken >= 1 then
                killer:addTreasure(2147, mob)
                if broken == 2 then
                    killer:addTreasure(2147, mob)
                end
            end
        end
    end)
end
