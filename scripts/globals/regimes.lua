------------------------------------
-- Fields and Grounds of Valor
--
-- https://www.bg-wiki.com/bg/Fields_of_Valor
-- https://www.bg-wiki.com/bg/Grounds_of_Valor
-- http://ffxiclopedia.wikia.com/wiki/Category:Fields_of_Valor
-- http://ffxiclopedia.wikia.com/wiki/Grounds_of_Valor
-- http://ffxiclopedia.wikia.com/wiki/Field_Manual
-- http://ffxiclopedia.wikia.com/wiki/Grounds_Tome
------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/keyitems")
------------------------------------

tpz = tpz or {}
tpz.regime = tpz.regime or {}

tpz.regime.type =
{
    FIELDS  = 1,
    GROUNDS = 2,
}

-------------------------------------------------
-- FoV/GoV training regime information
-- {n1, n2, n3, n4, low, high, reward, regimeId},
-- n1, n2, n3, n4 = number of monsters needed
-- low, high are the level range
-- reward is the gil/tabs you get for completing
-------------------------------------------------

local regimeInfo = {

    -------------------------------------------------
    -- Fields of Valor information
    -------------------------------------------------

    [tpz.regime.type.FIELDS] =
    {
        sharedOptions =
        {
            [18] = {page = 1},
            [34] = {page = 2},
            [50] = {page = 3},
            [66] = {page = 4},
            [82] = {page = 5},
        },
        updateOptions =
        {
            [ 1] = {review = true},
            [ 6] = {details = true},
        },
        finishOptions =
        {
            [  3] = {act = "CANCEL_REGIME",   cost =  0, discounted =  0},
            [ 21] = {act = "REPATRIATION",    cost = 50, discounted = 10},
            [ 37] = {act = "RERAISE",         cost = 10, discounted =  5},
            [ 53] = {act = "REGEN",           cost = 20, discounted = 10},
            [ 69] = {act = "REFRESH",         cost = 20, discounted = 10},
            [ 85] = {act = "PROTECT",         cost = 15, discounted =  5},
            [101] = {act = "SHELL",           cost = 15, discounted =  5},
            [117] = {act = "DRIED_MEAT",      cost = 50, discounted = 25, food = true},
            [133] = {act = "SALTED_FISH",     cost = 50, discounted = 25, food = true},
            [149] = {act = "HARD_COOKIE",     cost = 50, discounted = 25, food = true},
            [165] = {act = "INSTANT_NOODLES", cost = 50, discounted = 25, food = true},

            -- TODO: implement elite training
            -- ELITE_INTRO     =  36,
            -- ELITE_CHAP1     =  52,
            -- ELITE_CHAP2     =  68,
            -- ELITE_CHAP3     =  84,
            -- ELITE_CHAP4     = 100,
            -- ELITE_CHAP5     = 116,
            -- ELITE_CHAP6     = 132,
            -- ELITE_CHAP7     = 148,

            -- TODO: implement Trust: Sakura and Trust: Koru-Moru (Alter Ego Extravaganza)
        },
        zone =
        {
            [tpz.zone.WEST_RONFAURE] =
            {
                event = 61,
                page =
                {
                    { 6, 0, 0, 0, 1, 6, 270,  1},
                    { 6, 0, 0, 0, 2, 6, 285,  2},
                    { 5, 1, 0, 0, 4, 7, 300,  3},
                    { 4, 2, 0, 0, 4, 8, 315,  4},
                    { 6, 1, 0, 0, 4, 8, 330, 56},
                },
            },
            [tpz.zone.EAST_RONFAURE] =
            {
                event = 61,
                page =
                {
                    { 6, 0, 0, 0, 1, 5, 270, 64},
                    { 6, 0, 0, 0, 2, 5, 285, 65},
                    { 7, 0, 0, 0, 2, 6, 300, 66},
                    { 4, 2, 0, 0, 3, 6, 315, 67},
                    { 4, 2, 0, 0, 4, 8, 330, 68},
                },
            },
            [tpz.zone.LA_THEINE_PLATEAU] =
            {
                event = 61,
                page =
                {
                    { 3, 3, 0, 0, 8, 12, 330,  5},
                    { 3, 5, 0, 0, 11, 13, 360, 69},
                    { 8, 0, 0, 0, 12, 13, 390,  6},
                    { 5, 3, 0, 0, 11, 14, 420, 70},
                    { 5, 3, 0, 0, 10, 15, 450, 71},
                },
            },
            [tpz.zone.VALKURM_DUNES] =
            {
                event = 47,
                page =
                {
                    { 7, 1, 0, 0, 15, 19, 475,  7},
                    { 6, 2, 0, 0, 15, 22, 500,  8},
                    { 5, 3, 0, 0, 18, 23, 525,  9},
                    { 4, 4, 0, 0, 20, 23, 550, 10},
                    { 4, 2, 0, 0, 22, 25, 575, 57},
                },
            },
            [tpz.zone.JUGNER_FOREST] =
            {
                event = 32,
                page =
                {
                    { 8, 2, 0, 0, 15, 18, 480, 58},
                    { 9, 0, 0, 0, 21, 22, 540, 11},
                    { 8, 1, 0, 0, 21, 23, 570, 12},
                    { 7, 2, 0, 0, 22, 25, 600, 13},
                    { 6, 3, 0, 0, 24, 25, 630, 14},
                },
            },
            [tpz.zone.BATALLIA_DOWNS] =
            {
                event = 61,
                page =
                {
                    { 5, 2, 0, 0, 23, 26, 630, 72},
                    { 5, 2, 0, 0, 23, 28, 650, 73},
                    { 4, 3, 0, 0, 25, 28, 670, 15},
                    { 5, 2, 2, 0, 26, 32, 700, 74},
                    { 9, 0, 0, 0, 31, 32, 730, 75},
                },
            },
            [tpz.zone.NORTH_GUSTABERG] =
            {
                event = 266,
                page =
                {
                    { 6, 0, 0, 0, 1, 6, 270, 16},
                    { 6, 0, 0, 0, 3, 6, 285, 17},
                    { 5, 1, 0, 0, 3, 7, 300, 18},
                    { 4, 2, 0, 0, 3, 8, 315, 19},
                    { 3, 4, 0, 0, 3, 8, 330, 59},
                },
            },
            [tpz.zone.SOUTH_GUSTABERG] =
            {
                event = 61,
                page =
                {
                    { 6, 0, 0, 0, 1, 6, 270, 76},
                    { 7, 0, 0, 0, 2, 5, 285, 77},
                    { 3, 3, 0, 0, 3, 6, 300, 78},
                    { 7, 0, 0, 0, 3, 6, 315, 79},
                    { 5, 2, 0, 0, 4, 8, 330, 80},
                },
            },
            [tpz.zone.KONSCHTAT_HIGHLANDS] =
            {
                event = 61,
                page =
                {
                    { 4, 2, 0, 0, 8, 11, 340, 81},
                    { 4, 2, 0, 0, 9, 12, 360, 82},
                    { 3, 3, 0, 0, 10, 12, 330, 20},
                    { 6, 0, 0, 0, 9, 15, 380, 83},
                    { 2, 2, 2, 0, 12, 14, 400, 84},
                },
            },
            [tpz.zone.PASHHOW_MARSHLANDS] =
            {
                event = 28,
                page =
                {
                    { 9, 0, 0, 0, 20, 21, 540, 21},
                    { 8, 1, 0, 0, 20, 22, 570, 22},
                    { 7, 2, 0, 0, 21, 23, 600, 23},
                    { 6, 3, 0, 0, 22, 25, 630, 24},
                    { 5, 4, 1, 0, 22, 25, 660, 60},
                },
            },
            [tpz.zone.ROLANBERRY_FIELDS] =
            {
                event = 61,
                page =
                {
                    { 5, 2, 0, 0, 25, 26, 670, 85},
                    { 4, 3, 0, 0, 25, 28, 690, 25},
                    { 6, 2, 0, 0, 26, 32, 710, 86},
                    { 6, 2, 0, 0, 27, 33, 740, 87},
                    { 5, 0, 0, 0, 36, 37, 800, 88},
                },
            },
            [tpz.zone.BEAUCEDINE_GLACIER] =
            {
                event = 218,
                page =
                {
                    { 9, 2, 0, 0, 34, 38, 810, 46},
                    { 8, 3, 0, 0, 34, 39, 855, 47},
                    { 7, 4, 0, 0, 37, 42, 900, 48},
                    { 6, 4, 1, 0, 37, 43, 945, 49},
                    { 5, 4, 2, 0, 40, 43, 990, 50},
                },
            },
            [tpz.zone.XARCABARD] =
            {
                event = 48,
                page =
                {
                    { 9, 3, 0, 0, 42, 46, 900, 51},
                    { 8, 4, 0, 0, 42, 45, 950, 52},
                    { 7, 4, 1, 0, 42, 48, 1000, 53},
                    { 6, 4, 2, 0, 42, 48, 1050, 54},
                    { 5, 4, 3, 0, 45, 52, 1100, 55},
                },
            },
            [tpz.zone.CAPE_TERIGGAN] =
            {
                event = 61,
                page =
                {
                    { 4, 4, 0, 0, 62, 66, 1300, 104},
                    { 4, 5, 0, 0, 64, 68, 1320, 105},
                    { 4, 5, 0, 0, 64, 69, 1340, 106},
                    { 7, 3, 0, 0, 66, 74, 1390, 107},
                    { 4, 5, 0, 0, 71, 79, 1450, 108},
                },
            },
            [tpz.zone.EASTERN_ALTEPA_DESERT] =
            {
                event = 61,
                page =
                {
                    {10, 0, 0, 0, 30, 34, 810, 109},
                    { 3, 1, 7, 0, 35, 40, 830, 110},
                    { 3, 1, 7, 0, 35, 44, 870, 111},
                    { 5, 2, 2, 1, 44, 49, 950, 112},
                    { 3, 3, 2, 1, 45, 49, 970, 113},
                },
            },
            [tpz.zone.WEST_SARUTABARUTA] =
            {
                event = 52,
                page =
                {
                    { 6, 0, 0, 0, 1, 5, 270, 26},
                    { 6, 0, 0, 0, 2, 5, 285, 27},
                    { 5, 1, 0, 0, 3, 8, 300, 28},
                    { 4, 2, 0, 0, 4, 8, 315, 29},
                    { 4, 2, 0, 0, 4, 8, 330, 61},
                },
            },
            [tpz.zone.EAST_SARUTABARUTA] =
            {
                event = 61,
                page =
                {
                    { 6, 0, 0, 0, 1, 6, 270, 89},
                    { 6, 0, 0, 0, 1, 8, 285, 90},
                    { 6, 0, 0, 0, 2, 6, 300, 91},
                    { 4, 2, 0, 0, 3, 6, 315, 92},
                    { 4, 3, 0, 0, 3, 6, 330, 93},
                },
            },
            [tpz.zone.TAHRONGI_CANYON] =
            {
                event = 61,
                page =
                {
                    { 3, 3, 0, 0, 7, 12, 330, 30},
                    { 8, 0, 0, 0, 11, 13, 450, 31},
                    { 4, 2, 0, 0, 7, 11, 315, 94},
                    { 3, 3, 0, 0, 8, 12, 370, 95},
                    { 3, 4, 0, 0, 12, 16, 475, 96},
                },
            },
            [tpz.zone.BUBURIMU_PENINSULA] =
            {
                event = 51,
                page =
                {
                    { 7, 1, 0, 0, 15, 19, 475, 32},
                    { 6, 2, 0, 0, 15, 23, 500, 33},
                    { 5, 3, 0, 0, 20, 24, 525, 34},
                    { 4, 4, 0, 0, 21, 24, 550, 35},
                    { 4, 3, 0, 0, 22, 27, 575, 62},
                },
            },
            [tpz.zone.MERIPHATAUD_MOUNTAINS] =
            {
                event = 46,
                page =
                {
                    { 9, 0, 0, 0, 20, 21, 540, 36},
                    { 8, 1, 0, 0, 20, 22, 570, 37},
                    { 7, 2, 0, 0, 21, 23, 600, 38},
                    { 6, 3, 0, 0, 22, 25, 630, 39},
                    { 3, 5, 0, 0, 25, 27, 660, 63},
                },
            },
            [tpz.zone.SAUROMUGUE_CHAMPAIGN] =
            {
                event = 61,
                page =
                {
                    { 4, 3, 0, 0, 25, 28, 690, 40},
                    { 4, 4, 0, 0, 26, 32, 710, 97},
                    { 2, 5, 0, 0, 26, 34, 710, 98},
                    { 3, 5, 0, 0, 27, 33, 730, 99},
                    { 5, 3, 0, 0, 36, 38, 770, 100},
                },
            },
            [tpz.zone.THE_SANCTUARY_OF_ZITAH] =
            {
                event = 61,
                page =
                {
                    { 7, 2, 0, 0, 40, 44, 900, 114},
                    { 7, 3, 0, 0, 41, 46, 940, 115},
                    { 7, 3, 0, 0, 41, 46, 980, 116},
                    { 7, 3, 0, 0, 42, 47, 1020, 117},
                    { 3, 5, 0, 0, 44, 50, 1100, 118},
                },
            },
            [tpz.zone.ROMAEVE] =
            {
                event = 61,
                page =
                {
                    { 3, 3, 0, 0, 60, 65, 1300, 119},
                    { 7, 0, 0, 0, 64, 69, 1330, 120},
                    { 7, 0, 0, 0, 65, 69, 1360, 121},
                    { 6, 1, 0, 0, 78, 82, 1540, 122},
                    { 6, 1, 0, 0, 79, 82, 1570, 123},
                },
            },
            [tpz.zone.YUHTUNGA_JUNGLE] =
            {
                event = 61,
                page =
                {
                    { 4, 5, 0, 0, 30, 35, 820, 124},
                    { 7, 4, 0, 0, 32, 37, 840, 125},
                    {10, 0, 0, 0, 34, 36, 860, 126},
                    { 4, 6, 0, 0, 34, 38, 880, 127},
                    { 4, 6, 0, 0, 34, 41, 920, 128},
                },
            },
            [tpz.zone.YHOATOR_JUNGLE] =
            {
                event = 61,
                page =
                {
                    { 3, 6, 0, 0, 35, 39, 840, 129},
                    { 3, 6, 0, 0, 35, 40, 880, 130},
                    {10, 0, 0, 0, 40, 44, 920, 131},
                    { 7, 3, 0, 0, 40, 46, 940, 132},
                    {10, 0, 0, 0, 45, 49, 1000, 133},
                },
            },
            [tpz.zone.WESTERN_ALTEPA_DESERT] =
            {
                event = 61,
                page =
                {
                    { 7, 3, 0, 0, 40, 45, 920, 134},
                    { 5, 1, 4, 0, 44, 49, 980, 135},
                    {10, 1, 0, 0, 47, 53, 1020, 136},
                    { 2, 8, 0, 0, 51, 56, 1080, 137},
                    { 4, 6, 0, 0, 54, 58, 1140, 138},
                },
            },
            [tpz.zone.QUFIM_ISLAND] =
            {
                event = 33,
                page =
                {
                    { 9, 1, 0, 0, 26, 29, 630, 41},
                    { 8, 2, 0, 0, 26, 29, 665, 42},
                    { 7, 3, 0, 0, 28, 29, 700, 43},
                    { 6, 4, 0, 0, 28, 30, 735, 44},
                    { 5, 4, 1, 0, 28, 34, 770, 45},
                },
            },
            [tpz.zone.BEHEMOTHS_DOMINION] =
            {
                event = 61,
                page =
                {
                    { 3, 2, 0, 0, 41, 44, 350, 101},
                    { 3, 2, 0, 0, 41, 46, 400, 102},
                    { 3, 2, 0, 0, 43, 47, 450, 103},
                },
            },
            [tpz.zone.VALLEY_OF_SORROWS] =
            {
                event = 61,
                page =
                {
                    { 5, 2, 0, 0, 66, 72, 1220, 139},
                    { 5, 1, 0, 0, 66, 74, 1260, 140},
                    { 4, 1, 0, 0, 69, 74, 1300, 141},
                },
            },
            [tpz.zone.RUAUN_GARDENS] =
            {
                event = 73,
                page =
                {
                    { 8, 3, 0, 0, 72, 76, 1450, 142},
                    { 8, 3, 0, 0, 73, 78, 1500, 143},
                    {11, 0, 0, 0, 75, 78, 1550, 144},
                    { 2, 2, 2, 0, 78, 79, 1600, 145},
                    { 2, 2, 2, 0, 78, 79, 1600, 146},
                },
            },
        },
    },

    -------------------------------------------------
    -- Grounds of Valor information
    -------------------------------------------------

    [tpz.regime.type.GROUNDS] =
    {
        sharedOptions =
        {
            [ 18] = {page = 1},
            [ 34] = {page = 2},
            [ 50] = {page = 3},
            [ 66] = {page = 4},
            [ 82] = {page = 5},
            [ 98] = {page = 6},
            [114] = {page = 7},
            [130] = {page = 8},
            [146] = {page = 9},
            [162] = {page = 10},
        },
        updateOptions =
        {
            [  1] = {review = true},
            [  5] = {details = true},
            [  7] = {prowess = true, enabled = ENABLE_PROWESS == 1 and true or false},
        },
        finishOptions =
        {
            [  3] = {act = "CANCEL_REGIME",   cost =  0, discounted =  0},
            [ 20] = {act = "REPATRIATION",    cost = 50, discounted = 10},
            [ 36] = {act = "CIRCUMSPECTION",  cost =  5, discounted =  5, enabled = ENABLE_PROWESS == 1 and true or false},
            [ 52] = {act = "HOMING_INSTINCT", cost = 50, discounted = 25},
            [ 68] = {act = "RERAISE",         cost = 10, discounted =  5},
            [ 84] = {act = "RERAISE_II",      cost = 20, discounted = 10, enabled = ENABLE_PROWESS == 1 and true or false},
            [100] = {act = "RERAISE_III",     cost = 30, discounted = 15, enabled = ENABLE_PROWESS == 1 and true or false},
            [116] = {act = "REGEN",           cost = 20, discounted = 10},
            [132] = {act = "REFRESH",         cost = 20, discounted = 10},
            [148] = {act = "PROTECT",         cost = 15, discounted =  5},
            [164] = {act = "SHELL",           cost = 15, discounted =  5},
            [180] = {act = "HASTE",           cost = 20, discounted = 10, enabled = ENABLE_PROWESS == 1 and true or false},
            [196] = {act = "DRIED_MEAT",      cost = 50, discounted = 25, food = true},
            [212] = {act = "SALTED_FISH",     cost = 50, discounted = 25, food = true},
            [228] = {act = "HARD_COOKIE",     cost = 50, discounted = 25, food = true},
            [244] = {act = "INSTANT_NOODLES", cost = 50, discounted = 25, food = true},
            [260] = {act = "DRIED_AGARICUS",  cost = 50, discounted = 25, food = true},
            [276] = {act = "INSTANT_RICE",    cost = 50, discounted = 25, food = true},

            -- TODO: implement Trust: Sakura and Trust: Koru-Moru (Alter Ego Extravaganza)
            -- CIPHER_SAKURA   = 292,
        },
        zone =
        {
            [tpz.zone.THE_BOYAHDA_TREE] =
            {
                event = 17,
                page =
                {
                    { 3, 3, 0, 0, 60, 63, 1240, 719}, -- death caps/barkspiders
                    { 4, 3, 0, 0, 62, 66, 1300, 720}, -- mourioches/robber crab
                    { 4, 3, 0, 0, 62, 67, 1319, 721}, -- mourioches/moss eaters
                    { 4, 2, 0, 0, 72, 75, 1408, 722}, -- korrigans/elder goobbues
                    { 3, 4, 0, 0, 72, 76, 1427, 723}, -- skimmers/steelshells
                    { 4, 3, 0, 0, 72, 78, 1465, 724}, -- processionaires/darters
                    { 3, 3, 0, 0, 74, 78, 1465, 725}, -- boyahda saplins/bark tarantulas
                    -- { 2, 2, 2, 0, 102, 105, 2040, 726}, -- viseclaws/snaggletooth peapuks/mouring crawlers
                },
            },
            [tpz.zone.MIDDLE_DELKFUTTS_TOWER] =
            {
                event = 18,
                page =
                {
                    { 3, 4, 0, 0, 25, 34, 775, 782}, -- bats/goblins
                    { 3, 4, 0, 0, 25, 34, 775, 783}, -- bats/gigas
                    { 4, 4, 0, 0, 30, 34, 775, 784}, -- goblins/gigas
                },
            },
            [tpz.zone.UPPER_DELKFUTTS_TOWER] =
            {
                event = 20,
                page =
                {
                    { 6, 0, 0, 0, 34, 35, 798, 785}, -- gigas
                    { 2, 2, 2, 0, 62, 69, 1339, 786}, -- jotunn wallkeeper/gatekeeper
                    { 2, 2, 2, 0, 62, 69, 1339, 787}, -- jotunn hallkeeper/wildkeeper/bats
                    { 2, 2, 2, 0, 65, 69, 1339, 788}, -- jotunn gatekeeper/hallkeeper/arcana-type
                    { 2, 2, 2, 0, 65, 69, 1339, 789}, -- jotunn wildkeeper/wallkeeper/arcana-type
                },
            },
            [tpz.zone.TEMPLE_OF_UGGALEPIH] =
            {
                event = 83,
                page =
                {
                    { 3, 3, 0, 0, 51, 57, 1122, 790}, -- tonberries family/bees family
                    { 4, 2, 0, 0, 51, 57, 1122, 791}, -- tonberries/rumble crawlers
                    { 4, 2, 0, 0, 51, 57, 1122, 792}, -- tonberries/temple opo-opo
                    { 3, 3, 0, 0, 61, 63, 1240, 793}, -- tonberries/temple bees
                    { 3, 3, 0, 0, 61, 67, 1319, 794}, -- tonberries/hover tanks
                    { 3, 3, 0, 0, 61, 68, 1320, 795}, -- tonberries/iron maidens
                },
            },
            [tpz.zone.DEN_OF_RANCOR] =
            {
                event = 13,
                page =
                {
                    { 3, 3, 0, 0, 60, 64, 1260, 796}, -- dire bat/cave worm
                    { 6, 0, 0, 0, 60, 67, 1319, 797}, -- dire bat/mousses (mousses missing from mob spawns, adjusted to be 6 bats)
                    { 6, 0, 0, 0, 62, 69, 1339, 798}, -- tonberries
                    { 4, 2, 0, 0, 62, 69, 1339, 799}, -- succubus bats/tonberries
                    { 4, 2, 0, 0, 62, 76, 1427, 800}, -- million eyes/tonberries
                    { 5, 1, 0, 0, 73, 81, 1486, 801}, -- demonic pugils/doom toad
                    { 3, 3, 0, 0, 74, 79, 1450, 802}, -- tormentors/pucks
                    { 4, 2, 0, 0, 75, 80, 1468, 803}, -- torementors/bullbeggars
                },
            },
            [tpz.zone.RANGUEMONT_PASS] =
            {
                event = 24,
                page =
                {
                    { 4, 1, 0, 0,  3,  5, 270, 602}, -- wind bats/blade bats
                    { 5, 1, 0, 0, 25, 30, 717, 603}, -- seeker bats/ooze
                    { 4, 2, 0, 0, 26, 30, 717, 604}, -- goblin muggers/gamblers
                    { 4, 2, 0, 0, 26, 30, 717, 605}, -- goblin leechers/gamblers
                    { 4, 2, 0, 0, 30, 34, 775, 606}, -- stirges/hecteyes
                     -- { 5, 2, 0, 0, 87, 92, 2260, 607}, -- bilesuckers/hovering oculus
                     -- { 3, 3, 0, 0, 88, 90, 2260, 608}, -- goblin hoodoos/chasers
                     -- { 3, 3, 0, 0, 88, 90, 1850, 609}, -- goblin tanners/artificers
                },
            },
            [tpz.zone.BOSTAUNIEUX_OUBLIETTE] =
            {
                event = 114,
                page =
                {
                    { 5, 0, 0, 0, 52, 54, 1024, 610}, -- dark aspic
                    { 4, 2, 0, 0, 52, 59, 1044, 611}, -- funnel bats/werebats
                    { 5, 1, 0, 0, 56, 63, 1280, 612}, -- hound family/haunt
                    { 9, 0, 0, 0, 65, 68, 1300, 613}, -- bloodsuckers
                    -- { 6, 1, 0, 0, 94, 97, 2300, 614}, -- dabillas/panna cotta
                    -- { 6, 1, 0, 0, 95, 97, 2300, 615}, -- blind bats/panna cotta
                     -- { 6, 0, 0, 0, 96, 97, 1960, 616}, -- nachtmahrs
                     -- { 2, 5, 0, 0, 95, 99, 2480, 617}, -- wurdalaks/blind bats
                },
            },
            [tpz.zone.TORAIMARAI_CANAL] =
            {
                event = 100,
                page =
                {
                    { 3, 3, 0, 0, 47, 52, 1024, 618}, -- hell bats/makaras
                    { 2, 2, 2, 0, 52, 57, 1123, 619}, -- fallen knight/liches/dark aspics
                    { 3, 3, 0, 0, 53, 57, 1123, 620}, -- dark aspics/bloodsuckers
                    { 3, 4, 0, 0, 60, 65, 1280, 621}, -- scavenger crabs/stygian pugils
                    { 4, 3, 0, 0, 62, 65, 1280, 622}, -- starmite/dire bats (names different from what client will show)
                    -- { 5, 2, 0, 0, 95, 98, 2170, 623}, -- plunderer crabs/sodden bones
                    -- { 5, 2, 0, 0, 96, 98, 2250, 624}, -- blackwater pugils/drowned bones
                    -- { 8, 2, 0, 0, 94, 99, 2050, 625}, -- flume toads/poroggo excavators
                },
            },
            [tpz.zone.ZERUHN_MINES] =
            {
                event = 210,
                page =
                {
                    { 3, 0, 0, 0,  1,  3,  90, 626}, -- Ding bats
                    { 3, 0, 0, 0,  2,  4, 110, 627}, -- river crabs
                    -- { 5, 2, 0, 0, 75, 78, 1640, 628}, -- coiliery bats/soot crabs
                    -- { 5, 2, 0, 0, 75, 79, 1600, 629}, -- coiliery bats/burrower worms
                    -- { 5, 2, 0, 0, 75, 80, 1700, 630}, -- coiliery bats/veindigger leeches
                },
            },
            [tpz.zone.KORROLOKA_TUNNEL] =
            {
                event = 4,
                page =
                {
                    { 2, 4, 0, 0, 20, 26, 598, 727}, -- land worms/seeker bats
                    { 3, 3, 0, 0, 22, 30, 717, 728}, -- seeker bats/combats
                    { 4, 2, 0, 0, 23, 31, 741, 729}, -- huge spiders/jellies
                    { 6, 0, 0, 0, 28, 31, 741, 730}, -- thread leeches
                    { 6, 0, 0, 0, 29, 33, 752, 731}, -- clippers/greater pugils (no pugils, changed to 6 clippers)
                    { 4, 0, 0, 0, 30, 33, 752, 732}, -- bogies
                    { 6, 0, 0, 0, 35, 37, 844, 733}, -- gigas family
                    -- { 4, 3, 0, 0, 87, 91, 2140, 734}, -- lacerators/spool leeches
                },
            },
            [tpz.zone.KUFTAL_TUNNEL] =
            {
                event = 29,
                page =
                {
                    { 3, 3, 0, 0, 60, 64, 1261, 735}, -- robber crabs/sand lizards
                    { 5, 1, 0, 0, 60, 66, 1300, 736}, -- robber crabs/haunt
                    { 3, 3, 0, 0, 60, 66, 1300, 737}, -- cave worms/recluse spiders
                    { 4, 2, 0, 0, 60, 67, 1319, 738}, -- robber crabs/sabotender sed
                    { 3, 3, 0, 0, 63, 69, 1339, 739}, -- kuftal diggers/recluse spiders
                    { 3, 3, 0, 0, 65, 69, 1339, 740}, -- deinonychus/goblins
                    { 3, 3, 0, 0, 77, 80, 1468, 741}, -- ovinniks/greater cock
                    -- { 3, 3, 0, 0, 99, 103, 1900, 742}, -- kuftal delvers/machairoduss
                },
            },
            [tpz.zone.SEA_SERPENT_GROTTO] =
            {
                event = 24,
                page =
                {
                    { 3, 3, 0, 0, 35, 39, 831, 804}, -- royal leeches/undead bats
                    { 2, 4, 0, 0, 37, 41, 873, 805}, -- ironshells/skeletons
                    { 5, 1, 0, 0, 41, 45, 1036, 806}, -- sahagin/vampire bat
                    { 4, 2, 0, 0, 43, 48, 1013, 807}, -- sahagin/bigclaws
                    { 4, 2, 0, 0, 44, 48, 1013, 808}, -- sahagin/grotto pugils
                    { 3, 3, 0, 0, 62, 67, 1319, 809}, -- robber crabs/dire bats
                    { 3, 3, 0, 0, 62, 69, 1339, 810}, -- robber craws/devil manta
                    { 3, 3, 0, 0, 66, 69, 1339, 811}, -- mindgazers/greatclaws
                },
            },
            [tpz.zone.VELUGANNON_PALACE] =
            {
                event = 4,
                page =
                {
                    {10, 0, 0, 0, 72, 72, 1397, 743}, -- arcana-type
                    { 7, 0, 0, 0, 74, 77, 1446, 744}, -- evil weapons
                    { 7, 0, 0, 0, 75, 78, 1465, 745}, -- dustbusters
                    { 7, 0, 0, 0, 76, 79, 1450, 746}, -- caretakers
                    { 7, 0, 0, 0, 77, 80, 1468, 747}, -- enkidus
                    { 6, 0, 0, 0, 79, 80, 1468, 748}, -- elementals
                },
            },
            [tpz.zone.THE_SHRINE_OF_RUAVITAU] =
            {
                event = 61,
                page =
                {
                    {10, 0, 0, 0, 71, 71, 1378, 749}, -- arcana-type (defender)
                    { 6, 0, 0, 0, 71, 74, 1390, 750}, -- elementals
                    { 7, 0, 0, 0, 75, 80, 1468, 751}, -- aura pots
                    { 7, 0, 0, 0, 77, 82, 1505, 752}, -- doll family
                    { 7, 0, 0, 0, 79, 82, 1505, 753}, -- evil weapon family
                    { 7, 0, 0, 0, 81, 84, 1541, 754}, -- golem family
                },
            },
            [tpz.zone.LOWER_DELKFUTTS_TOWER] =
            {
                event = 40,
                page =
                {
                    { 3, 3, 0, 0, 25, 30, 717, 777}, -- bats/goblins
                    { 3, 3, 0, 0, 25, 30, 717, 778}, -- bats/gigas
                    { 4, 2, 0, 0, 25, 30, 717, 779}, -- bats/chaos idol
                    { 4, 2, 0, 0, 25, 32, 730, 780}, -- bats/bogy
                    { 4, 2, 0, 0, 25, 35, 798, 781}, -- bats/magic pots
                },
            },
            [tpz.zone.KING_RANPERRES_TOMB] =
            {
                event = 100,
                page =
                {
                    { 3, 3, 0, 0,  3,  8, 342, 631}, -- mouse bat/goblin
                    { 4, 2, 0, 0,  5, 11, 471, 632}, -- stone eater/wind bat
                    { 2, 2, 2, 0, 12, 16, 480, 633}, -- goblin ambush/tink/butch
                    { 3, 3, 0, 0, 14, 17, 510, 634}, -- plague bats/rock eater
                    { 2, 2, 2, 0, 21, 23, 550, 635}, -- goblin mugger/leecher/gambler
                     -- { 6, 1, 0, 0, 78, 80, 1520, 636},
                     -- { 5, 2, 0, 0, 77, 80, 1690, 637},
                     -- { 5, 2, 0, 0, 80, 83, 1720, 638},
                },
            },
            [tpz.zone.DANGRUF_WADI] =
            {
                event = 160,
                page =
                {
                    { 4, 1, 0, 0,  3,  8, 342, 639}, -- stone eater/rock lizard
                    { 3, 2, 0, 0,  5,  9, 385, 640}, -- goblins/wadi crab
                    { 3, 2, 0, 0, 11, 14, 420, 641}, -- wadi hare/leech
                     -- { 4, 2, 0, 0, 86, 89, 1830, 642}, -- fume lizard/goblin brigand
                     -- { 5, 2, 0, 0, 86, 90, 1650, 643}, -- witchetty grubs/goblin headsman
                     -- { 5, 2, 0, 0, 86, 90, 1840, 644}, -- prim pikas/goblin healer
                     -- { 2, 2, 2, 0, 90, 91, 1860, 645}, -- goblin conj/bladesmith/bushwhacker
                     -- { 5, 2, 0, 0, 90, 93, 2260, 646}, -- trimmers/natty gibbons
                },
            },
            [tpz.zone.INNER_HORUTOTO_RUINS] =
            {
                event = 100,
                page =
                {
                    { 2, 3, 0, 0,  1,  6, 315, 647}, -- battue bats/goblin thugs
                    { 2, 3, 0, 0,  1,  7, 367, 648}, -- blade bats/goblin weaver
                    { 3, 2, 0, 0, 15, 20, 500, 649}, -- battle bats/blobs
                    { 4, 2, 0, 0, 22, 26, 598, 650}, -- evil weapon/will-o-wisp
                     -- { 3, 3, 0, 0, 78, 82, 1750, 651}, -- troika bats/goblin trailblazers
                     -- { 3, 3, 0, 0, 79, 82, 1760, 652}, -- deathwatch beetles/goblin fleshers
                     -- { 2, 4, 0, 0, 81, 83, 1770, 653}, -- covin bats/skinymalinks
                     -- { 2, 4, 0, 0, 81, 84, 1780, 654}, -- goblin lurchers/skinnymajinxes
                },
            },
            [tpz.zone.ORDELLES_CAVES] =
            {
                event = 100,
                page =
                {
                    { 3, 3, 0, 0, 18, 21, 630, 655}, -- stalking sapling/thread leech
                    { 4, 2, 0, 0, 21, 27, 654, 656}, -- fly agaric/shrieker
                    { 5, 1, 0, 0, 17, 26, 630, 657}, -- goblin family/will-o-wisp
                    { 3, 3, 0, 0, 23, 26, 598, 658}, -- seeker bats/vorpal bunny
                    { 4, 2, 0, 0, 26, 28, 670, 659}, -- ancient bat/jelly
                    { 4, 1, 0, 0, 29, 34, 775, 660}, -- goliath beetle/stroper
                    -- { 3, 3, 0, 0, 84, 86, 1810, 661}, -- buds bunny/targe beetle
                    -- { 3, 3, 0, 0, 86, 88, 1890, 662}, -- bilis leech/swagger spruce
                },
            },
            [tpz.zone.OUTER_HORUTOTO_RUINS] =
            {
                event = 110,
                page =
                {
                    { 1, 1, 1, 1, 10, 14, 420, 663}, -- four cpus/batons/swords/coins
                    { 1, 1, 1, 1, 15, 19, 475, 664}, -- five cups/batons/swords/coins
                    { 1, 1, 1, 1, 20, 24, 573, 665}, -- six cups/batons/swords/coins
                    { 1, 1, 1, 1, 25, 29, 693, 666}, -- seven cups/batons/swords/coins
                    { 1, 1, 1, 1, 30, 34, 775, 667}, -- eight cups/batons/swords/coins
                    { 1, 1, 1, 1, 35, 39, 831, 668}, -- nine cups/batons/swords/coins
                     -- { 5, 1, 0, 0, 81, 85, 1840, 669}, -- fetor bats/fuligo
                     -- { 5, 1, 0, 0, 82, 85, 1850, 670}, -- thorn bats/fuligo
                },
            },
            [tpz.zone.THE_ELDIEME_NECROPOLIS] =
            {
                event = 100,
                page =
                {
                    { 6, 0, 0, 0, 42, 46, 1059, 671}, -- skeleton family
                    { 6, 0, 0, 0, 46, 49, 1034, 672}, -- shadow family
                    { 4, 2, 0, 0, 51, 54, 1064, 673}, -- shadow family/azers
                    { 5, 1, 0, 0, 50, 55, 1083, 674}, -- liches/blood soul
                    { 3, 3, 0, 0, 53, 56, 1103, 675}, -- tomb wolves/skeleton family
                    { 3, 3, 0, 0, 60, 63, 1241, 676}, -- tomb warriors/tomb mages
                     -- { 3, 3, 0, 0, 91, 95, 1890, 677}, -- hellbound warrios/nekros hounds
                     -- { 3, 3, 0, 0, 91, 95, 1890, 678}, -- hellbound warlocks/nekros hounds
                },
            },
            [tpz.zone.GUSGEN_MINES] =
            {
                event = 100,
                page =
                {
                    { 6, 0, 0, 0, 20, 27, 621, 679}, -- skeleton family
                    { 2, 4, 0, 0, 20, 24, 573, 680}, -- fly agarics/skeleton family
                    { 2, 4, 0, 0, 21, 26, 630, 681}, -- ore eater/bandersnatches
                    { 2, 2, 2, 0, 28, 31, 741, 682}, -- greater pugils/amphibaenas/mauthe doog
                    { 3, 3, 0, 0, 30, 34, 775, 683}, -- wights/myconids
                    { 3, 3, 0, 0, 32, 36, 821, 684}, -- ghasts/gallinippers
                     -- { 2, 5, 0, 0, 85, 87, 1890, 685}, -- accursed soldiers/rockmills
                     -- { 2, 5, 0, 0, 85, 89, 2180, 686}, -- accursed sorcerers/madfly
                },
            },
            [tpz.zone.CRAWLERS_NEST] =
            {
                event = 100,
                page =
                {
                    { 3, 3, 0, 0, 40, 44, 1013, 687}, -- worker crawler/death jacket
                    { 3, 3, 0, 0, 45, 49, 1034, 688}, -- soldier crawler/nest beetle
                    { 3, 3, 0, 0, 49, 52, 1050, 689}, -- labyrinth lizards/witch hazels
                    { 4, 2, 0, 0, 50, 54, 1064, 690}, -- exorays/hornflys
                    { 2, 2, 2, 0, 53, 58, 1142, 691}, -- rumble crawlers/wespes/dragonflys
                    { 3, 3, 0, 0, 59, 63, 1241, 692}, -- helm beetles/knight crawlers
                     -- { 4, 3, 0, 0, 91, 93, 2190, 693}, -- king crawlers/vespos
                     -- { 4, 3, 0, 0, 92, 96, 2220, 694}, -- dancing jewels/olid funguars
                },
            },
            [tpz.zone.MAZE_OF_SHAKHRAMI] =
            {
                event = 100,
                page =
                {
                    { 3, 2, 0, 0, 15, 18, 540, 695}, -- goblin family/stink bats
                    { 4, 2, 0, 0, 18, 23, 550, 696}, -- maze maker/combat
                    { 2, 4, 0, 0, 22, 26, 630, 697}, -- ghoul/carnivorous crawler
                    { 2, 4, 0, 0, 26, 31, 741, 698}, -- caterchipillar/anicient bat
                    { 4, 2, 0, 0, 26, 31, 741, 699}, -- abyss worm/ancient bat
                    { 5, 1, 0, 0, 27, 33, 752, 700}, -- abyss worm/labyrinth scrop
                     -- { 3, 3, 0, 0, 83, 85, 1840, 701}, -- chaser bats/bleeder leech
                     -- { 3, 3, 0, 0, 86, 88, 1830, 702}, -- warren bat/crypterpillar
                },
            },
            [tpz.zone.GARLAIGE_CITADEL] =
            {
                event = 110,
                page =
                {
                    { 4, 2, 0, 0, 40, 43, 990, 703}, -- wingrats/skeleton family
                    { 4, 2, 0, 0, 40, 44, 1013, 704}, -- siege bats/borer beetles
                    { 2, 4, 0, 0, 46, 49, 1034, 705}, -- evil weapon family/citadel bats
                    { 4, 2, 0, 0, 51, 55, 1083, 706}, -- funnel bats/explosures
                    { 3, 3, 0, 0, 52, 58, 1142, 707}, -- dromas/chamber beetles
                    { 2, 2, 1, 0, 59, 62, 1221, 708}, -- over weapons/vault weapons/wraith
                     -- { 5, 2, 0, 0, 91, 96, 1840, 709}, -- donjon bats/kabooms
                     -- { 4, 3, 0, 0, 92, 96, 2220, 710}, -- fortalice bats/warden beetles
                },
            },
            [tpz.zone.FEIYIN] =
            {
                event = 100,
                page =
                {
                    { 4, 2, 0, 0, 40, 43, 990, 711}, -- vampire bats/drones
                    { 4, 2, 0, 0, 43, 46, 1059, 712}, -- shadow family/ore golems
                    { 5, 1, 0, 0, 50, 55, 1083, 713}, -- underworld bats/talos
                    { 4, 2, 0, 0, 50, 56, 1103, 714}, -- underworld bats/dromas
                    { 5, 1, 0, 0, 50, 58, 1142, 715}, -- underworld bats/colossus
                    { 3, 3, 0, 0, 59, 63, 1241, 716}, -- killing weapons/hellish weapons
                     -- { 4, 2, 0, 0, 95, 99, 2060, 717}, -- balayang/wekufes
                     -- { 4, 3, 0, 0, 95, 99, 2250, 718}, -- balayang/sentient carafes
                },
            },
            [tpz.zone.IFRITS_CAULDRON] =
            {
                event = 51,
                page =
                {
                    { 4, 1, 0, 0, 61, 68, 1320, 755}, -- volcano wasp/gas
                    { 4, 1, 0, 0, 61, 68, 1320, 756}, -- old opo/volcanic gas
                    { 4, 1, 0, 0, 62, 69, 1339, 757}, -- goblin family/volcanic gas
                    { 3, 2, 0, 0, 62, 73, 1417, 758}, -- eotyrannus/volcanic gas
                    { 3, 2, 0, 0, 62, 73, 1417, 759}, -- volcanic gas/sulfur scorp
                    { 4, 2, 0, 0, 69, 74, 1390, 760}, -- nightmare bats/volcanic bomb
                    { 4, 2, 0, 0, 71, 78, 1465, 761}, -- ash lizard/volcanic bomb
                    { 4, 2, 0, 0, 71, 78, 1465, 762}, -- hurrican wyvern/volcanic bomb
                },
            },
            [tpz.zone.QUICKSAND_CAVES] =
            {
                event = 15,
                page =
                {
                    { 3, 3, 0, 0, 51, 55, 1083, 812}, -- sand spiders/antica family
                    { 3, 3, 0, 0, 51, 58, 1142, 813}, -- helm beetles/antica family
                    { 3, 3, 0, 0, 51, 59, 1162, 814}, -- worm family/antica family
                    { 7, 0, 0, 0, 52, 59, 1162, 815}, -- antica family
                    { 3, 3, 0, 0, 52, 59, 1162, 816}, -- sabotender family/antica family
                    { 3, 3, 0, 0, 56, 59, 1162, 817}, -- sand lizards/antica family
                    { 3, 3, 0, 0, 62, 65, 1280, 818}, -- girtabs/antica family
                    { 3, 3, 0, 0, 65, 69, 1339, 819}, -- sand tarantulas/antica family
                },
            },
            [tpz.zone.GUSTAV_TUNNEL] =
            {
                event = 17,
                page =
                {
                    { 2, 2, 1, 0, 44, 49, 1034, 763}, -- labyrinth lizards/leeches/bat family
                    { 2, 2, 2, 0, 45, 49, 1034, 764}, -- hawkers/makaras/goblin family
                    { 3, 2, 1, 0, 65, 68, 1320, 765}, -- robber crabs/skeleton family/goblin family
                    { 3, 3, 0, 0, 73, 76, 1427, 766}, -- doom warlocks/demonic pugils
                    { 5, 1, 0, 0, 75, 78, 1465, 767}, -- doom guards/erlik
                    { 5, 1, 0, 0, 75, 79, 1450, 768}, -- doom guards/antares
                    { 4, 2, 0, 0, 76, 80, 1468, 769}, -- doom warlocks/typhoon wyverns
                     -- { 5, 2, 0, 0, 100, 103, 2310, 770}, -- boulder eaters/pygmytoises
                },
            },
            [tpz.zone.LABYRINTH_OF_ONZOZO] =
            {
                event = 3,
                page =
                {
                    { 2, 3, 0, 0, 45, 49, 965, 771}, -- labyrinth leech/goblin family
                    { 3, 2, 0, 0, 50, 53, 1044, 772}, -- cockatrice/goblin family
                    { 3, 2, 0, 0, 50, 54, 1064, 773}, -- mushussu/cockatrice
                    { 3, 2, 0, 0, 55, 59, 1162, 774}, -- flying manta/goblin family
                    { 4, 1, 0, 0, 70, 74, 1390, 775}, -- torama/labyrinth manticore
                     -- { 4, 2, 0, 0, 95, 98, 1920, 776}, -- babaulas/boribaba
                },
            },
        },
    },
}

local function getPageByRegimeId(regimeType, zoneId, regimeId)
    local info = regimeInfo[regimeType]
    if not info then return nil end

    info = info.zone[zoneId]
    if not info then return nil end

    info = info.page
    if not info then return nil end

    -- return sequential page number for convenience
    local pageNum = 0
    for _, v in pairs(info) do
        pageNum = pageNum + 1
        if v[8] == regimeId then
            v[9] = pageNum
            return v
        end
    end

    return nil
end

local function getPageByNum(regimeType, zoneId, pageNum)
    local info = regimeInfo[regimeType]
    if not info then return nil end

    info = info.zone[zoneId]
    if not info then return nil end

    info = info.page
    return info[pageNum]
end

local function getUpdateOpts(regimeType)
    local out = {}
    for k, v in pairs(regimeInfo[regimeType].updateOptions) do
        out[k] = v
    end
    for k, v in pairs(regimeInfo[regimeType].sharedOptions) do
        out[k] = v
    end
    return out
end

local function getFinishOpts(regimeType)
    local out = {}
    for k, v in pairs(regimeInfo[regimeType].finishOptions) do
        out[k] = v
    end
    for k, v in pairs(regimeInfo[regimeType].sharedOptions) do
        out[k] = v
    end
    return out
end

-- first time an effect is applied, use basePower
-- each additional time an effect is applied, use addPower
-- can stack each effect up to maxStack times, per https://ffxiclopedia.fandom.com/wiki/Grounds_of_Valor#Prowesses
local prowessData =
{
    { effect = tpz.effect.PROWESS_CASKET_RATE,   basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = tpz.effect.PROWESS_SKILL_RATE,    basePower = 4,   addPower = 4,   maxStack = 11 },
    { effect = tpz.effect.PROWESS_CRYSTAL_YIELD, basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = tpz.effect.PROWESS_TH,            basePower = 1,   addPower = 1,   maxStack = 3  },
    { effect = tpz.effect.PROWESS_ATTACK_SPEED,  basePower = 400, addPower = 400, maxStack = 4  },
    { effect = tpz.effect.PROWESS_HP_MP,         basePower = 3,   addPower = 1,   maxStack = 11 },
    { effect = tpz.effect.PROWESS_ACC_RACC,      basePower = 4,   addPower = 4,   maxStack = 11 },
    { effect = tpz.effect.PROWESS_ATT_RATT,      basePower = 4,   addPower = 4,   maxStack = 11 },
    { effect = tpz.effect.PROWESS_MACC_MATK,     basePower = 4,   addPower = 4,   maxStack = 10 },
    { effect = tpz.effect.PROWESS_CURE_POTENCY,  basePower = 4,   addPower = 4,   maxStack = 5  },
    { effect = tpz.effect.PROWESS_WS_DMG,        basePower = 2,   addPower = 2,   maxStack = 5  },
    { effect = tpz.effect.PROWESS_KILLER,        basePower = 4,   addPower = 4,   maxStack = 2  },
}

local function addGovProwessBonusEffect(player)
    -- make a table of prowesses that are not yet maxed
    local availableProwesses = {}

    for i = 1, #prowessData do
        local p = prowessData[i]
        local e = player:getStatusEffect(p.effect)

        if not e or e:getPower() < (p.basePower + p.addPower * (p.maxStack - 1)) then
            table.insert(availableProwesses, p)
        end
    end

    -- pick one and apply
    if #availableProwesses > 0 then
        local p = availableProwesses[math.random(#availableProwesses)]
        local e = player:getStatusEffect(p.effect)

        -- get current power
        local power = 0
        if e then
            power = e:getPower()
            player:delStatusEffectSilent(p.effect)
        end

        -- add either basePower or addPower
        if power == 0 then
            power = p.basePower
        else
            power = power + p.addPower
        end

        -- set effect
        player:addStatusEffectEx(p.effect, 0, power, 0, 0)
        player:messageBasic(p.effect - 168)
    end
end

-- function made global to be called by hunts.lua
tpz.regime.clearRegimeVars = function(player)
    player:setCharVar("[regime]type", 0)
    player:setCharVar("[regime]zone", 0)
    player:setCharVar("[regime]id", 0)
    player:setCharVar("[regime]repeat", 0)
    player:setCharVar("[regime]lastReward", 0)
    player:setCharVar("[regime]waitNewDay", 0)

    for i = 1, 4 do
        player:setCharVar("[regime]needed" .. i, 0)
        player:setCharVar("[regime]killed" .. i, 0)
    end
end

tpz.regime.bookOnTrigger = function(player, regimeType)
    local info = regimeInfo[regimeType].zone[player:getZoneID()]
     -- checks if hunt is active, if so prompts player to cancel
    if player:getCharVar("[hunt]status") >= 1 then
        player:startEvent(info.event, 0, 0, 3, 1, 0, 0, player:getCurrency("valor_point"), player:getCharVar("[hunt]id"))

    elseif (regimeType == tpz.regime.type.FIELDS and ENABLE_FIELD_MANUALS == 1) or (regimeType == tpz.regime.type.GROUNDS and ENABLE_GROUNDS_TOMES == 1) then
        -- arg2 is a bitmask that controls which pages appear for examination
        -- here, we only show pages that have regime info
        -- arg4 reduces prices of field suppord
        local pages = table.getn(info.page)
        local arg2 = 0
        local arg4 = 0
        for i = 1, 10 do
            if i > pages then
                arg2 = arg2 + 2^i
            end
        end
        if player:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE) then
            arg4 = 1
        end

        player:startEvent(info.event, 0, arg2, 0, arg4, 0, 0, player:getCurrency("valor_point"), player:getCharVar("[regime]id"))
    else
        player:PrintToPlayer("Disabled.")
    end
end

tpz.regime.bookOnEventUpdate = function(player, option, regimeType)
    local page = getPageByRegimeId(player:getCharVar("[regime]type"), player:getCharVar("[regime]zone"), player:getCharVar("[regime]id"))

    -- check valid option
    local opts = getUpdateOpts(regimeType)
    local opt = opts[option]

    if not opt then
        return
    end

    -- generic message for options that have "enabled" param set to false
    if opt.enabled ~= nil and opt.enabled == false then
        local disabledMessage = "Option is disabled."
        if opt.act ~= nil then
            disabledMessage = string.format("Option %s is disabled.", string.gsub(string.lower(opt.act),"_"," "))
        end
        player:PrintToPlayer(disabledMessage, 29)
        player:release()
        return
    end

    -- review current training regime: progress on mobs
    if opt.review and page then
        local n1 = (page[1] ~= 0) and player:getCharVar("[regime]killed1") or 0
        local n2 = (page[2] ~= 0) and player:getCharVar("[regime]killed2") or 0
        local n3 = (page[3] ~= 0) and player:getCharVar("[regime]killed3") or 0
        local n4 = (page[4] ~= 0) and player:getCharVar("[regime]killed4") or 0
        player:updateEvent(page[1], page[2], page[3], page[4], n1, n2, n3, n4)

    -- review current training regime: level range and training area
    elseif opt.details and page then
        player:updateEvent(0, 0, 0, 0, 0, page[5], page[6], 0)

    -- TO DO: read about prowesses
    elseif opt.prowess then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)

    -- select a regime
    elseif opt.page then
        local page = getPageByNum(regimeType, player:getZoneID(), opt.page)
        if page then
            player:updateEvent(page[1], page[2], page[3], page[4], 0, page[5], page[6], page[8])
        end
    end
end

tpz.regime.bookOnEventFinish = function(player, option, regimeType)
    local zoneId = player:getZoneID()
    local msgOffset = zones[zoneId].text.REGIME_REGISTERED
    local tabs = player:getCurrency("valor_point")
    -- repeating regimes OOE for 2010
    local regimeRepeat = bit.band(option, 0x80000000)
    -- local regimeRepeat = 0
    local hasKI  = player:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE)

    option = bit.band(option, 0x7FFFFFFF)

    if option == 7 then
      tpz.hunts.clearHuntVars(player)
    end

    -- check valid option
    local opts = getFinishOpts(regimeType)
    local opt = opts[option]

    if not opt then
        return
    end

    -- generic message for options that have "enabled" param set to false
    if opt.enabled ~= nil and opt.enabled == false then
        local disabledMessage = "Option is disabled."
        if opt.act ~= nil then
            disabledMessage = string.format("Option %s is disabled.", string.gsub(string.lower(opt.act),"_"," "))
        end
        player:PrintToPlayer(disabledMessage, 29)
        return
    end

    local cost = opt.cost

    -- charges player differently if they hold RoV KeyItem
    if cost and hasKI then
        cost = opt.discounted
    end

    -- check player has enough tabs
    if cost and cost > tabs then
        player:showText(player, msgOffset + 1032) -- You do not have enough tabs.
        return
    end

    -- check player can eat
    if opt.food and (player:hasStatusEffect(tpz.effect.FOOD) or player:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        player:messageBasic(tpz.msg.basic.IS_FULL)
        return
    end

    -- purchase a service
    if opt.act then
        local act = opt.act
        player:delCurrency("valor_point", cost)

        if act == "CANCEL_REGIME" then
            local totalPageProgress = 0
            if REGIME_WAIT == 1 then
                for i = 1, 4 do
                    totalPageProgress = totalPageProgress + player:getCharVar("[regime]killed" .. i)
                end
                if totalPageProgress == 0 then
                    player:setCharVar("[regime]day",0)
                    player:PrintToPlayer("Field Manual: Page had no progress, you may get another page today!", 0xD)
                end
            end
            tpz.regime.clearRegimeVars(player)
            player:showText(player, msgOffset + 2) -- Training regime canceled.

        elseif act == "REPATRIATION" then
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.HOME_NATION, 0, 1)

        elseif act == "CIRCUMSPECTION" then
            player:delStatusEffectSilent(tpz.effect.SNEAK)
            player:addStatusEffect(tpz.effect.SNEAK, 0, 10, 900 * SNEAK_INVIS_DURATION_MULTIPLIER)
            player:delStatusEffectSilent(tpz.effect.INVISIBLE)
            player:addStatusEffect(tpz.effect.INVISIBLE, 0, 10, 900 * SNEAK_INVIS_DURATION_MULTIPLIER)

        elseif act == "HOMING_INSTINCT" then
            player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WARP, 0, 1)

        elseif act == "RERAISE" then
            player:delStatusEffectSilent(tpz.effect.RERAISE)
            player:addStatusEffect(tpz.effect.RERAISE, 1, 0, 7200)

        elseif act == "RERAISE_II" then
            player:delStatusEffectSilent(tpz.effect.RERAISE)
            player:addStatusEffect(tpz.effect.RERAISE, 2, 0, 7200)

        elseif act == "RERAISE_III" then
            player:delStatusEffectSilent(tpz.effect.RERAISE)
            player:addStatusEffect(tpz.effect.RERAISE, 3, 0, 7200)

        elseif act == "REGEN" then
            player:delStatusEffectSilent(tpz.effect.REGEN)
            player:addStatusEffect(tpz.effect.REGEN, 1, 3, 3600, 0, 128)

        elseif act == "REFRESH" then
            player:delStatusEffectSilent(tpz.effect.REFRESH)
            player:delStatusEffect(tpz.effect.SUBLIMATION_COMPLETE)
            player:delStatusEffect(tpz.effect.SUBLIMATION_ACTIVATED)
            player:addStatusEffect(tpz.effect.REFRESH, 1, 3, 3600, 0, 128)

        elseif act == "PROTECT" then
            local mLvl = player:getMainLvl()
            local power = 0

            if mLvl < 27 then
                power = 10
            elseif mLvl < 47 then
                power = 25
            elseif mLvl < 63 then
                power = 40
            else
                power = 55
            end

            player:delStatusEffectSilent(tpz.effect.PROTECT)
            player:addStatusEffect(tpz.effect.PROTECT, power, 0, 1800)

        elseif act == "SHELL" then
            local mLvl = player:getMainLvl()
            local power = 0

            if mLvl < 37 then
                power = 9
            elseif mLvl < 57 then
                power = 14
            elseif mLvl < 68 then
                power = 19
            else
                power = 22
            end
            player:delStatusEffectSilent(tpz.effect.SHELL)
            player:addStatusEffect(tpz.effect.SHELL, power, 0, 1800)

        elseif act == "HASTE" then
            player:delStatusEffectSilent(tpz.effect.HASTE)
            player:addStatusEffect(tpz.effect.HASTE, 1000, 0, 600)

        elseif act == "DRIED_MEAT" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 1, 0, 1800)

        elseif act == "SALTED_FISH" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 2, 0, 1800)

        elseif act == "HARD_COOKIE" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 3, 0, 1800)

        elseif act == "INSTANT_NOODLES" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 4, 0, 1800)

        elseif act == "DRIED_AGARICUS" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 5, 0, 1800)

        elseif act == "INSTANT_RICE" then
            player:addStatusEffectEx(tpz.effect.FIELD_SUPPORT_FOOD, 251, 6, 0, 1800)

        end

    -- select a training regime
    elseif opt.page then
        local page = getPageByNum(regimeType, zoneId, opt.page)

        if page then
            -- WINGSCUSTOM reset pages-per-day counter if you grab a new page on a different day
            if player:getCharVar("[regime]day") ~= VanadielDayAbsolute() then
                player:setCharVar("[regime]repeatedCompletions", 0)
            end
            if regimeRepeat ~= 0 then
                regimeRepeat = 1
                -- only displayed if repeating is enabled
                -- WINGSCUSTOM
                player:PrintToPlayer("Field Manual: You chose to repeat this regime. Continue killing regime monsters after completion for renewal!", 0xD)
            elseif player:getCharVar("[regime]day") == VanadielDayAbsolute() then
                player:messageBasic(tpz.msg.basic.WAIT_LONGER)
                return
            end

            -- QoL info for player to know which page number they just grabbed
            player:PrintToPlayer(string.format("Field Manual: Grabbed page %s!", opt.page), 0xD)

            player:setCharVar("[regime]type", regimeType)
            player:setCharVar("[regime]zone", zoneId)
            player:setCharVar("[regime]id", page[8])
            player:setCharVar("[regime]repeat", regimeRepeat)
            
            if REGIME_WAIT == 1 and player:getCharVar("[regime]day") == VanadielDayAbsolute() then
                -- WINGSCUSTOM
                player:PrintToPlayer("You have chosen a page before a new one is available. Since you chose to have the page repeat your progress is stalled until the new day.")
                for i = 1, 4 do
                    player:setCharVar("[regime]killed" .. i, page[i])
                    player:setCharVar("[regime]needed" .. i, page[i])
                end
                player:setCharVar("[regime]waitNewDay", 1)
            else
                for i = 1, 4 do
                    player:setCharVar("[regime]killed" .. i, 0)
                    player:setCharVar("[regime]needed" .. i, page[i])
                end
            end

            player:setCharVar("[regime]day", VanadielDayAbsolute())

            player:showText(player, msgOffset)
            player:showText(player, msgOffset + 1)

            -- Records of Eminence: Undertake a FoV Training Regime
            if player:getEminenceProgress(3) and regimeType == tpz.regime.type.FIELDS then
                tpz.roe.onRecordTrigger(player, 3)
            end

            -- Records of Eminence: Undertake a GoV Training Regime
            if player:getEminenceProgress(11) and regimeType == tpz.regime.type.GROUNDS then
                tpz.roe.onRecordTrigger(player, 11)
            end
        end
    end
end

tpz.regime.checkRegime = function(player, mob, regimeId, index, regimeType)
    -- if this is run for a player, do below logic to renew page if applicable
    if not player then
        return
    end

    -- check if regime needs to be renewed on ANY mob related to regimes
    if player:getCharVar("[regime]waitNewDay") ~= 1 then
        -- dead players and players not on this training regime get no credit
        if player:getHP() == 0 or player:getCharVar("[regime]id") ~= regimeId then
            return
        end

        -- people in alliance get no fields credit unless FOV_REWARD_ALLIANCE is 1 in scripts/globals/settings.lua
        if FOV_REWARD_ALLIANCE ~= 1 and regimeType == tpz.regime.type.FIELDS and player:checkSoloPartyAlliance() == 2 then
            return
        end

        -- people in alliance get no grounds credit unless GOV_REWARD_ALLIANCE is 1 in scripts/globals/settings.lua
        if GOV_REWARD_ALLIANCE ~= 1 and regimeType == tpz.regime.type.GROUNDS and player:checkSoloPartyAlliance() == 2 then
            return
        end

        -- mobs that give no XP give no credit
        if not player:checkKillCredit(mob) then
            return
        end

        -- get number of this mob needed, and killed so far
        local needed = player:getCharVar("[regime]needed" .. index)
        local killed = player:getCharVar("[regime]killed" .. index)

        -- already finished with this mob
        if killed == needed then
            return
        end

        -- increment number killed
        killed = killed + 1
        player:messageBasic(tpz.msg.basic.FOV_DEFEATED_TARGET, killed, needed)
        player:setCharVar("[regime]killed" .. index, killed)

        -- this mob is not yet finished
        if needed > killed then
            return
        end

        -- get page information
        local page = getPageByRegimeId(player:getCharVar("[regime]type"), player:getCharVar("[regime]zone"), player:getCharVar("[regime]id"))
        if not page then
            return
        end

        -- this page is not yet finished
        for i = 1, 4 do
            if player:getCharVar("[regime]killed" .. i) < page[i] then
                return
            end
        end


        -- get base reward
        player:messageBasic(tpz.msg.basic.FOV_COMPLETED_REGIME)
        local reward = page[7]

        -- WINGSCUSTOM diminishing returns on page rewards for repeated completions on same day
        local completions = player:getCharVar("[regime]repeatedCompletions")
        if REGIME_WAIT == 0 and player:getCharVar("[regime]day") == VanadielDayAbsolute() then
            if completions > 0 then
                reward = math.ceil(reward * (.85 ^ completions))
                player:PrintToPlayer(string.format("Field Manual : You are getting a reduced reward from completing %u pages on the same day!", completions), 0xD)
            end
            player:setCharVar("[regime]repeatedCompletions", completions + 1)
        else
            -- if completed a page on the previous day, give full reward this time but diminished for next. Else, give full for both
            player:setCharVar("[regime]repeatedCompletions", completions == 0 and 0 or 1)
        end

        -- adjust reward down if regime is higher than server mob level cap
        -- example: if you have mobs capped at level 80, and the regime is level 100, you will only get 80% of the reward
        if NORMAL_MOB_MAX_LEVEL_RANGE_MAX > 0 and page[6] > NORMAL_MOB_MAX_LEVEL_RANGE_MAX then
            local avgCapLevel = (NORMAL_MOB_MAX_LEVEL_RANGE_MIN + NORMAL_MOB_MAX_LEVEL_RANGE_MAX) / 2
            local avgMobLevel = (page[5] + page[6]) / 2
            reward = math.floor(reward * avgCapLevel / avgMobLevel)
        end

        -- prowess buffs from completing Grounds regimes
        if regimeType == tpz.regime.type.GROUNDS and ENABLE_PROWESS == 1 then
            addGovProwessBonusEffect(player)

            -- repeat clears bonus
            if player:hasStatusEffect(tpz.effect.PROWESS) then
                -- increase reward based on number of clears. hard caps at 2x base reward.
                local govClears = player:getStatusEffect(tpz.effect.PROWESS):getPower()
                local baseReward = reward
                reward = reward * (100 + (govClears * 4)) / 100
                reward = utils.clamp(reward, 0, baseReward * 2)

                -- increment clears
                player:delStatusEffectSilent(tpz.effect.PROWESS)
                player:addStatusEffect(tpz.effect.PROWESS, govClears + 1, 0, 0)

            else
                -- keep track of number of clears
                player:addStatusEffect(tpz.effect.PROWESS, 1, 0, 0)
            end
        end

        -- award gil and tabs once per day, or at every page completion if REGIME_WAIT is 0 in settings.lua
        local vanadielEpoch = vanaDay()
        if REGIME_WAIT == 0 or player:getCharVar("[regime]lastReward") < vanadielEpoch then
            -- gil
            player:addGil(reward)
            player:messageBasic(tpz.msg.basic.FOV_OBTAINS_GIL, reward)

            -- tabs
            local tabs = math.floor(reward / 10) * TABS_RATE
            tabs = utils.clamp(tabs, 0, 50000 - player:getCurrency("valor_point")) -- Retail caps players at 50000 tabs
            player:addCurrency("valor_point", tabs)
            player:messageBasic(tpz.msg.basic.FOV_OBTAINS_TABS, tabs, player:getCurrency("valor_point"))

            player:setCharVar("[regime]lastReward", vanadielEpoch)
        end

        -- award XP every page completion
        player:addExp(reward)
    end

    -- repeating regimes
    if player:getCharVar("[regime]repeat") == 1 then
        -- new day hasn't passed since collecting a page
        if REGIME_WAIT == 1 and player:getCharVar("[regime]day") == VanadielDayAbsolute() then
            if player:getCharVar("[regime]waitNewDay") ~= 1 then
                -- WINGSCUSTOM
                player:setCharVar("[regime]waitNewDay", 1)
                player:PrintToPlayer("Reviewing your progress at Field Manual will show all tasks complete until killing a regime monster in any zone on a new day.")
            end
        else
            for i = 1, 4 do
                player:setCharVar("[regime]killed" .. i, 0)
            end
            
            player:messageBasic(tpz.msg.basic.FOV_REGIME_BEGINS_ANEW)
            player:setCharVar("[regime]waitNewDay", 0)
            player:setCharVar("[regime]day", VanadielDayAbsolute())
            -- since we only let pages renew once per day, we need to reset this to allow gil/tabs every page completion
            if REGIME_WAIT == 1 then
                player:setCharVar("[regime]lastReward", 0)
            end

            local pageNum = getPageByRegimeId(player:getCharVar("[regime]type"), player:getCharVar("[regime]zone"), player:getCharVar("[regime]id"))[9]
            local regimeZoneID = player:getCharVar("[regime]zone")
            local zoneString = "SomeZone"
            for zone, v in pairs(tpz.zone) do
                if tpz.zone[zone] == regimeZoneID then
                    zoneString = zone
                    break
                end
            end
            player:PrintToPlayer(string.format("Field Manual: Renewed page %s from %s!", pageNum, string.gsub(string.lower(zoneString),"_"," ")), 0xD)
        end
    else
        tpz.regime.clearRegimeVars(player)
    end
end
