-----------------------------------------
-- Spell: Frypan
-- Delivers an area attack. Additional effect: "Stun." Accuracy varies with TP
-- Spell cost: 65 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 63
-- Casting Time: 1 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Lightning (can open Liquefaction or Detonation can close Impaction or Fusion)
-- Combos: Max HP Boost
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
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_IMPACTION
    params.spellLevel = 63
    params.numhits = 1
    params.multiplier = 3.5
    params.tp150 = 3.5
    params.tp300 = 3.5
    params.azuretp = 3.5
    params.duppercap = 75
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.2
    params.chr_wsc = 0.0
    params.bonusacc = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and math.floor(caster:getTP()/50) or nil)
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)
    
    params = {}
    params.eco = ECO_NONE
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    
    local duration = math.ceil(4 * resist * tryBuildResistance(tpz.mod.RESBUILD_STUN, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.STUNRES) < 100 then
        if resist >= 0.25 and not target:hasStatusEffect(tpz.effect.STUN) then
            target:addStatusEffect(tpz.effect.STUN, 1, 0, duration)
        end
    end

    return damage
end
