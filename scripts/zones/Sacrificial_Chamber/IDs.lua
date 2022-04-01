-----------------------------------
-- Area: Sacrificial_Chamber
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SACRIFICIAL_CHAMBER] =
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
        DSHANTOTTO_ENGAGE             = 7622, -- We warmly welcome you to the place of your unmaking.
        SHANTOTTO_ENGAGE              = 7623, -- From your ground bones, a loaf of bread we shall be baking.
        DSHANTOTTO_75                 = 7624, -- We shall curse you unto death! Prepare to breathe your final breath!
        SHANTOTTO_75                  = 7625, -- We will make you beg to die! Six fulms under you will lie!
        DSHANTOTTO_50                 = 7626, -- Naughty children shall receive no quarter! Curl up and die, this is your empress's order!
        SHANTOTTO_50                  = 7627, -- You've long overstayed your welcome! The punishment will be brutal and gruesome!
        DSHANTOTTO_25                 = 7628, -- Which way do you like it--slow or fast? Should you lose a limb, be not aghast!
        SHANTOTTO_25                  = 7629, -- You'll wish you were never born! From your torso limbs will be torn!
        SHANTOTTO_METEOR1             = 7630, -- Steel yourself for a wicked fright!
        SHANTOTTO_METEOR2             = 7631, -- We shall set your pants alight!
        DSHANTOTTO_METEOR1            = 7632, -- The world shall bow before our might!
        DSHANTOTTO_DEATH              = 7633, -- H-how could this be? This outcome, we did not foresee...
        SHANTOTTO_DEATH               = 7634, -- Be this a dream? Or is it real? This ending falls sorely short of ideal...
        DSHANTOTTO_DISENGAGE          = 7635, -- 'Twas high time you were made to know that your abilities are purely for show. O〜hohohohoho!
        SHANTOTTO_DISENGAGE           = 7636, -- A fitting end for a talentless crew that tried to bite off more than it could chew. O〜hohohohoho!
        DOOR_SHUT                     = 7689, -- The door is firmly shut.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.SACRIFICIAL_CHAMBER]
