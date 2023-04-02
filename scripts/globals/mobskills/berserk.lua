---------------------------------------------
-- Berserk
-- Berserk Ability.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BERSERK
    skill:setMsg(MobBuffMove(mob, typeEffect, 25, 0, 180))
    if (mob:getZone():getType() == tpz.zoneType.DYNAMIS) then
        effect = mob:getStatusEffect(tpz.effect.BERSERK)
        mob:addMod(tpz.mod.ATT, 799)
        effect:addMod(tpz.mod.ATT, 799)
        mob:addMod(tpz.mod.DEF, -200) -- CHECK MAKE SURE DEF ISN'T ZERO
        effect:addMod(tpz.mod.DEF, -200)
    end
    return typeEffect
end
