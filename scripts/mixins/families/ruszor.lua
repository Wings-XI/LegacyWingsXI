-- Ruszor family mixin

--[[
    Ruszors will become bubbly after using Aqua Wave and frosty after using Frozen Mist.

    AnimationSub(0) = Normal state
    AnimationSub(1) = Bubbly state (water absorbing)
    AnimationSub(2) = Frosty state (physical immunity)
]]

require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local wsAftermath =
{
    [2438] = { mod = tpz.mod.UDMGPHYS,     value = -100, duration = 30,  animsub = 1, },    -- Frozen Mist aftermath
    [2439] = { mod = tpz.mod.WATER_ABSORB, value = 100,  duration = 60, animsub = 2, },     -- Aqua Wave aftermath
}

local function removeAftermath(mob)
    -- check if there's anything to remove in the first place
    local aftermathMod = mob:getLocalVar("AftermathMod")
    if aftermathMod > 0 then
        local aftermathValue = mob:getLocalVar("AftermathValue")
        mob:delMod(aftermathMod, aftermathValue)
    end

    -- reinitialize variables
    mob:setLocalVar("AftermathMod", 0)
    mob:setLocalVar("AftermathValue", 0)
    mob:setLocalVar("AftermathTimeout", 0)

    -- back to "Normal" state
    mob:AnimationSub(0)
end

g_mixins.families.ruszor = function(mob)
    -- to add aftermath after certain weaponskills are used
    mob:addListener("WEAPONSKILL_USE", "RUSZOR_WSUSE", function(mob, _, wsid)
        -- when using Aqua Wave or Frozen Mist
        if wsid == 2438 or wsid == 2439 then
            -- cleanup any previous aftermath
            removeAftermath(mob)

            -- keep track of current aftermath for removal
            local aftermath = wsAftermath[wsid]
            mob:setLocalVar("AftermathMod", aftermath.mod)
            mob:setLocalVar("AftermathValue", aftermath.value)
            mob:setLocalVar("AftermathTimeout", os.time() + aftermath.duration)

            -- add current aftermath and apply visual effect
            mob:addMod(aftermath.mod, aftermath.value)
            mob:AnimationSub(aftermath.animsub)
        end
    end)

    -- to keep track and remove aftermath after expiration
    mob:addListener("TICK", "RUSZOR_TICK", function(mob)
        -- remove aftermath if set and expired
        local timeout = mob:getLocalVar("AftermathTimeout")
        if timeout > 0 and timeout < os.time() then
            removeAftermath(mob)
        end
    end)
end

return g_mixins.families.ruszor