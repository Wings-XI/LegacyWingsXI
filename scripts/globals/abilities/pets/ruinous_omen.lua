---------------------------------------------------
-- Ruinous Omen
-- Sources:
-- https://www.bg-wiki.com/ffxi/Ruinous_Omen
-- https://www.bluegartr.com/threads/108197-Random-Facts-Thread-Abilities?p=6003851&viewfull=1#post6003851
-- https://www.bluegartr.com/threads/35650-Diabolos-This-Way?s=f56900f365d3dd0ee19bf2efa5a69b38&p=1155067&viewfull=1#post1155067
-- https://seesaawiki.jp/w/homelos/d/%A5%EB%A5%A4%A5%CA%A5%B9%A5%AA%A1%BC%A5%E1%A5%F3
-- https://www.youtube.com/watch?v=0a_khHBAdxQ
---------------------------------------------------
require("/scripts/globals/settings")
require("/scripts/globals/status")
require("/scripts/globals/monstertpmoves")
require("scripts/globals/utils")
require("/scripts/globals/magic")

---------------------------------------------------

function onAbilityCheck(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP()<level) then
        return 87, 0
    end

    return 0, 0
end

function onPetAbility(target, pet, skill, master)

    -- Target HP decrease seems to be about 40% unresisted, 1% on NMs.
    -- Maximum observed 50% (weakness to darkness?), 10% on NMs.
    -- Minimum observed 10% (high resist), 0.05% on NMs
    local min = 10
    local max = 50
    local ratio = 4
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    
    if dINT <= 0 then ratio = 30 end

    if target:isNM() then
        printf("Current Target: %s, is NM", target:getName())
        if (target:getFamily() ~= 51 and target:getFamily() ~= 479) then -- Not a Behemoth
            printf("Current Target: %s, is NOT Behemoth", target:getName())
            min = 0.05
            max = 10
        else
            printf("Current Target: %s, is a Behemoth", target:getName())
            min = 2
            max = 10
        end
    end

    hpTarget = math.random(min, max)

    hpTarget = hpTarget + ((dINT / ratio))

    printf("Current Target: %s, dINT = %i, hpTarget = %i", target:getName(), dINT, hpTarget)

    hpTarget = MobMagicalMove(pet, target, skill, hpTarget, tpz.magic.ele.DARK, 0.7, TP_NO_EFFECT, 0)
    printf("Current Target: %s, after MobMagicalMove, hpTarget = %i", target:getName(), hpTarget.dmg)
    hpTarget = mobAddBonuses(pet, nil, target, hpTarget.dmg, tpz.magic.ele.DARK)
    printf("Current Target: %s, after mobAddBonuses, hpTarget = %i", target:getName(), hpTarget)
    hpTarget = AvatarFinalAdjustments(hpTarget, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    printf("Current Target: %s, after AvatarFinalAdjustments, hpTarget = %i", target:getName(), hpTarget)

    hpTarget = utils.clamp(hpTarget, min, max)
    printf("Current Target: %s, after clamping, hpTarget = %i", target:getName(), hpTarget)

    -- Convert the reduction into an entity-specific amount based on their current HP
    local damage = target:getHP() * hpTarget / 100
    printf("Final Damage = %i", damage)

    master:setMP(0)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)

    target:updateEnmityFromDamage(pet, damage)

    return damage
end
