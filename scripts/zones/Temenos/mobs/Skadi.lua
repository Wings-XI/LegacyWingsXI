-----------------------------------
-- Area: Temenos N T
--  Mob: Skadi
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    mob:setLocalVar('charmed', 0)
    mob:setLocalVar('charmhp', math.random(45,55))
    mob:setTrueDetection(1)
end

function onMobFight(mob, target)
    if mob:getHPP() < mob:getLocalVar('charmhp') and mob:getLocalVar('charmed') == 0 then
        mob:useMobAbility(710)
        mob:setLocalVar('charmed', 1)
    end
end

function onMobEngaged(mob, target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[2]+2):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[2]+1):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[2]+1):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[2]+2):isDead() then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
