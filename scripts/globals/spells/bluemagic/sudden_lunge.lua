-----------------------------------------
-- Spell: Sudden Lunge
-- Damage varies with TP. Additional effect: "Stun."
-- Spell cost: 18 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5 MP-5 DEX+1 AGI+1
-- Level: 95
-- Casting Time: 0.5 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s):
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
    params.eco = ECO_VERMIN
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = -10
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    local params = {}
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_DETONATION
    params.numhits = 1
    params.multiplier = 1.0
    params.tp150 = 1.25
    params.tp300 = 1.50
    params.azuretp = 1.6
    params.duppercap = 100
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.4
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if resist >= 0.25 and not target:hasStatusEffect(tpz.effect.STUN) then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, 20 * resist) -- wiki says 20 sec max
        end
    end

    return damage
end
