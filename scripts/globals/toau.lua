tpz = tpz or {}

tpz.toau = tpz.toau or {}

tpz.toau.mobSpecialHook = function (prefix, mob, chance, callback)

    mob:addListener("CRITICAL_TAKE", prefix .. "CRITICAL_TAKE", function(mob)
        if math.random(100) <= chance then
            callback(mob)
        end
     end)
     mob:addListener("ABILITY_TAKE", prefix .. "ABILITY_TAKE", function(mob, attacker, ability, action)
        local abilityID = ability:getID()
        if abilityID == 150      -- tomahawk
        or abilityID == 46       -- shield bash
        or abilityID == 77       -- weapon bash
        or abilityID == 66       -- jump
        or abilityID == 67       -- high jump
        or abilityID == 68       -- super jump
        or abilityID == 202      -- box step
        or abilityID == 170 then -- angon
            if math.random(100) <= chance then
                callback(mob)
            end
        end
     end)
     mob:addListener("WEAPONSKILL_TAKE", prefix .. "WEAPONSKILL_TAKE", function(mob, attacker, skillId, tp, action)
        if math.random(100) <= chance then
            callback(mob)
        end
    end)

end