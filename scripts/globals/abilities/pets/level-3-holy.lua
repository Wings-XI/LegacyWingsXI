---------------------------------------------------
-- Holy Roll 3
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/summon")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0,0
end

function onPetAbility(target, pet, skill)
    local power = 3
    local mpCost = 235
    local dMND = math.floor(pet:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))
    local ele = tpz.damageType.LIGHT
    local dmg = 0

    local dmgmod = 1
    local basedmg = pet:getMainLvl() * power + (dMND * 1.5)
    if target:getMainLvl() % power == 0 then
        local info = MobMagicalMove(pet, target, skill, basedmg, ele - 5, dmgmod, TP_NO_EFFECT, 10)
        dmg = mobAddBonuses(pet, nil, target, info.dmg, ele - 5)
        dmg = AvatarFinalAdjustments(dmg,pet,skill,target,tpz.attackType.MAGICAL,ele,1)

        local skillchainTier, skillchainCount = FormMagicBurst(ele - 5, target)
        if (skillchainTier > 0) then
            skill:setMsg(747)
        end

        target:takeDamage(dmg, pet, tpz.attackType.MAGICAL, ele)
        target:updateEnmityFromDamage(pet,dmg)
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    pet:getMaster():addMP(math.floor(-mpCost/skill:getTotalTargets()))

    return dmg
end
