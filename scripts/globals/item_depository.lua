--------------------------------------------------
-- Event Item Depository NPCs                   --
-- Author: Twilight                             --
-- (c) 2021 Wings open source project.          --
-- Licensed under GPLv3                        --
--------------------------------------------------

require('scripts/globals/zone')
require('scripts/globals/status')

-- Parameter 1: Furnishings 1
-- Parameter 2: Weapons and shields
-- Parameter 3: Armor - Head
-- Parameter 4: Armor - Body, Legs, Feet
-- Parameter 5: Player's gil
-- Parameter 6: Furnishings 2

-- Choice is the event option used when attempting to
-- retrieve an item back.
local itemDepoChoiceToBit = {
      [0]={0, 0x00000001}, -- San d'Orian holiday tree
      [1]={0, 0x00000002}, -- Bastokan holiday tree
      [2]={0, 0x00000004}, -- Windurstian holiday tree
      [3]={0, 0x00000008}, -- Kadomatsu
      [4]={0, 0x00000010}, -- Wing egg
      [5]={0, 0x00000020}, -- Lamp egg
      [6]={0, 0x00000040}, -- Flower egg
      [7]={0, 0x00000080}, -- Adventuring certificate
      [8]={0, 0x00000100}, -- Timepiece
      [9]={0, 0x00000200}, -- Miniature airship
     [10]={0, 0x00000400}, -- Pumpkin lantern
     [11]={0, 0x00000800}, -- Bomb lantern
     [12]={0, 0x00001000}, -- Mandragora lantern
     [13]={0, 0x00002000}, -- Dream platter
     [14]={0, 0x00004000}, -- Dream coffer
     [15]={0, 0x00008000}, -- Dream stocking
     [16]={1, 0x00000001}, -- Chocobo wand
     [17]={1, 0x00000002}, -- Trick staff
     [18]={1, 0x00000004}, -- Treat staff
     [19]={1, 0x00000008}, -- Treat staff II
     [20]={1, 0x00000010}, -- Wooden katana
     [21]={1, 0x00000020}, -- Hardwood katana
     [22]={1, 0x00000040}, -- Pitchfork
     [23]={1, 0x00000080}, -- Pitchfork +1
     [24]={1, 0x00000100}, -- Charm wand +1
     [25]={1, 0x00000200}, -- Lotus katana
     [26]={1, 0x00000400}, -- Moogle rod
     [27]={1, 0x00000800}, -- Battledore
     [28]={1, 0x00001000}, -- Miracle wand +1
     [29]={1, 0x00002000}, -- Shinai
     [30]={1, 0x00004000}, -- Ibushi shinai
     [31]={1, 0x00008000}, -- Ibushi shinai +1
     [32]={2, 0x00000001}, -- Pumpkin head
     [33]={2, 0x00000002}, -- Horror head
     [34]={2, 0x00000004}, -- Pumpkin head II
     [35]={2, 0x00000008}, -- Horror head II
     [36]={2, 0x00000010}, -- Dream hat
     [37]={2, 0x00000020}, -- Dream hat +1
     [38]={2, 0x00000040}, -- Sprout beret
     [39]={2, 0x00000080}, -- Guide beret
     [40]={2, 0x00000100}, -- Mandragora beret
     [41]={2, 0x00000200}, -- Witch hat
     [42]={2, 0x00000400}, -- Coven hat
     [43]={2, 0x00000800}, -- Egg helm
     [44]={2, 0x00001000}, -- Moogle cap
     [45]={2, 0x00002000}, -- Nomad cap
     [46]={2, 0x00004000}, -- Redeyes
     [47]={2, 0x00008000}, -- Sol cap
     [48]={3, 0x00000001}, -- Onoko yukata / Omina yukata
     [49]={3, 0x00000002}, -- Lord's Yukata / Lady's yukata
     [50]={3, 0x00000004}, -- Hume gilet / Hume top / Elvaan gilet / Elvaan top / Tarutaru maillot / Tarutaru top / Galka gilet / Mithra top
     [51]={3, 0x00000008}, -- Hume gilet +1 / Hume top +1 / Elvaan gilet +1 / Elvaan top +1 / Tarutaru maillot +1 / Tarutaru top +1 / Galka gilet +1 / Mithra top +1
     [52]={3, 0x00000010}, -- Hume trunks / Hume shorts / Elvaan trunks / Elvaan shorts / Tarutaru trunks / Mithra shorts / Galka trunks / Tarutaru shorts
     [53]={3, 0x00000020}, -- Hume trunks +1 / Hume shorts +1 / Elvaan trunks +1 / Elvaan shorts +1 / Tarutaru trunks +1 / Mithra shorts +1 / Galka trunks +1 / Tarutaru shorts +1
     [54]={3, 0x00000040}, -- Dream robe
     [55]={3, 0x00000080}, -- Dream robe +1
     [56]={3, 0x00000100}, -- Otoko yukata / Onago yukata
     [57]={3, 0x00000200}, -- Otokogimi yukata / Onnagimi yukata
     [58]={3, 0x00000400}, -- Dream boots
     [59]={3, 0x00000800}, -- Dream boots +1
     [60]={3, 0x00001000}, -- Custom gilet / Custom top / Magna gilet / Magna top / Wonder maillot / Wonder top / Savage top / Elder gilet
     [61]={3, 0x00002000}, -- Custom gilet +1 / Custom top +1 / Magna gilet +1 / Magna top +1 / Wonder maillot +1 / Wonder top +1 / Savage top +1 / Elder gilet +1
     [62]={3, 0x00004000}, -- Custom trunks / Custom shorts / Magna trunks / Magna shorts / Wonder trunks / Wonder shorts / Savage shorts / Elder trunks
     [63]={3, 0x00008000}, -- Custom trunks +1 / Custom shorts +1 / Magna trunks +1 / Magna shorts +1 / Wonder trunks +1 / Wonder shorts +1 / Savage shorts +1 / Elder trunks +1
     [64]={0, 0x00010000}, -- Copy of "Hoary Spire"
     [65]={0, 0x00020000}, -- Jeweled egg
     [66]={0, 0x00040000}, -- Sprig of red bamboo grass
     [67]={0, 0x00080000}, -- Sprig of blue bamboo grass
     [68]={0, 0x00100000}, -- Sprig of green bamboo grass
     [69]={0, 0x00200000}, -- Snowman knight
     [70]={0, 0x00400000}, -- Snowman miner
     [71]={0, 0x00800000}, -- Snowman mage
     [72]={0, 0x01000000}, -- Bonbori
     [73]={0, 0x02000000}, -- Set of festival dolls
     [74]={0, 0x04000000}, -- Melodious egg
     [75]={0, 0x08000000}, -- Clockwork egg
     [76]={0, 0x10000000}, -- Hatchling egg
     [77]={0, 0x20000000}, -- Harspichord
     [78]={0, 0x40000000}, -- Aldebaran horn
     [80]={2, 0x00010000}, -- Lunar cap
     [81]={2, 0x00020000}, -- Snow bunny hat +1
     [82]={2, 0x00040000}, -- Chocobo beret
     [84]={3, 0x00010000}, -- Eerie cloak
     [85]={3, 0x00020000}, -- Eerie cloak +1
     [86]={3, 0x00040000}, -- Tidal talisman
     [87]={3, 0x00080000}, -- Otokogusa yukata / Onnagusa yukata
     [88]={3, 0x00100000}, -- Otokoeshi yukata / Ominaeshi yukata
     [92]={1, 0x00010000}, -- Town moogle shield
     [93]={1, 0x00020000}, -- Nomad moogle shield
     [94]={1, 0x00040000}, -- Dream bell
     [95]={1, 0x00080000}, -- Dream bell +1
     [96]={4, 0x00000001}, -- Stuffed chocobo
     [97]={4, 0x00000002}, -- Egg buffet
     [98]={4, 0x00000004}, -- Adamantoise statue
     [99]={4, 0x00000008}, -- Behemoth statue
    [100]={4, 0x00000010}, -- Fafnir statue
    [101]={4, 0x00000020}, -- Pepo lantern
    [102]={4, 0x00000040}, -- Cushaw lantern
    [103]={4, 0x00000080}, -- Calabazilla lantern
    [104]={4, 0x00000100}, -- Jeunoan tree
    [105]={4, 0x00000200}, -- Shadow Lord statue
    [106]={4, 0x00000400}, -- Kabuto-kazari
    [107]={4, 0x00000800}, -- Katana-kazari
    [108]={4, 0x00001000}, -- Odin statue
    [109]={4, 0x00002000}, -- Alexander statue
    [110]={4, 0x00004000}, -- Carillon vermeil
    [111]={4, 0x00008000}, -- Aeolsglocke
    [112]={4, 0x00010000}, -- Leafbell
    [113]={4, 0x00020000}, -- San d'Orian flag
    [114]={4, 0x00040000}, -- Bastokan flag
    [115]={4, 0x00080000}, -- Windurstian flag
    [116]={4, 0x00100000}, -- Jack-o'-pricket
    [117]={4, 0x00200000}, -- Djinn pricket
    [118]={4, 0x00400000}, -- Korrigan pricket
    [119]={4, 0x00800000}, -- Mandragora pricket
    [126]={3, 0x00200000}, -- Dinner jacket
    [127]={3, 0x00400000}  -- Dinner hose
}

-- Used when an item is being traded to the NPC
-- in order to find the bitmask to set.
local itemDepoItemIdToBit = {
       [86]={0, 0x00000001}, -- San d'Orian holiday tree
       [87]={0, 0x00000008}, -- Kadomatsu
       [88]={0, 0x00000100}, -- Timepiece
      [115]={0, 0x00000002}, -- Bastokan holiday tree
      [116]={0, 0x00000004}, -- Windurstian holiday tree
      [117]={0, 0x00000010}, -- Wing egg
      [118]={0, 0x00000020}, -- Lamp egg
      [119]={0, 0x00000040}, -- Flower egg
      [138]={4, 0x00000100}, -- Jeunoan tree
      [140]={0, 0x00002000}, -- Dream platter
      [141]={0, 0x00004000}, -- Dream coffer
      [154]={0, 0x00000200}, -- Miniature airship
      [155]={0, 0x00008000}, -- Dream stocking
      [176]={0, 0x00200000}, -- Snowman knight
      [177]={0, 0x00400000}, -- Snowman miner
      [178]={0, 0x00800000}, -- Snowman mage
      [179]={0, 0x00020000}, -- Jeweled egg
      [180]={0, 0x01000000}, -- Bonbori
      [181]={4, 0x00020000}, -- San d'Orian flag
      [182]={4, 0x00040000}, -- Bastokan flag
      [183]={4, 0x00080000}, -- Windurstian flag
      [192]={0, 0x00010000}, -- Copy of "Hoary Spire"
      [193]={0, 0x00000080}, -- Adventuring certificate
      [196]={0, 0x04000000}, -- Melodious egg
      [197]={0, 0x08000000}, -- Clockwork egg
      [199]={0, 0x10000000}, -- Hatchling egg
      [203]={0, 0x00000800}, -- Bomb lantern
      [204]={0, 0x00000400}, -- Pumpkin lantern
      [205]={0, 0x00001000}, -- Mandragora lantern
      [215]={0, 0x02000000}, -- Set of festival dolls
      [264]={4, 0x00000001}, -- Stuffed chocobo
      [265]={4, 0x00000004}, -- Adamantoise statue
      [266]={4, 0x00000008}, -- Behemoth statue
      [267]={4, 0x00000010}, -- Fafnir statue
      [269]={4, 0x00000200}, -- Shadow Lord statue
      [270]={4, 0x00001000}, -- Odin statue
      [271]={4, 0x00002000}, -- Alexander statue
      [320]={0, 0x20000000}, -- Harspichord
      [323]={0, 0x00040000}, -- Sprig of red bamboo grass
      [324]={0, 0x00080000}, -- Sprig of blue bamboo grass
      [325]={0, 0x00100000}, -- Sprig of green bamboo grass
      [415]={0, 0x40000000}, -- Aldebaran horn
      [455]={4, 0x00000002}, -- Egg buffet
      [456]={4, 0x00000020}, -- Pepo lantern
      [457]={4, 0x00000040}, -- Cushaw lantern
      [458]={4, 0x00000080}, -- Calabazilla lantern
     [3622]={4, 0x00100000}, -- Jack-o'-pricket
     [3623]={4, 0x00200000}, -- Djinn pricket
     [3624]={4, 0x00400000}, -- Korrigan pricket
     [3641]={4, 0x00000400}, -- Kabuto-kazari
     [3642]={4, 0x00000800}, -- Katana-kazari
     [3643]={4, 0x00004000}, -- Carillon vermeil
     [3644]={4, 0x00008000}, -- Aeolsglocke
     [3645]={4, 0x00010000}, -- Leafbell
     [3646]={4, 0x00800000}, -- Mandragora pricket
    [11265]={3, 0x00001000}, -- Custom gilet
    [11266]={3, 0x00001000}, -- Custom top
    [11267]={3, 0x00001000}, -- Magna gilet
    [11268]={3, 0x00001000}, -- Magna top
    [11269]={3, 0x00001000}, -- Wonder maillot
    [11270]={3, 0x00001000}, -- Wonder top
    [11271]={3, 0x00001000}, -- Savage top
    [11272]={3, 0x00001000}, -- Elder gilet
    [11273]={3, 0x00002000}, -- Custom gilet +1
    [11274]={3, 0x00002000}, -- Custom top +1
    [11275]={3, 0x00002000}, -- Magna gilet +1
    [11276]={3, 0x00002000}, -- Magna top +1
    [11277]={3, 0x00002000}, -- Wonder maillot +1
    [11278]={3, 0x00002000}, -- Wonder top +1
    [11279]={3, 0x00002000}, -- Savage top +1
    [11280]={3, 0x00002000}, -- Elder gilet +1
    [11290]={3, 0x00040000}, -- Tidal talisman
    [11300]={3, 0x00010000}, -- Eerie cloak
    [11301]={3, 0x00020000}, -- Eerie cloak +1
    [11316]={3, 0x00080000}, -- Otokogusa yukata
    [11317]={3, 0x00080000}, -- Onnagusa yukata
    [11318]={3, 0x00100000}, -- Otokoeshi yukata
    [11319]={3, 0x00100000}, -- Ominaeshi yukata
    [11355]={3, 0x00200000}, -- Dinner jacket
    [11491]={2, 0x00020000}, -- Snow bunny hat +1
    [11500]={2, 0x00040000}, -- Chocobo beret
    [13819]={3, 0x00000001}, -- Onoko yukata
    [13820]={3, 0x00000001}, -- Omina yukata
    [13821]={3, 0x00000002}, -- Lord's Yukata
    [13822]={3, 0x00000002}, -- Lady's yukata
    [13916]={2, 0x00000001}, -- Pumpkin head
    [13917]={2, 0x00000002}, -- Horror head
    [14450]={3, 0x00000004}, -- Hume gilet
    [14451]={3, 0x00000004}, -- Hume top
    [14452]={3, 0x00000004}, -- Elvaan gilet
    [14453]={3, 0x00000004}, -- Elvaan top
    [14454]={3, 0x00000004}, -- Tarutaru maillot
    [14455]={3, 0x00000004}, -- Mithra top
    [14456]={3, 0x00000004}, -- Galka gilet
    [14457]={3, 0x00000008}, -- Hume gilet +1
    [14458]={3, 0x00000008}, -- Hume top +1
    [14459]={3, 0x00000008}, -- Elvaan gilet +1
    [14460]={3, 0x00000008}, -- Elvaan top +1
    [14461]={3, 0x00000008}, -- Tarutaru maillot +1
    [14462]={3, 0x00000008}, -- Mithra top +1
    [14463]={3, 0x00000008}, -- Galka gilet +1
    [14471]={3, 0x00000004}, -- Tarutaru top
    [14472]={3, 0x00000008}, -- Tarutaru top +1
    [14519]={3, 0x00000040}, -- Dream robe
    [14520]={3, 0x00000080}, -- Dream robe +1
    [14532]={3, 0x00000100}, -- Otoko yukata
    [14533]={3, 0x00000100}, -- Onago yukata
    [14534]={3, 0x00000200}, -- Otokogimi yukata
    [14535]={3, 0x00000200}, -- Onnagimi yukata
    [15176]={2, 0x00000004}, -- Pumpkin head II
    [15177]={2, 0x00000008}, -- Horror head II
    [15178]={2, 0x00000010}, -- Dream hat
    [15179]={2, 0x00000020}, -- Dream hat +1
    [15198]={2, 0x00000040}, -- Sprout beret
    [15199]={2, 0x00000080}, -- Guide beret
    [15204]={2, 0x00000100}, -- Mandragora beret
    [15408]={3, 0x00000010}, -- Hume trunks
    [15409]={3, 0x00000010}, -- Hume shorts
    [15410]={3, 0x00000010}, -- Elvaan trunks
    [15411]={3, 0x00000010}, -- Elvaan shorts
    [15412]={3, 0x00000010}, -- Tarutaru trunks
    [15413]={3, 0x00000010}, -- Mithra shorts
    [15414]={3, 0x00000010}, -- Galka trunks
    [15415]={3, 0x00000020}, -- Hume trunks +1
    [15416]={3, 0x00000020}, -- Hume shorts +1
    [15417]={3, 0x00000020}, -- Elvaan trunks +1
    [15418]={3, 0x00000020}, -- Elvaan shorts +1
    [15419]={3, 0x00000020}, -- Tarutaru trunks +1
    [15420]={3, 0x00000020}, -- Mithra shorts +1
    [15421]={3, 0x00000020}, -- Galka trunks +1
    [15423]={3, 0x00000010}, -- Tarutaru shorts
    [15424]={3, 0x00000020}, -- Tarutaru shorts +1
    [15752]={3, 0x00000400}, -- Dream boots
    [15753]={3, 0x00000800}, -- Dream boots +1
    [16075]={2, 0x00000200}, -- Witch hat
    [16076]={2, 0x00000400}, -- Coven hat
    [16109]={2, 0x00000800}, -- Egg helm
    [16118]={2, 0x00001000}, -- Moogle cap
    [16119]={2, 0x00002000}, -- Nomad cap
    [16120]={2, 0x00004000}, -- Redeyes
    [16144]={2, 0x00008000}, -- Sol cap
    [16145]={2, 0x00010000}, -- Lunar cap
    [16182]={1, 0x00010000}, -- Town moogle shield
    [16183]={1, 0x00020000}, -- Nomad moogle shield
    [16321]={3, 0x00004000}, -- Custom trunks
    [16322]={3, 0x00004000}, -- Custom shorts
    [16323]={3, 0x00004000}, -- Magna trunks
    [16324]={3, 0x00004000}, -- Magna shorts
    [16325]={3, 0x00004000}, -- Wonder trunks
    [16326]={3, 0x00004000}, -- Wonder shorts
    [16327]={3, 0x00004000}, -- Savage shorts
    [16328]={3, 0x00004000}, -- Elder trunks
    [16329]={3, 0x00008000}, -- Custom trunks +1
    [16330]={3, 0x00008000}, -- Custom shorts +1
    [16331]={3, 0x00008000}, -- Magna trunks +1
    [16332]={3, 0x00008000}, -- Magna shorts +1
    [16333]={3, 0x00008000}, -- Wonder trunks +1
    [16334]={3, 0x00008000}, -- Wonder shorts +1
    [16335]={3, 0x00008000}, -- Savage shorts +1
    [16336]={3, 0x00008000}, -- Elder trunks +1
    [16378]={3, 0x00400000}, -- Dinner hose
    [17074]={1, 0x00000001}, -- Chocobo wand
    [17565]={1, 0x00000002}, -- Trick staff
    [17566]={1, 0x00000004}, -- Treat staff
    [17588]={1, 0x00000008}, -- Treat staff II
    [17748]={1, 0x00004000}, -- Ibushi shinai
    [17749]={1, 0x00008000}, -- Ibushi shinai +1
    [17830]={1, 0x00000010}, -- Wooden katana
    [17831]={1, 0x00000020}, -- Hardwood katana
    [18102]={1, 0x00000040}, -- Pitchfork
    [18103]={1, 0x00000080}, -- Pitchfork +1
    [18400]={1, 0x00000100}, -- Charm wand +1
    [18401]={1, 0x00000400}, -- Moogle rod
    [18436]={1, 0x00000200}, -- Lotus katana
    [18441]={1, 0x00002000}, -- Shinai
    [18845]={1, 0x00001000}, -- Miracle wand +1
    [18846]={1, 0x00000800}, -- Battledore
    [18863]={1, 0x00040000}, -- Dream bell
    [18864]={1, 0x00080000}  -- Dream bell +1
}

local itemDepoBitToItemId = {
    [0] = {
        [0x00000001]=86,
        [0x00000002]=115,
        [0x00000004]=116,
        [0x00000008]=87,
        [0x00000010]=117,
        [0x00000020]=118,
        [0x00000040]=119,
        [0x00000080]=193,
        [0x00000100]=88,
        [0x00000200]=154,
        [0x00000400]=204,
        [0x00000800]=203,
        [0x00001000]=205,
        [0x00002000]=140,
        [0x00004000]=141,
        [0x00008000]=155,
        [0x00010000]=192,
        [0x00020000]=179,
        [0x00040000]=323,
        [0x00080000]=324,
        [0x00100000]=325,
        [0x00200000]=176,
        [0x00400000]=177,
        [0x00800000]=178,
        [0x01000000]=180,
        [0x02000000]=215,
        [0x04000000]=196,
        [0x08000000]=197,
        [0x10000000]=199,
        [0x20000000]=320,
        [0x40000000]=415,
    },
    [1] = {
        [0x00000001]=17074,
        [0x00000002]=17565,
        [0x00000004]=17566,
        [0x00000008]=17588,
        [0x00000010]=17830,
        [0x00000020]=17831,
        [0x00000040]=18102,
        [0x00000080]=18103,
        [0x00000100]=18400,
        [0x00000200]=18436,
        [0x00000400]=18401,
        [0x00000800]=18846,
        [0x00001000]=18845,
        [0x00002000]=18441,
        [0x00004000]=17748,
        [0x00008000]=17749,
        [0x00010000]=16182,
        [0x00020000]=16183,
        [0x00040000]=18863,
        [0x00080000]=18864
    },
    [2] = {
        [0x00000001]=13916,
        [0x00000002]=13917,
        [0x00000004]=15176,
        [0x00000008]=15177,
        [0x00000010]=15178,
        [0x00000020]=15179,
        [0x00000040]=15198,
        [0x00000080]=15199,
        [0x00000100]=15204,
        [0x00000200]=16075,
        [0x00000400]=16076,
        [0x00000800]=16109,
        [0x00001000]=16118,
        [0x00002000]=16119,
        [0x00004000]=16120,
        [0x00008000]=16144,
        [0x00010000]=16145,
        [0x00020000]=11491,
        [0x00040000]=11500
    },
    [3] = {
        [0x00000001]={13819, 13820},
        [0x00000002]={13821, 13822},
        [0x00000004]={14450, 14451, 14452, 14453, 14454, 14455, 14456, 14471},
        [0x00000008]={14457, 14458, 14459, 14460, 14461, 14462, 14463, 14472},
        [0x00000010]={15408, 15409, 15410, 15411, 15412, 15413, 15414, 15423},
        [0x00000020]={15415, 15416, 15417, 15418, 15419, 15420, 15421, 15424},
        [0x00000040]=14519,
        [0x00000080]=14520,
        [0x00000100]={14532, 14533},
        [0x00000200]={14534, 14535},
        [0x00000400]=15752,
        [0x00000800]=15753,
        [0x00001000]={11265, 11266, 11267, 11268, 11269, 11270, 11271, 11272},
        [0x00002000]={11273, 11274, 11275, 11276, 11277, 11278, 11279, 11280},
        [0x00004000]={16321, 16322, 16323, 16324, 16325, 16326, 16327, 16328},
        [0x00008000]={16329, 16330, 16331, 16332, 16333, 16334, 16335, 16336},
        [0x00010000]=11300,
        [0x00020000]=11301,
        [0x00040000]=11290,
        [0x00080000]={11316, 11317},
        [0x00100000]={11318, 11319},
        [0x00200000]=11355,
        [0x00400000]=16378
    },
    [4] = {
        [0x00000001]=264,
        [0x00000002]=455,
        [0x00000004]=265,
        [0x00000008]=266,
        [0x00000010]=267,
        [0x00000020]=456,
        [0x00000040]=457,
        [0x00000080]=458,
        [0x00000100]=138,
        [0x00000200]=269,
        [0x00000400]=3641,
        [0x00000800]=3642,
        [0x00001000]=270,
        [0x00002000]=271,
        [0x00004000]=3643,
        [0x00008000]=3644,
        [0x00010000]=3645,
        [0x00020000]=181,
        [0x00040000]=182,
        [0x00080000]=183,
        [0x00100000]=3622,
        [0x00200000]=3623,
        [0x00400000]=3624,
        [0x00800000]=3646
    }
}

-- Debug function that checks that the item id to bit table is
-- in sync with the bit table to item id table. Needed to
-- prevent a mistake leading to a player getting back a different
-- item than what they deposited.
-- Run with !exec
function itemDepoSanityRun()
    local failures = 0
    for itemid, bitdata in pairs(itemDepoItemIdToBit) do
        local bucket = bitdata[1]
        local itembit = bitdata[2]
        local itemtempdata = itemDepoBitToItemId[bucket][itembit]
        local newitemid = 0
        if type(itemtempdata) == "table" then
            for i = 1, #itemtempdata do
                if itemtempdata[i] == itemid then
                    newitemid = itemtempdata[i]
                    break
                end
            end
        else
            newitemid = itemtempdata
        end
        if newitemid ~= itemid then
            print(string.format("Item ID %i FAILED! (got %i)", itemid, newitemid))
            failures = failures + 1
        else
            print(string.format("Item ID %i succeeded", itemid))
        end
    end
    print(string.format("Number of failures: %i", failures))
end

function itemDepoCanRaceEquipItem(player, item)
    if player == nil or item == nil then
        return false
    end
    local item_race = item:getRace()
    local player_race = player:getRace()
    local race_match = bit.band(item_race, bit.lshift(1, player_race - 1))
    if race_match ~= nil and race_match ~= 0 then
        return true
    end
    return false
end

function itemDepoGetBitByChoice(player, choice)
    local bit_data = itemDepoChoiceToBit[choice]
    if (bit_data == nil) then
        return 0, 0
    end
    return bit_data[1], bit_data[2]
end

function itemDepoGetBitByItemId(player, itemid)
    local item = GetItem(itemid)
    if item == nil then
        return 0, 0
    end
    local bit_data = itemDepoItemIdToBit[itemid]
    if bit_data == nil then
        -- Not found
        return 0, 0
    end
    -- Prevent them from depositing items their race can't
    -- wear to avoid "magic transformation" when they pull
    -- it back
    local itemflags = item:getFlag()
    if (bit.band(itemflags, 0x0800) ~= 0) and (itemDepoCanRaceEquipItem(player, item) == false) then
        return 0, 0
    end
    -- First value is the bucket, second is the bit
    return bit_data[1], bit_data[2]
end

function itemDepoGetItemIdByBit(player, bucketno, itembit)
    local itemid = itemDepoBitToItemId[bucketno][itembit]
    if itemid == nil then
        return 0
    end
    if (type(itemid) == "table") then
        -- List of items, one per race
        -- Find the one this player can equip
        for i = 1, #itemid do
            local item = GetItem(itemid[i])
            local itemflags = item:getFlag()
            if (bit.band(itemflags, 0x0800) == 0) or (itemDepoCanRaceEquipItem(player, item)) then
                return itemid[i]
            end
        end
        -- Should not happen
        return 0
    end
    -- If we got here it means we have a single item
    return itemid
end

-------------------------------------------------------------------------

local Trigger_CSIDs = {
    [tpz.zone.SOUTHERN_SAN_DORIA] = 779,
    [tpz.zone.PORT_BASTOK] = 349,
    [tpz.zone.WINDURST_WATERS] = 910,
    [tpz.zone.PORT_JEUNO] = 308,
    [tpz.zone.AHT_URHGAN_WHITEGATE] = 702
}

local Trade_CSIDs = {
    [tpz.zone.SOUTHERN_SAN_DORIA] = 778,
    [tpz.zone.PORT_BASTOK] = 348,
    [tpz.zone.WINDURST_WATERS] = 909,
    [tpz.zone.PORT_JEUNO] = 307,
    [tpz.zone.AHT_URHGAN_WHITEGATE] = 701
}

function itemDepoOnTrade(player, npc, trade)
    local csid = Trade_CSIDs[player:getZoneID()]
    if csid == nil then
        return
    end
    if trade:getItemCount() ~= 1 then
        -- Can only trade one piece of gear at a time.
        -- None of them stack so the total quantity has
        -- to be one.
        return
    end
    local item = trade:getItem(0)
    if item == nil then
        return
    end
    local itemid = item:getID()
    if itemid == nil or itemid == 0 then
        return
    end
    -- Check if we can store this item
    local bucket = 0
    local itembit = 0
    bucket, itembit = itemDepoGetBitByItemId(player, itemid)
    if bucket == nil or itembit == nil or (bucket == 0 and itembit == 0) then
        -- Nope
        return
    end
    local bucket_name = "itemDepo" .. tostring(bucket)
    bucket_content = player:getCharVar(bucket_name)
    if bit.band(bucket_content, itembit) ~= 0 then
        -- They have an identical item already stored.
        -- Can't accept another one.
        return
    end
    -- Add the new item
    bucket_content = bit.bor(bucket_content, itembit)
    player:tradeComplete()
    player:setCharVar(bucket_name, bucket_content)
    -- "Do not worry. Your <item name> is in good hands."
    player:startEvent(csid, itemid)
end

function itemDepoOnTrigger(player, npc)
    local csid = Trigger_CSIDs[player:getZoneID()]
    if csid == nil then
        return
    end
    player:startEvent(csid, player:getCharVar("itemDepo0"), player:getCharVar("itemDepo1"), player:getCharVar("itemDepo2"), player:getCharVar("itemDepo3"), player:getGil(), player:getCharVar("itemDepo4"))
end

function itemDepoOnEventUpdate(player, csid, option)
end

function itemDepoOnEventFinish(player, csid, option)
    local zoneid = player:getZoneID()
    local zone = zones[zoneid]
    if csid ~= Trigger_CSIDs[zoneid] then
        return
    end
    if option == nil or option < 0 or option > 0xFF then
        return
    end
    -- Let's see which item they want back
    local bucket = 0
    local itembit = 0
    bucket, itembit = itemDepoGetBitByChoice(player, option)
    if bucket == nil or itembit == nil or (bucket == 0 and itembit == 0) then
        -- Doesn't seem there is such an item
        return
    end
    local bucket_name = "itemDepo" .. tostring(bucket)
    bucket_content = player:getCharVar(bucket_name)
    if bit.band(bucket_content, itembit) == 0 then
        -- They don't have that item stored (possible cheat attempt!)
        return
    end
    local itemid = itemDepoGetItemIdByBit(player, bucket, itembit)
    if itemid == nil or itemid == 0 then
        -- Shouldn't happen
        return
    end
    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(zone.text.ITEM_CANNOT_BE_OBTAINED, itemid)
        return
    end
    local item = GetItem(itemid)
    local itemflags = item:getFlag()
    if bit.band(itemflags, 0x8000) ~= 0 and player:hasItem(itemid) then
        -- Item is rare and they already have one
        player:messageSpecial(zone.text.ITEM_CANNOT_BE_OBTAINED, itemid)
        return
    end
    if player:getGil() < 250 then
         player:messageSpecial(zone.text.NOT_HAVE_ENOUGH_GIL)
         return
    end
    -- We can give them the item now
    bucket_content = bit.band(bucket_content, bit.bnot(itembit))
    player:setCharVar(bucket_name, bucket_content)
    player:delGil(250)
    -- Retail behavior is that if the item is usable then they
    -- need to wait a full cooldown after retrieving it from the
    -- depository.
    if item:isSubType(0x02) then
        player:addUsedItem(itemid)
    else
        player:addItem(itemid)
    end
    player:messageSpecial(zone.text.ITEM_OBTAINED, itemid)
end
