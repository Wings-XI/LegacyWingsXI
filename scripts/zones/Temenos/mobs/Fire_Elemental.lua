-----------------------------------
-- Area: Temenos E T
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    mob:addMod(tpz.mod.DMGPHYS, 15)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PLAGUE, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF1") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+4):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+4)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+10)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[1] + (mobID - ID.mob.TEMENOS_E_MOB[1])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)

                local FirstChoice = math.random(3,5)

                if FirstChoice == 4 then
                    FirstChoice = FirstChoice + 1
                elseif FirstChoice == 5 then
                    FirstChoice = FirstChoice + 2
                end

                if battlefield:getLocalVar("1ChestSpawn") == 0 then
                    tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", FirstChoice, true)
                    battlefield:setLocalVar("1ChestSpawn", battlefield:getLocalVar("1ChestSpawn") + 1)
                    if FirstChoice == 3 then
                        battlefield:setLocalVar('1Blue', 1)
                    elseif FirstChoice == 5  then
                        battlefield:setLocalVar('1Gold', 1)
                    else
                        battlefield:setLocalVar('1Brown', 1)
                    end
                else
                    local nextChest = math.random(0,2)
                    if nextChest == 0 and battlefield:getLocalVar('1Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 3, true)
                        battlefield:setLocalVar('1Blue', 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('1Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 5, true)
                        battlefield:setLocalVar('1Gold', battlefield:getLocalVar('1Gold') + 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('1Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 7, true)
                        battlefield:setLocalVar('1Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('1Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 5, true)
                        battlefield:setLocalVar('1Gold', battlefield:getLocalVar('1Gold') + 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('1Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 7, true)
                        battlefield:setLocalVar('1Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('1Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 3, true)
                        battlefield:setLocalVar('1Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('1Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 7, true)
                        battlefield:setLocalVar('1Brown', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('1Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 3, true)
                        battlefield:setLocalVar('1Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('1Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", 5, true)
                        battlefield:setLocalVar('1Gold', battlefield:getLocalVar('1Gold') + 1)
                    end
                end
            end
        end
    end
end
