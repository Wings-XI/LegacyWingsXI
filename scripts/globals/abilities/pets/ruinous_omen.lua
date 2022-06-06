---------------------------------------------------
-- Ruinous Omen
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

    -- Get enemy current HP
    local mobHP = target:getHP()/100
    local min = 10
    local max = 50
    local damage = math.random(min, max) * mobHP
    if target:isNM() then
        if target:getFamily() ~= 51 then -- Not a Behemoth
            damage = 1*mobHP
            printf("%i HP", 1*mobHP)
        else
            damage = math.random(1, min) * mobHP
        end
    end

    -- day/weather start
    local ele = 8
    local caster = pet
    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()

    if (weather == tpz.magic.singleWeatherStrong[ele]) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif (caster:getWeather() == tpz.magic.singleWeatherWeak[ele]) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif (weather == tpz.magic.doubleWeatherStrong[ele]) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif (weather == tpz.magic.doubleWeatherWeak[ele]) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if (dayElement == ele) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif (dayElement == tpz.magic.elementDescendant[ele]) then
        if (math.random() < 0.33) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    damage = damage * dayWeatherBonus
    -- day/weather end

    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.DARK - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
    end

    
    if target:isNM() then
        if target:getFamily() ~= 51 then -- Not a Behemoth
            damage = utils.clamp(damage, 1*mobHP, max*mobHP)
        else
            damage = utils.clamp(damage, 1*mobHP, min*mobHP)
        end
    else
        damage = utils.clamp(damage, min*mobHP, max*mobHP)
    end


    if damage > 9999 then
        damage = 9999
    end

    damage = math.floor(damage)

    damage = utils.stoneskin(target, damage)

    master:setMP(0)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)

    target:updateEnmityFromDamage(pet, damage)

    return damage
end
