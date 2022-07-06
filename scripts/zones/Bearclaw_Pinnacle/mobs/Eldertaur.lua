-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Eldertaur
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
        local apocalypticRay = 1360
        if math.random() < 0.75 then -- heavily prefer Apocalyptic Ray
            returnVal = apocalypticRay
        end
    end

    return returnVal
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 50)
    mob:setMod(tpz.mod.DMGMAGIC, -10)
    mob:setMod(tpz.mod.SLEEPRES, 75)
end

function onMobDeath(mob, player, isKiller)
    local mindertaur = GetMobByID(mob:getID()+1)

    if mindertaur and mindertaur:isAlive() then
        mindertaur:setLocalVar("unlockRay", 1)
    end
end
