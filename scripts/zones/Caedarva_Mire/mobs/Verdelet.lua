-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Verdelet
-- !pos 417 -19.3 -70 79
-----------------------------------
mixins = {require("scripts/mixins/families/imp")}
-----------------------------------

function onMobInitialize(mob)
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

function onMobFight(mob)
    local horn = mob:AnimationSub()

    if horn == 1 then
        mob:timer(30000, function(mob)
            mob:AnimationSub(0)
        end)
        mob:setSpellList(549)
    else
        mob:setSpellList(539)
    end
end

function onMobDeath(mob, player, isKiller)
end