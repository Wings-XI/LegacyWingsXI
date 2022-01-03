-----------------------------------
-- Area: Temenos
--  Mob: Temenos Ghrah
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DMGPHYS, 25)
    mob:addMod(tpz.mod.DMGMAGIC, -40)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("lootSpawned", 0)
        GetNPCByID(ID.npc.TEMENOS_C_CRATE[5]):setStatus(tpz.status.NORMAL)
    end
end
