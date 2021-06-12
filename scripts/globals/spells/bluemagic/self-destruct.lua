-----------------------------------------
-- Spell: Self-Destruct
-- Sacrifices HP to damage enemies within range. Affects caster with Weakness
-- Spell cost: 100 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2
-- Level: 50
-- Casting Time: 3.25 seconds
-- Recast Time: 21 seconds
-- Magic Bursts on: Liquefaction, Fusion, and Light
-- Combos: Auto Refresh
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if caster:hasStatusEffect(tpz.effect.WEAKNESS) then return 17 end
    caster:setLocalVar("self-destruct_hp", caster:getHP())
    return 0
end

function onSpellCast(caster, target, spell)
    local HP = caster:getLocalVar("self-destruct_hp")
    local params = {}
    params.eco = ECO_ARCANA
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.FIRE
    params.multiplier = 1 + HP/180
    params.tMultiplier = 1 + HP/180
    params.duppercap = 500
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.2
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.ignoreMTDR = true
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    --print(string.format("self-destruct damage %u (before HP capped)",damage))
    if damage > HP then damage = HP end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    caster:setHP(1)
    caster:delStatusEffect(tpz.effect.WEAKNESS)
    caster:addStatusEffect(tpz.effect.WEAKNESS, 1, 0, 300)

    return damage
end
