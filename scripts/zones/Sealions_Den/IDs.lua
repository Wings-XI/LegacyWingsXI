-----------------------------------
-- Area: Sealions_Den
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SEALIONS_DEN] =
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
        ORB_MESSAGE_OFFSET      = 7364, -- There is a crack in the <item>. It no longer contains a monster.
        CONQUEST_BASE           = 7420, -- Tallying conquest results...
        TENZEN_MSG_OFFSET       = 7910, -- 
        MAKKI_CHUBUKKI_OFFSET   = 7915, --
        KUKKI_CHEBUKKI_OFFSET   = 7921, --
        CHERUKIKI_OFFSET        = 7927, --
    },
    mob =
    {
        ONE_TO_BE_FEARED_OFFSET = 16908289,
        WARRIORS_PATH_OFFSET    = 16908310,
    },
    npc =
    {
        AIRSHIP_DOOR_OFFSET = 16908420,
    },
    aWarriorsPath = {
        [1] = {
            TENZEN_ID         = 16908310,
            MAKKI_SHAKKI_ID   = 16908311,
            KUKKI_CHEBUKKI_ID = 16908312,
            CHERUKKI_ID       = 16908313,
        },
        [2] = {
            TENZEN_ID         = 16908314,
            MAKKI_SHAKKI_ID   = 16908315,
            KUKKI_CHEBUKKI_ID = 16908316,
            CHERUKKI_ID       = 16908317,
        },
        [3] = {
            TENZEN_ID         = 16908318,
            MAKKI_SHAKKI_ID   = 16908319,
            KUKKI_CHEBUKKI_ID = 16908320,
            CHERUKKI_ID       = 16908321,
        }
    },
}

return zones[tpz.zone.SEALIONS_DEN]
