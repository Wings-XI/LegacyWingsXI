-----------------------------------------
-- Spell: Helldive
-- Damage varies with TP
-- Spell cost: 16 MP
-- Monster Type: Birds
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: CHR+1, HP+5
-- Level: 16
-- Casting Time: 0.5 seconds
-- Recast Time: 11.25 seconds
-- Skillchain Property: Transfixion (can open Compression, Reverberation, or Distortion)
-- Combos: None
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
    params.eco = ECO_BIRD
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_TRANSFIXION
    params.spellLevel = 16
    params.numhits = 1
    params.multiplier = 3.3
    params.tp150 = 3.7
    params.tp300 = 4.1
    params.azuretp = 4.23
    params.duppercap = 19
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)
    
    -- todo: proper knockback tech requires navmesh work. for now, it's just a 1 second stun to still interrupt mob skills/spells
    -- per Mattyg's research, apparently the knockback itself can be resisted so we have to pass a resist check
    params = {}
    params.eco = ECO_NONE
    params.diff = caster:getStat(tpz.mod.STR) - target:getStat(tpz.mod.VIT)
    params.attribute = tpz.mod.STR
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistanceEffect(caster, target, spell, params)
    if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.STUN) then
        target:addStatusEffect(tpz.effect.STUN, 1, 0, 1)
    end

    return damage
end
