-----------------------------------
-- Area: Rolanberry_Fields_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ROLANBERRY_FIELDS_S] =
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
        FISHING_MESSAGE_OFFSET  = 7069, -- You can't fish here.
        CONQUEST_BASE           = 7246, -- Tallying conquest results...
        COMMON_SENSE_SURVIVAL   = 9249, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DELICIEUSE_DELPHINE_PH =
        {
            [17150279] = 17150280, -- -484.535 -23.756 -467.462
        },
        ERLE_PH =
        {
            [17150075] = 17150081, -- -289.200, 11.876, 167.930
        },
        DYINYINGA_PH =
        {
            [17150045] = 17150047, -- 209.040, -33.060, -182.740
            [17150046] = 17150047, -- 169.810, -32.150, -163.930
        },
    },
    npc =
    {
    },
}

return zones[tpz.zone.ROLANBERRY_FIELDS_S]
