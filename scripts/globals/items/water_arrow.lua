-----------------------------------------
-- ID: 18698
-- Item: Water Arrow
-- Additional Effect: Water
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 95
    if target:getMod(tpz.mod.WATERRES) < 100 then
        if (target:getMainLvl() > player:getMainLvl()) then
            chance = chance - 5 * (target:getMainLvl() - player:getMainLvl())
            chance = utils.clamp(chance, 5, 95)
        end
    end

    if target:isNM() then
        chance = 35
    end

    if (math.random(0,99) >= chance) then
        return 0,0,0
    else
        dmg = player:getStat(tpz.mod.AGI) - target:getStat(tpz.mod.AGI)
        if dmg <= 0 then
            dmg = 1
        end
        dmg = utils.clamp(dmg, 0, 10)
        dmg = dmg + player:getMod(tpz.mod.INT)/3
        dmg = utils.clamp(dmg, 0, 67)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.WATER, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.WATER,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.WATER)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.WATER,dmg)
        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.WATER_DAMAGE,message,dmg
    end
end