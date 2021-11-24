-----------------------------------
-- Area: Temenos E T
--  Mob: Thunder Elemental
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.WALLHACK
local path =
{
    [0] =
    {
        {-312.000, 0.000, 128.000},
        {-312.000, 0.000, 152.000}
    },
    [1] =
    {
        {-300.000, 0.000, 152.000},
        {-300.000, 0.000, 128.000}
    },
    [2] =
    {
        {-248.000, 0.000, 152.000},
        {-248.000, 0.000, 128.000}
    },
    [3] =
    {
        {-260.000, 0.000, 128.000},
        {-260.000, 0.000, 152.000}
    },
}

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    mob:addMod(tpz.mod.DMGPHYS, 15)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 100})
end

function onMobRoam(mob)
    if mob:getBattlefieldID() == 1300 then
        local offset = mob:getID() - ID.mob.TEMENOS_E_MOB[5]
        local pause = mob:getLocalVar("pause")
        if pause < os.time() then
            local point = (mob:getLocalVar("point") % 2)+1
            mob:setLocalVar("point", point)
            mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
            mob:setLocalVar("pause", os.time()+10)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF5") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.THUNDERDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+8):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+8)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+14)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[5] + (mobID - ID.mob.TEMENOS_E_MOB[5])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                local FirstChoice = math.random(3,5)

                if FirstChoice == 4 then
                    FirstChoice = FirstChoice + 1
                elseif FirstChoice == 5 then
                    FirstChoice = FirstChoice + 2
                end

                if battlefield:getLocalVar("5ChestSpawn") == 0 then
                    tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", FirstChoice, true)
                    battlefield:setLocalVar("5ChestSpawn", battlefield:getLocalVar("5ChestSpawn") + 1)
                    if FirstChoice == 3 then
                        battlefield:setLocalVar('5Blue', 1)
                    elseif FirstChoice == 5  then
                        battlefield:setLocalVar('5Gold', 1)
                    else
                        battlefield:setLocalVar('5Brown', 1)
                    end
                else
                    local nextChest = math.random(0,2)
                    if nextChest == 0 and battlefield:getLocalVar('5Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 3, true)
                        battlefield:setLocalVar('5Blue', 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('5Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 5, true)
                        battlefield:setLocalVar('5Gold', battlefield:getLocalVar('5Gold') + 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('5Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 7, true)
                        battlefield:setLocalVar('5Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('5Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 5, true)
                        battlefield:setLocalVar('5Gold', battlefield:getLocalVar('5Gold') + 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('5Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 7, true)
                        battlefield:setLocalVar('5Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('5Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 3, true)
                        battlefield:setLocalVar('5Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('5Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 7, true)
                        battlefield:setLocalVar('5Brown', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('5Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 3, true)
                        battlefield:setLocalVar('5Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('5Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF5", 5, true)
                        battlefield:setLocalVar('5Gold', battlefield:getLocalVar('5Gold') + 1)
                    end
                end
            end
        end
    end
end
