-----------------------------------------
-- ID: 15554
-- Item: pelican ring
-- Increases chance of fishing skillup
-----------------------------------------
-- Duration: 20:00 min
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

local ringItemID = 15554
local ringMod = tpz.mod.PELICAN_RING_EFFECT
local ringEffect = tpz.effect.FISHING_RING

function onItemCheck(target)
    local result = 0
    -- buff can stack
    return result
end

function onItemUse(target)
    -- all the heavy lifting is done via  and effects lua
    -- status_effect_container: overwrite ignore
    -- status_effect_container: remove on zone
    -- effects lua: add/remove mod in sync with effect add/remove
    local duration = 1200
    target:addStatusEffectEx(ringEffect, tpz.effect.ENCHANTMENT, 1, 3, duration, 0, ringMod)
end