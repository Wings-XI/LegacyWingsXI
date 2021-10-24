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
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390, -- Obtained: <item>.
        GIL_OBTAINED            = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7050, -- Tallying conquest results...
        ORB_MESSAGE_OFFSET      = 7524, -- There is a crack in the <item>. It no longer contains a monster.
        GEMSTONE_SHIMMERS       = 7910, -- Before you, a small gemstone shimmers with light...
        GEMSTONE_FUSE           = 7911, -- With a blinding flash of light, the stones in your hand fuse together to form a brilliant crystal
    },
    mob = {
        -- Ode of Life Bestowing
        SEED_THRALLS =
        {
            17510453,
            17510454,
            17510455,
            17510456,
            17510457,
            17510458,
        },
    },
    npc =
    {
    },
}

return zones[tpz.zone.STELLAR_FULCRUM]
