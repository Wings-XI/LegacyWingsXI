-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM T1: Chigre
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
-- https://ffxiclopedia.fandom.com/wiki/Chigre
-- Immune to Bind and Gravity. Susceptible to Stun, Slow, Paralyze, Blind, and Poison.
-- Todo: add enailments, Drain samba on target if all ailments on, very fast enmity decay, capture speed
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.MOVE, 12)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
end

function onMobDeath(mob, player, isKiller)
end

function onAdditionalEffect(mob, target, damage)
    -- Blind, Poison, Paralyze, Slow, Petrification, Silence, Drain, Curse, and Plague.

    local effects = { } 
    if not target:hasStatusEffect(tpz.effect.BLINDNESS) then
        table.insert(effects, tpz.mob.ae.BLIND)
    end
    if not target:hasStatusEffect(tpz.effect.POISON) then
        table.insert(effects, tpz.mob.ae.POISON)
    end
    if not target:hasStatusEffect(tpz.effect.PARALYSIS) then
        table.insert(effects, tpz.mob.ae.PARALYZE)
    end
    if not target:hasStatusEffect(tpz.effect.SLOW) then
        table.insert(effects, tpz.mob.ae.SLOW)
    end
    if not target:hasStatusEffect(tpz.effect.PETRIFICATION) then
        table.insert(effects, tpz.mob.ae.PETRIFY)
    end
    if not target:hasStatusEffect(tpz.effect.SILENCE) then
        table.insert(effects, tpz.mob.ae.SILENCE)
    end
    if not target:hasStatusEffect(tpz.effect.CURSE_I) then
        table.insert(effects, tpz.mob.ae.CURSE)
    end
    if not target:hasStatusEffect(tpz.effect.PLAGUE) then
        table.insert(effects, tpz.mob.ae.PLAGUE)
    end

    --printf("effectscount %s", #effects)
    if #effects == 0 then
        local params = { }
        params.chance = 100
        params.power = 80
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, params)
    end

    local params = { }
    params.duration = 120
    local effect = effects[math.random(#effects)]
    if (effect == tpz.mob.ae.SLOW) then params.power = 1501 end -- force overwrite haste
    return tpz.mob.onAddEffect(mob, target, damage, effect, params)
end