------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla   (17334336)
------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier_[S]/IDs")
mixins = {
    require("scripts/mixins/families/ruszor"),
    require("scripts/mixins/rage"),
}

require("scripts/globals/hunts")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/titles")
------------------------------

function onMobInitialize(mob)
    -- fairly high humanoid killer
    mob:setMod(tpz.mod.HUMANOID_KILLER, 25)

    -- immune to bind and gravity
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600)

    mob:setLocalVar("fuAmount", 0)
    mob:setLocalVar("omfCooldown", 0)

    mob:AnimationSub(0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMobSkillAttack(0)

    -- slightly faster attack speed
    mob:setMod(tpz.mod.DELAY, 300)
end

function onMobFight(mob, target)
    -- will draw in and intimidate anyone on enmity list that's out of range
    if mob:getLocalVar("omfCooldown") < os.time() then
        -- run these checks once per second
        mob:setLocalVar("omfCooldown", os.time())

        -- Scylla has a 10 yalms Silence and Paralyze aura under certain conditions
        local animSub = mob:AnimationSub()
        local typeEffect = 0
        if animSub == 1 then
            -- "Frosty" state gives a Paralyze aura
            typeEffect = tpz.effect.PARALYSIS
        elseif animSub == 2 then
            -- "Bubbly" state gives a Silence aura
            typeEffect = tpz.effect.SILENCE
        end

        local mobPos = mob:getPos()
        local spawnPos = mob:getSpawnPos()

        -- check everyone on enmity list
        local finks = mob:getEnmityList()
        for _, fink in pairs(finks) do
            local entity = fink.entity
            local entityPos = entity:getPos()
            local distFromMob = math.sqrt((entityPos.x - mobPos.x) ^ 2 + (entityPos.y - mobPos.y) ^ 2 + (entityPos.z - mobPos.z) ^ 2)
            local distFromSpawn = math.sqrt((entityPos.x - spawnPos.x) ^ 2 + (entityPos.y - spawnPos.y) ^ 2 + (entityPos.z - spawnPos.z) ^ 2)

            if distFromMob < 10 and typeEffect > 0 then
                -- (re)apply the aura if applicable
                entity:delStatusEffectSilent(typeEffect)
                entity:addStatusEffect(typeEffect, 0, 0, 5)
            elseif distFromSpawn > 25 then
                -- draw in to spawn point if too far
                entity:setPos(spawnPos.x, spawnPos.y, spawnPos.z)
                mob:messageBasic(tpz.msg.basic.DRAWN_IN, 0, 0, entity)
            end
        end
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local fuAmount = mob:getLocalVar("fuAmount")
    if fuAmount == 0 then
        -- will prioritize Aqua Wave and Frozen Mist more as hp goes down (up to 80%)
        local chances = math.min(100 - mob:getHPP(), 50) + 30
        if math.random(100) <= chances then
            if math.random() < 0.5 then
                return 2438
            else
                return 2439
            end
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 2438 or skillID == 2439 then
        -- Frozen Mist (2438) will be followed by multiple Ice Guillotine (2440)
        -- Aqua Wave (2439) will be followed by multiple Aqua Cannon (2441)
        mob:setLocalVar("fuAmount", math.random(6, 10))
        mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:SetMobSkillAttack(skillID + 2)
        mob:setMod(tpz.mod.DELAY, 1800)

    elseif skillID == 2440 or skillID == 2441 then
        local fuAmount = math.max(0, mob:getLocalVar("fuAmount") - 1)
        mob:setLocalVar("fuAmount",  fuAmount)

        -- back to regular auto attacks when we're done
        if fuAmount < 1 then
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:SetMobSkillAttack(0)
            mob:setMod(tpz.mod.DELAY, 300)
        end
    end
end

function onMobDisengage(mob)
    mob:setLocalVar("fuAmount", 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMobSkillAttack(0)
    mob:setMod(tpz.mod.DELAY, 300)

    -- Scylla will despawn after the fight if a certain threshold was reached
    if mob:getHPP() < 90 then
        -- display message to players in range
        local players = mob:getPlayersInRange(30)
        if players ~= nil then
            for _, player in pairs(players) do
                player:messageSpecial(ID.text.SCYLLA_DESPAWN)
            end
        end

        -- aaand.. its gone
        DespawnMob(ID.mob.SCYLLA)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 539)
    player:addTitle(tpz.title.SCYLLA_SKINNER)
end

function onMobDespawn(mob)
    -- 4 to 6 hours respawn
    local respawn = math.random(14400, 21600)
    mob:setRespawnTime(respawn)
    SetServerVariable("ScyllaRespawn", os.time() + respawn)
end