-----------------------------------
-- Area: Temenos E T
--  Mob: Earth Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    mob:addMod(tpz.mod.DMGPHYS, 15)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF4") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.EARTHDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+7):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+7)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+13)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[4] + (mobID - ID.mob.TEMENOS_E_MOB[4])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                local FirstChoice = math.random(3,5)

                if FirstChoice == 4 then
                    FirstChoice = FirstChoice + 1
                elseif FirstChoice == 5 then
                    FirstChoice = FirstChoice + 2
                end

                if battlefield:getLocalVar("4ChestSpawn") == 0 then
                    tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", FirstChoice, true)
                    battlefield:setLocalVar("4ChestSpawn", battlefield:getLocalVar("4ChestSpawn") + 1)
                    if FirstChoice == 3 then
                        battlefield:setLocalVar('4Blue', 1)
                    elseif FirstChoice == 5  then
                        battlefield:setLocalVar('4Gold', 1)
                    else
                        battlefield:setLocalVar('4Brown', 1)
                    end
                else
                    local nextChest = math.random(0,2)
                    if nextChest == 0 and battlefield:getLocalVar('4Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 3, true)
                        battlefield:setLocalVar('4Blue', 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('4Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 5, true)
                        battlefield:setLocalVar('4Gold', battlefield:getLocalVar('4Gold') + 1)
                    elseif nextChest == 0 and battlefield:getLocalVar('4Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 7, true)
                        battlefield:setLocalVar('4Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('4Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 5, true)
                        battlefield:setLocalVar('4Gold', battlefield:getLocalVar('4Gold') + 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('4Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 7, true)
                        battlefield:setLocalVar('4Brown', 1)
                    elseif nextChest == 1 and battlefield:getLocalVar('4Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 3, true)
                        battlefield:setLocalVar('4Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('4Brown') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 7, true)
                        battlefield:setLocalVar('4Brown', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('4Blue') == 0 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 3, true)
                        battlefield:setLocalVar('4Blue', 1)
                    elseif nextChest == 2 and battlefield:getLocalVar('4Gold') < 2 then
                        tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", 5, true)
                        battlefield:setLocalVar('4Gold', battlefield:getLocalVar('4Gold') + 1)
                    end
                end
            end
        end
    end
end
