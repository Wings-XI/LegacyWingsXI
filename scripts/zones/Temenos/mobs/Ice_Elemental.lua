-----------------------------------
-- Area: Temenos E T
--  Mob: Ice Elemental
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [0] =
    {
        {200.000, -161.000, 197.000},
        {200.000, -161.000, 190.000}
    },
    [1] =
    {
        {197.000, -161.000, 200.000},
        {190.000, -161.000, 200.000}
    },
    [2] =
    {
        {200.000, -161.000, 203.000},
        {200.000, -161.000, 210.000}
    },
    [3] =
    {
        {203.000, -161.000, 200.000},
        {210.000, -161.000, 200.000}
    },
}

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    mob:addMod(tpz.mod.DMGPHYS, 15)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 100})
end

function onMobRoam(mob)
    if mob:getBattlefieldID() == 1300 then
        local offset = mob:getID() - ID.mob.TEMENOS_E_MOB[2]
        local pause = mob:getLocalVar("pause")
        if pause < os.time() then
            local point = (mob:getLocalVar("point") % 2)+1
            mob:setLocalVar("point", point)
            mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
            mob:setLocalVar("pause", os.time()+5)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF2") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.ICEDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+5):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+5)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+11)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[2] + (mobID - ID.mob.TEMENOS_E_MOB[2])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                local FirstChoice = math.random(3,5)

                if FirstChoice == 4 then
                    FirstChoice = FirstChoice + 1
                elseif FirstChoice == 5 then
                    FirstChoice = FirstChoice + 2
                end

                if battlefield:getLocalVar("2ChestSpawn") == 0 then
                    tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", FirstChoice, true)
                    battlefield:setLocalVar("2ChestSpawn", battlefield:getLocalVar("2ChestSpawn") + 1)
                    if FirstChoice == 3 then
                        battlefield:setLocalVar('2Blue', 1)
                    elseif FirstChoice == 5  then
                        battlefield:setLocalVar('2Gold', 1)
                    else
                        battlefield:setLocalVar('2Brown', 1)
                    end
                else
                    local nextChest = math.random(0,2)
                    if nextChest == 0 and battlefield:getLocalVar('2Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 3, true)
                        battlefield:setLocalVar('2Blue', 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('2Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 5, true)
                        battlefield:setLocalVar('2Gold', battlefield:getLocalVar('2Gold') + 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('2Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 7, true)
                        battlefield:setLocalVar('2Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('2Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 5, true)
                        battlefield:setLocalVar('2Gold', battlefield:getLocalVar('2Gold') + 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('2Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 7, true)
                        battlefield:setLocalVar('2Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('2Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 3, true)
                        battlefield:setLocalVar('2Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('2Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 7, true)
                        battlefield:setLocalVar('2Brown', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('2Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 3, true)
                        battlefield:setLocalVar('2Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('2Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF2", 5, true)
                        battlefield:setLocalVar('2Gold', battlefield:getLocalVar('2Gold') + 1)
                    end
                end
            end
        end
    end
end
