-----------------------------------
--
-- Dynamis-Buburimu
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_BUBURIMU
local DMB = 16941057 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 16941068 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] =
{

[DMB+0  ] = { id =  DMB+0  }, -- Apocalyptic Beast  ( 061 )
[DMB+309] = { id =  DMB+309}, -- Alklha             ( 051 )
[DMB+307] = { id =  DMB+307}, -- Stihi              ( 052 )
[DMB+610] = { id =  DMB+610}, -- Basilic            ( 053 )
[DMB+611] = { id =  DMB+611}, -- Jurik              ( 054 )
[DMB+308] = { id =  DMB+308}, -- Barong             ( 055 )
[DMB+612] = { id =  DMB+612}, -- Tarasca            ( 056 )
[DMB+613] = { id =  DMB+613}, -- Stollenwurm        ( 057 )
[DMB+614] = { id =  DMB+614}, -- Koschei            ( 058 )
[DMB+310] = { id =  DMB+310}, -- Aitvaras           ( 059 )
[DMB+615] = { id =  DMB+615}, -- Vishap             ( 060 )
-- Orcs Statues
[SMB+50 ] = { id =  SMB+50 }, -- Sergeant Tombstone (001-O)
[SMB+51 ] = { id =  SMB+51 }, -- Sergeant Tombstone (002-O)
[SMB+52 ] = { id =  SMB+52 }, -- Sergeant Tombstone (003-O)
[SMB+67 ] = { id =  SMB+67 }, -- Sergeant Tombstone (004-O)
[SMB+68 ] = { id =  SMB+68 }, -- Sergeant Tombstone (005-O)
[SMB+69 ] = { id =  SMB+69 }, -- Sergeant Tombstone (006-O)
[SMB+343] = { id =  SMB+343}, -- Sergeant Tombstone (007-O)
[SMB+344] = { id =  SMB+344}, -- Sergeant Tombstone (008-O)
[SMB+345] = { id =  SMB+345}, -- Sergeant Tombstone (009-O)
[SMB+357] = { id =  SMB+357}, -- Sergeant Tombstone (010-O)
[SMB+358] = { id =  SMB+358}, -- Sergeant Tombstone (011-O)
[SMB+359] = { id =  SMB+359}, -- Sergeant Tombstone (012-O)
[SMB+603] = { id =  SMB+603}, -- Sergeant Tombstone (013-O)
-- Goblins Statues
[SMB+0  ] = { id =  SMB+0  }, -- Goblin Replica     (014-G)
[SMB+1  ] = { id =  SMB+1  }, -- Goblin Replica     (015-G)
[SMB+2  ] = { id =  SMB+2  }, -- Goblin Replica     (016-G)
[SMB+15 ] = { id =  SMB+15 }, -- Goblin Replica     (017-G)
[SMB+16 ] = { id =  SMB+16 }, -- Goblin Replica     (018-G)
[SMB+17 ] = { id =  SMB+17 }, -- Goblin Replica     (019-G)
[SMB+30 ] = { id =  SMB+30 }, -- Goblin Replica     (020-G)
[SMB+31 ] = { id =  SMB+31 }, -- Goblin Replica     (021-G)
[SMB+32 ] = { id =  SMB+32 }, -- Goblin Replica     (022-G)
[SMB+313] = { id =  SMB+313}, -- Goblin Replica     (023-G)
[SMB+314] = { id =  SMB+314}, -- Goblin Replica     (024-G)
-- Quadavs Statues
[SMB+85 ] = { id =  SMB+85 }, -- Adamantking Effigy (025-Q)
[SMB+86 ] = { id =  SMB+86 }, -- Adamantking Effigy (026-Q)
[SMB+87 ] = { id =  SMB+87 }, -- Adamantking Effigy (027-Q)
[SMB+103] = { id =  SMB+103}, -- Adamantking Effigy (028-Q)
[SMB+104] = { id =  SMB+104}, -- Adamantking Effigy (029-Q)
[SMB+105] = { id =  SMB+105}, -- Adamantking Effigy (030-Q)
[SMB+372] = { id =  SMB+372}, -- Adamantking Effigy (031-Q)
[SMB+373] = { id =  SMB+373}, -- Adamantking Effigy (032-Q)
[SMB+374] = { id =  SMB+374}, -- Adamantking Effigy (033-Q)
[SMB+387] = { id =  SMB+387}, -- Adamantking Effigy (034-Q)
[SMB+388] = { id =  SMB+388}, -- Adamantking Effigy (035-Q)
[SMB+389] = { id =  SMB+389}, -- Adamantking Effigy (036-Q)
[SMB+604] = { id =  SMB+604}, -- Adamantking Effigy (037-Q)
-- Yagudos Statues
[SMB+122] = { id =  SMB+122}, -- Manifest Icon      (038-Y)
[SMB+123] = { id =  SMB+123}, -- Manifest Icon      (038-Y)
[SMB+124] = { id =  SMB+124}, -- Manifest Icon      (038-Y)
[SMB+140] = { id =  SMB+140}, -- Manifest Icon      (038-Y)
[SMB+141] = { id =  SMB+141}, -- Manifest Icon      (038-Y)
[SMB+142] = { id =  SMB+142}, -- Manifest Icon      (038-Y)
[SMB+403] = { id =  SMB+403}, -- Manifest Icon      (038-Y)
[SMB+404] = { id =  SMB+404}, -- Manifest Icon      (038-Y)
[SMB+405] = { id =  SMB+405}, -- Manifest Icon      (038-Y)
[SMB+417] = { id =  SMB+417}, -- Manifest Icon      (038-Y)
[SMB+418] = { id =  SMB+418}, -- Manifest Icon      (038-Y)
[SMB+419] = { id =  SMB+419}, -- Manifest Icon      (038-Y)
[SMB+605] = { id =  SMB+605}, -- Manifest Icon      (038-Y)

[DMB+155] = { id =  DMB+155}, -- Nightmare Crab
[DMB+156] = { id =  DMB+156}, -- Nightmare Crab
[DMB+157] = { id =  DMB+157}, -- Nightmare Crab
[DMB+158] = { id =  DMB+158}, -- Nightmare Crab
[DMB+159] = { id =  DMB+159}, -- Nightmare Crab
[DMB+160] = { id =  DMB+160}, -- Nightmare Crab
[DMB+161] = { id =  DMB+161}, -- Nightmare Crab
[DMB+162] = { id =  DMB+162}, -- Nightmare Crab
[DMB+163] = { id =  DMB+163}, -- Nightmare Crab
[DMB+164] = { id =  DMB+164}, -- Nightmare Crab
[DMB+165] = { id =  DMB+165}, -- Nightmare Crab
[DMB+166] = { id =  DMB+166}, -- Nightmare Crab
[DMB+167] = { id =  DMB+167}, -- Nightmare Crab
[DMB+168] = { id =  DMB+168}, -- Nightmare Crab
[DMB+169] = { id =  DMB+169}, -- Nightmare Crab
[DMB+170] = { id =  DMB+170}, -- Nightmare Crab
[DMB+171] = { id =  DMB+171}, -- Nightmare Crab
[DMB+172] = { id =  DMB+172}, -- Nightmare Crab
[DMB+173] = { id =  DMB+173}, -- Nightmare Crab
[DMB+174] = { id =  DMB+174}, -- Nightmare Crab


[DMB+175] = { id =  DMB+175}, -- Nightmare Dhamel
[DMB+176] = { id =  DMB+176}, -- Nightmare Dhamel
[DMB+177] = { id =  DMB+177}, -- Nightmare Dhamel
[DMB+178] = { id =  DMB+178}, -- Nightmare Dhamel
[DMB+179] = { id =  DMB+179}, -- Nightmare Dhamel
[DMB+180] = { id =  DMB+180}, -- Nightmare Dhamel
[DMB+181] = { id =  DMB+181}, -- Nightmare Dhamel
[DMB+182] = { id =  DMB+182}, -- Nightmare Dhamel
[DMB+183] = { id =  DMB+183}, -- Nightmare Dhamel
[DMB+184] = { id =  DMB+184}, -- Nightmare Dhamel
[DMB+185] = { id =  DMB+185}, -- Nightmare Dhamel
[DMB+186] = { id =  DMB+186}, -- Nightmare Dhamel
[DMB+187] = { id =  DMB+187}, -- Nightmare Dhamel
[DMB+188] = { id =  DMB+188}, -- Nightmare Dhamel
[DMB+189] = { id =  DMB+189}, -- Nightmare Dhamel
[DMB+190] = { id =  DMB+190}, -- Nightmare Dhamel
[DMB+191] = { id =  DMB+191}, -- Nightmare Dhamel
[DMB+192] = { id =  DMB+192}, -- Nightmare Dhamel
[DMB+442] = { id =  DMB+442}, -- Nightmare Dhamel
[DMB+443] = { id =  DMB+443}, -- Nightmare Dhamel
[DMB+444] = { id =  DMB+444}, -- Nightmare Dhamel
[DMB+445] = { id =  DMB+445}, -- Nightmare Dhamel
[DMB+446] = { id =  DMB+446}, -- Nightmare Dhamel
[DMB+447] = { id =  DMB+447}, -- Nightmare Dhamel
[DMB+448] = { id =  DMB+448}, -- Nightmare Dhamel
[DMB+449] = { id =  DMB+449}, -- Nightmare Dhamel

[DMB+193] = { id =  DMB+193}, -- Nightmare Urganite
[DMB+194] = { id =  DMB+194}, -- Nightmare Urganite
[DMB+195] = { id =  DMB+195}, -- Nightmare Urganite
[DMB+196] = { id =  DMB+196}, -- Nightmare Urganite
[DMB+197] = { id =  DMB+197}, -- Nightmare Urganite
[DMB+198] = { id =  DMB+198}, -- Nightmare Urganite
[DMB+199] = { id =  DMB+199}, -- Nightmare Urganite
[DMB+200] = { id =  DMB+200}, -- Nightmare Urganite
[DMB+201] = { id =  DMB+201}, -- Nightmare Urganite
[DMB+202] = { id =  DMB+202}, -- Nightmare Urganite
[DMB+203] = { id =  DMB+203}, -- Nightmare Urganite
[DMB+204] = { id =  DMB+204}, -- Nightmare Urganite
[DMB+205] = { id =  DMB+205}, -- Nightmare Urganite
[DMB+206] = { id =  DMB+206}, -- Nightmare Urganite
[DMB+207] = { id =  DMB+207}, -- Nightmare Urganite
[DMB+208] = { id =  DMB+208}, -- Nightmare Urganite
[DMB+464] = { id =  DMB+464}, -- Nightmare Urganite
[DMB+465] = { id =  DMB+465}, -- Nightmare Urganite
[DMB+466] = { id =  DMB+466}, -- Nightmare Urganite
[DMB+467] = { id =  DMB+467}, -- Nightmare Urganite
[DMB+468] = { id =  DMB+468}, -- Nightmare Urganite
[DMB+469] = { id =  DMB+469}, -- Nightmare Urganite

[DMB+209] = { id =  DMB+209}, -- Nightmare Scorpion
[DMB+210] = { id =  DMB+210}, -- Nightmare Scorpion
[DMB+211] = { id =  DMB+211}, -- Nightmare Scorpion
[DMB+212] = { id =  DMB+212}, -- Nightmare Scorpion
[DMB+213] = { id =  DMB+213}, -- Nightmare Scorpion
[DMB+214] = { id =  DMB+214}, -- Nightmare Scorpion
[DMB+215] = { id =  DMB+215}, -- Nightmare Scorpion
[DMB+216] = { id =  DMB+216}, -- Nightmare Scorpion
[DMB+217] = { id =  DMB+217}, -- Nightmare Scorpion
[DMB+218] = { id =  DMB+218}, -- Nightmare Scorpion
[DMB+219] = { id =  DMB+219}, -- Nightmare Scorpion
[DMB+220] = { id =  DMB+220}, -- Nightmare Scorpion
[DMB+221] = { id =  DMB+221}, -- Nightmare Scorpion
[DMB+222] = { id =  DMB+222}, -- Nightmare Scorpion
[DMB+223] = { id =  DMB+223}, -- Nightmare Scorpion
[DMB+224] = { id =  DMB+224}, -- Nightmare Scorpion
[DMB+225] = { id =  DMB+225}, -- Nightmare Scorpion
[DMB+226] = { id =  DMB+226}, -- Nightmare Scorpion
[DMB+477] = { id =  DMB+477}, -- Nightmare Scorpion
[DMB+478] = { id =  DMB+478}, -- Nightmare Scorpion
[DMB+479] = { id =  DMB+479}, -- Nightmare Scorpion

[DMB+227] = { id =  DMB+227}, -- Nightmare Bunny
[DMB+228] = { id =  DMB+228}, -- Nightmare Bunny
[DMB+229] = { id =  DMB+229}, -- Nightmare Bunny
[DMB+230] = { id =  DMB+230}, -- Nightmare Bunny
[DMB+231] = { id =  DMB+231}, -- Nightmare Bunny
[DMB+232] = { id =  DMB+232}, -- Nightmare Bunny
[DMB+233] = { id =  DMB+233}, -- Nightmare Bunny
[DMB+234] = { id =  DMB+234}, -- Nightmare Bunny
[DMB+235] = { id =  DMB+235}, -- Nightmare Bunny
[DMB+236] = { id =  DMB+236}, -- Nightmare Bunny
[DMB+237] = { id =  DMB+237}, -- Nightmare Bunny
[DMB+238] = { id =  DMB+238}, -- Nightmare Bunny
[DMB+239] = { id =  DMB+239}, -- Nightmare Bunny
[DMB+240] = { id =  DMB+240}, -- Nightmare Bunny
[DMB+241] = { id =  DMB+241}, -- Nightmare Bunny
[DMB+242] = { id =  DMB+242}, -- Nightmare Bunny
[DMB+496] = { id =  DMB+496}, -- Nightmare Bunny
[DMB+497] = { id =  DMB+497}, -- Nightmare Bunny
[DMB+498] = { id =  DMB+498}, -- Nightmare Bunny
[DMB+499] = { id =  DMB+499}, -- Nightmare Bunny

[DMB+520] = { id =  DMB+520}, -- Nightmare Mandragora
[DMB+521] = { id =  DMB+521}, -- Nightmare Mandragora
[DMB+522] = { id =  DMB+522}, -- Nightmare Mandragora
[DMB+523] = { id =  DMB+523}, -- Nightmare Mandragora
[DMB+524] = { id =  DMB+524}, -- Nightmare Mandragora
[DMB+525] = { id =  DMB+525}, -- Nightmare Mandragora
[DMB+526] = { id =  DMB+526}, -- Nightmare Mandragora
[DMB+527] = { id =  DMB+527}, -- Nightmare Mandragora
[DMB+528] = { id =  DMB+528}, -- Nightmare Mandragora
[DMB+529] = { id =  DMB+529}, -- Nightmare Mandragora
[DMB+530] = { id =  DMB+530}, -- Nightmare Mandragora
[DMB+531] = { id =  DMB+531}, -- Nightmare Mandragora
[DMB+532] = { id =  DMB+532}, -- Nightmare Mandragora
[DMB+533] = { id =  DMB+533}, -- Nightmare Mandragora
[DMB+534] = { id =  DMB+534}, -- Nightmare Mandragora
[DMB+535] = { id =  DMB+535}, -- Nightmare Mandragora
[DMB+536] = { id =  DMB+536}, -- Nightmare Mandragora
[DMB+537] = { id =  DMB+537}, -- Nightmare Mandragora
[DMB+538] = { id =  DMB+538}, -- Nightmare Mandragora
[DMB+539] = { id =  DMB+539}, -- Nightmare Mandragora
[DMB+540] = { id =  DMB+540}, -- Nightmare Mandragora
[DMB+541] = { id =  DMB+541}, -- Nightmare Mandragora
[DMB+542] = { id =  DMB+542}, -- Nightmare Mandragora
[DMB+543] = { id =  DMB+543}, -- Nightmare Mandragora

[DMB+259] = { id =  DMB+259}, -- Nightmare Crawler
[DMB+260] = { id =  DMB+260}, -- Nightmare Crawler
[DMB+261] = { id =  DMB+261}, -- Nightmare Crawler
[DMB+262] = { id =  DMB+262}, -- Nightmare Crawler
[DMB+263] = { id =  DMB+263}, -- Nightmare Crawler
[DMB+264] = { id =  DMB+264}, -- Nightmare Crawler
[DMB+265] = { id =  DMB+265}, -- Nightmare Crawler
[DMB+266] = { id =  DMB+266}, -- Nightmare Crawler
[DMB+267] = { id =  DMB+267}, -- Nightmare Crawler
[DMB+551] = { id =  DMB+551}, -- Nightmare Crawler
[DMB+552] = { id =  DMB+552}, -- Nightmare Crawler
[DMB+553] = { id =  DMB+553}, -- Nightmare Crawler
[DMB+554] = { id =  DMB+554}, -- Nightmare Crawler
[DMB+555] = { id =  DMB+555}, -- Nightmare Crawler
[DMB+556] = { id =  DMB+556}, -- Nightmare Crawler
[DMB+557] = { id =  DMB+557}, -- Nightmare Crawler
[DMB+558] = { id =  DMB+558}, -- Nightmare Crawler
[DMB+559] = { id =  DMB+559}, -- Nightmare Crawler
[DMB+560] = { id =  DMB+560}, -- Nightmare Crawler
[DMB+561] = { id =  DMB+561}, -- Nightmare Crawler
[DMB+562] = { id =  DMB+562}, -- Nightmare Crawler
[DMB+563] = { id =  DMB+563}, -- Nightmare Crawler
[DMB+564] = { id =  DMB+564}, -- Nightmare Crawler
[DMB+565] = { id =  DMB+565}, -- Nightmare Crawler

[DMB+269] = { id =  DMB+269}, -- Nightmare Raven
[DMB+270] = { id =  DMB+270}, -- Nightmare Raven
[DMB+271] = { id =  DMB+271}, -- Nightmare Raven
[DMB+272] = { id =  DMB+272}, -- Nightmare Raven
[DMB+273] = { id =  DMB+273}, -- Nightmare Raven
[DMB+274] = { id =  DMB+274}, -- Nightmare Raven
[DMB+275] = { id =  DMB+275}, -- Nightmare Raven
[DMB+276] = { id =  DMB+276}, -- Nightmare Raven
[DMB+277] = { id =  DMB+277}, -- Nightmare Raven
[DMB+278] = { id =  DMB+278}, -- Nightmare Raven
[DMB+279] = { id =  DMB+279}, -- Nightmare Raven
[DMB+280] = { id =  DMB+280}, -- Nightmare Raven
[DMB+281] = { id =  DMB+281}, -- Nightmare Raven
[DMB+282] = { id =  DMB+282}, -- Nightmare Raven
[DMB+283] = { id =  DMB+283}, -- Nightmare Raven
[DMB+284] = { id =  DMB+284}, -- Nightmare Raven
[DMB+285] = { id =  DMB+285}, -- Nightmare Raven
[DMB+286] = { id =  DMB+286}, -- Nightmare Raven
[DMB+287] = { id =  DMB+287}, -- Nightmare Raven
[DMB+288] = { id =  DMB+288}, -- Nightmare Raven
[DMB+572] = { id =  DMB+572}, -- Nightmare Raven
[DMB+573] = { id =  DMB+573}, -- Nightmare Raven
[DMB+574] = { id =  DMB+574}, -- Nightmare Raven
[DMB+575] = { id =  DMB+575}, -- Nightmare Raven
[DMB+576] = { id =  DMB+576}, -- Nightmare Raven
[DMB+577] = { id =  DMB+577}, -- Nightmare Raven

[DMB+289] = { id =  DMB+289}, -- Nightmare Eft
[DMB+290] = { id =  DMB+290}, -- Nightmare Eft
[DMB+291] = { id =  DMB+291}, -- Nightmare Eft
[DMB+292] = { id =  DMB+292}, -- Nightmare Eft
[DMB+293] = { id =  DMB+293}, -- Nightmare Eft
[DMB+294] = { id =  DMB+294}, -- Nightmare Eft
[DMB+295] = { id =  DMB+295}, -- Nightmare Eft
[DMB+296] = { id =  DMB+296}, -- Nightmare Eft
[DMB+297] = { id =  DMB+297}, -- Nightmare Eft
[DMB+298] = { id =  DMB+298}, -- Nightmare Eft
[DMB+299] = { id =  DMB+299}, -- Nightmare Eft
[DMB+300] = { id =  DMB+300}, -- Nightmare Eft
[DMB+301] = { id =  DMB+301}, -- Nightmare Eft
[DMB+302] = { id =  DMB+302}, -- Nightmare Eft
[DMB+303] = { id =  DMB+303}, -- Nightmare Eft
[DMB+304] = { id =  DMB+304}, -- Nightmare Eft
[DMB+305] = { id =  DMB+305}, -- Nightmare Eft
[DMB+306] = { id =  DMB+306}, -- Nightmare Eft
[DMB+590] = { id =  DMB+590}, -- Nightmare Eft
[DMB+591] = { id =  DMB+591}, -- Nightmare Eft

[DMB+620] = { id =  DMB+620}, -- Nightmare Cockatrice
[DMB+621] = { id =  DMB+621}, -- Nightmare Cockatrice
[DMB+622] = { id =  DMB+622}, -- Nightmare Cockatrice
[DMB+623] = { id =  DMB+623}, -- Nightmare Cockatrice
[DMB+624] = { id =  DMB+624}, -- Nightmare Cockatrice
[DMB+625] = { id =  DMB+625}, -- Nightmare Cockatrice
[DMB+626] = { id =  DMB+626}, -- Nightmare Cockatrice
[DMB+627] = { id =  DMB+627}, -- Nightmare Cockatrice
[DMB+628] = { id =  DMB+628}, -- Nightmare Cockatrice
[DMB+629] = { id =  DMB+629}, -- Nightmare Cockatrice
[DMB+630] = { id =  DMB+630}, -- Nightmare Cockatrice
[DMB+628] = { id =  DMB+628}, -- Nightmare Cockatrice
[DMB+631] = { id =  DMB+631}, -- Nightmare Cockatrice
[DMB+632] = { id =  DMB+632}, -- Nightmare Cockatrice
[DMB+633] = { id =  DMB+633}, -- Nightmare Cockatrice
[DMB+634] = { id =  DMB+634}, -- Nightmare Cockatrice
[DMB+635] = { id =  DMB+635}, -- Nightmare Cockatrice
[DMB+636] = { id =  DMB+636}, -- Nightmare Cockatrice
[DMB+637] = { id =  DMB+637}, -- Nightmare Cockatrice
[DMB+638] = { id =  DMB+638}, -- Nightmare Cockatrice

}

mobList[zone].zoneID = tpz.zone.DYNAMIS_BUBURIMU

--Dragons
mobList[zone][DMB+0  ].pos = {-29.0061, -13.6044, 60.6641, 11}
mobList[zone][DMB+307  ].pos = {60.7967, -23.0410, 199.0426, 12}
mobList[zone][DMB+309  ].pos = {-339.9798, -39.0022, 243.1307, 70}
mobList[zone][DMB+610  ].pos = {232.1226, -9.4403, 211.5448, 20}
mobList[zone][DMB+611  ].pos = {346.0957, -9.2967, 271.6128, 66}
mobList[zone][DMB+308  ].pos = {-428.8357, -7.4000, -221.6568, 211}
mobList[zone][DMB+612  ].pos = {-41.1463, -16.0195, -3.8987, 63}
mobList[zone][DMB+613  ].pos = {-33.7517, 16.1113, -236.2199, 186}
mobList[zone][DMB+614  ].pos = {36.0265, 0.1348, -233.2813, 193}
mobList[zone][DMB+310  ].pos = {206.5141, -7.7500, 4.5535, 119}
mobList[zone][DMB+615  ].pos = {482.4607, 0.9171, -18.3645, 127}
--Orc Stats
mobList[zone][SMB+50   ].pos = {-489.6237, -29.8504, 59.9449, 63}
mobList[zone][SMB+51   ].pos = {-483.8572, -30.9016, 65.4925, 63}
mobList[zone][SMB+52   ].pos = {-474.6325, -29.7465, 58.5642, 63}
mobList[zone][SMB+67   ].pos = {-365.3331, -22.1115, 21.2624, 198}
mobList[zone][SMB+68   ].pos = {-355.8970, -21.9494, 21.5242, 198}
mobList[zone][SMB+69   ].pos = {-360.7734, -21.8964, 18.8860, 198}
mobList[zone][SMB+343  ].pos = {-370.3228, -23.2670, 15.0742, 71}
mobList[zone][SMB+344  ].pos = {-353.7643, -22.5512, 15.7313, 71}
mobList[zone][SMB+345  ].pos = {-216.7957, -22.1539, 96.7794, 64}
mobList[zone][SMB+357  ].pos = {-216.1143, -22.1460, 106.0876, 189}
mobList[zone][SMB+358  ].pos = {-208.1248, -21.6153, 101.4173, 189}
mobList[zone][SMB+359  ].pos = {-199.5664, -22.8261, 94.8028, 9}
mobList[zone][SMB+603  ].pos = {-199.2854, -22.8656, 105.3254, 195}
--Goblin Stats
mobList[zone][SMB+0    ].pos = {-30.1739, -13.7288, 61.2518, 82}
mobList[zone][SMB+1    ].pos = {-24.6467, -13.2863, 58.9652, 82}
mobList[zone][SMB+2    ].pos = { -15.2367, -13.3332, 57.8845, 82}
mobList[zone][SMB+15   ].pos = {26.1893, -13.1639, 61.5514, 74}
mobList[zone][SMB+16   ].pos = {36.0939, -13.8959, 61.0378, 74}
mobList[zone][SMB+17   ].pos = {47.8134, -12.8931, 60.0505, 74}
mobList[zone][SMB+30   ].pos = {-20.4471, -13.5662, -5.0198, 67}
mobList[zone][SMB+31   ].pos = {-20.9386, -6.1433, -33.5945, 185}
mobList[zone][SMB+32   ].pos = {-12.7062, -7.3521, -42.6142, 249}
mobList[zone][SMB+313  ].pos = {-26.1805, -6.9301, -43.9465, 128}
mobList[zone][SMB+314  ].pos = {-18.5424, -6.0020, -48.6369, 49}
--Quadav Stats
mobList[zone][SMB+85   ].pos = {241.4802, -5.7749, 20.1419, 129}
mobList[zone][SMB+86   ].pos = {257.7976, -2.3514, 22.7234, 129}
mobList[zone][SMB+87   ].pos = { 279.3134, 2.1576, 20.6812, 129}
mobList[zone][SMB+103  ].pos = { 302.2001, 2.1881, 96.2034, 170}
mobList[zone][SMB+104  ].pos = { 299.4405, 2.1729, 82.7570, 170}
mobList[zone][SMB+105  ].pos = {300.0283, 2.2393, 77.8772, 170}
mobList[zone][SMB+372  ].pos = {283.6140, 2.1808, 19.5053, 128}
mobList[zone][SMB+373  ].pos = {299.0122, 2.2500, 37.3500, 128}
mobList[zone][SMB+374  ].pos = { 298.2328, 2.8144, 16.9182, 128}
mobList[zone][SMB+387  ].pos = {300.0039, 2.2430, -0.4152, 128}
mobList[zone][SMB+388  ].pos = {301.2189, 2.5103, -25.6304, 110}
mobList[zone][SMB+389  ].pos = {299.6303, 2.1966, -37.0409, 110}
mobList[zone][SMB+604  ].pos = {300.0410, 2.2101, -43.0707, 110}
-- Yagudo Stats
mobList[zone][SMB+122  ].pos = {351.5531, 2.0022, -60.4356, 196}
mobList[zone][SMB+123  ].pos = {373.1893, 2.5996, -63.9211, 219}
mobList[zone][SMB+124  ].pos = {379.2950, 2.1553, -81.4621, 2}
mobList[zone][SMB+140  ].pos = {351.6066, -0.6636, -190.2410, 1}
mobList[zone][SMB+141  ].pos = {353.3952, -0.6354, -200.8557, 236}
mobList[zone][SMB+142  ].pos = {375.5005, -0.6350, -225.3975, 225}
mobList[zone][SMB+403  ].pos = {412.0664, 2.6627, -221.4059, 189}
mobList[zone][SMB+404  ].pos = {430.3526, 2.0774, -219.0766, 123}
mobList[zone][SMB+405  ].pos = {493.5782, 2.5840, -225.4034, 154}
mobList[zone][SMB+417  ].pos = {501.7607, 2.0000, -247.7523, 169}
mobList[zone][SMB+418  ].pos = {523.8189, 2.1778, -259.4799, 144}
mobList[zone][SMB+419  ].pos = {536.0930, 2.2397, -261.7803, 137}
mobList[zone][SMB+605  ].pos = {553.5475, 1.4175, -261.2966, 126}
-- Nightmare Crabs
mobList[zone][DMB+155  ].pos = {-30.7958, 19.4184, -308.5479, 130}
mobList[zone][DMB+156  ].pos = {-29.2222, 19.9959, -315.8475, 131}
mobList[zone][DMB+157  ].pos = {-31.1747, 15.8897, -278.6635, 168}
mobList[zone][DMB+158  ].pos = {-33.0270, 16.0036, -274.3393, 65}
mobList[zone][DMB+159  ].pos = {-13.1607, 15.8045, -251.7880, 164}
mobList[zone][DMB+160  ].pos = {-6.0943, 15.8577, -249.0809, 126}
mobList[zone][DMB+161  ].pos = {-0.6842, 16.8508, -217.9911, 228}
mobList[zone][DMB+162  ].pos = {-0.7560, 16.4701, -212.7469, 191}
mobList[zone][DMB+163  ].pos = {-43.9131, 16.5957, -214.0052, 243}
mobList[zone][DMB+164  ].pos = {-49.2881, 16.4286, -219.6089, 100}
mobList[zone][DMB+165  ].pos = {-68.2952, 15.9799, -253.3839, 79}
mobList[zone][DMB+166  ].pos = {-68.1487, 16.1250, -263.1060, 45}
mobList[zone][DMB+167  ].pos = {-89.9767, 16.1424, -234.8192, 48}
mobList[zone][DMB+168  ].pos = {-86.8363, 15.6488, -230.9654, 219}
mobList[zone][DMB+169  ].pos = {-120.5364, 16.0000, -238.3332, 103}
mobList[zone][DMB+170  ].pos = {-124.9815, 16.0000, -233.7003, 169}
mobList[zone][DMB+171  ].pos = {-132.1700, 15.4754, -280.0170, 75}
mobList[zone][DMB+172  ].pos = {-126.3671, 16.1013, -286.9827, 48}
mobList[zone][DMB+173  ].pos = {-111.2321, 20.0000, -321.6591, 99}
mobList[zone][DMB+174  ].pos = {-115.5943, 20.0000, -325.8853, 94}
-- Nightmare Dhalmels
mobList[zone][DMB+174  ].pos = {147.0991, -13.8950, 83.2262, 91}
mobList[zone][DMB+174  ].pos = {150.5967, -15.0383, 77.4631, 52}
mobList[zone][DMB+174  ].pos = {184.7485, -14.7913, 70.9593, 80}
mobList[zone][DMB+174  ].pos = {193.1325, -14.6696, 69.7727, 8}
mobList[zone][DMB+174  ].pos = {173.1945, -15.7263, 105.4897, 231}
mobList[zone][DMB+174  ].pos = {175.1099, -16.7937, 95.3463, 35}
mobList[zone][DMB+174  ].pos = {168.6498, -17.3226, 97.7622, 245}
mobList[zone][DMB+174  ].pos = {159.7019, -19.7969, 137.1451, 115}
mobList[zone][DMB+174  ].pos = {164.7219, -20.3030, 142.5724, 240}
mobList[zone][DMB+174  ].pos = {165.4218, -19.7552, 138.6105, 117}
mobList[zone][DMB+174  ].pos = {200.3606, -12.1309, 138.5568, 25}
mobList[zone][DMB+174  ].pos = {205.9270, -12.3573, 141.1469, 235}
mobList[zone][DMB+174  ].pos = {202.5746, -13.5267, 144.1523, 46}
mobList[zone][DMB+174  ].pos = {234.5791, -8.2018, 134.8770, 28}
mobList[zone][DMB+174  ].pos = {229.5914, -7.8646, 131.2038, 69}
mobList[zone][DMB+174  ].pos = {229.1217, -9.2294, 138.7487, 8}
mobList[zone][DMB+174  ].pos = {220.6413, -10.6810, 173.0818, 143}
mobList[zone][DMB+174  ].pos = {218.4597, -11.5093, 170.9403, 98}
mobList[zone][DMB+174  ].pos = {197.9261, -15.5859, 184.8995, 25}
mobList[zone][DMB+174  ].pos = {204.3031, -15.3590, 189.9328, 215}
mobList[zone][DMB+174  ].pos = {226.7076, -10.4975, 199.3315, 214}
mobList[zone][DMB+174  ].pos = {231.5724, -8.7812, 200.8736, 126}
mobList[zone][DMB+174  ].pos = {259.2725, -4.3060, 194.6071, 203}
mobList[zone][DMB+174  ].pos = {257.5502, -5.7149, 202.1803, 183}
mobList[zone][DMB+174  ].pos = {256.6777, -8.2446, 131.9328, 47}
mobList[zone][DMB+174  ].pos = {254.4781, -7.8469, 121.0773, 88}
-- Nightmare Uragnites
mobList[zone][DMB+193  ].pos = {387.0336, 15.3531, 76.0351, 147}
mobList[zone][DMB+194  ].pos = {386.1310, 15.2863, 82.8960, 57}
mobList[zone][DMB+195  ].pos = {377.8488, 15.0754, 102.8690, 169}
mobList[zone][DMB+196  ].pos = {369.8853, 15.4632, 108.8367, 162}
mobList[zone][DMB+197  ].pos = {359.6248, 16.2275, 128.5730, 170}
mobList[zone][DMB+198  ].pos = {358.1983, 16.3443, 130.9093, 169}
mobList[zone][DMB+199  ].pos = {349.6410, 15.6979, 156.5760, 179}
mobList[zone][DMB+200  ].pos = {351.3098, 15.9044, 159.2635, 9}
mobList[zone][DMB+201  ].pos = {367.1823, 15.1005, 173.3831, 196}
mobList[zone][DMB+202  ].pos = {374.2122, 15.2872, 171.1647, 186}
mobList[zone][DMB+203  ].pos = {435.8933, 19.9970, 170.3763, 115}
mobList[zone][DMB+204  ].pos = {437.2286, 20.0000, 164.3130, 48}
mobList[zone][DMB+205  ].pos = {428.0363, 19.4671, 165.0977, 78}
mobList[zone][DMB+206  ].pos = {435.6099, 20.0000, 138.3125, 119}
mobList[zone][DMB+207  ].pos = {432.5457, 20.0000, 138.9886, 132}
mobList[zone][DMB+208  ].pos = {439.2874, 20.0000, 140.7343, 43}
mobList[zone][DMB+464  ].pos = {445.4790, 20.0000, 105.9790, 78}
mobList[zone][DMB+465  ].pos = {440.2088, 20.0000, 106.2512, 124}
mobList[zone][DMB+466  ].pos = {447.7589, 20.0000, 111.5140, 224}
mobList[zone][DMB+467  ].pos = {445.8142, 20.0674, 68.9965, 176}
mobList[zone][DMB+468  ].pos = {440.7611, 20.0000, 71.2139, 201}
mobList[zone][DMB+469  ].pos = {441.8423, 20.0000, 73.8866, 186}
-- Nightmare Scorpion
mobList[zone][DMB+209  ].pos = {471.2361, 0.2161, 6.8440, 62}
mobList[zone][DMB+210  ].pos = {479.5731, 0.4628, 6.5544, 26}
mobList[zone][DMB+211  ].pos = {477.7462, 4.1604, 16.9453, 112}
mobList[zone][DMB+212  ].pos = {478.3198, 1.0893, 10.9378, 23}
mobList[zone][DMB+213  ].pos = {516.1291, 0.2165, -8.3529, 115}
mobList[zone][DMB+214  ].pos = {512.9695, 0.1659, -4.3340, 162}
mobList[zone][DMB+215  ].pos = {518.4948, 0.0000, -1.8332, 83}
mobList[zone][DMB+216  ].pos = {511.0065, 0.0000, -10.1647, 100}
mobList[zone][DMB+217  ].pos = {519.8561, 1.0989, -51.0201, 102}
mobList[zone][DMB+218  ].pos = {516.4373, -0.0155, -43.8536, 182}
mobList[zone][DMB+219  ].pos = {521.2855, 0.0000, -41.4890, 244}
mobList[zone][DMB+220  ].pos = {526.9821, 0.3656, -40.4521, 120}
mobList[zone][DMB+221  ].pos = {474.1000, 0.0938, -39.7732, 137}
mobList[zone][DMB+222  ].pos = {465.3293, 1.1241, -45.7196, 77}
mobList[zone][DMB+223  ].pos = {470.0686, 1.4503, -50.5842, 150}
mobList[zone][DMB+224  ].pos = {479.3802, 0.2089, -45.7283, 178}
mobList[zone][DMB+225  ].pos = {471.0633, 0.3659, -15.7049, 56}
mobList[zone][DMB+226  ].pos = {476.3187, 0.4854, -12.9030, 78}
mobList[zone][DMB+477  ].pos = {487.9113, 0.6762, -13.6614, 1}
mobList[zone][DMB+478  ].pos = {492.5678, 0.3704, -18.9696, 57}
mobList[zone][DMB+479  ].pos = {482.5498, 0.4906, -27.0479, 94}
--Nightmare Bunny
mobList[zone][DMB+227  ].pos = {-500.4587, -31.1175, 40.6901, 236}
mobList[zone][DMB+228  ].pos = {-495.7739, -31.2272, 39.3958, 11}
mobList[zone][DMB+229  ].pos = {-490.4445, -31.8260, 19.6098, 51}
mobList[zone][DMB+230  ].pos = {-484.6965, -31.5461, 14.0162, 78}
mobList[zone][DMB+231  ].pos = {-465.3930, -32.6130, 15.1436, 246}
mobList[zone][DMB+232  ].pos = {-466.7535, -32.3936, 20.7843, 175}
mobList[zone][DMB+233  ].pos = {-459.7678, -29.8715, 35.0834, 240}
mobList[zone][DMB+234  ].pos = {-458.0956, -30.0835, 43.2425, 200}
mobList[zone][DMB+235  ].pos = {-458.8814, -32.5718, 66.9976, 179}
mobList[zone][DMB+236  ].pos = {-465.0006, -31.3889, 72.7084, 160}
mobList[zone][DMB+237  ].pos = {-478.2877, -32.0000, 78.9771, 147}
mobList[zone][DMB+238  ].pos = {-483.2349, -32.0000, 81.4262, 146}
mobList[zone][DMB+239  ].pos = {-503.5589, -31.2163, 79.4331, 113}
mobList[zone][DMB+240  ].pos = {-511.9339, -31.7978, 76.3893, 113}
mobList[zone][DMB+241  ].pos = {-524.4575, -32.0880, 44.5391, 40}
mobList[zone][DMB+242  ].pos = {-526.3312, -32.5739, 42.4996, 131}
mobList[zone][DMB+496  ].pos = {-471.6640, -31.7843, -0.3831, 184}
mobList[zone][DMB+497  ].pos = {-464.1001, -31.2146, -0.5464, 120}
mobList[zone][DMB+498  ].pos = {-432.8346, -31.8996, 0.7240, 207}
mobList[zone][DMB+499  ].pos = {-427.8708, -31.7024, 5.0407, 145}
-- Nightmare Mandragora
mobList[zone][DMB+520  ].pos = {18.8103, -25.6353, 215.0178, 84}
mobList[zone][DMB+521  ].pos = {14.4507, -25.8432, 215.0486, 128}
mobList[zone][DMB+522  ].pos = {14.2471, -25.7548, 220.5003, 158}
mobList[zone][DMB+523  ].pos = {-0.9103, -24.2774, 235.0815, 0}
mobList[zone][DMB+524  ].pos = {5.6903, -24.5357, 242.9050, 46}
mobList[zone][DMB+525  ].pos = {3.2289, -24.0000, 238.4653, 251}
mobList[zone][DMB+526  ].pos = {-42.1285, -24.0754, 236.0463, 104}
mobList[zone][DMB+527  ].pos = {-40.4723, -24.0000, 238.5071, 250}
mobList[zone][DMB+528  ].pos = {-35.3389, -24.1134, 236.0161, 253}
mobList[zone][DMB+529  ].pos = {-27.1142, -25.0121, 265.3078, 82}
mobList[zone][DMB+530  ].pos = {-26.8868, -24.3494, 260.0490, 253}
mobList[zone][DMB+531  ].pos = {-32.5834, -23.8965, 266.0062, 221}
mobList[zone][DMB+532  ].pos = {-62.4796, -29.3045, 273.5851, 222}
mobList[zone][DMB+533  ].pos = {-63.8176, -29.4805, 277.4575, 254}
mobList[zone][DMB+534  ].pos = {-57.1254, -27.8022, 278.2867, 238}
mobList[zone][DMB+535  ].pos = {-105.0640, -31.3110, 277.3794, 172}
mobList[zone][DMB+536  ].pos = {-106.2535, -31.4301, 279.9367, 172}
mobList[zone][DMB+537  ].pos = {-100.5884, -31.1011, 284.3138, 215}
mobList[zone][DMB+538  ].pos = {-131.7827, -33.5953, 268.1009, 136}
mobList[zone][DMB+539  ].pos = {-139.0331, -33.6447, 265.6450, 215}
mobList[zone][DMB+540  ].pos = {-145.4037, -33.7469, 261.0375, 246}
mobList[zone][DMB+541  ].pos = {57.2546, -23.1384, 198.0793, 78}
mobList[zone][DMB+542  ].pos = {53.9017, -23.5723, 203.3086, 179}
mobList[zone][DMB+543  ].pos = {60.4103, -24.2500, 207.0856, 167}
-- Nightmare Crawler
mobList[zone][DMB+259  ].pos = {319.6010, 0.0000, 361.1112, 80}
mobList[zone][DMB+260  ].pos = {317.8693, 0.0000, 358.3013, 246}
mobList[zone][DMB+261  ].pos = {323.2807, 0.0000, 357.6271, 91}
mobList[zone][DMB+262  ].pos = {340.7446, 1.0797, 330.5484, 145}
mobList[zone][DMB+263  ].pos = {338.2596, 0.9850, 325.3451, 252}
mobList[zone][DMB+264  ].pos = {337.1280, 0.9671, 331.9686, 90}
mobList[zone][DMB+265  ].pos = {317.7736, 0.0000, 319.5869, 247}
mobList[zone][DMB+266  ].pos = {309.4247, -1.5303, 321.6266, 136}
mobList[zone][DMB+267  ].pos = {284.4820, -7.9469, 323.3417, 106}
mobList[zone][DMB+551  ].pos = {278.1880, -8.0000, 319.7731, 107}
mobList[zone][DMB+552  ].pos = {283.0578, -7.4367, 296.3896, 51}
mobList[zone][DMB+553  ].pos = {282.0612, -7.7628, 288.7672, 97}
mobList[zone][DMB+554  ].pos = {371.0742, 0.6000, 228.1120, 74}
mobList[zone][DMB+555  ].pos = {366.5767, 0.7523, 218.8685, 92}
mobList[zone][DMB+556  ].pos = {374.6455, 0.3026, 216.7436, 65}
mobList[zone][DMB+557  ].pos = {402.5201, 0.3097, 229.7839, 208}
mobList[zone][DMB+558  ].pos = {400.8975, 0.0391, 235.1942, 177}
mobList[zone][DMB+559  ].pos = {433.3880, -0.0124, 209.0955, 49}
mobList[zone][DMB+560  ].pos = {433.7487, 0.1114, 201.2834, 121}
mobList[zone][DMB+561  ].pos = {430.1181, 0.2929, 201.8347, 149}
mobList[zone][DMB+562  ].pos = {399.0885, 0.0000, 194.4992, 94}
mobList[zone][DMB+563  ].pos = {397.8453, 0.1269, 190.9244, 55}
mobList[zone][DMB+564  ].pos = {368.1004, 0.2465, 194.1234, 111}
mobList[zone][DMB+565  ].pos = {364.4777, 0.0227, 199.6740, 162}
--Nightmare Raven
mobList[zone][DMB+269  ].pos = {251.3917, -7.5990, -27.2447, 247}
mobList[zone][DMB+270  ].pos = {248.1401, -8.3936, -31.8380, 91}
mobList[zone][DMB+271  ].pos = {247.8203, -7.7523, -51.8739, 76}
mobList[zone][DMB+272  ].pos = {241.0595, -7.0022, -59.9794, 129}
mobList[zone][DMB+273  ].pos = {226.7718, -8.4287, -67.0033, 101}
mobList[zone][DMB+274  ].pos = {220.9340, -9.4434, -62.6842, 158}
mobList[zone][DMB+275  ].pos = {212.1411, -13.9209, -45.4596, 175}
mobList[zone][DMB+276  ].pos = {209.5000, -15.0001, -37.4746, 208}
mobList[zone][DMB+277  ].pos = {189.4418, -14.5562, -35.2972, 106}
mobList[zone][DMB+278  ].pos = {187.8147, -13.3340, -30.7853, 179}
mobList[zone][DMB+279  ].pos = {192.6980, -12.6985, -60.3909, 50}
mobList[zone][DMB+280  ].pos = {189.3235, -7.0520, -68.8272, 112}
mobList[zone][DMB+281  ].pos = {164.4827, -7.9380, -4.5929, 98}
mobList[zone][DMB+282  ].pos = {169.4024, -7.8257, -4.7580, 2}
mobList[zone][DMB+283  ].pos = {194.2779, -7.9510, 10.4772, 243}
mobList[zone][DMB+284  ].pos = {205.5011, -7.9553, 8.8672, 252}
mobList[zone][DMB+285  ].pos = {153.4070, -7.2771, -17.0971, 133}
mobList[zone][DMB+286  ].pos = {153.8699, -7.2000, -23.8934, 56}
mobList[zone][DMB+287  ].pos = {133.5932, -7.9051, -41.3949, 50}
mobList[zone][DMB+288  ].pos = {135.6232, -8.0777, -42.6471, 25}
mobList[zone][DMB+572  ].pos = {107.4268, -7.9171, -27.6511, 142}
mobList[zone][DMB+573  ].pos = {102.3821, -7.8493, -23.0362, 140}
mobList[zone][DMB+574  ].pos = {104.9176, -7.3981, 7.3448, 79}
mobList[zone][DMB+575  ].pos = {102.5564, -8.1223, 14.6608, 179}
mobList[zone][DMB+576  ].pos = {78.0692, -7.9856, 4.3110, 91}
mobList[zone][DMB+577  ].pos = {75.4299, -8.0374, -1.7323, 86}
--Nightmare Eft
mobList[zone][DMB+289  ].pos = {-361.8208, -9.4083, -189.7500, 254}
mobList[zone][DMB+290  ].pos = {-358.7366, -8.0000, -197.0368, 167}
mobList[zone][DMB+291  ].pos = {-388.3024, -7.6163, -196.1346, 60}
mobList[zone][DMB+292  ].pos = {-392.3798, -8.5402, -192.1098, 157}
mobList[zone][DMB+293  ].pos = {-411.7224, -7.6151, -198.3405, 131}
mobList[zone][DMB+294  ].pos = {-417.6263, -7.7843, -192.3318, 134}
mobList[zone][DMB+295  ].pos = {-444.0339, -8.0858, -193.2675, 164}
mobList[zone][DMB+296  ].pos = {-444.6999, -8.2927, -190.2555, 16}
mobList[zone][DMB+297  ].pos = {-481.2613, -16.0000, -241.4592, 71}
mobList[zone][DMB+298  ].pos = {-479.4951, -16.0000, -243.0861, 35}
mobList[zone][DMB+299  ].pos = {-450.6776, -9.8428, -262.6942, 35}
mobList[zone][DMB+300  ].pos = {-445.6714, -9.1941, -257.4806, 229}
mobList[zone][DMB+301  ].pos = {-426.0003, -5.8710, -279.0026, 24}
mobList[zone][DMB+302  ].pos = {-432.6729, -7.5913, -281.1773, 129}
mobList[zone][DMB+303  ].pos = {-403.1646, 0.0000, -278.8900, 233}
mobList[zone][DMB+304  ].pos = {-401.6548, -0.3184, -273.5102, 205}
mobList[zone][DMB+305  ].pos = {-381.4844, -9.1690, -220.7178, 122}
mobList[zone][DMB+306  ].pos = {-386.0872, -8.7743, -218.2662, 241}
mobList[zone][DMB+590  ].pos = {-355.3060, -8.1887, -200.9366, 245}
mobList[zone][DMB+591  ].pos = {-359.9953, -8.3044, -205.1856, 90}
--Nightmare Cockatrice
mobList[zone][DMB+620  ].pos = {-313.1621, -39.8093, 257.1451, 19}
mobList[zone][DMB+621  ].pos = {-312.4508, -40.0850, 265.7268, 251}
mobList[zone][DMB+622  ].pos = {-299.1613, -39.8762, 269.6068, 215}
mobList[zone][DMB+623  ].pos = {-301.6097, -41.1347, 259.3679, 78}
mobList[zone][DMB+624  ].pos = {-352.1228, -39.8073, 236.7914, 139}
mobList[zone][DMB+625  ].pos = {-358.3139, -40.0000, 241.4646, 180}
mobList[zone][DMB+626  ].pos = {-361.2079, -40.2316, 231.6764, 94}
mobList[zone][DMB+627  ].pos = {-351.4143, -40.0605, 223.4486, 227}
mobList[zone][DMB+628  ].pos = {-334.8820, -31.3485, 204.2709, 51}
mobList[zone][DMB+629  ].pos = {-330.9466, -31.6538, 197.1722, 2}
mobList[zone][DMB+630  ].pos = {-337.4206, -31.3346, 195.2325, 109}
mobList[zone][DMB+628  ].pos = {-318.3690, -30.5167, 189.2187, 14}
mobList[zone][DMB+631  ].pos = {-357.9044, -32.3993, 154.4069, 9}
mobList[zone][DMB+632  ].pos = {-351.8373, -31.4871, 158.4229, 185}
mobList[zone][DMB+633  ].pos = {-352.3749, -31.5144, 168.4233, 173}
mobList[zone][DMB+634  ].pos = {-340.5129, -28.6569, 160.1128, 56}
mobList[zone][DMB+635  ].pos = {-318.5551, -23.0392, 139.2384, 11}
mobList[zone][DMB+636  ].pos = {-310.6508, -23.6236, 137.7404, 50}
mobList[zone][DMB+637  ].pos = {-310.4880, -23.9568, 125.5293, 55}
mobList[zone][DMB+638  ].pos = {-323.6383, -24.0892, 125.3986, 125}

-- Wavelists
--Dragons
mobList[zone][DMB+307 ].waves = { 1, nil, nil}
mobList[zone][DMB+309 ].waves = { 1, nil, nil}
mobList[zone][DMB+610 ].waves = { 1, nil, nil}
mobList[zone][DMB+611 ].waves = { 1, nil, nil}
mobList[zone][DMB+308 ].waves = { 1, nil, nil}
mobList[zone][DMB+612 ].waves = { 1, nil, nil}
mobList[zone][DMB+613 ].waves = { 1, nil, nil}
mobList[zone][DMB+614 ].waves = { 1, nil, nil}
mobList[zone][DMB+310 ].waves = { 1, nil, nil}
mobList[zone][DMB+615 ].waves = { 1, nil, nil}
--stats
mobList[zone][SMB+50  ].waves = { 1, nil, nil}
mobList[zone][SMB+51  ].waves = { 1, nil, nil}
mobList[zone][SMB+52  ].waves = { 1, nil, nil}
mobList[zone][SMB+67  ].waves = { 1, nil, nil}
mobList[zone][SMB+68  ].waves = { 1, nil, nil}
mobList[zone][SMB+69  ].waves = { 1, nil, nil}
mobList[zone][SMB+343 ].waves = { 1, nil, nil}
mobList[zone][SMB+344 ].waves = { 1, nil, nil}
mobList[zone][SMB+345 ].waves = { 1, nil, nil}
mobList[zone][SMB+357 ].waves = { 1, nil, nil}
mobList[zone][SMB+358 ].waves = { 1, nil, nil}
mobList[zone][SMB+359 ].waves = { 1, nil, nil}
mobList[zone][SMB+603 ].waves = { 1, nil, nil}
mobList[zone][SMB+0   ].waves = { 1, nil, nil}
mobList[zone][SMB+1   ].waves = { 1, nil, nil}
mobList[zone][SMB+2   ].waves = { 1, nil, nil}
mobList[zone][SMB+15  ].waves = { 1, nil, nil}
mobList[zone][SMB+16  ].waves = { 1, nil, nil}
mobList[zone][SMB+17  ].waves = { 1, nil, nil}
mobList[zone][SMB+30  ].waves = { 1, nil, nil}
mobList[zone][SMB+31  ].waves = { 1, nil, nil}
mobList[zone][SMB+32  ].waves = { 1, nil, nil}
mobList[zone][SMB+313 ].waves = { 1, nil, nil}
mobList[zone][SMB+314 ].waves = { 1, nil, nil}
mobList[zone][SMB+85  ].waves = { 1, nil, nil}
mobList[zone][SMB+86  ].waves = { 1, nil, nil}
mobList[zone][SMB+87  ].waves = { 1, nil, nil}
mobList[zone][SMB+103 ].waves = { 1, nil, nil}
mobList[zone][SMB+104 ].waves = { 1, nil, nil}
mobList[zone][SMB+105 ].waves = { 1, nil, nil}
mobList[zone][SMB+372 ].waves = { 1, nil, nil}
mobList[zone][SMB+373 ].waves = { 1, nil, nil}
mobList[zone][SMB+374 ].waves = { 1, nil, nil}
mobList[zone][SMB+387 ].waves = { 1, nil, nil}
mobList[zone][SMB+388 ].waves = { 1, nil, nil}
mobList[zone][SMB+389 ].waves = { 1, nil, nil}
mobList[zone][SMB+604 ].waves = { 1, nil, nil}
mobList[zone][SMB+122 ].waves = { 1, nil, nil}
mobList[zone][SMB+123 ].waves = { 1, nil, nil}
mobList[zone][SMB+124 ].waves = { 1, nil, nil}
mobList[zone][SMB+140 ].waves = { 1, nil, nil}
mobList[zone][SMB+141 ].waves = { 1, nil, nil}
mobList[zone][SMB+142 ].waves = { 1, nil, nil}
mobList[zone][SMB+403 ].waves = { 1, nil, nil}
mobList[zone][SMB+404 ].waves = { 1, nil, nil}
mobList[zone][SMB+405 ].waves = { 1, nil, nil}
mobList[zone][SMB+417 ].waves = { 1, nil, nil}
mobList[zone][SMB+418 ].waves = { 1, nil, nil}
mobList[zone][SMB+419 ].waves = { 1, nil, nil}
mobList[zone][SMB+605 ].waves = { 1, nil, nil}
--Apoc Beast
mobList[zone][DMB+0   ].waves = { nil, 2, nil}
--Nightmare Mobs
mobList[zone][DMB+155   ].waves = { nil, 2, nil}
mobList[zone][DMB+156   ].waves = { nil, 2, nil}
mobList[zone][DMB+157   ].waves = { nil, 2, nil}
mobList[zone][DMB+158   ].waves = { nil, 2, nil}
mobList[zone][DMB+159   ].waves = { nil, 2, nil}
mobList[zone][DMB+160   ].waves = { nil, 2, nil}
mobList[zone][DMB+161   ].waves = { nil, 2, nil}
mobList[zone][DMB+162   ].waves = { nil, 2, nil}
mobList[zone][DMB+163   ].waves = { nil, 2, nil}
mobList[zone][DMB+164   ].waves = { nil, 2, nil}
mobList[zone][DMB+165   ].waves = { nil, 2, nil}
mobList[zone][DMB+166   ].waves = { nil, 2, nil}
mobList[zone][DMB+167   ].waves = { nil, 2, nil}
mobList[zone][DMB+168   ].waves = { nil, 2, nil}
mobList[zone][DMB+169   ].waves = { nil, 2, nil}
mobList[zone][DMB+170   ].waves = { nil, 2, nil}
mobList[zone][DMB+171   ].waves = { nil, 2, nil}
mobList[zone][DMB+172   ].waves = { nil, 2, nil}
mobList[zone][DMB+173   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+174   ].waves = { nil, 2, nil}
mobList[zone][DMB+193   ].waves = { nil, 2, nil}
mobList[zone][DMB+194   ].waves = { nil, 2, nil}
mobList[zone][DMB+195   ].waves = { nil, 2, nil}
mobList[zone][DMB+196   ].waves = { nil, 2, nil}
mobList[zone][DMB+197   ].waves = { nil, 2, nil}
mobList[zone][DMB+198   ].waves = { nil, 2, nil}
mobList[zone][DMB+199   ].waves = { nil, 2, nil}
mobList[zone][DMB+200   ].waves = { nil, 2, nil}
mobList[zone][DMB+201   ].waves = { nil, 2, nil}
mobList[zone][DMB+202   ].waves = { nil, 2, nil}
mobList[zone][DMB+203   ].waves = { nil, 2, nil}
mobList[zone][DMB+204   ].waves = { nil, 2, nil}
mobList[zone][DMB+205   ].waves = { nil, 2, nil}
mobList[zone][DMB+206   ].waves = { nil, 2, nil}
mobList[zone][DMB+207   ].waves = { nil, 2, nil}
mobList[zone][DMB+208   ].waves = { nil, 2, nil}
mobList[zone][DMB+464   ].waves = { nil, 2, nil}
mobList[zone][DMB+465   ].waves = { nil, 2, nil}
mobList[zone][DMB+466   ].waves = { nil, 2, nil}
mobList[zone][DMB+467   ].waves = { nil, 2, nil}
mobList[zone][DMB+468   ].waves = { nil, 2, nil}
mobList[zone][DMB+469   ].waves = { nil, 2, nil}
mobList[zone][DMB+209   ].waves = { nil, 2, nil}
mobList[zone][DMB+210   ].waves = { nil, 2, nil}
mobList[zone][DMB+211   ].waves = { nil, 2, nil}
mobList[zone][DMB+212   ].waves = { nil, 2, nil}
mobList[zone][DMB+213   ].waves = { nil, 2, nil}
mobList[zone][DMB+214   ].waves = { nil, 2, nil}
mobList[zone][DMB+215   ].waves = { nil, 2, nil}
mobList[zone][DMB+216   ].waves = { nil, 2, nil}
mobList[zone][DMB+217   ].waves = { nil, 2, nil}
mobList[zone][DMB+218   ].waves = { nil, 2, nil}
mobList[zone][DMB+219   ].waves = { nil, 2, nil}
mobList[zone][DMB+220   ].waves = { nil, 2, nil}
mobList[zone][DMB+221   ].waves = { nil, 2, nil}
mobList[zone][DMB+222   ].waves = { nil, 2, nil}
mobList[zone][DMB+223   ].waves = { nil, 2, nil}
mobList[zone][DMB+224   ].waves = { nil, 2, nil}
mobList[zone][DMB+225   ].waves = { nil, 2, nil}
mobList[zone][DMB+226   ].waves = { nil, 2, nil}
mobList[zone][DMB+477   ].waves = { nil, 2, nil}
mobList[zone][DMB+478   ].waves = { nil, 2, nil}
mobList[zone][DMB+479   ].waves = { nil, 2, nil}
mobList[zone][DMB+227   ].waves = { nil, 2, nil}
mobList[zone][DMB+228   ].waves = { nil, 2, nil}
mobList[zone][DMB+229   ].waves = { nil, 2, nil}
mobList[zone][DMB+230   ].waves = { nil, 2, nil}
mobList[zone][DMB+231   ].waves = { nil, 2, nil}
mobList[zone][DMB+232   ].waves = { nil, 2, nil}
mobList[zone][DMB+233   ].waves = { nil, 2, nil}
mobList[zone][DMB+234   ].waves = { nil, 2, nil}
mobList[zone][DMB+235   ].waves = { nil, 2, nil}
mobList[zone][DMB+236   ].waves = { nil, 2, nil}
mobList[zone][DMB+237   ].waves = { nil, 2, nil}
mobList[zone][DMB+238   ].waves = { nil, 2, nil}
mobList[zone][DMB+239   ].waves = { nil, 2, nil}
mobList[zone][DMB+240   ].waves = { nil, 2, nil}
mobList[zone][DMB+241   ].waves = { nil, 2, nil}
mobList[zone][DMB+242   ].waves = { nil, 2, nil}
mobList[zone][DMB+496   ].waves = { nil, 2, nil}
mobList[zone][DMB+497   ].waves = { nil, 2, nil}
mobList[zone][DMB+498   ].waves = { nil, 2, nil}
mobList[zone][DMB+499   ].waves = { nil, 2, nil}
mobList[zone][DMB+520   ].waves = { nil, 2, nil}
mobList[zone][DMB+521   ].waves = { nil, 2, nil}
mobList[zone][DMB+522   ].waves = { nil, 2, nil}
mobList[zone][DMB+523   ].waves = { nil, 2, nil}
mobList[zone][DMB+524   ].waves = { nil, 2, nil}
mobList[zone][DMB+525   ].waves = { nil, 2, nil}
mobList[zone][DMB+526   ].waves = { nil, 2, nil}
mobList[zone][DMB+527   ].waves = { nil, 2, nil}
mobList[zone][DMB+528   ].waves = { nil, 2, nil}
mobList[zone][DMB+529   ].waves = { nil, 2, nil}
mobList[zone][DMB+530   ].waves = { nil, 2, nil}
mobList[zone][DMB+531   ].waves = { nil, 2, nil}
mobList[zone][DMB+532   ].waves = { nil, 2, nil}
mobList[zone][DMB+533   ].waves = { nil, 2, nil}
mobList[zone][DMB+534   ].waves = { nil, 2, nil}
mobList[zone][DMB+535   ].waves = { nil, 2, nil}
mobList[zone][DMB+536   ].waves = { nil, 2, nil}
mobList[zone][DMB+537   ].waves = { nil, 2, nil}
mobList[zone][DMB+538   ].waves = { nil, 2, nil}
mobList[zone][DMB+539   ].waves = { nil, 2, nil}
mobList[zone][DMB+540   ].waves = { nil, 2, nil}
mobList[zone][DMB+541   ].waves = { nil, 2, nil}
mobList[zone][DMB+542   ].waves = { nil, 2, nil}
mobList[zone][DMB+543   ].waves = { nil, 2, nil}
mobList[zone][DMB+259   ].waves = { nil, 2, nil}
mobList[zone][DMB+260   ].waves = { nil, 2, nil}
mobList[zone][DMB+261   ].waves = { nil, 2, nil}
mobList[zone][DMB+262   ].waves = { nil, 2, nil}
mobList[zone][DMB+263   ].waves = { nil, 2, nil}
mobList[zone][DMB+264   ].waves = { nil, 2, nil}
mobList[zone][DMB+265   ].waves = { nil, 2, nil}
mobList[zone][DMB+266   ].waves = { nil, 2, nil}
mobList[zone][DMB+267   ].waves = { nil, 2, nil}
mobList[zone][DMB+551   ].waves = { nil, 2, nil}
mobList[zone][DMB+552   ].waves = { nil, 2, nil}
mobList[zone][DMB+553   ].waves = { nil, 2, nil}
mobList[zone][DMB+554   ].waves = { nil, 2, nil}
mobList[zone][DMB+555   ].waves = { nil, 2, nil}
mobList[zone][DMB+556   ].waves = { nil, 2, nil}
mobList[zone][DMB+557   ].waves = { nil, 2, nil}
mobList[zone][DMB+558   ].waves = { nil, 2, nil}
mobList[zone][DMB+559   ].waves = { nil, 2, nil}
mobList[zone][DMB+560   ].waves = { nil, 2, nil}
mobList[zone][DMB+561   ].waves = { nil, 2, nil}
mobList[zone][DMB+562   ].waves = { nil, 2, nil}
mobList[zone][DMB+563   ].waves = { nil, 2, nil}
mobList[zone][DMB+564   ].waves = { nil, 2, nil}
mobList[zone][DMB+565   ].waves = { nil, 2, nil}
mobList[zone][DMB+269   ].waves = { nil, 2, nil}
mobList[zone][DMB+270   ].waves = { nil, 2, nil}
mobList[zone][DMB+271   ].waves = { nil, 2, nil}
mobList[zone][DMB+272   ].waves = { nil, 2, nil}
mobList[zone][DMB+273   ].waves = { nil, 2, nil}
mobList[zone][DMB+274   ].waves = { nil, 2, nil}
mobList[zone][DMB+275   ].waves = { nil, 2, nil}
mobList[zone][DMB+276   ].waves = { nil, 2, nil}
mobList[zone][DMB+277   ].waves = { nil, 2, nil}
mobList[zone][DMB+278   ].waves = { nil, 2, nil}
mobList[zone][DMB+279   ].waves = { nil, 2, nil}
mobList[zone][DMB+280   ].waves = { nil, 2, nil}
mobList[zone][DMB+281   ].waves = { nil, 2, nil}
mobList[zone][DMB+282   ].waves = { nil, 2, nil}
mobList[zone][DMB+283   ].waves = { nil, 2, nil}
mobList[zone][DMB+284   ].waves = { nil, 2, nil}
mobList[zone][DMB+285   ].waves = { nil, 2, nil}
mobList[zone][DMB+286   ].waves = { nil, 2, nil}
mobList[zone][DMB+287   ].waves = { nil, 2, nil}
mobList[zone][DMB+288   ].waves = { nil, 2, nil}
mobList[zone][DMB+572   ].waves = { nil, 2, nil}
mobList[zone][DMB+573   ].waves = { nil, 2, nil}
mobList[zone][DMB+574   ].waves = { nil, 2, nil}
mobList[zone][DMB+575   ].waves = { nil, 2, nil}
mobList[zone][DMB+576   ].waves = { nil, 2, nil}
mobList[zone][DMB+577   ].waves = { nil, 2, nil}
mobList[zone][DMB+289   ].waves = { nil, 2, nil}
mobList[zone][DMB+290   ].waves = { nil, 2, nil}
mobList[zone][DMB+291   ].waves = { nil, 2, nil}
mobList[zone][DMB+292   ].waves = { nil, 2, nil}
mobList[zone][DMB+293   ].waves = { nil, 2, nil}
mobList[zone][DMB+294   ].waves = { nil, 2, nil}
mobList[zone][DMB+295   ].waves = { nil, 2, nil}
mobList[zone][DMB+296   ].waves = { nil, 2, nil}
mobList[zone][DMB+297   ].waves = { nil, 2, nil}
mobList[zone][DMB+298   ].waves = { nil, 2, nil}
mobList[zone][DMB+299   ].waves = { nil, 2, nil}
mobList[zone][DMB+300   ].waves = { nil, 2, nil}
mobList[zone][DMB+301   ].waves = { nil, 2, nil}
mobList[zone][DMB+302   ].waves = { nil, 2, nil}
mobList[zone][DMB+303   ].waves = { nil, 2, nil}
mobList[zone][DMB+304   ].waves = { nil, 2, nil}
mobList[zone][DMB+305   ].waves = { nil, 2, nil}
mobList[zone][DMB+306   ].waves = { nil, 2, nil}
mobList[zone][DMB+590   ].waves = { nil, 2, nil}
mobList[zone][DMB+591   ].waves = { nil, 2, nil}
mobList[zone][DMB+620   ].waves = { nil, 2, nil}
mobList[zone][DMB+621   ].waves = { nil, 2, nil}
mobList[zone][DMB+622   ].waves = { nil, 2, nil}
mobList[zone][DMB+623   ].waves = { nil, 2, nil}
mobList[zone][DMB+624   ].waves = { nil, 2, nil}
mobList[zone][DMB+625   ].waves = { nil, 2, nil}
mobList[zone][DMB+626   ].waves = { nil, 2, nil}
mobList[zone][DMB+627   ].waves = { nil, 2, nil}
mobList[zone][DMB+628   ].waves = { nil, 2, nil}
mobList[zone][DMB+629   ].waves = { nil, 2, nil}
mobList[zone][DMB+630   ].waves = { nil, 2, nil}
mobList[zone][DMB+628   ].waves = { nil, 2, nil}
mobList[zone][DMB+631   ].waves = { nil, 2, nil}
mobList[zone][DMB+632   ].waves = { nil, 2, nil}
mobList[zone][DMB+633   ].waves = { nil, 2, nil}
mobList[zone][DMB+634   ].waves = { nil, 2, nil}
mobList[zone][DMB+635   ].waves = { nil, 2, nil}
mobList[zone][DMB+636   ].waves = { nil, 2, nil}
mobList[zone][DMB+637   ].waves = { nil, 2, nil}
mobList[zone][DMB+638   ].waves = { nil, 2, nil}

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
-- mobList[zone].waveDefeatRequirements[2] = { DMB+10, DMB+20, DMB+30, DMB+40 } -- example of 4 bosses
-- mobList[zone].waveDefeatRequirements[3] = { SMB+1 } -- example of mega boss for respawns

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
-- mobList[zone][SMB+1  ].waves = {  1 ,nil,nil } -- example

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][SMB+1  ].specificChildren = { SMB+2, SMB+3, SMB+4 } -- example

-- set how many random children i will spawn when i engage
-- mobList[zone][SMB+1  ].randomChildrenCount = 3 -- example

-- set my random children list i will pick from
-- mobList[zone][SMB+1  ].randomChildrenList = 1 -- example

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] =
{
    [1] =
    {
        -- 12345678, -- example
        -- 23456789, -- example
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] =
{

}