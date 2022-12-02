-----------------------------------
-- Area: Grauberg_[S]
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/events/dark_ixion")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GRAUBERG_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET       = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET      = 7049, -- You can't fish here.
        CONQUEST_BASE               = 7226, -- Tallying conquest results...
        THERE_IS_NO_RESPONSE        = 7671, -- There is no response...
        CHOSEN_NOT_ENTER            = 7678, -- You have chosen not to enter ≺Multiple Choice (Parameter 0)≻[Everbloom Hollow/the Ruhotz Silvermines/Ghoyu's Reverie].
        CANNOT_ENTER                = 7680, -- You cannot enter at this time. Please wait a moment and try again.
        PARTY_REQUIREMENTS_FAILED   = 7686, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        HARVESTING_IS_POSSIBLE_HERE = 7687, -- Harvesting is possible here if you have <item>.
        COMMON_SENSE_SURVIVAL       = 9292, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DARK_IXION = darkixion.zoneinfo[tpz.zone.GRAUBERG_S].mobID,
        KOTAN_KOR_KAMUY_PH =
        {
            [17141958] = 17141962,
            [17141959] = 17141962,
            [17141960] = 17141962,
            [17141963] = 17141962,
            [17141964] = 17141962,
            [17141965] = 17141962,
            [17141966] = 17141962,
            [17141967] = 17141962,
        },
        SCITALIS_PH =
        {
            [17141977] = 17141979,
            [17141978] = 17141979,
            [17141981] = 17141979,
        },
        VASILICERATOPS_PH =
        {
            [17141882] = 17141885,
            [17141818] = 17141885,
        },    
        MIGRATORY_HIPPOGRYPH = 17142108,
        SARCOPSYLLA          = 17141872,  
    },
    npc =
    {
        HARVESTING =
        {
            17142545,
            17142546,
            17142547,
            17142548,
            17142549,
            17142550,
        },
        INDESCRIPT_MARKINGS = 17142581,
    },
}

return zones[tpz.zone.GRAUBERG_S]
