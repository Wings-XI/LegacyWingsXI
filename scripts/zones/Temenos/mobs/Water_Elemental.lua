-----------------------------------
-- Area: Temenos E T
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Temenos/IDs")

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    -- double phys dmg as the mob family has -75% of each phys dmg type, effectively making them take -50% pdt instead of normal -75%
    mob:setMod(tpz.mod.DMGPHYS, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 50})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF6") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WATERDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+3):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+3)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+9)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[6] + (mobID - ID.mob.TEMENOS_E_MOB[6])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                tpz.limbus.spawnRandomCrate(crateID, battlefield, "crateMaskF6", battlefield:getLocalVar("crateMaskF6"), true)
            end
        end
    end
end
