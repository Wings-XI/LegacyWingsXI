-----------------------------------
-- Area: Temenos
--  Mob: Orichalcum Quadav
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1) -- allows carby pulls due to NMs not having a neutral timer
end

function onMobEngaged(mob, target)
    if GetMobByID(ID.mob.TEMENOS_C_MOB[3]+12):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+13):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3]+14):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+15):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3]+16):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+17):isDead()
    then
        mob:setMod(tpz.mod.SLASHRES, 1400)
        mob:setMod(tpz.mod.PIERCERES, 1400)
        mob:setMod(tpz.mod.IMPACTRES, 1400)
        mob:setMod(tpz.mod.H2HRES, 1400)
    else
        mob:setMod(tpz.mod.SLASHRES, 300)
        mob:setMod(tpz.mod.PIERCERES, 300)
        mob:setMod(tpz.mod.IMPACTRES, 300)
        mob:setMod(tpz.mod.H2HRES, 300)
    end
    GetMobByID(ID.mob.TEMENOS_C_MOB[3]):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_C_MOB[3]+2):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_C_MOB[3]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+1):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[3]+2):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(tpz.status.NORMAL)
        end
    end
end
