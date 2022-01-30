-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Beach Monk
-- Spawned During Pirates Chart Quest
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/status")
-----------------------------------

function OnWipe(mob, spawner)
    mob = GetMobByID(ID.mob.BEACH_MONK)
    spawner = GetPlayerByID(mob:getLocalVar("spawner"))

    local QM = GetNPCByID(ID.npc.PIRATE_CHART_QM)
    local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
    if QM:getLocalVar("lostinterest") == 0 and spawner:getHPP() == 0 then
        QM:setLocalVar("lostinterest", 1)
        QM:showText(QM, ID.text.TOO_MUCH_TIME_PASSED)        
    end
    spawner:delPartyEffect(143) --Remove Level Restriction
    spawner:delPartyEffect(276) -- Remove Confrontation
    shimmering:setStatus(tpz.status.DISAPPEAR)
    local party = spawner:getParty()   
    for _,member in pairs(party) do
        member:ChangeMusic(0, 0)
        member:ChangeMusic(1, 0)
        member:ChangeMusic(2, 101)
        member:ChangeMusic(3, 102)
        member:setLocalVar("Chart", 0)
    end     
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 0)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 8)
    mob:setLocalVar("spawner", 0)
    local QM = GetNPCByID(ID.npc.PIRATE_CHART_QM)
    QM:setLocalVar("lostinterest", 0)
end

function onMobFight(mob, target)
    mob:setLocalVar("spawner", target:getID())
    local twohour = mob:getLocalVar("twohour")

    if(mob:getHPP() < 50 and twohour == 0 and not mob:hasStatusEffect(tpz.effect.MEDICINE)) then -- Mithra Snare prevents 2hr usage
        mob:useMobAbility(690)
        mob:setLocalVar("twohour", 1)
    end

    if mob:hasStatusEffect(tpz.effect.FOOD) then -- Tarutaru Snare lowers damage to 1 or 2, since we can't force that this is the best we can do
        mob:setDamage(0)
    end
end

function onMobDespawn(mob)
    local crab = GetMobByID(ID.mob.HEIKE_CRAB)
    local houu = GetMobByID(ID.mob.HOUU_THE_SHOALWADER)

    if not crab:isAlive() and not houu:isAlive() then
        OnWipe()
    end
end

function onMobDeath(mob, player)
    local crab = GetMobByID(ID.mob.HEIKE_CRAB)
    local houu = GetMobByID(ID.mob.HOUU_THE_SHOALWADER)
    local barnacle = GetNPCByID(ID.npc.BARNACLED_BOX)

    if not crab:isAlive() and not houu:isAlive() then
        barnacle:teleport(mob:getPos(), mob:getRotPos())
        barnacle:setLocalVar("leaderID", player:getLeaderID())
        barnacle:setStatus(tpz.status.NORMAL)
        barnacle:setLocalVar("open", 0)
        barnacle:timer(180000, function(barnacle) barnacle:setStatus(tpz.status.DISAPPEAR) end)
    end    
    mob:setLocalVar("twohour", 0)
end