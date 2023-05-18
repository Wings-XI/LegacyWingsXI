---------------------------------------------------
-- Hellsnap
-- Stuns targets in an area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
  if(mob:getFamily() == 91) then
    local mobSkin = mob:getModelId()

    if (mobSkin == 1839) then
        return 0
    else
        return 1
    end
  end
  return 0
end

function onMobWeaponSkill(target, mob, skill)
    local duration = 15
    local returnEffect = tpz.effect.STUN

    skill:setMsg(MobStatusEffectMove(mob, target, returnEffect, 1, 0, duration))

    return returnEffect
end
