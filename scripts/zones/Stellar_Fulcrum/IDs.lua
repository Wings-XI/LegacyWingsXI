-----------------------------------
-- Area: Stellar_Fulcrum
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.STELLAR_FULCRUM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7049, -- Tallying conquest results...
        ORB_MESSAGE_OFFSET            = 7523, -- There is a crack in the <item>. It no longer contains a monster.
        GEMSTONE_SHIMMERS             = 7908, -- Before you, a small gemstone shimmers with light...
        GEMSTONE_FUSE                 = 7909, -- With a blinding flash of light, the stones in your hand fuse together to form a brilliant crystal
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.STELLAR_FULCRUM]
