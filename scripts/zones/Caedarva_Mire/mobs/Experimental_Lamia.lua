-----------------------------------
--   Area: Caedarva Mire
--    Mob: T3 ZNM - Experimental Lamia
-- Author: Spaceballs
-----------------------------------

mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/globals/status")
}
local ID = require("scripts/zones/Caedarva_Mire/IDs")



-- uses arrow deluge immediately after tail slap

-- Confirm
-- can para and blind, immune to grav
-- she does ranged attacks
-- uses hypnic sway (amnesia)... dukkeripen (self heal)...pole swing


local function spawnAdds(mob, target)
    mob:setLocalVar("adds", 1)

    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()

    for ii = ID.mob.EXPERIMENTAL_LAMIA + 1, ID.mob.EXPERIMENTAL_LAMIA + 3 do
        local pet = GetMobByID(ii)
        pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2))
        pet:spawn()
        pet:updateEnmity(target)
    end
end

local function despawnAdds(mob) 
    local mobId = mob:getID()
    for ii = mobId + 1, mobId + 3 do   -- yolo just despawn everything
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
    mob:setLocalVar("adds", 0)   
    mob:setLocalVar("dances", 0)
    mob:setLocalVar("tailSlap", 0)          
end     

function onMobEngaged(mob, target)
    mob:setLocalVar("clock", os.time() + 20) 
end

function onMobFight(mob, target)
    local now = os.time()
    local popTime = mob:getLocalVar("clock")
    local adds = mob:getLocalVar("adds")

    if now >= popTime and adds == 0 then
        spawnAdds(mob, target)
    end 

    if mob:getLocalVar("dances") > 0 then
        mob:addTP(1000)
    end
end

function onMobWeaponSkillPrepare(mob)
    local dance = mob:getLocalVar("dances")
    local tailslap = mob:getLocalVar("tailSlap")
    if dance > 0 then
        mob:setLocalVar("dances", dance - 1)
        return 1762 -- May be 1193
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1758 then -- Tail Slap
        mob:useMobAbility(1761)
    end
end



-- Take care of adds
function onMobDespawn(mob)
    despawnAdds(mob)
end

function onMobDeath(mob, player, isKiller)
    despawnAdds(mob)
end