-----------------------------------
-- Area: The_Garden_of_RuHmet
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_GARDEN_OF_RUHMET] =
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
        CONQUEST_BASE                 = 7439, -- Tallying conquest results...
        WRONG_DEVICE                  = 7610, -- It appears to be some sort of device. It does not respond to your presence...
        PORTAL_WONT_OPEN              = 7612, -- The portal won't open from this side.
        NO_NEED_INVESTIGATE           = 7626, -- There is no need to investigate further.
        PORTAL_SEALED                 = 7647, -- The portal is firmly sealed by a mysterious energy.
        UNKNOWN_PRESENCE              = 7754, -- You sense some unknown presence...
        NONE_HOSTILE                  = 7755, -- You sense some unknown presence, but it does not seem hostile.
        MENACING_CREATURES            = 7756, -- Menacing creatures appear out of nowhere!
        SHEER_ANIMOSITY               = 7757, -- <name> is enveloped in sheer animosity!
        HOMEPOINT_SET                 = 7763, -- Home point set!
    },
    mob =
    {
        AWAERN_DRG_GROUPS   = -- First Aw'Aerns in each group. Used to randomize the mobID as the new placeholder.
        {
            16920777,
            16920781,
            16920785,
            16920789,
        },
        AWAERN_DRK_GROUPS   = {
            16920646, -- SW
            16920651, -- NW
            16920660, -- NE
            16920665, -- SE
        },
        IXZDEI_RDM_1        = 16921011,
        IXZDEI_RDM_2        = 16921012,
        IXZDEI_BLM_1        = 16921013,
        IXZDEI_BLM_2        = 16921014,
        JAILER_OF_FORTITUDE = 16921015,
        KFGHRAH_WHM         = 16921016,
        KFGHRAH_BLM         = 16921017,
        IXAERN_DRK          = 16921018,
        JAILER_OF_FAITH     = 16921021,
        IXAERN_DRG          = 16921022,
        WYNAV_START         = 16921023,
        WYNAV_END           = 16921025,
    },
    npc =
    {
        QM_IXAERN_DRK_POS          =
        {
            {-560, 5.00, 239}, -- Taru-Mithra
            {-600, 5.00, 440}, -- Mithra-Hume
            {-240, 5.00, 440}, -- Hume-Elvaan
            {-280, 5.00, 240}, -- Elvaan-Galka
        },
        QM_JAILER_OF_FORTITUDE_POS =
        {
            {-420.00, 0.00, 755.00}, -- North / Hume tower.
            {-43.00, 0.00, 460.00},  -- NE / Elvaan tower.
            {-260.00, 0.00, 44.821}, -- SE / Galka tower.
            {-580.00, 0.00, 43.00},  -- SW / Tarutaru tower.
            {-796.00, 0.00, 460.00}, -- NW / Mithra tower.
        },
        QM_JAILER_OF_FAITH_POS     =
        {
            {-420.00, 0.00, -157.00}, -- North / Hume tower.
            {-157.00, 0.00, -340.00}, -- NE / Elvaan tower.
            {-260.00, 0.00, -643.00}, -- SE / Galka tower.
            {-580.00, 0.00, -644.00}, -- SW / Tarutaru tower.
            {-683.00, 0.00, -340.00}, -- NW / Mithra tower.
        },
        QM_JAILER_OF_FORTITUDE     = 16921027,
        QM_IXAERN_DRK              = 16921028,
        QM_JAILER_OF_FAITH         = 16921029,
    },
}

return zones[tpz.zone.THE_GARDEN_OF_RUHMET]
