-----------------------------------
-- Area: La_Vaule_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LA_VAULE_S] =
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
        FISHING_MESSAGE_OFFSET        = 7049, -- You can't fish here.
        CONQUEST_BASE                 = 7226, -- Tallying conquest results...
    },
    mob =
    { 
        HAWKEYED_DNATBAT_PH =
        {
            [17125431] = 17125433, -- 375.737 0.272 -174.487
        },
        ASHMAKER_GOTBLUT_PH =
        {
            [17125450] = 17125452, -- 234.481 3.424 -241.751
        },
        SHATTERSKULL_MIPPDAPP_PH = 
        {
            [17125492] = 17125494,  --  -61.291, -0.524, 61.806
        },

        
        AGRIOS                 = 17125663,
        ALL_SEEING             = 17125661,
        COGTOOTH_SKAGNOGG      = 17125662,
        COINBITER_CJAKNOKK     = 17125654,
        DRAKETRADER_ZLODGODD   = 17125655,
        FALSESPINNER_BHUDBRODD = 17125664,
        FEEBLESCHEME_BHOGBIGG  = 17125656,
        RUGAROO                = 17125665,
    },
    npc =
    {
    },
}

return zones[tpz.zone.LA_VAULE_S]
