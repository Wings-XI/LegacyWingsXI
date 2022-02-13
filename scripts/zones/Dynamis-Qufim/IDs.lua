-----------------------------------
-- Area: Dynamis-Qufim
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_QUFIM] =
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
        OMINOUS_PRESENCE        = 7330, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    npc =
    {
        QM =
        {
            -- [16945638] =
            -- {
            --     param = {3458, 3479, 3480, 3481, 3482},
            --     trade =
            --     {
            --         {item = 3458,                     mob = 16945153}, -- Antaeus
            --         {item = {3479, 3480, 3481, 3482}, mob = 16945403}, -- Arch Antaeus
            --     }
            -- },
            -- [16945639] = {trade = {{item = 3468, mob = 16945421}}}, -- Lost Stringes
            -- [16945640] = {trade = {{item = 3467, mob = 16945457}}}, -- Lost Scolopendra
            -- [16945641] = {trade = {{item = 3469, mob = 16945470}}}, -- Lost Suttung
        },
    },
    mob =
    {
        scolopendra = 16945287,
        stringes = 16945320,
        suttung = 16945381,
        fire_elemental = 16945641,
        ice_elemental  = 16945635,
        air_elemental = 16945633,
        earth_elemental = 16945636,
        thunder_elemental = 16945632,
        water_elemental = 16945629,
        light_elemental = 16945634,
        dark_elemental = 16945642,
    }
}

return zones[tpz.zone.DYNAMIS_QUFIM]
