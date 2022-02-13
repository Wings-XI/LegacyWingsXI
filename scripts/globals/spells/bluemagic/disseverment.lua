-----------------------------------------
-- Spell: Disseverment
-- Delivers a fivefold attack. Additional effect: Poison. Accuracy varies with TP
-- Spell cost: 74 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 5
-- Stat Bonus: INT+1, MND-1
-- Level: 72
-- Casting Time: 0.5 seconds
-- Recast Time: 32.75 seconds
-- Skillchain Element(s): Distortion (can open/close Darkness with Gravitation WSs and spells)
-- Combos: Accuracy Bonus
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
    params.eco = ECO_LUMINION
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_DISTORTION
    params.spellLevel = 72
    params.numhits = 5
    params.multiplier = 1.50
    params.tp150 = 1.50
    params.tp300 = 1.50
    params.azuretp = 1.50
    params.duppercap = 100
    params.att0 = 1.0
    params.att150 = 1.0
    params.att300 = 1.0
    params.azureatt = 1.0
    params.str_wsc = 0.2
    params.dex_wsc = 0.2
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.effect = tpz.effect.POISON
    params.bonusacc = caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and math.floor(caster:getTP()/50) or nil)
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params, taChar)
    
    params = {}
    params.eco = ECO_LUMINION
    params.diff = nil
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = math.ceil(180 * tryBuildResistance(tpz.mod.RESBUILD_POISON, target))
    if target:getMod(tpz.mod.STATUSRES) < 100 and target:getMod(tpz.mod.POISONRES) < 100 then
        if resist >= 0.5 and target:getStatusEffect(tpz.effect.POISON) == nil then
            local power = caster:getMainLvl()/5 + 3
            target:addStatusEffect(tpz.effect.POISON, power, 3, duration*resist)
        end
    end

    return damage
end
