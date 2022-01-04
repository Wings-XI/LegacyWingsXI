-----------------------------------------
-- ID: 17492
-- Item: Shiva's Claws
-- Additional Effect: Paralyze
-- Gweivyth
----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/world")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 10
	if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100 then
        if (VanadielDayOfTheWeek() == tpz.day.ICEDAY) then
            chance = 45 + player:getMainLvl()*2 - target:getMainLvl()*2
            if chance < 25 then
                chance = 25
            elseif chance > 65 then
                chance = 65
            end
        end
        
        if math.random(0,100) <= chance and applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) > 0.5 then
            target:addStatusEffect(tpz.effect.PARALYSIS, 10, 0, 30)
            return tpz.subEffect.PARALYSIS, tpz.msg.basic.ADD_EFFECT_STATUS, tpz.effect.PARALYSIS
        end

        return 0, 0, 0
    end
end
