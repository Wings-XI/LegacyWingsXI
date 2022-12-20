---------------------------------------------------
-- Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in his path.
-- No message is displayed in the chat log.
--
-- This move is triggered during onMobFight and is only advertised by the fact that DI runs towards random players in range
--
-- When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
--     Can be avoided easily by moving out of its path.
--     May charge in the opposite, or an entirely random, direction from the one he is currently facing.
--     Will load a set number of targets in his path before ramming forward. Occasionally,
--     a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3
    local MPL = math.random(10,30)/100
    local cMP = target:getMP()
    local newMP = cMP - cMP*MPL

    local typeEffect = tpz.effect.BIND
    local duration = 30


    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, duration)
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    target:setMP(newMP)
    skill:setMsg(tpz.msg.basic.HIT_DMG)
    return dmg
end