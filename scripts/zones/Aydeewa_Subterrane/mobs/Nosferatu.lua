-----------------------------------
--   Area: Aydeewa Subterrane
--    Mob: T3 ZNM - Nosferatu
-- Author: Spaceballs
-----------------------------------
mixins = {require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/status")

local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")

local function spawnAdds(mob, target)
    mob:setLocalVar("MobType", math.random(1,3)) -- 1 = bats, 2 = wolf, 3 = murk 
    mob:setLocalVar("addTimer", os.time() + math.random(90, 120)) 
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()


    if mob:getLocalVar("AF") == 1 then -- If we used astral flow
        -- spawn 1-2 of each pet type
        for jj = 1, 3 do
            mob:setLocalVar("adds", math.random(0,1))

            mob:setLocalVar("offset", 1 + 3 * (jj - 1))

            for ii = ID.mob.NOSFERATU + mob:getLocalVar("offset"), ID.mob.NOSFERATU + mob:getLocalVar("offset") + mob:getLocalVar("adds") do
                local pet = GetMobByID(ii)
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
                pet:spawn()
                pet:setLocalVar("AF", 1)
                pet:updateEnmity(target)
            end
        end
    else -- regular mob spawning
        if mob:getLocalVar("MobType") > 0 then
            mob:setLocalVar("offset", 1 + 3 * (mob:getLocalVar("MobType") - 1))
        end

        for ii = ID.mob.NOSFERATU + mob:getLocalVar("offset"), ID.mob.NOSFERATU + mob:getLocalVar("offset") + 2 do
            local pet = GetMobByID(ii)
            pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
            pet:spawn()
            pet:updateEnmity(target)
        end
    end
end

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 9 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMobMod(tpz.mobMod.ALLI_HATE, 30)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes 
    mob:setLocalVar("AF", 0)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BLOOD_WEAPON, hpp = 0},
            {id = tpz.jsa.ASTRAL_FLOW, hpp = math.random(5, 70)},
        },
    })

end     

function onMobEngaged(mob, target)
    mob:setLocalVar("addTimer", os.time() + math.random(90, 120)) 
end


function onMobFight(mob, target)
    local pop = mob:getLocalVar("addTimer")
    local now = os.time()



    if now >= pop then
        spawnAdds(mob, target)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 734 then -- Astral Flow
        mob:setLocalVar("AF", 1)
        mob:setLocalVar("addTimer", os.time() + 2)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() <= 25 and math.random() <= .5 then  
        return 2108
    else
        return 0
    end

end



-- Take care of adds
function onMobDespawn(mob)
    despawnAdds(mob)
end

function onMobDeath(mob, player, isKiller)
    despawnAdds(mob)
end