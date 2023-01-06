-----------------------------------
-- Area: Dynamis-Tavnazia
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_TAVNAZIA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7314, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7315, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7316, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7317, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7319, -- The sands of the hourglass have emptied...
        DIABOLOS                = 7328, -- You sense that something might happen if you possessed one of these...
        OMINOUS_PRESENCE        = 7330, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    npc =
    {
        QM =
        {
            -- [16949396] =
            -- {
            --     param = {3459, 3483, 3484, 3485, 3486},
            --     trade =
            --     {
            --         {item = 3459,                     mob = {16949249, 16949250, 16949251, 16949252}}, -- Diabolos Spade/Heart/Diamond/Club
            --         {item = {3483, 3484, 3485, 3486}, mob = {16949326, 16949327, 16949328, 16949329}}, -- Diabolos Somnus/Nox/Umbra/Letum
            --     }
            -- },
        },
    },
    mobs =
    {
        DIABOLOS = {
            16949249, -- Diabolos_Spade
            16949250, -- Diabolos_Heart
            16949251, -- Diabolos_Diamond
            16949252, -- Diabolos_Club
        },
        Nightmare_Bugard = 16949255,
        Nightmare_Worm = 16949257,
        Nightmare_Antlion = 16949256,
        winQM = 16949396,
        -- Megaboss = 1,
    },
}

return zones[tpz.zone.DYNAMIS_TAVNAZIA]
