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
    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        effect = mob:getStatusEffect(tpz.effect.BERSERK)
        -- addMod added twice due to limitation with core behavior with effect:addMod not adding a mod with the currect effect
        mob:addMod(tpz.mod.ATT, 799)
        effect:addMod(tpz.mod.ATT, 799)
        mob:addMod(tpz.mod.DEF, -200)
        effect:addMod(tpz.mod.DEF, -200)
    end
    return typeEffect
end
