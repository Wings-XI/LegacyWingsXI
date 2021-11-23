-----------------------------------
-- Area: Temenos E T
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [1] =
    {
        {20.000, 6.000, 150.000},
        {20.000, 6.000, 142.640}
    },
    [3] =
    {
        {60.000, 6.000, 150.000},
        {60.000, 6.000, 142.640}
    },
}

function onMobRoam(mob)
    if mob:getBattlefieldID() == 1300 then
        local offset = mob:getID() - ID.mob.TEMENOS_E_MOB[3]
        local pause = mob:getLocalVar("pause")
        if pause < os.time() and offset == 1 or offset == 3 then
            local point = (mob:getLocalVar("point") % 2)+1
            mob:setLocalVar("point", point)
            mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
            mob:setLocalVar("pause", os.time()+5)
        end
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF3") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WINDDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+6):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+6)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+12)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[3] + (mobID - ID.mob.TEMENOS_E_MOB[3])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                local FirstChoice = math.random(3,5)

                if FirstChoice == 4 then
                    FirstChoice = FirstChoice + 1
                elseif FirstChoice == 5 then
                    FirstChoice = FirstChoice + 2
                end

                if battlefield:getLocalVar("3ChestSpawn") == 0 then
                    tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", FirstChoice, true)
                    battlefield:setLocalVar("3ChestSpawn", battlefield:getLocalVar("3ChestSpawn") + 1)
                    if FirstChoice == 3 then
                        battlefield:setLocalVar('3Blue', 1)
                    elseif FirstChoice == 5  then
                        battlefield:setLocalVar('3Gold', 1)
                    else
                        battlefield:setLocalVar('3Brown', 1)
                    end
                else
                    local nextChest = math.random(0,2)
                    if nextChest == 0 and battlefield:getLocalVar('3Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 3, true)
                        battlefield:setLocalVar('3Blue', 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('3Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 5, true)
                        battlefield:setLocalVar('3Gold', battlefield:getLocalVar('3Gold') + 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('3Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 7, true)
                        battlefield:setLocalVar('3Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('3Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 5, true)
                        battlefield:setLocalVar('3Gold', battlefield:getLocalVar('3Gold') + 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('3Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 7, true)
                        battlefield:setLocalVar('3Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('3Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 3, true)
                        battlefield:setLocalVar('3Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('3Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 7, true)
                        battlefield:setLocalVar('3Brown', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('3Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 3, true)
                        battlefield:setLocalVar('3Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('3Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF3", 5, true)
                        battlefield:setLocalVar('3Gold', battlefield:getLocalVar('3Gold') + 1)
                    end
                end
            end
        end
    end
end
