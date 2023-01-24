-----------------------------------
-- Area: Halvung
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.HALVUNG] =
{
    text =
    {
        NOTHING_HAPPENS         = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7049, -- Tallying conquest results...
        WIDE_TRENCH             = 7900, -- There is a wide trench around the gate here. There are three keyholes of differing sizes inside the trench.
        KEY_BREAKS              = 7901, -- The <item> breaks!
        MINING_IS_POSSIBLE_HERE = 7924, -- Mining is possible here if you have <item>.
        BLUE_FLAMES             = 7963, -- You can see blue flames flickering from a hole in the ground here...
        COMMON_SENSE_SURVIVAL   = 8102, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        REACTON                 = 8027, -- Shredded scraps of paper are scattered all over...
        DEXTROSE                = 8028, -- The ground is strewn with shed leaves...
        DULL_PIECE              = 8037, -- A dull piece of metal lies on the ground. It appears to be a bracelet of sorts, but the layers of grime covering its surface render it wholly unwearable.
        LIFT_LEVER              = 8040, -- You lift the lever with all your might!
    },
    mob =
    {
        BIG_BOMB               = 17031401,
        GURFURLUR_THE_MENACING = 17031592,
        DEXTROSE               = 17031598,
        REACTON                = 17031599,
        ACHAMOTH               = 17031600,
        DORGERWOR_THE_ASTUTE   = 17031482,
    },
    npc =
    {
        MINING =
        {
            17031715,
            17031716,
            17031717,
            17031718,
            17031719,
            17031720,
        },
    },
}

return zones[tpz.zone.HALVUNG]
