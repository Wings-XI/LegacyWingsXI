-----------------------------------
-- Area: Dynamis-Buburimu
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_BUBURIMU] =
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
        CONQUEST_BASE           = 7149, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7314, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7315, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7316, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7317, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7319, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7330, -- You feel an ominous presence, as if something might happen if you possessed <item>.
    },
    npc =
    {
        QM =
        {
            -- [16941676] =
            -- {
            --     param = {3457, 3474, 3475, 3476, 3477, 3478},
            --     trade =
            --     {
            --         {item = 3457,                           mob = 16941057}, -- Apocalyptic Beast
            --         {item = {3474, 3475, 3476, 3477, 3478}, mob = 16941368}, -- Arch Apocalyptic Beast
            --     }
            -- },
            -- [16941677] = {trade = {{item = 3463, mob = 16941552}}}, -- Lost Stihi
            -- [16941678] = {trade = {{item = 3464, mob = 16941520}}}, -- Lost Barong
            -- [16941679] = {trade = {{item = 3465, mob = 16941576}}}, -- Lost Alklha
            -- [16941680] = {trade = {{item = 3466, mob = 16941666}}}, -- Lost Aitvaras
        },
    },
    mob =
    {
        Gosspix_Blabberlips = 16941097,
        Shamblix_Rottenheart = 16941082,
        Woodnix_Shrillwhistle = 16941066,
        Elvaansticker_Bxafraff = 16941116,
        Flamecaller_Zoeqdoq = 16941115,
        Hamfist_Gukhbuk = 16941133,
        Lyncean_Juwgneg = 16941134,
        GiBhe_Fleshfeaster = 16941152,
        QuPho_Bloodspiller = 16941151,
        TeZha_Ironclad = 16941170,
        VaRhu_Bodysnatcher = 16941169,
        Baa_Dava_The_Bibliopage = 16941206,
        Doo_Peku_The_Fleetfoot = 16941205,
        Koo_Rahi_The_Levinblade = 16941189,
        Ree_Nata_The_Melomanic = 16941188,
        Aitvaras = 16941367,
        Alklha = 16941366,
        Barong = 16941365,
        Basilic = 16941667,
        Jurik = 16941668,
        Koschei = 16941672,
        Stihi = 16941364,
        Stollenwurm = 16941671,
        Tarasca = 16941669,
        Vishap = 16941673,
        Dragons_Wyverns =
        {
            16941701,
            16941702,
            16941703,
            16941704,
            16941705,
        },
        Apocalyptic_Beast = 16941057,
    },
}

return zones[tpz.zone.DYNAMIS_BUBURIMU]
