-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Renfred
--  Involved in Mission: Enemy of the Empire (II) - A Shantotto Ascension
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("UtsuSpam", 0)
    mob:setLocalVar("clonesDead", 0)
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
    mob:untargetable(true)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.ASA_BATTLE_START)
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
        mob:setLocalVar("cloneTimer", os.time() + 1)
    elseif utsuCount == 1 and targetPhase == 0 and os.time() > utsuWait and os.time() >= mob:getLocalVar("cloneTimer") then
        mob:setLocalVar("targetPhase", 1)
        mob:setLocalVar("utsuWaitTime", os.time() + 10)
        mob:setLocalVar("cloneTimer", 0)
        local pos = mob:getPos()
        local move = 0
        for i = ID.mob.RENFRED + 1, ID.mob.RENFRED + 3 do
            move = move + 1
            local clone = GetMobByID(i)
            if not clone:isSpawned() then
                clone:setSpawn(pos.x + move, pos.y - 0.5, pos.z - move, pos.rot)
                clone:spawn()
                clone:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
                clone:updateEnmity(target)
            end
        end
    end

    if targetPhase >= 1 and os.time() > utsuWait and
       (not GetMobByID(ID.mob.RENFRED + 1):isSpawned() or
        not GetMobByID(ID.mob.RENFRED + 2):isSpawned() or
        not GetMobByID(ID.mob.RENFRED + 3):isSpawned()) then

        if mob:getLocalVar("cloneTimer") == 0 then
            mob:castSpell(339, mob)
            mob:setLocalVar("utsuWaitTime", os.time() + 10)
            mob:setLocalVar("cloneTimer", os.time())
        end
        if os.time() > mob:getLocalVar("cloneTimer") then
            mob:setLocalVar("utsuWaitTime", os.time() + 10)
            mob:setLocalVar("cloneTimer", 0)
            local pos = mob:getPos()
            local move = 0
            for i = ID.mob.RENFRED + 1, ID.mob.RENFRED + 3 do
                move = move + 1
                local clone = GetMobByID(i)
                if not clone:isSpawned() then
                    clone:setSpawn(pos.x + move, pos.y - 0.5, pos.z - move, pos.rot)
                    clone:spawn()
                    clone:addStatusEffect(tpz.effect.CONFRONTATION, 10, 0, 600)
                    clone:updateEnmity(target)
                end
            end
        end
    end

    if mob:getLocalVar("clonesDead") >= 10 and targetPhase == 1 then
        mob:delMod(tpz.mod.UDMGMAGIC, -101)
        mob:delMod(tpz.mod.UDMGPHYS, -101)
        mob:delMod(tpz.mod.UDMGRANGE, -101)
        mob:showText(mob, ID.text.ASA_MID_BATTLE)
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
        mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
        mob:SetMobAbilityEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:untargetable(false)
        mob:setLocalVar("targetPhase", 2)
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller or isKiller == nil then
        mob:showText(mob, ID.text.ASA_RENFRED_DEATH)

        local spawner = GetPlayerByID(mob:getLocalVar("spawner"))
        for i = ID.mob.RENFRED + 1, ID.mob.RENFRED + 3 do
            DespawnMob(i)
            for _, member in pairs(spawner:getAlliance()) do
                member:messageSpecial(ID.text.ASA_SHADOW_DEATH, 1)
            end
        end

        local gorattz = GetMobByID(ID.mob.GORATTZ)
        local bompupu = GetMobByID(ID.mob.BOMPUPU)
        local QM = GetNPCByID(ID.npc.OUTCROPPING_QM)
        if not gorattz:isAlive() and not bompupu:isAlive() then
            QM:setStatus(tpz.status.NORMAL)
            spawner:delPartyEffect(276) -- Remove Confrontation
            for _, member in pairs(spawner:getAlliance()) do
                member:setCharVar("ASA_enemyPhase", 2)
                local now = tonumber(os.date("%j"))
                local lastCactuar = member:getCharVar("LastCactuarKey")
                if not member:hasKeyItem(tpz.ki.CACTUAR_KEY) and now ~= lastCactuar and member:getCurrentMission(ASA) >= tpz.mission.id.asa.ENEMY_OF_THE_EMPIRE_II and member:getLocalVar("hadBook") == 1 then
                    member:setCharVar("LastCactuarKey", os.date("%j"))
                    member:addKeyItem(tpz.ki.CACTUAR_KEY)
                    member:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CACTUAR_KEY)
                    member:setLocalVar("hadBook", 0)
                end
            end
        end
    end
end

function onMobDespawn(mob)
    local gorattz = GetMobByID(ID.mob.GORATTZ)
    local bompupu = GetMobByID(ID.mob.BOMPUPU)
    local QM = GetNPCByID(ID.npc.OUTCROPPING_QM)
    local spawner = GetPlayerByID(mob:getLocalVar("spawner"))

    if not gorattz:isAlive() and not bompupu:isAlive() then
        QM:setStatus(tpz.status.NORMAL)
        spawner:delPartyEffect(276) -- Remove Confrontation
    end

    mob:resetLocalVars()
end
