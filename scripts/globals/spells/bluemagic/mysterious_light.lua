-----------------------------------------
-- Spell: Mysterious Light
-- Deals wind damage to enemies within range. Additional effect: Weight
-- Spell cost: 73 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 4
-- Stat Bonus: AGI+3
-- Level: 40
-- Casting Time: 3.75 seconds
-- Recast Time: 24.5 seconds
-- Magic Bursts on: Detonation, Fragmentation, Light
-- Combos: Max MP Boost
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.eco = ECO_ARCANA
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.WIND
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 4.5 or 3.5
    params.tMultiplier = 1.0
    params.duppercap = 56
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.3
    params.effect = tpz.effect.WEIGHT

    local resist = applyResistanceEffect(caster, target, spell, params)
    local damage = BlueMagicalSpell(caster, target, spell, params, CHR_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    local duration = math.ceil(30 * tryBuildResistance(tpz.mod.RESBUILD_GRAVITY, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.GRAVITYRES) < 100 then
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.WEIGHT) then
            target:addStatusEffect(tpz.effect.WEIGHT, 26, 0, duration*resist) -- https://www.bg-wiki.com/ffxi/Mysterious_Light 26%
        end
    end

    return damage
end
