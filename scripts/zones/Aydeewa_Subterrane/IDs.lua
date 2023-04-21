-----------------------------------
-- Area: Aydeewa_Subterrane
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.AYDEEWA_SUBTERRANE] =
{
    text =
    {
        NOTHING_HAPPENS         = 119, -- Nothing happens...
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
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        MINING_IS_POSSIBLE_HERE = 7320, -- Mining is possible here if you have <item>.
        PW_WHO_DARES            = 7956, -- Pandemonium Warden: Who dares disturb these gates...
        PW_END_OF_NOTHING       = 7957, -- Pandemonium Warden: This is the end...of nothing...
        BLOOD_STAINS            = 8029, -- The ground is smeared with bloodstains...
        DRAWS_NEAR              = 8030, -- Something draws near!
        COMMON_SENSE_SURVIVAL   = 8902, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLUESTREAK_GYUGYUROON_PH =
        {
            [17055941] = 17056156, -- -221.7 13.762 -346.83
            [17055942] = 17056156, -- -219 14.003 -364.83
        },
        NOSFERATU          = 17056157,
        PANDEMONIUM_WARDEN = 17056168,
        CHIGRE             = 17056186,
    },
    npc =
    {
    },
}

return zones[tpz.zone.AYDEEWA_SUBTERRANE]
