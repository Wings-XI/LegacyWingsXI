-----------------------------------------
-- ID: 15444
-- Item: Carpenter's belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2Min
-- Woodworking Skill +3
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    local imagery = 
	{
	tpz.effect.FISHING_IMAGERY,
	tpz.effect.WOODWORKING_IMAGERY,
	tpz.effect.SMITHING_IMAGERY,
	tpz.effect.GOLDSMITHING_IMAGERY,
	tpz.effect.CLOTHCRAFT_IMAGERY,
	tpz.effect.LEATHERCRAFT_IMAGERY,
	tpz.effect.BONECRAFT_IMAGERY,
	tpz.effect.ALCHEMY_IMAGERY,
	tpz.effect.COOKING_IMAGERY
	}

    for i, effect in ipairs(imagery) do
        if (target:hasStatusEffect(effect)) then
            result = tpz.msg.basic.ITEM_UNABLE_TO_USE
        end
    end
    
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 3, 0, 120)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.WOOD, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.WOOD, 1)
end
