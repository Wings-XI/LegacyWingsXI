-----------------------------------------
-- Spell: Sirvente
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)
    local sLvl = caster:getSkillLevel(tpz.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(tpz.slot.RANGED)
    
    local rangedType = nil
    if caster:isPC() then rangedType = caster:getWeaponSkillType(tpz.slot.RANGED) end
    if caster:isPC() and rangedType ~= tpz.skill.STRING_INSTRUMENT and rangedType ~= tpz.skill.WIND_INSTRUMENT then iLvl = math.floor(sLvl/2)
    else iLvl = sLvl end

    local power = 5 + caster:getMerit(tpz.merit.FOE_SIRVENTE)

    if (sLvl+iLvl > 300) then
        power = power + 2
    end
	if (sLvl+iLvl > 400) then
        power = power + 2
    end

    local iBoost = caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    power = power + iBoost*5

    if (caster:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(tpz.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffect(tpz.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(tpz.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster,tpz.effect.SIRVENTE,power,0,duration,caster:getID(), tpz.magic.ele.FIRE, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.SIRVENTE
end
