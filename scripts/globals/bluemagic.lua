require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")

-- BLU ecosystem
ECO_BEAST = 1
ECO_LIZARD = 2
ECO_VERMIN = 3
ECO_PLANTOID = 4

ECO_AQUAN = 5
ECO_AMORPH = 6
ECO_BIRD = 7

ECO_UNDEAD = 8
ECO_ARCANA = 9

ECO_DRAGON = 10
ECO_DEMON = 11

ECO_LUMORIAN = 12
ECO_LUMINION = 13

ECO_NONE = 0 -- beastmen or other ecosystems that have no strength/weaknesses

-- SC Properties
SC_IMPACTION = 0
SC_TRANSFIXION = 1
SC_DETONATION = 2
SC_REVERBERATION = 3
SC_SCISSION = 4
SC_INDURATION = 5
SC_LIQUEFACTION = 6
SC_COMPRESSION = 7

SC_FUSION = 8
SC_FRAGMENTATION = 9
SC_DISTORTION = 10
SC_GRAVITATION = 11

SC_DARK = 12
SC_LIGHT = 13

INT_BASED = 1
CHR_BASED = 2
MND_BASED = 3

function GetTargetEcosystem(target)
	local sys = target:getSystem()

    -- honestly just taking the topaz enum standard and converting it an easier enum standard
    -- this makes it very easy to explain the strengths/weaknesses (in the next function)

	if sys == 6 then return 1
	elseif sys == 14 then return 2
	elseif sys == 20 then return 3
	elseif sys == 17 then return 4
	elseif sys == 2 then return 5
	elseif sys == 1 then return 6
	elseif sys == 8 then return 7
	elseif sys == 19 then return 8
	elseif sys == 3 then return 9
	elseif sys == 10 then return 10
	elseif sys == 9 then return 11
	elseif sys == 15 then return 12
	elseif sys == 16 then return 13 end

	return 0

end

function GetMonsterCorrelation(eco,targeco)

    -- see top of document for the five ecosystem groups
    -- they work as a rotating rock-paper-scissors system for each group
    -- 1 beats 2 beats 3 beats 4 beats 1
    -- 5 beats 6 beats 7 beats 5
    -- 8/9 beat each other. 10/11 beat each other. 12/13 beat each other.
    -- https://ffxiclopedia.fandom.com/wiki/Category:Bestiary
    -- return value ... -1 = negative correlation, 0 = neutral, 1 = positive correlation

	if eco == 1 then
		if targeco == 2 then return  1 end
		if targeco == 4 then return -1 end
	elseif eco == 2 then
		if targeco == 3 then return  1 end
		if targeco == 1 then return -1 end
	elseif eco == 3 then
		if targeco == 4 then return  1 end
		if targeco == 2 then return -1 end
	elseif eco == 4 then
		if targeco == 1 then return  1 end
		if targeco == 3 then return -1 end
	elseif eco == 5 then
		if targeco == 6 then return  1 end
		if targeco == 7 then return -1 end
	elseif eco == 6 then
		if targeco == 7 then return  1 end
		if targeco == 5 then return -1 end
	elseif eco == 7 then
		if targeco == 5 then return  1 end
		if targeco == 6 then return -1 end
	elseif eco == 8 and targeco == 9 then
		return 1
	elseif eco == 9 and targeco == 8 then
		return 1
	elseif eco == 10 and targeco == 11 then
		return 1
	elseif eco == 11 and targeco == 10 then
		return 1
	elseif eco == 12 and targeco == 13 then
		return 1
	elseif eco == 13 and targeco == 12 then
		return 1
	end

	return 0

end

function BluePhysicalSpell(caster, target, spell, params)
    local BLUlvl = caster:getMainJob() == tpz.job.BLU and caster:getMainLvl() or caster:getSubLvl()

    -- http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage

    local D =  math.floor((caster:getSkillLevel(tpz.skill.BLUE_MAGIC) * 0.11)) * 2 + 3
    if D > params.duppercap then D = params.duppercap end

    local fStr = BluefSTR(caster:getStat(tpz.mod.STR) - target:getStat(tpz.mod.VIT))
    local WSC = BlueGetWsc(caster, params) -- ex. params.str_wsc of 0.2 = 20% STR added to base dmg
    if caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) then WSC = WSC * 2 end
    local multiplier = params.multiplier -- a.k.a. ftp0
    --print(caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS))

    -- monster correlation affects fTP mults
    local correl = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
    if params.eco ~= nil and target:isMob() then
        if correl > 0 then correl = 0.25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)/100 + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)/100
        elseif correl < 0 then correl = -0.25 end
        if multiplier ~= nil then multiplier = multiplier + correl end
        if params.tp150 ~= nil then params.tp150 = params.tp150 + correl end
        if params.tp300 ~= nil then params.tp300 = params.tp300 + correl end
        --print(string.format("monster family correl was %f",correl))
    end

    -- If under CA, replace multiplier with fTP(multiplier, tp150, tp300)
    local azureLore = caster:getStatusEffect(tpz.effect.AZURE_LORE)
    local chainAffinity = caster:getStatusEffect(tpz.effect.CHAIN_AFFINITY)
    if azureLore ~= nil then
        multiplier = params.azuretp
    elseif chainAffinity ~= nil then
        -- Calculate the total TP available for the fTP multiplier.
        local tp = caster:getTP() + caster:getMerit(tpz.merit.ENCHAINMENT)
        if tp > 3000 then tp = 3000 end

        multiplier = BluefTP(tp, multiplier, params.tp150, params.tp300)
    end

    local finalD = math.floor(D + fStr + WSC) * multiplier
    --GetPlayerByID(1):PrintToPlayer(string.format("finalD = (D + fSTR + WSC) * mult ... %u = (%u + %u + %u) * %f",finalD,D,fStr,WSC,multiplier))

    --print(params.offcratiomod)
    if params.offcratiomod == nil then -- cannonball uses def (cannonball.lua)
        -- https://forum.square-enix.com/ffxi/threads/43706-Aug-12-2014-%28JST%29-Version-Update
        -- implies that pre-2014, player attack has NO effect on BLU spell damage. one of the physical spells stated it did more damage based on skill, so let's use that
        local skill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
        if skill > 200 then
            params.offcratiomod = 215 + (skill-200)*0.9
        else
            params.offcratiomod = skill + 15
        end
        if params.spellLevel ~= nil and BLUlvl > params.spellLevel + 16 then
            local capskill = (params.spellLevel + 16)*276/75
            local capattack = 0
            if capskill > 200 then
                capattack = 215 + (capskill-200)*0.9
            else
                capattack = capskill + 15
            end
            capattack = capattack + (skill - capskill)*0.66
            params.offcratiomod = params.offcratiomod > capattack and capattack or params.offcratiomod
        end
        -- https://ffxiclopedia.fandom.com/wiki/Talk:Physical_Potency need to go to talk page because the main page is saying only +accuracy and nobody ever fixed it
    end
    params.offcratiomod = params.offcratiomod * (caster:getMerit(tpz.merit.PHYSICAL_POTENCY)+100)/100

    params.bonusacc = params.bonusacc == nil and 0 or params.bonusacc
    params.critchance = params.critchance == nil and 0 or utils.clamp(params.critchance + caster:getStat(tpz.mod.DEX)/2 - target:getStat(tpz.mod.AGI)/2, 5, 65) / 100

    local cratio = BluecRatio(params.offcratiomod / target:getStat(tpz.mod.DEF), caster:getMainLvl(), target:getMainLvl(), params.attackType == tpz.attackType.RANGED)
    local hitrate = BlueGetHitRate(caster, target, true, params.bonusacc)

    -- print("pdifmin "..cratio[1].." pdifmax "..cratio[2])

    -------------------------
    --     Attack Loop     --
    -------------------------
    local hitsdone = 0
    local hitslanded = 0
    local finaldmg = 0
    local isSneakValid = caster:hasStatusEffect(tpz.effect.SNEAK_ATTACK) and spell:isAoE() == 0 and params.attackType ~= tpz.attackType.RANGED and (caster:isBehind(target) or caster:hasStatusEffect(tpz.effect.HIDE))
    local taChar = (caster:hasStatusEffect(tpz.effect.TRICK_ATTACK) == true and spell:isAoE() == 0 and params.attackType ~= tpz.attackType.RANGED) and caster:getTrickAttackChar(target) or nil

    while hitsdone < params.numhits do
        if isSneakValid or math.random() < hitrate then
            local pdif = math.random((cratio[1]*1000), (cratio[2]*1000))
            local DBonusFromSA = 0
            pdif = pdif/1000

            if isSneakValid or math.random() < params.critchance then
                pdif = pdif + 0.7 -- force crit
                if isSneakValid and caster:getMainJob() == tpz.job.THF then
                    DBonusFromSA = caster:getStat(tpz.mod.DEX) * (1 + caster:getMod(tpz.mod.SNEAK_ATK_DEX)/100) * (100+(caster:getMod(tpz.mod.AUGMENTS_SA)))/100
                end
            end
            if taChar and caster:getMainJob() == tpz.job.THF and hitsdone == 0 then
                DBonusFromSA = DBonusFromSA + caster:getStat(tpz.mod.AGI) * (1 + caster:getMod(tpz.mod.TRICK_ATK_AGI)/100) * (100+(caster:getMod(tpz.mod.AUGMENTS_TA)))/100
            end

            if hitsdone == 0 then -- only the first hit benefits from multiplier
                finaldmg = finaldmg + (finalD + DBonusFromSA) * pdif
            else
                local correlmult = correl > 0 and 1.25 or (correl < 0 and 0.75 or 1.0) -- this still applies to multihits past the first, says bgwiki
                finaldmg = finaldmg + (math.floor(D + fStr + WSC)) * pdif * correlmult -- same as finalD but without multiplier (it should be 1.0)
            end

            hitslanded = hitslanded + 1
        end
        if params.attackType ~= tpz.attackType.RANGED then
            caster:delStatusEffect(tpz.effect.SNEAK_ATTACK)
            caster:delStatusEffect(tpz.effect.TRICK_ATTACK)
        end
        isSneakValid = false
        hitsdone = hitsdone + 1
    end
    caster:delStatusEffectsByFlag(tpz.effectFlag.DETECTABLE)
    --GetPlayerByID(1):PrintToPlayer(string.format("landed %u/%u hits ... hitrate was %u%% ... critchance was %u%%",hitslanded,hitsdone,hitrate*100,params.critchance*100))

    local h2hres = target:getMod(tpz.mod.H2HRES)
    local pierceres = target:getMod(tpz.mod.PIERCERES)
    local impactres = target:getMod(tpz.mod.IMPACTRES)
    local slashres = target:getMod(tpz.mod.SLASHRES)
    local spdefdown = target:getMod(tpz.mod.SPDEF_DOWN)

    if params.damageType == tpz.damageType.H2H then
        if h2hres < 1000 then
            finaldmg = finaldmg * (1 - ((1 - h2hres / 1000) * (1 - spdefdown/100)))
        else
            finaldmg = finaldmg * h2hres / 1000
        end
    elseif params.damageType == tpz.damageType.PIERCING then
        if pierceres < 1000 then
            finaldmg = finaldmg * (1 - ((1 - pierceres / 1000) * (1 - spdefdown/100)))
        else
            finaldmg = finaldmg * pierceres / 1000
        end
    elseif params.damageType == tpz.damageType.BLUNT then
        if impactres < 1000 then
            finaldmg = finaldmg * (1 - ((1 - impactres / 1000) * (1 - spdefdown/100)))
        else
            finaldmg = finaldmg * impactres / 1000
        end
    elseif params.damageType == tpz.damageType.SLASHING then
        if slashres < 1000 then
            finaldmg = finaldmg * (1 - ((1 - slashres / 1000) * (1 - spdefdown/100)))
        else
            finaldmg = finaldmg * slashres / 1000
        end
    end

    -- Circle Effects
    if target:isMob() and finaldmg > 0 then
        local ecoC = target:getSystem()
        local circlemult = 100
        local mod = 0

        if     ecoC == 1  then mod = 1226
        elseif ecoC == 2  then mod = 1228
        elseif ecoC == 3  then mod = 1232
        elseif ecoC == 6  then mod = 1230
        elseif ecoC == 8  then mod = 1225
        elseif ecoC == 9  then mod = 1234
        elseif ecoC == 10 then mod = 1233
        elseif ecoC == 14 then mod = 1227
        elseif ecoC == 16 then mod = 1238
        elseif ecoC == 15 then mod = 1237
        elseif ecoC == 17 then mod = 1229
        elseif ecoC == 19 then mod = 1231
        elseif ecoC == 20 then mod = 1224
        end

        if mod > 0 then
            circlemult = 100 + caster:getMod(mod)
        end

        finaldmg = math.floor(finaldmg * circlemult / 100)
    end
    
    if caster:hasStatusEffect(tpz.effect.SOLDIERS_DRINK) then
        finaldmg = finaldmg * 1.5
        caster:delStatusEffectSilent(tpz.effect.SOLDIERS_DRINK)
    end
    
    finaldmg = BlueApplyTargetDamageReductions(target, finaldmg)
    
    if finaldmg > 0 then target:addTPFromSpell(caster, hitslanded) end
    
    if (hitslanded == 0) then spell:setMsg(tpz.msg.basic.MAGIC_FAIL) end
    
    return finaldmg, hitslanded, taChar
end

function BlueMagicalSpell(caster, target, spell, params, statMod)
    local BLUlvl = caster:getMainJob() == tpz.job.BLU and caster:getMainLvl() or caster:getSubLvl()

    local D = BLUlvl + 2
    if params.D ~= nil then D = params.D end -- breath attacks calculate their own D.

    if D > params.duppercap then D = params.duppercap end

    local ST = BlueGetWsc(caster, params) -- Wiki: ST is the same as WSC, magical Blue mage spells are much like magical WS

    if caster:hasStatusEffect(tpz.effect.BURST_AFFINITY) then ST = ST * 2 end

    local convergence = caster:getStatusEffect(tpz.effect.CONVERGENCE)
    local convergenceBonus = convergence == nil and 1 or 1 + convergence:getPower()/100
    --print(string.format("cbonus = %f",convergenceBonus))

    local statBonus = 0
    local dStat = 0
    if statMod == INT_BASED then
        dStat = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
        statBonus = dStat * params.tMultiplier
    elseif statMod == CHR_BASED then
        dStat = caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR)
        statBonus = dStat * params.tMultiplier
    elseif statMod == MND_BASED then
        dStat = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
        statBonus = dStat * params.tMultiplier
    end

    D = ((D + ST) * params.multiplier * convergenceBonus) + statBonus

    local rparams = {}
    rparams.diff = dStat
    rparams.skillType = tpz.skill.BLUE_MAGIC
    rparams.bonus = convergence == nil and 0 or convergence:getPower()
    rparams.bonus = rparams.bonus + caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local res = applyResistance(caster, target, spell, rparams)
    D = math.floor(D * res)

    params.bonusmab = params.bonusmab == nil and 0 or params.bonusmab

    if params.eco ~= nil and target:isMob() then
        local correl = GetMonsterCorrelation(params.eco,GetTargetEcosystem(target))
        if correl > 0 then params.bonusmab = 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)
        elseif correl < 0 then params.bonusmab = -25 end
        --print(string.format("monster family correl bonus MAB was %i",params.bonusmab))
    end

    D = math.floor(addBonuses(caster, spell, target, D, params))
    
    if caster:hasStatusEffect(tpz.effect.SOLDIERS_DRINK) then
        D = D * 1.5
        caster:delStatusEffectSilent(tpz.effect.SOLDIERS_DRINK)
    end
    
    D = BlueApplyTargetDamageReductions(target, D)

    if params.attackType == tpz.attackType.BREATH then
        local head = caster:getEquipID(tpz.slot.HEAD)
        if head == 16150 or head == 11465 then D = math.floor(D*1.1) end -- saurian helm and Mirage Keffiyeh
    end

    if D > 0 then target:addTPFromSpell(caster) end
    caster:delStatusEffectSilent(tpz.effect.BURST_AFFINITY)

    return D
end

function BlueApplyTargetDamageReductions(target, dmg)
    dmg = dmg * BLUE_POWER
    dmg = dmg - target:getMod(tpz.mod.PHALANX)

    if dmg < 0 then dmg = 0 end

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    return dmg
end

function BlueFinalAdjustments(caster, target, spell, dmg, params, taChar)

    local attackType = params.attackType or tpz.attackType.NONE
    local damageType = params.damageType or tpz.damageType.NONE
    if attackType == tpz.attackType.MAGICAL or attackType == tpz.attackType.SPECIAL then
        dmg = target:magicDmgTaken(dmg)
    elseif attackType == tpz.attackType.RANGED then
        dmg = target:rangedDmgTaken(caster, dmg)
    elseif attackType == tpz.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(caster, dmg, damageType)
    end
    target:takeDamage(dmg, caster, attackType, damageType)
    local Emult = params.enmityPercent == nil and 1 or params.enmityPercent/100
    if not target:isPC() then
		if taChar == nil then
			target:updateEnmityFromDamage(caster,dmg*Emult)
		else
			target:updateEnmityFromDamage(taChar,dmg*Emult)
		end
	end
    target:handleAfflatusMiseryDamage(dmg)
    
    -- TP has already been dealt with.
    return dmg
end

------------------------------
-- Utility functions below ---
------------------------------

function BlueGetWsc(attacker, params)
    return (attacker:getStat(tpz.mod.STR) * params.str_wsc + attacker:getStat(tpz.mod.DEX) * params.dex_wsc +
        attacker:getStat(tpz.mod.VIT) * params.vit_wsc + attacker:getStat(tpz.mod.AGI) * params.agi_wsc +
        attacker:getStat(tpz.mod.INT) * params.int_wsc + attacker:getStat(tpz.mod.MND) * params.mnd_wsc +
        attacker:getStat(tpz.mod.CHR) * params.chr_wsc) * BlueGetAlpha(attacker:getMainLvl())
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function BluecRatio(ratio, atk_lvl, def_lvl, isRanged)
    local levelcor = 1 + (atk_lvl - def_lvl)*0.02
    if isRanged == true then levelcor = 1 + (atk_lvl - def_lvl)*0.01 end
    if levelcor > 1 then levelcor = 1
    elseif levelcor < 0.2 then levelcor = 0.2 end
    ratio = ratio * levelcor
    ratio = utils.clamp(ratio, 0, 4.0)
    --print(string.format("blue cratio = %f",ratio))

    local pdifmin = 0
    local pdifmax = 0

    pdifmax = ratio * 1.25
	if pdifmax < 0.15 then
		pdifmax = 0.15
	end

    pdifmin = pdifmax * 0.675 + 1/6
    if pdifmax > 2.75 then
        pdifmax = 2.75
    end
    if pdifmin > pdifmax - 0.1 then
        pdifmin = pdifmax - 0.1
    end

    --print(pdifmin)
    --print(pdifmax)

    local cratio = {}
    cratio[1] = pdifmin
    cratio[2] = pdifmax
    return cratio
end

-- Gets the fTP multiplier by applying 2 straight lines between ftp1-ftp2 and ftp2-ftp3
-- tp - The current TP
-- ftp1 - The TP 0% value
-- ftp2 - The TP 150% value
-- ftp3 - The TP 300% value
function BluefTP(tp, ftp1, ftp2, ftp3)
    if tp == nil or ftp1 == nil or ftp2 == nil or ftp3 == nil then return 1 end
    if tp <= 1500 then -- 0 to 1500
        return ftp1 + (ftp2 - ftp1) * (tp / 1500)
    else -- 1500 to 3000
        return ftp2 + (ftp3 - ftp2) * ((tp-1500) / 1500)
    end
end

function BluefSTR(dSTR)
    local fSTR2 = 0

    if     dSTR >= 12  then fSTR2 = (dSTR+4)/2
    elseif dSTR >= 6   then fSTR2 = (dSTR+6)/2
    elseif dSTR >= 1   then fSTR2 = (dSTR+7)/2
    elseif dSTR >= -2  then fSTR2 = (dSTR+8)/2
    elseif dSTR >= -7  then fSTR2 = (dSTR+9)/2
    elseif dSTR >= -15 then fSTR2 = (dSTR+10)/2
    elseif dSTR >= -21 then fSTR2 = (dSTR+12)/2
    else                    fSTR2 = (dSTR+13)/2 end

    if fSTR2 > 12 then fSTR2 = 12 end -- dSTR caps once you have more than 20 STR than the mob's VIT (equivalent to having a weapon rank 4)
    if fSTR2 < -4 then fSTR2 = -4 end -- and the lower bound will be met at 20 STR *under* the mob's VIT
    return math.floor(fSTR2)
end

function BlueGetHitRate(attacker, target, capHitRate, bonusacc)
    local acc = attacker:getACC() + attacker:getMerit(tpz.merit.PHYSICAL_POTENCY) + (attacker:getMainLvl()-target:getMainLvl())*4 + bonusacc
    local eva = target:getEVA()

    local hitrate = 75 + (acc-eva)/2
    hitrate = hitrate/100

    if capHitRate then -- dont cap when acc varies with tp, as more penalties are due
        if     hitrate > 0.95 then hitrate = 0.95
        elseif hitrate < 0.20 then hitrate = 0.20 end
    end
    return hitrate
end

-- obtains alpha, used for working out WSC
function BlueGetAlpha(level)
    local alpha = 1.00
    if (level <= 5) then
        alpha = 1.00
    elseif (level <= 11) then
        alpha = 0.99
    elseif (level <= 17) then
        alpha = 0.98
    elseif (level <= 23) then
        alpha = 0.97
    elseif (level <= 29) then
        alpha = 0.96
    elseif (level <= 35) then
        alpha = 0.95
    elseif (level <= 41) then
        alpha = 0.94
    elseif (level <= 47) then
        alpha = 0.93
    elseif (level <= 53) then
        alpha = 0.92
    elseif (level <= 59) then
        alpha = 0.91
    elseif (level <= 61) then
        alpha = 0.90
    elseif (level <= 63) then
        alpha = 0.89
    elseif (level <= 65) then
        alpha = 0.88
    elseif (level <= 67) then
        alpha = 0.87
    elseif (level <= 69) then
        alpha = 0.86
    elseif (level <= 71) then
        alpha = 0.85
    elseif (level <= 73) then
        alpha = 0.84
    elseif (level <= 75) then
        alpha = 0.83
    elseif (level <= 99) then
        alpha = 0.85
    end
    return alpha
end

