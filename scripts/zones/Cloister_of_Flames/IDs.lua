-----------------------------------
-- Area: Cloister_of_Flames
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CLOISTER_OF_FLAMES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6388, -- Obtained: <item>.
        GIL_OBTAINED                     = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED    = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                    = 7049, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7210, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7234, -- It is a giant crystal.
        ORB_MESSAGE_OFFSET               = 7523, -- There is a crack in the <item>. It no longer contains a monster.
        IFRIT_UNLOCKED                   = 7568, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ATTACH_SEAL                      = 7712, -- {player} attaches <item> to the protocrystal.
        POWER_STYMIES                    = 7713, -- An unseen power stymies your efforts to attach <item> to the protocrystal.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CLOISTER_OF_FLAMES]
