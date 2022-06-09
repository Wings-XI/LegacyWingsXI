-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Osschaart
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/status")
-----------------------------------

-- 2-hour map
local JobTo2Hour = {
    [tpz.job.WAR] = tpz.jsa.MIGHTY_STRIKES,
    [tpz.job.MNK] = tpz.jsa.HUNDRED_FISTS,
    [tpz.job.WHM] = tpz.jsa.BENEDICTION,
    [tpz.job.BLM] = tpz.jsa.MANAFONT,
    [tpz.job.RDM] = tpz.jsa.CHAINSPELL,
    [tpz.job.THF] = tpz.jsa.PERFECT_DODGE,
    [tpz.job.PLD] = tpz.jsa.INVINCIBLE,
    [tpz.job.DRK] = tpz.jsa.BLOOD_WEAPON,
    [tpz.job.SAM] = tpz.jsa.MEIKYO_SHISUI,
    [tpz.job.NIN] = tpz.jsa.MIJIN_GAKURE,
    [tpz.job.RNG] = tpz.jsa.EES_AHRIMAN
}

-- function that find and charm the next target
function charmNextTarget(mob, target)
    -- let's make sure target is not a pet!
    if (target:isPet()) then
        target = target:getMaster()
    end

    -- find the next target
    local battlefield = target:getBattlefield()
    local current = mob:getLocalVar("charmTarget")

    for i = current, current + 5 do
        local next = (i % 6) + 1
        local nextID = battlefield:getLocalVar("charmTarget_" .. next)

        if (nextID > 0) then
            local player = GetPlayerByID(nextID)
            if (player ~= nil) then
                -- make sure requirements are met
                local distance = mob:checkDistance(player)
                if (player:getZoneID() == mob:getZoneID() and player:isAlive() and distance < 50) then
                    target = player
                    current = next
                    break
                end
            end
        end
    end

    -- proceed to charm target
    mob:setLocalVar("charmTarget", current);
    mob:useMobAbility(1337, target)
end

-- function to copy certain aspects of the target
function copycat(mob, target)
    -- get current / new pet, if any
    local petID = mob:getLocalVar("petId")
    local newID = 0

    -- figure out which pet we need
    local jobID = target:getMainJob()
    if (jobID == tpz.job.BST) then
        newID = mob:getID() + 2
    elseif (jobID == tpz.job.DRG) then
        newID = mob:getID() + 3
    elseif (jobID == tpz.job.SMN) then
        newID = mob:getID() + 4
    elseif (jobID == tpz.job.PUP) then
        newID = mob:getID() + 5
    end

    -- if current pet and new pet aren't the same, we need to do something about either or both
    if (petID ~= newID) then
        -- despawn current pet if needed
        if (petID > 0) then
            local pet = GetMobByID(petID)
            if (pet and pet:isSpawned()) then
                DespawnMob(petID)
            end
        end

        -- spawn new pet if applicable
        if (newID > 0) then
            -- set new pet id
            mob:setLocalVar("petId", newID)

            -- cast animation / disable uses of ability/spells while casting is happening
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)

            -- small delay for animation to go through
            mob:timer(2500, function (mob)
                if (mob:isSpawned() and mob:isAlive()) then
                    local petID = mob:getLocalVar("petId")
                    local pet = GetMobByID(petID)

                    -- end animation and enable uses of abilities/spells
                    mob:entityAnimationPacket("shsm")
                    mob:SetAutoAttackEnabled(true)
                    mob:SetMagicCastingEnabled(true)
                    mob:SetMobAbilityEnabled(true)

                    -- spawn pet!
                    pet:setSpawn(mob:getXPos() + 3, mob:getYPos(), mob:getZPos() + 3)
                    pet:spawn()

                    -- pet assault
                    local target = mob:getTarget()
                    if (target ~= nil) then
                        pet:updateEnmity(target)
                    end
                end
            end)
        end
    end

    -- 15% chances to copycat/use 2-hour ability
    if (math.random() < 0.15) then
        local skillID = JobTo2Hour[jobID]
        if (skillID ~= nil) then
            mob:setLocalVar("twoHourId", skillID)

            -- random delay on 2-hour ability
            mob:timer(math.random(5,15) * 1000, function(mob)
                local skillID = mob:getLocalVar("twoHourId")
                if (mob:isSpawned() and mob:isAlive() and skillID > 0) then
                    mob:useMobAbility(skillID)
                end
            end)
        end
    end
end

function onMobSpawn(mob)
    -- resist silence + lullaby resist buildup
    mob:addMod(tpz.mod.SILENCERES, 80)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 25)

    -- ready to charm right off the bat
    mob:setLocalVar("readyToCharm", 1)
end

function onMobEngaged(mob, target)
    -- (re)set the charm target to orb bearer
    local battlefield = mob:getBattlefield()
    local currentID = 6
    local bearerID = battlefield:getInitiator()

    for i = 1, 6 do
        local targetID = battlefield:getLocalVar("charmTarget_" .. i)
        if (targetID == bearerID) then
            currentID = ((i - 2) % 6) + 1
            break
        end
    end

    mob:setLocalVar("charmTarget", currentID)
    mob:setLocalVar("twoHourId", 0)
end

function onMobFight(mob, target)
    if (mob:getLocalVar("readyToCharm") == 1) then
        mob:setLocalVar("readyToCharm", 0)

        -- find and charm the next player in line
        charmNextTarget(mob, target)

        -- wait 30 secs until the next iteration
        mob:timer(30000, function(mob)
            mob:setLocalVar("readyToCharm", 1)
        end)
    end
end

-- workaround draw in to fill in for lack of SKILLFLAG_DRAW_IN flag support?
function onMobWeaponSkill(target, mob, skill)
    -- if using charm, draw in first
    if (skill:getID() == 1337) then
        mob:triggerDrawIn(false, 10, 50, target)
    end
end

-- copycat charmed target
function onMobSkillFinished(mob, target, skill)
    if (skill:getID() == 1337) then
        copycat(mob, target)
    end
end

-- removing any remaining pets on death
function onMobDeath(mob, player, isKiller)
    for i = mob:getID() + 2, mob:getID() + 5 do
        if (GetMobByID(i):isSpawned()) then
            DespawnMob(i)
        end
    end
end