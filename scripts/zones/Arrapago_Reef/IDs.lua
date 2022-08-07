-----------------------------------
-- Area: Arrapago_Reef
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ARRAPAGO_REEF] =
{
    text =
    {
        NOTHING_HAPPENS               = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6402, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7049, -- You can't fish here.
        CONQUEST_BASE                 = 7149, -- Tallying conquest results...
        MOVE_CLOSER                   = 7309, -- You must move closer.
        IMPERIAL_CONTROL              = 7310, -- This gate guards an area under Imperial control.
        STAGING_POINT_ILRUSI          = 7315, -- Ilrusi Atoll Staging Point.
        CANNOT_LEAVE                  = 7320, -- You cannot leave this area while in the possession of <assault>
        RESPONSE                      = 7329, -- There is no response...
        DOOR_IS_LOCKED                = 7458, -- The door is locked.  You might be able to open it with <item>.
        DOOR_IS_LOCKED2               = 7459, -- The door is locked.  You might be able to open it with <item> or <item>.
        KEY_BREAKS                    = 7460, -- The <item> breaks!
        YOU_UNLOCK_DOOR               = 7463, -- You unlock the door from the inside.
        LOCK_SUCCESS                  = 7464, -- <name> successfully opened the lock with the <item>!
        LOCK_FAIL                     = 7465, -- <name> failed to open the lock with the <item>...
        YOU_NO_REQS                   = 7895, -- You do not meet the requirements to enter the battlefield with your party members. Access is denied.
        CANNOT_ENTER                  = 8446, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 8447, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 8450, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        PARTY_MIN_REQS                = 8453, -- Your party does not meet the minimum required number of ≺Numeric Parameter 0≻ members. Unable to enter area.
        MEMBER_TOO_FAR                = 8455, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEDUSA_ENGAGE                 = 8557, -- Foolish two-legs... Have you forgotten the terrible power of the gorgons you created? It is time you were reminded...
        MEDUSA_DEATH                  = 8558, -- No... I cannot leave my sisters...
        GLITTERING_FRAGMENTS          = 8906, -- Minute glittering fragments are scattered all over...
        SLIMY_TOUCH                   = 8907, -- The ground here is slimy to the touch...
        BLOOD_STAINS                  = 8907, -- The ground is smeared with bloodstains...
        DRAWS_NEAR                    = 8909, -- Something draws near!
        ZAREEHKL                      = 8912, -- 
        COMMON_SENSE_SURVIVAL         = 9781, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLOODY_BONES_PH       =
        {
            [16998653] = 16998655, -- 136.234 -6.831 468.779
        },
        MEDUSA                = 16998862,
        LIL_APKALLU           = 16998871,
        VELIONIS              = 16998872,
        ZAREEHKL_THE_JUBILANT = 16998873,
        NUHN                  = 16998874,
        EURYALE               = 16998696,
        LAMIE_NO7             = 16998520,
        LAMIE_NO8             = 16998481,
        LAMIE_NO9             = 16998742,
        MERROW_NO5            = 16998560,
    },
    npc =
    {
    },
}

return zones[tpz.zone.ARRAPAGO_REEF]
