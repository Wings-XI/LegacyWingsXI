------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
------------------------------
local ID = require("scripts/zones/Vunkerl_Inlet_[S]/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/hunts")
------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.BINDRESTRAIT, 100)
end

function onMobSpawn(mob)
    mob:setLocalVar("FamiliarHpp", math.random(45,55))
    mob:setDamage(150) -- hits hard, power attack can spike to 1.1k
end

function onMobDeath(mob, player, isKiller)
    -- When Pallas dies, his pets die
    for mobID = ID.mob.PALLAS+1, ID.mob.PALLAS+3, 1
    do
        local pet = GetMobByID(mobID)
        if pet and pet:isAlive() then
            pet:setHP(0)
        end
    end

    tpz.hunts.checkHunt(mob, player, 489)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 740 then --Familiar
        familiarPets()
    end
end

function onMobRoam(mob)
    -- Found testimonials saying that Pallas does not 2 hour more than once, even if regened to full
    -- So I will leave this out for now.   Seems cheesable though
    --if mob:getLocalVar("Familiar") == 1 then -- reset 2 hour if wandering around at 100% hp
    --    if mob:getHPP() == 100 then
    --    mob:setLocalVar("Familiar", 0) 
    --end

    respawnPets(mob)
end

function onMobFight(mob, target)
    if mob:getHPP() < mob:getLocalVar("FamiliarHpp") and mob:getLocalVar("Familiar") == 0 then
        mob:useMobAbility(740)
        mob:setLocalVar("Familiar", 1)
    end

    respawnPets(mob)
    engagePets(target) --Testimonials say that pets cannot be sac'd away - if idle will re-pick up hate if palls has hate
end

function onMobEngaged(mob, target)
     engagePets(target)
end


function respawnPets(mob)
    if (areAnyPetsDead()) then
        mob:entityAnimationPacket("casm")
        mob:timer(3000, function(mob)
            if mob:isAlive() then
                mob:entityAnimationPacket("shsm")
                for mobID = ID.mob.PALLAS+1, ID.mob.PALLAS+3, 1
                do
                    local pet = GetMobByID(mobID)
                    if pet and not pet:isAlive() and not pet:isSpawned() then
                        offsetX = math.random(1, 5)
                        offsetY = math.random(1, 5)
                        pet:setSpawn(mob:getXPos() + offsetX, mob:getYPos(), mob:getZPos() + offsetY)
                        SpawnMob(mobID)
                        if mob:getTarget() then
                            pet:updateEnmity(mob:getTarget())
                        end
                    end
                end
            end
        end)
    end
end

function areAnyPetsDead()
    local areAnyPetsDead = false
    for mobID = ID.mob.PALLAS+1, ID.mob.PALLAS+3, 1
    do
        local pet = GetMobByID(mobID)
        if pet and not pet:isAlive() and not pet:isSpawned() then
            areAnyPetsDead = true
        end
    end

    return areAnyPetsDead
end

function familiarPets()
    for mobID = ID.mob.PALLAS+1, ID.mob.PALLAS+3, 1
     do
        local pet = GetMobByID(mobID)
        if pet and pet:isAlive() then
            removeSleepEffects(pet) -- Pets wake and are unsleepable after famiilar.  Only effects the active pets
            pet:setMod(tpz.mod.SLEEPRESTRAIT, 100)
            pet:setMod(tpz.mod.LULLABYRESTRAIT, 100)
        end
     end
end

function engagePets(target)
    for mobID = ID.mob.PALLAS+1, ID.mob.PALLAS+3, 1
     do
        local pet = GetMobByID(mobID)
        if pet and pet:isAlive() and not pet:isEngaged() then
            pet:updateEnmity(target)
        end
     end
end