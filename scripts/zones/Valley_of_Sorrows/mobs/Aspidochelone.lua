-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function intoShell(mob)
    mob:SetMobAbilityEnabled(false)
    local chance = math.random(5,10)
    local changeHP = mob:getLocalVar("changeHP")
    if mob:getHPP() < changeHP then
        local changeHP = changeHP - chance
        mob:setLocalVar("changeHP", changeHP) -- record HP going into shell
    end
    mob:setLocalVar("changeTime", os.time() + 90) -- Time to come out of shell
    mob:AnimationSub(1)
    mob:setMod(tpz.mod.REGEN, 150)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(tpz.mod.UDMGRANGE, -95)
    mob:setMod(tpz.mod.UDMGPHYS, -95)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function outOfShell(mob)
    mob:SetMobAbilityEnabled(true)
    local chance = math.random(5,10)
    local changeHP = mob:getLocalVar("changeHP")
    local changeHP = changeHP - chance
    mob:setLocalVar("changeHP", changeHP) -- record HP coming out of shell
    if mob:AnimationSub() == 1 then
        mob:AnimationSub(2)
    else
        mob:AnimationSub(0)
    end
    mob:setMod(tpz.mod.REGEN, 0)
    mob:SetAutoAttackEnabled(true)
    mob:setMod(tpz.mod.UDMGRANGE, 0)
    mob:setMod(tpz.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
end

function onMobSpawn(mob)
    if LandKingSystem_NQ > 0 or LandKingSystem_HQ > 0 then
        GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(tpz.status.DISAPPEAR)
    end

    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMod(tpz.mod.DMGMAGIC,-35)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("changeHP", 100)
    outOfShell(mob)
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local changeHP = mob:getLocalVar("changeHP")
    local act = mob:getCurrentAction()
    local changeTime = mob:getLocalVar("changeTime")
    local waitTime = mob:getLocalVar("waitTime")
    if hpp <= changeHP then -- will go in and out of shell after being brought down 5% hp
        if (mob:AnimationSub() == 2 or mob:AnimationSub() == 0) and os.time() > waitTime then
            print("Into Shell")
            intoShell(mob)
            mob:setLocalVar("waitTime", os.time() + 2)
        elseif mob:AnimationSub() == 1 and (act ~= tpz.act.MAGIC_START or act ~= tpz.act.MAGIC_CASTING) and os.time() > waitTime then
            print("Out of Shell")
            outOfShell(mob)
            mob:setLocalVar("waitTime", os.time() + 2)
        end
    elseif (hpp == 100 or os.time() > changeTime) and mob:AnimationSub() == 1 and os.time() > waitTime then
        print("Forced out")
        outOfShell(mob)
        mob:setLocalVar("waitTime", os.time() + 2)
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ASPIDOCHELONE_SINKER)
end

function onMobDespawn(mob)
    -- Set Aspidochelone's Window Open Time
    if LandKingSystem_HQ ~= 1 then
        local wait = 72 * 3600
        SetServerVariable("[POP]Aspidochelone", os.time() + wait) -- 3 days
        if LandKingSystem_HQ == 0 then -- Is time spawn only
            DisallowRespawn(mob:getID(), true)
        end
    end

    -- Set Adamantoise's spawnpoint and respawn time (21-24 hours)
    if LandKingSystem_NQ ~= 1 then
        SetServerVariable("[PH]Aspidochelone", 0)
        DisallowRespawn(ID.mob.ADAMANTOISE, false)
        UpdateNMSpawnPoint(ID.mob.ADAMANTOISE)
        GetMobByID(ID.mob.ADAMANTOISE):setRespawnTime(75600 + math.random(0, 6) * 1800) -- 21 - 24 hours with half hour windows
    end
end
