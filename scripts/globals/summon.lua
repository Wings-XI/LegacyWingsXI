
require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/monstertpmoves")

function getSummoningSkillOverCap(avatar)
    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(tpz.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), tpz.job.SMN, tpz.skill.SUMMONING_MAGIC)
    return math.max(summoningSkill - maxSkill, 0)
end

function getAvatarEcosystemCoefficient(target, ele)
    --print(string.format("AvatarEcosystemCoe was %f",(getElementalSDT(ele-5, target)/100+0.9)/1.9))
    return (getElementalSDT(ele-5, target)/100+0.9)/1.9 -- range of 0.5 to 1.26
end

function getAvatarfTP(tp, tier)
    -- Source: https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    local ftp1 = 1
    local ftp2 = 1
    local ftp3 = 1

    if (tier == 2) then
        ftp1 = 1.5
        ftp2 = 2.75
        ftp3 = 3
    elseif (tier == 4) then
        ftp1 = 3.625
        ftp2 = 5.312
        ftp3 = 6.125
    end

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

function getAvatarAlpha(pet)
    local alpha = 1

    if (pet:getMainLvl() < 62) then
        alpha = 1 - math.floor(pet:getMainLvl() / 6) / 100
    else
        alpha = 0.9 - math.floor( (pet:getMainLvl() - 60) / 2 ) / 100
    end

    return alpha
end

function AvatarMagicalMove(pet, target, skill, tp, ele, tier)
    -- Damage = ( (D) * fTP + dSTAT ) * Magic Multipliers
    -- D = Constant + Modifier
    -- Source: https://www.bluegartr.com/threads/114636-Monster-Avatar-Pet-damage
    local damage = 0
    local statMod = 1
    local alpha = getAvatarAlpha(pet)
    local dINT = math.floor(pet:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    local totalAccBonus = 0

    if (dINT > 0) then
        dINT = dINT*1.5
    else
        dINT = 1.5
    end

    if (tier == 2) then
        statMod = 0.3
    elseif (tier >= 4) then
        statMod = 0.25
    end

    local baseDMG = pet:getMainLvl() + 2

    -- Base damage
    damage = math.floor(baseDMG + math.floor(pet:getStat(tpz.mod.INT)*statMod)*alpha)
    -- printf("Base DMG = %i", damage)
    -- Astral Flow damage
    -- Tuned to the following source: https://www.youtube.com/watch?v=n4Ib2EIM0_g
    if (tier == 0) then
        damage = damage * 5
    end
    -- printf("Astral Flow DMG = %i", damage)
    -- fTP
    damage = math.floor(damage*getAvatarfTP(tp, tier)+dINT)
    -- printf("FTP DMG = %i", damage)
    -- Resists (1, 1/2, 1/4, 1/8, or 1/16)
    totalAccBonus = utils.clamp(getSummoningSkillOverCap(pet), 0, 200) + pet:getMaster():getMerit(1284) -- avatar magic acc merit
    damage = math.floor(damage * applyPlayerResistance(pet, nil, target, pet:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), totalAccBonus, ele-5))
    -- printf("Resist damage = %i", damage)
    -- Day/Weather + MB Bonuses
    damage = mobAddBonuses(pet, nil, target, damage, ele-5)
    -- printf("day/weather + MB damage = %i", damage)
    -- MAB/MDB
    damage = math.floor(damage * ((1+(pet:getMod(tpz.mod.MATT)/100))/(1+(target:getMod(tpz.mod.MDEF)/100))))
    -- printf("MAB dmg = %i", damage)

    return damage
end

function AvatarPhysicalMove(avatar,target,skill,numberofhits,accmod,dmgmod,dmgmodsubsequent,tpeffect,mtp100,mtp200,mtp300,critmod, wsc)

    local master = avatar:getMaster()

    local returninfo = {}

    if critmod == nil then
        critmod = 0
    end

    local acc = avatar:getACC()
    local eva = target:getEVA()
    local dmg = avatar:getWeaponDmg() - target:getMod(tpz.mod.VIT)/4
    local minFstr, maxFstr = avatarFSTR(avatar:getStat(tpz.mod.STR), target:getStat(tpz.mod.VIT))
    local ratio = avatar:getStat(tpz.mod.ATT) / target:getStat(tpz.mod.DEF)
    -- printf("Avatar ATT = %d, target DEF = %d, Ratio = %d",avatar:getStat(tpz.mod.ATT), target:getStat(tpz.mod.DEF), ratio)
    local cRatio = avatar:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)

    -- Note: Avatars do not have any level correction. This is why they are so good on Wyrms! // https://kegsay.livejournal.com/tag/smn!
    -- merit 1280 is avatar phys accuracy merit
    local hitrate = utils.clamp(75 + accmod + getSummoningSkillOverCap(avatar) + master:getMerit(1280) + ((acc - eva)/5), 20, 97)

    local dexMod = 0
    if (cRatio < 7) then
        dexMod = 0
    elseif (cRatio < 14) then
        dexMod = 0.01
    elseif (cRatio < 20) then
        dexMod = 0.02
    elseif (cRatio < 30) then
        dexMod = 0.03
    elseif (cRatio < 40) then
        dexMod = 0.04
    elseif (cRatio < 51) then
        dexMod = (cRatio - 35) / 100
    else
        dexMod = 0.15
    end


    local critrate = 0.05 + dexMod
    --local critrate = (avatar:getStat(tpz.mod.DEX) - target:getStat(tpz.mod.AGI)) * 0.005 -- assumes +0.5% crit rate per 1 dDEX
    critrate = critrate + avatar:getMod(tpz.mod.CRITHITRATE) / 100 + critmod / 100
    critrate = utils.clamp(critrate, 0.05, 0.2)

    -- Applying pDIF
    if ratio <= 1 then
        maxRatio = 1
        minRatio = 1/3
    elseif ratio < 1.6 then
        maxRatio = (2 * ratio + 1) / 3
        minRatio = (7 * ratio - 4) / 9
    elseif ratio <= 1.8 then
        maxRatio = 1.8
        minRatio = 1
    elseif ratio < 3.6 then
        maxRatio = 2.4 * ratio - 2.52
        minRatio = 5 * ratio / 3 - 2
    else
        maxRatio = 4.2
        minRatio = 4
    end

    -- pDIF cap on low level mobs
    if (target:getMainLvl() < avatar:getMainLvl()-20) then
        maxRatio = utils.clamp(maxRatio, 1, 1.25)
        minRatio = utils.clamp(minRatio, 1/3, maxRatio-0.1)
    end

    --[[
    maxRatio = ratio * 0.5 + 1
    minRatio = maxRatio * 0.78 + 1/6
    if maxRatio > 2.75 then
        maxRatio = 2.75
    end
    if minRatio > maxRatio - 0.1 then
        minRatio = maxRatio - 0.1
    end ]]

    -- WSC calculation
    local extraDmg = 0
    if (wsc ~= nil) then
        extraDmg = (avatar:getStat(tpz.mod.STR) * wsc.str_wsc + avatar:getStat(tpz.mod.DEX) * wsc.dex_wsc +
         avatar:getStat(tpz.mod.VIT) * wsc.vit_wsc + avatar:getStat(tpz.mod.AGI) * wsc.agi_wsc +
         avatar:getStat(tpz.mod.INT) * wsc.int_wsc + avatar:getStat(tpz.mod.MND) * wsc.mnd_wsc +
         avatar:getStat(tpz.mod.CHR) * wsc.chr_wsc) * getAvatarAlpha(avatar)
    end

    -- start the hits
    local hitsdone = 1
    local hitslanded = 0
    local hitdmg = 0
    local finaldmg = 0

    -- first hit
    if math.random()*100 < hitrate then
        hitdmg = avatarHitDmg(dmg + extraDmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
        if (wsc.ele ~= nil) then
            hitdmg = hitdmg * applyResistanceAbility(avatar, target, wsc.ele, tpz.skill.ELEMENTAL_MAGIC)
        end
        finaldmg = finaldmg + hitdmg * dmgmod
        hitslanded = hitslanded + 1
    end

    while hitsdone < numberofhits do
        if math.random()*100 < hitrate then
            hitdmg = avatarHitDmg(dmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
            finaldmg = finaldmg + hitdmg * dmgmodsubsequent
            hitslanded = hitslanded + 1
        end
        hitsdone = hitsdone + 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg = 0
        hitslanded = 0
        skill:setMsg(tpz.msg.basic.SKILL_MISS)

    -- some hits hit
    else
        target:wakeUp()
    end

    --master:PrintToPlayer(string.format("blood pact hit %i of %i times for pdif %.2f to %.2f at an accuracy of %.2f",hitslanded,numberofhits,minRatio,maxRatio,hitrate))

    -- apply ftp bonus
    if tpeffect == TP_DMG_BONUS then
        finaldmg = finaldmg * avatarFTP(skill:getTP(), mtp100, mtp200, mtp300)
    end

    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo
end

-- minFstr = dSTR/4 + 0.5
-- maxFstr = dSTR/4 + 0.25
function avatarFSTR(att_str, def_vit)
    local dSTR = att_str - def_vit
    return math.floor(dSTR / 4 + 0.5), math.floor(dSTR / 4 + 0.25)
end

function avatarHitDmg(dmg, pdifMin, pdifMax, fstrMin, fstrMax, critrate)
    local fstr = math.random(fstrMin, fstrMax)
    local pdif = math.random(pdifMin * 1000, pdifMax * 1000) / 1000
    if math.random() < critrate then
        pdif = math.min(pdif + 1, 4.2)
    end
    -- printf("dmg = %d, fSTR = %d, pdif = %d total = %d", dmg, fstr, pdif, (dmg + fstr) * pdif)
    return (dmg + fstr) * pdif
end

function AvatarFinalAdjustments(dmg,mob,skill,target,skilltype,skillparam,shadowbehav)

    -- physical attack missed, skip rest
    if skilltype == tpz.attackType.PHYSICAL and dmg == 0 then
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(tpz.msg.basic.DAMAGE)

    --Handle shadows depending on shadow behaviour / skilltype
    if shadowbehav < 5 and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then --remove 'shadowbehav' shadows.
        targShadows = target:getMod(tpz.mod.UTSUSEMI)
        shadowType = tpz.mod.UTSUSEMI
        if targShadows == 0 then --try blink, as utsusemi always overwrites blink this is okay
            targShadows = target:getMod(tpz.mod.BLINK)
            shadowType = tpz.mod.BLINK
        end

        if targShadows > 0 then
        -- Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!
            if targShadows >= shadowbehav then --no damage, just suck the shadows
                skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
                target:setMod(shadowType, targShadows - shadowbehav)
                if shadowType == tpz.mod.UTSUSEMI then --update icon
                    effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if targShadows - shadowbehav == 0 then
                            target:delStatusEffect(tpz.effect.COPY_IMAGE)
                            target:delStatusEffect(tpz.effect.BLINK)
                        elseif targShadows - shadowbehav == 1 then
                            effect:setIcon(tpz.effect.COPY_IMAGE)
                        elseif targShadows - shadowbehav == 2 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_2)
                        elseif targShadows - shadowbehav == 3 then
                            effect:setIcon(tpz.effect.COPY_IMAGE_3)
                        end
                    end
                end
                return shadowbehav
            else -- less shadows than this move will take, remove all and factor damage down
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
                target:setMod(tpz.mod.UTSUSEMI, 0)
                target:setMod(tpz.mod.BLINK, 0)
                target:delStatusEffect(tpz.effect.COPY_IMAGE)
                target:delStatusEffect(tpz.effect.BLINK)
            end
        end
    elseif shadowbehav == MOBPARAM_WIPE_SHADOWS then --take em all!
        target:setMod(tpz.mod.UTSUSEMI, 0)
        target:setMod(tpz.mod.BLINK, 0)
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)
    end

    -- handle Third Eye using shadowbehav as a guide
    teye = target:getStatusEffect(tpz.effect.THIRD_EYE)
    if teye ~= nil and skilltype == tpz.attackType.PHYSICAL then --T.Eye only procs when active with PHYSICAL stuff
        if shadowbehav == MOBPARAM_WIPE_SHADOWS then --e.g. aoe moves
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        elseif shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then --it can be absorbed by shadows
            --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            --chance of anticipate based on previous successful anticipates.
            prevAnt = teye:getPower()
            if prevAnt == 0 then
                --100% proc
                teye:setPower(1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                return 0
            end
            if math.random() * 10 < 8 - prevAnt then
                --anticipated!
                teye:setPower(prevAnt+1)
                skill:setMsg(tpz.msg.basic.ANTICIPATE)
                return 0
            end
            target:delStatusEffect(tpz.effect.THIRD_EYE)
        end
    end

    if target:isNM() and skilltype == tpz.attackType.MAGICAL then
        dmg = dmg - (dmg * target:getMod(tpz.mod.MAGIC_STACKING_MDT) / 100)
        if target:getMod(tpz.mod.MAGIC_STACKING_MDT) == 0 then
            target:setMod(tpz.mod.MAGIC_STACKING_MDT, NM_MAGIC_STACK)
            target:queue(NM_MAGIC_STACK_WINDOW, function(target)
                target:setMod(tpz.mod.MAGIC_STACKING_MDT,0)
            end)
        elseif target:getMod(tpz.mod.MAGIC_STACKING_MDT) < NM_MAGIC_STACK_CAP then
            target:setMod(tpz.mod.MAGIC_STACKING_MDT, target:getMod(tpz.mod.MAGIC_STACKING_MDT) + NM_MAGIC_STACK)
        end
    end

    if skilltype == tpz.attackType.MAGICAL or skilltype == tpz.attackType.SPECIAL or skilltype == tpz.attackType.BREATH then
        dmg = target:magicDmgTaken(dmg, skillparam)
    elseif skilltype == tpz.attackType.RANGED then
        dmg = target:rangedDmgTaken(mob, dmg)
    elseif skilltype == tpz.attackType.PHYSICAL then
        dmg = target:physicalDmgTaken(mob, dmg, skillparam)
    end

    --TODO: Handle anything else (e.g. if you have Magic Shield and its a Magic skill, then do 0 damage.
    if skilltype == tpz.attackType.PHYSICAL and target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
        if (target:getStatusEffect(tpz.effect.PHYSICAL_SHIELD):getPower() < 2) then
            return 0
        end
    end

    if skilltype == tpz.attackType.RANGED and target:hasStatusEffect(tpz.effect.ARROW_SHIELD) then
        return 0
    end

    -- handle elemental resistence
    if skilltype == tpz.attackType.MAGICAL and target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
        return 0
    end

    -- handling phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)
    if dmg < 0 then
        return 0
    end

    --handle invincible
    if target:hasStatusEffect(tpz.effect.INVINCIBLE) and skilltype == tpz.attackType.PHYSICAL then
        return 0
    end
    -- handle pd
    if (target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH)) and skilltype == tpz.attackType.PHYSICAL then
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(tpz.mod.BP_DAMAGE) / 100

    if (skillparam == tpz.damageType.H2H) then
        dmg = dmg * target:getMod(tpz.mod.H2HRES) / 1000
    elseif (skillparam == tpz.damageType.PIERCING) then
        dmg = dmg * target:getMod(tpz.mod.PIERCERES) / 1000
    elseif (skillparam == tpz.damageType.BLUNT) then
        dmg = dmg * target:getMod(tpz.mod.IMPACTRES) / 1000
    elseif (skillparam == tpz.damageType.SLASHING) then
        dmg = dmg * target:getMod(tpz.mod.SLASHRES) / 1000
    end

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    return dmg
end

-- returns true if mob attack hit
-- used to stop tp move status effects
function AvatarPhysicalHit(skill, dmg)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:getMsg() == tpz.msg.basic.DAMAGE
end

function avatarFTP(tp,ftp1,ftp2,ftp3)
    if tp < 1000 then
        tp = 1000
    end
    if tp >= 1000 and tp < 2000 then
        return ftp1 + (ftp2 - ftp1) / 100 * (tp - 1000)
    elseif tp >= 2000 and tp <= 3000 then
        -- generate a straight line between ftp2 and ftp3 and find point @ tp
        return ftp2 + (ftp3 - ftp2) / 100 * (tp - 2000)
    end
    return 1 -- no ftp mod
end

-- Checks if the summoner is in a Trial Size Avatar Mini Fight (used to restrict summoning while in bcnm)
function avatarMiniFightCheck(caster)
    local result = 0
    local bcnmid
    if caster:hasStatusEffect(tpz.effect.BATTLEFIELD) then
        bcnmid = caster:getStatusEffect(tpz.effect.BATTLEFIELD):getPower()
        if bcnmid == 418 or bcnmid == 609 or bcnmid == 450 or bcnmid == 482 or bcnmid == 545 or bcnmid == 578 then -- Mini Avatar Fights
            result = 40 -- Cannot use <spell> in this area.
        end
    end
      return result
end
