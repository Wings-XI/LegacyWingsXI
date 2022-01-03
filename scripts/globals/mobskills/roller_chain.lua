---------------------------------------------
-- Roller Chain
--
-- Description: AoE damage and Bind, blinkable by 2-3 Utsusemi shadows. Used only when the door is closed.
-- Used by Archaic Ramparts
-- possibly animation 1383
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:AnimationSub() == 0) then
        return 0
    end

    return 1
end

function onMobWeaponSkill(target, mob, skill)
    --ToDo Implement Skill, not used by Nyzul Isle Ramparts

    return 0
end
