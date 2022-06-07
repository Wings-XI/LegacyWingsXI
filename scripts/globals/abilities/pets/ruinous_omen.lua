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
require("/scripts/globals/utils")
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
    local hpTarget = 30
    local max = 50
    local ratio = 4
    local currentHP = target:getHP()
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    
    if dINT <= 0 then ratio = 30 end

    if target:isNM() then
        if (target:getFamily() ~= 51 and target:getFamily() ~= 479) then -- Not a Behemoth
            min = 0.05
            max = 10
        else
            min = 2
            max = 10
        end
    end

    hpTarget = (math.random(min*100, max*100) / 100)

    hpTarget = hpTarget + ((dINT / ratio))

    -- Convert the reduction into an entity-specific amount based on their current HP
    local damage = currentHP * hpTarget / 100

    damage = MobMagicalMove(pet, target, skill, damage, tpz.magic.ele.DARK, 0.7, TP_NO_EFFECT, 0)
    damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.DARK)
    damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)

    damage = utils.clamp(damage, min*currentHP/100, max*currentHP/100)

    master:setMP(0)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)

    return damage
end
