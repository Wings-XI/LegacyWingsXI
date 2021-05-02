-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_JEUNO] =
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
        CONQUEST_BASE           = 7055, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7214, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7215, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7216, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7217, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7219, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7230, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    npc =
    {
        QM =
        {
            [17547509] =
            {
                param = {3356, 3419, 3420, 3421, 3422, 3423},
                trade =
                {
                    {item = 3356,                           mob = 17547265}, -- Goblin Golem
                    {item = {3419, 3420, 3421, 3422, 3423}, mob = 17547499}, -- Arch Goblin Golem
                }
            },
            [17547510] = {trade = {{item = 3392, mob = 17547493}}}, -- Quicktrix Hexhands
            [17547511] = {trade = {{item = 3393, mob = 17547494}}}, -- Feralox Honeylips
            [17547512] = {trade = {{item = 3394, mob = 17547496}}}, -- Scourquix Scaleskin
            [17547513] = {trade = {{item = 3395, mob = 17547498}}}, -- Wilywox Tenderpalm
        },
    },
}

return zones[tpz.zone.DYNAMIS_JEUNO]
