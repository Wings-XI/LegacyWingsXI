-----------------------------------
-- Area: Eastern Adoulin (257)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.EASTERN_ADOULIN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6393, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_CAN_NOW_BECOME      = 7009, -- You can now become a <geomancer/rune fencer>!
        MOG_LOCKER_OFFSET       = 7569, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        CONQUEST_BASE           = 8105, -- Tallying conquest results...
        HOMEPOINT_SET           = 8285, -- Home point set!
        LS_CONCIERGE_LISTING_CANCEL = 13657, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_SAME_DAY       = 13661, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LS_CONCIERGE_REGISTERED1    = 13709, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2    = 13710, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED = 13711, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
        COMMON_SENSE_SURVIVAL       = 13845, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.EASTERN_ADOULIN]
