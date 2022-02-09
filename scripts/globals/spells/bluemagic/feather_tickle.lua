-----------------------------------------
-- Spell: Feather Tickle
-- Reduces an enemy's TP
-- Spell cost: 48 MP
-- Monster Type: Birds
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: AGI+1
-- Level: 64
-- Casting Time: 4 seconds
-- Recast Time: 26 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Clear Mind
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.eco = ECO_BIRD
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = caster:getMerit(tpz.merit.MAGICAL_ACCURACY)
    local resist = applyResistance(caster, target, spell, params)
    local power = math.random(200, 300)

    if target:getTP() == 0 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    elseif resist < 0.5 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    else
        target:delTP(power*resist)
        spell:setMsg(tpz.msg.basic.MAGIC_TP_REDUCE)
        -- caster:PrintToPlayer(string.format("Tickled for %u TP.",power*resist))
    end

    return 0
end
