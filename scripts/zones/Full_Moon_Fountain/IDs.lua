-----------------------------------
-- Area: Full_Moon_Fountain
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.FULL_MOON_FOUNTAIN] =
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
        CONQUEST_BASE                 = 7049, -- Tallying conquest results...
        UNABLE_TO_PROTECT             = 7366, -- You were unable to protect Ajido-Marujido. Now leaving the battlefield.
        ORB_MESSAGE_OFFSET            = 7619, -- There is a crack in the <item>. It no longer contains a monster.
        PLAY_TIME_IS_OVER             = 7752, -- Play time is over! Powers of dark mana, answer my call!
        YOU_SHOULD_BE_THANKFUL        = 7753, -- You should be thankful. I'll give you a shortaru trip back to the hell you came from!
        DONT_GIVE_UP                  = 7754, -- Don't give up, adventurer! You are Windurst's guiding star, our beacon of hope!
    },
    mob =
    {
        MOON_READING_OFFSET = 17473540,
    },
    npc =
    {
    },
    battaru_royale =
    {
        CLONE_OF_BOULDERS =
        {
            17473595,
            17473611,
            17473627,
        },
        CLONE_OF_FLAMES =
        {
            17473591,
            17473607,
            17473623,
        },
        CLONE_OF_GLACIERS =
        {
            17473601,
            17473617,
            17473633,
        },
        CLONE_OF_GUSTS =
        {
            17473597,
            17473613,
            17473629,
        },
        CLONE_OF_LIGHTS =
        {
            17473603,
            17473619,
            17473635,
        },
        CLONE_OF_SHADOWS =
        {
            17473605,
            17473621,
            17473637,
        },
        CLONE_OF_SPARKS =
        {
            17473599,
            17473615,
            17473631,
        },
        CLONE_OF_TORRENTS =
        {
            17473593,
            17473609,
            17473625,
        },
    },
}

return zones[tpz.zone.FULL_MOON_FOUNTAIN]
