-----------------------------------
--  Family: Worm
--  Behavior: Do not cast magic
--  while not engaged or target
--  in melee range
-----------------------------------

function onMobFamilyInitialize(mob)
    mob:addListener("SPAWN", "WORM_SPAWN", function(mob)
        mob:SetMagicCastingEnabled(false)
    end)

    mob:addListener("COMBAT_TICK", "WORM_CTICK", function(mob)
        local target = mob:getTarget()
        if target then
            if mob:checkDistance(target) < (mob:getMeleeRange() - 0.2) then
               mob:SetMagicCastingEnabled(false)
            else 
                mob:SetMagicCastingEnabled(true)                        
            end
         end 
    end)
end
