-----------------------------------
--  Hydro Wave
--
--  Description: Fires a blast of Water, dealing damage in a fan-shaped area. Additional effect: Removes a single piece of equipment.
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Area of Effect (10 yalms)
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.WATER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WATER, MOBPARAM_WIPE_SHADOWS)

    -- take off a random piece of gear
    if target:isPC() then
        local slots = {}
        for i = tpz.slot.MAIN, tpz.slot.BACK do
            if target:getEquippedItem(i) ~= nil then
                table.insert(slots, i)
            end
        end

        if #slots > 0 then
            target:unequipItem(slots[math.random(1, #slots)])
        end
    end

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WATER)
    return dmg
end