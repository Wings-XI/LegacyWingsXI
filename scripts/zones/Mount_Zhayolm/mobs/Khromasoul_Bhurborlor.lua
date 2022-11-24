-----------------------------------
--   Area: Mount Zhayolm
--    Mob: T3 ZNM - Khromasoul Bhurborlor (Chromesole Bulbasaur)
-- Author: Spaceballs / Chiefy
-----------------------------------


mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}

local addList = {
    17027475, --Troll Grendier
    17027476, --Troll Grendier
    17027477, --Troll Grendier
    17027478, --Troll Cuirassier
    17027479, --Troll Cuirassier
    17027480, --Troll Cuirassier
    17027481, --Troll Artelleryman
    17027482, --Troll Artelleryman
    17027483, --Troll Hammersmith
    17027484  --Troll Hammersmith
}

local addCount = {
    3, -- Phase 1
    3, -- Phase 2
    2, -- Phase 3
    2, -- Phase 4
    0  -- Phase 5
}

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 10 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end

local function spawnAdds(mob)  
    local mobId = mob:getID()
    local mobPos = mob:getPos()
    local phase = mob:getLocalVar("Phase")
    local addCount = addCount(phase)
    -- Need to change starting point of our look up table of mobs
    if phase == 1 then
        local offset = 1
    elseif phase == 2 then
        local offset = 4
    elseif phase == 3 then
        local offset = 7
    elseif phase == 4 then
        local offset = 9
    end

    for ii = offset, offset + addCount - 1 do -- Figure that one out Nasomi...
        local pet = GetMobByID(addList(ii)) 

        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(addList(ii)) 
        pet:updateEnmity(target)
    end
end


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("Phase", 1)                       
end       

function onMobEngaged(mob, target)
    mob:setLocalVar("clock", os.time() + 10) 
end


function onMobFight(mob, target)
    local phase = mob:getLocalVar("Phase")
    local hpp = mob:getHPP()
    local now = os.time()
    local popTime = mob:getLocalVar("clock")

    -- Phase handeling block
    if phase == 1 and hpp <= 80 then
        despawnAdds(mob)
        mob:setLocalVar("Phase", 2)
        spawnAdds(mob)  
        mob:setLocalVar("clock", os.time() + 120) 
    elseif phase == 2 and hpp <= 60 then
        despawnAdds(mob)
        mob:setLocalVar("Phase", 3)
        spawnAdds(mob)  
        mob:setLocalVar("clock", os.time() + 120) 
    elseif phase == 3 and hpp <= 40 then
        despawnAdds(mob)
        mob:setLocalVar("Phase", 4)
        spawnAdds(mob)  
        mob:setLocalVar("clock", os.time() + 120) 
    elseif phase == 4 and hpp <= 20 then
        despawnAdds(mob)
        mob:setLocalVar("Phase", 5)  
    end




    -- Occationally, lets check to see if anyone killed adds and respawn them if needed.
    if now > popTime and phase < 5 then
        spawnAdds(mob)
        mob:setLocalVar("clock", os.time() + 120) 
    end
end



function onMobWeaponSkillPrepare(mob)
    local phase = mob:getLocalVar("phase")
    if phase == 5 then
        return 1742 -- May be 1895
    end
end


function onMobDespawn(mob)
    despawnAdds(mob)
end

function onMobDeath(mob, player, isKiller)
    despawnAdds(mob)
end
