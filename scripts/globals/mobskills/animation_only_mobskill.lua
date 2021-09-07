---------------------------------------------
-- Animation Only Mobskill
-- This script is a catch all for skills which only trigger an animation when used by a mob.
--  Known skills which follow this pattern:
--  SkillID  AnimationID NameAppearingOnCapture  MobUsingSkill  Effect
--  307      439         Substitute              Galarhigg      2 Hour "dust cloud" - entity flashes black
--  603      432         Lateral_Slash           Galarhigg      2 Hour "dust cloud" - entity flashes blue
--  624      434         Vulture_3               Galarhigg      2 Hour "dust cloud" - entity flashes green
--  626      437         Vulture_1               Galarhigg      2 Hour "dust cloud" - entity flashes white
--  2018     1365        Unknown                 Valkeng        Puppet Frame - Performs a dance then hides the mob model
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
    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end
