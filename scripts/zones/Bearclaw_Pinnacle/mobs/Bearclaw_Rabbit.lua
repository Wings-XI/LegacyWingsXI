-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Bearclaw Rabbit
-- ENM: Follow the White Rabbit
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
end

function onMobEngaged(mob)
    mob:setLocalVar("timer", os.time() + 60) -- spawn when less than 60% hp but only after 60s of fighting
end

function onMobFight(mob, target)
    if ((mob:getLocalVar("timer") < os.time() and mob:getHPP() < 60) or
        (mob:getHPP() < 30)) and mob:getLocalVar("spawnControl") == 0 then
        mob:setLocalVar("spawnControl", 1)
        local deathID = math.random(1,5)
        mob:setLocalVar("deathID", deathID) -- mobid offset of "random leveret" that despawns them all

        for i = 1, 5 do
            SpawnMob(mob:getID()+i):updateEnmity(target)
        end

        GetMobByID(mob:getID() + deathID):setLocalVar("deathID", deathID) -- set the "random leveret" var so it knows it's the special one
    end

    if
        GetMobByID(mob:getID() + mob:getLocalVar("deathID")):isDead() and
        mob:getLocalVar("spawnControl") == 1 and
        mob:getLocalVar("deathControl") == 0
    then
        mob:setLocalVar("deathControl", 1)
        mob:useMobAbility(688)
        mob:addMod(tpz.mod.ATTP, 60)
    end
end

function onMobDeath(mob, player, isKiller)
end
