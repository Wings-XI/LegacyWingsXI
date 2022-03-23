-----------------------------------
-- Area: Talacca_Cove
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.TALACCA_COVE] =
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
        FISHING_MESSAGE_OFFSET        = 7049, -- You can't fish here.
        CONQUEST_BASE                 = 7149, -- Tallying conquest results...
        ORB_MESSAGE_OFFSET            = 7623, -- There is a crack in the <item>. It no longer contains a monster.
        YOU_CAN_NOW_BECOME_A_CORSAIR  = 7781, -- You can now become a corsair!
        VALKENG_MELEE_CHANGE_FRAME    = 7852, -- Confirming status...Damage from melee attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_RANGED_CHANGE_FRAME   = 7853, -- Confirming status...Damage from ranged attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_MAGIC_CHANGE_FRAME    = 7854, -- Confirming status...Damage from magic attacks...≺Numeric Parameter 0≻%.Changing frame...
        VALKENG_MELEE_KEEP_FRAME      = 7855, -- Confirming status...Damage from melee attacks...≺Numeric Parameter 0≻%.Executing maneuver...
        VALKENG_RANGED_KEEP_FRAME     = 7856, -- Confirming status...Damage from ranged attacks...≺Numeric Parameter 0≻%.Executing maneuver...
        VALKENG_MAGIC_KEEP_FRAME      = 7857, -- Confirming status...Damage from magic attacks...≺Numeric Parameter 0≻%.Executing maneuver...
    },
    mob =
    {
        GESSHO = 17010725,
    },
    npc =
    {
    },
}

return zones[tpz.zone.TALACCA_COVE]
