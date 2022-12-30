-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Bearclaw Leveret
-- ENM: Follow the White Rabbit
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRES, 50)
end

function onMobEngaged(mob)
    if mob:getLocalVar("deathID") > 0 then
        mob:useMobAbility(1362)
    end
end

function onMobDeath(mob)
    if mob:getLocalVar("deathID") > 0 then
        local rabbitID = mob:getID() - mob:getLocalVar("deathID")
        for i = 1, 5 do
            if GetMobByID(rabbitID + i):isAlive() then
                GetMobByID(rabbitID + i):setHP(0)
            end
        end
    end
end