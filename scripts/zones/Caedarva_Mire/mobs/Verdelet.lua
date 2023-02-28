-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Verdelet
-- !pos 417 -19.3 -70 79
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobInitialize(mob)
    -- do not add immunity, as the onMobFight workaround will stop working
    mob:addMod(tpz.mod.SILENCERES, 101)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)

    -- take less damage
    mob:setMod(tpz.mod.DMGPHYS, -33)
    mob:setMod(tpz.mod.DMGMAGIC, -33)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UFASTCAST, 50) -- Appears to have 50% FC from capture.
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 80)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 12) -- Sets recast time in line with capture.

    mob:setLocalVar("horn", 0)
end

function onMobFight(mob, target)
    local horn = mob:AnimationSub()

    if horn == 1 then
        mob:timer(30000, function(mob)
            mob:AnimationSub(0)
        end)
        mob:setSpellList(549)
    else
        mob:setSpellList(539)
    end

    -- TODO: fix core mob_controller.cpp to close the gap if only offensive spells in spell list and mob's spell cooldown is ready
    -- action 30 is spell casting
    local targDistance = mob:checkDistance(target)
    if mob:getCurrentAction() ~= 30 and (targDistance > 23 or mob:getMP() < 200) then
        mob:addStatusEffect(tpz.effect.SILENCE, 1, 0, 30)
    elseif mob:hasStatusEffect(tpz.effect.SILENCE) and targDistance < 10 then
        mob:delStatusEffectSilent(tpz.effect.SILENCE)
    end
end

function onMobDeath(mob, player, isKiller)
end