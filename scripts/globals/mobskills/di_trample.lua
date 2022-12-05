--[[

Trample: Charges forward, dealing high damage to,(400-1000) and lowering the MP (10-30%) of, anyone in his path. 
No message is displayed in the chat log.

    When Dark Ixion's HP is low, he can do up to 3 Tramples in succession.
    Can be avoided easily by moving out of its path.
    May charge in the opposite, or an entirely random, direction from the one he is currently facing.
    Will load a set number of targets in his path before ramming forward. Occasionally,
    a person in his path will not be hit, as well as those wandering in its path after it has begun its charge.]]


function onMobSkillCheck(target, mob, skill)
    if mob:getLocalVar("charging") == 1 then
        return 0
    else
        return 1
    end
end


function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.3


    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    skill:setMsg(tpz.msg.basic.HIT_DMG)
    return dmg
end