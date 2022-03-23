---------------------------------------------
--  Biomagnet
--  Family: Archaic Rampart
--  Description: Biomagnet - Single-target draw in
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:checkDistance(target) > 5) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    mob:triggerDrawIn(false, 50, 50, target)
end
