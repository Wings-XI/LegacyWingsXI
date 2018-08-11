-----------------------------------
-- Area: GM_Home
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GM_HOME] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LS_CONCIERGE_LISTING_CANCEL = 9125, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_REGISTERED1    = 9177, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2    = 9178, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED = 9179, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.GM_HOME]
