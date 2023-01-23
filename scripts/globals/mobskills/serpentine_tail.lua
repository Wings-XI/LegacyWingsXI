---------------------------------------------
--  Serpentine Tail
--
--  Description: Deals heavy damage to a target behind the user.
--  Type: Physical
--  2-3 Shadows
--  Range: Back
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if (mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()

        if (mobSkin == 1796) then
            return 0
        else
            return 1
        end
    else
        -- Can always use, only if target is behind and not exclusive like spike flail
        if target:isBehind(mob, 96) then
            return 0
        else
            return 1
        end
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 2
    local dmgmod = 5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 2, 3, 4)
    local dmg = 0

    if info.hitslanded > 0 then
        dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)
    else
        skill:setMsg(tpz.msg.basic.EVADES)
        return
    end
	if skill:getMsg() ~= tpz.msg.basic.SHADOW_ABSORB then
        target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
        skill:setMsg(tpz.msg.basic.HIT_DMG)
        if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    end
    return dmg
end
