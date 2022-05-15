-----------------------------------
--
-- Dynamis-Qufim
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_QUFIM
local DMB = 16945153 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 16945160 -- statue mob base, where zone's statue targetid = 0
local EMB = 16945629 -- elemental mob base, where zone's elemental targetid = 0

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] =
{
    -- Wave 1
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_quf1.htm
    -- Nightmare Mobs
    [DMB+152] = { id =  DMB+152}, -- Nightmare_Stirge
    [DMB+153] = { id =  DMB+153}, -- Nightmare_Stirge
    [DMB+154] = { id =  DMB+154}, -- Nightmare_Stirge
    [DMB+155] = { id =  DMB+155}, -- Nightmare_Stirge
    [DMB+156] = { id =  DMB+156}, -- Nightmare_Stirge
    [DMB+157] = { id =  DMB+157}, -- Nightmare_Stirge
    [DMB+158] = { id =  DMB+158}, -- Nightmare_Stirge
    [DMB+159] = { id =  DMB+159}, -- Nightmare_Stirge
    [DMB+160] = { id =  DMB+160}, -- Nightmare_Stirge
    [DMB+161] = { id =  DMB+161}, -- Nightmare_Stirge
    [DMB+162] = { id =  DMB+162}, -- Nightmare_Stirge
    [DMB+163] = { id =  DMB+163}, -- Nightmare_Stirge
    [DMB+164] = { id =  DMB+164}, -- Nightmare_Stirge
    [DMB+165] = { id =  DMB+165}, -- Nightmare_Stirge
    [DMB+166] = { id =  DMB+166}, -- Nightmare_Stirge
    [DMB+254] = { id =  DMB+254}, -- Nightmare_Stirge
    [DMB+255] = { id =  DMB+255}, -- Nightmare_Stirge
    [DMB+256] = { id =  DMB+256}, -- Nightmare_Stirge
    [DMB+257] = { id =  DMB+257}, -- Nightmare_Stirge
    [DMB+258] = { id =  DMB+258}, -- Nightmare_Stirge
    [DMB+259] = { id =  DMB+259}, -- Nightmare_Stirge
    [DMB+260] = { id =  DMB+260}, -- Nightmare_Stirge
    [DMB+261] = { id =  DMB+261}, -- Nightmare_Stirge
    [DMB+262] = { id =  DMB+262}, -- Nightmare_Stirge
    [DMB+263] = { id =  DMB+263}, -- Nightmare_Stirge
    [DMB+264] = { id =  DMB+264}, -- Nightmare_Stirge
    [DMB+265] = { id =  DMB+265}, -- Nightmare_Stirge
    [DMB+266] = { id =  DMB+266}, -- Nightmare_Stirge
    [DMB+267] = { id =  DMB+267}, -- Nightmare_Stirge
    [DMB+211] = { id =  DMB+211}, -- Nightmare_Roc
    [DMB+212] = { id =  DMB+212}, -- Nightmare_Roc
    [DMB+213] = { id =  DMB+213}, -- Nightmare_Roc
    [DMB+251] = { id =  DMB+251}, -- Nightmare_Roc
    [DMB+252] = { id =  DMB+252}, -- Nightmare_Roc
    [DMB+253] = { id =  DMB+253}, -- Nightmare_Roc
    [DMB+229] = { id =  DMB+229}, -- Nightmare_Snoll
    [DMB+230] = { id =  DMB+230}, -- Nightmare_Snoll
    [DMB+231] = { id =  DMB+231}, -- Nightmare_Snoll
    [DMB+232] = { id =  DMB+232}, -- Nightmare_Snoll
    [DMB+233] = { id =  DMB+233}, -- Nightmare_Snoll
    [DMB+234] = { id =  DMB+234}, -- Nightmare_Snoll
    [DMB+235] = { id =  DMB+235}, -- Nightmare_Snoll
    [DMB+236] = { id =  DMB+236}, -- Nightmare_Snoll
    [DMB+237] = { id =  DMB+237}, -- Nightmare_Snoll
    [DMB+238] = { id =  DMB+238}, -- Nightmare_Snoll
    [DMB+239] = { id =  DMB+239}, -- Nightmare_Snoll
    [DMB+240] = { id =  DMB+240}, -- Nightmare_Snoll
    [DMB+241] = { id =  DMB+241}, -- Nightmare_Snoll
    [DMB+242] = { id =  DMB+242}, -- Nightmare_Snoll
    [DMB+243] = { id =  DMB+243}, -- Nightmare_Snoll
    [DMB+244] = { id =  DMB+244}, -- Nightmare_Snoll
    [DMB+245] = { id =  DMB+245}, -- Nightmare_Snoll
    [DMB+246] = { id =  DMB+246}, -- Nightmare_Snoll
    [DMB+247] = { id =  DMB+247}, -- Nightmare_Snoll
    [DMB+248] = { id =  DMB+248}, -- Nightmare_Snoll
    [DMB+249] = { id =  DMB+249}, -- Nightmare_Snoll
    [DMB+305] = { id =  DMB+305}, -- Nightmare_Snoll
    [DMB+306] = { id =  DMB+306}, -- Nightmare_Snoll
    [DMB+307] = { id =  DMB+307}, -- Nightmare_Snoll
    [DMB+308] = { id =  DMB+308}, -- Nightmare_Snoll
    [DMB+309] = { id =  DMB+309}, -- Nightmare_Snoll
    [DMB+310] = { id =  DMB+310}, -- Nightmare_Snoll
    [DMB+311] = { id =  DMB+311}, -- Nightmare_Snoll
    [DMB+312] = { id =  DMB+312}, -- Nightmare_Snoll
    [DMB+313] = { id =  DMB+313}, -- Nightmare_Snoll
    [DMB+314] = { id =  DMB+314}, -- Nightmare_Snoll
    [DMB+315] = { id =  DMB+315}, -- Nightmare_Snoll
    [DMB+316] = { id =  DMB+316}, -- Nightmare_Snoll

    -- Elemental and NM based on https://enedin.be/dyna/html/zone/frame_quf1.htm
    -- Sea Monk NM Area
    [EMB+0  ] = { id =  EMB+0  }, -- Water Elemental (043)
    [DMB+134] = { id =  DMB+134}, -- Scolopendra (040)
    -- Southwest Area
    [EMB+12 ] = { id =  EMB+12 }, -- Fire Elemental (044)
    -- Giant Bat Area
    [EMB+3  ] = { id =  EMB+3  }, -- Thunder Elemental (045)
    [DMB+167] = { id =  DMB+167}, -- Stringes (041)
    -- Northeast Area
    [EMB+4  ] = { id =  EMB+4  }, -- Air Elemental (046)
    [EMB+5  ] = { id =  EMB+5  }, -- Light Elemental (047)
    -- Boss Area
    [EMB+6  ] = { id =  EMB+6  }, -- Ice Elemental (048)
    [DMB+0  ] = { id =  DMB+0  }, -- Antaeus (064)
    -- Golem NM Area
    [EMB+7  ] = { id =  EMB+7  }, -- Earth Elemental (049)
    [EMB+13 ] = { id =  EMB+13 }, -- Dark Elemental (050)
    [DMB+228] = { id =  DMB+228}, -- Suttung (042)

    -- Initial Statues based on https://enedin.be/dyna/html/zone/frame_quf1.htm
    -- Sea Monk NM Area
    [SMB+30 ] = { id =  SMB+30 }, -- Adamantking_Effigy (001-Q)
    [SMB+31 ] = { id =  SMB+31 }, -- Adamantking_Effigy (002-Q)
    -- Southwest Area
    [SMB+32 ] = { id =  SMB+32 }, -- Adamantking_Effigy (003-Q)
    [SMB+40 ] = { id =  SMB+40 }, -- Adamantking_Effigy (004-Q)
    [SMB+41 ] = { id =  SMB+41 }, -- Adamantking_Effigy (005-Q)
    [SMB+42 ] = { id =  SMB+42 }, -- Adamantking_Effigy (006-Q)
    [SMB+50 ] = { id =  SMB+50 }, -- Adamantking_Effigy (007-Q)
    [SMB+60 ] = { id =  SMB+60 }, -- Manifest_Icon (008-Y)
    [SMB+61 ] = { id =  SMB+61 }, -- Manifest_Icon (009-Y)
    [SMB+62 ] = { id =  SMB+62 }, -- Manifest_Icon (010-Y)
    [SMB+70 ] = { id =  SMB+70 }, -- Manifest_Icon (011-Y)
    [SMB+71 ] = { id =  SMB+71 }, -- Manifest_Icon (012-Y)
    [SMB+72 ] = { id =  SMB+72 }, -- Manifest_Icon (013-Y)
    [SMB+80 ] = { id =  SMB+80 }, -- Manifest_Icon (014-Y)
    [SMB+81 ] = { id =  SMB+81 }, -- Manifest_Icon (015-Y)
    -- Northeast Area
    [SMB+0  ] = { id =  SMB+0  }, -- Serjeant_Tombstone (016-O)
    [SMB+1  ] = { id =  SMB+1  }, -- Serjeant_Tombstone (017-O)
    [SMB+2  ] = { id =  SMB+2  }, -- Serjeant_Tombstone (018-O)
    [SMB+10 ] = { id =  SMB+11 }, -- Serjeant_Tombstone (019-O)
    [SMB+11 ] = { id =  SMB+11 }, -- Serjeant_Tombstone (020-O)
    [SMB+12 ] = { id =  SMB+12 }, -- Serjeant_Tombstone (021-O)
    [SMB+20 ] = { id =  SMB+20 }, -- Serjeant_Tombstone (022-O)
    [SMB+21]  = { id =  SMB+21 }, -- Serjeant_Tombstone (023-O)
    [SMB+22 ] = { id =  SMB+22 }, -- Serjeant_Tombstone (024-O)
    [SMB+90 ] = { id =  SMB+90 }, -- Goblin_Replica (025-G)
    [SMB+91 ] = { id =  SMB+91 }, -- Goblin_Replica (026-G)
    -- Boss Area
    [SMB+92 ] = { id =  SMB+92 }, -- Goblin_Replica (027-G)
    [SMB+100] = { id =  SMB+100}, -- Goblin_Replica (028-G)
    [SMB+101] = { id =  SMB+101}, -- Goblin_Replica (029-G)
    [SMB+102] = { id =  SMB+102}, -- Goblin_Replica (030-G)
    [SMB+110] = { id =  SMB+110}, -- Goblin_Replica (031-G)
    -- Golem NM Area
    [SMB+111] = { id =  SMB+111}, -- Goblin_Replica (032-G)
    [SMB+112] = { id =  SMB+112}, -- Goblin_Replica (033-G)
    [SMB+346] = { id =  SMB+346}, -- Goblin_Replica (034-G)
    [SMB+347] = { id =  SMB+347}, -- Goblin_Replica (035-G)
    -- Giant Bat NM Area
    [SMB+348] = { id =  SMB+348}, -- Goblin_Replica (036-G)
    [SMB+367] = { id =  SMB+367}, -- Goblin_Replica (037-G)
    [SMB+368] = { id =  SMB+368}, -- Goblin_Replica (038-G)
    [SMB+369] = { id =  SMB+369}, -- Goblin_Replica (039-G)

    -- Wave 2
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_quf2.htm
    -- Nightmare Mobs
    [DMB+135] = { id =  DMB+135}, -- Nightmare_Weapon
    [DMB+136] = { id =  DMB+136}, -- Nightmare_Weapon
    [DMB+137] = { id =  DMB+137}, -- Nightmare_Weapon
    [DMB+138] = { id =  DMB+138}, -- Nightmare_Weapon
    [DMB+139] = { id =  DMB+139}, -- Nightmare_Weapon
    [DMB+140] = { id =  DMB+140}, -- Nightmare_Weapon
    [DMB+141] = { id =  DMB+141}, -- Nightmare_Weapon
    [DMB+142] = { id =  DMB+142}, -- Nightmare_Weapon
    [DMB+143] = { id =  DMB+143}, -- Nightmare_Weapon
    [DMB+144] = { id =  DMB+144}, -- Nightmare_Weapon
    [DMB+145] = { id =  DMB+145}, -- Nightmare_Weapon
    [DMB+146] = { id =  DMB+146}, -- Nightmare_Weapon
    [DMB+147] = { id =  DMB+147}, -- Nightmare_Weapon
    [DMB+148] = { id =  DMB+148}, -- Nightmare_Weapon
    [DMB+149] = { id =  DMB+149}, -- Nightmare_Weapon
    [DMB+150] = { id =  DMB+150}, -- Nightmare_Weapon
    [DMB+151] = { id =  DMB+151}, -- Nightmare_Weapon
    [DMB+396] = { id =  DMB+396}, -- Nightmare_Weapon
    [DMB+397] = { id =  DMB+397}, -- Nightmare_Weapon
    [DMB+398] = { id =  DMB+398}, -- Nightmare_Weapon
    [DMB+399] = { id =  DMB+399}, -- Nightmare_Weapon
    [DMB+400] = { id =  DMB+400}, -- Nightmare_Weapon
    [DMB+401] = { id =  DMB+401}, -- Nightmare_Weapon
    [DMB+402] = { id =  DMB+402}, -- Nightmare_Weapon
    [DMB+403] = { id =  DMB+403}, -- Nightmare_Weapon
    [DMB+404] = { id =  DMB+404}, -- Nightmare_Weapon
    [DMB+405] = { id =  DMB+405}, -- Nightmare_Weapon
    [DMB+514] = { id =  DMB+514}, -- Nightmare_Weapon
    [DMB+515] = { id =  DMB+515}, -- Nightmare_Weapon
    [DMB+516] = { id =  DMB+516}, -- Nightmare_Weapon
    [DMB+121] = { id =  DMB+121}, -- Nightmare_Kraken
    [DMB+122] = { id =  DMB+122}, -- Nightmare_Kraken
    [DMB+123] = { id =  DMB+123}, -- Nightmare_Kraken
    [DMB+124] = { id =  DMB+124}, -- Nightmare_Kraken
    [DMB+125] = { id =  DMB+125}, -- Nightmare_Kraken
    [DMB+126] = { id =  DMB+126}, -- Nightmare_Kraken
    [DMB+127] = { id =  DMB+127}, -- Nightmare_Kraken
    [DMB+128] = { id =  DMB+128}, -- Nightmare_Kraken
    [DMB+129] = { id =  DMB+129}, -- Nightmare_Kraken
    [DMB+130] = { id =  DMB+130}, -- Nightmare_Kraken
    [DMB+131] = { id =  DMB+131}, -- Nightmare_Kraken
    [DMB+132] = { id =  DMB+132}, -- Nightmare_Kraken
    [DMB+133] = { id =  DMB+133}, -- Nightmare_Kraken
    [DMB+290] = { id =  DMB+290}, -- Nightmare_Kraken
    [DMB+291] = { id =  DMB+291}, -- Nightmare_Kraken
    [DMB+292] = { id =  DMB+292}, -- Nightmare_Kraken
    [DMB+293] = { id =  DMB+293}, -- Nightmare_Kraken
    [DMB+294] = { id =  DMB+294}, -- Nightmare_Kraken
    [DMB+295] = { id =  DMB+295}, -- Nightmare_Kraken
    [DMB+296] = { id =  DMB+296}, -- Nightmare_Kraken
    [DMB+297] = { id =  DMB+297}, -- Nightmare_Kraken
    [DMB+298] = { id =  DMB+298}, -- Nightmare_Kraken
    [DMB+299] = { id =  DMB+299}, -- Nightmare_Kraken
    [DMB+300] = { id =  DMB+300}, -- Nightmare_Kraken
    [DMB+301] = { id =  DMB+301}, -- Nightmare_Kraken
    [DMB+302] = { id =  DMB+302}, -- Nightmare_Kraken
    [DMB+303] = { id =  DMB+303}, -- Nightmare_Kraken
    [DMB+184] = { id =  DMB+184}, -- Nightmare_Tiger
    [DMB+185] = { id =  DMB+185}, -- Nightmare_Tiger
    [DMB+186] = { id =  DMB+186}, -- Nightmare_Tiger
    [DMB+187] = { id =  DMB+187}, -- Nightmare_Tiger
    [DMB+188] = { id =  DMB+188}, -- Nightmare_Tiger
    [DMB+189] = { id =  DMB+189}, -- Nightmare_Tiger
    [DMB+190] = { id =  DMB+190}, -- Nightmare_Tiger
    [DMB+191] = { id =  DMB+191}, -- Nightmare_Tiger
    [DMB+192] = { id =  DMB+192}, -- Nightmare_Tiger
    [DMB+193] = { id =  DMB+193}, -- Nightmare_Tiger
    [DMB+194] = { id =  DMB+194}, -- Nightmare_Tiger
    [DMB+195] = { id =  DMB+195}, -- Nightmare_Tiger
    [DMB+357] = { id =  DMB+357}, -- Nightmare_Tiger
    [DMB+358] = { id =  DMB+358}, -- Nightmare_Tiger
    [DMB+359] = { id =  DMB+359}, -- Nightmare_Tiger
    [DMB+360] = { id =  DMB+360}, -- Nightmare_Tiger
    [DMB+361] = { id =  DMB+361}, -- Nightmare_Tiger
    [DMB+362] = { id =  DMB+362}, -- Nightmare_Tiger
    [DMB+363] = { id =  DMB+363}, -- Nightmare_Tiger
    [DMB+364] = { id =  DMB+364}, -- Nightmare_Tiger
    [DMB+365] = { id =  DMB+365}, -- Nightmare_Tiger
    [DMB+366] = { id =  DMB+366}, -- Nightmare_Tiger
    [DMB+367] = { id =  DMB+367}, -- Nightmare_Tiger
    [DMB+368] = { id =  DMB+368}, -- Nightmare_Tiger
    [DMB+517] = { id =  DMB+517}, -- Nightmare_Tiger
    [DMB+518] = { id =  DMB+518}, -- Nightmare_Tiger
    [DMB+519] = { id =  DMB+519}, -- Nightmare_Tiger
    [DMB+520] = { id =  DMB+520}, -- Nightmare_Tiger
    [DMB+521] = { id =  DMB+521}, -- Nightmare_Tiger
    [DMB+214] = { id =  DMB+214}, -- Nightmare_Raptor
    [DMB+215] = { id =  DMB+215}, -- Nightmare_Raptor
    [DMB+216] = { id =  DMB+216}, -- Nightmare_Raptor
    [DMB+217] = { id =  DMB+217}, -- Nightmare_Raptor
    [DMB+218] = { id =  DMB+218}, -- Nightmare_Raptor
    [DMB+219] = { id =  DMB+219}, -- Nightmare_Raptor
    [DMB+220] = { id =  DMB+220}, -- Nightmare_Raptor
    [DMB+221] = { id =  DMB+221}, -- Nightmare_Raptor
    [DMB+222] = { id =  DMB+222}, -- Nightmare_Raptor
    [DMB+223] = { id =  DMB+223}, -- Nightmare_Raptor
    [DMB+224] = { id =  DMB+224}, -- Nightmare_Raptor
    [DMB+225] = { id =  DMB+225}, -- Nightmare_Raptor
    [DMB+226] = { id =  DMB+226}, -- Nightmare_Raptor
    [DMB+227] = { id =  DMB+227}, -- Nightmare_Raptor
    [DMB+436] = { id =  DMB+436}, -- Nightmare_Raptor
    [DMB+437] = { id =  DMB+437}, -- Nightmare_Raptor
    [DMB+438] = { id =  DMB+438}, -- Nightmare_Raptor
    [DMB+439] = { id =  DMB+439}, -- Nightmare_Raptor
    [DMB+440] = { id =  DMB+440}, -- Nightmare_Raptor
    [DMB+441] = { id =  DMB+441}, -- Nightmare_Raptor
    [DMB+442] = { id =  DMB+442}, -- Nightmare_Raptor
    [DMB+443] = { id =  DMB+443}, -- Nightmare_Raptor
    [DMB+444] = { id =  DMB+444}, -- Nightmare_Raptor
    [DMB+445] = { id =  DMB+445}, -- Nightmare_Raptor
    [DMB+196] = { id =  DMB+196}, -- Nightmare_Diremite
    [DMB+197] = { id =  DMB+197}, -- Nightmare_Diremite
    [DMB+198] = { id =  DMB+198}, -- Nightmare_Diremite
    [DMB+199] = { id =  DMB+199}, -- Nightmare_Diremite
    [DMB+200] = { id =  DMB+200}, -- Nightmare_Diremite
    [DMB+201] = { id =  DMB+201}, -- Nightmare_Diremite
    [DMB+202] = { id =  DMB+202}, -- Nightmare_Diremite
    [DMB+203] = { id =  DMB+203}, -- Nightmare_Diremite
    [DMB+204] = { id =  DMB+204}, -- Nightmare_Diremite
    [DMB+205] = { id =  DMB+205}, -- Nightmare_Diremite
    [DMB+206] = { id =  DMB+206}, -- Nightmare_Diremite
    [DMB+207] = { id =  DMB+207}, -- Nightmare_Diremite
    [DMB+208] = { id =  DMB+208}, -- Nightmare_Diremite
    [DMB+209] = { id =  DMB+209}, -- Nightmare_Diremite
    [DMB+210] = { id =  DMB+210}, -- Nightmare_Diremite
    [DMB+269] = { id =  DMB+269}, -- Nightmare_Diremite
    [DMB+270] = { id =  DMB+270}, -- Nightmare_Diremite
    [DMB+271] = { id =  DMB+271}, -- Nightmare_Diremite
    [DMB+272] = { id =  DMB+272}, -- Nightmare_Diremite
    [DMB+273] = { id =  DMB+273}, -- Nightmare_Diremite
    [DMB+274] = { id =  DMB+274}, -- Nightmare_Diremite
    [DMB+275] = { id =  DMB+275}, -- Nightmare_Diremite
    [DMB+276] = { id =  DMB+276}, -- Nightmare_Diremite
    [DMB+277] = { id =  DMB+277}, -- Nightmare_Diremite
    [DMB+522] = { id =  DMB+522}, -- Nightmare_Diremite
    [DMB+523] = { id =  DMB+523}, -- Nightmare_Diremite
    [DMB+168] = { id =  DMB+168}, -- Nightmare_Gaylas
    [DMB+169] = { id =  DMB+169}, -- Nightmare_Gaylas
    [DMB+170] = { id =  DMB+170}, -- Nightmare_Gaylas
    [DMB+171] = { id =  DMB+171}, -- Nightmare_Gaylas
    [DMB+172] = { id =  DMB+172}, -- Nightmare_Gaylas
    [DMB+173] = { id =  DMB+173}, -- Nightmare_Gaylas
    [DMB+174] = { id =  DMB+174}, -- Nightmare_Gaylas
    [DMB+175] = { id =  DMB+175}, -- Nightmare_Gaylas
    [DMB+176] = { id =  DMB+176}, -- Nightmare_Gaylas
    [DMB+177] = { id =  DMB+177}, -- Nightmare_Gaylas
    [DMB+178] = { id =  DMB+178}, -- Nightmare_Gaylas
    [DMB+179] = { id =  DMB+179}, -- Nightmare_Gaylas
    [DMB+180] = { id =  DMB+180}, -- Nightmare_Gaylas
    [DMB+181] = { id =  DMB+181}, -- Nightmare_Gaylas
    [DMB+182] = { id =  DMB+182}, -- Nightmare_Gaylas
    [DMB+183] = { id =  DMB+183}, -- Nightmare_Gaylas
    [DMB+278] = { id =  DMB+278}, -- Nightmare_Gaylas
    [DMB+279] = { id =  DMB+279}, -- Nightmare_Gaylas
    [DMB+280] = { id =  DMB+280}, -- Nightmare_Gaylas
    [DMB+281] = { id =  DMB+281}, -- Nightmare_Gaylas
    [DMB+282] = { id =  DMB+282}, -- Nightmare_Gaylas
    [DMB+283] = { id =  DMB+283}, -- Nightmare_Gaylas
    [DMB+284] = { id =  DMB+284}, -- Nightmare_Gaylas
    [DMB+285] = { id =  DMB+285}, -- Nightmare_Gaylas
    [DMB+286] = { id =  DMB+286}, -- Nightmare_Gaylas
    [DMB+287] = { id =  DMB+287}, -- Nightmare_Gaylas
    [DMB+288] = { id =  DMB+288}, -- Nightmare_Gaylas
    [DMB+289] = { id =  DMB+289}, -- Nightmare_Gaylas
    [DMB+524] = { id =  DMB+524}, -- Nightmare_Gaylas

    -- Wave 2 Statues based on https://enedin.be/dyna/html/zone/frame_quf2.htm
    -- Southwest Area
    [SMB+385] = { id =  SMB+385}, -- Goblin_Replica (065-G)
    [SMB+386] = { id =  SMB+386}, -- Goblin_Replica (065-G)
    [SMB+387] = { id =  SMB+387}, -- Goblin_Replica (065-G)
    [SMB+525] = { id =  SMB+525}, -- Goblin_Replica (065-G)
    -- Northeast Area
    [SMB+484] = { id =  SMB+484}, -- Goblin_Replica (065-G)
    [SMB+485] = { id =  SMB+485}, -- Goblin_Replica (065-G)
    -- Central Area
    [SMB+519] = { id =  SMB+519}, -- Goblin_Replica (071-G)
    [SMB+520] = { id =  SMB+520}, -- Goblin_Replica (072-G)
    [SMB+521] = { id =  SMB+521}, -- Goblin_Replica (073-G)
    [SMB+522] = { id =  SMB+522}, -- Goblin_Replica (074-G)
    [SMB+523] = { id =  SMB+523}, -- Goblin_Replica (075-G)

    -- All Statue Spawnable Mobs
    [SMB+107] = { id =  SMB+107},
    [SMB+84 ] = { id =  SMB+84 },
    [SMB+106] = { id =  SMB+106},
    [SMB+85 ] = { id =  SMB+85 },
    [SMB+95 ] = { id =  SMB+95 },
    [SMB+374] = { id =  SMB+374},
    [SMB+383] = { id =  SMB+383},
    [SMB+109] = { id =  SMB+109},
    [SMB+96 ] = { id =  SMB+96 },
    [SMB+86 ] = { id =  SMB+86 },
    [SMB+104] = { id =  SMB+104},
    [SMB+4  ] = { id =  SMB+4  },
    [SMB-5  ] = { id =  SMB-5  },
    [SMB+19 ] = { id =  SMB+19 },
    [SMB+6  ] = { id =  SMB+6  },
    [SMB+7  ] = { id =  SMB+7  },
    [SMB-2  ] = { id =  SMB-2  },
    [SMB-4  ] = { id =  SMB-4  },
    [SMB+14 ] = { id =  SMB+14 },
    [SMB+15 ] = { id =  SMB+15 },
    [SMB+5  ] = { id =  SMB+5  },
    [SMB+8  ] = { id =  SMB+8  },
    [SMB+332] = { id =  SMB+332},
    [SMB+313] = { id =  SMB+313},
    [SMB-6  ] = { id =  SMB-6  },
    [SMB+18 ] = { id =  SMB+18 },
    [SMB-3  ] = { id =  SMB-3  },
    [SMB+16 ] = { id =  SMB+16 },
    [SMB+105] = { id =  SMB+105},
    [SMB+98 ] = { id =  SMB+98 },
    [SMB+97 ] = { id =  SMB+97 },
    [SMB+94 ] = { id =  SMB+94 },
    [SMB+88 ] = { id =  SMB+88 },
    [SMB+87 ] = { id =  SMB+87 },
    [SMB+24 ] = { id =  SMB+24 },
    [SMB+25 ] = { id =  SMB+25 },
    [SMB+45 ] = { id =  SMB+45 },
    [SMB+34 ] = { id =  SMB+34 },
    [SMB+35 ] = { id =  SMB+35 },
    [SMB+37 ] = { id =  SMB+37 },
    [SMB+36 ] = { id =  SMB+36 },
    [SMB+29 ] = { id =  SMB+29 },
    [SMB+44 ] = { id =  SMB+44 },
    [SMB+26 ] = { id =  SMB+26 },
    [SMB+28 ] = { id =  SMB+28 },
    [SMB+46 ] = { id =  SMB+46 },
    [SMB+412] = { id =  SMB+412},
    [SMB+48 ] = { id =  SMB+48 },
    [SMB+401] = { id =  SMB+401},
    [SMB+410] = { id =  SMB+410},
    [SMB+411] = { id =  SMB+411},
    [SMB+403] = { id =  SMB+403},
    [SMB+47 ] = { id =  SMB+47 },
    [SMB+409] = { id =  SMB+409},
    [SMB+419] = { id =  SMB+419},
    [SMB+400] = { id =  SMB+400},
    [SMB+413] = { id =  SMB+413},
    [SMB+57 ] = { id =  SMB+57 },
    [SMB+77 ] = { id =  SMB+77 },
    [SMB+54 ] = { id =  SMB+54 },
    [SMB+74 ] = { id =  SMB+74 },
    [SMB+66 ] = { id =  SMB+66 },
    [SMB+76 ] = { id =  SMB+76 },
    [SMB+78 ] = { id =  SMB+78 },
    [SMB+69 ] = { id =  SMB+69 },
    [SMB+58 ] = { id =  SMB+58 },
    [SMB+55 ] = { id =  SMB+55 },
    [SMB+75 ] = { id =  SMB+75 },
    [SMB+64 ] = { id =  SMB+64 },
    [SMB+67 ] = { id =  SMB+67 },
    [SMB+56 ] = { id =  SMB+56 },
    [SMB+65 ] = { id =  SMB+65 },
    [SMB+77 ] = { id =  SMB+77 },
    [SMB+363] = { id =  SMB+363},
    [SMB+371] = { id =  SMB+371},
    [SMB+383] = { id =  SMB+383},
    [SMB+382] = { id =  SMB+382},
    [SMB+374] = { id =  SMB+374},
    [SMB+373] = { id =  SMB+373},
    [SMB+362] = { id =  SMB+362},
    [SMB+381] = { id =  SMB+381},
    [SMB+343] = { id =  SMB+343},
    [SMB+364] = { id =  SMB+364},
    [SMB+372] = { id =  SMB+372},
    [SMB+341] = { id =  SMB+341},
    [SMB+482] = { id =  SMB+482},
    [SMB+422] = { id =  SMB+422},
    [SMB+380] = { id =  SMB+380},
    [SMB+502] = { id =  SMB+502},
    [SMB+485] = { id =  SMB+485},
    [SMB+341] = { id =  SMB+341},
    [SMB+342] = { id =  SMB+342},
    [SMB+488] = { id =  SMB+488},
    [SMB+345] = { id =  SMB+345},
    [SMB+490] = { id =  SMB+490},
    [SMB+492] = { id =  SMB+492},
    [SMB+494] = { id =  SMB+494},
    [SMB+487] = { id =  SMB+487},
    [SMB+498] = { id =  SMB+498},
    [SMB+486] = { id =  SMB+486},
    [SMB+496] = { id =  SMB+496},
    [SMB+484] = { id =  SMB+484},
    [SMB+489] = { id =  SMB+489},
    [SMB+499] = { id =  SMB+499},
    [SMB+495] = { id =  SMB+495},
    [SMB+501] = { id =  SMB+501},
    [SMB+493] = { id =  SMB+493},
    [SMB+491] = { id =  SMB+491},
    [SMB+526] = { id =  SMB+526},
    [SMB+527] = { id =  SMB+527},
    [SMB+506] = { id =  SMB+506},
    [SMB+528] = { id =  SMB+528},
    [SMB+529] = { id =  SMB+529},
    [SMB+500] = { id =  SMB+500},
    [SMB+503] = { id =  SMB+503},
    [SMB+505] = { id =  SMB+505},
    [SMB+497] = { id =  SMB+497},
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_QUFIM

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- Statues Wave 1 and Wave 2
mobList[zone][SMB+30 ].pos = { -260.608, -19.032, 43.783, 6    } -- (001-Q)
mobList[zone][SMB+31 ].pos = { -249.283, -19.988, 45.831, 6    } -- (002-Q)
mobList[zone][SMB+32 ].pos = { -207.631, -19.944, 106.263, 28  } -- (003-Q)
mobList[zone][SMB+40 ].pos = { -193.663, -19.635, 131.329, 68  } -- (004-Q)
mobList[zone][SMB+41 ].pos = { -205.758, -20.089, 162.879, 203 } -- (005-Q)
mobList[zone][SMB+42 ].pos = { -118.681, 20.019, 195.651, 27   } -- (006-Q)
mobList[zone][SMB+50 ].pos = { -116.667, -19.829, 207.454, 48  } -- (007-Q)
mobList[zone][SMB+60 ].pos = { -1.307, -19.138, -17.269, 129   } -- (008-Y)
mobList[zone][SMB+61 ].pos = { 13.437, -20.824, -21.301, 128   } -- (009-Y)
mobList[zone][SMB+62 ].pos = { 37.826, -19.383, -14.216, 237   } -- (010-Y)
mobList[zone][SMB+70 ].pos = { 60.955, -19.612, 11.245, 81     } -- (011-Y)
mobList[zone][SMB+71 ].pos = { 81.461, -19.891, 6.198, 107     } -- (012-Y)
mobList[zone][SMB+72 ].pos = { 93.956, -20.051, -14.926, 137   } -- (013-Y)
mobList[zone][SMB+80 ].pos = { 109.566, -19.994, -6.029, 113   } -- (014-Y)
mobList[zone][SMB+81 ].pos = { 121.584, -20.000, 0.963, 180    } -- (015-Y)
mobList[zone][SMB+0  ].pos = { 140.120, -19.025, 75.671, 154   } -- (016-O)
mobList[zone][SMB+1  ].pos = { 138.601, -19.895, 65.463, 165   } -- (017-O)
mobList[zone][SMB+2  ].pos = { 151.705, -19.830, 68.108, 146   } -- (018-O)
mobList[zone][SMB+10 ].pos = { 101.349, -20.176, 150.119, 38   } -- (019-O)
mobList[zone][SMB+11 ].pos = { 111.338, -19.739, 150.965, 48   } -- (020-O)
mobList[zone][SMB+12 ].pos = { 55.335, -19.323, 234.979, 79    } -- (021-O)
mobList[zone][SMB+20 ].pos = { 56.364, -20.275, 249.147, 44    } -- (022-O)
mobList[zone][SMB+21 ].pos = { 0.556, -20.427, 242.431, 50     } -- (023-O)
mobList[zone][SMB+22 ].pos = { 1.133, -19.029, 260.556, 129    } -- (024-O)
mobList[zone][SMB+90 ].pos = { -91.348, -19.634, 242.081, 171  } -- (025-G)
mobList[zone][SMB+91 ].pos = { -85.062, -19.723, 267.683, 91   } -- (026-G)
mobList[zone][SMB+92 ].pos = { -216.469, -19.178, 319.638, 255 } -- (027-G)
mobList[zone][SMB+100].pos = { -254.048, -20.000, 300.553, 224 } -- (028-G)
mobList[zone][SMB+101].pos = { -256.694, -20.000, 313.411, 231 } -- (029-G)
mobList[zone][SMB+102].pos = { -253.725, -20.000, 329.286, 9   } -- (030-G)
mobList[zone][SMB+110].pos = { -250.551, -19.933, 341.246, 43  } -- (031-G)
mobList[zone][SMB+111].pos = { -288.097, -11.721, 475.140, 225 } -- (032-G)
mobList[zone][SMB+112].pos = { -312.791, -11.762, 483.752, 247 } -- (033-G)
mobList[zone][SMB+346].pos = { -546.876, -8.836, 416.088, 8    } -- (034-G)
mobList[zone][SMB+347].pos = { -550.221, -7.494, 422.123, 13   } -- (035-G)
mobList[zone][SMB+348].pos = { 174.031, 20.747, -202.030, 204  } -- (036-G)
mobList[zone][SMB+367].pos = { 163.990, 20.081, -208.679, 232  } -- (037-G)
mobList[zone][SMB+368].pos = { 140.386, 17.982, -431.949, 214  } -- (038-G)
mobList[zone][SMB+369].pos = { 142.936, 18.121, -436.945, 196  } -- (039-G)
mobList[zone][SMB+385].pos = { -108.072, -20.30, 191.006, 154  } -- (065-G)
mobList[zone][SMB+386].pos = { -112.225, -20.560, 188.736, 160 } -- (066-G)
mobList[zone][SMB+387].pos = { -77.407, -19.770, 19.093, 134   } -- (067-G)
mobList[zone][SMB+525].pos = { -59.591, -19.733, -2.097, 34    } -- (068-G)
mobList[zone][SMB+484].pos = { 21.350, -19.769, 187.950, 155   } -- (069-G)
mobList[zone][SMB+485].pos = { -2.647, -20.584, 191.007, 239   } -- (070-G)
mobList[zone][SMB+519].pos = { -44.788, -20.040, 122.724, 162  } -- (071-G)
mobList[zone][SMB+520].pos = { -45.871, -20.082, 75.716, 94    } -- (072-G)
mobList[zone][SMB+521].pos = { 5.245, -20.007, 125.149, 223    } -- (073-G)
mobList[zone][SMB+522].pos = { -7.265, -18.019, 101.000, 9     } -- (074-G)
mobList[zone][SMB+523].pos = { -18.812, -17.300, 104.154, 9    } -- (075-G)
-- Wave 1 Nightmare Mobs + NMs + Elementals Based on https://enedin.be/dyna/html/zone/frame_quf1.htm
mobList[zone][DMB+152].pos = { -61.614, -19.824, 36.806, 64    } -- ( 051 )
mobList[zone][DMB+156].pos = { 21.479, -19.832, 153.201, 79    } -- ( 052 )
mobList[zone][DMB+160].pos = { -60.969, -19.775, 153.545, 54   } -- ( 053 )
mobList[zone][DMB+164].pos = { 143.273, 21.394, -348.023, 144  } -- ( 062 )
mobList[zone][DMB+255].pos = { 153.181, 20.601, -370.837, 193  } -- ( 063 )
mobList[zone][DMB+211].pos = { 153.580, -19.718, -20.217, 128  } -- ( 061 )
mobList[zone][DMB+251].pos = { -221.369, -19.805, 437.399, 56  } -- ( 048 )
mobList[zone][DMB+229].pos = { -136.073, -20.377, 344.4214, 102} -- ( 054 )
mobList[zone][DMB+233].pos = { -132.776, -19.527, 320.005, 118 } -- ( 055 )
mobList[zone][DMB+237].pos = { -156.819, -20.000, 362.471, 98  } -- ( 056 )
mobList[zone][DMB+241].pos = { -157.837, -19.317, 334.877, 115 } -- ( 057 )
mobList[zone][DMB+245].pos = { -475.226, -11.232, 385.530, 207 } -- ( 059 )
mobList[zone][DMB+249].pos = { -496.717, -12.481, 379.136, 236 } -- ( 060 )
mobList[zone][DMB+134].pos = { -264.477, -3.417, 24.961, 60    } -- ( 040 )
mobList[zone][DMB+167].pos = { 149.787, 21.221, -409.158, 185  } -- ( 041 )
mobList[zone][DMB+0  ].pos = { -257.040, -20.000, 319.628, 254 } -- ( 064 )
mobList[zone][DMB+228].pos = { -535.544, -13.042, 386.895, 51  } -- ( 042 )
mobList[zone][EMB+0  ].pos = { -278.296, -19.902, 74.020, 57   } -- ( 043 )
mobList[zone][EMB+12 ].pos = { 19.150, -19.260, -86.259, 193   } -- ( 044 )
mobList[zone][EMB+3  ].pos = { 158.148, 20.219, -230.048, 184  } -- ( 045 )
mobList[zone][EMB+4  ].pos = { 163.632, -19.481, 133.232, 94   } -- ( 046 )
mobList[zone][EMB+5  ].pos = { 29.825, -19.906, 288.771, 77    } -- ( 047 )
mobList[zone][EMB+6  ].pos = { -214.001, -19.742, 392.671, 60  } -- ( 048 )
mobList[zone][EMB+7  ].pos = { -338.197, -12.949, 531.737, 70  } -- ( 049 )
mobList[zone][EMB+13 ].pos = { -428.031, -12.956, 337.849, 136 } -- ( 050 )
-- Wave 2 Nightmare Mobs Based on https://enedin.be/dyna/html/zone/frame_quf2.htm
mobList[zone][DMB+135].pos = { -121.628, -19.756, 208.912, 96  } -- ( 076 )
mobList[zone][DMB+138].pos = { -134.926, -19.311, 196.783, 161 } -- ( 077 )
mobList[zone][DMB+141].pos = { -146.120, -20.016, 210.193, 132 } -- ( 078 )
mobList[zone][DMB+144].pos = { -130.309, -19.514, 223.921, 94  } -- ( 079 )
mobList[zone][DMB+147].pos = { -152.466, -19.784, 228.106, 80  } -- ( 080 )
mobList[zone][DMB+150].pos = { -180.295, -19.421, 234.489, 124 } -- ( 081 )
mobList[zone][DMB+397].pos = { -179.492, -19.027, 202.111, 128 } -- ( 082 )
mobList[zone][DMB+400].pos = { -204.581, -19.972, 196.347, 177 } -- ( 083 )
mobList[zone][DMB+403].pos = { -232.019, -19.347, 217.225, 225 } -- ( 084 )
mobList[zone][DMB+514].pos = { -223.150, -19.996, 252.186, 131 } -- ( 085 )
mobList[zone][DMB+121].pos = { -218.359, -19.083, 38.272, 239  } -- ( 086 )
mobList[zone][DMB+124].pos = { -243.159, -20.207, 27.225, 198  } -- ( 087 )
mobList[zone][DMB+126].pos = { -250.003, -20.170, 47.660, 69   } -- ( 088 )
mobList[zone][DMB+128].pos = { -265.529, -19.342, 39.694, 8    } -- ( 089 )
mobList[zone][DMB+130].pos = { -276.600, -19.065, 61.284, 83   } -- ( 090 )
mobList[zone][DMB+132].pos = { -294.936, -20.308, 50.588, 29   } -- ( 091 )
mobList[zone][DMB+290].pos = { -282.784, -19.906, 23.687, 238  } -- ( 092 )
mobList[zone][DMB+292].pos = { -277.102, -20.299, 87.588, 87   } -- ( 093 )
mobList[zone][DMB+294].pos = { -311.925, -19.710, 58.419, 10   } -- ( 094 )
mobList[zone][DMB+296].pos = { -332.640, -20.770, 56.555, 26   } -- ( 095 )
mobList[zone][DMB+298].pos = { -341.548, -20.000, 40.281, 235  } -- ( 096 )
mobList[zone][DMB+300].pos = { -304.406, -13.677, 26.310, 162  } -- ( 097 )
mobList[zone][DMB+302].pos = { -287.617, -6.243, 14.683, 150   } -- ( 098 )
mobList[zone][DMB+184].pos = { -5.263, -19.257, -17.494, 134   } -- ( 099 )
mobList[zone][DMB+189].pos = { 9.803, -19.711, 2.171, 83       } -- ( 100 )
mobList[zone][DMB+193].pos = { 16.809, -19.160, -37.493, 160   } -- ( 101 )
mobList[zone][DMB+358].pos = { 31.847, -19.619, -23.678, 129   } -- ( 102 )
mobList[zone][DMB+362].pos = { 26.496, -19.454, 2.021, 98      } -- ( 103 )
mobList[zone][DMB+366].pos = { 42.812, -19.072, -18.570, 125   } -- ( 104 )
mobList[zone][DMB+518].pos = { 42.515, -20.000, -43.731, 152   } -- ( 105 )
mobList[zone][DMB+214].pos = { 130.669, -19.668, 82.273, 117   } -- ( 106 )
mobList[zone][DMB+216].pos = { 148.374, -19.620, 76.792, 122   } -- ( 107 )
mobList[zone][DMB+218].pos = { 160.662, -19.133, 97.363, 111   } -- ( 108 )
mobList[zone][DMB+220].pos = { 145.314, -19.913, 105.753, 129  } -- ( 109 )
mobList[zone][DMB+222].pos = { 123.742, -19.506, 107.013, 90   } -- ( 110 )
mobList[zone][DMB+224].pos = { 119.467, -20.012, 123.786, 77   } -- ( 111 )
mobList[zone][DMB+226].pos = { 139.221, -19.040, 121.758, 128  } -- ( 112 )
mobList[zone][DMB+436].pos = { 157.073, -20.000, 120.170, 126  } -- ( 113 )
mobList[zone][DMB+438].pos = { 162.310, -19.547, 147.419, 96   } -- ( 114 )
mobList[zone][DMB+440].pos = { 146.681, -19.473, 160.135, 96   } -- ( 115 )
mobList[zone][DMB+442].pos = { 123.247, -19.623, 148.440, 78   } -- ( 116 )
mobList[zone][DMB+444].pos = { 196.789, -20.000, 119.545, 127  } -- ( 117 )
mobList[zone][DMB+196].pos = { -270.470, -10.747, 487.465, 231 } -- ( 118 )
mobList[zone][DMB+198].pos = { -275.038, -11.989, 471.655, 162 } -- ( 119 )
mobList[zone][DMB+200].pos = { -284.911, -12.086, 484.757, 245 } -- ( 120 )
mobList[zone][DMB+202].pos = { -296.533, -11.751, 491.319, 54  } -- ( 121 )
mobList[zone][DMB+204].pos = { -300.984, -11.000, 478.629, 248 } -- ( 122 )
mobList[zone][DMB+206].pos = { -298.767, -12.114, 463.578, 218 } -- ( 123 )
mobList[zone][DMB+208].pos = { -308.469, -12.394, 456.989, 202 } -- ( 124 )
mobList[zone][DMB+210].pos = { -320.408, -12.000, 472.749, 7   } -- ( 125 )
mobList[zone][DMB+270].pos = { -332.928, -12.946, 467.776, 207 } -- ( 126 )
mobList[zone][DMB+272].pos = { -316.672, -11.611, 450.671, 221 } -- ( 127 )
mobList[zone][DMB+274].pos = { -318.770, -11.912, 428.749, 215 } -- ( 128 )
mobList[zone][DMB+276].pos = { -332.708, -11.348, 443.779, 234 } -- ( 129 )
mobList[zone][DMB+522].pos = { -358.722, -12.000, 442.357, 2   } -- ( 130 )
mobList[zone][DMB+168].pos = { 255.054, -9.825, -20.566, 157   } -- ( 131 )
mobList[zone][DMB+171].pos = { 209.686, 21.250, -150.013, 232  } -- ( 132 )
mobList[zone][DMB+174].pos = { 191.926, 20.154, -154.146, 32   } -- ( 133 )
mobList[zone][DMB+177].pos = { 198.768, 20.933, -175.515, 216  } -- ( 134 )
mobList[zone][DMB+181].pos = { 185.369, 20.750, -195.772, 193  } -- ( 135 )
mobList[zone][DMB+279].pos = { 162.382, 20.186, -194.457, 241  } -- ( 136 )
mobList[zone][DMB+283].pos = { 153.565, 20.512, -214.524, 219  } -- ( 137 )
mobList[zone][DMB+287].pos = { 165.904, 20.263, -235.467, 209  } -- ( 138 )

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path.pos = { x, y, z, r} { 11, 22, 33, 66, 77, 88, }

-- set statue eye color
mobList[zone][SMB+90 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+91 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+92 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+346].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+347].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+520].eyes = dynamis.eyes.BLUE

-- set time extensions
mobList[zone][DMB+0  ].timeExtension = 60

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = {DMB+0} -- Antaeus Kill

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
-- Wave 1 Statues
mobList[zone][SMB+30 ].waves = { 1, nil, nil} -- (001-Q)
mobList[zone][SMB+31 ].waves = { 1, nil, nil} -- (002-Q)
mobList[zone][SMB+32 ].waves = { 1, nil, nil} -- (003-Q)
mobList[zone][SMB+40 ].waves = { 1, nil, nil} -- (004-Q)
mobList[zone][SMB+41 ].waves = { 1, nil, nil} -- (005-Q)
mobList[zone][SMB+42 ].waves = { 1, nil, nil} -- (006-Q)
mobList[zone][SMB+50 ].waves = { 1, nil, nil} -- (007-Q)
mobList[zone][SMB+60 ].waves = { 1, nil, nil} -- (008-Y)
mobList[zone][SMB+61 ].waves = { 1, nil, nil} -- (009-Y)
mobList[zone][SMB+62 ].waves = { 1, nil, nil} -- (010-Y)
mobList[zone][SMB+70 ].waves = { 1, nil, nil} -- (011-Y)
mobList[zone][SMB+71 ].waves = { 1, nil, nil} -- (012-Y)
mobList[zone][SMB+72 ].waves = { 1, nil, nil} -- (013-Y)
mobList[zone][SMB+80 ].waves = { 1, nil, nil} -- (014-Y)
mobList[zone][SMB+81 ].waves = { 1, nil, nil} -- (015-Y)
mobList[zone][SMB+0  ].waves = { 1, nil, nil} -- (016-O)
mobList[zone][SMB+1  ].waves = { 1, nil, nil} -- (017-O)
mobList[zone][SMB+2  ].waves = { 1, nil, nil} -- (018-O)
mobList[zone][SMB+10 ].waves = { 1, nil, nil} -- (019-O)
mobList[zone][SMB+11 ].waves = { 1, nil, nil} -- (020-O)
mobList[zone][SMB+12 ].waves = { 1, nil, nil} -- (021-O)
mobList[zone][SMB+20 ].waves = { 1, nil, nil} -- (022-O)
mobList[zone][SMB+21 ].waves = { 1, nil, nil} -- (023-O)
mobList[zone][SMB+22 ].waves = { 1, nil, nil} -- (024-O)
mobList[zone][SMB+90 ].waves = { 1, nil, nil} -- (025-G)
mobList[zone][SMB+91 ].waves = { 1, nil, nil} -- (026-G)
mobList[zone][SMB+92 ].waves = { 1, nil, nil} -- (027-G)
mobList[zone][SMB+111].waves = { 1, nil, nil} -- (032-G)
mobList[zone][SMB+112].waves = { 1, nil, nil} -- (033-G)
mobList[zone][SMB+346].waves = { 1, nil, nil} -- (034-G)
mobList[zone][SMB+347].waves = { 1, nil, nil} -- (035-G)
mobList[zone][SMB+348].waves = { 1, nil, nil} -- (036-G)
mobList[zone][SMB+367].waves = { 1, nil, nil} -- (037-G)
mobList[zone][SMB+368].waves = { 1, nil, nil} -- (038-G)
mobList[zone][SMB+369].waves = { 1, nil, nil} -- (039-G)
-- Wave 1 Nightmare Mobs
mobList[zone][DMB+152].waves = { 1, nil, nil}
mobList[zone][DMB+156].waves = { 1, nil, nil}
mobList[zone][DMB+160].waves = { 1, nil, nil}
mobList[zone][DMB+164].waves = { 1, nil, nil}
mobList[zone][DMB+255].waves = { 1, nil, nil}
mobList[zone][DMB+211].waves = { 1, nil, nil}
mobList[zone][DMB+251].waves = { 1, nil, nil}
mobList[zone][DMB+229].waves = { 1, nil, nil}
mobList[zone][DMB+233].waves = { 1, nil, nil}
mobList[zone][DMB+237].waves = { 1, nil, nil}
mobList[zone][DMB+241].waves = { 1, nil, nil}
mobList[zone][DMB+245].waves = { 1, nil, nil}
mobList[zone][DMB+249].waves = { 1, nil, nil}
-- Wave 1 Elementals and NMs
mobList[zone][EMB+0  ].waves = { 1, nil, nil} -- Water Elemental (43)
mobList[zone][DMB+134].waves = { 1, nil, nil} -- Scolopendra (40)
mobList[zone][EMB+12 ].waves = { 1, nil, nil} -- Fire Elemental (44)
mobList[zone][EMB+3  ].waves = { 1, nil, nil} -- Thunder Elemental (45)
mobList[zone][DMB+167].waves = { 1, nil, nil} -- Stringes (41)
mobList[zone][EMB+4  ].waves = { 1, nil, nil} -- Air Elemental (46)
mobList[zone][EMB+5  ].waves = { 1, nil, nil} -- Light Elemental (47)
mobList[zone][EMB+6  ].waves = { 1, nil, nil} -- Ice Elemental (48)
mobList[zone][DMB+0  ].waves = { 1, nil, nil} -- Antaeus (64)
mobList[zone][EMB+7  ].waves = { 1, nil, nil} -- Earth Elemental (49)
mobList[zone][EMB+13 ].waves = { 1, nil, nil} -- Dark Elemental (50)
mobList[zone][DMB+228].waves = { 1, nil, nil} -- Suttung (42)
-- Wave 2 Nightmare Mobs
mobList[zone][DMB+135].waves = { nil, 2, nil}
mobList[zone][DMB+138].waves = { nil, 2, nil}
mobList[zone][DMB+141].waves = { nil, 2, nil}
mobList[zone][DMB+144].waves = { nil, 2, nil}
mobList[zone][DMB+147].waves = { nil, 2, nil}
mobList[zone][DMB+150].waves = { nil, 2, nil}
mobList[zone][DMB+397].waves = { nil, 2, nil}
mobList[zone][DMB+400].waves = { nil, 2, nil}
mobList[zone][DMB+403].waves = { nil, 2, nil}
mobList[zone][DMB+514].waves = { nil, 2, nil}
mobList[zone][DMB+121].waves = { nil, 2, nil}
mobList[zone][DMB+124].waves = { nil, 2, nil}
mobList[zone][DMB+126].waves = { nil, 2, nil}
mobList[zone][DMB+128].waves = { nil, 2, nil}
mobList[zone][DMB+130].waves = { nil, 2, nil}
mobList[zone][DMB+132].waves = { nil, 2, nil}
mobList[zone][DMB+290].waves = { nil, 2, nil}
mobList[zone][DMB+292].waves = { nil, 2, nil}
mobList[zone][DMB+294].waves = { nil, 2, nil}
mobList[zone][DMB+296].waves = { nil, 2, nil}
mobList[zone][DMB+298].waves = { nil, 2, nil}
mobList[zone][DMB+300].waves = { nil, 2, nil}
mobList[zone][DMB+302].waves = { nil, 2, nil}
mobList[zone][DMB+184].waves = { nil, 2, nil}
mobList[zone][DMB+189].waves = { nil, 2, nil}
mobList[zone][DMB+193].waves = { nil, 2, nil}
mobList[zone][DMB+358].waves = { nil, 2, nil}
mobList[zone][DMB+362].waves = { nil, 2, nil}
mobList[zone][DMB+366].waves = { nil, 2, nil}
mobList[zone][DMB+518].waves = { nil, 2, nil}
mobList[zone][DMB+214].waves = { nil, 2, nil}
mobList[zone][DMB+216].waves = { nil, 2, nil}
mobList[zone][DMB+218].waves = { nil, 2, nil}
mobList[zone][DMB+220].waves = { nil, 2, nil}
mobList[zone][DMB+222].waves = { nil, 2, nil}
mobList[zone][DMB+224].waves = { nil, 2, nil}
mobList[zone][DMB+226].waves = { nil, 2, nil}
mobList[zone][DMB+436].waves = { nil, 2, nil}
mobList[zone][DMB+438].waves = { nil, 2, nil}
mobList[zone][DMB+440].waves = { nil, 2, nil}
mobList[zone][DMB+442].waves = { nil, 2, nil}
mobList[zone][DMB+444].waves = { nil, 2, nil}
mobList[zone][DMB+196].waves = { nil, 2, nil}
mobList[zone][DMB+198].waves = { nil, 2, nil}
mobList[zone][DMB+200].waves = { nil, 2, nil}
mobList[zone][DMB+202].waves = { nil, 2, nil}
mobList[zone][DMB+204].waves = { nil, 2, nil}
mobList[zone][DMB+206].waves = { nil, 2, nil}
mobList[zone][DMB+208].waves = { nil, 2, nil}
mobList[zone][DMB+210].waves = { nil, 2, nil}
mobList[zone][DMB+270].waves = { nil, 2, nil}
mobList[zone][DMB+272].waves = { nil, 2, nil}
mobList[zone][DMB+274].waves = { nil, 2, nil}
mobList[zone][DMB+276].waves = { nil, 2, nil}
mobList[zone][DMB+522].waves = { nil, 2, nil}
mobList[zone][DMB+168].waves = { nil, 2, nil}
mobList[zone][DMB+171].waves = { nil, 2, nil}
mobList[zone][DMB+174].waves = { nil, 2, nil}
mobList[zone][DMB+177].waves = { nil, 2, nil}
mobList[zone][DMB+181].waves = { nil, 2, nil}
mobList[zone][DMB+279].waves = { nil, 2, nil}
mobList[zone][DMB+283].waves = { nil, 2, nil}
mobList[zone][DMB+287].waves = { nil, 2, nil}
-- Wave 2 Statues
mobList[zone][SMB+385].waves = { nil, 2, nil}  -- (065-G)
mobList[zone][SMB+386].waves = { nil, 2, nil}  -- (066-G)
mobList[zone][SMB+387].waves = { nil, 2, nil}  -- (067-G)
mobList[zone][SMB+525].waves = { nil, 2, nil}  -- (068-G)
mobList[zone][SMB+484].waves = { nil, 2, nil}  -- (069-G)
mobList[zone][SMB+485].waves = { nil, 2, nil}  -- (070-G)
mobList[zone][SMB+519].waves = { nil, 2, nil}  -- (071-G)
mobList[zone][SMB+520].waves = { nil, 2, nil}  -- (072-G)
mobList[zone][SMB+521].waves = { nil, 2, nil}  -- (073-G)
mobList[zone][SMB+522].waves = { nil, 2, nil}  -- (074-G)
mobList[zone][SMB+523].waves = { nil, 2, nil}  -- (075-G)

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- Wave 1 based on https://enedin.be/dyna/html/zone/frame_quf1.htm
-- Boss Area
mobList[zone][DMB+0  ].specificChildren = { true, SMB+100,                                     --                          (028-G)
                                            SMB+101,                                           --                          (029-G)
                                            SMB+102,                                           --                          (030-G)
                                            SMB+110                                          } --                          (031-G)
mobList[zone][SMB+92 ].specificChildren = { true, SMB+107                                    } -- BST                      (027-G)
mobList[zone][SMB+100].specificChildren = { true, SMB+84, SMB+106, SMB+85, SMB+95            } -- WAR, PLD, RDM, BLM       (028-G)
mobList[zone][SMB+101].specificChildren = { true, SMB+374                                    } -- DRG                      (029-G)
mobList[zone][SMB+102].specificChildren = { true, SMB+383                                    } -- SMN                      (030-G)
mobList[zone][SMB+110].specificChildren = { true, SMB+109, SMB+96, SMB+86, SMB+104           } -- SAM, DRK, RNG, WHM       (031-G)
-- Northeast
mobList[zone][SMB+0  ].specificChildren = { true, SMB+4, SMB-5, SMB+19                       } --  MNK, WHM, NIN           (016-O)
mobList[zone][SMB+1  ].specificChildren = { true, SMB+6                                      } --  PLD                     (017-O)
mobList[zone][SMB+2  ].specificChildren = { true, SMB+7, SMB-2                               } --  BRD, DRG                (018-O)
mobList[zone][SMB+10 ].specificChildren = { true, SMB-4, SMB+14                              } --  RDM, BLM                (019-O)
mobList[zone][SMB+11 ].specificChildren = { true, SMB+15                                     } --  DRK                     (020-O)
mobList[zone][SMB+12 ].specificChildren = { true, SMB+5, SMB+8, SMB+332                      } --  THF, SMN, MNK           (021-O)
mobList[zone][SMB+20 ].specificChildren = { true, SMB+313                                    } --  DRK                     (022-O)
mobList[zone][SMB+21 ].specificChildren = { true, SMB-6, SMB+18, SMB-3, SMB+16               } --  WAR, SAM, RNG, BST      (024-O)
mobList[zone][SMB+90 ].specificChildren = { true, SMB+105, SMB+98, SMB+97                    } --  THF, SMN, BRD           (025-G)
mobList[zone][SMB+91 ].specificChildren = { true, SMB+94, SMB+88, SMB+87                     } --  MNK, DRG, NIN           (026-G)
-- Sea Monk NM Area
mobList[zone][SMB+30 ].specificChildren = { true, SMB+24, SMB+25, SMB+45                     } --  MNK, BLM, THF           (001-Q)
mobList[zone][SMB+31 ].specificChildren = { true, SMB+34, SMB+35, SMB+37                     } --  WAR, RDM, NIN           (002-Q)
-- Southwest
mobList[zone][SMB+32 ].specificChildren = { true, SMB+36, SMB+29, SMB+44                     } --  PLD, SAM, WHM           (003-Q)
mobList[zone][SMB+40 ].specificChildren = { true, SMB+26, SMB+28                             } --  BST, RNG                (004-Q)
mobList[zone][SMB+41 ].specificChildren = { true, SMB+46, SMB+412, SMB+48                    } --  DRK, NIN, DRG           (005-Q)
mobList[zone][SMB+42 ].specificChildren = { true, SMB+401, SMB+410, SMB+411, SMB+403, SMB+47 } --  BST, RDM, PLD, RNG, BRD (006-Q)
mobList[zone][SMB+50 ].specificChildren = { true, SMB+409, SMB+419, SMB+400, SMB+413         } --  WAR, WHM, BLM, SMN      (007-Q)
mobList[zone][SMB+60 ].specificChildren = { true, SMB+57, SMB+77                             } --  DRK, SAM                (008-Y)
mobList[zone][SMB+61 ].specificChildren = { true, SMB+54, SMB+74, SMB+66, SMB+76             } --  WAR, RDM, BRD, RNG      (009-Y)
mobList[zone][SMB+62 ].specificChildren = { true, SMB+78                                     } --  SMN                     (010-Y)
mobList[zone][SMB+70 ].specificChildren = { true, SMB+69, SMB+58                             } --  NIN, BST                (011-Y)
mobList[zone][SMB+72 ].specificChildren = { true, SMB+55, SMB+75, SMB+64                     } --  MNK, THF, WHM           (013-Y)
mobList[zone][SMB+80 ].specificChildren = { true, SMB+67                                     } --  DRG                     (014-Y)
mobList[zone][SMB+81 ].specificChildren = { true, SMB+56, SMB+65, SMB+77                     } --  PLD, BLM, SAM           (015-Y)
-- Golem NM Area
mobList[zone][SMB+111].specificChildren = { true, SMB+363, SMB+371, SMB+383                  } -- THF, RDM, SMN            (032-G)
mobList[zone][SMB+112].specificChildren = { true, SMB+382, SMB+374, SMB+373                  } -- BRD. DRG. NIN            (033-G)
-- Giant Bat NM Area
mobList[zone][SMB+348].specificChildren = { true, SMB+362, SMB+381, SMB+343                  } -- WAR, BLM, BST            (036-G)
mobList[zone][SMB+367].specificChildren = { true, SMB+364, SMB+372, SMB+341                  } -- DRK, RNG, WHM            (037-G)
-- Wave 2 based on https://enedin.be/dyna/html/zone/frame_quf2.htm
-- Southwest
mobList[zone][SMB+385].specificChildren = { true, SMB+486, SMB+526, SMB+380, SMB+506         } --  THF, BRD, MNK, RNG      (065-G)
mobList[zone][SMB+386].specificChildren = { true, SMB+489, SMB+490, SMB+342, SMB+492         } --  MNK, WHM, PLD, SMN      (066-G)
mobList[zone][SMB+387].specificChildren = { true, SMB+345, SMB+494, SMB+496, SMB+528, SMB+498} --  SAM, BLM, RDM, MNK, WAR (067-G)
mobList[zone][SMB+525].specificChildren = { true, SMB+527, SMB+502, SMB+529, SMB+500         } --  PLD, DRK, WHM, BST      (068-G)
-- Northeast
mobList[zone][SMB+484].specificChildren = { true, SMB+488, SMB+487, SMB+493, SMB+503         } --  THF, BRD, SAM, DRG      (069-G)
mobList[zone][SMB+485].specificChildren = { true, SMB+499, SMB+505, SMB+497, SMB+495         } --  WAR, NIN, RDM, BLM      (070-G)

-- Nightmares
-- Wave 1
mobList[zone][DMB+152].specificChildren = { true, DMB+153, DMB+154, DMB+155                  } -- ( 051 )
mobList[zone][DMB+156].specificChildren = { true, DMB+157, DMB+158, DMB+159                  } -- ( 052 )
mobList[zone][DMB+160].specificChildren = { true, DMB+161, DMB+162, DMB+163                  } -- ( 053 )
mobList[zone][DMB+164].specificChildren = { true, DMB+165, DMB+166, DMB+254                  } -- ( 062 )
mobList[zone][DMB+255].specificChildren = { true, DMB+256, DMB+257                           } -- ( 063 )
mobList[zone][DMB+211].specificChildren = { true, DMB+212, DMB+213                           } -- ( 061 )
mobList[zone][DMB+251].specificChildren = { true, DMB+252, DMB+253                           } -- ( 048 )
mobList[zone][DMB+229].specificChildren = { true, DMB+230, DMB+231, DMB+232                  } -- ( 054 )
mobList[zone][DMB+233].specificChildren = { true, DMB+234, DMB+235, DMB+236                  } -- ( 055 )
mobList[zone][DMB+237].specificChildren = { true, DMB+238, DMB+239, DMB+240                  } -- ( 056 )
mobList[zone][DMB+241].specificChildren = { true, DMB+242, DMB+243, DMB+244                  } -- ( 057 )
mobList[zone][DMB+245].specificChildren = { true, DMB+246, DMB+247, DMB+248                  } -- ( 059 )
mobList[zone][DMB+249].specificChildren = { true, DMB+305, DMB+306, DMB+307                  } -- ( 060 )

-- Wave 2
mobList[zone][DMB+135].specificChildren = { true, DMB+136, DMB+137                           } -- ( 076 )
mobList[zone][DMB+138].specificChildren = { true, DMB+139, DMB+140                           } -- ( 077 )
mobList[zone][DMB+141].specificChildren = { true, DMB+142, DMB+143                           } -- ( 078 )
mobList[zone][DMB+144].specificChildren = { true, DMB+145, DMB+146                           } -- ( 079 )
mobList[zone][DMB+147].specificChildren = { true, DMB+148, DMB+149                           } -- ( 080 )
mobList[zone][DMB+150].specificChildren = { true, DMB+151, DMB+396                           } -- ( 081 )
mobList[zone][DMB+397].specificChildren = { true, DMB+398, DMB+399                           } -- ( 082 )
mobList[zone][DMB+400].specificChildren = { true, DMB+401, DMB+402                           } -- ( 083 )
mobList[zone][DMB+403].specificChildren = { true, DMB+404, DMB+405                           } -- ( 084 )
mobList[zone][DMB+514].specificChildren = { true, DMB+515, DMB+516                           } -- ( 085 )
mobList[zone][DMB+121].specificChildren = { true, DMB+122, DMB+123                           } -- ( 086 )
mobList[zone][DMB+124].specificChildren = { true, DMB+125                                    } -- ( 087 )
mobList[zone][DMB+126].specificChildren = { true, DMB+127                                    } -- ( 088 )
mobList[zone][DMB+128].specificChildren = { true, DMB+129                                    } -- ( 089 )
mobList[zone][DMB+130].specificChildren = { true, DMB+131                                    } -- ( 090 )
mobList[zone][DMB+132].specificChildren = { true, DMB+133                                    } -- ( 091 )
mobList[zone][DMB+290].specificChildren = { true, DMB+291                                    } -- ( 092 )
mobList[zone][DMB+292].specificChildren = { true, DMB+293                                    } -- ( 093 )
mobList[zone][DMB+294].specificChildren = { true, DMB+295                                    } -- ( 094 )
mobList[zone][DMB+296].specificChildren = { true, DMB+297                                    } -- ( 095 )
mobList[zone][DMB+298].specificChildren = { true, DMB+299                                    } -- ( 096 )
mobList[zone][DMB+300].specificChildren = { true, DMB+301                                    } -- ( 097 )
mobList[zone][DMB+302].specificChildren = { true, DMB+303                                    } -- ( 098 )
mobList[zone][DMB+184].specificChildren = { true, DMB+185, DMB+186, DMB+187, DMB+188         } -- ( 099 )
mobList[zone][DMB+189].specificChildren = { true, DMB+190, DMB+191, DMB+192, DMB+193         } -- ( 100 )
mobList[zone][DMB+193].specificChildren = { true, DMB+194, DMB+195, DMB+357                  } -- ( 101 )
mobList[zone][DMB+358].specificChildren = { true, DMB+359, DMB+360, DMB+361                  } -- ( 102 )
mobList[zone][DMB+362].specificChildren = { true, DMB+363, DMB+364, DMB+365                  } -- ( 103 )
mobList[zone][DMB+366].specificChildren = { true, DMB+367, DMB+368, DMB+517                  } -- ( 104 )
mobList[zone][DMB+518].specificChildren = { true, DMB+519, DMB+520, DMB+521                  } -- ( 105 )
mobList[zone][DMB+214].specificChildren = { true, DMB+215                                    } -- ( 106 )
mobList[zone][DMB+216].specificChildren = { true, DMB+217                                    } -- ( 107 )
mobList[zone][DMB+218].specificChildren = { true, DMB+219                                    } -- ( 108 )
mobList[zone][DMB+220].specificChildren = { true, DMB+221                                    } -- ( 109 )
mobList[zone][DMB+222].specificChildren = { true, DMB+223                                    } -- ( 110 )
mobList[zone][DMB+224].specificChildren = { true, DMB+225                                    } -- ( 111 )
mobList[zone][DMB+226].specificChildren = { true, DMB+227                                    } -- ( 112 )
mobList[zone][DMB+436].specificChildren = { true, DMB+437                                    } -- ( 113 )
mobList[zone][DMB+438].specificChildren = { true, DMB+439                                    } -- ( 114 )
mobList[zone][DMB+440].specificChildren = { true, DMB+441                                    } -- ( 115 )
mobList[zone][DMB+442].specificChildren = { true, DMB+443                                    } -- ( 116 )
mobList[zone][DMB+444].specificChildren = { true, DMB+445                                    } -- ( 117 )
mobList[zone][DMB+196].specificChildren = { true, DMB+197                                    } -- ( 118 )
mobList[zone][DMB+198].specificChildren = { true, DMB+199                                    } -- ( 119 )
mobList[zone][DMB+200].specificChildren = { true, DMB+201                                    } -- ( 120 )
mobList[zone][DMB+202].specificChildren = { true, DMB+203                                    } -- ( 121 )
mobList[zone][DMB+204].specificChildren = { true, DMB+205                                    } -- ( 122 )
mobList[zone][DMB+206].specificChildren = { true, DMB+207                                    } -- ( 123 )
mobList[zone][DMB+208].specificChildren = { true, DMB+209                                    } -- ( 124 )
mobList[zone][DMB+210].specificChildren = { true, DMB+269                                    } -- ( 125 )
mobList[zone][DMB+270].specificChildren = { true, DMB+271                                    } -- ( 126 )
mobList[zone][DMB+272].specificChildren = { true, DMB+273                                    } -- ( 127 )
mobList[zone][DMB+274].specificChildren = { true, DMB+275                                    } -- ( 128 )
mobList[zone][DMB+276].specificChildren = { true, DMB+277                                    } -- ( 129 )
mobList[zone][DMB+522].specificChildren = { true, DMB+523                                    } -- ( 130 )
mobList[zone][DMB+168].specificChildren = { true, DMB+169, DMB+170                           } -- ( 131 )
mobList[zone][DMB+171].specificChildren = { true, DMB+172, DMB+173                           } -- ( 132 )
mobList[zone][DMB+174].specificChildren = { true, DMB+175, DMB+176                           } -- ( 133 )
mobList[zone][DMB+177].specificChildren = { true, DMB+178, DMB+179, DMB+180                  } -- ( 134 )
mobList[zone][DMB+181].specificChildren = { true, DMB+182, DMB+183, DMB+278                  } -- ( 135 )
mobList[zone][DMB+279].specificChildren = { true, DMB+280, DMB+281, DMB+282                  } -- ( 136 )
mobList[zone][DMB+283].specificChildren = { true, DMB+284, DMB+285, DMB+286                  } -- ( 137 )
mobList[zone][DMB+287].specificChildren = { true, DMB+288, DMB+289, DMB+524                  } -- ( 138 )

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{
    [16945638] = { id = 16945638, spawnAtStart = true},
}