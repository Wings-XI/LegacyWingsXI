---------------------------------------------
-- Noctoshield
--
-- Description: Gives the effect of "Phalanx."
-- Type: Magical
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobBuffMove(mob, tpz.effect.PHALANX, 13, 0, 120))
    return tpz.effect.PHALANX
end