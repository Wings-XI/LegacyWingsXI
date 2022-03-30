---------------------------------------------------
-- Magic Mortar
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/automatonweaponskills")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:getID() == 17072171) then -- Ob
        if (mob:getHPP() > 50) then
            return 1 -- only used under 50%
        end
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local ftp
    local tp = skill:getTP()

    -- going with guess work based on reports - and using Ob's 14k max hp for scaling
    -- starts using it at 50%, or 7k/7 = 1k dmg
    -- max damage is ~2k at 1hp
    local damage = (mob:getMaxHP() - mob:getHP()) / 7
    

    if damage > 0 then
       damage = damage + math.random(1,99) -- add variance
       target:addTP(20)
       mob:addTP(80)
       target:tryInterruptSpell(mob, 1)
    end

    target:takeDamage(damage, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    return damage
end
