-----------------------------------
-- Area: Dynamis - Valkrum
--  Mob: Dragontrap
-----------------------------------
mixins = {require("scripts/mixins/dynamis_dreamland")}
require("scripts/globals/dynamis")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
    -- Set Mods
    mob:addMod(tpz.mod.REGAIN, 1250)
    mob:SetAutoAttackEnabled(false)
end

function onMobDeath(mob, player, isKiller)

end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
end

function onMobFight(mob)
    local ID = zones[zone]
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

    if mob:getLocalVar("PetsSpawned") ~= 1 then
        GetMobByID(ID.mobs.Dragontrap_2):setSpawn(mobX, mobY, mobZ)
        GetMobByID(ID.mobs.Dragontrap_2):setPos(mobX, mobY, mobZ)
        SpawnMob(ID.mobs.Dragontrap_2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        GetMobByID(ID.mobs.Dragontrap_3):setSpawn(mobX, mobY, mobZ)
        GetMobByID(ID.mobs.Dragontrap_3):setPos(mobX, mobY, mobZ)
        SpawnMob(ID.mobs.Dragontrap_3):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        mob:setLocalVar("PetsSpawned", 1)
    end
end