---------------------------------------------
-- Bubble Curtain
--
-- Description: Reduces magical damage received by 50%
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:Nightmare Crabs use an enhanced version that applies a Magic Defense Boost that cannot be dispelled.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SHELL
    local power = 50

    if mob:getZone():getType() == tpz.zoneType.DYNAMIS then
        typeEffect = tpz.effect.MAGIC_DEF_BOOST
        skill:setMsg(MobBuffMove(mob, typeEffect, power * 2, 0, 180))
        local effect = mob:getStatusEffect(tpz.effect.MAGIC_DEF_BOOST)
        effect:unsetFlag(tpz.effectFlag.DISPELABLE)
        -- addMod added twice due to limitation with core behavior with effect:addMod not adding a mod with the currect effect
        mob:addMod(tpz.mod.DMGMAGIC, -power)
        effect:addMod(tpz.mod.DMGMAGIC, -power)
    else
        skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 180))
    end

    return typeEffect
end
