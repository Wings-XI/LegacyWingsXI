-----------------------------------
-- Area: Chamber_of_Oracles
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CHAMBER_OF_ORACLES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6388, -- Obtained: <item>.
        GIL_OBTAINED                     = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                     = 6392, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS              = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED    = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7049, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7210, -- You cannot enter the battlefield at present. Please wait a little longer.
        ORB_MESSAGE_OFFSET               = 7523, -- There is a crack in the <item>. It no longer contains a monster.
        PLACED_INTO_THE_PEDESTAL         = 7617, -- It appears that something should be placed into this pedestal.
        YOU_PLACE_THE                    = 7618, -- You place the <item> into the pedestal.
        IS_SET_IN_THE_PEDESTAL           = 7619, -- The <item> is set in the pedestal.
        HAS_LOST_ITS_POWER               = 7620, -- The <item> has lost its power.
        YOU_DECIDED_TO_SHOW_UP           = 7640, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY      = 7641, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY            = 7642, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS      = 7643, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER     = 7644, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP            = 7645, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING      = 7646, -- Ungh... That'll hurt in the morning...
        CAT_BURGLAR                      = 7669, -- Time for the Cat Burglar to barrre her claws...
        SHOW_EM_WHAT_YOU_GOT             = 7670, -- Cha! Show 'em what ya've got.
        A_LITTLE_HELP                    = 7671, -- Bopa! A little help here!?
        EARNED_MY_PAY                    = 7672, -- Grrr... Bah, I've earrrned my pay. I'm outta here!
        YA_RANG_BOSS                     = 7673, -- [Cha] Ya rrrang, boss?
        BOPA_SCRATCHING_POST             = 7674, -- [Bopa] Bopa's gonna use you for a scrratchin' post!
        THIS_WONT_HURT_MUCH              = 7675, -- Sit still, will ya? This won't hurrrt...much!
        CHECK_THIS_OUT                   = 7676, -- Hey boss, check this out!
        DINNERTIME                       = 7677, -- It's almost dinnerrrtime. Let's turn this one into mithkabob meat!
        MAKE_SAUSAGE                     = 7678, -- We're gonna make sausage out of your entrrrails!
        LOOK_WHAT_I_CAN_DO               = 7679, -- Hey boss! Look what I've been prrracticing!
        YOU_THINK_YOU_CAN_TAKE_US        = 7680, -- Hah! You rrreally think you can take us?
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CHAMBER_OF_ORACLES]
