-----------------------------------
-- Area: Southern_San_dOria_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SOUTHERN_SAN_DORIA_S] =
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
        CONQUEST_BASE           = 7126, -- Tallying conquest results...
        MOG_LOCKER_OFFSET       = 7360, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        REGIME_CANCELED         = 7622, -- Current training regime canceled.
        HUNT_ACCEPTED           = 7640, -- Hunt accepted!
        USE_SCYLDS              = 7641, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 7652, -- You record your hunt.
        OBTAIN_SCYLDS           = 7654, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 7658, -- Hunt canceled.
        WYATT_DIALOG            = 11079, -- Ahhh, sorry, sorry. The name's Wyatt, an' I be an armor merchant from Jeuno. Ended up 'ere in San d'Oria some way or another, though.
        HOMEPOINT_SET           = 11109, -- Home point set!
        ITEM_DELIVERY_DIALOG    = 11210, -- If'n ye have goods tae deliver, then Nembet be yer man!
        ALLIED_SIGIL            = 12911, -- You have received the Allied Sigil!
        RETRIEVE_DIALOG_ID      = 15574, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 15648, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        CAMPAIGN_RECHARGE       = 12940, -- You do not possess the ≺Numeric Parameter 1≻ ≺Singular/Plural Choice (Parameter 1)≻[Allied Note/Allied Notes] required to fully recharge the ≺Possible Special Code: 01≻≺Possible Special Code: 05≻#≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻.≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.SOUTHERN_SAN_DORIA_S]
