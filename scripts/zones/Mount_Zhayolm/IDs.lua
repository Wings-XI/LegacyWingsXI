-----------------------------------
-- Area: Mount_Zhayolm
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MOUNT_ZHAYOLM] =
{
    text =
    {
        NOTHING_HAPPENS         =  119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        MOVE_CLOSER             = 7309, -- You must move closer.
        IMPERIAL_CONTROL        = 7310, -- This gate guards an area under Imperial control.
        STAGING_POINT_HALVUNG   = 7313, -- Halvung Staging Point.
        CANNOT_LEAVE            = 7320, -- You cannot leave this area while in the possession of <assault>
        RESPONSE                = 7329, -- There is no response...
		ORDINARY				= 7365, -- There is nothing out of the ordinary here.
		GATES_OF_HALVUNG		= 7366, -- There is a large keyhole here.
		CAST_METAL_PLATE		= 7367, -- Obtained key item: <key item>. You think it may fit the large keyhole.
		OPEN_GATES				= 7368, -- You insert the <key item> into the keyhole.≺Prompt≻
        MINING_IS_POSSIBLE_HERE = 7418, -- Mining is possible here if you have <item>.	
        CANNOT_ENTER            = 7477, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL               = 7478, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS          = 7482, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        PARTY_MIN_REQS          = 7485,	-- Your party does not meet the minimum required number of ≺Numeric Parameter 0≻ members. Unable to enter area.
        MEMBER_TOO_FAR          = 7486, -- One or more party members are too far away from the entrance. Unable to enter area.
        SHED_LEAVES             = 7548, -- The ground is strewn with shed leaves...
        DETACHED_PART           = 7533, -- There is a detached part here...
        SICKLY_SWEET            = 7563, -- A sickly sweet fragrance pervades the air...
        DRAWS_NEAR              = 7575, -- Something draws near!
        HOMEPOINT_SET           = 8724, -- Home point set!
    },
    mob =
    {
        ENERGETIC_ERUCA_PH    =
        {
            [17027146] = 17027466, -- 175.315 -14.444 -173.589
            [17027145] = 17027466, -- 181.601 -14.120 -166.218
        },
        IGNAMOTH_PH =
        {
            [17027421] = 17027423, -- -567.6 -15.35 252.201
            [17027422] = 17027423, -- -544.3 -14.8 262.992
        },
        EVOLVING_WAMOURA_PRINCES =
        {
            17027197, 
            17027200,
            17027341,
            17027346,
            17027417, 
            17027419,
            17027425,
            17027428,
        },
        CERBERUS              = 17027458,
        BRASS_BORER           = 17027471,
        CLARET                = 17027472,
        ANANTABOGA            = 17027473,
        KHROMASOUL_BHURBORLOR = 17027474,
        SARAMEYA              = 17027485,
    },
    npc =
    {
        MINING =
        {
            17027559,
            17027560,
            17027561,
            17027562,
            17027563,
            17027564,
        },
    },
}

return zones[tpz.zone.MOUNT_ZHAYOLM]
