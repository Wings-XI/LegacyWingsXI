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
            {id = tpz.jsa.CHAINSPELL, hpp = 95, begCode = function(mob) mob:messageText(mob, ID.text.DYNAMIS_LORD_DIALOG +13) end},
        },
    })
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("lastPetPop", os.time() +60)
    mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +8) -- Imortal Drakes, deafeated
end

function onMobFight(mob, target)
    local battleTime = mob:getBattleTime()
    local alreadyPopped = false
    if os.time() - mob:getLocalVar("lastPetPop") > 30 then
        for i = 17330183, 17330184 do -- ying & yang
            local pet = GetMobByID(i)
            if alreadyPopped == true then
                break
            elseif not pet:isSpawned() and utils.canUseAbility(mob) == true then
                spawnPets(mob, pet)
                pet:updateEnmity(target)
                mob:setLocalVar("lastPetPop", os.time() +30)
                if mob:getLocalVar("initialSpawnDialog") == 0 then
                    mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +7)
                    mob:setLocalVar("initialSpawnDialog", 1)
                end
            end
        end
    end

    for i = 17330183, 17330184 do -- ying & yang
        local pet = GetMobByID(i)
        if pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- at or below 25% hp, tera slash & oblivion smash have a chance to insta death on hit.
    -- each has two animations per skill, one jumping (insta death) the other standing on the ground.
    if mob:getHPP() <= 25 then
        if math.random() < 0.25 then
            return 1135
        elseif math.random() < 0.50 then
            return 1133
        elseif math.random() < 0.75 then
            return 1134
        else
            return 1132
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1135 then
        mob:showText(mob, ID.text.DYNAMIS_LORD_DIALOG +1)
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
        DespawnMob(17330183)
        DespawnMob(17330184)
    end
end