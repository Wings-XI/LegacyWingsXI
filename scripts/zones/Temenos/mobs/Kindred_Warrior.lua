-----------------------------------
-- Area: Temenos N T
--  Mob: Kindred Warrior
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    mob:setTrueDetection(1)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1) -- allows carby pulls due to NMs not having a neutral timer
end

function onMobEngaged(mob,target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[4]+1):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[4]+2):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[4]+1):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[4]+2):isDead() then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[4]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[4]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[4]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
