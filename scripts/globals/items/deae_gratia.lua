-----------------------------------------
-- ID: 18856
-- Item: Deae Gratia
-- Additional effect: HP Drain
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player,target,damage)
    local chance = 15

    if (math.random(0,99) >= chance or target:isUndead()) then
        return 0,0,0
    else
        local drain = 23 * (player:getMainLvl() / target:getMainLvl()) * (target:getMod(tpz.mod.SDT_DARK) / 100) + (player:getSkillLevel(tpz.skill.ENHANCING_MAGIC) / 16)
        if drain > 62 then
            drain = 62
        end    

        return tpz.subEffect.HP_DRAIN, tpz.msg.basic.ADD_EFFECT_HP_DRAIN, player:addHP(drain)
    end
end
