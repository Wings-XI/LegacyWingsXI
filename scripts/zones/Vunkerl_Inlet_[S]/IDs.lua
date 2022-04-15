-----------------------------------
-- Area: Vunkerl_Inlet_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.VUNKERL_INLET_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET   = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        CONQUEST_BASE           = 7226, -- Tallying conquest results...
        THERE_IS_NO_REPONSE     = 7672, -- There is no response...
        COMMON_SENSE_SURVIVAL   = 9018, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        PALLAS      = 17117250,
        BIG_BANG_PH =
        {
            [17117347] = 17117349,
            [17117348] = 17117349,
        },
        PALLAS_PH =
        {
            [17117241] = 17117250,
            [17117246] = 17117250,
        },
    },
    npc =
    {
        INDESCRIPT_MARKINGS = 17118008,
    },
}

return zones[tpz.zone.VUNKERL_INLET_S]
