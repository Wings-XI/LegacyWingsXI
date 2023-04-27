---------------------------------------------------
-- Whispers of Ire
-- Delivers an area attack that drains 1-6 stats
-- TODO: Enable it to be used on self to remove debuffs
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if -- Blighting Brand, Nightmare Weapons
        mob:getPool() == 5730 or
        mob:getZone():getType() == tpz.zoneType.DYNAMIS
    then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local effects =
    { 
        tpz.effect.STR_DOWN,
        tpz.effect.DEX_DOWN,
        tpz.effect.VIT_DOWN,
        tpz.effect.AGI_DOWN,
        tpz.effect.INT_DOWN,
        tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN,
    }

    local drained = math.random(1, 6)

    for i=1, drained do
        local typeEffect = table.remove(effects, math.random(1, #effects))
        skill:setMsg(MobDrainAttribute(mob, target, typeEffect, 10, 3, 120))
    end

    return drained
end
