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
--[[
local addList = {
    [1] = 17027475, --Troll Grendier
    [2] = 17027476, --Troll Grendier
    [3] = 17027477, --Troll Grendier
    [4] = 17027478, --Troll Cuirassier
    [5] = 17027479, --Troll Cuirassier
    [6] = 17027480, --Troll Cuirassier
    [7] = 17027481, --Troll Artelleryman
    [8] = 17027482, --Troll Artelleryman
    [9] = 17027483, --Troll Hammersmith
    [10] = 17027484  --Troll Hammersmith
}
]]
local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 10 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end


function spawnAdds(mob)  
    local mobId = mob:getID()
    local mobPos = mob:getPos()

    for ii = (mobId + mob:getLocalVar("Offset")), (mobId + mob:getLocalVar("Offset")+ mob:getLocalVar("AddCount") -1) do
        local pet = GetMobByID(ii)  
        
        pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
        pet:spawn(pet) 
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
    mob:setLocalVar("Offset", 1) 
    mob:setLocalVar("AddCount", 3)
    mob:setLocalVar('First', 0)                    
end       

function onMobEngaged(mob, target)
    mob:setLocalVar("clock", os.time() + 10) 
end


function onMobFight(mob, target)
    local phase = mob:getLocalVar("Phase")
    local hpp = mob:getHPP()
    local now = os.time()
    local popTime = mob:getLocalVar("clock")
    local mobId = mob:getID()
    local mobPos = mob:getPos()

    -- Phase handeling block

    if phase == 1 and hpp <= 80 then
        despawnAdds(mob)
        mob:setLocalVar("Offset", 4) 
        mob:setLocalVar("AddCount", 3)
        mob:setLocalVar("Phase", 2)
        mob:setLocalVar("clock", os.time() + 10)
        
    elseif phase == 2 and hpp <= 60 then
        despawnAdds(mob)
        mob:setLocalVar("Offset", 7) 
        mob:setLocalVar("AddCount", 2)
        mob:setLocalVar("Phase", 3)
        mob:setLocalVar("clock", os.time() + 10)
        
    elseif phase == 3 and hpp <= 40 then
        despawnAdds(mob)
        mob:setLocalVar("Offset", 9) 
        mob:setLocalVar("AddCount", 2)
        mob:setLocalVar("Phase", 4)
        mob:setLocalVar("clock", os.time() + 10)
        
    elseif phase == 4 and hpp <= 20 then
        despawnAdds(mob)
        mob:setLocalVar("Phase", 5)  
    end


    -- Occationally, lets check to see if anyone killed adds and respawn them if needed.
    if now > popTime and phase < 5 then
        for ii = (mobId + mob:getLocalVar("Offset")), (mobId + mob:getLocalVar("Offset")+ mob:getLocalVar("AddCount") -1) do
            local pet = GetMobByID(ii)  
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(pet) 
            pet:updateEnmity(target)
            mob:setLocalVar("clock", os.time() + 120)
        end
    end
end



function onMobWeaponSkillPrepare(mob)
   if mob:getLocalVar("Phase") == 5 and math.random() <=.7 then
       return 1895
    end
end


function onMobDespawn(mob)
    despawnAdds(mob)
end

function onMobDeath(mob, player, isKiller)
    despawnAdds(mob)
end
