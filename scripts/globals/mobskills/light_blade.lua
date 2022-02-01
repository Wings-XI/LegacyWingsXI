---------------------------------------------
--  Light Blade
--  Description: Deals very high physical damage to a single player.
--  Type: Ranged
--  Damage decreases the farther away the target is from Kam'lanaut.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 7
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.SLASHING, info.hitslanded)
    if mob:getID() == 16924679 then -- Apoc Nigh Damage Change
        -- Adding in a clamp to set minimum damage. This is due to the way the skill
        -- is currently setup as at times it will do little to no damage.
        -- https://www.youtube.com/watch?v=mG-qyhGOqNY&ab_channel=Smackdownbob
        dmg = utils.clamp(dmg, 450, 1200)
    end
    -- TODO: There's no MOBPARAM_RANGED, but MOBPARAM doesn't appear to do anything?
    -- Guessing ~40-100% damage based on range (20/50+).
    -- TODO: Find better data?
    -- ~400-450ish at tanking/melee range for a PLD with defender up and earth staff.
    -- ~750 for a DRG/BLU w/o Cocoon up at melee range.
    -- Wiki says 1k, videos were actually less, so trusting videos.
    local distance = mob:checkDistance(target)
    distance = utils.clamp(distance, 0, 40)
    dmg = dmg * ((50 - distance) / 50)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.SLASHING)
	if dmg > 0 and skill:getMsg() ~= 31 then target:tryInterruptSpell(mob, info.hitslanded) end
    return dmg
end
