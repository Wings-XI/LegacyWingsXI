require("scripts/globals/settings")
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage"),
}

darkixion = {}


darkixion.zoneinfo =
{
    [tpz.zone.JUGNER_FOREST_S] =
        {
            zoneID = tpz.zone.JUGNER_FOREST_S,
            mobID = 17113468,
        },
    [tpz.zone.WEST_SARUTABARUTA_S] =
        {
            zoneID = tpz.zone.WEST_SARUTABARUTA_S,
            mobID = 17166730,
        },
    [tpz.zone.ROLANBERRY_FIELDS_S] =
        {
            zoneID = tpz.zone.ROLANBERRY_FIELDS_S,
            mobID = 17150321,
        },
    [tpz.zone.GRAUBERG_S] =
        {
            zoneID = tpz.zone.GRAUBERG_S,
            mobID = 17142112,
        },
    [tpz.zone.BATALLIA_DOWNS_S] =
        {
            zoneID = tpz.zone.BATALLIA_DOWNS_S,
            mobID = 17121697,
        },
    [tpz.zone.FORT_KARUGO_NARUGO_S] =
        {
            zoneID = tpz.zone.FORT_KARUGO_NARUGO_S,
            mobID = 17170649,
    },
    [tpz.zone.EAST_RONFAURE_S] =
        {
            zoneID = tpz.zone.EAST_RONFAURE_S,
            mobID = 17109367,
        },
}


darkixion.onZoneInit = function(zone)
end

darkixion.onZoneGameHour = function(zone)
end

darkixion.onMobInitialize = function(mob)
end