-----------------------------------
--  tpz.effect.PATHOS
--  Used in Nyzul Isle to represent a variety of restrictions
-----------------------------------

--[[
    Bit     Val -   Effect
    1   -   1   -   JA Restriction
    2   -   2   -   WS Restriction
    3   -   4   -   White Magic Restriction
    4   -   8   -   Black Magic Restriction
    5   -   16  -   Bard Magic Restriction
    6   -   32  -   Ninjitsu Magic Restriction
    7   -   64  -   Summoning Magic Restriction
    8   -   128 -   Blue Magic Restriction
    9   -   256 -   Attack Speed Down
    10  -   512 -   Casting Speed Down
]]

function onEffectGain(target, effect)
    local power = effect:getPower()
    if (bit.band(power, (bit.lshift(1, 8))) > 0) then
        -- Attack Speed Down
        target:addMod(tpz.mod.HASTE_ABILITY, -2500)
    end
    if (bit.band(power, (bit.lshift(1, 9))) > 0) then
        -- Casting Speed Down
        target:addMod(tpz.mod.FASTCAST, -25)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    if (bit.band(power, (bit.lshift(1, 8))) > 0) then
        -- Attack Speed Down
        target:delMod(tpz.mod.HASTE_ABILITY, -2500)
    end
    if (bit.band(power, (bit.lshift(1, 9))) > 0) then
        target:delMod(tpz.mod.FASTCAST, -25)
    end
end
