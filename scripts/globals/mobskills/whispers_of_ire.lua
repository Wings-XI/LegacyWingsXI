---------------------------------------------------
-- Whispers of Ire
-- Delivers an area attack that drains 1-6 stats
-- TODO: Enable it to be used on self to remove debuffs
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobWeaponSkill(target, mob, skill)
    if mob:getPool() == 5730 then -- Blighting Brand, remove all debuffs
        local removables =
        {
            tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.MAX_HP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.PARALYSIS,tpz.effect.POISON,
            tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND,
            tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK,
            tpz.effect.DROWN, tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN,
            tpz.effect.MND_DOWN, tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN,
            tpz.effect.ATTACK_DOWN, tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN,
            tpz.effect.MAGIC_EVASION_DOWN, tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.SILENCE,
        }

        for _, effect in ipairs(removables) do
            if mob:hasStatusEffect(effect) then
                mob:delStatusEffect(effect)
            end
        end
    end

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

    local drained = math.random(2, 6)

    for i=1, drained do
        local typeEffect = table.remove(effects, math.random(1, #effects))
        skill:setMsg(MobDrainAttribute(mob, target, typeEffect, 26, 3, 80))
    end

    return drained
end
