-----------------------------------
-- Area: Navukgo_Execution_Chamber
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NAVUKGO_EXECUTION_CHAMBER] =
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
        ORB_MESSAGE_OFFSET            = 7523, -- There is a crack in the <item>. It no longer contains a monster.
        KARABABA_FIGHT                = 7625, -- I do love a good fight! Gives me the chance to exercise my might!
        KARABABA_ENOUGH               = 7628, -- That's quite enough...
        KARABABA_ROUGH                = 7629, -- Time for me to start playing rough!
        KARABABA_FIRE                 = 7630, -- Fuel for the fire! It doesn't pay to invoke my ire!
        KARABABA_ICE                  = 7631, -- Well, if you won't play nice, I'll put your sorry hide on ice!
        KARABABA_WIND                 = 7632, -- This battle is growing stale. How about we have a refreshing gale!
        KARABABA_EARTH                = 7633, -- Sometimes it comes as quite a shock, how much damage you can deal with simple rock!
        KARABABA_LIGHTNING            = 7634, -- How I love to rip things asunder! Witness the power of lightning and thunder!
        KARABABA_WATER                = 7635, -- Water is more dangerous than most expect. Never fear, I'll teach you respect!
        KARABABA_QUIT                 = 7644, -- What a completely useless shield. It's time for me to quit the field.
        KARABABA_OOF                  = 7636, -- Oof....
        KARABABA_URGH                 = 7637, -- Urgh...
        KARABABA_OUCH                 = 7638, -- Ouch...
        KARABABA_HURT                 = 7639, -- I'm getting hurt? I Must keep a little more alert...
        KARABABA_VICTORY              = 7640, -- Ohohohoho! Victory is mine! Is there a feeling quite so fine?
        KHIMAIRA_RAGGED               = 7649, -- The khimaira's breathing has grown ragged.
        KHIMAIRA_RECOVERED            = 7650, -- The khimaira has recovered
    },
    mob =
    {
        KARABABA_OFFSET = 17039401,
        IMMORTAL_FLAN2  = 17039375, -- IMMORTAL_FLAN1 always pops in battlefield, other flans pop depending on party size
        IMMORTAL_FLAN3  = 17039376,
        IMMORTAL_FLAN4  = 17039377,
        IMMORTAL_FLAN5  = 17039378,
        IMMORTAL_FLAN6  = 17039379,
    },
    npc =
    {
    },
}

return zones[tpz.zone.NAVUKGO_EXECUTION_CHAMBER]
