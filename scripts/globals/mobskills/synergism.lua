---------------------------------------------
--  Synergism (1826)
--
--  Used by Dextrose ZNM
--  Description: Absorbs HP from any nearby flans, should not kill the target.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- make sure to leave atleast 5% hp
    local neededHP = math.ceil(mob:getMaxHP() / 4)
    local expandableHP = target:getHP() - math.ceil(target:getMaxHP() * 0.05)

    local dmg = math.min(neededHP, expandableHP)
    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))
end