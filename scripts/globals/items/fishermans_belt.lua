-----------------------------------------
-- ID: 15452
-- Item: Fisherman's Belt
-- Enchantment: Fishing imagery
-----------------------------------------
-- Enchantment: Fishing imagery
-- Duration: 2 hrs
-- Fishing Skill +2
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
    target:addStatusEffect(tpz.effect.FISHING_IMAGERY, 2, 0, 7200) -- 2 hours
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FISH, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FISH, 1)
end