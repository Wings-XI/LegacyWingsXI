-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Bompupu
--  Involved in Mission: Enemy of the Empire (II) - A Shantotto Ascension
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setSpellList(0)
    mob:setLocalVar("UtsuSpam", 0)
    mob:setLocalVar("targetPhase", 0)
    mob:setLocalVar("utsuWaitTime", os.time() + 5)
    mob:addMod(tpz.mod.UDMGMAGIC, -101)
    mob:addMod(tpz.mod.UDMGPHYS, -101)
    mob:addMod(tpz.mod.UDMGRANGE, -101)
    mob:setMobMod(tpz.mobMod.SPECIAL_SKILL, 0) -- ranged attacks disabled
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 8)
    mob:SetMobAbilityEnabled(false)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(true)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
end

function onMobFight(mob, target)
    mob:setLocalVar("spawner", target:getID())
    local utsuCount = mob:getLocalVar("utsuSpam")
    local targetPhase = mob:getLocalVar("targetPhase")
    local utsuWait = mob:getLocalVar("utsuWaitTime")

    if targetPhase == 0 and utsuCount == 0 then
        mob:setLocalVar("utsuSpam", 4)
    elseif utsuCount <= 4 and utsuCount > 1 and targetPhase == 0 and os.time() > utsuWait then
        mob:castSpell(339, mob)
        mob:setLocalVar("utsuWaitTime", os.time() + 4)
        mob:setLocalVar("utsuSpam", utsuCount - 1)
    elseif utsuCount == 1 and targetPhase == 0 and os.time() > utsuWait then
        mob:setLocalVar("targetPhase", 1)
        mob:setLocalVar("utsuWaitTime", os.time() + 10)
        for i = ID.mob.BOMPUPU + 1, ID.mob.BOMPUPU + 3 do
            SpawnMob(i)
            GetMobByID(i):updateEnmity(target)
            GetMobByID(i):addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
        end
    end

    if targetPhase >= 1 and os.time() > utsuWait then
        for i = ID.mob.BOMPUPU + 1, ID.mob.BOMPUPU + 3 do
            if not GetMobByID(i):isSpawned() then
                mob:castSpell(339, mob)
                SpawnMob(i)
                GetMobByID(i):addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
                GetMobByID(i):updateEnmity(target)
                mob:setLocalVar("utsuWaitTime", os.time() + 10)
            end
        end
    end

    -- print(GetMobByID(ID.mob.RENFRED):getLocalVar("clonesDead"))
    if GetMobByID(ID.mob.RENFRED):getLocalVar("clonesDead") >= 10 and targetPhase == 1 then
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        mob:SetMobAbilityEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:delMod(tpz.mod.UDMGMAGIC, -101)
        mob:delMod(tpz.mod.UDMGPHYS, -101)
        mob:delMod(tpz.mod.UDMGRANGE, -101)
        mob:untargetable(false)
        mob:setSpellList(0)
        mob:setLocalVar("targetPhase", 2)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:showText(mob, ID.text.ASA_BOMPUPU_DEATH)
    for i = ID.mob.BOMPUPU + 1, ID.mob.BOMPUPU + 3 do
        DespawnMob(i)
        for _, member in pairs(player:getAlliance()) do
            member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 2)
        end
    end

    local gorattz = GetMobByID(ID.mob.GORATTZ)
    local renfred = GetMobByID(ID.mob.RENFRED)
    local QM = GetNPCByID(ID.npc.OUTCROPPING_QM)
    local spawner = GetPlayerByID(mob:getLocalVar("spawner"))

    if not gorattz:isAlive() and not renfred:isAlive() then
        QM:setStatus(tpz.status.NORMAL)
        spawner:delPartyEffect(276) -- Remove Confrontation
        for _, member in pairs(spawner:getAlliance()) do
            member:setCharVar("ASA_enemyPhase", 2)
        end
    end
end

function onMobDespawn(mob)
    local gorattz = GetMobByID(ID.mob.GORATTZ)
    local renfred = GetMobByID(ID.mob.RENFRED)
    local QM = GetNPCByID(ID.npc.OUTCROPPING_QM)
    local spawner = GetPlayerByID(mob:getLocalVar("spawner"))

    if not gorattz:isAlive() and not renfred:isAlive() then
        QM:setStatus(tpz.status.NORMAL)
        spawner:delPartyEffect(276) -- Remove Confrontation
    end

    mob:resetLocalVars()
end