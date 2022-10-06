-----------------------------------
-- Area: Apollyon SW
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    -- double phys dmg as the mob family has -75% of each phys dmg type, effectively making them take -50% pdt instead of normal -75% 
    mob:setMod(tpz.mod.DMGPHYS, 100)
    mob:setMod(tpz.mod.DMGMAGIC, -40)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobEngaged(mob, target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+8):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+16):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if tpz.limbus.elementalsDead() then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(tpz.status.NORMAL)
        end
    end
end
