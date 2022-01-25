-----------------------------------------
-- Spell: Tail Slap
-- Delivers an area attack. Additional effect: "Stun." Damage varies with TP
-- Spell cost: 77 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: MND+2
-- Level: 69
-- Casting Time: 1 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element: Water (can open Impaction and Induration can close Reverberation and Fragmentation)
-- Combos: Store TP
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
    params.eco = ECO_NONE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.H2H
    params.scattr = SC_REVERBERATION
    params.spellLevel = 69
    params.numhits = 1
    params.multiplier = 1.625
    params.tp150 = 1.625
    params.tp300 = 1.625
    params.azuretp = 1.625
    params.att0 = 1.0
    params.att150 = 1.5
    params.att300 = 2.0
    params.azureatt = 2.25
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.5
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)

    params = {}
    params.eco = ECO_NONE
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)

    local duration =  math.ceil(4 * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if resist >= 0.25 and not target:hasStatusEffect(tpz.effect.STUN) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, math.ceil(duration*resist))
    end

    return damage
end
