-----------------------------------------
-- Spell: Dirge
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local sLvl = caster:getSkillLevel(dsp.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(dsp.slot.RANGED)
    
    local rangedType = nil
    if caster:isPC() then rangedType = caster:getWeaponSkillType(tpz.slot.RANGED) end
    if caster:isPC() and rangedType ~= tpz.skill.STRING_INSTRUMENT and rangedType ~= tpz.skill.WIND_INSTRUMENT then iLvl = math.floor(sLvl/2)
    else iLvl = sLvl end

    local power = -7 - caster:getMerit(dsp.merit.ADVENTURERS_DIRGE)

    if (sLvl+iLvl > 300) then
        power = power - 1
    end
	if (sLvl+iLvl > 400) then
        power = power - 1
    end

    local iBoost = caster:getMod(dsp.mod.ALL_SONGS_EFFECT)
    power = power - iBoost*3

    if (caster:hasStatusEffect(dsp.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(dsp.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffect(dsp.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(dsp.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(dsp.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster,dsp.effect.DIRGE,power,0,duration,caster:getID(), dsp.magic.ele.FIRE, 1)) then
        spell:setMsg(dsp.msg.basic.MAGIC_NO_EFFECT)
    end

    return dsp.effect.DIRGE
end
