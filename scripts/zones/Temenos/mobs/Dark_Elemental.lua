-----------------------------------
-- Area: Temenos E T
--  Mob: Dark Elemental
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")

function onMobInitialize(mob)
    mob:addMod(tpz.mod.DMGMAGIC, -25)
    mob:addMod(tpz.mod.DMGPHYS, 15)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.CURSE, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        switch (mob:getID()): caseof
        {
            [ID.mob.TEMENOS_E_MOB[7]] = function ()
                if GetMobByID(ID.mob.TEMENOS_E_MOB[7]+1):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(tpz.status.NORMAL)
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]+1):setStatus(tpz.status.NORMAL)
                end
            end,
            [ID.mob.TEMENOS_E_MOB[7]+1] = function ()
                if GetMobByID(ID.mob.TEMENOS_E_MOB[7]):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(tpz.status.NORMAL)
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]+1):setStatus(tpz.status.NORMAL)
                end
            end,
        }
    end
end
