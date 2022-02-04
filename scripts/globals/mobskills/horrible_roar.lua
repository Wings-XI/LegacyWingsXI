---------------------------------------------
-- Horrible Roar
--
-- Description: Dispels four effects from targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 25' radial
-- Notes: Used by Bahamut in Wyrmking Descends
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else       
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local dis1 = target:dispelStatusEffect()
    local dis2 = target:dispelStatusEffect()
    local dis3 = target:dispelStatusEffect()
    local dis4 = target:dispelStatusEffect()


    if (dis1 ~= tpz.effect.NONE and dis2 ~= tpz.effect.NONE and dis3 ~= tpz.effect.NONE and dis4 ~= tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
        return 4
    elseif (dis1 ~= tpz.effect.NONE or dis2 ~= tpz.effect.NONE or dis3 ~= tpz.effect.NONE or dis4 ~= tpz.effect.NONE) then
        -- dispeled only one
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
        return 1
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    end

    return 0
end
