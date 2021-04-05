-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Chigre
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
-- https://ffxiclopedia.fandom.com/wiki/Chigre
-- Immune to Bind and Gravity. Susceptible to Stun, Slow, Paralyze, Blind, and Poison.
-- Todo: add enailments, Drain samba on target if all ailments on, very fast enmity decay, capture speed
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobDeath(mob, player, isKiller)
end

function onAdditionalEffect(mob, target, damage)
    -- Blind, Poison, Paralyze, Slow, Petrification, Silence, Drain, Curse, and Plague.

    local effects = { } 
    if not target:hasStatusEffect(tpz.effect.BLIND) then
        table.insert(effects, tpz.effect.BLIND)
    end
    if not target:hasStatusEffect(tpz.effect.POISON) then
        table.insert(effects, tpz.effect.POISON)
    end
    if not target:hasStatusEffect(tpz.effect.PARALYZE) then
        table.insert(effects, tpz.effect.PARALYZE)
    end
    if not target:hasStatusEffect(tpz.effect.SLOW) then
        table.insert(effects, tpz.effect.SLOW)
    end
    if not target:hasStatusEffect(tpz.effect.PETRIFICATION) then
        table.insert(effects, tpz.effect.PETRIFICATION)
    end
    if not target:hasStatusEffect(tpz.effect.SILENCE) then
        table.insert(effects, tpz.effect.SILENCE)
    end
    if not target:hasStatusEffect(tpz.effect.CURSE) then
        table.insert(effects, tpz.effect.CURSE)
    end
    if not target:hasStatusEffect(tpz.effect.PLAGUE) then
        table.insert(effects, tpz.effect.PLAGUE)
    end

    if #effects == 0 then
        local params = { }
        params.chance = 100
        params.power = 80
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, params)
    end

    local params = { }
    params.duration = 120
    return tpz.mob.onAddEffect(mob, target, damage, effects[math.random(#effects)], params)
end