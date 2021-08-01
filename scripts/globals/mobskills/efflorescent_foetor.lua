---------------------------------------------
--  Efflorescent Foetor
--  Description: Sprays toxic pollen in a fan-shaped area of effect, inflicting Blind & Silence.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local blinded = false
    local silenced = false

    blinded = MobStatusEffectMove(mob, target, tpz.effect.BLINDNESS, 20, 0, 120)
    silenced = MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 120)

    skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)

    if (blinded == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.BLINDNESS
    elseif (bio == tpz.msg.basic.SKILL_ENFEEB_IS) then
        typeEffect = tpz.effect.SILENCE
    else
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    end

    return typeEffect
end
