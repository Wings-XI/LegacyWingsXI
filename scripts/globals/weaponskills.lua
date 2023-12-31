-- Contains all common weaponskill calculations including but not limited to:
-- fSTR
-- Alpha
-- Ratio -> cRatio
-- min/max cRatio
-- applications of fTP
-- applications of critical hits ('Critical hit rate varies with TP.')
-- applications of accuracy mods ('Accuracy varies with TP.')
-- applications of damage mods ('Damage varies with TP.')
-- performance of the actual WS (rand numbers, etc)
require("scripts/globals/magicburst")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")

-- Function to calculate if a hit in a WS misses, criticals, and the respective damage done
-- dmg parameter is ( D + fSTR + WSC) * fTP, also sometimes referred to as WD
function getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, isRanged)
    local criticalHit = false
    local finaldmg = 0
 
    local testEntity = attacker
    if not attacker:isPC() and attacker:isPet() and (attacker:getMaster()):isPC() then
        testEntity = attacker:getMaster()
    end

    local hitrate = calcParams.hitRate
    if calcParams.firstHitRateBonus and calcParams.melee == true and (calcParams.useOAXTimes == nil or calcParams.useOAXTimes == false) then -- jumps do not get this acc bonus
        hitrate = hitrate + calcParams.firstHitRateBonus/100
    end
    if hitrate > 0.95 then
        hitrate = 0.95
    elseif hitrate < 0.20 then
        hitrate = 0.20
    end

    local missChance = math.random()
    --testEntity:PrintToPlayer(string.format("acc was %i",hitrate*100))
    if ((missChance <= hitrate) -- See if we hit the target
    or calcParams.guaranteedHit
    or (calcParams.melee and math.random() < attacker:getMod(tpz.mod.ZANSHIN)/100))
    and not calcParams.mustMiss then
        if not shadowAbsorb(target) then
            local critChance = math.random() -- See if we land a critical hit
            criticalHit = (wsParams.canCrit and critChance <= calcParams.critRate) or calcParams.forcedFirstCrit or calcParams.mightyStrikesApplicable
            if criticalHit == true then
                calcParams.criticalHit = true
                calcParams.pdif = generatePdif(calcParams.ccritratio[1], calcParams.ccritratio[2], isRanged)
            else
                calcParams.pdif = generatePdif(calcParams.cratio[1], calcParams.cratio[2], isRanged)
            end
            -- attacker:PrintToPlayer(string.format("final pdif %f", calcParams.pdif))
            finaldmg = dmg * calcParams.pdif

            -- Duplicate the first hit with an added magical component for hybrid WSes
            if calcParams.hybridHit == true then
                -- Calculate magical bonuses and reductions
                local magicdmg = addBonusesAbility(attacker, wsParams.ele, target, finaldmg, wsParams)
                magicdmg = magicdmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, calcParams.bonusAcc)
                magicdmg = target:magicDmgTaken(magicdmg)
                magicdmg = adjustForTarget(target, magicdmg, wsParams.ele)

                finaldmg = finaldmg + magicdmg
            end
            -- if criticalHit == false then
                --testEntity:PrintToPlayer(string.format("non-critical WS hit for %i",finaldmg))
            -- else
                --testEntity:PrintToPlayer(string.format("CRITICAL WS hit for %i !!",finaldmg))
            -- end

            calcParams.hitsLanded = calcParams.hitsLanded + 1
        else
            calcParams.shadowsAbsorbed = calcParams.shadowsAbsorbed + 1
        end
    end

    return finaldmg, calcParams
end


function getDexCritBonus(dDEX)
    local nativeCrit = 0
    if dDEX > 50 then -- Caps at 15% maximum benefit from dDEX
        nativeCrit = 0.15
    elseif (dDEX > 39) then
        nativeCrit = (dDEX-35)/100
    elseif (dDEX > 29) then
        nativeCrit = 0.04
    elseif (dDEX > 19) then
        nativeCrit = 0.03
    elseif (dDEX > 13) then
        nativeCrit = 0.02
    elseif (dDEX > 6) then
        nativeCrit = 0.01
    end
    return nativeCrit
end

-- Calculates the raw damage for a weaponskill, used by both doPhysicalWeaponskill and doRangedWeaponskill.
-- Behavior of damage calculations can vary based on the passed in calcParams, which are determined by the calling function
-- depending on the type of weaponskill being done, and any special cases for that weaponskill
--
-- wsParams can contain: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300,
-- acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atk100, atk200, atk300, kick, hybridWS, hitsHigh, formless
--
-- See doPhysicalWeaponskill or doRangedWeaponskill for how calcParams are determined.
function calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams, isRanged)

    -- Recalculate accuracy if it varies with TP, applied to all hits
    if wsParams.acc100 ~= 0 then
        calcParams.hitRate = accVariesWithTP(calcParams.hitRate, calcParams.accStat, tp, wsParams.acc100, wsParams.acc200, wsParams.acc300)
    end

    -- Calculate alpha, WSC, and our modifiers for our base per-hit damage
    if not calcParams.alpha then
        if USE_ADOULIN_WEAPON_SKILL_CHANGES then
            calcParams.alpha = 1
        else
            calcParams.alpha = getAlpha(attacker:getMainLvl())
        end
    end

    -- Begin Checks for bonus wsc bonuses. See the following for details:
    -- https://www.bg-wiki.com/bg/Utu_Grip
    -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

    if attacker:getMod(tpz.mod.WS_STR_BONUS) > 0 then
        wsParams.str_wsc = wsParams.str_wsc + (attacker:getMod(tpz.mod.WS_STR_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_DEX_BONUS) > 0 then
        wsParams.dex_wsc = wsParams.dex_wsc + (attacker:getMod(tpz.mod.WS_DEX_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_VIT_BONUS) > 0 then
        wsParams.vit_wsc = wsParams.vit_wsc + (attacker:getMod(tpz.mod.WS_VIT_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_AGI_BONUS) > 0 then
        wsParams.agi_wsc = wsParams.agi_wsc + (attacker:getMod(tpz.mod.WS_AGI_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_INT_BONUS) > 0 then
        wsParams.int_wsc = wsParams.int_wsc + (attacker:getMod(tpz.mod.WS_INT_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_MND_BONUS) > 0 then
        wsParams.mnd_wsc = wsParams.mnd_wsc + (attacker:getMod(tpz.mod.WS_MND_BONUS) / 100)
    end

    if attacker:getMod(tpz.mod.WS_CHR_BONUS) > 0 then
        wsParams.chr_wsc = wsParams.chr_wsc + (attacker:getMod(tpz.mod.WS_CHR_BONUS) / 100)
    end

    local wsMods = calcParams.fSTR +
        (attacker:getStat(tpz.mod.STR) * wsParams.str_wsc + attacker:getStat(tpz.mod.DEX) * wsParams.dex_wsc +
         attacker:getStat(tpz.mod.VIT) * wsParams.vit_wsc + attacker:getStat(tpz.mod.AGI) * wsParams.agi_wsc +
         attacker:getStat(tpz.mod.INT) * wsParams.int_wsc + attacker:getStat(tpz.mod.MND) * wsParams.mnd_wsc +
         attacker:getStat(tpz.mod.CHR) * wsParams.chr_wsc) * calcParams.alpha
    -- (D + fSTR + WSC)
    local mainBase = calcParams.weaponDamage[1] + wsMods + calcParams.bonusWSmods
    
    -- Calculate fTP multiplier
    local ftp = fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + calcParams.bonusfTP

    -- Calculate critrates
    local critRate = 0

    if wsParams.canCrit then -- Work out critical hit ratios
        local nativecrit = 0.05
        critRate = fTP(tp, wsParams.crit100, wsParams.crit200, wsParams.crit300)

        if isRanged then -- use dAGI
            local dAGI = (attacker:getStat(tpz.mod.AGI) - target:getStat(tpz.mod.AGI))
            if dAGI > 0 then
                nativecrit = nativecrit + math.floor(dAGI/10)/100 -- no known cap
            end
        else
            local dDEX = (attacker:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI))
            nativecrit = nativecrit + getDexCritBonus(dDEX)
        end
        -- Always minimum 5% native crit
        if nativecrit < 0.05 then
            nativecrit = 0.05
        end

        local fencerBonus = calcParams.fencerBonus or 0
        nativecrit = nativecrit + attacker:getMod(tpz.mod.CRITHITRATE)/100 + attacker:getMerit(tpz.merit.CRIT_HIT_RATE)/100
                                + fencerBonus - target:getMerit(tpz.merit.ENEMY_CRIT_RATE)/100

        -- Innin critical boost when attacker is behind target
        if (attacker:hasStatusEffect(tpz.effect.INNIN) and attacker:isBehind(target, 23)) then
            nativecrit = nativecrit + attacker:getStatusEffect(tpz.effect.INNIN):getPower()
        end

        -- attacker:PrintToPlayer(string.format("native crit rate was %d", nativecrit*100))

        critRate = critRate + nativecrit

        if calcParams.flourishEffect and calcParams.flourishEffect:getPower() > 2 then
             critRate = critRate + 0.10 + calcParams.flourishEffect:getSubPower()/100
        end
    end
    calcParams.critRate = critRate

    -- Start the WS
    local hitdmg = 0
    local finaldmg = 0
    calcParams.hitsLanded = 0
    calcParams.shadowsAbsorbed = 0

    -- Calculate the damage from the first hit
    local dmg = math.floor(mainBase * ftp)
    hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, isRanged)
    finaldmg = finaldmg + hitdmg

    -- Have to calculate added bonus for SA/TA here since it is done outside of the fTP multiplier
    if attacker:getMainJob() == tpz.job.THF then
        -- Add DEX/AGI bonus to first hit if THF main and valid Sneak/Trick Attack
        if calcParams.sneakApplicable then
            finaldmg = finaldmg +
                        (attacker:getStat(tpz.mod.DEX) * (1 + attacker:getMod(tpz.mod.SNEAK_ATK_DEX)/100) * calcParams.pdif) *
                        ((100+(attacker:getMod(tpz.mod.AUGMENTS_SA)))/100)
        end
        if calcParams.trickApplicable then
            finaldmg = finaldmg +
                        (attacker:getStat(tpz.mod.AGI) * (1 + attacker:getMod(tpz.mod.TRICK_ATK_AGI)/100) * calcParams.pdif) *
                        ((100+(attacker:getMod(tpz.mod.AUGMENTS_TA)))/100)
        end
    end

    -- We've now accounted for any crit from SA/TA, or damage bonus for a Hybrid WS, so nullify them
    calcParams.forcedFirstCrit = false
    calcParams.hybridHit = false
    calcParams.firstHitRateBonus = 0

    -- For items that apply bonus damage to the first hit of a weaponskill (but not later hits),
    -- store bonus damage for first hit, for use after other calculations are done
    local firstHitBonus = ((finaldmg * attacker:getMod(tpz.mod.ALL_WSDMG_FIRST_HIT))/100)

    -- Reset fTP if it's not supposed to carry over across all hits for this WS
    if not wsParams.multiHitfTP then ftp = 1 end -- We'll recalculate our mainhand damage after doing offhand

    -- Do the extra hit for our offhand if applicable
    if calcParams.melee == true and calcParams.extraOffhandHit == true then
        local offhandDmg = (calcParams.weaponDamage[2] + wsMods) * ftp
        hitdmg, calcParams = getSingleHitDamage(attacker, target, offhandDmg, wsParams, calcParams, isRanged)
        finaldmg = finaldmg + hitdmg
    end

    calcParams.guaranteedHit = false -- Accuracy bonus from SA/TA applies only to first main and offhand hit
    calcParams.tpHitsLanded = calcParams.hitsLanded -- Store number of TP hits that have landed thus far
    calcParams.hitsLanded = 0 -- Reset counter to start tracking additional hits (from WS or Multi-Attacks)

    -- Calculate additional hits if a multiHit WS (or we're supposed to get a DA/TA/QA proc from main hit)
    dmg = mainBase * ftp
    -- Only get an additional offHand hit with H2H if the numHits == 1 
    -- "Note that Hand-to-Hand weaponskills' listed hits do include the offhand hit. However, if a weaponskill does not list multiple hits, it still has an additional offhand hit."
    -- see "hits" column: https://wiki-ffo-jp.translate.goog/html/19049.html?_x_tr_sch=http&_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=it&_x_tr_pto=wapp
    -- basically h2h always gets 2 "initial" hits, but `numHits` is hard respected for the extra hits
    -- whereas dual widling gets 2 "initial" hits, but `numHits` e.g. dancing edge is respected as though only one "initial" was performed 
    -- tl;dr: DW gives an extra WS hit everytime, H2H simply ensures every WS gets at least 2 hits (yes backhand blow and dragon kick are both 2-hit ws...)
    -- WINGSTODO Fix upstream
    local hitsDone = attacker:getWeaponSkillType(tpz.slot.MAIN) == tpz.skill.HAND_TO_HAND and 2 or 1
    local offHitsDone = 0
    local numHits, numOffhandHits = getMultiAttacks(attacker, target, wsParams.numHits, wsParams.useOAXTimes, calcParams.melee)
    calcParams.useOAXTimes = wsParams.useOAXTimes

    while (hitsDone < numHits) do -- numHits is hits in the base WS _and_ DA/TA/QA procs during those hits
        hitdmg, calcParams = getSingleHitDamage(attacker, target, dmg, wsParams, calcParams, isRanged)
        finaldmg = finaldmg + hitdmg
        hitsDone = hitsDone + 1
    end
    calcParams.extraHitsLanded = calcParams.hitsLanded
    calcParams.hitsLanded = 0
    while (offHitsDone < numOffhandHits) do
        local offhandDmg = (calcParams.weaponDamage[2] + wsMods) * ftp
        hitdmg, calcParams = getSingleHitDamage(attacker, target, offhandDmg, wsParams, calcParams, isRanged)
        finaldmg = finaldmg + hitdmg
        offHitsDone = offHitsDone + 1
        --print("offhand while loop")
    end
    calcParams.extraHitsLanded = calcParams.extraHitsLanded + calcParams.hitsLanded

    -- Apply Souleater bonus
    if calcParams.melee then -- souleaterBonus() checks for the effect inside itself
        finaldmg = finaldmg + souleaterBonus(attacker, (calcParams.tpHitsLanded+calcParams.extraHitsLanded))
    end

    -- Factor in "all hits" bonus damage mods
    local bonusdmg = attacker:getMod(tpz.mod.ALL_WSDMG_ALL_HITS) -- For any WS
    if (attacker:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0) then -- For specific WS
        bonusdmg = bonusdmg + attacker:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
    end

    finaldmg = finaldmg * ((100 + bonusdmg)/100) -- Apply our "all hits" WS dmg bonuses
    finaldmg = finaldmg + firstHitBonus -- Finally add in our "first hit" WS dmg bonus from before

    -- Return our raw damage to then be modified by enemy reductions based off of melee/ranged
    calcParams.finalDmg = finaldmg
    return calcParams
end

-- Sets up the necessary calcParams for a melee WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to takeWeaponskillDamage.
function doPhysicalWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg, taChar)

    -- Determine cratio and ccritratio
    local ignoredDef = 0
    if wsParams.ignoresDef ~= nil and wsParams.ignoresDef == true then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(tpz.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end

    local attPercentBonus = 0

    local cratio = cMeleeRatio(attacker, target, wsParams, ignoredDef, tp, false)
    local ccritratio = cMeleeRatio(attacker, target, wsParams, ignoredDef, tp, true)

    -- Set up conditions and wsParams used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = tpz.attackType.PHYSICAL,
        ['slot'] = tpz.slot.MAIN,
        ['weaponType'] = attacker:getWeaponSkillType(tpz.slot.MAIN),
        ['damageType'] = attacker:getWeaponDamageType(tpz.slot.MAIN)
    }
    local calcParams = {}
    calcParams.weaponDamage = getMeleeDmg(attacker, attack.weaponType, wsParams.kick)
    calcParams.fSTR = fSTR(attacker:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT), attacker:getWeaponDmgRank())
    calcParams.cratio = cratio
    calcParams.ccritratio = ccritratio
    calcParams.accStat = attacker:getACC()
    calcParams.melee = true
    calcParams.mustMiss = target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or
                          (target:hasStatusEffect(tpz.effect.TOO_HIGH) and not wsParams.hitsHigh)
    calcParams.sneakApplicable = attacker:hasStatusEffect(tpz.effect.SNEAK_ATTACK) and
                                 (attacker:isBehind(target) or attacker:hasStatusEffect(tpz.effect.HIDE) or
                                 target:hasStatusEffect(tpz.effect.DOUBT))
    calcParams.taChar = taChar
    calcParams.trickApplicable = calcParams.taChar ~= nil
    calcParams.assassinApplicable = calcParams.trickApplicable and attacker:hasTrait(68)
    calcParams.guaranteedHit = calcParams.sneakApplicable or calcParams.trickApplicable
    calcParams.mightyStrikesApplicable = attacker:hasStatusEffect(tpz.effect.MIGHTY_STRIKES)
    calcParams.forcedFirstCrit = calcParams.sneakApplicable or calcParams.assassinApplicable
    calcParams.extraOffhandHit = attacker:isDualWielding() or attack.weaponType == tpz.skill.HAND_TO_HAND
    calcParams.hybridHit = wsParams.hybridWS
     -- various job abilities are abusing this ws function, don't boost them or remove building flourish
    calcParams.flourishEffect = wsParams.preserveBuildingFlourish == nil and attacker:getStatusEffect(tpz.effect.BUILDING_FLOURISH) or nil
    calcParams.fencerBonus = fencerBonus(attacker)
    calcParams.bonusTP = wsParams.bonusTP or 0
    calcParams.bonusfTP = gorgetBeltFTP or 0
    calcParams.bonusAcc = (gorgetBeltAcc or 0) + attacker:getMod(tpz.mod.WSACC)
    calcParams.bonusWSmods = wsParams.bonusWSmods or 0
    
    if (wsID == 0) then
        calcParams.firstHitRateBonus = 0
    else
        calcParams.firstHitRateBonus = 50
    end

    if calcParams.flourishEffect ~= nil then
         calcParams.bonusAcc = calcParams.bonusAcc + 40 + calcParams.flourishEffect:getSubPower()*2 
    end

    calcParams.hitRate = getHitRate(attacker, target, false, calcParams.bonusAcc)

    -- Send our wsParams off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams, false)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(tpz.effectFlag.ATTACK)
    if wsParams.preserveBuildingFlourish == nil then attacker:delStatusEffectSilent(tpz.effect.BUILDING_FLOURISH) end

    local h2hres = target:getMod(tpz.mod.H2HRES)
    local pierceres = target:getMod(tpz.mod.PIERCERES)
    local impactres = target:getMod(tpz.mod.IMPACTRES)
    local slashres = target:getMod(tpz.mod.SLASHRES)
    local spdefdown = target:getMod(tpz.mod.SPDEF_DOWN)

    if not wsParams.formless then
        finaldmg = target:physicalDmgTaken(attacker, finaldmg, attack.damageType)
        -- WINGSCUSTOM
        -- using damageType so that ws dmg type follows modified weapon type (joyeuse, birdbanes, etc)
        if attack.damageType == tpz.damageType.H2H then
            if h2hres < 1000 then
                finaldmg = finaldmg * (1 - ((1 - h2hres / 1000) * (1 - spdefdown/100)))
            else
                finaldmg = finaldmg * h2hres / 1000
            end
        elseif attack.damageType == tpz.damageType.PIERCING then
            if pierceres < 1000 then
                finaldmg = finaldmg * (1 - ((1 - pierceres / 1000) * (1 - spdefdown/100)))
            else
                finaldmg = finaldmg * pierceres / 1000
            end
        elseif attack.damageType == tpz.damageType.BLUNT then
            if impactres < 1000 then
                finaldmg = finaldmg * (1 - ((1 - impactres / 1000) * (1 - spdefdown/100)))
            else
                finaldmg = finaldmg * impactres / 1000
            end
        else
            if slashres < 1000 then
                finaldmg = finaldmg * (1 - ((1 - slashres / 1000) * (1 - spdefdown/100)))
            else
                finaldmg = finaldmg * slashres / 1000
            end
        end
    end

    -- Circle Effects
    if target:isMob() and finaldmg > 0 then
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

        if mod > 0 then
            circlemult = 100 + attacker:getMod(mod)
        end

        finaldmg = math.floor(finaldmg * circlemult / 100)
    end

    if wsParams.useAutoTPFormula == nil or wsParams.useAutoTPFormula == 0 then
        finaldmg = finaldmg * WEAPON_SKILL_POWER * 1.0
    end

    finaldmg = finaldmg * WEAPON_SKILL_POWER
    calcParams.finalDmg = finaldmg
    finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    -- attacker:PrintToPlayer(string.format("ws hits landed: tphits %u, extrahits %u", calcParams.tpHitsLanded, calcParams.extraHitsLanded))
    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end


-- Sets up the necessary calcParams for a ranged WS before passing it to calculateRawWSDmg. When the raw
-- damage is returned, handles reductions based on target resistances and passes off to takeWeaponskillDamage.
 function doRangedWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg)

    -- Determine cratio and ccritratio
    local ignoredDef = 0
    if (wsParams.ignoresDef == not nil and wsParams.ignoresDef == true) then
        ignoredDef = calculatedIgnoredDef(tp, target:getStat(tpz.mod.DEF), wsParams.ignored100, wsParams.ignored200, wsParams.ignored300)
    end
    local cratio = cRangedRatio(attacker, target, wsParams, ignoredDef, tp, false)
    local ccritratio = cRangedRatio(attacker, target, wsParams, ignoredDef, tp, true)

    -- Set up conditions and params used for calculating weaponskill damage
    local gorgetBeltFTP, gorgetBeltAcc = handleWSGorgetBelt(attacker)
    local attack =
    {
        ['type'] = tpz.attackType.RANGED,
        ['slot'] = tpz.slot.RANGED,
        ['weaponType'] = attacker:getWeaponSkillType(tpz.slot.RANGED),
        ['damageType'] = attacker:getWeaponDamageType(tpz.slot.RANGED)
    }
    local calcParams =
    {
        weaponDamage = {attacker:getRangedDmg()},
        fSTR = fSTR2(attacker:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT), attacker:getRangedDmgRank()),
        cratio = cratio,
        ccritratio = ccritratio,
        accStat = attacker:getRACC(),
        melee = false,
        mustMiss = false,
        sneakApplicable = false,
        trickApplicable = false,
        assassinApplicable = false,
        mightyStrikesApplicable = false,
        forcedFirstCrit = false,
        extraOffhandHit = false,
        flourishEffect = nil,
        fencerBonus = fencerBonus(attacker),
        bonusTP = wsParams.bonusTP or 0,
        bonusfTP = gorgetBeltFTP or 0,
        bonusAcc = (gorgetBeltAcc or 0) + attacker:getMod(tpz.mod.WSACC),
        bonusWSmods = wsParams.bonusWSmods or 0
    }

    if attacker:hasStatusEffect(tpz.effect.FLASHY_SHOT) == true then
        calcParams.accStat = calcParams.accStat + 20
    end

    calcParams.firstHitRateBonus = 0

    if calcParams.flourishEffect ~= nil then
        calcParams.bonusAcc = calcParams.bonusAcc + 20 + calcParams.flourishEffect:getSubPower()*2 
    end

    calcParams.hitRate = getHitRate(attacker, target, false, calcParams.bonusAcc, true)

    -- Send our params off to calculate our raw WS damage, hits landed, and shadows absorbed
    calcParams = calculateRawWSDmg(attacker, target, wsID, tp, action, wsParams, calcParams, true)
    local finaldmg = calcParams.finalDmg

    -- Delete statuses that may have been spent by the WS
    attacker:delStatusEffectsByFlag(tpz.effectFlag.ATTACK)
    attacker:delStatusEffectSilent(tpz.effect.BUILDING_FLOURISH)

    -- Calculate reductions
    finaldmg = target:rangedDmgTaken(attacker, finaldmg)
    local pierceres = target:getMod(tpz.mod.PIERCERES)
    local spdefdown = target:getMod(tpz.mod.SPDEF_DOWN)
    if pierceres < 1000 then
        finaldmg = finaldmg * (1 - ((1 - pierceres / 1000) * (1 - spdefdown/100)))
    else
        finaldmg = finaldmg * pierceres / 1000
    end

    -- Circle Effects
    if target:isMob() and finaldmg > 0 then
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

        if mod > 0 then
            circlemult = 100 + attacker:getMod(mod)
        end

        finaldmg = math.floor(finaldmg * circlemult / 100)
    end
    

    finaldmg = finaldmg * WEAPON_SKILL_POWER
    calcParams.finalDmg = finaldmg
    finaldmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    attacker:delStatusEffect(tpz.effect.FLASHY_SHOT)
    attacker:delStatusEffect(tpz.effect.STEALTH_SHOT)

    return finaldmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- params: ftp100, ftp200, ftp300, wsc_str, wsc_dex, wsc_vit, wsc_agi, wsc_int, wsc_mnd, wsc_chr,
--         ele (tpz.magic.ele.FIRE), skill (tpz.skill.STAFF)

function doMagicWeaponskill(attacker, target, wsID, wsParams, tp, action, primaryMsg, mythicMagicWsParams)

    -- Set up conditions and wsParams used for calculating weaponskill damage
    local attack

    if wsParams.skill == tpz.skill.MARKSMANSHIP or wsParams.skill == tpz.skill.ARCHERY then
        attack =
        {
            ['type'] = tpz.attackType.MAGICAL,
            ['slot'] = tpz.slot.RANGED,
            ['weaponType'] = attacker:getWeaponSkillType(tpz.slot.RANGED),
            ['damageType'] = tpz.damageType.ELEMENTAL + wsParams.ele
        }
    else
        attack =
        {
            ['type'] = tpz.attackType.MAGICAL,
            ['slot'] = tpz.slot.MAIN,
            ['weaponType'] = attacker:getWeaponSkillType(tpz.slot.MAIN),
            ['damageType'] = tpz.damageType.ELEMENTAL + wsParams.ele
        }
    end

    local calcParams =
    {
        ['shadowsAbsorbed'] = 0,
        ['tpHitsLanded'] = 1,
        ['extraHitsLanded'] = 0,
        ['bonusTP'] = wsParams.bonusTP or 0,
        ['flourishEffect'] = wsParams.preserveBuildingFlourish == nil and attacker:getStatusEffect(tpz.effect.BUILDING_FLOURISH) or nil -- various job abilities are abusing this ws function, don't boost them or remove building flourish
    }

    -- Delete statuses that may have been spent by the WS
    if wsParams.preserveBuildingFlourish == nil then attacker:delStatusEffectSilent(tpz.effect.BUILDING_FLOURISH) end
    
    local bonusfTP, bonusacc = handleWSGorgetBelt(attacker)
    -- There is an assumed +100 macc bonus for magical weaponskills
    -- https://www.bg-wiki.com/ffxi/Category:Elemental_Weapon_Skill
    -- While this is very difficult to prove, the consistency of Trueflight, Leaden Salute, and Primal Rend (among others) supports this
    bonusacc = bonusacc + attacker:getMod(tpz.mod.WSACC) + 100
    
    local fint = utils.clamp(8 + (attacker:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)), -32, 32)
    local dmg = 0

    -- Magic-based WSes never miss, so we don't need to worry about calculating a miss, only if a shadow absorbed it.
    if not shadowAbsorb(target) then

        -- Begin Checks for bonus wsc bonuses. See the following for details:
        -- https://www.bg-wiki.com/bg/Utu_Grip
        -- https://www.bluegartr.com/threads/108199-Random-Facts-Thread-Other?p=6826618&viewfull=1#post6826618

        if attacker:getMod(tpz.mod.WS_STR_BONUS) > 0 then
            wsParams.str_wsc = wsParams.str_wsc + (attacker:getMod(tpz.mod.WS_STR_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_DEX_BONUS) > 0 then
            wsParams.dex_wsc = wsParams.dex_wsc + (attacker:getMod(tpz.mod.WS_DEX_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_VIT_BONUS) > 0 then
            wsParams.vit_wsc = wsParams.vit_wsc + (attacker:getMod(tpz.mod.WS_VIT_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_AGI_BONUS) > 0 then
            wsParams.agi_wsc = wsParams.agi_wsc + (attacker:getMod(tpz.mod.WS_AGI_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_INT_BONUS) > 0 then
            wsParams.int_wsc = wsParams.int_wsc + (attacker:getMod(tpz.mod.WS_INT_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_MND_BONUS) > 0 then
            wsParams.mnd_wsc = wsParams.mnd_wsc + (attacker:getMod(tpz.mod.WS_MND_BONUS) / 100)
        end

        if attacker:getMod(tpz.mod.WS_CHR_BONUS) > 0 then
            wsParams.chr_wsc = wsParams.chr_wsc + (attacker:getMod(tpz.mod.WS_CHR_BONUS) / 100)
        end

        dmg = attacker:getMainLvl() + 2 + (attacker:getStat(tpz.mod.STR) * wsParams.str_wsc + attacker:getStat(tpz.mod.DEX) * wsParams.dex_wsc +
             attacker:getStat(tpz.mod.VIT) * wsParams.vit_wsc + attacker:getStat(tpz.mod.AGI) * wsParams.agi_wsc +
             attacker:getStat(tpz.mod.INT) * wsParams.int_wsc + attacker:getStat(tpz.mod.MND) * wsParams.mnd_wsc +
             attacker:getStat(tpz.mod.CHR) * wsParams.chr_wsc)

        -- Applying fTP multiplier
        -- ftp doesnt multiply fInt (dStat), it multiplies 
        local ftp = fTP(tp, wsParams.ftp100, wsParams.ftp200, wsParams.ftp300) + bonusfTP
        dmg = dmg * ftp

        -- mythic weapons use: D value = (77 + status correction) x magnification + (own step A-enemy step B) x system magnification
        -- Source: bgwiki and https://w.atwiki.jp/studiogobli/pages/77.html
        if (mythicMagicWsParams) then
            local attackerStat = mythicMagicWsParams.attackerStat
            local defenderStat = mythicMagicWsParams.defenderStat
            local magnification = mythicMagicWsParams.magnification
            dmg = dmg + ((attacker:getStat(attackerStat) - target:getStat(defenderStat)) * magnification)
        else
            dmg = dmg + fint
        end

        -- Factor in "all hits" bonus damage mods
        local bonusdmg = attacker:getMod(tpz.mod.ALL_WSDMG_ALL_HITS) -- For any WS
        if (attacker:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID) > 0) then -- For specific WS
            bonusdmg = bonusdmg + attacker:getMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE + wsID)
        end

        -- Add in bonusdmg
        dmg = dmg * ((100 + bonusdmg)/100) -- Apply our "all hits" WS dmg bonuses
        dmg = dmg + ((dmg * attacker:getMod(tpz.mod.ALL_WSDMG_FIRST_HIT))/100) -- Add in our "first hit" WS dmg bonus

        -- Calculate magical bonuses and reductions
        dmg = addBonusesAbility(attacker, wsParams.ele, target, dmg, wsParams)
        dmg = dmg * applyResistanceAbility(attacker, target, wsParams.ele, wsParams.skill, bonusacc)
        dmg = target:magicDmgTaken(dmg)
        dmg = adjustForTarget(target, dmg, wsParams.ele)

        
        --https://www.bluegartr.com/threads/79254-Circle-Testing/page2
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

            if mod > 0 then
                circlemult = 100 + attacker:getMod(mod)
            end

            dmg = math.floor(dmg * circlemult / 100)
        end

        dmg = dmg * WEAPON_SKILL_POWER -- Add server bonus
    else
        calcParams.shadowsAbsorbed = 1
    end
    
    calcParams.finalDmg = dmg
    dmg = takeWeaponskillDamage(target, attacker, wsParams, primaryMsg, attack, calcParams, action)
    return dmg, calcParams.criticalHit, calcParams.tpHitsLanded, calcParams.extraHitsLanded, calcParams.shadowsAbsorbed
end

-- After WS damage is calculated and damage reduction has been taken into account by the calling function,
-- handles displaying the appropriate action/message, delivering the damage to the mob, and any enmity from it
function takeWeaponskillDamage(defender, attacker, wsParams, primaryMsg, attack, wsResults, action)
    local finaldmg = wsResults.finalDmg
    local targetTPMult = wsParams.targetTPMult or 1
    local useAutoTPFormula = wsParams.useAutoTPFormula or 0
    local passedBonusTP = wsResults.extraHitsLanded * 10 + wsResults.bonusTP
    if useAutoTPFormula ~= 0 then
        passedBonusTP = wsResults.extraHitsLanded
    end
    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attack.type, attack.damageType, attack.slot, primaryMsg, wsResults.tpHitsLanded, passedBonusTP, targetTPMult, useAutoTPFormula)
    if wsResults.tpHitsLanded + wsResults.extraHitsLanded > 0 then
        if finaldmg >= 0 then
            if primaryMsg then
                action:messageID(defender:getID(), tpz.msg.basic.DAMAGE)
            else
                action:messageID(defender:getID(), tpz.msg.basic.DAMAGE_SECONDARY)
            end

            if finaldmg > 0 then
                action:reaction(defender:getID(), tpz.reaction.HIT)
                if wsResults.criticalHit then
                    action:speceffect(defender:getID(), tpz.specEffect.CRITICAL_HIT)
                else
                    action:speceffect(defender:getID(), tpz.specEffect.RECOIL)
                end
            end
        else
            if primaryMsg then
                action:messageID(defender:getID(), tpz.msg.basic.SELF_HEAL)
            else
                action:messageID(defender:getID(), tpz.msg.basic.SELF_HEAL_SECONDARY)
            end
        end
        action:param(defender:getID(), finaldmg)
    elseif wsResults.shadowsAbsorbed > 0 then
        action:messageID(defender:getID(), tpz.msg.basic.SHADOW_ABSORB)
        action:param(defender:getID(), wsResults.shadowsAbsorbed)
    else
        if primaryMsg then
            action:messageID(defender:getID(), tpz.msg.basic.SKILL_MISS)
        else
            action:messageID(defender:getID(), tpz.msg.basic.EVADES)
        end
        action:reaction(defender:getID(), tpz.reaction.EVADE)
    end
    local enmityEntity = wsResults.taChar or attacker
    if (wsParams.overrideCE and wsParams.overrideVE) then
        defender:addEnmity(enmityEntity, wsParams.overrideCE, wsParams.overrideVE)
    else
        local enmityMult = wsParams.enmityMult or 1
        if attacker:hasStatusEffect(tpz.effect.FLASHY_SHOT) and not wsResults.melee then
            enmityMult = enmityMult * 1.4
        elseif attacker:hasStatusEffect(tpz.effect.STEALTH_SHOT) and not wsResults.melee then
            enmityMult = enmityMult * (1 - attacker:getMerit(tpz.merit.STEALTH_SHOT)/100)
        end
        defender:updateEnmityFromDamage(enmityEntity, finaldmg * enmityMult)
    end

    if finaldmg > 0 then
        defender:setLocalVar("weaponskillHit", 1)
    end
    
    return finaldmg
end

function fencerBonus(attacker)
    if attacker:getObjType() ~= tpz.objType.PC then
        return 0
    end

    local mainEquip = attacker:getStorageItem(0, 0, tpz.slot.MAIN)
    if mainEquip and not mainEquip:isTwoHanded() and not mainEquip:isHandToHand() then
        local subEquip = attacker:getStorageItem(0, 0, tpz.slot.SUB)
        if subEquip == nil or subEquip:getSkillType() == tpz.skill.NONE or subEquip:isShield() then
            return attacker:getMod(tpz.mod.FENCER_CRITHITRATE) / 100
        end
    end
    return 0
end

function souleaterBonus(attacker, numhits)
    if attacker:hasStatusEffect(tpz.effect.SOULEATER) then
        local damage = 0
        local percent = 0.1
        if attacker:getMainJob() ~= tpz.job.DRK then
            percent = percent / 2
        end
        percent = percent + math.min(0.02, 0.01 * attacker:getMod(tpz.mod.SOULEATER_EFFECT))

        local hitscounted = 0
        while (hitscounted < numhits) do
            local health = attacker:getHP()
            if health > 10 then
                damage = damage + health*percent
            end
            hitscounted = hitscounted + 1
        end
        attacker:delHP(numhits*0.10*attacker:getHP())
        return damage
    else
        return 0
    end
end

function accVariesWithTP(hitrate, acc, tp, a1, a2, a3)
    -- sadly acc varies with tp ALL apply an acc PENALTY, the acc at various %s are given as a1 a2 a3
    accpct = fTP(tp, a1, a2, a3)
    acclost = acc - (acc*accpct)
    hrate = hitrate - (0.005*acclost)
    -- cap it
    if (hrate>0.95) then
        hrate = 0.95
    end
    if (hrate<0.2) then
        hrate = 0.2
    end
    return hrate
end

-- Helper function to get Main damage depending on weapon type
function getMeleeDmg(attacker, weaponType, kick)
    local mainhandDamage = attacker:getWeaponDmg()
    local offhandDamage = attacker:getOffhandDmg()

    if weaponType == tpz.skill.HAND_TO_HAND or weaponType == tpz.skill.NONE then
        local h2hSkill = attacker:getSkillLevel(1) * 0.11 + 3

        if kick == true and attacker:hasStatusEffect(tpz.effect.FOOTWORK) then
            mainhandDamage = 18 + attacker:getMod(tpz.mod.KICK_DMG) -- Use Kick damage if footwork is on
        end

        mainhandDamage = mainhandDamage + h2hSkill
        offhandDamage = mainhandDamage
    end

    return {mainhandDamage, offhandDamage}
end

-- Works for ranged and melee. Will default to melee if isRanged parameter is not specified
function getHitRate(attacker, target, capHitRate, bonus, isRanged)
    local acc = isRanged and attacker:getRACC() or attacker:getACC()
    local eva = target:getEVA()

    if (bonus == nil) then
        bonus = 0
    end
    if (attacker:hasStatusEffect(tpz.effect.INNIN) and attacker:isBehind(target, 23)) then -- Innin acc boost if attacker is behind target
        bonus = bonus + attacker:getStatusEffect(tpz.effect.INNIN):getPower()
    end
    if (target:hasStatusEffect(tpz.effect.YONIN) and attacker:isFacing(target, 23)) then -- Yonin evasion boost if attacker is facing target
        bonus = bonus - target:getStatusEffect(tpz.effect.YONIN):getPower()
    end
    if (attacker:hasTrait(76) and attacker:isBehind(target, 23)) then --TRAIT_AMBUSH
        bonus = bonus + attacker:getMerit(tpz.merit.AMBUSH)
    end

    acc = acc + bonus

    -- https://www.bg-wiki.com/index.php?title=Hit_Rate&oldid=167680
    local lvldiff = attacker:getMainLvl() - target:getMainLvl()

    acc = acc + lvldiff*4

    -- % hitrate: baseline 75%, 2 acc or 2 evasion net 1% +/- hit rate
    local hitrate = 75 + math.floor((acc-eva)/2)

    -- Applying hitrate caps
    if (capHitRate) then -- this isn't capped for when acc varies with tp, as more penalties are due
        hitrate = utils.clamp(hitrate, 20, 95)
    end
    -- Needs return as a decimal percent
    return hitrate/100
end

function fTP(tp, ftp1, ftp2, ftp3)
    if (tp < 1000) then
        tp = 1000
    end
    if (tp >= 1000 and tp < 2000) then
        return ftp1 + ( ((ftp2-ftp1)/1000) * (tp-1000))
    elseif (tp >= 2000 and tp <= 3000) then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + ( ((ftp3-ftp2)/1000) * (tp-2000))
    end
    return 1 -- no ftp mod
end

function calculatedIgnoredDef(tp, def, ignore1, ignore2, ignore3)
    if (tp>=1000 and tp <2000) then
        return (ignore1 + ( ((ignore2-ignore1)/1000) * (tp-1000)))*def
    elseif (tp>=2000 and tp<=3000) then
        return (ignore2 + ( ((ignore3-ignore2)/1000) * (tp-2000)))*def
    end
    return 1 -- no def ignore mod
end

-- Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function cMeleeRatio(attacker, defender, params, ignoredDef, tp, isCritical)
    local flourishCoefficient = 1
    local flourisheffect = attacker:getStatusEffect(tpz.effect.BUILDING_FLOURISH)
    if flourisheffect ~= nil and flourisheffect:getPower() > 1 then flourishCoefficient = 1.25 + flourisheffect:getSubPower()/100 end

    local atkmulti = fTP(tp, params.atk100, params.atk200, params.atk300)
    local ratio = (attacker:getStat(tpz.mod.ATT) * atkmulti * flourishCoefficient) / (defender:getStat(tpz.mod.DEF) - ignoredDef)
    --attacker:PrintToPlayer(string.format("att post wsmod: %i ... def post ignoreddef: %i",attacker:getStat(tpz.mod.ATT) * atkmulti,defender:getStat(tpz.mod.DEF) - ignoredDef))
    
    local ratioCap = 2.25
    ratio = utils.clamp(ratio, 0, ratioCap)
    local cRatio = ratio;

    if attacker:getMainLvl() < defender:getMainLvl() then
        cRatio = cRatio - (defender:getMainLvl() - attacker:getMainLvl()) * 0.05
    end

    cRatio = utils.clamp(cRatio, 0, ratioCap)

    -- Using Montenten's model
    local wRatio = cRatio

    if (isCritical) then
        wRatio = wRatio + 1
    end

    local upperLimit = 3.25
    local lowerLimit = 0.0

    if (wRatio < 0.5) then
        upperLimit = wRatio + 0.5
    elseif (wRatio < 0.7) then
        upperLimit = 1.0
    elseif (wRatio < 1.2) then
        upperLimit = wRatio + 0.3
    elseif (wRatio < 1.5) then
        upperLimit = (wRatio * 0.25) + wRatio
    elseif (wRatio < 2.625) then
        upperLimit = wRatio + 0.375
    elseif (wRatio <= 3.25) then
        upperLimit = 3.0
    end
    upperLimit = utils.clamp(upperLimit, 0, 3.0)

    if (wRatio < 0.38) then
        lowerLimit = 0.0
    elseif (wRatio < 1.25) then
        lowerLimit = wRatio * (1176.0/1024.0) - (448.0/1024.0)
    elseif (wRatio < 1.51) then
        lowerLimit = 1.0
    elseif (wRatio < 2.44) then
        lowerLimit = wRatio * (1176.0/1024.0) - (755.0/1024.0)
    elseif (wRatio <= 3.25) then
        lowerLimit = wRatio - 0.375
    end
    lowerLimit = utils.clamp(lowerLimit, 0, 3.0)

    local pDIF = {}
    pDIF[1] = lowerLimit
    pDIF[2] = upperLimit
    -- attacker:PrintToPlayer(string.format("enemy def %f ... lower was %f ... upper was %f", defender:getStat(tpz.mod.DEF), lowerLimit, upperLimit))
    
    -- Bernoulli distribution, applied for cRatio < 0.5 and 0.75 < cRatio < 1.25
    -- Other cRatio values are uniformly distributed
    -- https://www.bluegartr.com/threads/108161-pDif-and-damage?p=5308205&viewfull=1#post5308205
    local U = math.max(0.0, math.min(0.333, 1.3 * (2.0 - math.abs(wRatio - 1)) - 1.96))

    local bernoulli = false

    if (math.random() < U) then
        bernoulli = true
    end

    if (bernoulli) then
        local roundedRatio = math.floor(wRatio + 0.5) -- equivalent to rounding
        pDIF[1] = roundedRatio
        pDIF[2] = roundedRatio
    end

    if isCritical then
        local critbonus = attacker:getMod(tpz.mod.CRIT_DMG_INCREASE) - defender:getMod(tpz.mod.CRIT_DEF_BONUS)
        critbonus = utils.clamp(critbonus, 0, 100)
        pDIF[1] = pDIF[1] * ((100 + critbonus)/ 100.0)
        pDIF[2] = pDIF[2] * ((100 + critbonus)/ 100.0)
    end

    return pDIF
end

function cRangedRatio(attacker, defender, params, ignoredDef, tp, isCritical)
    local ratioCap = 3.0

    local range = attacker:checkDistance(defender)

    local atkmulti = fTP(tp, params.atk100, params.atk200, params.atk300)
    local ratio = (attacker:getRATT(range) * atkmulti) / (defender:getStat(tpz.mod.DEF) - ignoredDef)

    ratio = utils.clamp(ratio, 0, ratioCap)

    local cRatio = ratio

    -- Level difference penalty
    if attacker:getMainLvl() < defender:getMainLvl() then
        -- Flashy shot ignores level difference penalty
        if attacker:hasStatusEffect(tpz.effect.FLASHY_SHOT) then
            cRatio = ratio
        else
            cRatio = ratio - (defender:getMainLvl() - attacker:getMainLvl()) * 0.025
        end
    end

    local upperLimit = 3.0
    if cRatio < 0.9 then
        upperLimit = cRatio * 10.0/9.0
    elseif cRatio < 1.1 then
        upperLimit = 1.0
    elseif cRatio < 3.0 then
        upperLimit = cRatio
    end

    local lowerLimit = 0.0
    if cRatio < 0.9 then
        lowerLimit = cRatio
    elseif cRatio < 1.1 then
        lowerLimit = 1.0
    elseif cRatio < 3.0 then
        lowerLimit = cRatio * (20.0/19.0) - (3.0/19.0)
    end

    local pDIF = {}
    pDIF[1] = lowerLimit
    pDIF[2] = upperLimit

    if isCritical then
        -- Ranged attacks get pDIF * 1.25
        pDIF[1] = pDIF[1] * 1.25
        pDIF[2] = pDIF[2] * 1.25

        -- Apply crit damage increase mods 
        local critbonus = attacker:getMod(tpz.mod.CRIT_DMG_INCREASE) - defender:getMod(tpz.mod.CRIT_DEF_BONUS)
        critbonus = utils.clamp(critbonus, 0, 100)
        pDIF[1] = pDIF[1] * ((100 + critbonus)/ 100.0)
        pDIF[2] = pDIF[2] * ((100 + critbonus)/ 100.0)
    end

    return pDIF
end

-- Given the attacker's str and the mob's vit, fSTR is calculated (for melee WS)
function fSTR(atk_str, def_vit, weapon_rank)
    local dSTR = atk_str - def_vit
    local fSTR = 0
    if (dSTR >= 12) then
        fSTR = (dSTR + 4) / 4
    elseif (dSTR >= 6) then
        fSTR = (dSTR + 6) / 4
    elseif (dSTR >= 1) then
        fSTR = (dSTR + 7) / 4
    elseif (dSTR >= -2) then
        fSTR = (dSTR + 8) / 4
    elseif (dSTR >= -7) then
        fSTR = (dSTR + 9) / 4
    elseif (dSTR >= -15) then
        fSTR = (dSTR + 10) / 4
    elseif (dSTR >= -21) then
        fSTR = (dSTR + 12) / 4
    else
        fSTR = (dSTR + 13) / 4
    end

    -- Apply fSTR caps.
    local lower_cap = weapon_rank * -1
    if weapon_rank == 0 then
        lower_cap = -1
    end
    fSTR = utils.clamp(fSTR, lower_cap, weapon_rank + 8)
    return fSTR
end

-- Given the attacker's str and the mob's vit, fSTR2 is calculated (for ranged WS)
function fSTR2(atk_str, def_vit, weapon_rank)
    local dSTR = atk_str - def_vit
    local fSTR2 = 0
    if (dSTR >= 12) then
        fSTR2 = (dSTR + 4) / 2
    elseif (dSTR >= 6) then
        fSTR2 = (dSTR + 6) / 2
    elseif (dSTR >= 1) then
        fSTR2 = (dSTR + 7) / 2
    elseif (dSTR >= -2) then
        fSTR2 = (dSTR + 8) / 2
    elseif (dSTR >= -7) then
        fSTR2 = (dSTR + 9) / 2
    elseif (dSTR >= -15) then
        fSTR2 = (dSTR + 10) / 2
    elseif (dSTR >= -21) then
        fSTR2 = (dSTR + 12) / 2
    else
        fSTR2 = (dSTR + 13) / 2
    end

    -- Apply fSTR2 caps.
    local lower_cap = weapon_rank * -2
    if weapon_rank == 0 then
        lower_cap = -2
    elseif weapon_rank == 1 then
        lower_cap = -3
    end
    fSTR2 = utils.clamp(fSTR2, lower_cap, (weapon_rank + 8) * 2)
    return fSTR2
end

-- Obtains alpha, used for working out WSC on legacy servers
function getAlpha(level)
    -- Retail has no alpha anymore as of 2014. Weaponskill functions
    -- should be checking for USE_ADOULIN_WEAPON_SKILL_CHANGES and
    -- overwriting the results of this function if the server has it set
    alpha = 1.00
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
    elseif (level < 99) then
        alpha = 0.85
    else
        alpha = 1
    end
    return alpha
end

function getMultiAttacks(attacker, target, numHits, useOAXTimes, melee)
    local bonusHits = 0
    local multiChances = 1
    local doubleRate = (attacker:getMod(tpz.mod.DOUBLE_ATTACK) + attacker:getMerit(tpz.merit.DOUBLE_ATTACK_RATE))/100
    local tripleRate = (attacker:getMod(tpz.mod.TRIPLE_ATTACK) + attacker:getMerit(tpz.merit.TRIPLE_ATTACK_RATE))/100
    local quadRate = attacker:getMod(tpz.mod.QUAD_ATTACK)/100
    local oaThriceRate = attacker:getMod(tpz.mod.MYTHIC_OCC_ATT_THRICE)/100
    local oaTwiceRate = attacker:getMod(tpz.mod.MYTHIC_OCC_ATT_TWICE)/100
    local offHandHits = 0

    --doubleRate = 1

    -- Add Ambush Augments to Triple Attack
    --if (attacker:hasTrait(76) and attacker:isBehind(target, 23)) then -- TRAIT_AMBUSH
        --tripleRate = tripleRate + attacker:getMerit(tpz.merit.AMBUSH) / 3 -- Value of Ambush is 3 per mert, augment gives +1 Triple Attack per merit
    --end
    -- this is lv90 item onry

    -- QA/TA/DA can only proc on the first hit of each weapon or each fist
    if (attacker:getOffhandDmg() > 0 or attacker:getWeaponSkillType(tpz.slot.MAIN) == tpz.skill.HAND_TO_HAND) then
        multiChances = 2
    end

    if melee == false then
        bonusHits = 0
        multiChances = 0
        doubleRate = 0
        tripleRate = 0
        quadRate = 0
        oaThriceRate = 0
        oaTwiceRate = 0
        offHandHits = 0
    end

    for i = 1, multiChances, 1 do
        if math.random() < quadRate then
            bonusHits = bonusHits + 3
        elseif math.random() < tripleRate then
            bonusHits = bonusHits + 2
        elseif math.random() < doubleRate then
            bonusHits = bonusHits + 1
        elseif (i == 1 and math.random() < oaThriceRate) then -- Can only proc on first hit
            bonusHits = bonusHits + 2
        elseif (i == 1 and math.random() < oaTwiceRate) then -- Can only proc on first hit
            bonusHits = bonusHits + 1
        end
        if (i == 1) then
            attacker:delStatusEffect(tpz.effect.ASSASSINS_CHARGE)
            attacker:delStatusEffect(tpz.effect.WARRIOR_S_CHARGE)

            -- recalculate DA/TA/QA rate
            doubleRate = (attacker:getMod(tpz.mod.DOUBLE_ATTACK) + attacker:getMerit(tpz.merit.DOUBLE_ATTACK_RATE))/100
            tripleRate = (attacker:getMod(tpz.mod.TRIPLE_ATTACK) + attacker:getMerit(tpz.merit.TRIPLE_ATTACK_RATE))/100
            quadRate = attacker:getMod(tpz.mod.QUAD_ATTACK)/100
        end
    end

    -- for Jump, now check multihit weapons if we have no bonushits
    if attacker:isPC() and useOAXTimes ~= nil and useOAXTimes == true and bonusHits == 0 then
        local mhandOAX = attacker:getOAXTimes(0)
        local offhandOAX = attacker:getOAXTimes(1)

        if mhandOAX > 0 then
            bonusHits = bonusHits + mhandOAX - 1
        end
        if offhandOAX > 0 then
            offHandHits = offhandOAX - 1
        end
    end

    local ret1 = numHits + bonusHits

    if (ret1 >= 8) then
        -- if dual wielding, reduce max hits by 1 to account for the extra offhand hit not tracked in "hitCount"
        ret1 = attacker:getOffhandDmg() > 0 and 7 or 8
    end

    return ret1, offHandHits
end

function generatePdif (cratiomin, cratiomax, isRanged)
    local pDIF = math.random(cratiomin*1000, cratiomax*1000) / 1000.0

    if (isRanged ~= nil) and (isRanged == false) then
        pDIF = pDIF * (math.random(100, 105)/100.0)
    end

    return pDIF
end

function getStepAnimation(skill)
    if skill <= 1 then
        return 15
    elseif skill <= 3 then
        return 14
    elseif skill == 4 then
        return 19
    elseif skill == 5 then
        return 16
    elseif skill <= 7 then
        return 18
    elseif skill == 8 then
        return 20
    elseif skill == 9 then
        return 21
    elseif skill == 10 then
        return 22
    elseif skill == 11 then
        return 17
    elseif skill == 12 then
        return 23
    else
        return 0
    end
end

function getFlourishAnimation(skill)
    if skill <= 1 then
        return 25
    elseif skill <= 3 then
        return 24
    elseif skill == 4 then
        return 29
    elseif skill == 5 then
        return 26
    elseif skill <= 7 then
        return 28
    elseif skill == 8 then
        return 30
    elseif skill == 9 then
        return 31
    elseif skill == 10 then
        return 32
    elseif skill == 11 then
        return 27
    elseif skill == 12 then
        return 33
    else
        return 0
    end
end



function handleWSGorgetBelt(attacker)
    local ftpBonus = 0
    local accBonus = 0
    if attacker:getObjType() == tpz.objType.PC then
        -- TODO: Get these out of itemid checks when possible.
        local elementalGorget = { 15495, 15496, 15497, 15498, 15499, 15500, 15501, 15502 }
        local elementalBelt =   { 11755, 11758, 11760, 11757, 11756, 11759, 11761, 11762 }
        local neck = attacker:getEquipID(tpz.slot.NECK)
        local belt = attacker:getEquipID(tpz.slot.WAIST)
        local SCProp1, SCProp2, SCProp3 = attacker:getWSSkillchainProp()
        -- Some things are treated as WS but don't have properties, such as jumps
        if SCProp1 == nil then
            return 0, 0
        end
        for i,v in ipairs(elementalGorget) do
            if neck == v then
                if
                    doesElementMatchWeaponskill(i, SCProp1) or
                    doesElementMatchWeaponskill(i, SCProp2) or
                    doesElementMatchWeaponskill(i, SCProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if neck == 27510 then -- Fotia Gorget
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end

        for i, v in ipairs(elementalBelt) do
            if belt == v then
                if
                    doesElementMatchWeaponskill(i, SCProp1) or
                    doesElementMatchWeaponskill(i, SCProp2) or
                    doesElementMatchWeaponskill(i, SCProp3)
                then
                    accBonus = accBonus + 10
                    ftpBonus = ftpBonus + 0.1
                end

                break
            end
        end

        if belt == 28420 then -- Fotia Belt
            accBonus = accBonus + 10
            ftpBonus = ftpBonus + 0.1
        end
    end

    return ftpBonus, accBonus
end

function shadowAbsorb(target)
    local targShadows = target:getMod(tpz.mod.UTSUSEMI)
    local shadowType = tpz.mod.UTSUSEMI

    if targShadows == 0 then
        if math.random() < 0.8 then
            targShadows = target:getMod(tpz.mod.BLINK)
            shadowType = tpz.mod.BLINK
        end
    end

    if targShadows > 0 then
        if shadowType == tpz.mod.UTSUSEMI then
            local effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
            if effect then
                if targShadows - 1 == 1 then
                    effect:setIcon(tpz.effect.COPY_IMAGE)
                elseif targShadows - 1 == 2 then
                    effect:setIcon(tpz.effect.COPY_IMAGE_2)
                elseif targShadows - 1 == 3 then
                    effect:setIcon(tpz.effect.COPY_IMAGE_3)
                end
            end
        end
        target:setMod(shadowType, targShadows - 1)
        if targShadows - 1 == 0 then
            target:delStatusEffect(tpz.effect.COPY_IMAGE)
            target:delStatusEffect(tpz.effect.COPY_BLINK)
        end
        return true
    end
    return false
end
