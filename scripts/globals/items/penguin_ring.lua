-----------------------------------------
-- ID: 15553 and 15556
-- Item: penguin ring
-- Increases skill at tiring fish
-----------------------------------------
-- Bonus: The effect of the ring dramatically increases the rate of stamina drain of a fish while you try to reel it in.
-- Duration: 20:00 min
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

local ringItemID = 15553
local ringMod = tpz.mod.PENGUIN_RING_EFFECT
local ringEffect = tpz.effect.FISHING_RING

function onItemCheck(target)
    local result = 0
    -- if already have the ring's buff, cannot use
    if (target:getMod(ringMod) ~= 0) then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
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