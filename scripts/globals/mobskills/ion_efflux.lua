---------------------------------------------
-- Ion_Efflux
--
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
--
-- Range: 10 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- skillList  54 = Omega
    -- skillList 727 = Proto-Omega
    -- skillList 728 = Ultima
    -- skillList 729 = Proto-Ultima
    local skillList = mob:getMobMod(tpz.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()

    if ((skillList == 54 and mobhp > 25) or (skillList == 727 and mob:AnimationSub() <= 1)) then
        return 0
    else
        return 1
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 60))

    return typeEffect
end
