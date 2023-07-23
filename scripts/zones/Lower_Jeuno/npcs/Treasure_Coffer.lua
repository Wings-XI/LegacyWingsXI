-----------------------------------
-- Area: Lower Jeuno
--  NPC: Treasure Coffer
-- Type: Add-on NPC
-- !pos 41.169 3.899 -51.005 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
-----------------------------------

local optionToKI =
{
    [ 1] = tpz.ki.CRIMSON_KEY,
    [ 2] = tpz.ki.VIRIDIAN_KEY,
    [ 3] = tpz.ki.AMBER_KEY,
    [ 4] = tpz.ki.AZURE_KEY,
    [ 5] = tpz.ki.IVORY_KEY,
    [ 6] = tpz.ki.EBON_KEY,
    [ 8] = tpz.ki.WHITE_CORAL_KEY,
    [ 9] = tpz.ki.BLUE_CORAL_KEY,
    [10] = tpz.ki.PEACH_CORAL_KEY,
    [11] = tpz.ki.BLACK_CORAL_KEY,
    [12] = tpz.ki.RED_CORAL_KEY,
    [13] = tpz.ki.ANGEL_SKIN_KEY,
    [15] = tpz.ki.MOOGLE_KEY,
    [16] = tpz.ki.BIRD_KEY,
    [17] = tpz.ki.CACTUAR_KEY,
    [18] = tpz.ki.BOMB_KEY,
    [19] = tpz.ki.CHOCOBO_KEY,
    [20] = tpz.ki.TONBERRY_KEY,
}

local optionToGear =
{
    [1] = {addon = 1, itemid = 11313}, -- nuevo_coselete
    [2] = {addon = 1, itemid = 11314}, -- mirke_wardecors
    [3] = {addon = 1, itemid = 11315}, -- royal_redingote
    [4] = {addon = 2, itemid = 11487}, -- champions_galea
    [5] = {addon = 2, itemid = 11488}, -- anwig_salade
    [6] = {addon = 2, itemid = 11489}, -- selenian_cap
    [7] = {addon = 3, itemid = 16369}, -- blitzer_poleyn
    [8] = {addon = 3, itemid = 16370}, -- desultor_tassets
    [9] = {addon = 3, itemid = 16371}, -- tatsumaki_sitagoromo
}

local optionToAugment =
{
    [1] = -- ACP
    {
        [ 1] = {{augment =  23, power =  9}}, -- Accuracy+10
        [ 2] = {{augment =  25, power =  9}}, -- Attack+10
        [ 3] = {{augment =  27, power =  9}}, -- Ranged Accuracy+10
        [ 4] = {{augment =  29, power =  9}}, -- Ranged Attack+10
        [ 5] = {{augment =  31, power =  9}}, -- Evasion+10
        [ 6] = {{augment =  35, power =  3}}, -- Magic Accuracy+4
        [ 7] = {{augment = 133, power =  3}}, -- "Magic Atk, Bonus"+4
        [ 8] = {{augment = 143, power =  1}}, -- "Double Attack"+2
        [ 9] = {{augment =  41, power =  2}}, -- Critical hit rate +3
        [10] = {{augment =  44, power =  3}}, -- Store TP"+4 "Subtle Blow"+4
        [11] = {{augment =  39, power =  4}}, -- Enmity+5
        [12] = {{augment =  40, power =  4}}, -- Enmity-5
        [13] = {{augment = 140, power =  4}}, -- Enhances "Fast Cast" effect +5
        [14] = {{augment = 324, power = 14}}, -- "Call Beast" ability delay -15
        [15] = {{augment = 211, power =  4}}, -- "Snapshot"+5
        [16] = {{augment = 146, power =  2}}, -- Enhances "Dual Wield" effect +3
        [17] = {{augment = 320, power =  3}}, -- "Blood Pact" ability delay -4
        [18] = {{augment = 321, power =  1}}, -- Avatar perpetuation cost -2
        [19] = {{augment = 325, power =  4}}, -- Quick Draw" ability delay -5
        [20] = {{augment =  96, power = 14}}, -- Pet: Accuracy+15 Ranged Accuracy+15
        [21] = {{augment =  97, power = 14}}, -- Pet: Attack+15 Ranged Attack+15
        [22] = {{augment = 108, power =  6}}, -- Pet: Magic Acc.+7 "Magic Atk. Bonus"+7
        [23] = {{augment = 109, power =  1}}, -- Pet: "Double Attack"+2 Crit. hit rate +2
    },
    [2] = -- AMK
    {
        [ 1] = {{augment = 512, power = 3}, {augment = 326, power = 14}}, -- STR+4 Weapon Skill Accuracy +15
        [ 2] = {{augment = 513, power = 3}, {augment = 328, power =  1}}, -- DEX+4 Increases Critical Hit Damage (+2%)
        [ 3] = {{augment = 514, power = 3}, {augment = 286, power =  4}}, -- VIT+4 Shield Skill +5
        [ 4] = {{augment = 515, power = 3}, {augment = 327, power =  1}}, -- AGI+4 Increases weapon skill damage (+2%)
        [ 5] = {{augment = 516, power = 3}, {augment =  35, power =  1}}, -- INT+4 Magic Accuracy+2
        [ 6] = {{augment = 517, power = 3}, {augment = 329, power =  2}}, -- MND+4 "Cure" potency +3%
        [ 7] = {{augment = 518, power = 3}, {augment = 331, power =  1}}, -- CHR+4 "Waltz" ability delay -2
        [ 8] = {{augment = 512, power = 1}, {augment =  49, power =  1}}, -- STR+2 Haste +2%
        [ 9] = {{augment = 513, power = 1}, {augment =  49, power =  1}}, -- DEX+2 Haste +2%
        [10] = {{augment = 514, power = 1}, {augment =  49, power =  1}}, -- VIT+2 Haste +2%
        [11] = {{augment = 515, power = 1}, {augment =  49, power =  1}}, -- AGI+2 Haste +2%
        [12] = {{augment =  49, power = 2}, {augment = 211, power =  2}}, -- Haste+3% Enhances "Snapshot" effect (+3%)
        [13] = {{augment =  23, power = 9}, {augment =  25, power =  4}}, -- Accuracy+10 Attack+5
        [14] = {{augment =  27, power = 9}, {augment =  29, power =  4}}, -- Ranged Accuracy+10 Ranged Attack+5
        [15] = {{augment =  31, power = 9}, {augment = 142, power =  3}}, -- Evasion+10 Store TP +4
        [16] = {{augment = 133, power = 1}, {augment =  51, power =  2}}, -- "Magic Attack Bonus"+2 HP recovered while healing +3
        [17] = {{augment =  35, power = 2}, {augment =  52, power =  2}}, -- Magic Accuracy+3 MP recovered while healing +3
        [18] = {{augment =  55, power = 1}, {augment =  39, power =  3}}, -- Magic damage taken -2% Enmity+4
        [19] = {{augment =  57, power = 9}, {augment =  40, power =  3}}, -- Magic critical hit rate +10% Enmity-4
        [20] = {{augment = 516, power = 1}, {augment = 140, power =  1}}, -- INT+2 Enhances "Fast Cast" effect (+2%)
        [21] = {{augment = 517, power = 1}, {augment = 140, power =  1}}, -- MND+2 Enhances "Fast Cast" effect (+2%)
        [22] = {{augment = 518, power = 1}, {augment = 140, power =  1}}, -- CHR+2 Enhances "Fast Cast" effect (+2%)
        [23] = {{augment = 140, power = 2}, {augment = 320, power =  2}}, -- Enhances "Fast Cast" effect (+3%) "Blood Pact" ability delay -3
        [24] = {{augment =  23, power = 2}, {augment = 102, power =  2}}, -- Accuracy+3 Pet: Critical Hit Rate +3%
        [25] = {{augment =  25, power = 2}, {augment = 110, power =  0}}, -- Attack+3 Pet: Adds "Regen" effect
        [26] = {{augment =  25, power = 2}, {augment = 112, power =  9}}, -- Attack+3 Pet: Damage taken -10%
        [27] = {{augment =  23, power = 2}, {augment = 111, power =  4}}, -- Accuracy+3 Pet: Haste +5%
    },
    [3] = -- ASA
    {
        [ 1] = {{augment =    1, power = 24}, {augment = 39, power =  3}}, -- HP+25 Enmity+4
        [ 2] = {{augment =    9, power = 24}, {augment = 40, power =  3}}, -- MP+25 Enmity-4
        [ 3] = {{augment =   23, power =  6}}, -- Attack+7
        [ 4] = {{augment =   25, power =  6}}, -- Accuracy+7
        [ 5] = {{augment =   27, power =  6}}, -- Ranged Accuracy+7
        [ 6] = {{augment =   29, power =  6}}, -- Ranged Attack+7
        [ 7] = {{augment =   31, power =  6}}, -- Evasion+7
        [ 8] = {{augment =   35, power =  3}}, -- Magic Accuracy+4
        [ 9] = {{augment =  133, power =  3}}, -- "Magic Atk. Bonus" +4
        [10] = {{augment =   49, power =  2}}, -- Haste +3%
        [11] = {{augment =  143, power =  1}}, -- "Double Attack" +2%
        [12] = {{augment =  328, power =  2}}, -- Increases Critical Hit Damage +3%
        [13] = {{augment =  332, power =  4}}, -- Skillchain damage +5%
        [14] = {{augment =  333, power =  4}}, -- "Conserve TP"+5
        [15] = {{augment =   54, power =  3}}, -- Physical damage taken -4%
        [16] = {{augment =  335, power =  9}}, -- Magic Critical Hit damage +10%
        [17] = {{augment =  334, power =  9}}, -- Magic Burst damage +10%
        [18] = {{augment =  194, power =  4}}, -- "Kick Attacks" +5
        [19] = {{augment =  329, power =  4}}, -- "Cure" potency +5%
        [20] = {{augment =  336, power =  4}}, -- "Sic" & "Ready" ability delay -5
        [21] = {{augment =  337, power =  2}}, -- Song Recast Delay -3
        [22] = {{augment =  338, power =  0}}, -- "Barrage" +1
        [23] = {{augment =  339, power = 19}}, -- "Elemental Siphon" +20
        [24] = {{augment =  340, power =  4}}, -- "Phantom Roll" ability delay -5
        [25] = {{augment =  341, power =  9}}, -- "Repair" potency +10%
        [26] = {{augment =  342, power =  4}}, -- "Waltz" TP cost -50
        [27] = {{augment =   96, power =  6}}, -- Pet: Accuracy +7 Ranged Accuracy +7
        [28] = {{augment =   97, power =  6}}, -- Pet: Attack +7 Ranged Attack +7
        [29] = {{augment =  115, power =  7}, {augment = 116, power =  7}}, -- Pet: "Store TP" +8 "Subtle Blow" +8
        [30] = {{augment =  100, power =  6}}, -- Pet: Magic Accuracy +7
        [31] = {{augment =  913, power =  2}}, -- Movement Speed +8%
        [32] = {{augment =  195, power =  4}}, -- "Subtle Blow"+5
    },
}

-- No good data on augments.  Just pulled from each key on: https://ffxiclopedia.fandom.com/wiki/Treasure_Coffer_(Tenshodo)
local prizes =
{
    [tpz.ki.CRIMSON_KEY] =
    {
        {cutoff =   70, itemId = 13206, augments = {{9, 0,  5}, {516, 0, 1}, {517, 0, 1}, {518, 0, 1}, { 32, 0, 1}, { 96, 0, 1}}}, -- Gold Obi
        {cutoff =   80, itemId = 13445, augments = {{9, 0,  8}, {516, 0, 1}, {517, 0, 1}, {518, 0, 2}, { 39, 0, 1}, { 35, 0, 2}}}, -- Gold Ring
        {cutoff =  186, itemId = 13446, augments = {{1, 0, 15}, { 13, 0, 2}, { 25, 0, 5}, { 31, 0, 1}, {195, 0, 1}, { 35, 0, 1}}}, -- Mythril Ring
        {cutoff =  276, itemId = 13643, augments = {{9, 0,  5}, {516, 0, 1}, {517, 0, 1}, {518, 0, 1}, {100, 0, 1}, { 39, 0, 1}}}, -- Sarcenet Cape
        {cutoff =  351, itemId = 13196, augments = {{1, 0,  5}, { 23, 0, 1}, { 27, 0, 1}, {512, 0, 1}, {520, 0, 1}, {515, 0, 1}}}, -- Silver Belt
        {cutoff =  460, itemId = 13571, augments = {{1, 0,  5}, { 25, 0, 3}, { 29, 0, 3}, {512, 0, 0}, {769, 0, 2}, { 32, 0, 2}}}, -- Wolf Mantle
        {cutoff =  468, itemId =   694}, -- Chestnut Log
        {cutoff =  471, itemId =   887}, -- Coral Fragment
        {cutoff =  476, itemId =  4903}, -- Dark Spirit Pact
        {cutoff =  479, itemId =   654}, -- Darksteel Ingot
        {cutoff =  500, itemId =   645}, -- Darksteel Ore
        {cutoff =  523, itemId =  4868}, -- Scroll of Dispel
        {cutoff =  619, itemId =  4145}, -- Elixir
        {cutoff =  668, itemId =   690}, -- Elm Log
        {cutoff =  699, itemId =  4751}, -- Scroll of Erase
        {cutoff =  702, itemId =  4116}, -- Hi-Potion
        {cutoff =  723, itemId =   651}, -- Iron Ingot
        {cutoff =  775, itemId =   643}, -- Iron Ore
        {cutoff =  785, itemId =  4902}, -- Light Spirit Pact
        {cutoff =  821, itemId =  5070}, -- Scroll of Magic Finale
        {cutoff =  824, itemId =   691}, -- Maple Log
        {cutoff =  858, itemId =   653}, -- Mythril Ingot
        {cutoff =  879, itemId =   644}, -- Mythril Ore
        {cutoff =  884, itemId =  4113}, -- Potion +1
        {cutoff =  923, itemId =   744}, -- Silver Ingot
        {cutoff =  949, itemId =   736}, -- Silver Ore
        {cutoff =  993, itemId =   652}, -- Steel Ingot
        {cutoff = 1003, itemId =  4947}, -- Scroll of Utsusemi: Ni
    },
    [tpz.ki.VIRIDIAN_KEY] =
    {
        {cutoff =   65, itemId = 13639, augments = {{ 9, 0, 19}, {  1, 0, 19}, { 40, 0,  1}, {771, 0, 6}, {768, 0,  6}, { 34, 2, 3}}}, -- Aurora Mantle
        {cutoff =  142, itemId = 13271, augments = {{23, 0,  2}, { 31, 0,  1}, {  9, 0, 13}, { 26, 0, 1}, {  1, 0, 12}, { 49, 0, 2}}}, -- Corsette
        {cutoff =  237, itemId = 12364, augments = {{ 9, 0,  9}, {517, 0,  0}, {516, 0,  0}, {512, 0, 0}, {518, 0,  0}, { 35, 0, 1}}}, -- Nymph Shield
        {cutoff =  356, itemId = 13570, augments = {{ 5, 0,  5}, { 13, 0, 10}, {515, 0,  0}, {513, 0, 0}, { 23, 0,  3}, { 27, 0, 3}}}, -- Ram Mantle
        {cutoff =  457, itemId = 13198, augments = {{ 1, 0,  4}, {512, 0,  1}, {513, 0,  1}, {514, 0, 0}, { 24, 0,  2}, { 29, 0, 3}}}, -- Swordbelt
        {cutoff =  463, itemId = 13207, augments = {{ 1, 0,  3}, {  9, 0, 11}, { 35, 0,  2}, {290, 0, 2}, { 50, 0,  1}, {100, 0, 2}}}, -- Brocade Obi
        {cutoff =  469, itemId =   793}, -- Black Pearl
        {cutoff =  497, itemId =   775}, -- Black Rock
        {cutoff =  515, itemId =   770}, -- Blue Rock
        {cutoff =  616, itemId =  4145}, -- Elixir
        {cutoff =  670, itemId =  4129}, -- Ether +1
        {cutoff =  676, itemId =   790}, -- Garnet
        {cutoff =  672, itemId =   808}, -- Goshenite
        {cutoff =  684, itemId =   772}, -- Green Rock
        {cutoff =  775, itemId =   699}, -- Oak Log
        {cutoff =  811, itemId =   792}, -- Pearl
        {cutoff =  829, itemId =   788}, -- Peridot
        {cutoff =  835, itemId =   738}, -- Platinum Ore
        {cutoff =  871, itemId =  4113}, -- Potion +1
        {cutoff =  877, itemId =   774}, -- Purple Rock
        {cutoff =  901, itemId =   769}, -- Red Rock
        {cutoff =  984, itemId =   701}, -- Rosewood Log
        {cutoff = 1008, itemId =   815}, -- Sphene
        {cutoff = 1020, itemId =   773}, -- Translucent Rock
        {cutoff = 1032, itemId =   776}, -- White Rock
        {cutoff = 1044, itemId =   771}, -- Yellow Rock
        {cutoff = 1056, itemId =   798}, -- Turquoise
    },
    [tpz.ki.AMBER_KEY] =
    {
        {cutoff = 111, itemId = 16263, augments = {{  9, 0, 12}, { 35, 0,  1}, {516, 0, 1}, {518, 0, 1}, {517, 0, 1}, { 97, 0, 4}, { 39, 0, 1}}}, -- Beak Necklace
        {cutoff = 219, itemId = 13207, augments = {{  1, 0, 11}, {  9, 0, 11}, { 35, 0, 2}, {290, 0, 2}, { 50, 0, 0}, {100, 0, 2}             }}, -- Brocade Obi
        {cutoff = 334, itemId = 13091, augments = {{513, 0,  0}, {512, 0,  2}, { 25, 0, 6}, { 29, 0, 6}, {142, 0, 1}, { 24, 0, 3}, {773, 0, 5}}}, -- Carapace Gorget
        {cutoff = 436, itemId = 13445, augments = {{  9, 0, 13}, {517, 0,  1}, { 35, 0, 2}, { 39, 0, 1}, {516, 0, 1}, {518, 0, 1}             }}, -- Gold Ring
        {cutoff = 561, itemId = 13593, augments = {{  1, 0, 29}, {513, 0,  1}, {520, 0, 1}, {515, 0, 2}, {514, 0, 2}, { 39, 0, 1}, {772, 0, 5}}}, -- Raptor Mantle
        {cutoff = 564, itemId =   887}, -- Coral Fragment
        {cutoff = 576, itemId =   645}, -- Darksteel Ore
        {cutoff = 599, itemId =   902}, -- Demon Horn
        {cutoff = 616, itemId =   702}, -- Ebony Log
        {cutoff = 625, itemId =   737}, -- Gold Ore
        {cutoff = 683, itemId =  4144}, -- Hi-Elixer
        {cutoff = 730, itemId =  4132}, -- Hi-Ether
        {cutoff = 771, itemId =  4116}, -- Hi-Potion
        {cutoff = 788, itemId =   700}, -- Mahogany Log
        {cutoff = 805, itemId =  1116}, -- Manticore Hide
        {cutoff = 807, itemId =   703}, -- Petrified Log
        {cutoff = 809, itemId =   738}, -- Platinum Ore
        {cutoff = 818, itemId =   644}, -- Mythril Ore
        {cutoff = 835, itemId =   895}, -- Ram Horn
        {cutoff = 876, itemId =   859}, -- Ram Skin
        {cutoff = 885, itemId =  4621}, -- Scroll of Raise II
        {cutoff = 920, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 946, itemId =   866}, -- Wyvern Scales
        {cutoff = 961, itemId =  1122}, -- Wyvern Skin
    },
    [tpz.ki.AZURE_KEY] =
    {
        {cutoff = 106, itemId = 13597, augments = {{512, 0,  1}, {513, 0,  1}, { 26, 0, 5}, { 23, 0, 6}, { 31, 0, 6}, {195, 0, 1}}}, -- Beak Mantle
        {cutoff = 203, itemId = 13092, augments = {{515, 0,  3}, { 23, 0,  7}, { 27, 0, 7}, { 30, 0, 3}, {195, 0, 1}, {771, 0, 3}}}, -- Coeurl Gorget
        {cutoff = 305, itemId = 13447, augments = {{  1, 0,  9}, {512, 0,  1}, {513, 0, 1}, {514, 0, 1}, { 26, 0, 2}, { 23, 0, 2}}}, -- Platinum Ring
        {cutoff = 386, itemId = 13208, augments = {{  9, 0, 19}, {516, 0,  4}, {517, 0, 4}, {518, 0, 4}, { 36, 0, 2}, { 52, 0, 2}}}, -- Rainbow Obi
        {cutoff = 490, itemId = 13125, augments = {{  5, 0, 13}, {  9, 0, 12}, {515, 0, 2}, {516, 0, 1}, {517, 0, 1}, {518, 0, 1}}}, -- Torque
        {cutoff = 498, itemId =   791}, -- Aquamarine
        {cutoff = 502, itemId =   801}, -- Chrysoberyl
        {cutoff = 536, itemId =   654}, -- Darksteel Ingot
        {cutoff = 612, itemId =   645}, -- Darksteel Ore
        {cutoff = 659, itemId =   702}, -- Ebony Log
        {cutoff = 693, itemId =   745}, -- Gold Ingot
        {cutoff = 786, itemId =  4144}, -- Hi-Elixir
        {cutoff = 789, itemId =  4133}, -- Hi-Ether +1
        {cutoff = 831, itemId =  4117}, -- Hi-Potion +1
        {cutoff = 835, itemId =   784}, -- Jadeite
        {cutoff = 856, itemId =   700}, -- Mahogany Log
        {cutoff = 907, itemId =   653}, -- Mythril Ingot
        {cutoff = 911, itemId =   895}, -- Ram Horn
        {cutoff = 915, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 948, itemId =   652}, -- Steel Ingot
        {cutoff = 956, itemId =   803}, -- Sunstone
        {cutoff = 960, itemId =   866}, -- Wyvern Scales
    },
    [tpz.ki.IVORY_KEY] =
    {
        {cutoff =   62, itemId = 13357, augments = {{518, 0, 1}, { 40, 0, 1}, {  1, 0,  9}, {  9, 0, 9}, {105, 0, 1}, {106, 0, 0}, {34, 0, 3}}}, -- Angels Earring
        {cutoff =   70, itemId = 13356, augments = {{ 33, 0, 3}, { 39, 0, 1}, {  1, 0,  9}, {  9, 0, 9}, {104, 0, 1}, {521, 0, 1}            }}, -- Death Earring
        {cutoff =  113, itemId = 13353, augments = {{516, 0, 1}, {515, 0, 0}, {133, 0,  1}, {  9, 0, 5}, { 36, 0, 0}, {101, 0, 1}            }}, -- Diamond Earring
        {cutoff =  196, itemId = 13351, augments = {{515, 0, 1}, { 31, 0, 4}, { 98, 0,  4}, { 27, 0, 2}, {514, 0, 0}, { 30, 0, 1}            }}, -- Emerald Earring
        {cutoff =  301, itemId = 13352, augments = {{ 25, 0, 4}, {516, 0, 0}, { 97, 0,  4}, { 29, 0, 4}, {512, 0, 1}, { 24, 0, 2}            }}, -- Ruby Earring
        {cutoff =  392, itemId = 13355, augments = {{ 35, 0, 1}, {517, 0, 1}, {  9, 0,  5}, {100, 0, 1}, {512, 0, 0}, {  5, 0, 6}            }}, -- Sapphire Earring
        {cutoff =  478, itemId = 13354, augments = {{ 23, 0, 2}, {513, 0, 1}, {517, 0,  0}, { 96, 0, 2}, {142, 0, 0}, {195, 0, 1}, {26, 0, 4}}}, -- Spinel Earring
        {cutoff =  497, itemId = 13318, augments = {{ 33, 0, 4}, {513, 0, 0}, {  1, 0, 19}, { 99, 0, 4}, {514, 0, 1}, { 32, 0, 2}            }}, -- Topaz Earring
        {cutoff =  546, itemId =  1110}, -- Beetle Blood
        {cutoff =  602, itemId =   823}, -- Gold Thread
        {cutoff =  627, itemId =  1465}, -- Granite
        {cutoff =  658, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  901, itemId =  4118}, -- Hi-Potion +2
        {cutoff =  963, itemId =   837}, -- Malboro Fiber
        {cutoff =  982, itemId =   924}, -- Philosophers Stone
        {cutoff = 1019, itemId =   844}, -- Phoenix Feather
        {cutoff = 1062, itemId =   830}, -- Rainbow Cloth
        {cutoff = 1124, itemId =  1132}, -- Raxa
        {cutoff = 1172, itemId =  4174}, -- Vile Elixir
    },
    [tpz.ki.EBON_KEY] =
    {
        {cutoff =  31, itemId = 13463, augments = {{783, 0, 29}, { 40, 0, 1}, {  1, 0, 19}, {518, 0, 0}, { 23, 1, 5}, { 96, 0, 3}                                      }}, -- Angels Ring
        {cutoff =  82, itemId = 13462, augments = {{782, 0, 29}, {525, 0, 2}, {  9, 0, 19}, { 33, 0, 6}, { 31, 0, 4}, { 39, 0, 0}                                      }}, -- Death Ring
        {cutoff = 174, itemId = 13450, augments = {{776, 0, 29}, {519, 0, 4}, {  9, 0,  9}, {515, 0, 2}, {516, 0, 0}, {517, 0, 1}                                      }}, -- Diamond Ring
        {cutoff = 225, itemId = 13448, augments = {{777, 0, 29}, {523, 0, 4}, {  1, 0,  8}, {512, 0, 1}, {514, 0, 2}, {515, 0, 0}                                      }}, -- Emerald Ring
        {cutoff = 296, itemId = 13449, augments = {{781, 0, 29}, {524, 0, 1}, {  1, 0,  9}, {512, 0, 0}, {513, 0, 1}, {516, 0, 2}                                      }}, -- Ruby Ring
        {cutoff = 357, itemId = 13452, augments = {{780, 0, 29}, {  9, 0, 9}, {519, 0,  2}, {520, 0, 3}, {517, 0, 0}, {518, 0, 2}                                      }}, -- Sapphire Ring
        {cutoff = 459, itemId = 13451, augments = {{779, 0, 29}, {  1, 0, 9}, {513, 0,  0}, {521, 0, 0}, {515, 0, 1}, {517, 0, 2}, { 23, 0, 0}, {195, 0, 1}, {96, 0, 1}}}, -- Spinel Ring
        {cutoff = 500, itemId = 13453, augments = {{778, 0, 29}, {522, 0, 5}, {771, 0,  8}, {  1, 0, 9}, {513, 0, 1}, {514, 0, 0}, {516, 0, 2}                         }}, -- Topaz Ring
        {cutoff = 510, itemId =   655}, -- Adaman Ingot
        {cutoff = 541, itemId =   813}, -- Angelstone
        {cutoff = 561, itemId =   645}, -- Darksteel Ore
        {cutoff = 592, itemId =   812}, -- Deathstone
        {cutoff = 633, itemId =   787}, -- Diamond
        {cutoff = 643, itemId =   785}, -- Emerald
        {cutoff = 714, itemId =  4135}, -- Hi-Ether +3
        {cutoff = 785, itemId =  4119}, -- Hi-Potion +3
        {cutoff = 805, itemId =   739}, -- Orichalcum Ore
        {cutoff = 815, itemId =   738}, -- Platinum Ore
        {cutoff = 835, itemId =   786}, -- Ruby
        {cutoff = 855, itemId =   794}, -- Sapphire
        {cutoff = 896, itemId =  4613}, -- Scroll of Cure V
        {cutoff = 916, itemId =  4659}, -- Scroll of Shell IV
        {cutoff = 936, itemId =  4774}, -- Scroll of Thunder III
        {cutoff = 987, itemId =  4174}, -- Vile Elixir
        {cutoff = 997, itemId =  4748}, -- Scroll of Raise III
    },
    [tpz.ki.WHITE_CORAL_KEY] =
    {
        {cutoff =   31, itemId = 12433}, -- Brass Mask
        {cutoff =  109, itemId = 12986}, -- Chestnut Sabots
        {cutoff =  218, itemId = 12721}, -- Cotton Gloves
        {cutoff =  296, itemId = 12826}, -- Studded Trousers
        {cutoff =  437, itemId = 12602}, -- Wool Robe
        {cutoff =  468, itemId =   694}, -- Chestnut Log
        {cutoff =  499, itemId =   645}, -- Darksteel Ore
        {cutoff =  624, itemId =  4145}, -- Elixir
        {cutoff =  655, itemId =   690}, -- Elm Log
        {cutoff =  686, itemId =   643}, -- Iron Ore
        {cutoff =  717, itemId =   651}, -- Iron Ingot
        {cutoff =  764, itemId =   653}, -- Mythril Ingot
        {cutoff =  780, itemId =   644}, -- Mythril Ore
        {cutoff =  843, itemId =   744}, -- Silver Ingot
        {cutoff =  874, itemId =   736}, -- Silver Ore
        {cutoff =  937, itemId =   652}, -- Steel Ingot
        {cutoff =  968, itemId =  4868}, -- Scroll of Dispel
        {cutoff =  999, itemId =  5070}, -- Scroll of Magic Finale
        {cutoff = 1015, itemId =  4947}, -- Scroll of Utsusemi: Ni
        {cutoff = 1031, itemId =  4751}, -- Scroll of Erase
    },
    [tpz.ki.BLUE_CORAL_KEY] =
    {
        {cutoff =   42, itemId = 12571}, -- Cuir Bouilli
        {cutoff =  250, itemId = 14118}, -- Iron Greaves
        {cutoff =  292, itemId = 12866}, -- Linen Slacks
        {cutoff =  375, itemId = 12450}, -- Padded Cap
        {cutoff =  458, itemId = 12731}, -- Velvet Cuffs
        {cutoff =  500, itemId =   793}, -- Black Pearl
        {cutoff =  583, itemId =  4145}, -- Elixir
        {cutoff =  625, itemId =  4129}, -- Ether +1
        {cutoff =  667, itemId =   790}, -- Garnet
        {cutoff =  709, itemId =   788}, -- Peridot
        {cutoff =  751, itemId =  4113}, -- Potion +1
        {cutoff =  876, itemId =   699}, -- Oak Log
        {cutoff =  918, itemId =   830}, -- Rainbow Cloth
        {cutoff =  960, itemId =   769}, -- Red Rock
        {cutoff = 1002, itemId =   798}, -- Turquoise
    },
    [tpz.ki.PEACH_CORAL_KEY] =
    {
        {cutoff =   66, itemId = 13712}, -- Carapace Harness
        {cutoff =  198, itemId = 12956}, -- Raptor Ledelsens
        {cutoff =  303, itemId = 12476}, -- Silk Hat
        {cutoff =  395, itemId = 14003}, -- Steel Finger Gauntlets
        {cutoff =  487, itemId = 12867}, -- White Slacks
        {cutoff =  500, itemId =   645}, -- Darksteel Ore
        {cutoff =  526, itemId =   902}, -- Demon Horn
        {cutoff =  565, itemId =   702}, -- Ebony Log
        {cutoff =  591, itemId =   737}, -- Gold Ore
        {cutoff =  696, itemId =  4144}, -- Hi-Elixer
        {cutoff =  747, itemId =  4132}, -- Hi-Ether
        {cutoff =  773, itemId =  4116}, -- Hi-Potion
        {cutoff =  786, itemId =   700}, -- Mahogany Log
        {cutoff =  839, itemId =  1116}, -- Manticore Hide
        {cutoff =  852, itemId =   644}, -- Mythril Ore
        {cutoff =  891, itemId =   703}, -- Petrified Log
        {cutoff =  930, itemId =  4621}, -- Scroll of Raise II
        {cutoff =  969, itemId =   738}, -- Platinum Ore
        {cutoff = 1008, itemId =   895}, -- Ram Horn
        {cutoff = 1021, itemId =   859}, -- Ram Skin
        {cutoff = 1074, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 1087, itemId =   866}, -- Wyvern Scales
        {cutoff = 1103, itemId =  1122}, -- Wyvern Skin
    },
    [tpz.ki.BLACK_CORAL_KEY] =
    {
        {cutoff =   90, itemId = 13698}, -- Beak Helm
        {cutoff =  194, itemId = 12988}, -- Pigaches
        {cutoff =  224, itemId = 12811}, -- Darksteel Breeches
        {cutoff =  433, itemId = 12707}, -- Scorpion Mitts
        {cutoff =  552, itemId = 12604}, -- Silk Coat
        {cutoff =  597, itemId =   645}, -- Darksteel Ore
        {cutoff =  612, itemId =   654}, -- Darksteel Ingot
        {cutoff =  642, itemId =   745}, -- Gold Ingot
        {cutoff =  776, itemId =  4144}, -- Hi-Elixer
        {cutoff =  821, itemId =  4133}, -- Hi-Ether +1
        {cutoff =  851, itemId =  4117}, -- Hi-Potion +1
        {cutoff =  866, itemId =   700}, -- Mahogany Log
        {cutoff =  881, itemId =   653}, -- Mythril Ingot
        {cutoff =  896, itemId =   797}, -- Painite
        {cutoff = 1000, itemId =   652}, -- Steel Ingot
        {cutoff = 1015, itemId =   805}, -- Zircon
    },
    [tpz.ki.RED_CORAL_KEY] =
    {
        {cutoff =  109, itemId = 16289}, -- Alloy Torque
        {cutoff =  200, itemId = 16288}, -- Aureate Necklace
        {cutoff =  273, itemId = 16290}, -- Burly Gorget
        {cutoff =  382, itemId = 16286}, -- Nitid Choker
        {cutoff =  473, itemId = 16287}, -- Pneuma Collar
        {cutoff =  528, itemId =  1110}, -- Beetle Blood
        {cutoff =  619, itemId =   823}, -- Gold Thread
        {cutoff =  692, itemId =  1465}, -- Granite
        {cutoff =  728, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  764, itemId =   837}, -- Malboro Fiber
        {cutoff =  782, itemId =   924}, -- Philosophers Stone
        {cutoff =  800, itemId =   844}, -- Phoenix Feather
        {cutoff =  836, itemId =   830}, -- Rainbow Cloth
        {cutoff =  872, itemId =  1132}, -- Raxa
        {cutoff =  999, itemId =  4174}, -- Vile Elixir
        {cutoff = 1017, itemId =  4517}, -- Yellow Curry
    },
    [tpz.ki.ANGEL_SKIN_KEY] =
    {
        {cutoff =   65, itemId = 16254}, -- Altius Mantle
        {cutoff =  162, itemId = 16253}, -- Chiffon Cape
        {cutoff =  243, itemId = 16255}, -- Cortege Cape
        {cutoff =  356, itemId = 16252}, -- Resilient Mantle
        {cutoff =  437, itemId = 16256}, -- Rugged Mantle
        {cutoff =  469, itemId =   646}, -- Adaman Ore
        {cutoff =  501, itemId =   813}, -- Angelstone
        {cutoff =  517, itemId =   645}, -- Darksteel Ore
        {cutoff =  582, itemId =   812}, -- Deathstone
        {cutoff =  614, itemId =   787}, -- Diamond
        {cutoff =  646, itemId =   785}, -- Emerald
        {cutoff =  662, itemId =  4135}, -- Hi-Ether +3
        {cutoff =  694, itemId =  4119}, -- Hi-Potion +3
        {cutoff =  742, itemId =   739}, -- Orichalcum Ore
        {cutoff =  790, itemId =   786}, -- Ruby
        {cutoff =  822, itemId =  4613}, -- Scroll of Cure V
        {cutoff =  855, itemId =  4659}, -- Scroll of Shell IV
        {cutoff =  888, itemId =   804}, -- Spinel
        {cutoff = 1021, itemId =  4174}, -- Vile Elixir
        {cutoff = 1037, itemId =  4774}, -- Scroll of Thunder III
        {cutoff = 1047, itemId =  4748}, -- Scroll of Raise III
    },
    [tpz.ki.MOOGLE_KEY] =
    {
        {cutoff =  167, itemId = 12442, augments = {{23, 0,  0}, {769, 0, 1}                         }}, -- Studded Bandana
        {cutoff =  374, itemId = 13209, augments = {{ 9, 0,  3}, {551, 0, 0}, {770, 0, 0}            }}, -- Chain Belt
        {cutoff =  707, itemId = 13083, augments = {{ 9, 0, 11}, {775, 0, 2}, { 40, 0, 0}, {53, 0, 0}}}, -- Chain Choker
        {cutoff =  874, itemId =  4751}, -- Scroll of Erase
        {cutoff = 1041, itemId =   653}, -- Mythril Ingot
        {cutoff = 1100, itemId =   744}, -- Silver Ingot
    },
    [tpz.ki.BIRD_KEY] =
    {
        {cutoff = 143, itemId = 12987, augments = {{ 39, 0, 3}, {774, 0, 2}, { 53, 0, 2}, { 35, 0, 0}, { 9, 0, 1}, {518, 0, 0}}}, -- Ebony Sabots
        {cutoff = 393, itemId = 13783, augments = {{  1, 0, 9}, { 51, 0, 2}, {512, 0, 1}, {520, 0, 3}, {25, 0, 5}, { 97, 0, 2}}}, -- Iron Scale Mail
        {cutoff = 536, itemId = 12293, augments = {{  9, 0, 3}, {768, 0, 3}, { 35, 0, 0}, {329, 0, 0}, {96, 0, 2}, {521, 0, 0}}}, -- Oak Shield
        {cutoff = 653, itemId = 13200, augments = {{188, 0, 1}, {185, 0, 0}, {512, 0, 0}, { 25, 0, 3}, {32, 0, 5}             }}, -- Waistbelt
        {cutoff = 663, itemId =   793}, -- Black Pearl
        {cutoff = 678, itemId =   770}, -- Blue Rock
        {cutoff = 770, itemId =  4145}, -- Elixir
        {cutoff = 801, itemId =  4129}, -- Ether +1
        {cutoff = 816, itemId =   808}, -- Goshenite
        {cutoff = 847, itemId =   699}, -- Oak Log
        {cutoff = 852, itemId =   792}, -- Pearl
        {cutoff = 862, itemId =   788}, -- Peridot
        {cutoff = 871, itemId =  4113}, -- Potion +1
        {cutoff = 922, itemId =   701}, -- Rosewood Log
        {cutoff = 927, itemId =   815}, -- Sphene
        {cutoff = 947, itemId =   773}, -- Translucent Rock
        {cutoff = 957, itemId =   776}, -- White Rock
        {cutoff = 967, itemId =   771}, -- Yellow Rock
        {cutoff = 972, itemId =   774}, -- Purple Rock
    },
    [tpz.ki.CACTUAR_KEY] =
    {
        {cutoff = 109, itemId = 13111, augments = {{512, 0, 1}, {513, 0, 1}, { 50, 0, 3}, {  1, 0, 4}, {115, 0, 1}, {773, 0, 1}}}, -- Nodowa
        {cutoff = 196, itemId = 12604, augments = {{516, 0, 3}, {517, 0, 3}, {518, 0, 3}, {110, 0, 0}, {179, 0, 1}, { 36, 0, 2}}}, -- Silk Coat
        {cutoff = 305, itemId = 13981, augments = {{518, 0, 1}, {520, 0, 2}, { 25, 0, 2}, { 23, 0, 1}, {178, 0, 1}, {187, 0, 0}}}, -- Turtle Bangles
        {cutoff = 370, itemId = 13711, augments = {{517, 0, 1}, {  1, 0, 5}, { 27, 0, 4}, { 30, 0, 3}, {770, 0, 4}             }}, -- Carapace Mask
        {cutoff = 435, itemId =  4132}, -- Hi-Ether
        {cutoff = 544, itemId =  4144}, -- Hi-Elixer
        {cutoff = 609, itemId =   645}, -- Darksteel Ore
        {cutoff = 631, itemId =   737}, -- Gold Ore
        {cutoff = 674, itemId =  4719}, -- Scroll of Regen III
        {cutoff = 696, itemId =  4621}, -- Scroll of Raise II
        {cutoff = 718, itemId =   738}, -- Platinum Ore
        {cutoff = 761, itemId =   866}, -- Wyvern Scales
        {cutoff = 804, itemId =   702}, -- Ebony Log
        {cutoff = 847, itemId =   902}, -- Demon Horn
        {cutoff = 869, itemId =   703}, -- Petrified Log
        {cutoff = 891, itemId =  1116}, -- Manticore Hide
        {cutoff = 913, itemId =   895}, -- Ram Horn
        {cutoff = 935, itemId =   859}, -- Ram Skin
    },
    [tpz.ki.BOMB_KEY] =
    {
        {cutoff = 308, itemId = 12980, augments = {{34, 0, 5}, {  9, 0, 10}, {141, 0, 2}, { 40, 0, 1}, {104, 0, 1}}}, -- Battle Boots
        {cutoff = 462, itemId = 12860, augments = {{ 9, 0, 2}, {515, 0,  0}, {517, 0, 1}, { 29, 0, 2}, { 98, 0, 0}}}, -- Silk Slops
        {cutoff = 616, itemId = 13589, augments = {{ 1, 0, 4}, {515, 0,  0}, { 31, 0, 0}, {769, 0, 1}, { 55, 0, 0}}}, -- Tiger Mantle
        {cutoff = 693, itemId = 12427, augments = {{49, 0, 2}, { 24, 0,  0}, {180, 0, 0}, {100, 0, 0}             }}, -- Bascinet
        {cutoff = 747, itemId =  4144}, -- Hi-Elixer
        {cutoff = 824, itemId =   654}, -- Darksteel Ingot
        {cutoff = 901, itemId =   645}, -- Darksteel Ore
    },
    [tpz.ki.CHOCOBO_KEY] =
    {
        {cutoff =  190, itemId = 16008, augments = {{34, 0, 5}, { 35, 0, 1}, {141, 0, 2}, {53, 0, 4}, {294, 0, 0}, {293, 0, 1}, {291, 0, 1}, {295, 0, 0}, {290, 0, 1}, {299, 0, 1}, {13, 0, 25}, {296, 0, 1}, {298, 0, 2}, {292, 0, 0}}}, -- Aptus Earring
        {cutoff =  285, itemId = 16372, augments = {{44, 0, 2}, {188, 0, 3}, { 51, 0, 0}, { 1, 0, 7}, {774, 0, 6}, {783, 0, 5}                                                                                                        }}, -- Stearc Subligar
        {cutoff =  571, itemId = 16295, augments = {{23, 0, 4}, { 25, 0, 4}, { 27, 0, 3}, {29, 0, 3}, {259, 0, 0}, {267, 0, 2}, {262, 0, 0}, {260, 0, 0}, {264, 0, 4}, {266, 0, 0}, {282, 0, 2}, {281, 0, 4}, {257, 0, 4}, {  5, 0,24}}}, -- Varius Torque
        {cutoff =  595, itemId =   823}, -- Gold Thread
        {cutoff =  643, itemId =  4134}, -- Hi-Ether +2
        {cutoff =  714, itemId =  4118}, -- Hi-Potion +2
        {cutoff =  785, itemId =   837}, -- Malboro Fiber
        {cutoff =  856, itemId =  1110}, -- Beetle Blood
        {cutoff =  927, itemId =   924}, -- Philosophers Stone
        {cutoff =  995, itemId =   830}, -- Rainbow Cloth
        {cutoff = 1043, itemId =  1132}, -- Raxa
        {cutoff = 1067, itemId =  1465}, -- Granite
        {cutoff = 1115, itemId =  4174}, -- Vile Elixir
        {cutoff = 1186, itemId =   844}, -- Phoenix Feather
    },
    [tpz.ki.TONBERRY_KEY] =
    {
        {cutoff =  291, itemId = 15938, augments = {{516, 0, 5}, {517, 0,  4}, {518, 0, 4}, {35, 0, 3}, {39, 0, 2}, {53, 0, 2}}}, -- Esprit Belt
        {cutoff =  600, itemId = 15937, augments = {{ 49, 0, 4}, {512, 0,  2}, {513, 0, 2}, {195, 0, 4}, {31, 0, 4}, {24, 0, 9}}}, -- Fettle Belt
        {cutoff =  636, itemId =   813}, -- Angelstone
        {cutoff =  654, itemId =   812}, -- Deathstone
        {cutoff =  690, itemId =   645}, -- Darksteel Ore
        {cutoff =  708, itemId =   787}, -- Diamond
        {cutoff =  744, itemId =   785}, -- Emerald
        {cutoff =  780, itemId =   823}, -- Gold Thread
        {cutoff =  798, itemId =  4119}, -- Hi-Potion +3
        {cutoff =  816, itemId =   738}, -- Platinum Ore
        {cutoff =  834, itemId =   739}, -- Orichalcum Ore
        {cutoff =  870, itemId =   786}, -- Ruby
        {cutoff =  883, itemId =   794}, -- Sapphire
        {cutoff =  901, itemId =  4613}, -- Scroll of Cure V
        {cutoff =  919, itemId =  4748}, -- Scroll of Raise III
        {cutoff =  937, itemId =  4774}, -- Scroll of Thunder III
        {cutoff =  955, itemId =   804}, -- Spinel
        {cutoff =  973, itemId =   789}, -- Topaz
        {cutoff = 1082, itemId =  4174}, -- Vile Elixir
    },
}

local repeatableKeyItems = {
    tpz.keyItem.MOOGLE_KEY,
    tpz.keyItem.BIRD_KEY,
    tpz.keyItem.CACTUAR_KEY,
    tpz.keyItem.BOMB_KEY,
    tpz.keyItem.CHOCOBO_KEY,
    tpz.keyItem.TONBERRY_KEY,
    tpz.keyItem.CRIMSON_KEY,
    tpz.keyItem.VIRIDIAN_KEY,
    tpz.keyItem.AMBER_KEY,
    tpz.keyItem.AZURE_KEY,
    tpz.keyItem.IVORY_KEY,
    tpz.keyItem.EBON_KEY,
}

local function hasAnyKeyItems(player)
    for i,v in pairs(repeatableKeyItems) do
        if player:hasKeyItem(v) then
            return true
        end
    end
    return false
end

local function givePrize(player, ki)
    if not player:hasKeyItem(ki) then
        player:showText(player, ID.text.NO_KEY)
    else
        local p = prizes[ki]
        if p ~= nil then
            -- determine prize
            local prize = nil
            local roll = math.random(p[#p].cutoff)
            for i = 1, #p do
                if roll <= p[i].cutoff then
                    prize = p[i]
                    break
                end
            end

            -- determine augments
            local addAug = {}
            if prize.augments ~= nil then
                local pAug = prize.augments
                local alreadyRolled = {}
                for i = 1, 4 do
                    -- static 50% chance to get any augment at all each loop
                    if #addAug == 0 or math.random(1,2) == 1 then
                        -- since lua arrays start at index 1, set start at 1 to guarantee at least one augment
                        roll = math.random(1, #pAug)
                    else
                        roll = 0
                    end
                    local a = pAug[roll]
                    if a ~= nil and alreadyRolled[a[1]] == nil then
                        alreadyRolled[a[1]] = true
                        table.insert(addAug, a[1])
                        table.insert(addAug, math.random(a[2], a[3]))
                    end
                end
            end
            for i = #addAug, 7 do
                table.insert(addAug, 0)
            end

            -- give prize
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, prize.itemId)
            else
                player:addItem(prize.itemId, 1, unpack(addAug))
                player:messageSpecial(ID.text.ITEM_OBTAINED, prize.itemId)
                player:delKeyItem(ki)
            end
        end
    end
end

function scenarioArmor(player, option, giveToPlayer)
    local aug1 = 0
    local aug2 = 0
    local gear = 0
    local addon = 0

    -- if giveToPlayer then
    --     local selection = player:getCharVar("expansionSelect")
    --     if selection == 1 then -- ACP
    --         option = option - 8388615 -- extra bit passed when recieving armor
    --     elseif selection == 2 then -- AMK
    --     elseif selection == 3 then -- ASA
    --         option = option - 21 -- extra bit passed when recieving armor
    --     end
    -- end

    -- aug2 = bit.rshift(option, 16)                               -- 5 bits for 2nd selected augment
    -- aug1 = bit.rshift(option, 11) - (aug2 * 32)                 -- 5 bits for 1st selected augment
    -- gear = bit.rshift(option, 6)  - (aug2 * 1024) - (aug1 * 32) -- 5 bits for selected gear piece
    -- addon = optionToGear[gear].addon                            -- index of addon scenario the gear belongs to

    aug2 = bit.band(bit.rshift(option, 16), 31) -- 5 bits for 2nd selected augment
    aug1 = bit.band(bit.rshift(option, 11), 31) -- 5 bits for 1st selected augment
    gear = bit.band(bit.rshift(option, 6), 31)  -- 5 bits for selected gear piece
    addon = optionToGear[gear].addon            -- index of addon scenario the gear belongs to

    -- if not giveToPlayer then
    --     player:setCharVar("expansionSelect", addon)
    -- end

    local augment1 = optionToAugment[addon][aug1]
    local augment2 = optionToAugment[addon][aug2]

    local addAug = {}
    if giveToPlayer then
        -- Add each augment's ID and power
        for i = 1, #augment1 do
            table.insert(addAug, augment1[i].augment)
            table.insert(addAug, augment1[i].power)
        end
        for i = 1, #augment2 do
            table.insert(addAug, augment2[i].augment)
            table.insert(addAug, augment2[i].power)
        end

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, optionToGear[gear].itemid)
        else
            player:addItem(optionToGear[gear].itemid, 1, unpack(addAug))
            player:messageSpecial(ID.text.ITEM_OBTAINED, optionToGear[gear].itemid)
            player:delKeyItem(({tpz.ki.PRISMATIC_KEY,tpz.ki.OXBLOOD_KEY,tpz.ki.BEHEMOTH_KEY})[addon])
        end
    else
        -- Convert each augment's power and ID to binary (5 bits for power followed by 11 bits for ID)
        for i = 1, #augment1 do
            table.insert(addAug, string.format("%05i%011i", intToBinary(augment1[i].power), intToBinary(augment1[i].augment)))
        end
        for i = 1, #augment2 do
            table.insert(addAug, string.format("%05i%011i", intToBinary(augment2[i].power), intToBinary(augment2[i].augment)))
        end
        for i = #addAug, 5 do
            table.insert(addAug, "0000000000000000")
        end

        -- Each argument concats 2 different augments. For some reason, argument 1 contacts the string below.
        player:updateEvent(tonumber(addAug[1] .. "0000001100000010", 2), tonumber(addAug[2] .. addAug[3], 2), tonumber(addAug[4] .. addAug[5], 2))
    end

end

function intToBinary(x)
    local bin = ""
    while x > 1 do
        bin = tostring(x % 2) .. bin
        x = math.floor(x / 2)
    end
    bin = tostring(x) .. bin
    return bin
end

function onSpawn(npc)
    if ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA == 0 then
        npc:setStatus(tpz.status.DISAPPEAR)
    end
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local receivedNexusCape = player:getCharVar("receivedNexusCape")

    local arg1 =
        (not player:hasKeyItem(tpz.ki.CRIMSON_KEY)   and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.VIRIDIAN_KEY)  and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.AMBER_KEY)     and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.AZURE_KEY)     and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.IVORY_KEY)     and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.EBON_KEY)      and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.PRISMATIC_KEY) and 128 or 0)

    local arg2 =
        (not player:hasKeyItem(tpz.ki.WHITE_CORAL_KEY) and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.BLUE_CORAL_KEY)  and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.PEACH_CORAL_KEY) and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.BLACK_CORAL_KEY) and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.RED_CORAL_KEY)   and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.ANGEL_SKIN_KEY)  and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.OXBLOOD_KEY)     and 128 or 0)

    local arg3 =
        (not player:hasKeyItem(tpz.ki.MOOGLE_KEY)   and   2 or 0) +
        (not player:hasKeyItem(tpz.ki.BIRD_KEY)     and   4 or 0) +
        (not player:hasKeyItem(tpz.ki.CACTUAR_KEY)  and   8 or 0) +
        (not player:hasKeyItem(tpz.ki.BOMB_KEY)     and  16 or 0) +
        (not player:hasKeyItem(tpz.ki.CHOCOBO_KEY)  and  32 or 0) +
        (not player:hasKeyItem(tpz.ki.TONBERRY_KEY) and  64 or 0) +
        (not player:hasKeyItem(tpz.ki.BEHEMOTH_KEY) and 128 or 0)

    local arg4 =
        ((ENABLE_ACP == 0 or arg1 == 254) and 2 or 0) +
        ((ENABLE_AMK == 0 or arg2 == 254) and 4 or 0) +
        ((ENABLE_ASA == 0 or arg3 == 254) and 8 or 0) +
        ((ENABLE_ACP * ENABLE_AMK * ENABLE_ASA == 0 or receivedNexusCape == 1) and 16 or 0) +
        ((ENABLE_ACP * ENABLE_AMK * ENABLE_ASA == 0 or receivedNexusCape == 0) and 32 or 0)

    if not hasAnyKeyItems(player) and login_points.delPoints(player, 5) then
        local newKeyItem = repeatableKeyItems[math.random(1, #repeatableKeyItems)]
        player:addKeyItem(newKeyItem)
        player:messageSpecial(zones[player:getZoneID()].text.KEYITEM_OBTAINED, newKeyItem)
    else
        player:startEvent(10099, arg1, arg2, arg3, arg4, 0, 0, 0, 0)
    end
end

function onEventUpdate(player, csid, option)
    if csid == 10099 then
        if option >= 2048 and option < 16777216 then
            scenarioArmor(player, option, false)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 10099 then
        if option == 16777216 and player:getCharVar("receivedNexusCape") == 0 and npcUtil.giveItem(player, 11538) then
            player:setCharVar("receivedNexusCape", 1)
        elseif option == 33554432 or (option == 16777216 and player:getCharVar("receivedNexusCape") == 0) then
            player:addUsedItem(11538)
        elseif option >= 1 and option <= 20 then
            local ki = optionToKI[option]
            if ki ~= nil then
                givePrize(player, ki)
            end
        elseif option >= 2048 and option < 16777216 then
            scenarioArmor(player, option, true)
        end
    end
end
