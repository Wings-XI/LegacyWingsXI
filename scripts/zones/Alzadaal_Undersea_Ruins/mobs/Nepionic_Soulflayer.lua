-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Nepionic Soulflayer
-- Note: Retail capture looks like he
-- casts AM faster (because they reduced cast times)
-----------------------------------
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(tpz.mobMod.NO_STANDBACK, 1)
    mob:setMod(tpz.mod.POISONRES, 20)
    mob:setMod(tpz.mod.POISONRESTRAIT, 50)
    mob:setMod(tpz.mod.FASTCAST, 40)
end

function onMobSpawn(mob)
    mob:setLocalVar("specialThreshold", math.random(55, 75));
end

function onMobFight(mob)
    if mob:getHPP() < mob:getLocalVar("specialThreshold") then
        mob:useMobAbility(tpz.jsa.MANAFONT)
        mob:setLocalVar("specialThreshold", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("TransformationsProgress") == 4 then
        player:setCharVar("TransformationsProgress", 5)
    end
end
