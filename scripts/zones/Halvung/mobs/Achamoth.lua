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


local smallList = { -- Achamothcampa
    17031601, 
    17031602
}
 
local bigList = { -- Achamoth_Nympha
    17031603, 
    17031604
}



function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.WINDDEF, 50)
    mob:setMod(tpz.mod.DOUBLEATTACK, 10)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 12)
end


function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                 -- 90 minutes
    mob:setLocalVar("smallAdds", 0)
    mob:setLocalVar("bigAdds", 0)               
    mob:addListener("ATTACK", "RESTORE_MP", function(player, target, action)
        if mob:getTarget() ~= nil 
        mob:addMP(30)
        -- Addditional effect: Achamoth recovers 30 MP. (blue cure color)
        end
    end)              
end     


function onMobEngaged(mob, target)
    mob:setLocalVar("clock", os.time() + 60) 
end


function onMobFight(mob, target)
    local now = os.time()
    local popTime = mob:getLocalVar("clock")
    local small = mob:getLocalVar("smallAdds")
    local big = mob:getLocalVar("bigAdds")


    if now >= popTime and (small+big <= 2) then -- Time to have babies
        local mobId = mob:getID()
        local mobPos = mob:getPos()

        -- Determine which of the adds to spawn and give birth
        if mob:getHPP(smallList(1)) > 0 then
            local pet = GetMobByID(smallList(2))
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(smallList(2))
        else
            local pet = GetMobByID(smallList(1))
            pet:setSpawn(mobPos.x + math.random(-2, 2), mobPos.y, mobPos.z + math.random(-2, 2), mobPos.r)
            pet:spawn(smallList(1))
        end
        pet:updateEnmity(target)
        -- Count the new baby and start a new clock
        mob:setLocalVar("smallAdds", small + 1)
        mob:setLocalVar("clock", os.time() + 60) 
    end


end