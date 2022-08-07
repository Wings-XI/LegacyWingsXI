-----------------------------------
-- Area: Bhaflau_Thickets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BHAFLAU_THICKETS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7049, -- You can't fish here.
        MOVE_CLOSER                   = 7309, -- You must move closer.
        IMPERIAL_CONTROL              = 7310, -- This gate guards an area under Imperial control.
        STAGING_POINT_MAMOOL          = 7312, -- Mamool Ja Staging Point.
        DIG_THROW_AWAY                = 7062, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7064, -- You dig and you dig, but find nothing.
        CONQUEST_BASE                 = 7149, -- Tallying conquest results...
        CANNOT_LEAVE                  = 7320, -- You cannot leave this area while in the possession of <assault>
        RESPONSE                      = 7329, -- There is no response...
        HARVESTING_IS_POSSIBLE_HERE   = 7561, -- Harvesting is possible here if you have <item>.
        CANNOT_ENTER                  = 7584, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7585, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 7589, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        PARTY_MIN_REQS                = 7592, -- Your party does not meet the minimum required number of ≺Numeric Parameter 0≻ members. Unable to enter area.
        MEMBER_TOO_FAR                = 7593, -- One or more party members are too far away from the entrance. Unable to enter area.
        HOMEPOINT_SET                 = 7692, -- Home point set!
        LIVIDROOT_AMOOSHAH            = 7661, -- A putrid odor threatens to overwhelm you.
    },
    mob =
    {
        MAHISHASURA_PH     =
        {
            [16990296] = 16990306, -- 215.000 -18.000 372.000
        },
        EMERGENT_ELM_PH    =
        {
            [16990374] = 16990376, -- 86.000 -35.000 621.000
        },
        NIS_PUK_PH         =
        {
            [16990383] = 16990403, -- -135 -18 -648
            [16990384] = 16990403, -- -104 -18 -636
            [16990385] = 16990403, -- -123 -16 -638
            [16990391] = 16990403, -- -106 -16 -613
            [16990392] = 16990403, -- -109 -15 -600
            [16990393] = 16990403, -- -128 -15 -602
            [16990394] = 16990403, -- -132 -16 -612
            [16990398] = 16990403, -- -119 -15 -651
        },
        HARVESTMAN         = 16990252,
        LIVIDROOT_AMOOSHAH = 16990473,
        DEA                = 16990474,
        CHIGOE_POOLS =
        {
            {
                16990289,
                16990290,
                16990291,
                16990292,
                16990293,
            }
        },
        GRAND_MARID1_PH =
        {
            [16990296] = 16990294, -- 215.000 -18.000 372.000
            [16990297] = 16990294, -- 209.000 -19.000 341.000
            [16990298] = 16990294, -- 153.000 -15.000 355.000
            [16990299] = 16990294, -- 149.000 -17.000 310.000
            [16990304] = 16990294, -- 160.000 -15.000 328.000
            [16990305] = 16990294, -- 163.000 -16.000 312.000
        },
        GRAND_MARID2_PH =
        {
            [16990296] = 16990295, -- 215.000 -18.000 372.000
            [16990297] = 16990295, -- 209.000 -19.000 341.000
            [16990298] = 16990295, -- 153.000 -15.000 355.000
            [16990299] = 16990295, -- 149.000 -17.000 310.000
            [16990304] = 16990295, -- 160.000 -15.000 328.000
            [16990305] = 16990295, -- 163.000 -16.000 312.000
        }
    },
    npc =
    {
        HARVESTING =
        {
            16990607,
            16990608,
            16990609,
            16990610,
            16990611,
            16990612,
        },
    },
}

return zones[tpz.zone.BHAFLAU_THICKETS]
