-----------------------------------
--
-- Dynamis-Valkurm
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_VALKURM
local DMB = 16936961 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 16937208 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    -- Wave 1
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val1.htm
    -- Nightmare Mobs
    -- Manticore Sands
    [DMB+51 ] = { id =  DMB+51 }, -- Nightmare Fly ( 021 )
    [DMB+54 ] = { id =  DMB+54 }, -- Nightmare Fly ( 021 )
    [DMB+55 ] = { id =  DMB+55 }, -- Nightmare Fly ( 021 )
    -- Sheep Sands
    [DMB+52 ] = { id =  DMB+52 }, -- Nightmare Fly ( 022 )
    [DMB+56 ] = { id =  DMB+56 }, -- Nightmare Fly ( 022 )
    [DMB+57 ] = { id =  DMB+57 }, -- Nightmare Fly ( 022 )
    -- Hippogryph Sands
    [DMB+53 ] = { id =  DMB+53 }, -- Nightmare Fly ( 023 )
    [DMB+58 ] = { id =  DMB+58 }, -- Nightmare Fly ( 023 )
    [DMB+59 ] = { id =  DMB+59 }, -- Nightmare Fly ( 023 )

    -- NM based on https://enedin.be/dyna/html/zone/frame_val1.htm
    -- Funguar NM Area
    [DMB+139] = { id =  DMB+139}, -- Fairy Ring ( 005 )
    -- Flytrap NM Area
    [DMB+615] = { id =  DMB+615}, -- Dragontrap ( 010 )
    [DMB+616] = { id =  DMB+616}, -- Dragontrap ( 010 )
    [DMB+617] = { id =  DMB+617}, -- Dragontrap ( 010 )
    -- Treant NM Area
    [DMB+90 ] = { id =  DMB+90 }, -- Stcemqestcint ( 010 )
    -- Gobbue NM Area
    [DMB+116] = { id =  DMB+116}, -- Nant'ina ( 020 )
    -- Boss Area
    [DMB+0  ] = { id =  DMB+0  }, -- Cirrate Christelle ( 024 )
    -- Spawns
    [SMB+79 ] = { id =  SMB+79 }, -- Goblin_Replica (025-G)
    [SMB+54 ] = { id =  SMB+54 }, -- Manifest_Icon (026-Y)
    [SMB+29 ] = { id =  SMB+29 }, -- Adamanking_Effigy (027-Q)
    [SMB+4  ] = { id =  SMB+4  }, -- Sergeant_Tombstone (028-O)
    [DMB+655] = { id =  DMB+655}, -- Nightmare_Manticore ( 029 )
    [DMB+665] = { id =  DMB+665}, -- Nightmare_Manticore ( 029 )
    [DMB+666] = { id =  DMB+666}, -- Nightmare_Manticore ( 029 )
    [DMB+433] = { id =  DMB+433}, -- Nightmare_Hippogryph ( 030 )
    [DMB+667] = { id =  DMB+667}, -- Nightmare_Hippogryph ( 030 )
    [DMB+668] = { id =  DMB+668}, -- Nightmare_Hippogryph ( 030 )
    [DMB+356] = { id =  DMB+356}, -- Nightmare_Sabotender ( 031 )
    [DMB+668] = { id =  DMB+668}, -- Nightmare_Sabotender ( 031 )
    [DMB+669] = { id =  DMB+669}, -- Nightmare_Sabotender ( 031 )
    [DMB+664] = { id =  DMB+664}, -- Nightmare_Sheep ( 032 )
    [DMB+670] = { id =  DMB+670}, -- Nightmare_Sheep ( 032 )
    [DMB+671] = { id =  DMB+671}, -- Nightmare_Sheep ( 032 )

    -- Initial Statues based on https://enedin.be/dyna/html/zone/frame_val1.htm
    -- Funguar NM Area
    [SMB+50 ] = { id =  SMB+50 }, -- Manifest_Icon (001-Y)
    [SMB+51 ] = { id =  SMB+51 }, -- Manifest_Icon (002-Y)
    [SMB+52 ] = { id =  SMB+52 }, -- Manifest_Icon (003-Y)
    [SMB+53 ] = { id =  SMB+53 }, -- Manifest_Icon (004-Y)
    -- Flytrap NM Area
    [SMB+75 ] = { id =  SMB+75 }, -- Goblin_Replica (006-G)
    [SMB+76 ] = { id =  SMB+76 }, -- Goblin_Replica (007-G)
    [SMB+77 ] = { id =  SMB+77 }, -- Goblin_Replica (008-G)
    [SMB+78 ] = { id =  SMB+78 }, -- Goblin_Replica (009-G)
    -- Treant NM Area
    [SMB+0 ] = { id =  SMB+0 }, -- Sergeant_Tombstone (011-O)
    [SMB+1 ] = { id =  SMB+1 }, -- Sergeant_Tombstone (012-O)
    [SMB+2 ] = { id =  SMB+2 }, -- Sergeant_Tombstone (013-O)
    [SMB+3 ] = { id =  SMB+3 }, -- Sergeant_Tombstone (014-O)
    -- Goobbue NM Area
    [SMB+25 ] = { id =  SMB+25 }, -- Adamanking_Effigy (016-Q)
    [SMB+26 ] = { id =  SMB+26 }, -- Adamanking_Effigy (017-Q)
    [SMB+27 ] = { id =  SMB+27 }, -- Adamanking_Effigy (018-Q)
    [SMB+28 ] = { id =  SMB+28 }, -- Adamanking_Effigy (019-Q)

    -- Wave 2 Manticore Sands and Goobubue NM Area
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
    -- Nightmare Mobs
    [DMB+26 ] = { id =  DMB+26 }, -- Nightmare_Manticore ( 110 )
    [DMB+27 ] = { id =  DMB+27 }, -- Nightmare_Manticore ( 110 )
    [DMB+28 ] = { id =  DMB+28 }, -- Nightmare_Manticore ( 110 )
    [DMB+29 ] = { id =  DMB+29 }, -- Nightmare_Manticore ( 111 )
    [DMB+30 ] = { id =  DMB+30 }, -- Nightmare_Manticore ( 111 )
    [DMB+31 ] = { id =  DMB+31 }, -- Nightmare_Manticore ( 111 )
    [DMB+32 ] = { id =  DMB+32 }, -- Nightmare_Manticore ( 112 )
    [DMB+33 ] = { id =  DMB+33 }, -- Nightmare_Manticore ( 112 )
    [DMB+34 ] = { id =  DMB+34 }, -- Nightmare_Manticore ( 112 )
    [DMB+35 ] = { id =  DMB+35 }, -- Nightmare_Manticore ( 113 )
    [DMB+36 ] = { id =  DMB+36 }, -- Nightmare_Manticore ( 113 )
    [DMB+37 ] = { id =  DMB+37 }, -- Nightmare_Manticore ( 113 )
    [DMB+38 ] = { id =  DMB+38 }, -- Nightmare_Manticore ( 114 )
    [DMB+39 ] = { id =  DMB+39 }, -- Nightmare_Manticore ( 114 )
    [DMB+40 ] = { id =  DMB+40 }, -- Nightmare_Manticore ( 114 )
    [DMB+41 ] = { id =  DMB+41 }, -- Nightmare_Manticore ( 115 )
    [DMB+42 ] = { id =  DMB+42 }, -- Nightmare_Manticore ( 115 )
    [DMB+43 ] = { id =  DMB+43 }, -- Nightmare_Manticore ( 115 )
    [DMB+44 ] = { id =  DMB+44 }, -- Nightmare_Manticore ( 116 )
    [DMB+45 ] = { id =  DMB+45 }, -- Nightmare_Manticore ( 116 )
    [DMB+46 ] = { id =  DMB+46 }, -- Nightmare_Manticore ( 116 )
    [DMB+47 ] = { id =  DMB+47 }, -- Nightmare_Manticore ( 117 )
    [DMB+48 ] = { id =  DMB+48 }, -- Nightmare_Manticore ( 117 )
    [DMB+49 ] = { id =  DMB+49 }, -- Nightmare_Manticore ( 117 )
    [DMB+50 ] = { id =  DMB+50 }, -- Nightmare_Manticore ( 118 )
    [DMB+394] = { id =  DMB+394}, -- Nightmare_Manticore ( 118 )
    [DMB+395] = { id =  DMB+395}, -- Nightmare_Manticore ( 118 )
    [DMB+396] = { id =  DMB+396}, -- Nightmare_Manticore ( 119 )
    [DMB+397] = { id =  DMB+397}, -- Nightmare_Manticore ( 119 )
    [DMB+398] = { id =  DMB+398}, -- Nightmare_Manticore ( 119 )
    [DMB+399] = { id =  DMB+399}, -- Nightmare_Manticore ( 119 )
    [DMB+400] = { id =  DMB+400}, -- Nightmare_Manticore ( 120 )
    [DMB+401] = { id =  DMB+401}, -- Nightmare_Manticore ( 120 )
    [DMB+402] = { id =  DMB+402}, -- Nightmare_Manticore ( 120 )
    [DMB+403] = { id =  DMB+403}, -- Nightmare_Manticore ( 120 )
    [DMB+404] = { id =  DMB+404}, -- Nightmare_Manticore ( 121 )
    [DMB+405] = { id =  DMB+405}, -- Nightmare_Manticore ( 121 )
    [DMB+406] = { id =  DMB+406}, -- Nightmare_Manticore ( 121 )
    [DMB+407] = { id =  DMB+407}, -- Nightmare_Manticore ( 121 )
    [DMB+408] = { id =  DMB+408}, -- Nightmare_Manticore ( 122 )
    [DMB+409] = { id =  DMB+409}, -- Nightmare_Manticore ( 122 )
    [DMB+410] = { id =  DMB+410}, -- Nightmare_Manticore ( 122 )
    [DMB+411] = { id =  DMB+411}, -- Nightmare_Manticore ( 123 )
    [DMB+412] = { id =  DMB+412}, -- Nightmare_Manticore ( 123 )
    [DMB+413] = { id =  DMB+413}, -- Nightmare_Manticore ( 123 )
    [DMB+643] = { id =  DMB+643}, -- Nightmare_Manticore ( 124 )
    [DMB+644] = { id =  DMB+644}, -- Nightmare_Manticore ( 124 )
    [DMB+645] = { id =  DMB+645}, -- Nightmare_Manticore ( 124 )
    -- Goobbue NM Area
    [DMB+646] = { id =  DMB+646}, -- Nightmare_Manticore ( 125 )
    [DMB+647] = { id =  DMB+647}, -- Nightmare_Manticore ( 125 )
    [DMB+648] = { id =  DMB+648}, -- Nightmare_Manticore ( 125 )
    [DMB+649] = { id =  DMB+649}, -- Nightmare_Manticore ( 126 )
    [DMB+650] = { id =  DMB+650}, -- Nightmare_Manticore ( 126 )
    [DMB+651] = { id =  DMB+651}, -- Nightmare_Manticore ( 126 )
    [DMB+652] = { id =  DMB+652}, -- Nightmare_Manticore ( 127 )
    [DMB+653] = { id =  DMB+653}, -- Nightmare_Manticore ( 127 )
    [DMB+654] = { id =  DMB+654}, -- Nightmare_Manticore ( 127 )
    [DMB+357] = { id =  DMB+357}, -- Nightmare_Sabotender ( 128 )
    [DMB+358] = { id =  DMB+358}, -- Nightmare_Sabotender ( 128 )
    [DMB+359] = { id =  DMB+359}, -- Nightmare_Sabotender ( 128 )
    [DMB+360] = { id =  DMB+360}, -- Nightmare_Sabotender ( 129 )
    [DMB+361] = { id =  DMB+361}, -- Nightmare_Sabotender ( 129 )
    [DMB+362] = { id =  DMB+362}, -- Nightmare_Sabotender ( 129 )

    -- Wave 3 Sheep Sands and Treant NM Area
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
    -- Nightmare Mobs
    [DMB+204] = { id =  DMB+135}, -- Nightmare_Sheep ( 087 )
    [DMB+205] = { id =  DMB+135}, -- Nightmare_Sheep ( 087 )
    [DMB+206] = { id =  DMB+135}, -- Nightmare_Sheep ( 087 )
    [DMB+207] = { id =  DMB+135}, -- Nightmare_Sheep ( 088 )
    [DMB+208] = { id =  DMB+135}, -- Nightmare_Sheep ( 088 )
    [DMB+209] = { id =  DMB+135}, -- Nightmare_Sheep ( 088 )
    [DMB+210] = { id =  DMB+135}, -- Nightmare_Sheep ( 089 )
    [DMB+211] = { id =  DMB+135}, -- Nightmare_Sheep ( 089 )
    [DMB+212] = { id =  DMB+135}, -- Nightmare_Sheep ( 089 )
    [DMB+213] = { id =  DMB+135}, -- Nightmare_Sheep ( 090 )
    [DMB+214] = { id =  DMB+135}, -- Nightmare_Sheep ( 090 )
    [DMB+215] = { id =  DMB+135}, -- Nightmare_Sheep ( 090 )
    [DMB+216] = { id =  DMB+135}, -- Nightmare_Sheep ( 091 )
    [DMB+217] = { id =  DMB+135}, -- Nightmare_Sheep ( 091 )
    [DMB+218] = { id =  DMB+135}, -- Nightmare_Sheep ( 091 )
    [DMB+219] = { id =  DMB+135}, -- Nightmare_Sheep ( 092 )
    [DMB+220] = { id =  DMB+135}, -- Nightmare_Sheep ( 092 )
    [DMB+221] = { id =  DMB+135}, -- Nightmare_Sheep ( 092 )
    [DMB+222] = { id =  DMB+135}, -- Nightmare_Sheep ( 093 )
    [DMB+223] = { id =  DMB+135}, -- Nightmare_Sheep ( 093 )
    [DMB+224] = { id =  DMB+135}, -- Nightmare_Sheep ( 094 )
    [DMB+225] = { id =  DMB+135}, -- Nightmare_Sheep ( 094 )
    [DMB+226] = { id =  DMB+135}, -- Nightmare_Sheep ( 095 )
    [DMB+227] = { id =  DMB+135}, -- Nightmare_Sheep ( 095 )
    [DMB+228] = { id =  DMB+135}, -- Nightmare_Sheep ( 096 )
    [DMB+472] = { id =  DMB+135}, -- Nightmare_Sheep ( 096 )
    [DMB+473] = { id =  DMB+135}, -- Nightmare_Sheep ( 097 )
    [DMB+474] = { id =  DMB+135}, -- Nightmare_Sheep ( 097 )
    [DMB+475] = { id =  DMB+135}, -- Nightmare_Sheep ( 098 )
    [DMB+476] = { id =  DMB+135}, -- Nightmare_Sheep ( 098 )
    [DMB+477] = { id =  DMB+135}, -- Nightmare_Sheep ( 099 )
    [DMB+478] = { id =  DMB+135}, -- Nightmare_Sheep ( 099 )
    [DMB+479] = { id =  DMB+135}, -- Nightmare_Sheep ( 100 )
    [DMB+480] = { id =  DMB+135}, -- Nightmare_Sheep ( 100 )
    [DMB+481] = { id =  DMB+135}, -- Nightmare_Sheep ( 101 )
    [DMB+482] = { id =  DMB+135}, -- Nightmare_Sheep ( 101 )
    [DMB+483] = { id =  DMB+135}, -- Nightmare_Sheep ( 102 )
    [DMB+484] = { id =  DMB+135}, -- Nightmare_Sheep ( 102 )
    [DMB+485] = { id =  DMB+135}, -- Nightmare_Sheep ( 103 )
    [DMB+486] = { id =  DMB+135}, -- Nightmare_Sheep ( 103 )
    [DMB+487] = { id =  DMB+135}, -- Nightmare_Sheep ( 104 )
    [DMB+488] = { id =  DMB+135}, -- Nightmare_Sheep ( 104 )
    [DMB+489] = { id =  DMB+135}, -- Nightmare_Sheep ( 105 )
    [DMB+490] = { id =  DMB+135}, -- Nightmare_Sheep ( 105 )
    [DMB+491] = { id =  DMB+135}, -- Nightmare_Sheep ( 106 )
    [DMB+492] = { id =  DMB+135}, -- Nightmare_Sheep ( 106 )
    [DMB+493] = { id =  DMB+135}, -- Nightmare_Sheep ( 107 )
    [DMB+656] = { id =  DMB+135}, -- Nightmare_Sheep ( 107 )
    [DMB+657] = { id =  DMB+135}, -- Nightmare_Sheep ( 107 )
    [DMB+658] = { id =  DMB+135}, -- Nightmare_Sheep ( 108 )
    [DMB+659] = { id =  DMB+135}, -- Nightmare_Sheep ( 108 )
    [DMB+660] = { id =  DMB+135}, -- Nightmare_Sheep ( 108 )
    [DMB+661] = { id =  DMB+135}, -- Nightmare_Sheep ( 109 )
    [DMB+662] = { id =  DMB+135}, -- Nightmare_Sheep ( 109 )
    [DMB+663] = { id =  DMB+135}, -- Nightmare_Sheep ( 109 )

    -- Wave 4 Hippogryph Sands and Flytrap NM Area
    -- Nightmare Mobs + NMs Based on https://enedin.be/dyna/html/zone/frame_val2.htm
    -- Nightmare Mobs
    -- Hippogryph Sands
    [DMB+1  ] = { id =  DMB+1  }, -- Nightmare_Hippogryph ( 059 )
    [DMB+2  ] = { id =  DMB+2  }, -- Nightmare_Hippogryph ( 059 )
    [DMB+3  ] = { id =  DMB+3  }, -- Nightmare_Hippogryph ( 059 )
    [DMB+4  ] = { id =  DMB+4  }, -- Nightmare_Hippogryph ( 060 )
    [DMB+5  ] = { id =  DMB+5  }, -- Nightmare_Hippogryph ( 060 )
    [DMB+6  ] = { id =  DMB+6  }, -- Nightmare_Hippogryph ( 060 )
    [DMB+7  ] = { id =  DMB+7  }, -- Nightmare_Hippogryph ( 061 )
    [DMB+8  ] = { id =  DMB+8  }, -- Nightmare_Hippogryph ( 061 )
    [DMB+9  ] = { id =  DMB+9  }, -- Nightmare_Hippogryph ( 061 )
    [DMB+10 ] = { id =  DMB+10 }, -- Nightmare_Hippogryph ( 062 )
    [DMB+11 ] = { id =  DMB+11 }, -- Nightmare_Hippogryph ( 062 )
    [DMB+12 ] = { id =  DMB+12 }, -- Nightmare_Hippogryph ( 062 )
    [DMB+13 ] = { id =  DMB+13 }, -- Nightmare_Hippogryph ( 063 )
    [DMB+14 ] = { id =  DMB+14 }, -- Nightmare_Hippogryph ( 063 )
    [DMB+15 ] = { id =  DMB+15 }, -- Nightmare_Hippogryph ( 063 )
    [DMB+16 ] = { id =  DMB+16 }, -- Nightmare_Hippogryph ( 064 )
    [DMB+17 ] = { id =  DMB+17 }, -- Nightmare_Hippogryph ( 064 )
    [DMB+18 ] = { id =  DMB+18 }, -- Nightmare_Hippogryph ( 064 )
    [DMB+19 ] = { id =  DMB+19 }, -- Nightmare_Hippogryph ( 065 )
    [DMB+20 ] = { id =  DMB+20 }, -- Nightmare_Hippogryph ( 065 )
    [DMB+21 ] = { id =  DMB+21 }, -- Nightmare_Hippogryph ( 065 )
    [DMB+22 ] = { id =  DMB+22 }, -- Nightmare_Hippogryph ( 066 )
    [DMB+23 ] = { id =  DMB+23 }, -- Nightmare_Hippogryph ( 066 )
    [DMB+24 ] = { id =  DMB+24 }, -- Nightmare_Hippogryph ( 066 )
    [DMB+25 ] = { id =  DMB+25 }, -- Nightmare_Hippogryph ( 067 )
    [DMB+413] = { id =  DMB+413}, -- Nightmare_Hippogryph ( 067 )
    [DMB+414] = { id =  DMB+414}, -- Nightmare_Hippogryph ( 067 )
    [DMB+415] = { id =  DMB+415}, -- Nightmare_Hippogryph ( 068 )
    [DMB+416] = { id =  DMB+416}, -- Nightmare_Hippogryph ( 068 )
    [DMB+417] = { id =  DMB+417}, -- Nightmare_Hippogryph ( 068 )
    [DMB+418] = { id =  DMB+418}, -- Nightmare_Hippogryph ( 069 )
    [DMB+419] = { id =  DMB+419}, -- Nightmare_Hippogryph ( 069 )
    [DMB+420] = { id =  DMB+420}, -- Nightmare_Hippogryph ( 069 )
    [DMB+421] = { id =  DMB+421}, -- Nightmare_Hippogryph ( 070 )
    [DMB+422] = { id =  DMB+422}, -- Nightmare_Hippogryph ( 070 )
    [DMB+423] = { id =  DMB+423}, -- Nightmare_Hippogryph ( 070 )
    [DMB+424] = { id =  DMB+424}, -- Nightmare_Hippogryph ( 071 )
    [DMB+425] = { id =  DMB+425}, -- Nightmare_Hippogryph ( 071 )
    [DMB+426] = { id =  DMB+426}, -- Nightmare_Hippogryph ( 071 )
    [DMB+427] = { id =  DMB+427}, -- Nightmare_Hippogryph ( 072 )
    [DMB+428] = { id =  DMB+428}, -- Nightmare_Hippogryph ( 072 )
    [DMB+429] = { id =  DMB+429}, -- Nightmare_Hippogryph ( 072 )
    [DMB+430] = { id =  DMB+430}, -- Nightmare_Hippogryph ( 073 )
    [DMB+431] = { id =  DMB+431}, -- Nightmare_Hippogryph ( 073 )
    [DMB+432] = { id =  DMB+432}, -- Nightmare_Hippogryph ( 073 )
    [DMB+154] = { id =  DMB+154}, -- Nightmare_Sabotender ( 074 )
    [DMB+155] = { id =  DMB+155}, -- Nightmare_Sabotender ( 074 )
    [DMB+156] = { id =  DMB+156}, -- Nightmare_Sabotender ( 074 )
    [DMB+157] = { id =  DMB+157}, -- Nightmare_Sabotender ( 075 )
    [DMB+158] = { id =  DMB+158}, -- Nightmare_Sabotender ( 075 )
    [DMB+159] = { id =  DMB+159}, -- Nightmare_Sabotender ( 075 )
    [DMB+160] = { id =  DMB+160}, -- Nightmare_Sabotender ( 076 )
    [DMB+161] = { id =  DMB+161}, -- Nightmare_Sabotender ( 076 )
    [DMB+162] = { id =  DMB+162}, -- Nightmare_Sabotender ( 076 )
    [DMB+163] = { id =  DMB+163}, -- Nightmare_Sabotender ( 077 )
    [DMB+164] = { id =  DMB+164}, -- Nightmare_Sabotender ( 077 )
    [DMB+165] = { id =  DMB+165}, -- Nightmare_Sabotender ( 077 )
    [DMB+166] = { id =  DMB+166}, -- Nightmare_Sabotender ( 078 )
    [DMB+167] = { id =  DMB+167}, -- Nightmare_Sabotender ( 078 )
    [DMB+168] = { id =  DMB+168}, -- Nightmare_Sabotender ( 078 )
    [DMB+169] = { id =  DMB+169}, -- Nightmare_Sabotender ( 079 )
    [DMB+170] = { id =  DMB+170}, -- Nightmare_Sabotender ( 079 )
    [DMB+171] = { id =  DMB+171}, -- Nightmare_Sabotender ( 079 )
    [DMB+172] = { id =  DMB+172}, -- Nightmare_Sabotender ( 080 )
    [DMB+173] = { id =  DMB+173}, -- Nightmare_Sabotender ( 080 )
    [DMB+174] = { id =  DMB+174}, -- Nightmare_Sabotender ( 080 )
    [DMB+175] = { id =  DMB+175}, -- Nightmare_Sabotender ( 081 )
    [DMB+176] = { id =  DMB+176}, -- Nightmare_Sabotender ( 081 )
    [DMB+177] = { id =  DMB+177}, -- Nightmare_Sabotender ( 081 )
    [DMB+178] = { id =  DMB+178}, -- Nightmare_Sabotender ( 082 )
    [DMB+351] = { id =  DMB+351}, -- Nightmare_Sabotender ( 082 )
    [DMB+352] = { id =  DMB+352}, -- Nightmare_Sabotender ( 082 )
    -- Flytrap NM Area
    [DMB+353] = { id =  DMB+353}, -- Nightmare_Sabotender ( 083 )
    [DMB+354] = { id =  DMB+354}, -- Nightmare_Sabotender ( 083 )
    [DMB+355] = { id =  DMB+355}, -- Nightmare_Sabotender ( 083 )
    [DMB+626] = { id =  DMB+626}, -- Nightmare_Hippogryph ( 084 )
    [DMB+627] = { id =  DMB+627}, -- Nightmare_Hippogryph ( 084 )
    [DMB+628] = { id =  DMB+628}, -- Nightmare_Hippogryph ( 084 )
    [DMB+629] = { id =  DMB+629}, -- Nightmare_Hippogryph ( 085 )
    [DMB+630] = { id =  DMB+630}, -- Nightmare_Hippogryph ( 085 )
    [DMB+631] = { id =  DMB+631}, -- Nightmare_Hippogryph ( 085 )
    [DMB+632] = { id =  DMB+632}, -- Nightmare_Hippogryph ( 086 )
    [DMB+633] = { id =  DMB+633}, -- Nightmare_Hippogryph ( 086 )
    [DMB+634] = { id =  DMB+634}, -- Nightmare_Hippogryph ( 086 )

    -- Wave 5 Statues based on https://enedin.be/dyna/html/zone/frame_val2.htm
    -- Outpost Area
    [SMB+55 ] = { id =  SMB+55 }, -- Manifest_Icon (033-Y)
    [SMB+336] = { id =  SMB+336}, -- Manifest_Icon (034-Y)
    [SMB+337] = { id =  SMB+337}, -- Manifest_Icon (035-Y)
    [SMB+338] = { id =  SMB+338}, -- Manifest_Icon (036-Y)
    [SMB+339] = { id =  SMB+339}, -- Manifest_Icon (037-Y)
    [SMB+80 ] = { id =  SMB+80 }, -- Goblin_Replica (038-G)
    [SMB+361] = { id =  SMB+361}, -- Goblin_Replica (039-G)
    [SMB+362] = { id =  SMB+362}, -- Goblin_Replica (040-G)
    [SMB+363] = { id =  SMB+363}, -- Goblin_Replica (041-G)
    [SMB+364] = { id =  SMB+364}, -- Goblin_Replica (042-G)
    [SMB+5  ] = { id =  SMB+5  }, -- Sergeant_Tombstone (043-O)
    [SMB+286] = { id =  SMB+286}, -- Sergeant_Tombstone (044-O)
    [SMB+287] = { id =  SMB+287}, -- Sergeant_Tombstone (045-O)
    [SMB+288] = { id =  SMB+288}, -- Sergeant_Tombstone (046-O)
    [SMB+289] = { id =  SMB+289}, -- Sergeant_Tombstone (047-O)
    [SMB+30 ] = { id =  SMB+30 }, -- Adamanking_Effigy (048-Q)
    [SMB+311] = { id =  SMB+311}, -- Adamanking_Effigy (049-Q)
    [SMB+312] = { id =  SMB+312}, -- Adamanking_Effigy (050-Q)
    [SMB+313] = { id =  SMB+313}, -- Adamanking_Effigy (051-Q)
    [SMB+314] = { id =  SMB+314}, -- Adamanking_Effigy (052-Q)
    
    -- Wave 5 Outpost Area
    -- Nightmare Mobs based on https://enedin.be/dyna/html/zone/frame_val2.htm
    -- Nightmare Mobs
    [DMB+363] = { id =  DMB+363}, -- Nightmare_Sabotender ( 053 )
    [DMB+364] = { id =  DMB+364}, -- Nightmare_Sabotender ( 053 )
    [DMB+365] = { id =  DMB+365}, -- Nightmare_Sabotender ( 053 )
    [DMB+366] = { id =  DMB+366}, -- Nightmare_Sabotender ( 054 )
    [DMB+367] = { id =  DMB+367}, -- Nightmare_Sabotender ( 054 )
    [DMB+368] = { id =  DMB+368}, -- Nightmare_Sabotender ( 054 )
    [DMB+369] = { id =  DMB+369}, -- Nightmare_Sabotender ( 055 )
    [DMB+370] = { id =  DMB+370}, -- Nightmare_Sabotender ( 055 )
    [DMB+371] = { id =  DMB+371}, -- Nightmare_Sabotender ( 055 )
    [DMB+372] = { id =  DMB+372}, -- Nightmare_Sabotender ( 056 )
    [DMB+635] = { id =  DMB+635}, -- Nightmare_Sabotender ( 056 )
    [DMB+636] = { id =  DMB+636}, -- Nightmare_Sabotender ( 056 )
    [DMB+637] = { id =  DMB+637}, -- Nightmare_Sabotender ( 057 )
    [DMB+638] = { id =  DMB+638}, -- Nightmare_Sabotender ( 057 )
    [DMB+639] = { id =  DMB+639}, -- Nightmare_Sabotender ( 057 )
    [DMB+640] = { id =  DMB+640}, -- Nightmare_Sabotender ( 058 )
    [DMB+641] = { id =  DMB+641}, -- Nightmare_Sabotender ( 058 )
    [DMB+642] = { id =  DMB+642}, -- Nightmare_Sabotender ( 058 )

    -- All Statue Spawnable Mobs
    [SMB+107] = { id =  SMB+107},
    
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_VALKURM

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- mobList[zone][SMB+1  ].pos = { 81.7644, 0.0000, -71.8662, 0   } -- example

-- set statue eye color
mobList[zone][SMB+75 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+76 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+25 ].eyes = dynamis.eyes.BLUE

-- set time extensions
mobList[zone][DMB+0  ].timeExtension = 60

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements    = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+51, DMB+54, DMB+55 } -- Manticore Sands Nightmare Flies
mobList[zone].waveDefeatRequirements[3] = { DMB+52, DMB+56, DMB+57 } -- Sheep Sands Nightmare Flies
mobList[zone].waveDefeatRequirements[4] = { DMB+53, DMB+58, DMB+59 } -- Hippogryph Sands Nightmare Flies
mobList[zone].waveDefeatRequirements[5] = { DMB+0 } -- Megaboss

-- set which waves this monster will spawn on (can be multiple)
-- Wave 1
mobList[zone][DMB+51 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+52 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+53 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+139].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+615].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+90 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+116].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+0  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+79 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+54 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+29 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+4  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+655].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+433].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+356].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+664].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+50 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+51 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+52 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+53 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+75 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+76 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+77 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+78 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+0  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+1  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+2  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+3  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+25 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+26 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+27 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][SMB+28 ].waves = { 1, nil, nil, nil, nil }
-- Wave 2
mobList[zone][DMB+26 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+29 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+32 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+35 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+38 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+41 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+44 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+47 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+50 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+396].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+400].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+404].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+408].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+411].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+643].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+646].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+649].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+652].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+357].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+360].waves = { nil, 2, nil, nil, nil }
-- Wave 3
mobList[zone][DMB+204].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+207].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+210].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+213].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+216].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+219].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+222].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+224].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+226].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+228].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+473].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+475].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+477].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+479].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+481].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+483].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+485].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+487].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+489].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+491].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+493].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+658].waves = { nil, nil, 3, nil, nil }
mobList[zone][DMB+661].waves = { nil, nil, 3, nil, nil }
-- Wave 4
mobList[zone][DMB+1  ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+4  ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+7  ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+10 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+13 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+16 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+19 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+22 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+25 ].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+415].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+418].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+421].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+424].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+427].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+430].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+154].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+157].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+160].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+163].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+166].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+169].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+172].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+175].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+178].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+353].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+626].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+629].waves = { nil, nil, nil, 4, nil }
mobList[zone][DMB+632].waves = { nil, nil, nil, 4, nil }
-- Wave 5
mobList[zone][SMB+55 ].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+336].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+337].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+338].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+339].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+80 ].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+361].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+362].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+363].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+364].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+5  ].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+286].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+287].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+288].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+289].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+30 ].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+311].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+312].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+313].waves = { nil, nil, nil, nil, 5 }
mobList[zone][SMB+314].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+363].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+366].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+369].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+372].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+637].waves = { nil, nil, nil, nil, 5 }
mobList[zone][DMB+640].waves = { nil, nil, nil, nil, 5 }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][SMB+1  ].specificChildren = { SMB+2, SMB+3, SMB+4 } -- example

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] = 
{
    [1] =
    {
        
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{

}