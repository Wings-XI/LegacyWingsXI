-----------------------------------
-- Area: Apollyon SW
--  Mob: Dark Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DMGPHYS, 100)
    mob:addMod(tpz.mod.DMGMAGIC, -40)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobEngaged(mob, target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+1):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+9):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+17):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if tpz.limbus.elementalsDead() then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(tpz.status.NORMAL)
        end
    end
end

