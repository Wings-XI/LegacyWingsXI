-----------------------------------
-- Area: Alzadaal_Undersea_Ruins
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ALZADAAL_UNDERSEA_RUINS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7049, -- Tallying conquest results...
        MOVE_CLOSER                   = 7209, -- You must move closer.
        IMPERIAL_CONTROL              = 7210, -- This gate guards an area under Imperial control.
        STAGING_POINT_NYZUL           = 7216, -- Nyzul Isle Staging Point.
        CANNOT_LEAVE                  = 7220, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7229, -- There is no response...
        DEVICE_MALFUNCTIONING         = 7245, -- The device appears to be malfunctioning...
        NOTHING_OUT_OF_ORDINARY       = 7425, -- There is nothing out of the ordinary here.
        COMMENCING_TRANSPORT          = 7438, -- Commencing transport to Nyzul Isle
        CANNOT_ENTER                  = 7441, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 7442, -- This area is fully occupied. You were unable to enter.
        ORDER_GIVEN_TO_INVADE         = 7445, -- The order has been given to invade <blank> Param 1 = 5 = Nyzul Isle.
        MEMBER_NO_REQS                = 7446, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        PARTY_NO_REQS                 = 7447, -- Your party does not meet the requirements for this Assualt mission.
        PARTY_MIN_REQS                = 7449,	-- Your party does not meet the minimum required number of ≺Numeric Parameter 0≻ members. Unable to enter area.        
        MEMBER_TOO_FAR                = 7450, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEMBER_IMBUED_ITEM            = 7451, -- One or more party members are carrying imbued items. Unable to enter area.
        IMBUED_ITEM                   = 7452, -- You are carrying imbued items. Unable to enter area.
        MYTHIC_REQUIRED               = 7454, -- You do not have the appropriate mythic weapon equipped. Unable to enter area.
        HEADY_FRAGRANCE               = 7728, -- The heady fragrance of wine pervades the air...
        SLIMY_TOUCH                   = 7747, -- The ground here is slimy to the touch...
        DRAWS_NEAR                    = 7758, -- Something draws near!
        WULGARU                       = 7760, -- Quite the accomplishment.. Never would I have expected you to surpass Zahak.
    },
    mob =
    {
        NEPIONIC_SOULFLAYER     = 17072129,
        COOKIEDUSTER_LIPIROON_PH =
        {
            [17072142] = 17072150,
            [17072144] = 17072150,
        },
        OB                      = 17072171,
        CHEESE_HOARDER_GIGIROON = 17072172,
        ARMED_GEARS             = 17072178,
        WULGARU                 = 17072179,
        OUPIRE                  = 17072170,
        BOOMPADU                = 17072133,
    },
    npc =
    {
        RUNIC_PORTAL_NORTH      = 17072236,
        RUNIC_PORTAL_SOUTH      = 17072237,
        NEPIONIC_QM             = 17072271,
    },
}

return zones[tpz.zone.ALZADAAL_UNDERSEA_RUINS]
