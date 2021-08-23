---------------------------------------------
--  Wild Rage
--
--  Description: Deals physical damage to enemies within area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 15' radial
--  Notes: Has additional effect of Poison when used by King Vinegarroon.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

local PLATOON_SCORP_POOL_ID = 3157
local KING_VINEGARROON_POOL_ID = 2262

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.1
    
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    
    if mob:getPool() == PLATOON_SCORP_POOL_ID then
        info.dmg = info.dmg * mob:getLocalVar('WildRagePercent')/100 -- see Platoon_Scorpion.lua
    end
    
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)
    
    if mob:getPool() == KING_VINEGARROON_POOL_ID then
        MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.POISON, 25, 3, 60)
    end
    
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
