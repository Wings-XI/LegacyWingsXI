-----------------------------------
-- Area: The_Shrouded_Maw
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_SHROUDED_MAW] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        ORB_MESSAGE_OFFSET            = 7364, -- There is a crack in the <item>. It no longer contains a monster.
        CONQUEST_BASE                 = 7421, -- Tallying conquest results...
    },
    mob =
    {
        DIABOLOS_OFFSET = 16818177,
    },
    npc =
    {
        DARKNESS_NAMED_TILE_OFFSET = 16818259, -- _0a0 in npc_list
    },
    spawn =
    {
            {-300.212,  -48.0177,    220.050 },  -- Player spawn points for area 1
            {-60.222,   -8.0162,     -59.998 }   -- Player spawn points for area 2
            {219.955,   31.9897,     -340.014 }  -- Player spawn points for area 3
    },
}

return zones[tpz.zone.THE_SHROUDED_MAW]
