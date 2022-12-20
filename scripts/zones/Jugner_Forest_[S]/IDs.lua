-----------------------------------
-- Area: Jugner_Forest_[S]
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/dark_ixion")
-----------------------------------

zones = zones or {}

zones[tpz.zone.JUGNER_FOREST_S] =
{
    text =
    {
        NOTHING_HAPPENS          = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LOGGING_IS_POSSIBLE_HERE = 7069, -- Logging is possible here if you have <item>.
        CONQUEST_BASE            = 7268, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7362, -- You can't fish here.
        ALREADY_OBTAINED_TELE    = 7698, -- You already possess the gate crystal for this telepoint.
        VOKBROKGREG_THREE_TIMES  = 7799, -- Vokbrokgreg! Vokbrokgreg! Vokbrokgreg
        VOKBROKGREG              = 7871, -- Vokbrokgreg!
        COMMON_SENSE_SURVIVAL    = 9500, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DARK_IXION = darkixion.zoneinfo[tpz.zone.JUGNER_FOREST_S].mobID,
        DRUMSKULL_ZOGDREGG_PH =
        {
            [17113380] = 17113381, -- 195.578 -0.556 -347.699
        },
        FINGERFILCHER_DRADZAD = 17113462,
        COBRACLAW_BUCHZVOTCH  = 17113464,
        VULKODLAC = 17113463,
        VOIRLOUP_PH =
        {
            [17113174] = 17113175, -- -204.612, -0.313, -119.120
        },
    },
    npc =
    {
        LOGGING =
        {
            17113901,
            17113902,
            17113903,
            17113904,
            17113905,
            17113906,
        },
    },
}

return zones[tpz.zone.JUGNER_FOREST_S]
