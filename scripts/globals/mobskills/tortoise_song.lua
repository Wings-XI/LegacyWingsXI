---------------------------------------------
-- Tortoise Song
--
-- Description: Removes all status effects in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 20' radial
-- Notes: Adamantoise in Nyzul Isle (mob ID 17092999) uses a version which dispels all buffs
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local count = 0
    if (mob:getID() == 17092999) then
        count = target:dispelAllStatusEffect()
    else
        count = target:dispelAllStatusEffect(bit.bor(tpz.effectFlag.SONG, tpz.effectFlag.ROLL))
    end

    if (count == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(tpz.msg.basic.DISAPPEAR_NUM)
    end

    return count
end
