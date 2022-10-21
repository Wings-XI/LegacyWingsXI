-----------------------------------
-- Area: Dynamis-Valkurm
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_VALKURM] =
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
            -- [16937585] =
            -- {
            --     param = {3456, 3470, 3471, 3472, 3473},
            --     trade =
            --     {
            --         {item = 3456,                     mob = 16936961}, -- Cirrate Christelle
            --         {item = {3470, 3471, 3472, 3473}, mob = 16937290}, -- Arch Christelle
            --     }
            -- },
            -- [16937586] = {trade = {{item = 3461, mob = 16937311}}}, -- Lost Nant'ina
            -- [16937587] = {trade = {{item = 3460, mob = 16937432}}}, -- Lost Fairy Ring
            -- [16937588] = {trade = {{item = 3462, mob = 16937415}}}, -- Lost Stcemqestcint
        },
    },
    mobs =
    {
        Nightmare_Fly_1 = 16937012,
        Nightmare_Fly_2 = 16937013,
        Nightmare_Fly_3 = 16937014,
        sjRestrictionNPC = 16937585,
        Nantina = 16937077,
        Stcemqestcint = 16937051,
        Fairy_Ring = 16937100,
        Dragontrap_1 = 16937576,
        Dragontrap_2 = 16937577,
        Dragontrap_3 = 16937578,
        Megaboss = 16936961,
        Nightmare_Morbol_1 = 16937634,
        Nightmare_Morbol_2 = 16937635,
    },
}

return zones[tpz.zone.DYNAMIS_VALKURM]
