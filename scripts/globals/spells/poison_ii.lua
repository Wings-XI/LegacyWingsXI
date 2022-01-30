-----------------------------------------
-- Spell: Poison
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if target:getMod(tpz.mod.STATUSRES) >= 100 or target:getMod(tpz.mod.POISONRES) >= 100 then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return tpz.effect.POISON
    end
    
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    local skill = caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC)

    -- Rough Estimated Cap for 2010 is 10/tick (https://www.bg-wiki.com/index.php?title=Poison_II&oldid=54561 and https://ffxiclopedia.fandom.com/wiki/Poison_II?oldid=988334)
    -- Previous caps were not implemented until 2012.
    -- Increased floor of Poison II to 5 (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129421&id=833)
    local power = math.floor((skill / 30), 5, 10)
    power = calculatePotency(power, spell:getSkillType(), caster, target)

    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)

    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.POISON
    local resist = applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then -- effect taken
        if target:addStatusEffect(params.effect, power, 3, duration * resist) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else -- resist entirely.
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return params.effect
end
