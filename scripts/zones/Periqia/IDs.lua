-----------------------------------
-- Area: Periqia
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PERIQIA] =
{
    text = {
        ITEM_CANNOT_BE_OBTAINED       = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6389, -- Obtained: <item>.
        GIL_OBTAINED                  = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6392, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6393, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6394, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6398, -- You obtain <number> <item>!
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7149, -- Tallying conquest results...
        PLAYER_OBTAINS_ITEM           = 7311, -- <name> obtains <item>!
        ASSAULT_START_OFFSET          = 7446, -- USE ONLY to chose the right starting text for the right assault
        TIME_TO_COMPLETE              = 7507, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7508, -- The mission has failed. Leaving area.
        RUNE_UNLOCKED_POS             = 7509, -- ission objective completed. Unlocking Rune of Release ([A/B/C/D/E/F/G/H/I/J/K/L/M/N/O/P/Q/R/S/T/U/V/W/X/Y/Z]-#).
        RUNE_UNLOCKED                 = 7510, -- ission objective completed. Unlocking Rune of Release.
        ASSAULT_POINTS_OBTAINED       = 7511, -- You gain <number> [Assault point/Assault points]!
        TIME_REMAINING_MINUTES        = 7512, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7513, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7515, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        EXCALIACE_START               = 7524, -- Such a lot of trouble for one little corsair... Shall we be on our way?
        EXCALIACE_END1                = 7525, -- Yeah, I got it. Stay here and keep quiet.
        EXCALIACE_END2                = 7526, -- Hey... It was a short trip, but nothing is ever dull around you, huh?
        EXCALIACE_ESCAPE              = 7527, -- Heh. The Immortals really must be having troubles finding troops if they sent this bunch of slowpokes to watch over me...
        EXCALIACE_PAIN1               = 7528, -- Oomph!
        EXCALIACE_PAIN2               = 7529, -- Ouch!
        EXCALIACE_PAIN3               = 7530, -- Youch!
        EXCALIACE_PAIN4               = 7531, -- Damn, that's gonna leave a mark!
        EXCALIACE_PAIN5               = 7532, -- Urggh!
        EXCALIACE_MOB_ENGAGED         = 7533, -- Over to you.
        EXCALIACE_CRAB1               = 7534, -- What's this guy up to?
        EXCALIACE_NOT_USE             = 7535, -- Uh-oh.
        EXCALIACE_PUGIL1              = 7536, -- Wh-what the...!?
        EXCALIACE_DEBAUCHER1          = 7537, -- H-help!!!
        EXCALIACE_RUN                 = 7538, -- Now's my chance!
        EXCALIACE_TOO_CLOSE           = 7539, -- Okay, okay, you got me! I promise I won't run again if you step back a bit...please. Someone's been eating too much garlic...
        EXCALIACE_TIRED               = 7540, -- <Pant>...<wheeze>...
        EXCALIACE_CAUGHT              = 7541, -- Damn...
    },

    mob =
    {
        [SEAGULL_GROUNDED] =
        {
            MOBS_START =
            {
                17006594, 17006595, 17006596, 17006597, 17006598, 17006599, 17006600, 17006601,
                17006602, 17006603, 17006604, 17006605, 17006606, 17006607, 17006608, 17006610, 17006611,
            },
        },
        [REQUIEM] =
        {
            MOBS_START =
            {
                17006612, 17006613, 17006614, 17006615, 17006616, 17006617, 17006619, 17006620, 17006621,
                17006623, 17006625, 17006626, 17006627, 17006628, 17006630, 17006631, 17006633, 17006634,
            },
        },
        -- Shades of Vengeance
        [79] =
        {
            K23H1LAMIA1  = 17006754,
            K23H1LAMIA2  = 17006755,
            K23H1LAMIA3  = 17006756,
            K23H1LAMIA4  = 17006757,
            K23H1LAMIA5  = 17006758,
            K23H1LAMIA6  = 17006759,
            K23H1LAMIA7  = 17006760,
            K23H1LAMIA8  = 17006761,
            K23H1LAMIA9  = 17006762,
            K23H1LAMIA10 = 17006763,
        }

    },


    npc =
    {
        EXCALIACE       = 17006593,
        ANCIENT_LOCKBOX = 17006809,
        RUNE_OF_RELEASE = 17006810,
        _1K1            = 17006840,
        _1K2            = 17006841,
        _1K3            = 17006842,
        _1K4            = 17006843,
        _1K5            = 17006844,
        _1K6            = 17006845,
        _1K7            = 17006846,
        _1K8            = 17006847,
        _1K9            = 17006848,
        _1KA            = 17006849,
        _1KB            = 17006850,
        _1KC            = 17006851,
        _1KD            = 17006852,
        _1KE            = 17006853,
        _1KF            = 17006854,
        _1KG            = 17006855,
        _1KH            = 17006856,
        _1KI            = 17006857,
        _1KJ            = 17006858,
        _1KK            = 17006859,
        _1KL            = 17006860,
        _1KM            = 17006861,
        _1KN            = 17006862,
        _1KO            = 17006863,
        _1KP            = 17006864,
        _1KQ            = 17006865,
        _1KR            = 17006866,
        _1KS            = 17006867,
        _1KT            = 17006868,
        _1KU            = 17006869,
        _1KV            = 17006870,
        _1KW            = 17006871,
        _1KX            = 17006872,
        _1KY            = 17006873,
        _1KZ            = 17006874,
        _JK0            = 17006875,
        _JK1            = 17006876,
        _JK2            = 17006877,
        _JK3            = 17006878,
        _JK4            = 17006879,
        _JK5            = 17006880,
        _JK6            = 17006881,
        _JK7            = 17006882,
        _JK8            = 17006883,
        _JK9            = 17006884,
        _JKA            = 17006885,
        _JKB            = 17006886,
        _JKC            = 17006887,
        _JKD            = 17006888,
        _JKE            = 17006889,
        _JKF            = 17006890,
        _JKG            = 17006891,
        _JKH            = 17006892,
        _JKI            = 17006893,
        _JKJ            = 17006894,
        _JKK            = 17006895,
        _JKL            = 17006896,
        _JKM            = 17006897,
        _JKN            = 17006898,
        _JKO            = 17006899,
    }
}

return zones[tpz.zone.PERIQIA]
