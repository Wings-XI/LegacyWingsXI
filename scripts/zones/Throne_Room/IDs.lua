-----------------------------------
-- Area: Throne_Room
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THRONE_ROOM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6392, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7049, -- Tallying conquest results...
        ORB_MESSAGE_OFFSET            = 7523, -- There is a crack in the <item>. It no longer contains a monster.
        NO_HIDE_AWAY                  = 7698, -- I have not been hiding away from my troubles!
        FEEL_MY_PAIN                  = 7699, -- Feel my twenty years of pain!
        YOUR_ANSWER                   = 7700, -- Is that your answer!?
        RETURN_TO_THE_DARKNESS        = 7701, -- Return with your soul to the darkness you came from!
        CANT_UNDERSTAND               = 7702, -- You--a man who has never lived bound by the chains of his country--how can you understand my pain!?
        BLADE_ANSWER                  = 7703, -- Let my blade be the answer!
        BONANZA_BEGINS                = 7777, -- Now for the moment you pathetic fools have been waiting for! The drawing for the Mega Mog Bonanza-Rama-Palooza begins!
        RANK_2_PRIZE                  = 7778, -- Oh, lucky you! A Rank 2 prize! Here's some gil for ya...!
        BOOBY_PRIZE                   = 7779, -- OHHHHHH, I'm sorry... Looks like you get the booby prize!
        CRYSTAL_PRIZE                 = 7780, -- <Ding-ding-ding!> Oh my, ladies and gentlemen! It looks like we have a winner for the Crystal Prize!
        THIRD_PRIZE_REST_RELAXATION   = 7781, -- Third prize for me...some well-deserved rest and relaxation!
        THAT_HIT_THE_SPOT             = 7781, -- Ahhhhhh...that hit the spot!
    },
    mob =
    {
        SHADOW_LORD_STAGE_2_OFFSET = 17453060,
        ZEID_BCNM_OFFSET           = 17453063,
        RIKO_KUPENREICH_OFFSET     = 17453102,
    },
    npc =
    {
    },
}

return zones[tpz.zone.THRONE_ROOM]
