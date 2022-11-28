-----------------------------------
--   Area: Halvung
--    Mob: T3 ZNM - Achamoth
-- Author: Spaceballs
-----------------------------------

mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
local ID = require("scripts/zones/Halvung/IDs")


-- Wiki notes

-- Max of 2 adds TOTAL

-- When achamoth hits something, it restores (not drains) 3- MP


-- uses -na and erase for debuffs
-- exuviation heals dependant on how many debuffs are on mob - this should exist already in mob skills





function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.WINDDEF, 50)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 12)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BENEDICTION, hpp = -1},
            
        },
    })
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.MP_DRAIN, { chance = 100, power = 30 }) 
    
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("smallAdds", 0)
    mob:setLocalVar("bigAdds", 0)      
    
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.BENEDICTION, hpp = -1},
            
        },
    })
end     

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 4 do   -- yolo just despawn everything
        DespawnMob(ii)
    end
end


function onMobEngaged(mob, target)
    mob:setLocalVar("clock", os.time() + 120) 
end


function onMobFight(mob, target)
    
    local now = os.time()
    local popTime = mob:getLocalVar("clock")
    local small = mob:getLocalVar("smallAdds")
    local big = mob:getLocalVar("bigAdds")
    
    if small+big == 2 then
        mob:setLocalVar("clock", os.time() + math.random(30,60))
    end



    if now >= popTime and (small+big < 2) then -- Time to have babies
        local mobId = mob:getID()
        local mobPos = mob:getPos()

        -- Determine which of the adds to spawn and give birth
        if GetMobByID(17031601):isSpawned() then
            local pet = GetMobByID(17031602)
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(17031602)
            pet:updateEnmity(target)
        else
            local pet = GetMobByID(17031601)
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(17031601)
            pet:updateEnmity(target)
        end
        
        -- Count the new baby and start a new clock
        mob:setLocalVar("smallAdds", small + 1)
        mob:setLocalVar("clock", os.time() + 60) 
    end


end


function onMobDeath(mob)
    despawnAdds(mob)
end

function onMobDespawn(mob)
    despawnAdds(mob)
end