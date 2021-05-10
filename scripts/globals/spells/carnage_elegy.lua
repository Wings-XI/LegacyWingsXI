-----------------------------------------
-- Spell: Carnage Elegy
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 180
    local power = 5000

    local pCHR = caster:getStat(tpz.mod.CHR)
    local mCHR = target:getStat(tpz.mod.CHR)
    local dCHR = pCHR - mCHR
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = 0
    params.effect = tpz.effect.ELEGY
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
    local resist = applyResistanceEffect(caster, target, spell, params)
    local buildResistPercent = tryBuildResistance(tpz.mod.RESBUILD_SLOW, target)
    if resist < 0.5 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(tpz.mod.ELEGY_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
        power = power + iBoost * 100

        if caster:hasStatusEffect(tpz.effect.SOUL_VOICE) then
            power = power * 2
        elseif caster:hasStatusEffect(tpz.effect.MARCATO) then
            power = power * 1.5
        end
        caster:delStatusEffect(tpz.effect.MARCATO)

        duration = duration * (iBoost * 0.1 + caster:getMod(tpz.mod.SONG_DURATION_BONUS) / 100 + 1)
        duration = math.ceil(duration * resist * buildResistPercent)

        if caster:hasStatusEffect(tpz.effect.TROUBADOUR) then
            duration = duration * 2
        end
        
        -- https://ffxiclopedia.fandom.com/wiki/Carnage_Elegy?oldid=1083354 "The Elegy family of spells players can cast is capped at 50% Slow."
        if caster:isPC() == true and power > 5000 then power = 5000 end

        -- Try to overwrite weaker elegy
        if target:addStatusEffect(tpz.effect.ELEGY, power, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end

    end

    return tpz.effect.ELEGY
end
