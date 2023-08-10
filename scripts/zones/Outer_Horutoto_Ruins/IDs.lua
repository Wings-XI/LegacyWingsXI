-----------------------------------
-- Area: Outer_Horutoto_Ruins
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.OUTER_HORUTOTO_RUINS] =
{
    text =
    {
        ORB_ALREADY_PLACED       = 0,     -- A dark Mana Orb is already placed here.
        CONQUEST_BASE            = 15,    -- Tallying conquest results...
        DEVICE_NOT_WORKING       = 188,   -- The device is not working.
        SYS_OVERLOAD             = 197,   -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE             = 202,   -- You lost the <item>.
        ITEM_CANNOT_BE_OBTAINED  = 6587,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6593,  -- Obtained: <item>.
        GIL_OBTAINED             = 6594,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6596,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6597,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6622,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7204,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7205,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7206,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED     = 7215,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        DOOR_FIRMLY_SHUT         = 7254,  -- The door is firmly shut.
        ALL_G_ORBS_ENERGIZED     = 7257,  -- The six Mana Orbs have been successfully energized with magic!
        CHEST_UNLOCKED           = 7280,  -- You unlock the chest!
        IF_HAD_ORBS              = 7338,  -- You sense that if you had <keyitem>, <keyitem>, <keyitem>, or <keyitem>, something might happen.
        VENTURED_FAR_WARNING     = 7345,  -- You have ventured too far from the field of battle. The Confrontation will automatically disengage if you do not return.
        VENTURED_FAR_DISENGAGE   = 7346,  -- You have ventured too far from the field of battle. The Confrontation has been disengaged.
        YOU_HAVE_RETURNED        = 7347,  -- You have returned to the field of battle.
        MINUTES_TO_COMPLETE      = 7348,  -- You have <time> minutes (Earth time) to complete the battle.
        MINUTES_REMAINING        = 7349,  -- You have <time> minutes (Earth time) remaining to complete the battle.
        SECONDS_REMAINING        = 7350,  -- You have only <time> seconds (Earth time) remaining.
        TIME_IS_UP               = 7351,  -- Your time for this Confrontation is up...
        PLAYER_OBTAINS_ITEM      = 8257,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8258,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8259,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8260,  -- You already possess that temporary item.
        NO_COMBINATION           = 8265,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10343, -- New training regime registered!
    },
    mob =
    {
        DESMODONT_PH                =
        {
            [17571868] = 17571870,
        },
        AH_PUCH_PH                  =
        {
            [17571893] = 17571903, -- -418, -1, 629
            [17571894] = 17571903, -- -419, -1, 570
            [17571895] = 17571903, -- -419, -1, 581
            [17571896] = 17571903, -- -418, -1, 590
            [17571897] = 17571903, -- -418, -1, 597
            [17571898] = 17571903, -- -417, -1, 640
            [17571899] = 17571903, -- -419, -1, 615
            [17571900] = 17571903, -- -417, -1, 661
        },
        BALLOON_NM_OFFSET           = 17572141,
        FULL_MOON_FOUNTAIN_OFFSET   = 17572197,
        JACK_OF_CUPS                = 17572197,
        JACK_OF_BATONS              = 17572198,
        JACK_OF_SWORDS              = 17572199,
        JACK_OF_COINS               = 17572200,
        JESTER_WHO_D_BE_KING_OFFSET = 17572201,
        APPARATUS_ELEMENTAL         = 17572203,
        CUSTOM_CARDIAN_OFFSET       = 17572204,
        CUSTOM_CARDIANS             =
        {
            17572204,
            17572205,
            17572206,
            17572207,
            17572208,
            17572209,
            17572210,
            17572211,
            17572212,
            17572213,
            17572214,
            17572215,
            17572216,
            17572217,
            17572218,
            17571921,
            17571922,
            17571923,
            17571924,
            17571925,
        }
    },
    npc =
    {
        CASKET_BASE        = 17572223,
        GATE_MAGICAL_GIZMO = 17572248,
        TREASURE_CHEST     = 17572290,
        QM1                = 17572302,
    },
}

return zones[tpz.zone.OUTER_HORUTOTO_RUINS]
