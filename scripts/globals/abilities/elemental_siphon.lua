-----------------------------------
-- Ability: Elemental Siphon
-- Drains MP from your summoned spirit.
-- Obtained: Summoner level 50
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local pet = player:getPetID()
    if (pet >= 0 and pet <= 7) then -- checking use with spirit
        return 0, 0
    else
        return tpz.msg.basic.UNABLE_TO_USE_JA, 0
    end
end

function onUseAbility(player,target,ability)
    local spiritEle = player:getPetElement() -- Just pulled the element ID for the pet to reduce confusion if future changes are made to sql database housing pets
    -- element order: fire, ice, wind, earth, thunder, water, light, dark

    local pEquipMods = player:getMod(tpz.mod.ENHANCES_ELEMENTAL_SIPHON) --Will be in era if expansions between TOAU/WINGS are implemented
    local basePower = player:getSkillLevel(tpz.skill.SUMMONING_MAGIC) + pEquipMods - 50
    if (basePower < 0) then
        basePower = 0
    end
    local WeatherDayBase = 1
    local DayBonus = 0
    local WeatherBonus = 0
    local dayElement = VanadielDayElement()
    local weather = player:getWeather()
    
    -- Day bonus/penalty
    if (dayElement == spiritEle) then
        DayBonus = DayBonus + 0.1
    elseif (dayElement == tpz.magic.elementDescendant[spiritEle]) then
        DayBonus = DayBonus - 0.1
    end
    -- Weather bonus/penalty
    if (weather == tpz.magic.singleWeatherStrong[spiritEle]) then
        WeatherBonus = WeatherBonus + 0.1
    elseif (weather == tpz.magic.singleWeatherWeak[spiritEle]) then
        WeatherBonus = WeatherBonus - 0.1
    elseif (weather == tpz.magic.doubleWeatherStrong[spiritEle]) then
        WeatherBonus = WeatherBonus + 0.25
    elseif (weather == tpz.magic.doubleWeatherWeak[spiritEle]) then
        WeatherBonus = WeatherBonus - 0.25
    end

    local power = math.floor(basePower * (WeatherDayBase + DayBonus + WeatherBonus))
    local spirit = player:getPet()
    power = utils.clamp(power, 0, spirit:getMP()) -- cap MP drained at spirit's MP
    power = utils.clamp(power, 0, player:getMaxMP() - player:getMP()) -- cap MP drained at the max MP - current MP

    spirit:delMP(power)
    return player:addMP(power)
end
