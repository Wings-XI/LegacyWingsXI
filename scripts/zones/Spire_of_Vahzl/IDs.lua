-----------------------------------
-- Area: Spire_of_Vahzl
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SPIRE_OF_VAHZL] =
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
        FAINT_SCRAPING                = 7081, -- You can hear a faint scraping sound from within, but the way is barred by some strange membrane...
        ORB_MESSAGE_OFFSET            = 7364, -- There is a crack in the <item>. It no longer contains a monster.
        CONQUEST_BASE                 = 7439, -- Tallying conquest results...
    },
    mob =
    {
    },
    npc =
    {
    },
    pullingThePlug = {
        [1] = {
            RED_ID       = 16871446,
            GREEN_ID     = 16871447,
            BLUE_ID      = 16871448,
            TEAL_ID      = 16871449,
            CONTEMPLATOR = 16871450,
            INGURGITATOR = 16871451,
            REPINER      = 16871452,
            INGURG_PET1  = 16871453,
            INGURG_PET2  = 16871454,
        },
        [2] = {
            RED_ID       = 16871456,
            GREEN_ID     = 16871457,
            BLUE_ID      = 16871458,
            TEAL_ID      = 16871459,
            CONTEMPLATOR = 16871460,
            INGURGITATOR = 16871461,
            REPINER      = 16871462,
            INGURG_PET1  = 16871463,
            INGURG_PET2  = 16871464,
        },
        [3] = {
            RED_ID       = 16871466,
            GREEN_ID     = 16871467,
            BLUE_ID      = 16871468,
            TEAL_ID      = 16871469,
            CONTEMPLATOR = 16871470,
            INGURGITATOR = 16871471,
            REPINER      = 16871472,
            INGURG_PET1  = 16871473,
            INGURG_PET2  = 16871474,
        },
    },
}

return zones[tpz.zone.SPIRE_OF_VAHZL]
