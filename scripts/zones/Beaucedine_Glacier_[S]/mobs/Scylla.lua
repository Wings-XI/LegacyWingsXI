------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla   (17334336)
------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier_[S]/IDs")
mixins = { require("scripts/mixins/rage"), }

require("scripts/globals/hunts")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/titles")
------------------------------

local spawnPoint = { x = 282, y = 0.9, z = 218 }

function checkDistanceFromSpawn(target)
    local targetPos = target:getPos()
    return math.sqrt(
        (targetPos.x - spawnPoint.x) ^ 2
        + (targetPos.y - spawnPoint.y) ^ 2
        + (targetPos.z - spawnPoint.z) ^ 2
        * 1)
end

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

        -- everyone on enmity list will get drawn in to spawn point if too far from it
        local finks = mob:getEnmityList()
        for _, fink in pairs(finks) do
            local entity = fink.entity
            local dist = checkDistanceFromSpawn(entity)

            printf(string.format("Distance from spawn: %u", dist))
            if dist < 10 and typeEffect > 0 then
                printf("applying effect")
                -- (re)apply the aura if applicable
                entity:delStatusEffectSilent(typeEffect)
                entity:addStatusEffect(typeEffect, 0, 0, 5)
            elseif dist > 25 then
                printf("draw in")
                entity:setPos(spawnPoint.x, spawnPoint.y, spawnPoint.z)
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
        mob:addMod(tpz.mod.DELAY, 1500)

    elseif skillID == 2440 or skillID == 2441 then
        local fuAmount = math.max(0, mob:getLocalVar("fuAmount") - 1)
        mob:setLocalVar("fuAmount",  fuAmount)

        -- back to regular auto attacks when we're done
        if fuAmount < 1 then
            mob:SetAutoAttackEnabled(true)
            mob:SetMagicCastingEnabled(true)
            mob:SetMobAbilityEnabled(true)
            mob:SetMobSkillAttack(0)
            mob:delMod(tpz.mod.DELAY, 1500)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 539)
    player:addTitle(tpz.title.SCYLLA_SKINNER)
end

function onMobDespawn(mob)
    -- target despawned and wasnt killed
    if mob:getHP() > 0 then
        mob:showText(mob, ID.text.SCYLLA_DESPAWN)
    end

    -- 4 to 6 hours respawn
    local respawn = math.random(14400, 21600)
    mob:setRespawnTime(respawn)
    SetServerVariable("ScyllaRespawn", os.time() + respawn)
end