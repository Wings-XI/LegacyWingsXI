-----------------------------------------
-- Spell: Mind Blast
-- Deals lightning damage to an enemy. Additional effect: Paralysis
-- Spell cost: 82 MP
-- Monster Type: Demons
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: MP+5 MND+1
-- Level: 73
-- Casting Time: 3 seconds
-- Recast Time: 30 seconds
-- Magic Bursts on: Impaction, Fragmentation, and Light
-- Combos: Clear Mind
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
    params.eco = ECO_DEMON
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.LIGHTNING
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getStatusEffect(tpz.effect.CONVERGENCE) == nil and 0 or (caster:getStatusEffect(tpz.effect.CONVERGENCE)):getPower()
    params.multiplier = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 4.7 or 3.6
    params.tMultiplier = 1.5
    params.duppercap = 69
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    params.effect = tpz.effect.PARALYSIS

    if caster:hasStatusEffect(tpz.effect.AZURE_LORE) then
        params.multiplier = params.multiplier + 0.50
    end
    
    local resist = applyResistanceEffect(caster, target, spell, params)
    local damage = BlueMagicalSpell(caster, target, spell, params, MND_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    -- Per BG wiki and wikiwiki.jp - 90s duration
    local duration = math.ceil(90 * tryBuildResistance(tpz.mod.RESBUILD_PARALYZE, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.PARALYZERES) < 100 then
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.PARALYSIS) then
            target:addStatusEffect(tpz.effect.PARALYSIS, 20, 0, duration*resist) -- https://www.bg-wiki.com/bg/Mind_Blast 20%
        end
    end

    return damage
end
