-----------------------------------
-- Area: Mine_Shaft_2716
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MINE_SHAFT_2716] =
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
        ORB_MESSAGE_OFFSET      = 7364, -- There is a crack in the <item>. It no longer contains a monster.
        CONQUEST_BASE           = 7421, -- Tallying conquest results...
        MOVAMUQ_COME_COME       = 7801, -- Bug Bug! Come come!
        MOVAMUQ_SMACK_SMACK     = 7802, -- Bug Bug! Smack smack!
        MOVAMUQ_GO_CRAZY        = 7803, -- Bug Bug! Go crazy crazy!
        MOVAMUQ_PIG_PIG         = 7804, -- You useless pig pig!
        MOVAMUQ_BUG_BUG         = 7805, -- Eh? Where's Bug Bug?
        CHEKOCHUK_COME          = 7809, -- Buuug! Oooveeer heeere nooow!
        CHEKOCHUK_SHOWTIME      = 7811, -- Buuug! Iiit's shooowtiiime!
        CHEKOCHUK_IDIOT         = 7812, -- Yooouuu iiidiiiooot!
        CHEKOCHUK_NO            = 7813, -- Buuug! Noooooooooo!
        TRIKOTRAK_PNCH_KCK      = 7817, -- Bg! Pnch! Kck!
        TRIKOTRAK_KILL_KILL     = 7818, -- Bg! Kill! Kill!
        TRIKOTRAK_MIGHTY        = 7819, -- Bg! Mighty! Mighty!
        TRIKOTRAK_N             = 7821, -- Bg? Nnnnnnnnnnn!
        SWIPOSTIK_SMASH         = 7825, -- Bug's! Smash's up's this's one's!
        SWIPOSTIK_BUG_BUSTER    = 7826, -- Use's super's Bug's Buster's!
        SWIPOSTIK_MIGHTY        = 7827, -- Bug's! Time's for's Mighty's Strike's!
        BUGBBY_UGH              = 7832, -- Ugh.
        BUGBBY_UGH_UGH          = 7833, -- Ugh ugh.
        BUGBBY_ARGH             = 7835, -- Arrrgh!
        BUGBBY_UG               = 7837, -- Ug ug ug.
        BUGBBY_PANT             = 7838, -- <Pant...pant...>
        BUGBBY_SIGH             = 7839, -- <Sigh>... Arg!
    },
    mob =
    {
    },
    npc =
    {
    },
    aCenturyOfHardship = {
        [1] = {
            MOBLIN_IDS = { 16830465, 16830466, 16830467, 16830468 }
        },
        [2] = {
            MOBLIN_IDS = { 16830470, 16830471, 16830472, 16830473 }
        },
        [3] = {
            MOBLIN_IDS = { 16830475, 16830476, 16830477, 16830478 }
        },
    },
}

return zones[tpz.zone.MINE_SHAFT_2716]
