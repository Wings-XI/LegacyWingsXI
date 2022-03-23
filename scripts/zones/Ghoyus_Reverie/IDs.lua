-----------------------------------
-- Area: Ghoyus_Reverie
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GHOYUS_REVERIE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_TO_COMPLETE              = 7049, -- You have ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes] (Earth time) to complete your objectives.
        TIME_REMAINING_MINUTES        = 7050, -- Time remaining: ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7051, -- Time remaining: ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[second/seconds] (Earth time).
        PARTY_FALLEN                  = 7052, -- All party members have fallen in battle. Exiting in ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes].
        OPERATION_FAILED              = 7053, -- The operation has failed.≺Prompt≻
        CONQUEST_BASE                 = 7054, -- Tallying conquest results...
    },
    mob =
    {
        MANIFEST_PROBLEM_START = 17305647,
        MANIFEST_PROBLEM_END   = 17305661,
        LAA_YAKU_THE_AUSTERE   = 17305662,
    },
    npc =
    {
    },
}

return zones[tpz.zone.GHOYUS_REVERIE]
