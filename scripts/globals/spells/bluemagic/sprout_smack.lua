-----------------------------------------
-- Spell: Sprout Smack
-- Additional effect: Slow. Duration of effect varies with TP
-- Spell cost: 6 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 2
-- Stat Bonus: MND+1
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain property: Reverberation (can open Induration or Impaction)
-- Combos: Beast Killer
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DURATION
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_REVERBERATION
    params.numhits = 1
    params.multiplier = 1.5
    params.tp150 = 1.5
    params.tp300 = 1.5
    params.azuretp = 1.5
    params.duppercap = 11
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.3
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.SA = 1.3
	params.eco = tpz.ecosystem.PLANTOID
    damage = BluePhysicalSpell(caster, target, spell, params)
    if damage == 0 then
		return 0
	end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
    
    local resist = applyResistanceAbility(caster,target,tpz.magic.element.EARTH,tpz.skill.BLUE_MAGIC,bonus)
    
    local duration = math.ceil(60 * resist * tryBuildResistance(tpz.mod.RESBUILD_SLOW, target))
    if not target:hasStatusEffect(tpz.effect.SLOW) and resist >= 0.5 then
        local power = 1000
        local cMND = caster:getStat(tpz.mod.MND)
        local tMND = target:getStat(tpz.mod.MND)
        if cMND < tMND then
            power = power - (tMND - cMND)*40
            if power < 300 then
                power = 300
            end
        end

        target:addStatusEffect(tpz.effect.SLOW, power, 0, duration)
    end

    return damage
end
