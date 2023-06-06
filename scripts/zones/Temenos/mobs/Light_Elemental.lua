-----------------------------------
-- Area: Temenos E T
--  Mob: Light Elemental
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    -- double phys dmg as the mob family has -75% of each phys dmg type, effectively making them take -50% pdt instead of normal -75%
    mob:setMod(tpz.mod.DMGPHYS, 100)
    mob:addMod(tpz.mod.DMGMAGIC, -40)
    mob:setMobMod(tpz.mobMod.NO_LINK, 1) -- allows carby pulls due to NMs not having a neutral timer
end

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2]+1 then
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]):updateEnmity(target)
    elseif mobID == ID.mob.TEMENOS_C_MOB[2]+2 then
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        switch (mob:getID()): caseof
        {
            [ID.mob.TEMENOS_C_MOB[2]+1] = function()
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_C_CRATE[2]):setStatus(tpz.status.NORMAL)
                end
            end,
            [ID.mob.TEMENOS_C_MOB[2]+2] = function()
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_C_CRATE[2]):setStatus(tpz.status.NORMAL)
                end
            end,
        }
    end
end
