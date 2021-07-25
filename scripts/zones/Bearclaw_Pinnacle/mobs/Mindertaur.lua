-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Mindertaur
--  ENM: Brothers
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/mobs")
-----------------------------------

function onMobWeaponSkillPrepare(mob, target)
    local returnVal = 0

    if mob:getLocalVar("unlockRay") == 1 then
        local chthonianRay = 1359
        if math.random() < 0.75 then -- heavily prefer Chthonian Ray
            returnVal = chthonianRay
        end
    end

    return returnVal
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SILENCERES, 75)
    mob:setMod(tpz.mod.LULLABYRES, 75)
    mob:setMod(tpz.mod.DMGMAGIC, -10)
    mob:setMod(tpz.mod.SLEEPRES, 50)
end

function onMobDeath(mob, player, isKiller)
    local eldertaur = GetMobByID(mob:getID()-1)

    if eldertaur and eldertaur:isAlive() then
        eldertaur:setLocalVar("unlockRay", 1)
    end
end
