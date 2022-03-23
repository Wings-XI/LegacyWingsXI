-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Marquis Cimeries
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
-----------------------------------

local zone = 135

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Xarcabard/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    if isKiller then
        local demonIDs =
        {
            17330377, 17330353, 17330223, 17330304, 17330390, 17330332, 17330360, 17330315,
            17330481, 17330417, 17330451, 17330343, 17330440, 17330430, 17330415,
        }
        local demonsKilled = {}
        for i, v in ipairs(demonIDs) do
            local demons = GetMobByID(v)
            if demons:getLocalVar("dynaIsDefeatedForWaveReq") == 1 then
                table.insert(demonsKilled, v)
            end
        end
        if #demonsKilled == 15 then
            local dynaPlayers =  player:getZone():getPlayers()
            for _, dynaPlayer in pairs(dynaPlayers) do
                dynaPlayer:messageSpecial(ID.text.PRISON_OF_SOULS_HAS_SET_FREE)
            end
        end
    end
end

function onMobSpawn(mob)
    dynamis.setNMStats(mob)
end
