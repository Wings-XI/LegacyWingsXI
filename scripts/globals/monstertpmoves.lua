require("scripts/globals/magicburst")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")

-- Foreword: A lot of this is good estimating since the FFXI playerbase has not found all of info for individual moves.
--            What is known is that they roughly follow player Weaponskill calculations (pDIF, dMOD, ratio, etc) so this is what
--            this set of functions emulates.

-- mob types
-- used in mob:isMobType()
MOBTYPE_NORMAL            = 0x00
MOBTYPE_0X01             = 0x01
MOBTYPE_NOTORIOUS        = 0x02
MOBTYPE_FISHED            = 0x04
MOBTYPE_CALLED            = 0x08
MOBTYPE_BATTLEFIELD        = 0x10
MOBTYPE_EVENT            = 0x20

MOBDRAIN_HP = 0
MOBDRAIN_MP = 1
MOBDRAIN_TP = 2

--shadowbehav (number of shadows to take off)
MOBPARAM_IGNORE_SHADOWS = 0
MOBPARAM_1_SHADOW = 1
MOBPARAM_2_SHADOW = 2
MOBPARAM_3_SHADOW = 3
MOBPARAM_4_SHADOW = 4
MOBPARAM_WIPE_SHADOWS = 999

TP_ACC_VARIES = 0
TP_ATK_VARIES = 1
TP_DMG_VARIES = 2
TP_CRIT_VARIES = 3
TP_NO_EFFECT = 0
TP_MACC_BONUS = 1
TP_MAB_BONUS = 2
TP_DMG_BONUS = 3
TP_RANGED = 4

BOMB_TOSS_HPP = 1

function MobRangedMove(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect)
    -- this will eventually contain ranged attack code
    return MobPhysicalMove(mob, target, skill, numberofhits, accmod, dmgmod, TP_RANGED, 1, 1, 1)
end

function tryParryBlockGuard(mob, target, tpeffect, minRatio, maxRatio, dmg)
    
    -- return value is newDMG, hitLanded
    -- hitLanded is basically for the purpose of if the attack should be considered for shadowbeh later, and also tp generation for defender
    
    local pdif = math.random((minRatio*1000),(maxRatio*1000))/1000
    
    if tpeffect ~= TP_RANGED then
        if math.random()*100 < target:getParryRate(mob) then
            target:trySkillUp(mob, tpz.skill.PARRY, 1)
            --target:PrintToPlayer("Successfully parried a TP move swing!")
            return 0, false
        elseif math.random()*100 < target:getBlockRate(mob) then
            target:trySkillUp(mob, tpz.skill.SHIELD, 1)
            --target:PrintToPlayer("Successfully blocked a TP move swing!")
            return target:getBlockedDamage(dmg*pdif), true
        elseif math.random()*100 < target:getGuardRate(mob) then
            target:trySkillUp(mob, tpz.skill.GUARD, 1)
            --target:PrintToPlayer("Successfully guarded a TP move swing!")
            pdif = pdif - 1
            if pdif < 0 then return 0, false end
        end
    end
    
    return dmg*pdif, true
end

-- PHYSICAL MOVE FUNCTION
-- Call this on every physical move!
-- accmod is a linear multiplier for accuracy (1 default)
-- dmgmod is a linear multiplier for damage (1 default)
-- tpeffect is an enum which can be one of:
-- 0 TP_ACC_VARIES
-- 1 TP_ATK_VARIES
-- 2 TP_DMG_VARIES
-- 3 TP_CRIT_VARIES
-- mtp100/200/300 are the three values for 100% TP, 200% TP, 300% TP just like weaponskills.lua
-- if TP_ACC_VARIES -> three values are acc %s (1.0 is 100% acc, 0.8 is 80% acc, 1.2 is 120% acc)
-- if TP_ATK_VARIES -> three values are attack multiplier (1.5x 0.5x etc)
-- if TP_DMG_VARIES -> three values are

function MobPhysicalMove(mob, target, skill, numberofhits, accmod, dmgmod, tpeffect, mtp000, mtp150, mtp300, offcratiomod)
    --dstr scaling per 2 diff is a bit high (should be per 4 diff) but it works out pretty well since the weapon damage of mobs on p.servers is a bit too high (about twice as high)
    --i.e. level 75 mobs have weapons that have 100 base damage.
    --for this reason, going to cap the dstr lower/upper bounds as if it was a rank5 wep (doubled the bounds though since the scaling is twice as aggressive)
    local dstr = math.floor((mob:getStat(tpz.mod.STR) - target:getStat(tpz.mod.VIT)) / 2)
    if dstr < -10 then dstr = -10
    elseif dstr > 26 then dstr = 26 end
    
    local acc = mob:getACC()
    local eva = target:getEVA()
    if target:hasStatusEffect(tpz.effect.YONIN) and mob:isFacing(target, 23) then -- Yonin evasion boost if mob is facing target
        eva = eva + target:getStatusEffect(tpz.effect.YONIN):getPower()
    end

    --apply WSC
    local base = mob:getWeaponDmg() + dstr --todo: change to include WSC
    if base < 1 then base = 1 end

    --work out and cap ratio. default to attack. Pretty much every physical mobskill will use this, Cannonball being the exception.
    if offcratiomod == nil then offcratiomod = mob:getStat(tpz.mod.ATT) end
    local lvldiff = mob:getMainLvl() - target:getMainLvl()
    if lvldiff < 0 then lvldiff = 0 end
    local ratio = offcratiomod/target:getStat(tpz.mod.DEF) + lvldiff * 0.05
    ratio = utils.clamp(ratio, 0, 4)
    
    --work out hit rate for mobs (bias towards them)
    local hitrate = 75 + acc*accmod - eva + lvldiff*2
    hitrate = utils.clamp(hitrate, 20, 95)
    -- printf("acc: %f, eva: %f, hitrate: %f", acc, eva, hitrate)
    
    local hitdamage = (base + lvldiff) * dmgmod

    if tpeffect == TP_DMG_VARIES then hitdamage = hitdamage * MobTPMod(skill:getTP() / 10) end

    --work out min and max cRatio
    local maxRatio = 1
    local minRatio = 0

    if ratio < 0.5 then
        maxRatio = ratio + 0.5
    elseif 0.5 <= ratio and ratio <= 0.7 then
        maxRatio = 1
    elseif 0.7 < ratio and ratio <= 1.2 then
        maxRatio = ratio + 0.3
    elseif 1.2 < ratio and ratio <= 1.5 then
        maxRatio = (ratio * 0.25) + ratio
    elseif 1.5 < ratio and ratio <= 2.625 then
        maxRatio = ratio + 0.375
    elseif 2.625 < ratio and ratio <= 3.25 then
        maxRatio = 3
    else
        maxRatio = ratio
    end


    if ratio < 0.38 then
        minRatio = 0
    elseif 0.38 <= ratio and ratio <= 1.25 then
        minRatio = ratio * 1176 / 1024 - (448 / 1024)
    elseif 1.25 < ratio and ratio <= 1.51 then
        minRatio = 1
    elseif 1.51 < ratio and ratio <= 2.44 then
        minRatio = ratio * 1176 / 1024 - (775 / 1024)
    else
        minRatio = ratio - 0.375
    end

    --apply ftp (assumes 1~3 scalar linear mod)
    if tpeffect == TP_DMG_BONUS then hitdamage = hitdamage * fTP(skill:getTP(), mtp000, mtp150, mtp300) end

    -- start the hits
    local finaldmg = 0
    local hitsdone = 0
    local hitslanded = 0
    local swingDamage = 0
    local swingLanded = false

    while hitsdone < numberofhits do
        if math.random()*100 <= hitrate then -- it hit
            --target:PrintToPlayer("swing prehit!")
            swingDamage, swingLanded = tryParryBlockGuard(mob, target, tpeffect, minRatio, maxRatio, hitdamage)
            swingDamage = swingDamage - target:getMod(tpz.mod.PHALANX)
            if swingDamage > 0 then finaldmg = finaldmg + swingDamage end
            if swingLanded then hitslanded = hitslanded + 1 end
        end
        hitsdone = hitsdone + 1
    end

    -- all hits missed
    if hitslanded == 0 then
        finaldmg = 0
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end
    
    local returninfo = {}
    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo

end

-- MAGICAL MOVE
-- Call this on every magical move!
-- mob/target/skill should be passed from onMobWeaponSkill.
-- dmg is the base damage (V value), accmod is a multiplier for accuracy (1 default, more than 1 = higher macc for mob),
-- ditto for dmg mod but more damage >1 (equivalent of M value)
-- tpeffect is an enum from one of:
-- 0 = TP_NO_EFFECT
-- 1 = TP_MACC_BONUS
-- 2 = TP_MAB_BONUS
-- 3 = TP_DMG_BONUS
-- tpvalue affects the strength of having more TP along the following lines:
-- TP_NO_EFFECT -> tpvalue has no tpz.effect.
-- TP_MACC_BONUS -> direct multiplier to macc (1 for default)
-- TP_MAB_BONUS -> direct multiplier to mab (1 for default)
-- TP_DMG_BONUS -> direct multiplier to damage (V+dINT) (1 for default)
--Examples:
-- TP_DMG_BONUS and TP=100, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1)/100 = 150
-- TP_DMG_BONUS and TP=200, tpvalue = 1, assume V=150  --> damage is now 150*(TP*1)/100 = 300
-- TP_DMG_BONUS and TP=100, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2)/100 = 300
-- TP_DMG_BONUS and TP=200, tpvalue = 2, assume V=150  --> damage is now 150*(TP*2)/100 = 600

function MobMagicalMove(mob, target, skill, damage, element, dmgmod, tpeffect, tpvalue, accmod)
    returninfo = {}
    --get all the stuff we need
    local resist = 1

    local mdefBarBonus = 0
    if
        element >= tpz.magic.element.FIRE and
        element <= tpz.magic.element.WATER and
        target:hasStatusEffect(tpz.magic.barSpell[element])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(tpz.magic.barSpell[element]):getSubPower()
    end
    -- plus 100 forces it to be a number
    mab = (100 + mob:getMod(tpz.mod.MATT)) / (100 + target:getMod(tpz.mod.MDEF) + mdefBarBonus)

    if (mab > 1.3) then
        mab = 1.3
    end

    if (mab < 0.7) then
        mab = 0.7
    end

    if (tpeffect==TP_DMG_BONUS) then
        damage = damage * (((skill:getTP() / 10)*tpvalue)/100)
    end

    -- printf("power: %f, bonus: %f", damage, mab)
    -- resistence is added last
    finaldmg = damage * mab * dmgmod

    -- get resistence
    local totalAccBonus = 0
    if (mob:isPet() and mob:getMaster() ~= nil) then
        local master = mob:getMaster()
        if (master:getPetID() >= 0 and master:getPetID() <= 20 and master:isPC()) then -- check to ensure pet is avatar
            totalAccBonus = utils.clamp(master:getSkillLevel(tpz.skill.SUMMONING_MAGIC) - master:getMaxSkillLevel(mob:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC), 0, 200) + master:getMerit(1284) -- avatar magic acc merit
        end
    end

    if (accMod and accMod > 0) then
        totalAccBonus = totalAccBonus + accmod
    end

    resist = applyPlayerResistance(mob, nil, target, mob:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), totalAccBonus, element)

    local magicDefense = getElementalDamageReduction(target, element)

    finaldmg = finaldmg * resist * magicDefense
    
    local ramSS = target:getMod(tpz.mod.RAMPART_STONESKIN)
    if ramSS > 0 then
        if finaldmg >= ramSS then
            target:setMod(tpz.mod.RAMPART_STONESKIN, 0)
            finaldmg = finaldmg - ramSS
        else
            target:setMod(tpz.mod.RAMPART_STONESKIN, ramSS - finaldmg)
            finaldmg = 0
        end
    end

    returninfo.dmg = finaldmg

    return returninfo

end

-- mob version
-- effect = tpz.effect.WHATEVER if enfeeble
-- statmod = the stat to account for resist (INT, MND, etc) e.g. tpz.mod.INT
-- This determines how much the monsters ability resists on the player.
function applyPlayerResistance(mob, effect, target, diff, bonus, element)
    local percentBonus = 0
    local magicaccbonus = 0

    if effect ~= nil and math.random() < getEffectResistanceTraitChance(mob, target, effect) then
        return 1/16 -- this will make any status effect fail. this takes into account trait+food+gear
    end

    if (diff > 10) then
        magicaccbonus = magicaccbonus + 10 + (diff - 10)/2
    else
        magicaccbonus = magicaccbonus + diff
    end

    if (bonus ~= nil) then
        magicaccbonus = magicaccbonus + bonus
    end

    if (effect ~= nil) then
        percentBonus = percentBonus - getEffectResistance(target, effect)
    end

    local p = getMagicHitRate(mob, target, 0, element, percentBonus, magicaccbonus)

    return getMagicResist(p)
end

function mobAddBonuses(caster, spell, target, dmg, ele)

    local magicDefense = getElementalDamageReduction(target, ele)
    dmg = math.floor(dmg * magicDefense)

    dayWeatherBonus = 1.00

    if caster:getWeather() == tpz.magic.singleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif caster:getWeather() == tpz.magic.singleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.25
        end
    elseif caster:getWeather() == tpz.magic.doubleWeatherWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.25
        end
    end

    if VanadielDayElement() == tpz.magic.dayStrong[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus + 0.10
        end
    elseif VanadielDayElement() == tpz.magic.dayWeak[ele] then
        if math.random() < 0.33 then
            dayWeatherBonus = dayWeatherBonus - 0.10
        end
    end

    if dayWeatherBonus > 1.35 then
        dayWeatherBonus = 1.35
    end

    dmg = math.floor(dmg * dayWeatherBonus)

    burst = calculateMobMagicBurst(caster, ele, target)
    
    -- todo: damage compensation until +magic acc can be added instead further up the stack
    if burst > 1.0 then
        burst = burst + 0.1
    end

    --if (burst > 1.0 and skill ~= nil) then -- not a spell, is a mobskill
        --skill:setMsg(747) -- magic burst!
    --end

    dmg = math.floor(dmg * burst)

    local mdefBarBonus = 0
    if
        ele >= tpz.magic.element.FIRE and
        ele <= tpz.magic.element.WATER and
        target:hasStatusEffect(tpz.magic.barSpell[ele])
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(tpz.magic.barSpell[ele]):getSubPower()
    end

    magicDmgMod = (256 + target:getMod(tpz.mod.DMGMAGIC)) / 256

    dmg = math.floor(dmg * magicDmgMod)

    -- print(affinityBonus)
    -- print(speciesReduction)
    -- print(dayWeatherBonus)
    -- print(burst)
    -- print(mab)
    -- print(magicDmgMod)

    return dmg
end

function calculateMobMagicBurst(caster, ele, target)

    local burst = 1.0

    local skillchainTier, skillchainCount = MobFormMagicBurst(ele, target)

    if (skillchainTier > 0) then
        if (skillchainCount == 1) then
            burst = 1.3
        elseif (skillchainCount == 2) then
            burst = 1.35
        elseif (skillchainCount == 3) then
             burst = 1.40
        elseif (skillchainCount == 4) then
            burst = 1.45
        elseif (skillchainCount == 5) then
            burst = 1.50
        elseif (skillchainCount == 6) then
            burst = 1.55
        else
            -- Something strange is going on if this occurs.
            burst = 1.0
        end
    end

    return burst
end

-- Calculates breath damage
-- mob is a mob reference to get hp and lvl
-- percent is the percentage to take from HP
-- base is calculated from main level to create a minimum
-- Equation: (HP * percent) + (LVL / base)
-- cap is optional, defines a maximum damage
function MobBreathMove(mob, target, percent, base, element, cap, bonus)
    local damage = (mob:getHP() * percent) + (mob:getMainLvl() / base)

    if (cap == nil) then
        -- cap max damage
        cap = math.floor(mob:getHP()/5)
    end

    if bonus == nil then
        bonus = 0
    end
    
    -- Deal bonus damage vs mob ecosystem
    local systemBonus = utils.getSystemStrengthBonus(mob, target)
    damage = damage + (damage * (systemBonus * 0.25))

    damage = utils.clamp(damage, 1, cap)

    -- elemental resistence
    if (element ~= nil and element > 0) then
        -- no skill available, pass nil
        local resist = applyPlayerResistance(mob, nil, target, mob:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), bonus, element)

        -- get elemental damage reduction
        local defense = getElementalDamageReduction(target, element)

        damage = damage * resist * defense
    end
    
    damage = math.floor(damage * (math.random()/4 + 0.75))

    local ramSS = target:getMod(tpz.mod.RAMPART_STONESKIN)
    if ramSS > 0 then
        if damage >= ramSS then
            target:setMod(tpz.mod.RAMPART_STONESKIN, 0)
            damage = damage - ramSS
        else
            target:setMod(tpz.mod.RAMPART_STONESKIN, ramSS - damage)
            damage = 0
        end
    end

    return damage
end

-- param requireNumHits is used to get back how many hits actually landed on the target after shadows/blink/thirdeye
-- see mobskill tornado edge for an example
function MobFinalAdjustments(dmg, mob, skill, target, attackType, damageType, shadowbehav, requireNumHits) -- shadowbehav encodes the HITS LANDED if the shadowbehav is not WIPE or IGNORE

    -- physical attack missed, skip rest
    if skill:hasMissMsg() then return 0 end
    
    if ( target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH) ) and attackType == tpz.attackType.PHYSICAL then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return 0
    end

    -- set message to damage. this is for AoE because its only set once
    skill:setMsg(tpz.msg.basic.DAMAGE)

    --Handle shadows depending on shadow behaviour / attackType
    local numShadowsUsed = 0
    if shadowbehav ~= MOBPARAM_WIPE_SHADOWS and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then --remove 'shadowbehav' shadows.

        if skill:isAoE() or skill:isConal() then
            shadowbehav = MobTakeAoEShadow(mob, target, shadowbehav)
        end
        
        if shadowbehav == nil then shadowbehav = 1 end
        dmg, numShadowsUsed = utils.takeShadows(target, dmg, shadowbehav, mob)
        
        if numShadowsUsed == shadowbehav then
            skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
            return shadowbehav
        end

    elseif shadowbehav == MOBPARAM_WIPE_SHADOWS then --take em all!
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)
        target:delStatusEffect(tpz.effect.THIRD_EYE)
    end

    --handle Third Eye using shadowbehav as a guide
    if (attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED) and utils.thirdeye(target) == true then
        skill:setMsg(tpz.msg.basic.ANTICIPATE)
        return 0
    end
	
	if attackType == tpz.attackType.PHYSICAL and skill:isSingle() == false and math.random() < 0.7 then -- per wiki, multiattacks have a very high chance to remove TE
        target:delStatusEffect(tpz.effect.THIRD_EYE)
    end

    -- Handle Automaton Analyzer which decreases damage from successive special attacks
    if target:getMod(tpz.mod.AUTO_ANALYZER) > 0 then
        local analyzerSkill = target:getLocalVar("analyzer_skill")
        local analyzerHits = target:getLocalVar("analyzer_hits")
        if analyzerSkill == skill:getID() then
            analyzerHits = analyzerHits + 1
            local cappedNum = analyzerHits
            if analyzerHits > target:getMod(tpz.mod.AUTO_ANALYZER) then
                cappedNum = target:getMod(tpz.mod.AUTO_ANALYZER)
            end
            dmg = dmg * (1.1 - cappedNum/10)
        else
            target:setLocalVar("analyzer_skill", skill:getID())
            analyzerHits = 1
        end
        target:setLocalVar("analyzer_hits", analyzerHits)
    end

    if attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED then

        dmg = target:physicalDmgTaken(dmg, damageType)
        if not target:isPC() then
            local h2hres = target:getMod(tpz.mod.H2HRES)
            local pierceres = target:getMod(tpz.mod.PIERCERES)
            local impactres = target:getMod(tpz.mod.IMPACTRES)
            local slashres = target:getMod(tpz.mod.SLASHRES)
            local spdefdown = target:getMod(tpz.mod.SPDEF_DOWN)
            
            if damageType == tpz.damageType.H2H then
                if h2hres < 1000 then
                    dmg = dmg * (1 - ((1 - h2hres / 1000) * (1 - spdefdown/100)))
                else
                    dmg = dmg * h2hres / 1000
                end
            elseif damageType == tpz.damageType.PIERCING then
                if pierceres < 1000 then
                    dmg = dmg * (1 - ((1 - pierceres / 1000) * (1 - spdefdown/100)))
                else
                    dmg = dmg * pierceres / 1000
                end
            elseif damageType == tpz.damageType.BLUNT then
                if impactres < 1000 then
                    dmg = dmg * (1 - ((1 - impactres / 1000) * (1 - spdefdown/100)))
                else
                    dmg = dmg * impactres / 1000
                end
            else
                if slashres < 1000 then
                    dmg = dmg * (1 - ((1 - slashres / 1000) * (1 - spdefdown/100)))
                else
                    dmg = dmg * slashres / 1000
                end
            end
        end

    elseif attackType == tpz.attackType.MAGICAL then

        dmg = target:magicDmgTaken(dmg)

    elseif attackType == tpz.attackType.BREATH then

        dmg = target:breathDmgTaken(dmg)

    elseif attackType == tpz.attackType.RANGED then

        dmg = target:rangedDmgTaken(dmg)

    end

    --phalanx was handled on a per-hit basis for physical attacks already
    if attackType ~= tpz.attackType.PHYSICAL and attackType ~= tpz.attackType.RANGED then
        dmg = dmg - target:getMod(tpz.mod.PHALANX)
    end
    if dmg < 0 then return 0 end

    dmg = utils.stoneskin(target, dmg)

    local numHits = 1
    if dmg > 0 then
        target:updateEnmityFromDamage(mob, dmg)
        target:handleAfflatusMiseryDamage(dmg)
        if attackType == tpz.attackType.PHYSICAL or attackType == tpz.attackType.RANGED then
            if shadowbehav ~= MOBPARAM_WIPE_SHADOWS and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then
                numHits = shadowbehav - numShadowsUsed
            end
            target:addTP(10*numHits)
        end
    end

    if (requireNumHits ~= nil) then
        local returnInfo = {}
        returnInfo.dmg = dmg
        returnInfo.hitslanded = numHits

        return returnInfo
    else
        return dmg
    end
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function MobPhysicalHit(skill)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:hasMissMsg() == false
end

-- function MobHit()
-- end

-- function MobAoEHit()
-- end

-- function MobMagicHit()
-- end

-- function MobMagicAoEHit()
-- end

function MobDrainMove(mob, target, drainType, drain, attackType, damageType)

    if (target:isUndead() == false) then
        if (drainType == MOBDRAIN_MP) then
            -- can't go over limited mp
            if (target:getMP() < drain) then
                drain = target:getMP()
            end

            target:delMP(drain)
            mob:addMP(drain)

            return tpz.msg.basic.SKILL_DRAIN_MP
        elseif (drainType == MOBDRAIN_TP) then
            -- can't go over limited tp
            if (target:getTP() < drain) then
                drain = target:getTP()
            end

            target:delTP(drain)
            mob:addTP(drain)

            return tpz.msg.basic.SKILL_DRAIN_TP
        elseif (drainType == MOBDRAIN_HP) then
            -- can't go over limited hp
            if (target:getHP() < drain) then
                drain = target:getHP()
            end

            target:takeDamage(drain, mob, attackType, damageType)
            mob:addHP(drain)

            return tpz.msg.basic.SKILL_DRAIN_HP
        end
    else
        -- it's undead so just deal damage
        -- can't go over limited hp
        if (target:getHP() < drain) then
            drain = target:getHP()
        end

        target:takeDamage(drain, mob, attackType, damageType)
        return tpz.msg.basic.DAMAGE
    end

    return tpz.msg.basic.SKILL_NO_EFFECT
end

function MobPhysicalDrainMove(mob, target, skill, drainType, drain)
    if (MobPhysicalHit(skill)) then
        return MobDrainMove(mob, target, drainType, drain)
    end

    return tpz.msg.basic.SKILL_MISS
end

function MobDrainAttribute(mob, target, typeEffect, power, tick, duration)
    local positive = nil
    if (typeEffect == tpz.effect.STR_DOWN) then
        positive = tpz.effect.STR_BOOST
    elseif (typeEffect == tpz.effect.DEX_DOWN) then
        positive = tpz.effect.DEX_BOOST
    elseif (typeEffect == tpz.effect.AGI_DOWN) then
        positive = tpz.effect.AGI_BOOST
    elseif (typeEffect == tpz.effect.VIT_DOWN) then
        positive = tpz.effect.VIT_BOOST
    elseif (typeEffect == tpz.effect.MND_DOWN) then
        positive = tpz.effect.MND_BOOST
    elseif (typeEffect == tpz.effect.INT_DOWN) then
        positive = tpz.effect.INT_BOOST
    elseif (typeEffect == tpz.effect.CHR_DOWN) then
        positive = tpz.effect.CHR_BOOST
    end

    if (positive ~= nil) then
        local results = MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

        if (results == tpz.msg.basic.SKILL_ENFEEB_IS) then
            mob:addStatusEffect(positive, power, tick, duration)

            return tpz.msg.basic.ATTR_DRAINED
        end

        return tpz.msg.basic.SKILL_MISS
    end

    return tpz.msg.basic.SKILL_NO_EFFECT
end

function MobDrainStatusEffectMove(mob, target)
    -- try to drain buff
    local effect = mob:stealStatusEffect(target)

    if (effect ~= 0) then
        return tpz.msg.basic.EFFECT_DRAINED
    end

    return tpz.msg.basic.SKILL_NO_EFFECT
end

-- Adds a status effect to a target
function MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)

    if (target:canGainStatusEffect(typeEffect, power)) then
        local statmod = tpz.mod.INT
        local element = mob:getStatusEffectElement(typeEffect)

        local resist = applyPlayerResistance(mob, typeEffect, target, mob:getStat(statmod)-target:getStat(statmod), 0, element)

        if (resist >= 0.25) then

            local totalDuration = utils.clamp(duration * resist, 1)
            target:addStatusEffect(typeEffect, power, tick, totalDuration)

            return tpz.msg.basic.SKILL_ENFEEB_IS
        end

        return tpz.msg.basic.SKILL_MISS -- resist !
    end
    return tpz.msg.basic.SKILL_NO_EFFECT -- no effect
end

-- similar to status effect move except, this will not land if the attack missed
function MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, tick, duration)

    if (MobPhysicalHit(skill)) then
        return MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end

    return tpz.msg.basic.SKILL_MISS
end

-- similar to statuseffect move except it will only take effect if facing
function MobGazeMove(mob, target, typeEffect, power, tick, duration)
    if (target:isFacing(mob)) then
        return MobStatusEffectMove(mob, target, typeEffect, power, tick, duration)
    end
    return tpz.msg.basic.SKILL_NO_EFFECT
end

function MobBuffMove(mob, typeEffect, power, tick, duration)

    if (mob:addStatusEffect(typeEffect, power, tick, duration)) then
        return tpz.msg.basic.SKILL_GAIN_EFFECT
    end
    return tpz.msg.basic.SKILL_NO_EFFECT
end

function MobHealMove(target, heal)

    local mobHP = target:getHP()
    local mobMaxHP = target:getMaxHP()

    if (mobHP+heal > mobMaxHP) then
        heal = mobMaxHP - mobHP
    end

    target:wakeUp()

    target:addHP(heal)

    return heal
end

function MobTakeAoEShadow(mob, target, maxs)
    local skillmax = math.floor(269 * 75 / target:getMainLvl()) -- yeah i know this is a linear approximation, usually you'd want getskillcap for said level, but this is close enough for this application
    if skillmax < 40 then
        skillmax = 40
    end
    local currskill = target:getSkillLevel(tpz.skill.NINJUTSU)
    
    local chance = 0.65 * currskill / skillmax
    
    if math.random() < chance then
        maxs = maxs - 1
        if maxs < 1 then
            maxs = 1
        end
    end

    return maxs
end

function MobTPMod(tp)
    -- increase damage based on tp
    if tp >= 3000 then return 2
    elseif tp >= 2000 then return 1.5
    else return 1 end
end

function fTP(tp, ftp1, ftp2, ftp3)
    if tp < 1000 then tp = 1000 end
    
    if tp >= 1000 and tp < 1500 then
        return ftp1 + ((ftp2-ftp1)/500) * (tp-1000)
    elseif tp >= 1500 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ((ftp3-ftp2)/1500) * (tp-1500)
    end
    return 1 -- no ftp mod
end
