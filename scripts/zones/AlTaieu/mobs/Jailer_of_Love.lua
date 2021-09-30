-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Love
-- !pos 431.522 -0.912 -603.503 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/magic")
require("scripts/globals/utils")
-----------------------------------

local minionGroup =
{
    [0] = 10, -- Qnxzomit
    [1] = 19, -- Qnhpemde
    [2] =  1, -- Ruphuabo
    [3] = 13, -- Qnxzomit
    [4] = 22, -- Qnhpemde
    [5] =  4, -- Ruphuabo
    [6] = 16, -- Qnxzomit
    [7] = 25, -- Qnhpemde
}

local elementToAbsorb =
{
    [307] = tpz.mod.FIRE_ABSORB,  -- Substitute
    [404] = tpz.mod.ICE_ABSORB,   -- Smite of Rage
    [603] = tpz.mod.WIND_ABSORB,  -- Lateral Slash
    [604] = tpz.mod.EARTH_ABSORB, -- Throat Stab
    [624] = tpz.mod.LTNG_ABSORB,  -- Vulture 1
    [625] = tpz.mod.WATER_ABSORB, -- Vulture 2
    [626] = tpz.mod.DARK_ABSORB, -- Vulture 3
    [627] = tpz.mod.LIGHT_ABSORB, -- Vulture 4
}

function onMobInitialize(mob)
    mob:setBehaviour(2)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.REGEN, 260)
    mob:setMod(tpz.mod.MATT, 50)
    mob:setMod(tpz.mod.INT, 4)
    mob:setMod(tpz.mod.DEF, 620)
    mob:setMod(tpz.mod.MDEF, 75)
    mob:setMod(tpz.mod.DMGMAGIC, -50) -- starts the fight with -50% magic damage taken, reduced to 25% after regen is taken off.
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.ASTRAL_FLOW, hpp = math.random(45, 55)},
        },
    })
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:AnimationSub(2)
    mob:setLocalVar("elementAbsorb", os.time() + 120)
    mob:setLocalVar("pop_pets", os.time() + 150) -- wait 2.5 minutes until spawning initial mobs
    mob:setLocalVar("currentAbsorb", math.random(459, 466)) -- pick a random element to absorb after engaging
end

function onMobWeaponSkill(target, mob, skill)
    local skillId = skill:getID()
    local absorbId = elementToAbsorb[skillId]

    if absorbId then
        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar("currentAbsorb")

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar("currentAbsorb", absorbId)
        mob:setMod(absorbId, 100)
        mob:addTP(mob:getLocalVar("twohour_tp"))
        mob:setLocalVar("twohour_tp", 0)
    end

    if skillId == 734 then
        astralFlowPets()
    end
end

function onMobFight(mob, target)
    -- reduce regen after nine Xzomits and Hpemdes are killed
    if mob:getLocalVar("JoL_Regen_Reduction") == 0 and mob:getLocalVar("JoL_Qn_xzomit_Killed") >= 9 and mob:getLocalVar("JoL_Qn_hpemde_Killed") >= 9 then
        mob:setLocalVar("JoL_Regen_Reduction", 1)
        mob:delMod(tpz.mod.REGEN, 260)
        mob:setMod(tpz.mod.DMGMAGIC, -25) -- magic damage taken reduced from 50% to 25% after killing nine xzomits and hpemdes
    end

    -- every 2 minutes JoL will change the element it absorbs/casts spells this change happens after a two hour animation
    if os.time() > mob:getLocalVar("elementAbsorb") then
        mob:setLocalVar("elementAbsorb", os.time() + 120)
        local abilities = { 307, 404, 603, 604, 624, 625, 626, 627 }
        mob:setLocalVar("twohour_tp", mob:getTP())
        mob:useMobAbility(abilities[math.random(#abilities)])
    end

    local currentAbsorb = mob:getLocalVar("currentAbsorb")
    if currentAbsorb == 459 then -- fire
        mob:setSpellList(485)
    elseif currentAbsorb == 460 then -- ice
        mob:setSpellList(486)
    elseif currentAbsorb == 461 then -- wind
        mob:setSpellList(487)
    elseif currentAbsorb == 462 then -- earth
        mob:setSpellList(488)
    elseif currentAbsorb == 463 then -- ltng
        mob:setSpellList(489)
    elseif currentAbsorb == 464 then -- water
        mob:setSpellList(490)
    elseif currentAbsorb == 466 then -- dark
        mob:setSpellList(491)
    elseif currentAbsorb == 465 then -- light
        mob:setSpellList(484)
    end

    -- spawn minions in 2.5 minute intervals
    if os.time() > mob:getLocalVar("pop_pets") and utils.canUseAbility(mob) == true then
        mob:setLocalVar("pop_pets", os.time() + 150)

        local spawns = mob:getLocalVar("SPAWNS")
        if spawns < 8 then
            local minionOffset = ID.mob.JAILER_OF_LOVE + minionGroup[spawns]
            spawnPets(mob, minionOffset)
        elseif spawns > 8 then
            mob:entityAnimationPacket("casm")
            mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:timer(3000, function(mob, target)
                if mob:isAlive() then
                    mob:entityAnimationPacket("shsm")
                    mob:SetAutoAttackEnabled(true)
                    mob:SetMagicCastingEnabled(true)
                    mob:SetMobAbilityEnabled(true)
                    spawnSharks(mob)
                end
            end)
        end
        mob:setLocalVar("SPAWNS", spawns + 1)
    end

    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        local pet = GetMobByID(i)
        if pet:isSpawned() and pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end

end

function astralFlowPets()
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        local pet = GetMobByID(i)
        if pet and pet:isAlive() then
            pet:timer(1500, function(pet)
                if pet:getFamily() == 269 then -- xzomit
                    pet:useMobAbility(786) -- lateral slash
                elseif pet:getFamily() == 144 then -- hpemde
                    pet:useMobAbility(1367) -- sinuate rush
                elseif pet:getFamily() == 194 then -- shark
                    pet:useMobAbility(1353) -- aerial collision
                end
            end)
        end
    end
end

function spawnPets(mob, minionOffset)
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
            GetMobByID(minionOffset + 0):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
            GetMobByID(minionOffset + 1):setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos() + 4)
            GetMobByID(minionOffset + 2):setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos() - 4)
            SpawnMob(minionOffset + 0):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            SpawnMob(minionOffset + 1):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            SpawnMob(minionOffset + 2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        end
    end)
end

function spawnSharks(mob, target)
    -- determine which sharks are currently spawned
    local phuaboUp = {}
    local phuaboDn = {}
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 9 do
        local phuabo = GetMobByID(i)
        if phuabo:isAlive() then
            table.insert(phuaboUp, i)
        elseif not phuabo:isSpawned() then
            table.insert(phuaboDn, i)
        end
    end
    -- how many sharks spawn depends on number currently alive
    -- https://www.bg-wiki.com/bg/Jailer_of_Love
    local numToSpawn = 0
    if #phuaboUp == 2 then
        numToSpawn = 1
    elseif #phuaboUp == 0 or #phuaboUp == 3 then
        numToSpawn = 3
    elseif #phuaboUp == 1 then
        numToSpawn = math.random(3)
    end
    -- spawn sharks
    for i = 1, math.min(numToSpawn, #phuaboDn) do
        -- spawnSharks(mob, phuaboDn)
        local target = mob:getTarget()
        GetMobByID(phuaboDn[i]):setSpawn(target:getXPos() + math.random(-2, 2), target:getYPos(), target:getZPos())
        SpawnMob(phuaboDn[i]):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    end
end

function onMobDeath(mob, player, isKiller)
    -- despawn pets
    for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 27 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

function onMobDespawn(mob)
    -- SpawnMob(ID.mob.ABSOLUTE_VIRTUE) -- Absolute Virtue will always pop upon its defeat as of Sept. 8th, 2008.
end
