-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(tpz.mobMod.TELEPORT_START, 988)
    mob:setMobMod(tpz.mobMod.TELEPORT_END, 989)
    mob:setMobMod(tpz.mobMod.TELEPORT_TYPE, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.MACC, 50)
    mob:addMod(tpz.mod.UFASTCAST, 60)
    mob:addMod(tpz.mod.UDMGMAGIC, -95)
    mob:addMod(tpz.mod.UDMGPHYS, -40)
    mob:addMod(tpz.mod.EVA, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 25)
end

function onMobDeath(mob, player, isKiller)
end
