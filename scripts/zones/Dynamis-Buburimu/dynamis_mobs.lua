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
[DMB+614] = { id =  DMB+614}, -- Stollenwurm        ( 057 )
[DMB+615] = { id =  DMB+615}, -- Koschei            ( 058 )
[DMB+310] = { id =  DMB+310}, -- Aitvaras           ( 059 )
[DMB+616] = { id =  DMB+616}, -- Vishap             ( 060 )
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
[SMB+606] = { id =  SMB+606}, -- Sergeant Tombstone (013-O)
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
[SMB+607] = { id =  SMB+607}, -- Adamantking Effigy (037-Q)
-- Yagudos Statues
[SMB+122] = { id =  SMB+122}, -- Manifest Icon      (038-Y)
[SMB+123] = { id =  SMB+123}, -- Manifest Icon      (039-Y)
[SMB+124] = { id =  SMB+124}, -- Manifest Icon      (040-Y)
[SMB+140] = { id =  SMB+140}, -- Manifest Icon      (041-Y)
[SMB+141] = { id =  SMB+141}, -- Manifest Icon      (042-Y)
[SMB+142] = { id =  SMB+142}, -- Manifest Icon      (043-Y)
[SMB+403] = { id =  SMB+403}, -- Manifest Icon      (044-Y)
[SMB+404] = { id =  SMB+404}, -- Manifest Icon      (045-Y)
[SMB+405] = { id =  SMB+405}, -- Manifest Icon      (046-Y)
[SMB+417] = { id =  SMB+417}, -- Manifest Icon      (047-Y)
[SMB+418] = { id =  SMB+418}, -- Manifest Icon      (048-Y)
[SMB+419] = { id =  SMB+419}, -- Manifest Icon      (049-Y)
[SMB+608] = { id =  SMB+608}, -- Manifest Icon      (050-Y)
-- Nightmare Mobs
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
[DMB+643] = { id =  DMB+643}, -- Nightmare Cockatrice
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
-- All Statue Spawned Mobs
[DMB+59 ] = { id =  DMB+59 },
[DMB+47 ] = { id =  DMB+47 },
[DMB+49 ] = { id =  DMB+49 },
[DMB+54 ] = { id =  DMB+54 },
[DMB+74 ] = { id =  DMB+74 },
[DMB+52 ] = { id =  DMB+52 },
[DMB+58 ] = { id =  DMB+58 },
[DMB+65 ] = { id =  DMB+65 },
[DMB+68 ] = { id =  DMB+68 },
[DMB+55 ] = { id =  DMB+55 },
[DMB+73 ] = { id =  DMB+73 },
[DMB+45 ] = { id =  DMB+45 },
[DMB+76 ] = { id =  DMB+76 },
[DMB+56 ] = { id =  DMB+56 },
[DMB+348] = { id =  DMB+348},
[DMB+66 ] = { id =  DMB+66 },
[DMB+50 ] = { id =  DMB+50 },
[DMB+48 ] = { id =  DMB+48 },
[DMB+72 ] = { id =  DMB+72 },
[DMB+351] = { id =  DMB+351},
[DMB+69 ] = { id =  DMB+69 },
[DMB+77 ] = { id =  DMB+77 },
[DMB+67 ] = { id =  DMB+67 },
[DMB+360] = { id =  DMB+360},
[DMB+70 ] = { id =  DMB+70 },
[DMB+366] = { id =  DMB+366},
[DMB+350] = { id =  DMB+350},
[DMB+346] = { id =  DMB+346},
[DMB+5  ] = { id =  DMB+5  },
[DMB+40 ] = { id =  DMB+40 },
[DMB+33 ] = { id =  DMB+33 },
[DMB+35 ] = { id =  DMB+35 },
[DMB+23 ] = { id =  DMB+23 },
[DMB+22 ] = { id =  DMB+22 },
[DMB+3  ] = { id =  DMB+3  },
[DMB+38 ] = { id =  DMB+38 },
[DMB+6  ] = { id =  DMB+6  },
[DMB+9  ] = { id =  DMB+9  },
[DMB+36 ] = { id =  DMB+36 },
[DMB+21 ] = { id =  DMB+21 },
[DMB+17 ] = { id =  DMB+17 },
[DMB+19 ] = { id =  DMB+19 },
[DMB+20 ] = { id =  DMB+20 },
[DMB+25 ] = { id =  DMB+25 },
[DMB+30 ] = { id =  DMB+30 },
[DMB+15 ] = { id =  DMB+15 },
[DMB+7  ] = { id =  DMB+7  },
[DMB+322] = { id =  DMB+322},
[DMB+335] = { id =  DMB+335},
[DMB+314] = { id =  DMB+314},
[DMB+94 ] = { id =  DMB+94 },
[DMB+82 ] = { id =  DMB+82 },
[DMB+87 ] = { id =  DMB+87 },
[DMB+375] = { id =  DMB+375},
[DMB+100] = { id =  DMB+100},
[DMB+101] = { id =  DMB+101},
[DMB+106] = { id =  DMB+106},
[DMB+393] = { id =  DMB+393},
[DMB+113] = { id =  DMB+113},
[DMB+105] = { id =  DMB+105},
[DMB+108] = { id =  DMB+108},
[DMB+109] = { id =  DMB+109},
[DMB+89 ] = { id =  DMB+89 },
[DMB+377] = { id =  DMB+377},
[DMB+92 ] = { id =  DMB+92 },
[DMB+381] = { id =  DMB+381},
[DMB+102] = { id =  DMB+102},
[DMB+388] = { id =  DMB+388},
[DMB+107] = { id =  DMB+107},
[DMB+394] = { id =  DMB+394},
[DMB+95 ] = { id =  DMB+95 },
[DMB+85 ] = { id =  DMB+85 },
[DMB+83 ] = { id =  DMB+83 },
[DMB+84 ] = { id =  DMB+84 },
[DMB+391] = { id =  DMB+391},
[DMB+392] = { id =  DMB+392},
[DMB+387] = { id =  DMB+387},
[DMB+640] = { id =  DMB+640},
[DMB+110] = { id =  DMB+110},
[DMB+396] = { id =  DMB+396},
[DMB+112] = { id =  DMB+112},
[DMB+103] = { id =  DMB+103},
[DMB+90 ] = { id =  DMB+90 },
[DMB+91 ] = { id =  DMB+91 },
[DMB+118] = { id =  DMB+118},
[DMB+128] = { id =  DMB+128},
[DMB+119] = { id =  DMB+119},
[DMB+410] = { id =  DMB+410},
[DMB+132] = { id =  DMB+132},
[DMB+137] = { id =  DMB+137},
[DMB+144] = { id =  DMB+144},
[DMB+143] = { id =  DMB+143},
[DMB+125] = { id =  DMB+125},
[DMB+129] = { id =  DMB+129},
[DMB+146] = { id =  DMB+146},
[DMB+127] = { id =  DMB+127},
[DMB+149] = { id =  DMB+149},
[DMB+120] = { id =  DMB+120},
[DMB+139] = { id =  DMB+139},
[DMB+141] = { id =  DMB+141},
[DMB+426] = { id =  DMB+426},
[DMB+406] = { id =  DMB+406},
[DMB+407] = { id =  DMB+407},
[DMB+412] = { id =  DMB+412},
[DMB+422] = { id =  DMB+422},
[DMB+423] = { id =  DMB+423},
[DMB+122] = { id =  DMB+122},
[DMB+137] = { id =  DMB+137},
[DMB+148] = { id =  DMB+148},
[DMB+145] = { id =  DMB+145},
[DMB+425] = { id =  DMB+425},
[DMB+641] = { id =  DMB+641},
[DMB+123] = { id =  DMB+123},
[DMB+424] = { id =  DMB+424},
[DMB+131] = { id =  DMB+131},
[DMB+642] = { id =  DMB+642},
[DMB+124] = { id =  DMB+124},
[DMB+406] = { id =  DMB+486},

}

mobList[zone].zoneID = tpz.zone.DYNAMIS_BUBURIMU

--Dragons
mobList[zone][DMB+0  ].pos = {-201.7883, -29.9139, 147.2554, 57 } -- Apoc Beast
mobList[zone][DMB+307].pos = {60.7967, -23.0410, 199.0426, 12   } -- Stihi
mobList[zone][DMB+309].pos = {-339.9798, -39.0022, 243.1307, 70 } -- Alklha
mobList[zone][DMB+610].pos = {232.1226, -9.4403, 211.5448, 20   } -- Basilic
mobList[zone][DMB+611].pos = {346.0957, -9.2967, 271.6128, 66   } -- Jurik
mobList[zone][DMB+308].pos = {-428.8357, -7.4000, -221.6568, 211} -- Barong
mobList[zone][DMB+612].pos = {-41.1463, -16.0195, -3.8987, 63   } -- Tarasca
mobList[zone][DMB+614].pos = {-33.7517, 16.1113, -236.2199, 186 } -- Stollenwurm
mobList[zone][DMB+615].pos = {36.0265, 0.1348, -233.2813, 193   } -- Koschei
mobList[zone][DMB+310].pos = {206.5141, -7.7500, 4.5535, 119    } -- Aitvaras
mobList[zone][DMB+616].pos = {482.4607, 0.9171, -18.3645, 127   } -- Vishap
--Orc Stats
mobList[zone][SMB+50 ].pos = {-489.6237, -29.8504, 59.9449, 63  }
mobList[zone][SMB+51 ].pos = {-483.8572, -30.9016, 65.4925, 63  }
mobList[zone][SMB+52 ].pos = {-474.6325, -29.7465, 58.5642, 63  }
mobList[zone][SMB+67 ].pos = {-365.3331, -22.1115, 21.2624, 198 }
mobList[zone][SMB+68 ].pos = {-355.8970, -21.9494, 21.5242, 198 }
mobList[zone][SMB+69 ].pos = {-360.7734, -21.8964, 18.8860, 198 }
mobList[zone][SMB+343].pos = {-370.3228, -23.2670, 15.0742, 71  }
mobList[zone][SMB+344].pos = {-353.7643, -22.5512, 15.7313, 71  }
mobList[zone][SMB+345].pos = {-216.7957, -22.1539, 96.7794, 64  }
mobList[zone][SMB+357].pos = {-216.1143, -22.1460, 106.0876, 189}
mobList[zone][SMB+358].pos = {-208.1248, -21.6153, 101.4173, 189}
mobList[zone][SMB+359].pos = {-199.5664, -22.8261, 94.8028, 9   }
mobList[zone][SMB+606].pos = {-199.2854, -22.8656, 105.3254, 195}
--Goblin Stats
mobList[zone][SMB+0  ].pos = {-30.1739, -13.7288, 61.2518, 82   }
mobList[zone][SMB+1  ].pos = {-24.6467, -13.2863, 58.9652, 82   }
mobList[zone][SMB+2  ].pos = { -15.2367, -13.3332, 57.8845, 82  }
mobList[zone][SMB+15 ].pos = {26.1893, -13.1639, 61.5514, 74    }
mobList[zone][SMB+16 ].pos = {36.0939, -13.8959, 61.0378, 74    }
mobList[zone][SMB+17 ].pos = {47.8134, -12.8931, 60.0505, 74    }
mobList[zone][SMB+30 ].pos = {-20.4471, -13.5662, -5.0198, 67   }
mobList[zone][SMB+31 ].pos = {-20.9386, -6.1433, -33.5945, 185  }
mobList[zone][SMB+32 ].pos = {-12.7062, -7.3521, -42.6142, 249  }
mobList[zone][SMB+313].pos = {-26.1805, -6.9301, -43.9465, 128  }
mobList[zone][SMB+314].pos = {-18.5424, -6.0020, -48.6369, 49   }
--Quadav Stats
mobList[zone][SMB+85 ].pos = {241.4802, -5.7749, 20.1419, 129   }
mobList[zone][SMB+86 ].pos = {257.7976, -2.3514, 22.7234, 129   }
mobList[zone][SMB+87 ].pos = { 279.3134, 2.1576, 20.6812, 129   }
mobList[zone][SMB+103].pos = { 302.2001, 2.1881, 96.2034, 170   }
mobList[zone][SMB+104].pos = { 299.4405, 2.1729, 82.7570, 170   }
mobList[zone][SMB+105].pos = {300.0283, 2.2393, 77.8772, 170    }
mobList[zone][SMB+372].pos = {283.6140, 2.1808, 19.5053, 128    }
mobList[zone][SMB+373].pos = {299.0122, 2.2500, 37.3500, 128    }
mobList[zone][SMB+374].pos = { 298.2328, 2.8144, 16.9182, 128   }
mobList[zone][SMB+387].pos = {300.0039, 2.2430, -0.4152, 128    }
mobList[zone][SMB+388].pos = {301.2189, 2.5103, -25.6304, 110   }
mobList[zone][SMB+389].pos = {299.6303, 2.1966, -37.0409, 110   }
mobList[zone][SMB+607].pos = {300.0410, 2.2101, -43.0707, 110   }
-- Yagudo Stats
mobList[zone][SMB+122].pos = {351.5531, 2.0022, -60.4356, 196   }
mobList[zone][SMB+123].pos = {373.1893, 2.5996, -63.9211, 219   }
mobList[zone][SMB+124].pos = {379.2950, 2.1553, -81.4621, 2     }
mobList[zone][SMB+140].pos = {351.6066, -0.6636, -190.2410, 1   }
mobList[zone][SMB+141].pos = {353.3952, -0.6354, -200.8557, 236 }
mobList[zone][SMB+142].pos = {375.5005, -0.6350, -225.3975, 225 }
mobList[zone][SMB+403].pos = {412.0664, 2.6627, -221.4059, 189  }
mobList[zone][SMB+404].pos = {430.3526, 2.0774, -219.0766, 123  }
mobList[zone][SMB+405].pos = {493.5782, 2.5840, -225.4034, 154  }
mobList[zone][SMB+417].pos = {501.7607, 2.0000, -247.7523, 169  }
mobList[zone][SMB+418].pos = {523.8189, 2.1778, -259.4799, 144  }
mobList[zone][SMB+419].pos = {536.0930, 2.2397, -261.7803, 137  }
mobList[zone][SMB+608].pos = {553.5475, 1.4175, -261.2966, 126  }
-- Nightmare Crabs
mobList[zone][DMB+155].pos = {-30.7958, 19.4184, -308.5479, 130 }
mobList[zone][DMB+157].pos = {-31.1747, 15.8897, -278.6635, 168 }
mobList[zone][DMB+159].pos = {-13.1607, 15.8045, -251.7880, 164 }
mobList[zone][DMB+161].pos = {-0.6842, 16.8508, -217.9911, 228  }
mobList[zone][DMB+163].pos = {-43.9131, 16.5957, -214.0052, 243 }
mobList[zone][DMB+165].pos = {-68.2952, 15.9799, -253.3839, 79  }
mobList[zone][DMB+167].pos = {-89.9767, 16.1424, -234.8192, 48  }
mobList[zone][DMB+169].pos = {-120.5364, 16.0000, -238.3332, 103}
mobList[zone][DMB+171].pos = {-132.1700, 15.4754, -280.0170, 75 }
mobList[zone][DMB+173].pos = {-111.2321, 20.0000, -321.6591, 99 }
-- Nightmare Dhalmels
mobList[zone][DMB+174].pos = {147.0991, -13.8950, 83.2262, 91   }
mobList[zone][DMB+176].pos = {184.7485, -14.7913, 70.9593, 80   }
mobList[zone][DMB+178].pos = {173.1945, -15.7263, 105.4897, 231 }
mobList[zone][DMB+180].pos = {168.6498, -17.3226, 97.7622, 245  }
mobList[zone][DMB+182].pos = {164.7219, -20.3030, 142.5724, 240 }
mobList[zone][DMB+184].pos = {200.3606, -12.1309, 138.5568, 25  }
mobList[zone][DMB+186].pos = {202.5746, -13.5267, 144.1523, 46  }
mobList[zone][DMB+188].pos = {229.5914, -7.8646, 131.2038, 69   }
mobList[zone][DMB+191].pos = {218.4597, -11.5093, 170.9403, 98  }
mobList[zone][DMB+443].pos = {226.7076, -10.4975, 199.3315, 214 }
mobList[zone][DMB+446].pos = {257.5502, -5.7149, 202.1803, 183  }
-- Nightmare Uragnites
mobList[zone][DMB+193].pos = {387.0336, 15.3531, 76.0351, 147   }
mobList[zone][DMB+195].pos = {377.8488, 15.0754, 102.8690, 169  }
mobList[zone][DMB+197].pos = {359.6248, 16.2275, 128.5730, 170  }
mobList[zone][DMB+199].pos = {349.6410, 15.6979, 156.5760, 179  }
mobList[zone][DMB+201].pos = {367.1823, 15.1005, 173.3831, 196  }
mobList[zone][DMB+203].pos = {435.8933, 19.9970, 170.3763, 115  }
mobList[zone][DMB+206].pos = {435.6099, 20.0000, 138.3125, 119  }
mobList[zone][DMB+464].pos = {445.4790, 20.0000, 105.9790, 78   }
mobList[zone][DMB+467].pos = {445.8142, 20.0674, 68.9965, 176   }
-- Nightmare Scorpion
mobList[zone][DMB+209].pos = {471.2361, 0.2161, 6.8440, 62      }
mobList[zone][DMB+213].pos = {516.1291, 0.2165, -8.3529, 115    }
mobList[zone][DMB+217].pos = {519.8561, 1.0989, -51.0201, 102   }
mobList[zone][DMB+221].pos = {474.1000, 0.0938, -39.7732, 137   }
mobList[zone][DMB+225].pos = {471.0633, 0.3659, -15.7049, 56    }
--Nightmare Bunny
mobList[zone][DMB+227].pos = {-500.4587, -31.1175, 40.6901, 236 }
mobList[zone][DMB+229].pos = {-490.4445, -31.8260, 19.6098, 51  }
mobList[zone][DMB+231].pos = {-465.3930, -32.6130, 15.1436, 246 }
mobList[zone][DMB+233].pos = {-459.7678, -29.8715, 35.0834, 240 }
mobList[zone][DMB+235].pos = {-458.8814, -32.5718, 66.9976, 179 }
mobList[zone][DMB+237].pos = {-478.2877, -32.0000, 78.9771, 147 }
mobList[zone][DMB+239].pos = {-503.5589, -31.2163, 79.4331, 113 }
mobList[zone][DMB+241].pos = {-524.4575, -32.0880, 44.5391, 40  }
mobList[zone][DMB+496].pos = {-471.6640, -31.7843, -0.3831, 184 }
mobList[zone][DMB+498].pos = {-432.8346, -31.8996, 0.7240, 207  }
-- Nightmare Mandragora
mobList[zone][DMB+520].pos = {18.8103, -25.6353, 215.0178, 84   }
mobList[zone][DMB+523].pos = {-0.9103, -24.2774, 235.0815, 0    }
mobList[zone][DMB+526].pos = {-42.1285, -24.0754, 236.0463, 104 }
mobList[zone][DMB+529].pos = {-27.1142, -25.0121, 265.3078, 82  }
mobList[zone][DMB+532].pos = {-62.4796, -29.3045, 273.5851, 222 }
mobList[zone][DMB+535].pos = {-105.0640, -31.3110, 277.3794, 172}
mobList[zone][DMB+538].pos = {-131.7827, -33.5953, 268.1009, 136}
mobList[zone][DMB+541].pos = {57.2546, -23.1384, 198.0793, 78   }
-- Nightmare Crawler
mobList[zone][DMB+259].pos = {319.6010, 0.0000, 361.1112, 80    }
mobList[zone][DMB+261].pos = {323.2807, 0.0000, 357.6271, 91    }
mobList[zone][DMB+263].pos = {338.2596, 0.9850, 325.3451, 252   }
mobList[zone][DMB+265].pos = {317.7736, 0.0000, 319.5869, 247   }
mobList[zone][DMB+551].pos = {278.1880, -8.0000, 319.7731, 107  }
mobList[zone][DMB+554].pos = {371.0742, 0.6000, 228.1120, 74    }
mobList[zone][DMB+556].pos = {374.6455, 0.3026, 216.7436, 65    }
mobList[zone][DMB+558].pos = {400.8975, 0.0391, 235.1942, 177   }
mobList[zone][DMB+560].pos = {433.7487, 0.1114, 201.2834, 121   }
mobList[zone][DMB+563].pos = {397.8453, 0.1269, 190.9244, 55    }
--Nightmare Raven
mobList[zone][DMB+269].pos = {251.3917, -7.5990, -27.2447, 247  }
mobList[zone][DMB+271].pos = {247.8203, -7.7523, -51.8739, 76   }
mobList[zone][DMB+273].pos = {226.7718, -8.4287, -67.0033, 101  }
mobList[zone][DMB+275].pos = {212.1411, -13.9209, -45.4596, 175 }
mobList[zone][DMB+277].pos = {189.4418, -14.5562, -35.2972, 106 }
mobList[zone][DMB+279].pos = {192.6980, -12.6985, -60.3909, 50  }
mobList[zone][DMB+281].pos = {164.4827, -7.9380, -4.5929, 98    }
mobList[zone][DMB+283].pos = {194.2779, -7.9510, 10.4772, 243   }
mobList[zone][DMB+285].pos = {153.4070, -7.2771, -17.0971, 133  }
mobList[zone][DMB+287].pos = {133.5932, -7.9051, -41.3949, 50   }
mobList[zone][DMB+572].pos = {107.4268, -7.9171, -27.6511, 142  }
mobList[zone][DMB+574].pos = {104.9176, -7.3981, 7.3448, 79     }
mobList[zone][DMB+576].pos = {78.0692, -7.9856, 4.3110, 91      }
--Nightmare Eft
mobList[zone][DMB+289].pos = {-361.8208, -9.4083, -189.7500, 254}
mobList[zone][DMB+291].pos = {-388.3024, -7.6163, -196.1346, 60 }
mobList[zone][DMB+293].pos = {-411.7224, -7.6151, -198.3405, 131}
mobList[zone][DMB+295].pos = {-444.0339, -8.0858, -193.2675, 164}
mobList[zone][DMB+297].pos = {-481.2613, -16.0000, -241.4592, 71}
mobList[zone][DMB+299].pos = {-450.6776, -9.8428, -262.6942, 35 }
mobList[zone][DMB+301].pos = {-426.0003, -5.8710, -279.0026, 24 }
mobList[zone][DMB+303].pos = {-403.1646, 0.0000, -278.8900, 233 }
mobList[zone][DMB+305].pos = {-381.4844, -9.1690, -220.7178, 122}
mobList[zone][DMB+590].pos = {-355.3060, -8.1887, -200.9366, 245}
--Nightmare Cockatrice
mobList[zone][DMB+643].pos = {-313.1621, -39.8093, 257.1451, 19 }
mobList[zone][DMB+624].pos = {-352.1228, -39.8073, 236.7914, 139}
mobList[zone][DMB+628].pos = {-334.8820, -31.3485, 204.2709, 51 }
mobList[zone][DMB+632].pos = {-357.9044, -32.3993, 154.4069, 9  }
mobList[zone][DMB+636].pos = {-318.5551, -23.0392, 139.2384, 11 }

-- set statue eye color
mobList[zone][SMB+51 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+345].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+357].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+359].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+606].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+30 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+32 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+313].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+314].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+387].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+122].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+123].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+140].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+403].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+404].eyes = dynamis.eyes.BLUE

-- set time extensions
mobList[zone][DMB+0  ].timeExtension = 60

-- TODO: patrols?
-- mobList[zone][DMB+0  ].patrolPath = {   -361.5, -23.5, -25,    -40.6, 0,  -159,     285.7, 1, 15   } -- Triangle around zone

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements    = {       }
mobList[zone].waveDefeatRequirements[1] = {       } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+0 } -- Kill Megaboss

-- set which waves this monster will spawn on (can be multiple)
mobList[zone][DMB+0  ].waves = { 1, nil, nil}
mobList[zone][DMB+307].waves = { 1, nil, nil}
mobList[zone][DMB+309].waves = { 1, nil, nil}
mobList[zone][DMB+610].waves = { 1, nil, nil}
mobList[zone][DMB+611].waves = { 1, nil, nil}
mobList[zone][DMB+308].waves = { 1, nil, nil}
mobList[zone][DMB+612].waves = { 1, nil, nil}
mobList[zone][DMB+614].waves = { 1, nil, nil}
mobList[zone][DMB+615].waves = { 1, nil, nil}
mobList[zone][DMB+310].waves = { 1, nil, nil}
mobList[zone][DMB+616].waves = { 1, nil, nil}
mobList[zone][SMB+50 ].waves = { 1, nil, nil}
mobList[zone][SMB+51 ].waves = { 1, nil, nil}
mobList[zone][SMB+52 ].waves = { 1, nil, nil}
mobList[zone][SMB+67 ].waves = { 1, nil, nil}
mobList[zone][SMB+68 ].waves = { 1, nil, nil}
mobList[zone][SMB+69 ].waves = { 1, nil, nil}
mobList[zone][SMB+343].waves = { 1, nil, nil}
mobList[zone][SMB+344].waves = { 1, nil, nil}
mobList[zone][SMB+345].waves = { 1, nil, nil}
mobList[zone][SMB+357].waves = { 1, nil, nil}
mobList[zone][SMB+358].waves = { 1, nil, nil}
mobList[zone][SMB+359].waves = { 1, nil, nil}
mobList[zone][SMB+606].waves = { 1, nil, nil}
mobList[zone][SMB+0  ].waves = { 1, nil, nil}
mobList[zone][SMB+1  ].waves = { 1, nil, nil}
mobList[zone][SMB+2  ].waves = { 1, nil, nil}
mobList[zone][SMB+15 ].waves = { 1, nil, nil}
mobList[zone][SMB+16 ].waves = { 1, nil, nil}
mobList[zone][SMB+17 ].waves = { 1, nil, nil}
mobList[zone][SMB+30 ].waves = { 1, nil, nil}
mobList[zone][SMB+31 ].waves = { 1, nil, nil}
mobList[zone][SMB+32 ].waves = { 1, nil, nil}
mobList[zone][SMB+313].waves = { 1, nil, nil}
mobList[zone][SMB+314].waves = { 1, nil, nil}
mobList[zone][SMB+85 ].waves = { 1, nil, nil}
mobList[zone][SMB+86 ].waves = { 1, nil, nil}
mobList[zone][SMB+87 ].waves = { 1, nil, nil}
mobList[zone][SMB+103].waves = { 1, nil, nil}
mobList[zone][SMB+104].waves = { 1, nil, nil}
mobList[zone][SMB+105].waves = { 1, nil, nil}
mobList[zone][SMB+372].waves = { 1, nil, nil}
mobList[zone][SMB+373].waves = { 1, nil, nil}
mobList[zone][SMB+374].waves = { 1, nil, nil}
mobList[zone][SMB+387].waves = { 1, nil, nil}
mobList[zone][SMB+388].waves = { 1, nil, nil}
mobList[zone][SMB+389].waves = { 1, nil, nil}
mobList[zone][SMB+607].waves = { 1, nil, nil}
mobList[zone][SMB+122].waves = { 1, nil, nil}
mobList[zone][SMB+123].waves = { 1, nil, nil}
mobList[zone][SMB+124].waves = { 1, nil, nil}
mobList[zone][SMB+140].waves = { 1, nil, nil}
mobList[zone][SMB+141].waves = { 1, nil, nil}
mobList[zone][SMB+142].waves = { 1, nil, nil}
mobList[zone][SMB+403].waves = { 1, nil, nil}
mobList[zone][SMB+404].waves = { 1, nil, nil}
mobList[zone][SMB+405].waves = { 1, nil, nil}
mobList[zone][SMB+417].waves = { 1, nil, nil}
mobList[zone][SMB+418].waves = { 1, nil, nil}
mobList[zone][SMB+419].waves = { 1, nil, nil}
mobList[zone][SMB+608].waves = { 1, nil, nil}
mobList[zone][DMB+155].waves = { nil, 2, nil}
mobList[zone][DMB+157].waves = { nil, 2, nil}
mobList[zone][DMB+159].waves = { nil, 2, nil}
mobList[zone][DMB+161].waves = { nil, 2, nil}
mobList[zone][DMB+163].waves = { nil, 2, nil}
mobList[zone][DMB+165].waves = { nil, 2, nil}
mobList[zone][DMB+167].waves = { nil, 2, nil}
mobList[zone][DMB+169].waves = { nil, 2, nil}
mobList[zone][DMB+171].waves = { nil, 2, nil}
mobList[zone][DMB+173].waves = { nil, 2, nil}
mobList[zone][DMB+289].waves = { nil, 2, nil}
mobList[zone][DMB+291].waves = { nil, 2, nil}
mobList[zone][DMB+293].waves = { nil, 2, nil}
mobList[zone][DMB+295].waves = { nil, 2, nil}
mobList[zone][DMB+297].waves = { nil, 2, nil}
mobList[zone][DMB+299].waves = { nil, 2, nil}
mobList[zone][DMB+301].waves = { nil, 2, nil}
mobList[zone][DMB+303].waves = { nil, 2, nil}
mobList[zone][DMB+305].waves = { nil, 2, nil}
mobList[zone][DMB+590].waves = { nil, 2, nil}
mobList[zone][DMB+227].waves = { nil, 2, nil}
mobList[zone][DMB+229].waves = { nil, 2, nil}
mobList[zone][DMB+231].waves = { nil, 2, nil}
mobList[zone][DMB+233].waves = { nil, 2, nil}
mobList[zone][DMB+235].waves = { nil, 2, nil}
mobList[zone][DMB+237].waves = { nil, 2, nil}
mobList[zone][DMB+239].waves = { nil, 2, nil}
mobList[zone][DMB+241].waves = { nil, 2, nil}
mobList[zone][DMB+496].waves = { nil, 2, nil}
mobList[zone][DMB+498].waves = { nil, 2, nil}
mobList[zone][DMB+643].waves = { nil, 2, nil}
mobList[zone][DMB+624].waves = { nil, 2, nil}
mobList[zone][DMB+628].waves = { nil, 2, nil}
mobList[zone][DMB+632].waves = { nil, 2, nil}
mobList[zone][DMB+636].waves = { nil, 2, nil}
mobList[zone][DMB+520].waves = { nil, 2, nil}
mobList[zone][DMB+523].waves = { nil, 2, nil}
mobList[zone][DMB+526].waves = { nil, 2, nil}
mobList[zone][DMB+529].waves = { nil, 2, nil}
mobList[zone][DMB+532].waves = { nil, 2, nil}
mobList[zone][DMB+535].waves = { nil, 2, nil}
mobList[zone][DMB+538].waves = { nil, 2, nil}
mobList[zone][DMB+541].waves = { nil, 2, nil}
mobList[zone][DMB+269].waves = { nil, 2, nil}
mobList[zone][DMB+271].waves = { nil, 2, nil}
mobList[zone][DMB+273].waves = { nil, 2, nil}
mobList[zone][DMB+275].waves = { nil, 2, nil}
mobList[zone][DMB+277].waves = { nil, 2, nil}
mobList[zone][DMB+279].waves = { nil, 2, nil}
mobList[zone][DMB+281].waves = { nil, 2, nil}
mobList[zone][DMB+283].waves = { nil, 2, nil}
mobList[zone][DMB+285].waves = { nil, 2, nil}
mobList[zone][DMB+287].waves = { nil, 2, nil}
mobList[zone][DMB+572].waves = { nil, 2, nil}
mobList[zone][DMB+574].waves = { nil, 2, nil}
mobList[zone][DMB+576].waves = { nil, 2, nil}
mobList[zone][DMB+174].waves = { nil, 2, nil}
mobList[zone][DMB+176].waves = { nil, 2, nil}
mobList[zone][DMB+178].waves = { nil, 2, nil}
mobList[zone][DMB+180].waves = { nil, 2, nil}
mobList[zone][DMB+182].waves = { nil, 2, nil}
mobList[zone][DMB+184].waves = { nil, 2, nil}
mobList[zone][DMB+186].waves = { nil, 2, nil}
mobList[zone][DMB+188].waves = { nil, 2, nil}
mobList[zone][DMB+191].waves = { nil, 2, nil}
mobList[zone][DMB+443].waves = { nil, 2, nil}
mobList[zone][DMB+446].waves = { nil, 2, nil}
mobList[zone][DMB+259].waves = { nil, 2, nil}
mobList[zone][DMB+261].waves = { nil, 2, nil}
mobList[zone][DMB+263].waves = { nil, 2, nil}
mobList[zone][DMB+265].waves = { nil, 2, nil}
mobList[zone][DMB+551].waves = { nil, 2, nil}
mobList[zone][DMB+554].waves = { nil, 2, nil}
mobList[zone][DMB+556].waves = { nil, 2, nil}
mobList[zone][DMB+558].waves = { nil, 2, nil}
mobList[zone][DMB+560].waves = { nil, 2, nil}
mobList[zone][DMB+563].waves = { nil, 2, nil}
mobList[zone][DMB+193].waves = { nil, 2, nil}
mobList[zone][DMB+195].waves = { nil, 2, nil}
mobList[zone][DMB+197].waves = { nil, 2, nil}
mobList[zone][DMB+199].waves = { nil, 2, nil}
mobList[zone][DMB+201].waves = { nil, 2, nil}
mobList[zone][DMB+203].waves = { nil, 2, nil}
mobList[zone][DMB+206].waves = { nil, 2, nil}
mobList[zone][DMB+464].waves = { nil, 2, nil}
mobList[zone][DMB+467].waves = { nil, 2, nil}
mobList[zone][DMB+209].waves = { nil, 2, nil}
mobList[zone][DMB+213].waves = { nil, 2, nil}
mobList[zone][DMB+217].waves = { nil, 2, nil}
mobList[zone][DMB+221].waves = { nil, 2, nil}
mobList[zone][DMB+225].waves = { nil, 2, nil}

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- Statue Children
mobList[zone][SMB+50 ].specificChildren = { true, DMB+59, DMB+47, DMB+49, DMB+54     } -- Elvaansticker Bxafraff, RDM, THF, BRD (001-O)
mobList[zone][SMB+51 ].specificChildren = { true, DMB+74, DMB+52                     } -- SMN, BST                              (002-O)
mobList[zone][SMB+52 ].specificChildren = { true, DMB+58, DMB+65, DMB+68, DMB+55     } -- Flamecaller Zoeqdoq, WAR, WHM, NIN    (003-O)
mobList[zone][SMB+67 ].specificChildren = { true, DMB+73                             } -- SAM                                   (004-O)
mobList[zone][SMB+68 ].specificChildren = { true, DMB+45                             } -- BLM                                   (005-O)
mobList[zone][SMB+69 ].specificChildren = { true, DMB+76, DMB+56, DMB+348, DMB+66    } -- Hamfist Gukhbuk, DRG, BST, WAR        (006-O)
mobList[zone][SMB+343].specificChildren = { true, DMB+50                             } -- DRK                                   (007-O)
mobList[zone][SMB+344].specificChildren = { true, DMB+48                             } -- RDM                                   (008-O)
mobList[zone][SMB+345].specificChildren = { true, DMB+72                             } -- PLD                                   (009-O)
mobList[zone][SMB+357].specificChildren = { true, DMB+351, DMB+69                    } -- NIN, WHM                              (010-O)
mobList[zone][SMB+358].specificChildren = { true, DMB+77, DMB+67, DMB+360, DMB+70    } -- Lyncean Juvgneg, MNK, MNK, RNG        (011-O)
mobList[zone][SMB+359].specificChildren = { true, DMB+366, DMB+350                   } -- SMN, BRD                              (012-O)
mobList[zone][SMB+606].specificChildren = { true, DMB+346                            } -- THF                                   (013-O)
mobList[zone][SMB+0  ].specificChildren = { true, DMB+5                              } -- BRD                                   (014-G)
mobList[zone][SMB+1  ].specificChildren = { true, DMB+40, DMB+33, DMB+35, DMB+23     } -- Gosspix Blabberlips, THF, PLD, DRG    (015-G)
mobList[zone][SMB+2  ].specificChildren = { true, DMB+22, DMB+3                      } -- NIN, BST                              (016-G)
mobList[zone][SMB+15 ].specificChildren = { true, DMB+38, DMB+6                      } -- SMN, BRD                              (017-G)
mobList[zone][SMB+16 ].specificChildren = { true, DMB+9, DMB+36, DMB+21, DMB+17      } -- Woodnix Shrillwhistle, RNG, DRK, WHM  (018-G)
mobList[zone][SMB+17 ].specificChildren = { true, DMB+19                             } -- BLM                                   (019-G)
mobList[zone][SMB+30 ].specificChildren = { true, DMB+20                             } -- BLM                                   (020-G)
mobList[zone][SMB+31 ].specificChildren = { true, DMB+25, DMB+30, DMB+15, DMB+7      } -- Shamblix Rottenheart, MNK, WAR, SAM   (021-G)
mobList[zone][SMB+32 ].specificChildren = { true, DMB+322                            } -- SMN                                   (022-G)
mobList[zone][SMB+313].specificChildren = { true, DMB+335                            } -- NIN                                   (023-G)
mobList[zone][SMB+314].specificChildren = { true, DMB+314                            } -- RDM                                   (024-G)
mobList[zone][SMB+85 ].specificChildren = { true, DMB+94, DMB+82, DMB+87, DMB+375    } -- Qu'Pho Bloodspiller, WAR, BST, BST    (025-Q)
mobList[zone][SMB+86 ].specificChildren = { true, DMB+100, DMB+101                   } -- BLM, BLM                              (026-Q)
mobList[zone][SMB+87 ].specificChildren = { true, DMB+106, DMB+393                   } -- DRK, DRK                              (027-Q)
mobList[zone][SMB+103].specificChildren = { true, DMB+113, DMB+105, DMB+108, DMB+109 } -- Te'Zha Ironclad, PLD, NIN, NIN        (028-Q)
mobList[zone][SMB+104].specificChildren = { true, DMB+89, DMB+377                    } -- BRD, BRD                              (029-Q)
mobList[zone][SMB+105].specificChildren = { true, DMB+92, DMB+381                    } -- DRG, DRG                              (030-Q)
mobList[zone][SMB+372].specificChildren = { true, DMB+102, DMB+388                   } -- RDM, RDM                              (031-Q)
mobList[zone][SMB+373].specificChildren = { true, DMB+107, DMB+394                   } -- SAM, SAM                              (032-Q)
mobList[zone][SMB+374].specificChildren = { true, DMB+95, DMB+85, DMB+83, DMB+84     } -- Gi'Bhe Flesheater, WHM, MNK, MNK      (033-Q)
mobList[zone][SMB+387].specificChildren = { true, DMB+391, DMB+392                   } -- PLD, PLD                              (034-Q)
mobList[zone][SMB+388].specificChildren = { true, DMB+387, DMB+640                   } -- BLM, BLM                              (035-Q)
mobList[zone][SMB+389].specificChildren = { true, DMB+110, DMB+396                   } -- SMN, SMN                              (036-Q)
mobList[zone][SMB+607].specificChildren = { true, DMB+112, DMB+103, DMB+90, DMB+91   } -- Va'Rhu Bodysnatcher, THF, RNG, RNG    (037-Q)
mobList[zone][SMB+122].specificChildren = { true, DMB+118, DMB+128                   } -- MNK, SAM                              (038-Y)
mobList[zone][SMB+123].specificChildren = { true, DMB+119, DMB+410                   } -- MNK, SAM                              (039-Y)
mobList[zone][SMB+124].specificChildren = { true, DMB+132, DMB+137, DMB+144, DMB+143 } -- Koo rahi the Levinblade, WAR, RNG, DRK(040-Y)
mobList[zone][SMB+140].specificChildren = { true, DMB+125, DMB+129                   } -- BST, DRG                              (041-Y)
mobList[zone][SMB+141].specificChildren = { true, DMB+146, DMB+127                   } -- SMN, BRD                              (042-Y)
mobList[zone][SMB+142].specificChildren = { true, DMB+149, DMB+120, DMB+139, DMB+141 } -- Baa Dava the Bibliopage, WHM, BLM, RDM(043-Y)
mobList[zone][SMB+403].specificChildren = { true, DMB+426, DMB+406                   } -- SMN, BRD                              (044-Y)
mobList[zone][SMB+404].specificChildren = { true, DMB+407, DMB+412                   } -- BST, DRG                              (045-Y)
mobList[zone][SMB+405].specificChildren = { true, DMB+422, DMB+423                   } -- DRK, DRK                              (046-Y)
mobList[zone][SMB+417].specificChildren = { true, DMB+122, DMB+137                   } -- THF, WAR                              (047-Y)
mobList[zone][SMB+418].specificChildren = { true, DMB+148, DMB+145, DMB+425, DMB+641 } -- Doo Peku the Fleetfoot, NIN, NIN, NIN (048-Y)
mobList[zone][SMB+419].specificChildren = { true, DMB+123, DMB+424                   } -- THF, RNG                              (049-Y)
mobList[zone][SMB+608].specificChildren = { true, DMB+131, DMB+642, DMB+124, DMB+406 } -- Ree Nata the Melomanic, BRD, PLD, PLD (050-Y)
-- Nightmare Mobs
mobList[zone][DMB+155].specificChildren = { true, DMB+156                            } -- Nightmare Crab                        ( 062 )
mobList[zone][DMB+157].specificChildren = { true, DMB+158                            } -- Nightmare Crab                        ( 063 )
mobList[zone][DMB+159].specificChildren = { true, DMB+160                            } -- Nightmare Crab                        ( 064 )
mobList[zone][DMB+161].specificChildren = { true, DMB+162                            } -- Nightmare Crab                        ( 065 )
mobList[zone][DMB+163].specificChildren = { true, DMB+164                            } -- Nightmare Crab                        ( 066 )
mobList[zone][DMB+165].specificChildren = { true, DMB+166                            } -- Nightmare Crab                        ( 067 )
mobList[zone][DMB+167].specificChildren = { true, DMB+168                            } -- Nightmare Crab                        ( 068 )
mobList[zone][DMB+169].specificChildren = { true, DMB+170                            } -- Nightmare Crab                        ( 069 )
mobList[zone][DMB+171].specificChildren = { true, DMB+172                            } -- Nightmare Crab                        ( 070 )
mobList[zone][DMB+173].specificChildren = { true, DMB+174                            } -- Nightmare Crab                        ( 071 )
mobList[zone][DMB+289].specificChildren = { true, DMB+290                            } -- Nightmare Eft                         ( 072 )
mobList[zone][DMB+291].specificChildren = { true, DMB+292                            } -- Nightmare Eft                         ( 073 )
mobList[zone][DMB+293].specificChildren = { true, DMB+294                            } -- Nightmare Eft                         ( 074 )
mobList[zone][DMB+295].specificChildren = { true, DMB+296                            } -- Nightmare Eft                         ( 075 )
mobList[zone][DMB+297].specificChildren = { true, DMB+298                            } -- Nightmare Eft                         ( 076 )
mobList[zone][DMB+299].specificChildren = { true, DMB+300                            } -- Nightmare Eft                         ( 077 )
mobList[zone][DMB+301].specificChildren = { true, DMB+302                            } -- Nightmare Eft                         ( 078 )
mobList[zone][DMB+303].specificChildren = { true, DMB+304                            } -- Nightmare Eft                         ( 079 )
mobList[zone][DMB+305].specificChildren = { true, DMB+306                            } -- Nightmare Eft                         ( 080 )
mobList[zone][DMB+590].specificChildren = { true, DMB+591                            } -- Nightmare Eft                         ( 081 )
mobList[zone][DMB+227].specificChildren = { true, DMB+228                            } -- Nightmare Bunny                       ( 082 )
mobList[zone][DMB+229].specificChildren = { true, DMB+230                            } -- Nightmare Bunny                       ( 083 )
mobList[zone][DMB+231].specificChildren = { true, DMB+232                            } -- Nightmare Bunny                       ( 084 )
mobList[zone][DMB+233].specificChildren = { true, DMB+234                            } -- Nightmare Bunny                       ( 085 )
mobList[zone][DMB+235].specificChildren = { true, DMB+236                            } -- Nightmare Bunny                       ( 086 )
mobList[zone][DMB+237].specificChildren = { true, DMB+238                            } -- Nightmare Bunny                       ( 087 )
mobList[zone][DMB+239].specificChildren = { true, DMB+240                            } -- Nightmare Bunny                       ( 088 )
mobList[zone][DMB+241].specificChildren = { true, DMB+242                            } -- Nightmare Bunny                       ( 089 )
mobList[zone][DMB+496].specificChildren = { true, DMB+497                            } -- Nightmare Bunny                       ( 090 )
mobList[zone][DMB+498].specificChildren = { true, DMB+499                            } -- Nightmare Bunny                       ( 091 )
mobList[zone][DMB+643].specificChildren = { true, DMB+621, DMB+622, DMB+623          } -- Nightmare Cockatrice                  ( 092 )
mobList[zone][DMB+624].specificChildren = { true, DMB+625, DMB+626, DMB+627          } -- Nightmare Cockatrice                  ( 093 )
mobList[zone][DMB+628].specificChildren = { true, DMB+629, DMB+630, DMB+631          } -- Nightmare Cockatrice                  ( 094 )
mobList[zone][DMB+632].specificChildren = { true, DMB+633, DMB+634, DMB+635          } -- Nightmare Cockatrice                  ( 095 )
mobList[zone][DMB+636].specificChildren = { true, DMB+637, DMB+638, DMB+639          } -- Nightmare Cockatrice                  ( 096 )
mobList[zone][DMB+520].specificChildren = { true, DMB+521, DMB+522                   } -- Nightmare Mandragora                  ( 097 )
mobList[zone][DMB+523].specificChildren = { true, DMB+524, DMB+525                   } -- Nightmare Mandragora                  ( 098 )
mobList[zone][DMB+526].specificChildren = { true, DMB+527, DMB+528                   } -- Nightmare Mandragora                  ( 099 )
mobList[zone][DMB+529].specificChildren = { true, DMB+530, DMB+531                   } -- Nightmare Mandragora                  ( 100 )
mobList[zone][DMB+532].specificChildren = { true, DMB+533, DMB+534                   } -- Nightmare Mandragora                  ( 101 )
mobList[zone][DMB+535].specificChildren = { true, DMB+536, DMB+537                   } -- Nightmare Mandragora                  ( 102 )
mobList[zone][DMB+538].specificChildren = { true, DMB+539, DMB+540                   } -- Nightmare Mandragora                  ( 103 )
mobList[zone][DMB+541].specificChildren = { true, DMB+542, DMB+543                   } -- Nightmare Mandragora                  ( 104 )
mobList[zone][DMB+269].specificChildren = { true, DMB+270                            } -- Nightmare Raven                       ( 105 )
mobList[zone][DMB+271].specificChildren = { true, DMB+272                            } -- Nightmare Raven                       ( 106 )
mobList[zone][DMB+273].specificChildren = { true, DMB+274                            } -- Nightmare Raven                       ( 107 )
mobList[zone][DMB+275].specificChildren = { true, DMB+276                            } -- Nightmare Raven                       ( 108 )
mobList[zone][DMB+277].specificChildren = { true, DMB+278                            } -- Nightmare Raven                       ( 109 )
mobList[zone][DMB+279].specificChildren = { true, DMB+280                            } -- Nightmare Raven                       ( 110 )
mobList[zone][DMB+281].specificChildren = { true, DMB+282                            } -- Nightmare Raven                       ( 111 )
mobList[zone][DMB+283].specificChildren = { true, DMB+284                            } -- Nightmare Raven                       ( 112 )
mobList[zone][DMB+285].specificChildren = { true, DMB+286                            } -- Nightmare Raven                       ( 113 )
mobList[zone][DMB+287].specificChildren = { true, DMB+288                            } -- Nightmare Raven                       ( 114 )
mobList[zone][DMB+572].specificChildren = { true, DMB+573                            } -- Nightmare Raven                       ( 115 )
mobList[zone][DMB+574].specificChildren = { true, DMB+575                            } -- Nightmare Raven                       ( 116 )
mobList[zone][DMB+576].specificChildren = { true, DMB+577                            } -- Nightmare Raven                       ( 117 )
mobList[zone][DMB+174].specificChildren = { true, DMB+175                            } -- Nightmare Dhalmel                     ( 118 )
mobList[zone][DMB+176].specificChildren = { true, DMB+177                            } -- Nightmare Dhalmel                     ( 119 )
mobList[zone][DMB+178].specificChildren = { true, DMB+179                            } -- Nightmare Dhalmel                     ( 120 )
mobList[zone][DMB+180].specificChildren = { true, DMB+181                            } -- Nightmare Dhalmel                     ( 121 )
mobList[zone][DMB+182].specificChildren = { true, DMB+183                            } -- Nightmare Dhalmel                     ( 122 )
mobList[zone][DMB+184].specificChildren = { true, DMB+185                            } -- Nightmare Dhalmel                     ( 123 )
mobList[zone][DMB+186].specificChildren = { true, DMB+187                            } -- Nightmare Dhalmel                     ( 124 )
mobList[zone][DMB+188].specificChildren = { true, DMB+189, DMB+190                   } -- Nightmare Dhalmel                     ( 125 )
mobList[zone][DMB+191].specificChildren = { true, DMB+192, DMB+193                   } -- Nightmare Dhalmel                     ( 126 )
mobList[zone][DMB+443].specificChildren = { true, DMB+444, DMB+445                   } -- Nightmare Dhalmel                     ( 127 )
mobList[zone][DMB+446].specificChildren = { true, DMB+447, DMB+448                   } -- Nightmare Dhalmel                     ( 128 )
mobList[zone][DMB+259].specificChildren = { true, DMB+260                            } -- Nightmare Crawler                     ( 129 )
mobList[zone][DMB+261].specificChildren = { true, DMB+262                            } -- Nightmare Crawler                     ( 130 )
mobList[zone][DMB+263].specificChildren = { true, DMB+264                            } -- Nightmare Crawler                     ( 131 )
mobList[zone][DMB+265].specificChildren = { true, DMB+266, DMB+267                   } -- Nightmare Crawler                     ( 132 )
mobList[zone][DMB+551].specificChildren = { true, DMB+552, DMB+553                   } -- Nightmare Crawler                     ( 133 )
mobList[zone][DMB+554].specificChildren = { true, DMB+555                            } -- Nightmare Crawler                     ( 134 )
mobList[zone][DMB+556].specificChildren = { true, DMB+557                            } -- Nightmare Crawler                     ( 135 )
mobList[zone][DMB+558].specificChildren = { true, DMB+559                            } -- Nightmare Crawler                     ( 136 )
mobList[zone][DMB+560].specificChildren = { true, DMB+561, DMB+562                   } -- Nightmare Crawler                     ( 137 )
mobList[zone][DMB+563].specificChildren = { true, DMB+564, DMB+565                   } -- Nightmare Crawler                     ( 138 )
mobList[zone][DMB+193].specificChildren = { true, DMB+194                            } -- Nightmare Uragnite                    ( 139 )
mobList[zone][DMB+195].specificChildren = { true, DMB+196                            } -- Nightmare Uragnite                    ( 140 )
mobList[zone][DMB+197].specificChildren = { true, DMB+198                            } -- Nightmare Uragnite                    ( 141 )
mobList[zone][DMB+199].specificChildren = { true, DMB+200                            } -- Nightmare Uragnite                    ( 142 )
mobList[zone][DMB+201].specificChildren = { true, DMB+202                            } -- Nightmare Uragnite                    ( 143 )
mobList[zone][DMB+203].specificChildren = { true, DMB+204, DMB+205                   } -- Nightmare Uragnite                    ( 144 )
mobList[zone][DMB+206].specificChildren = { true, DMB+207, DMB+208                   } -- Nightmare Uragnite                    ( 145 )
mobList[zone][DMB+464].specificChildren = { true, DMB+465, DMB+466                   } -- Nightmare Uragnite                    ( 146 )
mobList[zone][DMB+467].specificChildren = { true, DMB+468, DMB+469                   } -- Nightmare Uragnite                    ( 147 )
mobList[zone][DMB+209].specificChildren = { true, DMB+210, DMB+211, DMB+212          } -- Nightmare Scorption                   ( 148 )
mobList[zone][DMB+213].specificChildren = { true, DMB+214, DMB+215, DMB+216          } -- Nightmare Scorption                   ( 149 )
mobList[zone][DMB+217].specificChildren = { true, DMB+218, DMB+219, DMB+220          } -- Nightmare Scorption                   ( 150 )
mobList[zone][DMB+221].specificChildren = { true, DMB+222, DMB+223, DMB+224          } -- Nightmare Scorption                   ( 151 )
mobList[zone][DMB+225].specificChildren = { true, DMB+226, DMB+477, DMB+478, DMB+479 } -- Nightmare Scorption                   ( 152 )

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