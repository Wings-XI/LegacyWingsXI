-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Dynamis Lord
-- Note: Mega Boss
-- Spawned by trading a Shrouded Bijou to the ??? in front of Castle Zvahl.
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.UFASTCAST, 100)
    SetServerVariable("MainDynaLord", ID.mob.DYNAMIS_LORD)
    mob:setLocalVar("tpTime", 0)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
    mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)

    tpz.mix.jobSpecial.config(mob, {
        between = 60,
        specials =
        {
            {id = tpz.jsa.HUNDRED_FISTS, hpp = 95, begCode = function(mob) mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOG +11) end},
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = 95, begCode = function(mob) mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOG +14) end},
            {id = tpz.jsa.BLOOD_WEAPON, hpp = 95, begCode = function(mob) mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOG +12) end},
            {id = tpz.jsa.CHAINSPELL, hpp = 50, begCode = function(mob) mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOG +13) end},
        },
    })

    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("lastPetPop", os.time() + 60)
    mob:setLocalVar("teraTime", os.time() + math.random(90,120))
    local mainLord = GetServerVariable("MainDynaLord")
    if mob:getID() == mainLord then
        mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG + 8) -- Immortal Drakes, deafeated

    end
end

function onMobFight(mob, target)
    local tpTime = mob:getLocalVar("tpTime")
    local mainLord = GetServerVariable("MainDynaLord")
    if os.time() > tpTime and tpTime ~= 0 then
        local cloneMove = GetServerVariable("CloneMove")
        mob:useMobAbility(cloneMove)
        mob:setLocalVar("tpTime", 0)
        GetMobByID(mainLord):setLocalVar("teraTime", os.time() + math.random(90,120))
    elseif tpTime == 0 or os.time() > tpTime then
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
    end

    local alreadyPopped = false

    if os.time() - mob:getLocalVar("lastPetPop") > 30 then
        for i = ID.mob.YING, ID.mob.YANG do
            local pet = GetMobByID(i)
            if alreadyPopped == true then
                break
            elseif not pet:isSpawned() and utils.canUseAbility(mob) == true then
                spawnPets(mob, pet)
                pet:updateEnmity(target)
                mob:setLocalVar("lastPetPop", os.time() +30)
                if mob:getLocalVar("initialSpawnDialog") == 0 and mob:getID() == mainLord then
                    mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +7)
                    mob:setLocalVar("initialSpawnDialog", 1)
                end
            end
        end
    end

    for i = ID.mob.YING, ID.mob.YANG do
        local pet = GetMobByID(i)
        if pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

    -- Dynamis Lord spawns clones of himself 1 1/2 - 2min after pull that use a TP move in unison and despawn after
    local teraTime = mob:getLocalVar("teraTime")
    if os.time() > teraTime and mob:getID() == mainLord then
        local targetList = mob:getEnmityList()
        local newMain = 17330177 + math.random(0,5) -- Choose which Dyna Lord stays around after clones
        SetServerVariable("CloneMove", math.random(1131,1135)) -- Choose which TP move clones should use

        mob:entityAnimationPacket("casm")
        mob:SetAutoAttackEnabled(false)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:timer(3000, function(mob)
            if mob:isAlive() then
                mob:entityAnimationPacket("shsm")
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(true)
                mob:SetMobAbilityEnabled(true)
                if mob:getID() == mainLord then
                    mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG + 14)
                end
                for i = ID.mob.DYNAMIS_LORD, ID.mob.DYNAMIS_LORD + 5 do
                    local clone = GetMobByID(i)
                    if not clone:isSpawned() and utils.canUseAbility(mob) == true then
                        local victim = math.random(#targetList)
                        local victimPos = targetList[victim].entity:getPos()
                        clone:setSpawn(victimPos.x,victimPos.y,victimPos.z)
                        SpawnMob(i)
                        clone:setHP(mob:getHP())
                        clone:updateEnmity(targetList[victim].entity)
                        clone:setLocalVar("tpTime", os.time() + 2)
                    end
                end
                mob:setLocalVar("tpTime", os.time() + 2)
            end
        end)

        SetServerVariable("MainDynaLord", newMain)
    end
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    -- Dynamis Lord has a small chance to choose death
    if rnd <= 0.05 then
        return 367 -- Death
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    local moveRand = math.random(100)
    if mob:getHPP() <= 25 then
        if moveRand < 25 then
            return 1135
        elseif moveRand < 50 then
            return 1133
        elseif moveRand < 75 then
            return 1134
        else
            return 1132
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local mainLord = GetServerVariable("MainDynaLord")
    if skill:getID() == 1135 and mob:getID() == mainLord then
        mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +1)
    end
end

function onMobSkillFinished(mob, target, skill)
    -- Despawn clones after they use their TP move
    local newMain = GetServerVariable("MainDynaLord")
    if mob:getID() ~= newMain then
        DespawnMob(mob:getID())
    end
end

function spawnPets(mob, pet)
    mob:entityAnimationPacket("casm")
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:timer(3000, function(mob)
        if mob:isAlive() then
            mob:entityAnimationPacket("shsm")
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            pet:setSpawn(-414.282, -44, 20.427)
            pet:spawn()
        end
    end)
end

function onMobDisengage(mob)
    mob:setLocalVar("initialSpawnDialog", 0)
    mob:resetLocalVars()
end

function onMobDeath(mob, player, isKiller)
    local winQM = GetNPCByID(17330780)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_XARCABARD_INTERLOPER) -- Clear ??? Title
    player:addTitle(tpz.title.LIFTER_OF_SHADOWS) -- Dyna Lord Title
    if isKiller then
        mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +2)
        DespawnMob(ID.mob.YING)
        DespawnMob(ID.mob.YANG)
    end
    SetServerVariable("MainDynaLord", ID.mob.DYNAMIS_LORD)
end