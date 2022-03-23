-----------------------------------------
-- Spell: Pinecone Bomb
-- Additional effect: Sleep. Duration of effect varies with TP
-- Spell cost: 48 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 36
-- Casting Time: 2.5 seconds
-- Recast Time: 26.5 seconds
-- Skillchain Element(s): Fire (can open Scission or Fusion and can close Liquefaction)
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0
end

function onSpellCast(caster,target,spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.SLEEPRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.SLEEP_I
    end

    local params = {}
    params.eco = ECO_PLANTOID
    params.attackType = tpz.attackType.RANGED
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_LIQUEFACTION
    params.numhits = 1
    params.multiplier = 2.25
    params.tp150 = 2.25
    params.tp300 = 2.25
    params.azuretp = 2.25
    params.duppercap = 37
    params.str_wsc = 0.20
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.20
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    
    local damage = 0
    local hitslanded = 0
    local taChar = nil
    damage, hitslanded, taChar = BluePhysicalSpell(caster, target, spell, params)
    if hitslanded == 0 then return 0 end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    local resparams = {}
    resparams.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    resparams.attribute = tpz.mod.INT
    resparams.skillType = tpz.skill.BLUE_MAGIC
    resparams.bonus = 0
    resparams.effect = tpz.effect.SLEEP_I
    local resist = applyResistanceEffect(caster, target, spell, resparams)

    local duration = math.ceil(math.random(15,30) * tryBuildResistance(tpz.mod.RESBUILD_SLEEP, target))
    local bonus = resist * (caster:hasStatusEffect(tpz.effect.AZURE_LORE) and 70 or (caster:hasStatusEffect(tpz.effect.CHAIN_AFFINITY) and caster:getTP()/50 or 0))
    
    if resist >= 0.5 and not target:hasStatusEffect(tpz.effect.SLEEP_I) and not target:hasStatusEffect(tpz.effect.SLEEP_II) and not target:hasStatusEffect(tpz.effect.LULLABY) then -- wont wake up if we hit their stoneskin!
        target:addStatusEffect(tpz.effect.SLEEP_I, 2, 0, duration+bonus)
    end

    return damage
end
