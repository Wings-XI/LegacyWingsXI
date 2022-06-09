-----------------------------------------
-- ID: 17322
-- Item: Fire Arrow
-- Additional Effect: Fire
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 95
    if target:getMod(tpz.mod.FIRERES) < 100 then
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
        dmg = utils.clamp(dmg, 0, 12)
        local params = {}
        params.bonusmab = 0
        params.includemab = false
        dmg = addBonusesAbility(player, tpz.magic.ele.FIRE, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.FIRE,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.FIRE)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.FIRE,dmg)
        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.FIRE_DAMAGE,message,dmg
    end
end