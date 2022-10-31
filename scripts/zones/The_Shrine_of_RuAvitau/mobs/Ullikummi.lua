-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Ullikummi
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 1000)

    mob:addListener("WEAPONSKILL_USE", "ULLI_WEAPONSKILL_USE", function(entity, target, wsid, tp, action)

        if wsid == 675 and target:isPC() and action:param(target:getID()) > 1 then
            entity:resetEnmity(target)
        end
    end)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGEN, 10)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.ULLIKUMMI_QM):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
    mob:removeListener("ULLI_WEAPONSKILL_USE")
end
