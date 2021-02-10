-----------------------------------------
-- ID: 17622
-- Item: Buccaneer's Knife
-- Additional Effect: Water damage when facing brigandish blade.
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    if target:getID() == 17502568 and (player:getEquipID(tpz.slot.MAIN) == 17622) then
        local chance = 90

        if math.random(100) <= chance then
            target:delStatusEffectSilent(tpz.effect.MAGIC_SHIELD)
            local finalDMG = math.floor(40, 60)
            if finalDMG > 0 then
                finalDMG = target:magicDmgTaken(finalDMG)
                finalDMG = utils.clamp(finalDMG, 0, 99999)
                target:takeDamage(finalDMG, player, tpz.attackType.MAGICAL, tpz.damageType.WATER)
                target:setUnkillable(false)
                return tpz.subEffect.WATER_DAMAGE, tpz.msg.basic.ADD_EFFECT_DMG, finalDMG
            end
        end
    end

    return 0, 0, 0
end
