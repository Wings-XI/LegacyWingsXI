-----------------------------------
--   Area: Aydeewa Subterrane
--    Mob: T3 ZNM - Nosferatu
-- Author: Spaceballs
-----------------------------------
mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")

-- wiki notes

-- occationally spawns a group of 3 pets that appear, WS, then depop
-- should be some kind of stunnable cast
-- The minions are 3 of either Nosferatu Bats (bat trios),
-- Nosferatu Wolves (hounds), or Nosferatu Murks (fomors).
-- saw wolf use dirty claw 
-- batt use jet stream
-- murk used barbed cresent
-- astral flow: bats uses turbulence, wolf used methane breath, murk used foxfire
-- sub 50% he can AF, pops 3-6 mobs instantly and they do the same thing
-- draw in
-- verified it uses eternal damnation, heliovoid, wings of gehenna, bloodrake, nocturnal servitude, nosferatu's kiss, decollation
-- casts absorb ac, aborb tp, dread spike, drain 2, drain, stun

-- my notes, seems to favor decolation early and kiss late



--local batID = [17056158, 17056159, 17056160]
--local wolfID = [17056161, 17056162, 17056163]
--local murkID = [17056164, 17056165, 17056166] 

local function spawnAdds(mob, target)
    local mobType = math.random(1,3) -- 1 = bats, 2 = wolf, 3 = murk 
    local af = mob:getLocalVar("AF")
    mob:setLocalVar("addTimer", os.time() + math.random(90, 120)) 
    local x = mob:getXPos(target) -- does this work?
    local y = mob:getYPos(target)
    local z = mob:getZPos(target)


    if af == 1 -- If we used astral flow
        for jj = 1, 3
        local adds = math.random(0,1)

        if jj == 1
            local offset = 1
        elseif jj == 2
            local offset = 4
        elseif jj == 3
            local offset = 7
        end

            for ii = ID.mob.NOSFERATU + offset, ID.mob.NOSFERATU + offset + adds do
                local pet = GetMobByID(ii)
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
                pet:spawn()
                pet:setLocalVar("AF", 1)
                pet:updateEnmity(target)
            end
        end

-- regular mob spawning
    else
        if mobType == 1
            local offset = 1
        elseif mobType == 2
            local offset = 4
        elseif mobType == 3
            local offset = 7
        end

        for ii = ID.mob.NOSFERATU + offset, ID.mob.NOSFERATU + offset + 2 do
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
    mob:setLocalVar("addTimer", os.time() + math.random(90, 120))   
    mob:setLocalVar("AF", 0)       
    mob:setLocalVar("2hr", math.random(20,50))
end     


function onMobFight(mob, target)
    local pop = mob:getLocalVar("addTimer")
    local now = os.time()
    local hpp = mob:getHPP()
    local boom = mob:getLocalVar("2hr")

    if now >= pop then,
        spawnMobs()
    end

    if hpp <= boom
        mob:setLocalVar("AF", 1) 
        mob:useMobAbility(####) -- ASCAR Astral Flow
    end

end


-- Take care of adds
function onMobDespawn(mob)
    despawnAdds(mob)
end

function onMobDeath(mob, player, isKiller)
    despawnAdds(mob)
end