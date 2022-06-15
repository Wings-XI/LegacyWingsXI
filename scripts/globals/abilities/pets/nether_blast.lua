---------------------------------------------------
-- Nether Blast
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/magic")
---------------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local mpCost = 109
    local level = pet:getMainLvl()
    local damage = (5 * level +  10) -- 385 ...
    
    --damage = MobMagicalMove(pet, target, skill, damage, tpz.magic.ele.DARK, 1, TP_NO_EFFECT, 0)
    --damage = mobAddBonuses(pet, nil, target, damage.dmg, tpz.magic.ele.DARK)
    --damage = AvatarFinalAdjustments(damage, pet, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, 1)
    
    local master = pet:getMaster()
    
    local mab = (100 + pet:getMod(tpz.mod.MATT)) / (100 + target:getMod(tpz.mod.MDEF))
    
    damage = damage * mab
    
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
    
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
        damage = 0
    end
    
    local skillchainTier, skillchainCount = FormMagicBurst(tpz.damageType.DARK - 5, target)
    if (skillchainTier > 0) then
        skill:setMsg(747)
        damage = damage * 1.28
    end
    
    damage = math.floor(damage)
    
    damage = utils.stoneskin(target, damage)
    target:takeDamage(damage, pet, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    target:updateEnmityFromDamage(pet, damage)
    
    pet:getMaster():addMP(-mpCost)
    return damage
end
