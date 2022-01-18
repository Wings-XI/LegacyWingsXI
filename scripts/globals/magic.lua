require("scripts/globals/spell_data")
require("scripts/globals/magicburst")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/msg")
------------------------------------

tpz = tpz or {}
tpz.magic = tpz.magic or {}

------------------------------------
-- Tables by element
------------------------------------

tpz.magic.dayStrong           = {tpz.day.FIRESDAY,              tpz.day.ICEDAY,               tpz.day.WINDSDAY,               tpz.day.EARTHSDAY,              tpz.day.LIGHTNINGDAY,               tpz.day.WATERSDAY,               tpz.day.LIGHTSDAY,           tpz.day.DARKSDAY}
tpz.magic.singleWeatherStrong = {tpz.weather.HOT_SPELL,         tpz.weather.SNOW,             tpz.weather.WIND,               tpz.weather.DUST_STORM,         tpz.weather.THUNDER,                tpz.weather.RAIN,                tpz.weather.AURORAS,         tpz.weather.GLOOM}
tpz.magic.doubleWeatherStrong = {tpz.weather.HEAT_WAVE,         tpz.weather.BLIZZARDS,        tpz.weather.GALES,              tpz.weather.SAND_STORM,         tpz.weather.THUNDERSTORMS,          tpz.weather.SQUALL,              tpz.weather.STELLAR_GLARE,   tpz.weather.DARKNESS}
local elementalObi            = {tpz.mod.FORCE_FIRE_DWBONUS,    tpz.mod.FORCE_ICE_DWBONUS,    tpz.mod.FORCE_WIND_DWBONUS,     tpz.mod.FORCE_EARTH_DWBONUS,    tpz.mod.FORCE_LIGHTNING_DWBONUS,    tpz.mod.FORCE_WATER_DWBONUS,     tpz.mod.FORCE_LIGHT_DWBONUS, tpz.mod.FORCE_DARK_DWBONUS}
local spellAcc                = {tpz.mod.FIREACC,               tpz.mod.ICEACC,               tpz.mod.WINDACC,                tpz.mod.EARTHACC,               tpz.mod.THUNDERACC,                 tpz.mod.WATERACC,                tpz.mod.LIGHTACC,            tpz.mod.DARKACC}
local strongAffinityDmg       = {tpz.mod.FIRE_AFFINITY_DMG,     tpz.mod.ICE_AFFINITY_DMG,     tpz.mod.WIND_AFFINITY_DMG,      tpz.mod.EARTH_AFFINITY_DMG,     tpz.mod.THUNDER_AFFINITY_DMG,       tpz.mod.WATER_AFFINITY_DMG,      tpz.mod.LIGHT_AFFINITY_DMG,  tpz.mod.DARK_AFFINITY_DMG}
local strongAffinityAcc       = {tpz.mod.FIRE_AFFINITY_ACC,     tpz.mod.ICE_AFFINITY_ACC,     tpz.mod.WIND_AFFINITY_ACC,      tpz.mod.EARTH_AFFINITY_ACC,     tpz.mod.THUNDER_AFFINITY_ACC,       tpz.mod.WATER_AFFINITY_ACC,      tpz.mod.LIGHT_AFFINITY_ACC,  tpz.mod.DARK_AFFINITY_ACC}
tpz.magic.resistMod           = {tpz.mod.FIRERES,               tpz.mod.ICERES,               tpz.mod.WINDRES,                tpz.mod.EARTHRES,               tpz.mod.THUNDERRES,                 tpz.mod.WATERRES,                tpz.mod.LIGHTRES,            tpz.mod.DARKRES}
tpz.magic.defenseMod          = {tpz.mod.FIREDEF,               tpz.mod.ICEDEF,               tpz.mod.WINDDEF,                tpz.mod.EARTHDEF,               tpz.mod.THUNDERDEF,                 tpz.mod.WATERDEF,                tpz.mod.LIGHTDEF,            tpz.mod.DARKDEF}
tpz.magic.absorbMod           = {tpz.mod.FIRE_ABSORB,           tpz.mod.ICE_ABSORB,           tpz.mod.WIND_ABSORB,            tpz.mod.EARTH_ABSORB,           tpz.mod.LTNG_ABSORB,                tpz.mod.WATER_ABSORB,            tpz.mod.LIGHT_ABSORB,        tpz.mod.DARK_ABSORB}
local nullMod                 = {tpz.mod.FIRE_NULL,             tpz.mod.ICE_NULL,             tpz.mod.WIND_NULL,              tpz.mod.EARTH_NULL,             tpz.mod.LTNG_NULL,                  tpz.mod.WATER_NULL,              tpz.mod.LIGHT_NULL,          tpz.mod.DARK_NULL}
local blmMerit                = {tpz.merit.FIRE_MAGIC_POTENCY,  tpz.merit.ICE_MAGIC_POTENCY,  tpz.merit.WIND_MAGIC_POTENCY,   tpz.merit.EARTH_MAGIC_POTENCY,  tpz.merit.LIGHTNING_MAGIC_POTENCY,  tpz.merit.WATER_MAGIC_POTENCY}
local rdmMerit                = {tpz.merit.FIRE_MAGIC_ACCURACY, tpz.merit.ICE_MAGIC_ACCURACY, tpz.merit.WIND_MAGIC_ACCURACY,  tpz.merit.EARTH_MAGIC_ACCURACY, tpz.merit.LIGHTNING_MAGIC_ACCURACY, tpz.merit.WATER_MAGIC_ACCURACY}
tpz.magic.barSpell            = {tpz.effect.BARFIRE,            tpz.effect.BARBLIZZARD,       tpz.effect.BARAERO,             tpz.effect.BARSTONE,            tpz.effect.BARTHUNDER,              tpz.effect.BARWATER}

tpz.magic.dayWeak             = {tpz.day.WATERSDAY,             tpz.day.FIRESDAY,            tpz.day.ICEDAY,                  tpz.day.WINDSDAY,               tpz.day.EARTHSDAY,                  tpz.day.LIGHTNINGDAY,            tpz.day.DARKSDAY,            tpz.day.LIGHTSDAY           }
tpz.magic.singleWeatherWeak   = {tpz.weather.RAIN,              tpz.weather.HOT_SPELL,       tpz.weather.SNOW,                tpz.weather.WIND,               tpz.weather.DUST_STORM,             tpz.weather.THUNDER,             tpz.weather.GLOOM,           tpz.weather.AURORAS         }
tpz.magic.doubleWeatherWeak   = {tpz.weather.SQUALL,            tpz.weather.HEAT_WAVE,       tpz.weather.BLIZZARDS,           tpz.weather.GALES,              tpz.weather.SAND_STORM,             tpz.weather.THUNDERSTORMS,       tpz.weather.DARKNESS,        tpz.weather.STELLAR_GLARE   }

-- USED FOR DAMAGING MAGICAL SPELLS (Stages 1 and 2 in Calculating Magic Damage on wiki)
--Calculates magic damage using the standard magic damage calc.
--Does NOT handle resistance.
-- Inputs:
-- dmg - The base damage of the spell
-- multiplier - The INT multiplier of the spell
-- skilltype - The skill ID of the spell.
-- atttype - The attribute type (usually tpz.mod.INT , except for things like Banish which is tpz.mod.MND)
-- hasMultipleTargetReduction - true ifdamage is reduced on AoE. False otherwise (e.g. Charged Whisker vs -ga3 spells)
--
-- Output:
-- The total damage, before resistance and before equipment (so no HQ staff bonus worked out here).
local SOFT_CAP = 60 --guesstimated
local HARD_CAP = 120 --guesstimated

function calculateMagicDamage(caster, target, spell, params)

    local dINT = caster:getStat(params.attribute) - target:getStat(params.attribute)
    local dmg = params.dmg

    if dINT <= 0 then --if dINT penalises, it's always M=1
        dmg = dmg + dINT
        if dmg <= 0 then return 0 end
    elseif dINT > 0 and dINT <= SOFT_CAP then --The standard calc, most spells hit this
        dmg = dmg + dINT * params.multiplier
    elseif dINT > 0 and dINT > SOFT_CAP and dINT < HARD_CAP then --After SOFT_CAP, INT is only half effective
        dmg = dmg + SOFT_CAP * params.multiplier + ((dINT - SOFT_CAP) * params.multiplier) / 2
    elseif dINT > 0 and dINT > SOFT_CAP and dINT >= HARD_CAP then --After HARD_CAP, INT has no tpz.effect.
        dmg = dmg + HARD_CAP * params.multiplier
    end


    if params.skillType == tpz.skill.DIVINE_MAGIC and target:isUndead() then
        dmg = dmg * 1.5
    end

    -- printf("dmg: %d dINT: %d\n", dmg, dINT)

    return dmg

end

function doBoostGain(caster, target, spell, effect)
    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    --calculate potency
    local magicskill = target:getSkillLevel(spell:getSkillType())

    local potency = math.floor((magicskill - 300) / 10) + 5

    if potency > 25 then
        potency = 25
    elseif potency < 5 then
        potency = 5
    end

    --printf("BOOST-GAIN: POTENCY = %d", potency)

    --Only one Boost Effect can be active at once, so if the player has any we have to cancel & overwrite
    local effectOverwrite =
    {
        tpz.effect.STR_BOOST,
        tpz.effect.DEX_BOOST,
        tpz.effect.VIT_BOOST,
        tpz.effect.AGI_BOOST,
        tpz.effect.INT_BOOST,
        tpz.effect.MND_BOOST,
        tpz.effect.CHR_BOOST
    }

    for i, effect in ipairs(effectOverwrite) do
            --printf("BOOST-GAIN: CHECKING FOR EFFECT %d...", effect)
            if caster:hasStatusEffect(effect) then
                --printf("BOOST-GAIN: HAS EFFECT %d, DELETING...", effect)
                caster:delStatusEffect(effect)
            end
    end

    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end
end

function doEnspell(caster, target, spell, effect)
    -- Calculate Bonus duration
    local baseDuration = 0
    if caster:getEquipID(tpz.slot.MAIN) == 17696 then
        baseDuration = 210
    else
        baseDuration = 180
    end

    local duration = calculateDuration(baseDuration, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    --calculate potency
    local magicskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC)
    -- Add effect bonuses from equipment
    local potencybonus = 0
    if caster:getEquipID(tpz.slot.MAIN) == 17696 then -- Buzzard Tusk
        potencybonus = 2 + potencybonus
    elseif caster:getEquipID(tpz.slot.EAR1) == 16011 or caster:getEquipID(tpz.slot.EAR2) == 16011 then -- Lycopodium Earring
        potencybonus = 2 + potencybonus
    elseif caster:getEquipID(tpz.slot.EAR1) == 15964 or caster:getEquipID(tpz.slot.EAR2) == 15964 then -- Hollow Earring
        potencybonus = 3 + potencybonus
    elseif(caster:getHPP() <= 75 and caster:getTP() <= 100) and (caster:getEquipID(tpz.slot.RING1) == 13290 or caster:getEquipID(tpz.slot.RING2) == 13290) then -- Fencer's Ring
        potencybonus = 5 + potencybonus
    elseif caster:getEquipID(tpz.slot.MAIN) == 17696 then -- Enhancing Sword
        potencybonus = 5 + potencybonus
    end

    -- Potency with Effect Bonus
    local potency = 0
    if (caster:getWeaponSkillType(tpz.slot.MAIN) == tpz.skill.SWORD or caster:getWeaponSkillType(tpz.slot.SUB) == tpz.skill.SWORD) then
        if magicskill <= 200 then
            potency = 3 + potencybonus + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + potencybonus + math.floor(5 * magicskill / 100)
        end
    -- Potency without Effect Bonus
    else
        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end
    end
    
    if target:addStatusEffect(effect, potency, 0, duration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end
end

---------------------------------
--   getCurePower returns the caster's cure power
--   getCureFinal returns the final cure amount
--   Source: http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
---------------------------------
function getCurePower(caster, isBlueMagic)
    local MND = caster:getStat(tpz.mod.MND)
    local VIT = caster:getStat(tpz.mod.VIT)
    local skill = caster:getSkillLevel(tpz.skill.HEALING_MAGIC)
    local power = math.floor(MND/2) + math.floor(VIT/4) + skill
    return power
end
function getCurePowerOld(caster)
    local MND = caster:getStat(tpz.mod.MND)
    local VIT = caster:getStat(tpz.mod.VIT)
    local skill = caster:getSkillLevel(tpz.skill.HEALING_MAGIC) -- it's healing magic skill for the BLU cures as well
    local power = (3 * MND) + VIT + (3 * math.floor(skill/5))
    return power
end
function getBaseCure(power, divisor, constant, basepower)
    return ((power - basepower) / divisor) + constant
end
function getBaseCureOld(power, divisor, constant)
    return (power / 2) / divisor + constant
end

function getCureFinal(caster, spell, basecure, minCure, isBlueMagic)
    if basecure < minCure then
        basecure = minCure
    end

    local curePot = math.min(caster:getMod(tpz.mod.CURE_POTENCY), 50) / 100 -- caps at 50%
    local curePotII = math.min(caster:getMod(tpz.mod.CURE_POTENCY_II), 30) / 100 -- caps at 30%
    local potency = 1 + curePot + curePotII

    local dSeal = 1
    if caster:hasStatusEffect(tpz.effect.DIVINE_SEAL) then
        dSeal = 2
    end

    local rapture = 1
    if isBlueMagic == false then --rapture doesn't affect BLU cures as they're not white magic
        if caster:hasStatusEffect(tpz.effect.RAPTURE) then
            rapture = 1.5 + caster:getMod(tpz.mod.RAPTURE_AMOUNT)/100
            caster:delStatusEffectSilent(tpz.effect.RAPTURE)
        end
    end

    local dayWeatherBonus = 1
    local ele = spell:getElement()

    local castersWeather = caster:getWeather()

    if castersWeather == tpz.magic.singleWeatherStrong[ele] then
        if caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif castersWeather == tpz.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif castersWeather == tpz.magic.doubleWeatherStrong[ele] then
        if caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif castersWeather == tpz.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif (dayElement == tpz.magic.elementDescendant[ele]) then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then dayWeatherBonus = 1.4 end

    local final = math.floor(math.floor(math.floor(math.floor(basecure) * potency) * dayWeatherBonus) * rapture) * dSeal
    return final
end

function getCureAsNukeFinal(caster, spell, power, divisor, constant, basepower)
    return getCureFinal(caster, spell, power, divisor, constant, basepower)
end

function isValidHealTarget(caster, target)
    return target:getAllegiance() == caster:getAllegiance() and
            (target:getObjType() == tpz.objType.PC or
            target:getObjType() == tpz.objType.MOB or
            target:getObjType() == tpz.objType.TRUST or
            target:getObjType() == tpz.objType.FELLOW)
end

-----------------------------------
-- Returns the staff bonus for the caster and spell.
-----------------------------------

-- affinities that strengthen/weaken the index element


function AffinityBonusDmg(caster, ele)

    local affinity = caster:getMod(strongAffinityDmg[ele])
    local bonus = 1.00 + affinity * 0.05 -- 5% per level of affinity
    -- print(bonus)
    return bonus
end

function AffinityBonusAcc(caster, ele)

    local affinity = caster:getMod(strongAffinityAcc[ele])
    local bonus = 0 + affinity * 10 -- 10 acc per level of affinity
    -- print(bonus)
    return bonus
end

-- USED FOR DAMAGING MAGICAL SPELLS. Stage 3 of Calculating Magic Damage on wiki
-- Reduces damage ifit resists.
--
-- Output:
-- The factor to multiply down damage (1/2 1/4 1/8 1/16) - In this format so this func can be used for enfeebs on duration.

function applyResistance(caster, target, spell, params)
    return applyResistanceEffect(caster, target, spell, params)
end

-- USED FOR Status Effect Enfeebs (blind, slow, para, etc.)
-- Output:
-- The factor to multiply down duration (1/2 1/4 1/8 1/16)
--[[
local params = {}
params.attribute = $2
params.skillType = $3
params.bonus = $4
params.effect = $5
]]
function applyResistanceEffect(caster, target, spell, params) -- says "effect" but this is the global resistance fetching formula, even for damage spells
    local effect = params.effect
    if effect ~= nil and math.random() < getEffectResistanceTraitChance(caster, target, effect) then
        return 1/16 -- this will make any status effect fail. this takes into account trait+food+gear
        --print("restrait proc!")
        --TODO return 2 values resist + traitProc bool? so we can use the setMsg completely resist
        --if spell ~= nil then
            --spell:setMsg(MAGIC_COMPLETELY_RESIST)
            --if spell:isAoe() == 1 then
                --spell:setMsg(MAGIC_COMPLETELY_RESIST_AOE)
            --end
        --end
    end

    local diff = params.diff or (caster:getStat(params.attribute) - target:getStat(params.attribute))
    local skill = params.skillType
    local bonus = params.bonus

    local element = spell:getElement()
    local percentBonus = 0
    local magicaccbonus = getSpellBonusAcc(caster, target, spell, params)
    
    local softcap = params.dStatAccSoftCap -- 10 is set on all nukes. everything else is nil
    if softcap == nil then
        softcap = 15
    end

    if diff > softcap then -- past the soft cap (10 or 15) each dstat is half as effective
        magicaccbonus = magicaccbonus + softcap + math.floor((diff - softcap)/2)
    else
        magicaccbonus = magicaccbonus + diff
    end

    if bonus ~= nil then
        magicaccbonus = magicaccbonus + bonus
    end

    if effect ~= nil then
        percentBonus = percentBonus - getEffectResistance(target, effect) -- this is a HITRATE penalty not a MEVA BOOST (but they are the same thing if macc > meva)
    end
    
    if params.skillBonus ~= nil then -- bard only it seems like. takes into account signing+instrument skill (at least, it should)
        magicaccbonus = magicaccbonus + params.skillBonus
    end

    local p = getMagicHitRate(caster, target, skill, element, percentBonus, magicaccbonus)
    local res = getMagicResist(p)
    
    if getElementalSDT(element, target) == 5 then -- jimmayus: SDT tier .05 makes you lose ALL coin flips
        res = 1/8
    end
    
    if getElementalSDT(element, target) <= 50 then -- .5 or below SDT drops a resist tier
        res = res / 2
    end
    
    if target:isPC() and element ~= nil and element > 0 and element < 9 then
        -- shiyo's research https://discord.com/channels/799050462539284533/799051759544434698/827052905151332354 (Project Wings Discord)
        local eleres = target:getMod(element+53)
        if     eleres < 0  and res < 0.5  then res = 0.5
        elseif eleres < 10 and res < 0.25 then res = 0.25 end
    end
    --print(string.format("res was %f",res))
    return res
end

-- Applies resistance for things that may not be spells - ie. Quick Draw
function applyResistanceAbility(player, target, element, skill, bonus)
    local p = getMagicHitRate(player, target, skill, element, 0, bonus)

    return getMagicResist(p)
end

-- Applies resistance for additional effects
function applyResistanceAddEffect(player, target, element, bonus)

    local p = getMagicHitRate(player, target, 0, element, 0, bonus)
    local res = getMagicResist(p)
    
    if target:isPC() and element ~= nil and element > 0 and element < 9 then
        -- shiyo's research https://discord.com/channels/799050462539284533/799051759544434698/827052905151332354 (Project Wings Discord)
        local eleres = target:getMod(element+53)
        if     eleres < 0  and res < 0.5  then res = 0.5
        elseif eleres < 10 and res < 0.25 then res = 0.25 end
    end
    
    return res
end

function getMagicHitRate(caster, target, skillType, element, percentBonus, bonusAcc)
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0) then return 0 end
    if bonusAcc == nil then bonusAcc = 0 end
    local magiceva = 0
    
    local magicacc = caster:getMod(tpz.mod.MACC) + caster:getILvlMacc()

    -- Get the base acc (just skill + skill mod (79 + skillID = ModID) + magic acc mod)
    if skillType ~= 0 then
        local skillBonus = 0
        local skillAmount = caster:getSkillLevel(skillType)
        
        if skillAmount > 200 then
            skillBonus = 200 + (skillAmount - 200)*0.9
        else
            skillBonus = skillAmount
        end
        
        magicacc = magicacc + skillBonus
    else
        magicacc = magicacc + utils.getSkillLvl(1, caster:getMainLvl()) -- for mob skills / additional effects which don't have a skill
    end

    local resMod = 0 -- Some spells may possibly be non elemental, but have status effects.
    if element ~= tpz.magic.ele.NONE then
        resMod = target:getMod(tpz.magic.resistMod[element])

        -- Add acc for elemental affinity accuracy and element specific accuracy
        local affinityBonus = AffinityBonusAcc(caster, element)
        local elementBonus = caster:getMod(spellAcc[element])
        -- print(elementBonus)
        bonusAcc = bonusAcc + affinityBonus + elementBonus
    end

    magicacc = magicacc + caster:getMerit(tpz.merit.MAGIC_ACCURACY)

    magicacc = magicacc + caster:getMerit(tpz.merit.NIN_MAGIC_ACCURACY)

    -- Base magic evasion (base magic evasion plus resistances(players), plus elemental defense(mobs)
    -- target:getMod(MEVA) is set to a capped skill of rank C when the mob spawns
    local magiceva = target:getMod(tpz.mod.MEVA) + resMod

    magicacc = magicacc + bonusAcc

    -- Add macc% from food
    local maccFood = magicacc * (caster:getMod(tpz.mod.FOOD_MACCP)/100)
    magicacc = magicacc + utils.clamp(maccFood, 0, caster:getMod(tpz.mod.FOOD_MACC_CAP))
    
    local SDT = getElementalSDT(element, target)

    return calculateMagicHitRate(magicacc, magiceva, percentBonus, caster:getMainLvl(), target:getMainLvl(), SDT)
end

function calculateMagicHitRate(magicacc, magiceva, percentBonus, casterLvl, targetLvl, SDT)
    local p = 0
    
    -- percentBonus is a bit deceiving of a name. it's either 0 or a negative number. its only application is specific effect resistance (i.e. +5 resist to paralyze = -5% hitrate on incoming paras)
    -- note that this has nothing to do with the resist TRAIT which is handled BEFORE rate calculations. gear bonuses (i.e. "Enhances Resist Paralyze Effect") count as traits.
    -- If dMAcc < 0, Magic Hit Rate = 70% + floor( dMAcc÷2 ) = magic hit rate
    -- If dMAcc ≥ 0, Magic Hit Rate = 70% + dMAcc = magic hit rate
    
    --magicacc = magicacc + (casterLvl - targetLvl)*4
    magicacc = magicacc + utils.clamp(casterLvl - targetLvl, -10, 5)*3
    local dMAcc = magicacc - magiceva
    --print(string.format("magicacc = %u, magiceva = %u",magicacc,magiceva))
    if dMAcc < 0 then -- when penalty, half effective
        p = 70 + math.floor(dMAcc/2)
    else
        p = 70 + dMAcc
    end
    
    p = p + percentBonus
	--GetPlayerByID(1):PrintToPlayer(string.format("magic hit rate pre SDT: %u",p))
    p = p * SDT/100
	--GetPlayerByID(1):PrintToPlayer(string.format("magic hit rate post SDT: %u",p))
    return utils.clamp(p, 5, 95)
end

-- Returns resistance value from given magic hit rate (p)
function getMagicResist(magicHitRate)

    local p = magicHitRate / 100
    local resist = 1

    -- Resistance thresholds based on p.  A higher p leads to lower resist rates, and a lower p leads to higher resist rates.
    local half = (1 - p)
    local quart = ((1 - p)^2)
    local eighth = ((1 - p)^3)
    -- print("HALF: "..half)
    -- print("QUART: "..quart)
    -- print("EIGHTH: "..eighth)
    -- print("SIXTEENTH: "..sixteenth)

    local resvar = math.random()

    -- sixteenth section removed as it is not obtainable under normal circumstances... requires getting a 1/8th roll reduced by half via a 50% or lower SDT tier
    if resvar <= eighth then
        resist = 0.125
        --printf("Spell resisted to 1/8!  Threshold = %u",eighth)
    elseif resvar <= quart then
        resist = 0.25
        --printf("Spell resisted to 1/4.  Threshold = %u",quart)
    elseif resvar <= half then
        resist = 0.5
        --printf("Spell resisted to 1/2.  Threshold = %u",half)
    else
        resist = 1.0
        --printf("1.0")
    end

    return resist
end

function getEffectResistanceTraitChance(caster, target, effect)
    local effectres = 0
    if effect == tpz.effect.SLEEP_I or effect == tpz.effect.SLEEP_II or effect == tpz.effect.LULLABY then
        effectres = tpz.mod.SLEEPRESTRAIT
    elseif effect == tpz.effect.POISON then
        effectres = tpz.mod.POISONRESTRAIT
    elseif effect == tpz.effect.PARALYSIS then
        effectres = tpz.mod.PARALYZERESTRAIT
    elseif effect == tpz.effect.BLINDNESS then
        effectres = tpz.mod.BLINDRESTRAIT
    elseif effect == tpz.effect.SILENCE then
        effectres = tpz.mod.SILENCERESTRAIT
    elseif effect == tpz.effect.PLAGUE or effect == tpz.effect.DISEASE then
        effectres = tpz.mod.VIRUSRESTRAIT
    elseif effect == tpz.effect.PETRIFICATION then
        effectres = tpz.mod.PETRIFYRESTRAIT
    elseif effect == tpz.effect.BIND then
        effectres = tpz.mod.BINDRESTRAIT
    elseif effect == tpz.effect.CURSE_I or effect == tpz.effect.CURSE_II or effect == tpz.effect.BANE then
        effectres = tpz.mod.CURSERESTRAIT
    elseif effect == tpz.effect.WEIGHT then
        effectres = tpz.mod.GRAVITYRESTRAIT
    elseif effect == tpz.effect.SLOW or effect == tpz.effect.ELEGY then
        effectres = tpz.mod.SLOWRESTRAIT
    elseif effect == tpz.effect.STUN then
        effectres = tpz.mod.STUNRESTRAIT
    elseif effect == tpz.effect.CHARM then
        effectres = tpz.mod.CHARMRESTRAIT
    elseif effect == tpz.effect.AMNESIA then
        effectres = tpz.mod.AMNESIARESTRAIT
    end
    
    if effectres ~= 0 then
        local ret = target:getMod(effectres)
        if not caster:isPC() and caster:isNM() then
            ret = math.floor(ret/2)
        end
        return ret/100
    end

    return 0
    
end

-- Returns the amount of resistance the
-- target has to the given effect (stun, sleep, etc..)
function getEffectResistance(target, effect)
    local effectres = 0
    local statusres = target:getMod(tpz.mod.STATUSRES)
    if effect == tpz.effect.SLEEP_I or effect == tpz.effect.SLEEP_II then
        effectres = tpz.mod.SLEEPRES
    elseif effect == tpz.effect.LULLABY then
        effectres = tpz.mod.LULLABYRES
    elseif effect == tpz.effect.POISON then
        effectres = tpz.mod.POISONRES
    elseif effect == tpz.effect.PARALYSIS then
        effectres = tpz.mod.PARALYZERES
    elseif effect == tpz.effect.BLINDNESS then
        effectres = tpz.mod.BLINDRES
    elseif effect == tpz.effect.SILENCE then
        effectres = tpz.mod.SILENCERES
    elseif effect == tpz.effect.PLAGUE or effect == tpz.effect.DISEASE then
        effectres = tpz.mod.VIRUSRES
    elseif effect == tpz.effect.PETRIFICATION then
        effectres = tpz.mod.PETRIFYRES
    elseif effect == tpz.effect.BIND then
        effectres = tpz.mod.BINDRES
    elseif effect == tpz.effect.CURSE_I or effect == tpz.effect.CURSE_II or effect == tpz.effect.BANE then
        effectres = tpz.mod.CURSERES
    elseif effect == tpz.effect.WEIGHT then
        effectres = tpz.mod.GRAVITYRES
    elseif effect == tpz.effect.SLOW or effect == tpz.effect.ELEGY then
        effectres = tpz.mod.SLOWRES
    elseif effect == tpz.effect.STUN then
        effectres = tpz.mod.STUNRES
    elseif effect == tpz.effect.CHARM then
        effectres = tpz.mod.CHARMRES
    elseif effect == tpz.effect.AMNESIA then
        effectres = tpz.mod.AMNESIARES
    end

    if effectres ~= 0 then
        return target:getMod(effectres) + statusres
    end

    return statusres
end

-- Returns the bonus magic accuracy for any spell
function getSpellBonusAcc(caster, target, spell, params)
    local magicAccBonus = 0
    local castersWeather = caster:getWeather()
    local skill = spell:getSkillType()
    local spellGroup = spell:getSpellGroup()
    local element = spell:getElement()

    if caster:hasStatusEffect(tpz.effect.ALTRUISM) and spellGroup == tpz.magic.spellGroup.WHITE then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(tpz.effect.ALTRUISM):getPower()
    end

    if caster:hasStatusEffect(tpz.effect.FOCALIZATION) and spellGroup == tpz.magic.spellGroup.BLACK then
        magicAccBonus = magicAccBonus + caster:getStatusEffect(tpz.effect.FOCALIZATION):getPower()
    end

    local skillchainTier, skillchainCount = FormMagicBurst(element, target)

    --add acc for skillchains
    if skillchainTier > 0 then
        magicAccBonus = magicAccBonus + 30 -- jimmayus said this is 30 not 25
    end

    --Add acc for klimaform
    if element > 0 and caster:hasStatusEffect(tpz.effect.KLIMAFORM) and (castersWeather == tpz.magic.singleWeatherStrong[element] or castersWeather == tpz.magic.doubleWeatherStrong[element]) then
        magicAccBonus = magicAccBonus + 15
    end

    --Add acc for dark seal
    if skill == tpz.skill.DARK_MAGIC and caster:hasStatusEffect(tpz.effect.DARK_SEAL) then
        magicAccBonus = magicAccBonus + 75
    end

    -- Add acc for elemental seal
    if caster:hasStatusEffect(tpz.effect.ELEMENTAL_SEAL) then
        magicAccBonus = magicAccBonus + 75
    end

    --add acc for RDM group 1 merits
    -- each merit should add +3 magic accuracy per upgrade
    -- gating to be only effective for main job RDM
    if caster:getMainJob() == tpz.job.RDM then
        if element >= tpz.magic.element.FIRE and element <= tpz.magic.element.WATER then
            magicAccBonus = magicAccBonus + caster:getMerit(rdmMerit[element])
        end
    end

    --add acc for RDM group 2 merits
    if spell == tpz.magic.spell.PARALYZE_II then
        magicAccBonus = magicAccBonus + (2 * caster:getMerit(tpz.merit.PARALYZE_II))
    end

    if spell == tpz.magic.spell.SLOW_II then
        magicAccBonus = magicAccBonus + (2 * caster:getMerit(tpz.merit.SLOW_II))
    end

    if spell == tpz.magic.spell.BLIND_II then
        magicAccBonus = magicAccBonus + (2 *caster:getMerit(tpz.merit.BLIND_II))
    end

    return magicAccBonus
end

function handleAfflatusMisery(caster, spell, dmg)
    if caster:hasStatusEffect(tpz.effect.AFFLATUS_MISERY) then
        local misery = caster:getMod(tpz.mod.AFFLATUS_MISERY)
        local miseryMax = 300 -- BGWiki Caps at 300 magic damage.
        
        if misery > miseryMax then misery = miseryMax end

        local boost = 1 + misery / miseryMax -- linear boost range 1x~2x
        dmg = math.floor(dmg * boost)
        -- printf("AFFLATUS MISERY: Damage boosted by %f to %d", boost, dmg)

        caster:setMod(tpz.mod.AFFLATUS_MISERY, 0)
    end
    return dmg
end

 function finalMagicAdjustments(caster, target, spell, dmg)
    --Handles target's HP adjustment and returns UNSIGNED dmg (absorb message is set in this function)
    
    local skill = spell:getSkillType()
    if skill == tpz.skill.ELEMENTAL_MAGIC then
        dmg = dmg * ELEMENTAL_POWER
    elseif skill == tpz.skill.DARK_MAGIC then
        dmg = dmg * DARK_POWER
        local id = spell:getID()
        if id == 245 or id == 246 or id == 247 or id == 248 then
            dmg = math.floor(dmg * (math.random()/2 + 0.5)) -- aspir1/2, drain1/2, wiki notes this is how it is randomized but i can't find the source atm
        end
    elseif skill == tpz.skill.NINJUTSU then
        dmg = dmg * NINJUTSU_POWER
    elseif skill == tpz.skill.DIVINE_MAGIC then
        dmg = dmg * DIVINE_POWER
    end
    
    -- Circle Effects
    if target:isMob() and dmg > 0 then
        local eco = target:getSystem()
        local circlemult = 100
        local mod = 0
        
        if     eco == 1  then mod = 1226
        elseif eco == 2  then mod = 1228
        elseif eco == 3  then mod = 1232
        elseif eco == 6  then mod = 1230
        elseif eco == 8  then mod = 1225
        elseif eco == 9  then mod = 1234
        elseif eco == 10 then mod = 1233
        elseif eco == 14 then mod = 1227
        elseif eco == 16 then mod = 1238
        elseif eco == 15 then mod = 1237
        elseif eco == 17 then mod = 1229
        elseif eco == 19 then mod = 1231
        elseif eco == 20 then mod = 1224
        end
        
        if mod > 0 then circlemult = 100 + caster:getMod(mod) end
        
        dmg = math.floor(dmg * circlemult / 100)
    end

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(tpz.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end
    
    local ramSS = target:getMod(tpz.mod.RAMPART_STONESKIN)
    if ramSS > 0 then
        if dmg >= ramSS then
            target:setMod(tpz.mod.RAMPART_STONESKIN, 0)
            dmg = dmg - ramSS
        else
            target:setMod(tpz.mod.RAMPART_STONESKIN, ramSS - dmg)
            dmg = 0
        end
    end
    
    dmg = utils.stoneskin(target, dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    if dmg < 0 then
        dmg = target:addHP(-dmg)
        spell:setMsg(tpz.msg.basic.MAGIC_RECOVERS_HP)
    else
        target:takeDamage(dmg, caster, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL + spell:getElement())
        target:handleAfflatusMiseryDamage(dmg)
        target:updateEnmityFromDamage(caster, dmg)
        if dmg > 0 then target:addTPFromSpell(caster) end
    end

    if (caster:hasStatusEffect(tpz.effect.SOLDIERS_DRINK)) then
        dmg = dmg * 1.5
        caster:delStatusEffectSilent(tpz.effect.SOLDIERS_DRINK)
    end

    return dmg
 end

function finalMagicNonSpellAdjustments(caster, target, ele, dmg)
    --Handles target's HP adjustment and returns SIGNED dmg (negative values on absorb)

    dmg = target:magicDmgTaken(dmg)

    if dmg > 0 then
        dmg = dmg - target:getMod(tpz.mod.PHALANX)
        dmg = utils.clamp(dmg, 0, 99999)
    end
    
    local ramSS = target:getMod(tpz.mod.RAMPART_STONESKIN)
    if ramSS > 0 then
        if dmg >= ramSS then
            target:setMod(tpz.mod.RAMPART_STONESKIN, 0)
            dmg = dmg - ramSS
        else
            target:setMod(tpz.mod.RAMPART_STONESKIN, ramSS - dmg)
            dmg = 0
        end
    end

    dmg = utils.stoneskin(target, dmg)
    dmg = utils.clamp(dmg, -99999, 99999)

    if dmg < 0 then
        dmg = -(target:addHP(-dmg))
    else
        target:takeDamage(dmg, caster, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL + ele)
    end
    -- Not updating enmity from damage, as this is primarily used for additional effects (which don't generate emnity)
    -- in the case that updating enmity is needed, do it manually after calling this
    -- target:updateEnmityFromDamage(caster, dmg)

    return dmg
end

function adjustForTarget(target, dmg, ele)
    if dmg > 0 and math.random(0, 99) < target:getMod(tpz.magic.absorbMod[ele]) then return -dmg end
    if math.random(0, 99) < target:getMod(nullMod[ele]) then return 0 end
    --Moved non element specific absorb and null mod checks to core
    --TODO: update all lua calls to magicDmgTaken with appropriate element and remove this function
    return dmg
end

function calculateMagicBurst(caster, spell, target, params)

    local burst = 1.0
    local skillchainburst = 1.0
    local modburst = 1.0

    if spell:getSpellGroup() == 3 and not caster:hasStatusEffect(tpz.effect.BURST_AFFINITY) then return 1 end

    -- Obtain first multiplier from gear, atma and job traits
    modburst = modburst + (caster:getMod(tpz.mod.MAG_BURST_BONUS) / 100) + params.AMIIburstBonus

    if caster:isBehind(target) and caster:hasStatusEffect(tpz.effect.INNIN) then
        modburst = modburst + (caster:getMerit(tpz.merit.INNIN_EFFECT)/100)
    end

    -- Cap bonuses from first multiplier at 40% or 1.4
    if modburst > 1.4 then
        modburst = 1.4
    end

    -- Obtain second multiplier from skillchain
    -- Starts at 35% damage bonus, increases by 10% for every additional weaponskill in the chain
    local skillchainTier, skillchainCount = FormMagicBurst(spell:getElement(), target)

    if skillchainTier > 0 then
        if skillchainCount == 1 then -- two weaponskills
            skillchainburst = 1.35
        elseif skillchainCount == 2 then -- three weaponskills
            skillchainburst = 1.45
        elseif skillchainCount == 3 then -- four weaponskills
             skillchainburst = 1.55
        elseif skillchainCount == 4 then -- five weaponskills
            skillchainburst = 1.65
        elseif skillchainCount == 5 then -- six weaponskills
            skillchainburst = 1.75
        elseif skillchainCount == 6 then -- seven weaponskills
            skillchainburst = 1.85
        else
            skillchainburst = 1.85 -- eight or more? shouldn't be possible
        end
    end

    if skillchainburst > 1 then burst = modburst * skillchainburst end

    return burst
end

function addBonuses(caster, spell, target, dmg, params)
    params = params or {}

    local ele = spell:getElement()

    local affinityBonus = AffinityBonusDmg(caster, ele)
    if params.attackType ~= tpz.attackType.BREATH then dmg = math.floor(dmg * affinityBonus) end -- BLU breaths unaffected by staff

    params.bonusmab = params.bonusmab or 0
    params.AMIIburstBonus = params.AMIIburstBonus or 0

    local magicDefense = getElementalDamageReduction(target, ele) -- special defense
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()

    if weather == tpz.magic.singleWeatherStrong[ele] then
        if caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == tpz.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif weather == tpz.magic.doubleWeatherStrong[ele] then
        if caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
                dayWeatherBonus = dayWeatherBonus + 0.10
            end
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif weather == tpz.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        dayWeatherBonus = dayWeatherBonus + caster:getMod(tpz.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == tpz.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 or isHelixSpell(spell) then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    local burst = calculateMagicBurst(caster, spell, target, params)

    if burst > 1.0 then
        spell:setMsg(spell:getMagicBurstMessage()) -- "Magic Burst!"
    end

    dmg = math.floor(dmg * burst)
    local mabbonus = 0
    local spellId = spell:getID()

    if spellId >= 245 and spellId <= 248 then -- Drain/Aspir (II)
        mabbonus = 1 + caster:getMod(tpz.mod.ENH_DRAIN_ASPIR)/100
    else
        local mab = caster:getMod(tpz.mod.MATT) + params.bonusmab

        if spell:getSkillType() == tpz.skill.NINJUTSU then
            mab = mab + caster:getMerit(tpz.merit.NIN_MAGIC_BONUS)
        end

        local mab_crit = caster:getMod(tpz.mod.MAGIC_CRITHITRATE)
        if math.random(1, 100) < mab_crit then
           mab = mab + ( 10 + caster:getMod(tpz.mod.MAGIC_CRIT_DMG_INCREASE ) )
        end

        local mdefBarBonus = 0
        if ele >= tpz.magic.element.FIRE and ele <= tpz.magic.element.WATER then
            mab = mab + caster:getMerit(blmMerit[ele])
            if target:hasStatusEffect(tpz.magic.barSpell[ele]) then -- bar- spell magic defense bonus
                mdefBarBonus = target:getStatusEffect(tpz.magic.barSpell[ele]):getSubPower()
            end
        end
        if params.attackType == tpz.attackType.BREATH then mab = params.bonusmab end -- BLU breaths only affected by correlation bonuses
        mabbonus = (100 + mab) / (100 + target:getMod(tpz.mod.MDEF) + mdefBarBonus)
    end

    if mabbonus < 0 then mabbonus = 0 end

    dmg = math.floor(dmg * mabbonus)

    if caster:hasStatusEffect(tpz.effect.EBULLIENCE) then
        dmg = dmg * (1.2 + caster:getMod(tpz.mod.EBULLIENCE_AMOUNT)/100)
        caster:delStatusEffectSilent(tpz.effect.EBULLIENCE)
    end

    dmg = math.floor(dmg)

    return dmg
end

function addBonusesAbility(caster, ele, target, dmg, params)

    local affinityBonus = AffinityBonusDmg(caster, ele)
    dmg = math.floor(dmg * affinityBonus)

    local magicDefense = getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = 1.00
    local weather = caster:getWeather()

    if weather == tpz.magic.singleWeatherStrong[ele] then
        if (math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1) and caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == tpz.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif weather == tpz.magic.doubleWeatherStrong[ele] then
        if (math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1) and caster:getMod(tpz.mod.IRIDESCENCE) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif weather == tpz.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    local dayElement = VanadielDayElement()
    if dayElement == ele then
        dayWeatherBonus = dayWeatherBonus + caster:getMod(tpz.mod.DAY_NUKE_BONUS)/100 -- sorc. tonban(+1)/zodiac ring
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif dayElement == tpz.magic.elementDescendant[ele] then
        if math.random() < 0.33 or caster:getMod(elementalObi[ele]) >= 1 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.4 then
        dayWeatherBonus = 1.4
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    local mab = 1
    local mdefBarBonus = 0
    if ele >= tpz.magic.element.FIRE and ele <= tpz.magic.element.WATER and target:hasStatusEffect(tpz.magic.barSpell[ele]) then
        mdefBarBonus = target:getStatusEffect(tpz.magic.barSpell[ele]):getSubPower()
    end

    if params ~= nil and params.bonusmab ~= nil and params.includemab == true then
        mab = (100 + caster:getMod(tpz.mod.MATT) + params.bonusmab) / (100 + target:getMod(tpz.mod.MDEF) + mdefBarBonus)
    elseif params == nil or (params ~= nil and params.includemab == true) then
        mab = (100 + caster:getMod(tpz.mod.MATT)) / (100 + target:getMod(tpz.mod.MDEF) + mdefBarBonus)
    end

    if mab < 0 then mab = 0 end

    dmg = math.floor(dmg * mab)

    return dmg
end

-- get elemental damage reduction
function getElementalDamageReduction(target, element)
    local defense = 1
    if element > 0 then
        defense = 1 - (target:getMod(tpz.magic.defenseMod[element]) / 256)

        return utils.clamp(defense, 0.0, 2.0)
    end

    return defense
end

---------------------------------------------
--  Elemental Debuff Potency functions
---------------------------------------------

function getElementalDebuffDOT(INT)
    local DOT = 0
    
    if     INT <=  39 then DOT = 1
    elseif INT <=  69 then DOT = 2
    elseif INT <=  99 then DOT = 3
    elseif INT <= 149 then DOT = 4
    else                   DOT = 5
    end
    
    return DOT
end

function getElementalDebuffStatDownFromDOT(dot)
    return (dot-1)*2 +5
end

function getHelixDuration(caster)
    --Dark Arts will further increase Helix duration, but testing is ongoing.

    local casterLevel = caster:getMainLvl()
    local duration = 30
    
    if     casterLevel < 40 then duration = 30
    elseif casterLevel < 60 then duration = 60
    else                         duration = 90
    end
    
    return duration
end

function isHelixSpell(spell)

    local id = spell:getID()
    if id >= 278 and id <= 285 then return true end
    return false
end

function handleThrenody(caster, target, spell, basePower, baseDuration, modifier)
    -- Process resitances
    local staff = AffinityBonusAcc(caster, spell:getElement())
    -- print("staff=" .. staff)
    local dCHR = (caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR))
    -- print("dCHR=" .. dCHR)
    local params = {}
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = staff
    params.skillBonus = 0
    if caster:isPC() then
        local sLvl = caster:getSkillLevel(tpz.skill.SINGING) -- Gets skill level of Singing
        local iLvl = caster:getWeaponSkillLevel(tpz.slot.RANGED)
        local skillcap = caster:getMaxSkillLevel(caster:getMainLvl(), tpz.job.BRD, tpz.skill.STRING_INSTRUMENT) -- will return the same whether string or wind, both are C for bard
        
        local rangedType = caster:getWeaponSkillType(tpz.slot.RANGED)
        if rangedType ~= tpz.skill.STRING_INSTRUMENT and rangedType ~= tpz.skill.WIND_INSTRUMENT then iLvl = sLvl end
        
        if sLvl + iLvl > skillcap*2 then
            params.skillBonus = sLvl + iLvl - skillcap*2 -- every point over the skillcap (only attainable from gear/merits) is an extra +1 magic accuracy
        end
    end

    local resm = applyResistance(caster, target, spell, params)
    -- print("rsem=" .. resm)

    if resm < 0.5 then
        -- print("resm resist")
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        return tpz.effect.THRENODY
    end

    -- Remove previous Threnody
    target:delStatusEffect(tpz.effect.THRENODY)

    local iBoost = caster:getMod(tpz.mod.THRENODY_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    local power = basePower + iBoost*5
    local duration = baseDuration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if caster:hasStatusEffect(tpz.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(tpz.effect.MARCATO) then
        power = power * 1.5
    end

    if caster:hasStatusEffect(tpz.effect.TROUBADOUR) then
        duration = duration * 2
    end

    -- Set spell message and apply status effect
    target:addStatusEffect(tpz.effect.THRENODY, -power, 0, duration, 0, modifier, 0)

    return tpz.effect.THRENODY
end

function handleNinjutsuDebuff(caster, target, spell, basePower, baseDuration, modifier)
    target:addStatusEffectEx(tpz.effect.NINJUTSU_ELE_DEBUFF, 0, basePower, 0, baseDuration, 0, modifier, 0)
    return tpz.effect.NINJUTSU_ELE_DEBUFF
end

-- Returns true if you can overwrite the effect
-- Example: canOverwrite(target, tpz.effect.SLOW, 25)
function canOverwrite(target, effect, power, mod)
    mod = mod or 1

    local statusEffect = target:getStatusEffect(effect)

    if statusEffect == nil then return true end

    if statusEffect:getPower()*mod > power then return false end

    return true
end

function getElementalSDT(element, target) -- takes into account if magic burst window is open -> increase tier by 1
    if target:isPC() then return 100 end

    local SDT = 100
    local SDTmod = 0
    
    if     element == 1 then SDTmod = tpz.mod.SDT_FIRE
    elseif element == 2 then SDTmod = tpz.mod.SDT_ICE
    elseif element == 3 then SDTmod = tpz.mod.SDT_WIND
    elseif element == 4 then SDTmod = tpz.mod.SDT_EARTH
    elseif element == 5 then SDTmod = tpz.mod.SDT_THUNDER
    elseif element == 6 then SDTmod = tpz.mod.SDT_WATER
    elseif element == 7 then SDTmod = tpz.mod.SDT_LIGHT
    elseif element == 8 then SDTmod = tpz.mod.SDT_DARK
    end
    if SDTmod > 0 then SDT = target:getMod(SDTmod) end
    
    if SDT == 0 or SDT == nil then SDT = 100 end
    
    local MB1 = 0
    local MB2 = 0
    MB1, MB2 = FormMagicBurst(element, target)
    
    if MB1 > 0 then -- window is open for this element, up one tier SDT
        if     SDT == 5   then SDT = 10
        elseif SDT == 10  then SDT = 15
        elseif SDT == 15  then SDT = 20
        elseif SDT == 20  then SDT = 25
        elseif SDT == 25  then SDT = 30
        elseif SDT == 30  then SDT = 40
        elseif SDT == 40  then SDT = 50
        elseif SDT == 50  then SDT = 60
        elseif SDT == 60  then SDT = 70
        elseif SDT == 70  then SDT = 85
        elseif SDT == 85  then SDT = 100
        elseif SDT == 100 then SDT = 115
        elseif SDT == 115 then SDT = 130
        elseif SDT == 130 then SDT = 150
        elseif SDT == 150 then SDT = 150
        else SDT = SDT + 10 end
    end
    
    local SDTcoe = (1 - target:getMod(tpz.mod.SPDEF_DOWN)/100) -- warrior's tomahawk, or whm's banish against undead
    if SDTcoe < 0.03 then
        SDTcoe = 0.03
    elseif SDTcoe > 1 then
        SDTcoe = 1
    end
    
    if SDT < 100 then -- these SPDEF_DOWN effects don't mean anything if it's the mob's weakness already
        SDT = 100 - ((100 - SDT) * SDTcoe)
    end
    
    if SDT < 5 then
        SDT = 5
    elseif SDT > 150 then
        SDT = 150
    end
    --print(string.format(SDT))
    return SDT
end

function doElementalNuke(caster, spell, target, spellParams)
    local DMG = 0
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local V = 0
    local M = 0
    local hasMultipleTargetReduction = spellParams.hasMultipleTargetReduction
    local resistBonus = spellParams.resistBonus

    if USE_OLD_MAGIC_DAMAGE and spellParams.V ~= nil and spellParams.M ~= nil then
        V = spellParams.V -- Base value
        M = spellParams.M -- Spell Tier multiplier, i.e. Stone II, Stone III
        local I = spellParams.I -- Inflection point (a.k.a. the soft cap)
        local cap = I * 2 + V

        if dINT < 0 then -- If dINT is a negative value the tier multiplier M is always 1
            DMG = V + dINT
            if DMG < 1 then return 0 end
        elseif dINT < I then -- dINT > 0 but below inflection point I
            DMG = V + dINT * M
        else -- Above inflection point I additional dINT is only half as effective
            DMG = V + I + ((dINT - I) * (M / 2))
        end
        
        if DMG > cap then DMG = cap end

    else
        local mDMG = caster:getMod(tpz.mod.MAGIC_DAMAGE)

        -- D = floor[ mDMG + V + (dINT × M) ]
        -- For dINT reduce by amount factored into the V value (example: at 134 INT, when using V100 in the calculation, use dINT = 134-100 = 34)

        if dINT <= 49 then
            V = spellParams.V0
            M = spellParams.M0
            DMG = math.floor(DMG + mDMG + V + (dINT * M))
            if DMG <= 0 then return 0 end
        elseif dINT >= 50 and dINT <= 99 then
            V = spellParams.V50
            M = spellParams.M50
            DMG = math.floor(DMG + mDMG + V + ((dINT - 50) * M))
        elseif dINT >= 100 and dINT <= 199 then
            V = spellParams.V100
            M = spellParams.M100
            DMG = math.floor(DMG + mDMG + V + ((dINT - 100) * M))
        elseif dINT > 199 then
            V = spellParams.V200
            M = spellParams.M200
            DMG = math.floor(DMG + mDMG + V + ((dINT - 200) * M))
        end
    end

    --get resist multiplier (1x if no resist)
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.ELEMENTAL_MAGIC
    params.resistBonus = resistBonus
    params.dStatAccSoftCap = 10

    local resist = applyResistance(caster, target, spell, params)
    
    local element = spell:getElement()
    
    local MTDR = 1.0
    
    if hasMultipleTargetReduction == true then
        MTDR = 0.90 - spell:getTotalTargets() * 0.05
        if MTDR == 0.85 then -- 1 target, stay at 1.0
            MTDR = 1.0
        elseif MTDR < 0.4 then
            MTDR = 0.4
        end
        --print(string.format("MTDR was %.2f for numtargets %u",MTDR,spell:getTotalTargets()))
    end
    
    if target:isNM() then DMG = applyNMDamagePenalty(target, DMG) end
    
    DMG = DMG * resist * MTDR
    DMG = addBonuses(caster, spell, target, DMG, spellParams) -- staff/day/weather/jas/mab/etc all go in this function
    DMG = adjustForTarget(target, DMG, element)
    DMG = finalMagicAdjustments(caster, target, spell, DMG)

    return DMG
end

function doDivineNuke(caster, target, spell, params)
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.attribute = tpz.mod.MND
    params.dStatAccSoftCap = 10

    return doNuke(caster, target, spell, params)
end

function doNinjutsuNuke(caster, target, spell, params)
    local mabBonus = params.bonusmab

    mabBonus = mabBonus or 0

    mabBonus = mabBonus + caster:getMod(tpz.mod.NIN_NUKE_BONUS) -- "enhances ninjutsu damage" bonus
    if caster:hasStatusEffect(tpz.effect.INNIN) and caster:isBehind(target, 23) then -- Innin mag atk bonus from behind, guesstimating angle at 23 degrees
        mabBonus = mabBonus + 30
    end
    params.skillType = tpz.skill.NINJUTSU
    params.attribute = tpz.mod.INT
    params.bonusmab = mabBonus
    params.dStatAccSoftCap = 10

    return doNuke(caster, target, spell, params)
end

function doNuke(caster, target, spell, params)
    params.dStatAccSoftCap = 10
    local dmg = calculateMagicDamage(caster, target, spell, params)
    if target:isNM() then dmg = applyNMDamagePenalty(target, dmg) end
    
    local resist = applyResistance(caster, target, spell, params)
    dmg = dmg*resist
    
    if spell:getSkillType() == tpz.skill.NINJUTSU then
        if caster:getMainJob() == tpz.job.NIN then -- NIN main gets a bonus to their ninjutsu nukes
            local ninSkillBonus = 100
            if spell:getID() % 3 == 2 then -- ichi nuke spell ids are 320, 323, 326, 329, 332, and 335
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(tpz.skill.NINJUTSU) - 50)/2) -- getSkillLevel includes bonuses from merits and modifiers (ie. gear)
            elseif spell:getID() % 3 == 0 then -- ni nuke spell ids are 1 more than their corresponding ichi spell
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(tpz.skill.NINJUTSU) - 125)/2)
            else -- san nuke spell, also has ids 1 more than their corresponding ni spell
                ninSkillBonus = 100 + math.floor((caster:getSkillLevel(tpz.skill.NINJUTSU) - 275)/2)
            end
            ninSkillBonus = utils.clamp(ninSkillBonus, 100, 200) -- bonus caps at +100%, and does not go negative
            dmg = dmg * ninSkillBonus/100
        end
        
        if caster:hasStatusEffect(tpz.effect.FUTAE) then
            dmg = math.floor(dmg * 1.50)
            caster:delStatusEffect(tpz.effect.FUTAE)
        end
    end
    
    dmg = addBonuses(caster, spell, target, dmg, params) -- staff/day/weather/jas/mab/etc all go in this function
    dmg = adjustForTarget(target, dmg, spell:getElement())
    dmg = finalMagicAdjustments(caster, target, spell, dmg)
    return dmg
end

function doDivineBanishNuke(caster, target, spell, params)
    params.skillType = tpz.skill.DIVINE_MAGIC
    params.attribute = tpz.mod.MND
    params.dStatAccSoftCap = 10
    
    if caster:isPC() then params.dmg = params.dmg + caster:getMerit(tpz.merit.BANISH_EFFECT) end

    local dmg = calculateMagicDamage(caster, target, spell, params)
    local resist = applyResistance(caster, target, spell, params)

    if target:isNM() then dmg = applyNMDamagePenalty(target, dmg) end
    
    dmg = dmg*resist
    dmg = addBonuses(caster, spell, target, dmg, params) -- staff/day/weather/jas/mab/etc all go in this function
    dmg = adjustForTarget(target, dmg, spell:getElement())
    dmg = handleAfflatusMisery(caster, spell, dmg)
    dmg = finalMagicAdjustments(caster, target, spell, dmg)
    return dmg
end

function calculateDurationForLvl(duration, spellLvl, targetLvl)
    if targetLvl < spellLvl then return duration * targetLvl / spellLvl end
    return duration
end

function calculateDuration(duration, magicSkill, spellGroup, caster, target, useComposure)
    if magicSkill == tpz.skill.ENHANCING_MAGIC then
    
        duration = duration + duration * caster:getMod(tpz.mod.ENH_MAGIC_DURATION) / 100 -- Gear mods
        duration = duration + caster:getMerit(tpz.merit.ENHANCING_MAGIC_DURATION)
        
        useComposure = useComposure or (useComposure == nil and true)

        if useComposure and caster:hasStatusEffect(tpz.effect.COMPOSURE) and caster:getID() == target:getID() then
            duration = duration * 3
        end

        if caster:hasStatusEffect(tpz.effect.PERPETUANCE) and spellGroup == tpz.magic.spellGroup.WHITE then
            duration  = duration * 2
        end
        
    elseif magicSkill == tpz.skill.ENFEEBLING_MAGIC then
        if caster:hasStatusEffect(tpz.effect.SABOTEUR) then
            if target:isNM() then
                duration = duration * 1.25
            else
                duration = duration * 2
            end
        end
        
        duration = duration + caster:getMerit(tpz.merit.ENFEEBLING_MAGIC_DURATION) -- After Saboteur according to bg-wiki
    end

    return math.floor(duration)
end

function calculatePotency(basePotency, magicSkill, caster, target)
    if magicSkill ~= tpz.skill.ENFEEBLING_MAGIC then
        return basePotency
    end

    if caster:hasStatusEffect(tpz.effect.SABOTEUR) then
        if target:isNM() then
            basePotency = math.floor(basePotency * (1.3 + caster:getMod(tpz.mod.ENHANCES_SABOTEUR)))
        else
            basePotency = math.floor(basePotency * (2 + caster:getMod(tpz.mod.ENHANCES_SABOTEUR)))
        end
    end

    return math.floor(basePotency * (1 + caster:getMod(tpz.mod.ENF_MAG_POTENCY) / 100))
end

-- Output magic hit rate for all levels
function outputMagicHitRateInfo()
    for casterLvl = 1, 75 do

        printf("")
        printf("-------- CasterLvl: %d", casterLvl)

        for lvlMod = -5, 20 do

            local targetLvl = casterLvl + lvlMod

            if targetLvl >= 0 then
                -- assume BLM spell, A+
                local magicAcc = utils.getSkillLvl(6, casterLvl)
                -- assume default monster magic eva, C
                local magicEvaRank = 3
                local rate = 0

                local magicEva = utils.getMobSkillLvl(magicEvaRank, targetLvl)

                local dINT = (lvlMod + 1) * -1

                if dINT > 10 then
                    magicAcc = magicAcc + 10 + (dINT - 10)/2
                else
                    magicAcc = magicAcc + dINT
                end

                local magicHitRate = calculateMagicHitRate(magicAcc, magicEva, 0, casterLvl, targetLvl, 100)

                printf("Lvl: %d vs %d, %d%%, MA: %d, ME: %d", casterLvl, targetLvl, magicHitRate, magicAcc, magicEva)
            end

        end
    end
end

function applyNMDamagePenalty(target, DMG)
    DMG = DMG - (DMG * target:getMod(tpz.mod.MAGIC_STACKING_MDT) / 100)
    if target:getMod(tpz.mod.MAGIC_STACKING_MDT) == 0 then
        target:setMod(tpz.mod.MAGIC_STACKING_MDT, NM_MAGIC_STACK)
        target:queue(NM_MAGIC_STACK_WINDOW, function(target)
            target:setMod(tpz.mod.MAGIC_STACKING_MDT,0)
        end)
    elseif target:getMod(tpz.mod.MAGIC_STACKING_MDT) < NM_MAGIC_STACK_CAP then
        target:setMod(tpz.mod.MAGIC_STACKING_MDT, target:getMod(tpz.mod.MAGIC_STACKING_MDT) + NM_MAGIC_STACK)
    end
    return DMG
end 

function tryBuildResistance(mod, target)

    local percent = target:calculateResistanceBuildPercent(mod)
    --print(string.format("magic:tryBuildResistance(%u, %s) -> %u", mod, target:getName(), percent))
    return 1 - percent/100
end


tpz.ma = tpz.magic
