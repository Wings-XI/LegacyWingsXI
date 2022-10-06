-----------------------------------
--
-- tpz.effect.BIO
-- When provided a subeffect of SLEEP_I, this bio effect doesn't break any sleep effects
-- see nightmare.lua for more information
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:addMod(tpz.mod.ATTP, -subpower)
    -- Only use REGEN_DOWN if this is a regular Bio
    -- WINGSTODO Fix upstream
    if (effect:getSubType() ~= tpz.effect.SLEEP_I) then
        target:addMod(tpz.mod.REGEN_DOWN, power)
    end
end

function onEffectTick(target, effect)
    -- WINGSTODO Fix upstream
    -- handle diabolos nightmare bio damage explicitly
    -- This type of Bio doesn't break any type of sleep
    -- It does this by dealing lua damage with the `wakeUp` flag explicitly set to false
    if (effect:getSubType() == tpz.effect.SLEEP_I) then
        -- re-using logic from helix effect processing
        local dmg = utils.stoneskin(target, effect:getPower())
        if (dmg > 0) then
            -- we dont care about attacker, attack type, or dmg type
            -- no attacker so we don't trigger sleep removal via EFFECTFLAG_DAMAGE 
            target:takeDamage(dmg, nil, nil, nil, {wakeUp=false,breakBind=false})
        end

        if (effect:getTick() ~= 3000) then
            effect:setTick(3000)
        end
    end
end

function onEffectLose(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    target:delMod(tpz.mod.ATTP, -subpower)
    -- WINGSTODO Fix upstream
    -- Only use REGEN_DOWN if this is a regular Bio
    if (effect:getSubType() ~= tpz.effect.SLEEP_I) then
        target:delMod(tpz.mod.REGEN_DOWN, power)
    end
end
