-----------------------------------------
-- ID: 17324
-- Item: Lightning Arrow
-- Additional Effect: Lightning
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    local chance = 95
    if target:getMod(tpz.mod.THUNDERRES) < 100 then
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
        dmg = addBonusesAbility(player, tpz.magic.ele.THUNDER, target, dmg, params)
        dmg = dmg * applyResistanceAddEffect(player,target,tpz.magic.ele.THUNDER,0)
        dmg = adjustForTarget(target,dmg,tpz.magic.ele.THUNDER)
        dmg = finalMagicNonSpellAdjustments(player,target,tpz.magic.ele.THUNDER,dmg)
        local message = tpz.msg.basic.ADD_EFFECT_DMG
        if (dmg < 0) then
            message = tpz.msg.basic.ADD_EFFECT_HEAL
            dmg = -dmg
        end

        return tpz.subEffect.LIGHTNING_DAMAGE,message,dmg
    end
end