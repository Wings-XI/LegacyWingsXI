-----------------------------------------
-- Spell: Queasyshroom
-- Additional effect: Poison. Duration of effect varies with TP
-- Spell cost: 20 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 8
-- Casting Time: 2 seconds
-- Recast Time: 15 seconds
-- Skillchain Element(s): Dark (can open Transfixion or Detonation can close Compression or Gravitation)
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
    params.eco = ECO_PLANTOID
    params.attackType = tpz.attackType.RANGED
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_DARK
    params.numhits = 1
    params.multiplier = 1.25
    params.tp150 = 1.25
    params.tp300 = 1.25
    params.azuretp = 1.25
    params.duppercap = 15
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.20
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    
    target:delStatusEffect(tpz.effect.BLINK)
    target:delStatusEffect(tpz.effect.UTSUSEMI)

    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    params = {}
    params.eco = ECO_PLANTOID
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(30 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target))
    local bonus = resist * (caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and caster:getTP()/50 or 0))

    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
        if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.POISON) then
            local BLUlvl = caster:getMainLvl()
            if caster:getMainJob() ~= tpz.job.BLU then BLUlvl = caster:getSubLvl() end
            local power = 3 + math.floor(BLUlvl/15)
            target:addStatusEffect(tpz.effect.POISON, power, 0, duration*resist + bonus)
        end
    end

    return damage
end
