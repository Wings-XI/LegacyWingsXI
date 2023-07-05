-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Fairy Ring
--   ID: 16937100
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

function onMobSpawn(mob)
    dynamis.setNMStats(mob)

    -- Set Mods
    mob:speed(80) -- flee speed
    mob:setMod(tpz.mod.MDEF, 30)
    mob:setMod(tpz.mod.MEVA, 30)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    mob:SetMobSkillAttack(5021)
end
