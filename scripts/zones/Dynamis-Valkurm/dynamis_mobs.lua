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
    -- Hippogryph Sands
    [DMB+51 ] = { id =  DMB+51 }, -- Nightmare Fly ( 021 )
    [DMB+54 ] = { id =  DMB+54 }, -- Nightmare Fly ( 021 )
    [DMB+55 ] = { id =  DMB+55 }, -- Nightmare Fly ( 021 )
    -- Sheep Sands
    [DMB+52 ] = { id =  DMB+52 }, -- Nightmare Fly ( 022 )
    [DMB+56 ] = { id =  DMB+56 }, -- Nightmare Fly ( 022 )
    [DMB+57 ] = { id =  DMB+57 }, -- Nightmare Fly ( 022 )
    -- Manticore Sands
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
    [DMB+669] = { id =  DMB+669}, -- Nightmare_Sabotender ( 031 )
    [DMB+670] = { id =  DMB+670}, -- Nightmare_Sabotender ( 031 )
    [DMB+664] = { id =  DMB+664}, -- Nightmare_Sheep ( 032 )
    [DMB+671] = { id =  DMB+671}, -- Nightmare_Sheep ( 032 )
    [DMB+672] = { id =  DMB+672}, -- Nightmare_Sheep ( 032 )

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
    [SMB+68 ] = { id =  SMB+68 },
    [SMB+58 ] = { id =  SMB+58 },
    [SMB+60 ] = { id =  SMB+60 },
    [SMB+37 ] = { id =  SMB+37 },
    [SMB+34 ] = { id =  SMB+34 },
    [SMB+38 ] = { id =  SMB+38 },
    [SMB+20 ] = { id =  SMB+20 },
    [SMB+17 ] = { id =  SMB+17 },
    [SMB+23 ] = { id =  SMB+23 },
    [SMB-17 ] = { id =  SMB-17 },
    [SMB-6  ] = { id =  SMB-6  },
    [SMB-2  ] = { id =  SMB-2  },
    [SMB+40 ] = { id =  SMB+40 },
    [SMB+47 ] = { id =  SMB+47 },
    [SMB+36 ] = { id =  SMB+36 },
    [SMB+33 ] = { id =  SMB+33 },
    [SMB+48 ] = { id =  SMB+48 },
    [SMB+44 ] = { id =  SMB+44 },
    [SMB+42 ] = { id =  SMB+42 },
    [SMB+43 ] = { id =  SMB+43 },
    [SMB+45 ] = { id =  SMB+45 },
    [SMB+32 ] = { id =  SMB+32 },
    [SMB+41 ] = { id =  SMB+41 },
    [SMB+46 ] = { id =  SMB+46 },
    [SMB+65 ] = { id =  SMB+65 },
    [SMB+73 ] = { id =  SMB+73 },
    [SMB+69 ] = { id =  SMB+69 },
    [SMB+71 ] = { id =  SMB+71 },
    [SMB+70 ] = { id =  SMB+70 },
    [SMB+64 ] = { id =  SMB+64 },
    [SMB+67 ] = { id =  SMB+67 },
    [SMB+66 ] = { id =  SMB+66 },
    [SMB+62 ] = { id =  SMB+62 },
    [SMB+57 ] = { id =  SMB+57 },
    [SMB+72 ] = { id =  SMB+72 },
    [SMB+63 ] = { id =  SMB+63 },
    [SMB-14 ] = { id =  SMB-14 },
    [SMB-8  ] = { id =  SMB-8  },
    [SMB-13 ] = { id =  SMB-13 },
    [SMB-18 ] = { id =  SMB-18 },
    [SMB-16 ] = { id =  SMB-16 },
    [SMB-4  ] = { id =  SMB-4  },
    [SMB-10 ] = { id =  SMB-10 },
    [SMB-3  ] = { id =  SMB-3  },
    [SMB-7  ] = { id =  SMB-7  },
    [SMB-12 ] = { id =  SMB-12 },
    [SMB-11 ] = { id =  SMB-11 },
    [SMB-15 ] = { id =  SMB-15 },
    [SMB+19 ] = { id =  SMB+19 },
    [SMB+10 ] = { id =  SMB+10 },
    [SMB+13 ] = { id =  SMB+13 },
    [SMB+7  ] = { id =  SMB+7  },
    [SMB+16 ] = { id =  SMB+16 },
    [SMB+15 ] = { id =  SMB+15 },
    [SMB+21 ] = { id =  SMB+21 },
    [SMB+8  ] = { id =  SMB+8  },
    [SMB+22 ] = { id =  SMB+22 },
    [SMB+9  ] = { id =  SMB+9  },
    [SMB+11 ] = { id =  SMB+11 },
    [SMB+14 ] = { id =  SMB+14 },
    [SMB+318] = { id =  SMB+318},
    [SMB+325] = { id =  SMB+325},
    [SMB+319] = { id =  SMB+319},
    [SMB+326] = { id =  SMB+326},
    [SMB+333] = { id =  SMB+333},
    [SMB+323] = { id =  SMB+323},
    [SMB+327] = { id =  SMB+327},
    [SMB+331] = { id =  SMB+331},
    [SMB+328] = { id =  SMB+328},
    [SMB+320] = { id =  SMB+320},
    [SMB+334] = { id =  SMB+334},
    [SMB+332] = { id =  SMB+332},
    [SMB+324] = { id =  SMB+324},
    [SMB+329] = { id =  SMB+329},
    [SMB+321] = { id =  SMB+321},
    [SMB+343] = { id =  SMB+343},
    [SMB+346] = { id =  SMB+346},
    [SMB+350] = { id =  SMB+350},
    [SMB+345] = { id =  SMB+345},
    [SMB+358] = { id =  SMB+358},
    [SMB+344] = { id =  SMB+344},
    [SMB+355] = { id =  SMB+355},
    [SMB+349] = { id =  SMB+349},
    [SMB+352] = { id =  SMB+352},
    [SMB+357] = { id =  SMB+357},
    [SMB+353] = { id =  SMB+353},
    [SMB+356] = { id =  SMB+356},
    [SMB+351] = { id =  SMB+351},
    [SMB+359] = { id =  SMB+359},
    [SMB+347] = { id =  SMB+347},
    [SMB+268] = { id =  SMB+268},
    [SMB+276] = { id =  SMB+276},
    [SMB+281] = { id =  SMB+281},
    [SMB+280] = { id =  SMB+280},
    [SMB+277] = { id =  SMB+277},
    [SMB+274] = { id =  SMB+274},
    [SMB+282] = { id =  SMB+282},
    [SMB+275] = { id =  SMB+275},
    [SMB+283] = { id =  SMB+283},
    [SMB+271] = { id =  SMB+271},
    [SMB+278] = { id =  SMB+278},
    [SMB+270] = { id =  SMB+270},
    [SMB+269] = { id =  SMB+269},
    [SMB+284] = { id =  SMB+284},
    [SMB+272] = { id =  SMB+272},
    [SMB+293] = { id =  SMB+293},
    [SMB+297] = { id =  SMB+297},
    [SMB+307] = { id =  SMB+307},
    [SMB+300] = { id =  SMB+300},
    [SMB+295] = { id =  SMB+295},
    [SMB+296] = { id =  SMB+296},
    [SMB+308] = { id =  SMB+308},
    [SMB+304] = { id =  SMB+304},
    [SMB+306] = { id =  SMB+306},
    [SMB+305] = { id =  SMB+305},
    [SMB+298] = { id =  SMB+298},
    [SMB+294] = { id =  SMB+294},
    [SMB+301] = { id =  SMB+301},
    [SMB+302] = { id =  SMB+302},
    [SMB+309] = { id =  SMB+309},
    [DMB+673] = { id =  DMB+673},
    [DMB+674] = { id =  DMB+674},
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_VALKURM

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- Wave 1
-- Boss Area
mobList[zone][DMB+0  ].pos = { 63.648, 1.031, -76.541, 180     } -- ( 024 )
mobList[zone][SMB+79 ].pos = { 29.358, 0.045, -24.815, 45      } -- (025-G)
mobList[zone][SMB+54 ].pos = { 41.943, 0.814, -23.702, 67      } -- (026-Y)
mobList[zone][SMB+29 ].pos = { 56.671, 0.562, -25.307, 67      } -- (027-Q)
mobList[zone][SMB+4  ].pos = { 84.413, 0.024, -29.546, 59      } -- (028-O)
mobList[zone][DMB+655].pos = { 37.877, 0.000, -38.515, 60      } -- ( 029 )
mobList[zone][DMB+433].pos = { 85.392, 0.709, -56.579, 78      } -- ( 030 )
mobList[zone][DMB+356].pos = { 111.675, 0.053, -46.130, 110    } -- ( 031 )
mobList[zone][DMB+664].pos = { 106.273, 0.463, -35.941, 100    } -- ( 032 )
-- NMs
mobList[zone][DMB+139].pos = { -308.519, 0.095, -148.257, 29   } -- ( 005 )
mobList[zone][DMB+615].pos = { -679.979, -8.000, 158.754, 139  } -- ( 010 )
mobList[zone][DMB+90 ].pos = { 769.009, -7.530, 379.675, 54    } -- ( 015 )
mobList[zone][DMB+116].pos = { 956.335, 0.475, -332.799, 190   } -- ( 020 )
-- Initial Statues
mobList[zone][SMB+50 ].pos = { -227.075, 4.043, -136.874, 198  } -- (001-Y)
mobList[zone][SMB+51 ].pos = { -231.037, 4.300, -156.459, 181  } -- (002-Y)
mobList[zone][SMB+52 ].pos = { -248.461, 4.300, -155.360, 241  } -- (003-Y)
mobList[zone][SMB+53 ].pos = { -238.301, 3.994, -135.911, 188  } -- (004-Y)
mobList[zone][SMB+75 ].pos = { -541.404, -15.080, 355.848, 249 } -- (006-G)
mobList[zone][SMB+76 ].pos = { -565.817, -16.120, 354.162, 255 } -- (007-G)
mobList[zone][SMB+77 ].pos = { -550.128, -16.683, 323.770, 130 } -- (008-G)
mobList[zone][SMB+78 ].pos = { -568.867, -16.445, 325.818, 8   } -- (009-G)
mobList[zone][SMB+0  ].pos = { 800.240, -7.456, 254.332, 105   } -- (011-O)
mobList[zone][SMB+1  ].pos = { 796.763, -7.631, 268.595, 64    } -- (012-O)
mobList[zone][SMB+2  ].pos = { 792.154, -8.291, 321.301, 52    } -- (013-O)
mobList[zone][SMB+3  ].pos = { 805.659, -7.797, 340.507, 80    } -- (014-O)
mobList[zone][SMB+25 ].pos = { 648.224, -0.554, -166.534, 176  } -- (016-Q)
mobList[zone][SMB+26 ].pos = { 627.996, -1.738, -163.301, 225  } -- (017-Q)
mobList[zone][SMB+27 ].pos = { 702.606, -5.689, -180.082, 98   } -- (018-Q)
mobList[zone][SMB+28 ].pos = { 718.906, -8.000, -178.972, 123  } -- (019-Q)
mobList[zone][SMB+55 ].pos = { 15.751, -7.298, 79.127, 65      } -- (033-Y)
mobList[zone][SMB+336].pos = { 2.127, -7.719, 70.444, 65       } -- (034-Y)
mobList[zone][SMB+337].pos = { 15.570, -7.075, 68.542, 64      } -- (035-Y)
mobList[zone][SMB+338].pos = { 29.655, -8.313, 67.841, 61      } -- (036-Y)
mobList[zone][SMB+339].pos = { 16.975, -6.399, 53.539, 60      } -- (037-Y)
mobList[zone][SMB+80 ].pos = { -6.098, -7.882, 76.867, 120     } -- (038-G)
mobList[zone][SMB+361].pos = { -18.538, -7.656, 87.493, 126    } -- (039-G)
mobList[zone][SMB+362].pos = { -4.878, -7.742, 87.812, 127     } -- (040-G)
mobList[zone][SMB+363].pos = { 6.479, -7.928, 87.953, 130      } -- (041-G)
mobList[zone][SMB+364].pos = { -4.693, -7.204, 102.477, 124    } -- (042-G)
mobList[zone][SMB+5  ].pos = { 20.768, -7.224, 125.433, 199    } -- (043-O)
mobList[zone][SMB+286].pos = { 3.822, -7.841, 112.598, 204     } -- (044-O)
mobList[zone][SMB+287].pos = { 17.844, -8.016, 108.887, 198    } -- (045-O)
mobList[zone][SMB+288].pos = { 31.170, -7.792, 106.365, 195    } -- (046-O)
mobList[zone][SMB+289].pos = { 15.876, -7.875, 96.537, 191     } -- (047-O)
mobList[zone][SMB+30 ].pos = { 42.235, -7.096, 101.898, 2      } -- (048-Q)
mobList[zone][SMB+311].pos = { 28.787, -7.788, 86.305, 2       } -- (049-Q)
mobList[zone][SMB+312].pos = { 40.759, -7.855, 86.931, 253     } -- (050-Q)
mobList[zone][SMB+313].pos = { 54.684, -7.896, 87.993, 252     } -- (051-Q)
mobList[zone][SMB+314].pos = { 41.105, -7.913, 74.242, 255     } -- (052-Q)
-- Nightmare Mobs
mobList[zone][DMB+51 ].pos = { -199.637, 0.752, 15.476, 243    } -- ( 021 )
mobList[zone][DMB+52 ].pos = { 497.477, -15.127, 237.200, 77   } -- ( 022 )
mobList[zone][DMB+53 ].pos = { 351.001, -2.324, -21.541, 159   } -- ( 023 )
mobList[zone][DMB+363].pos = { 270.350, -7.845, 88.144, 11     } -- ( 053 )
mobList[zone][DMB+366].pos = { 269.572, -7.850, 110.006, 212   } -- ( 054 )
mobList[zone][DMB+369].pos = { 232.008, -8.007, 114.407, 116   } -- ( 055 )
mobList[zone][DMB+372].pos = { 227.459, -7.580, 81.794, 109    } -- ( 056 )
mobList[zone][DMB+637].pos = { 203.136, -7.688, 103.600, 130   } -- ( 057 )
mobList[zone][DMB+640].pos = { 204.115, -7.446, 133.583, 112   } -- ( 058 )
mobList[zone][DMB+1  ].pos = { -201.351, -0.157, -72.847, 191  } -- ( 059 )
mobList[zone][DMB+4  ].pos = { -182.171, -2.491, -41.078, 211  } -- ( 060 )
mobList[zone][DMB+7  ].pos = { -207.936, -3.404, -18.120, 169  } -- ( 061 )
mobList[zone][DMB+10 ].pos = { -211.957, -0.079, -48.985, 246  } -- ( 062 )
mobList[zone][DMB+13 ].pos = { -242.782, -0.176, -39.340, 131  } -- ( 063 )
mobList[zone][DMB+16 ].pos = { -337.618, -7.120, 116.906, 27   } -- ( 064 )
mobList[zone][DMB+19 ].pos = { -368.481, -7.446, 104.491, 3    } -- ( 065 )
mobList[zone][DMB+22 ].pos = { -431.067, -7.755, 83.780, 17    } -- ( 066 )
mobList[zone][DMB+25 ].pos = { -439.514, -7.563, 147.256, 66   } -- ( 067 )
mobList[zone][DMB+415].pos = { -411.644, -7.61, 200.437, 235   } -- ( 068 )
mobList[zone][DMB+418].pos = { -363.394, -8.000, 199.008, 245  } -- ( 069 )
mobList[zone][DMB+421].pos = { -337.741, -9.782, 180.387, 21   } -- ( 070 )
mobList[zone][DMB+424].pos = { -323.574, -7.976, 155.486, 27   } -- ( 071 )
mobList[zone][DMB+427].pos = { -321.165, -7.748, 129.066, 16   } -- ( 072 )
mobList[zone][DMB+430].pos = { -307.629, -7.568, 161.307, 21   } -- ( 073 )
mobList[zone][DMB+154].pos = { -528.345, -9.070, 112.368, 235  } -- ( 074 )
mobList[zone][DMB+157].pos = { -525.822, -7.596, 134.059, 26   } -- ( 075 )
mobList[zone][DMB+160].pos = { -525.602, -8.154, 161.502, 57   } -- ( 076 )
mobList[zone][DMB+163].pos = { -504.772, -8.829, 166.651, 10   } -- ( 077 )
mobList[zone][DMB+166].pos = { -506.119, -7.978, 141.795, 55   } -- ( 078 )
mobList[zone][DMB+169].pos = { -495.775, -7.227, 116.713, 12   } -- ( 079 )
mobList[zone][DMB+172].pos = { -477.706, -7.630, 131.416, 248  } -- ( 080 )
mobList[zone][DMB+175].pos = { -476.029, -8.003, 161.425, 237  } -- ( 081 )
mobList[zone][DMB+178].pos = { -496.854, -7.158, 123.142, 221  } -- ( 082 )
mobList[zone][DMB+353].pos = { -675.863, -8.309, 206.097, 69   } -- ( 083 )
mobList[zone][DMB+626].pos = { -704.722, -7.277, 203.703, 3    } -- ( 084 )
mobList[zone][DMB+629].pos = { -722.532, -8.000, 238.819, 49   } -- ( 085 )
mobList[zone][DMB+632].pos = { -747.801, -4.455, 196.307, 11   } -- ( 086 )
mobList[zone][DMB+204].pos = { 448.005, -15.775, 233.921, 42   } -- ( 087 )
mobList[zone][DMB+207].pos = { 449.724, -16.110, 209.823, 94   } -- ( 088 )
mobList[zone][DMB+210].pos = { 471.173, -16.142, 218.323, 235  } -- ( 089 )
mobList[zone][DMB+213].pos = { 463.897, -15.196, 239.508, 50   } -- ( 090 )
mobList[zone][DMB+216].pos = { 486.988, -15.702, 251.184, 49   } -- ( 091 )
mobList[zone][DMB+219].pos = { 500.990, -16.375, 219.804, 148  } -- ( 092 )
mobList[zone][DMB+222].pos = { 440.603, -8.000, 80.841, 179    } -- ( 093 )
mobList[zone][DMB+224].pos = { 453.174, -7.956, 99.440, 198    } -- ( 094 )
mobList[zone][DMB+226].pos = { 430.282, -8.061, 106.429, 154   } -- ( 095 )
mobList[zone][DMB+228].pos = { 414.866, -7.318, 80.183, 110    } -- ( 096 )
mobList[zone][DMB+473].pos = { 407.319, -7.451, 58.923, 138    } -- ( 097 )
mobList[zone][DMB+475].pos = { 428.845, -2.609, 48.355, 15     } -- ( 098 )
mobList[zone][DMB+477].pos = { 419.554, -3.957, 32.476, 89     } -- ( 099 )
mobList[zone][DMB+479].pos = { 398.680, -7.547, 32.037, 121    } -- ( 100 )
mobList[zone][DMB+481].pos = { 398.680, -7.547, 32.037, 121    } -- ( 101 )
mobList[zone][DMB+483].pos = { 374.559, -7.349, 77.603, 144    } -- ( 102 )
mobList[zone][DMB+485].pos = { 354.904, -7.569, 69.202, 122    } -- ( 103 )
mobList[zone][DMB+487].pos = { 350.501, -7.809, 48.913, 84     } -- ( 104 )
mobList[zone][DMB+489].pos = { 350.501, -7.809, 48.913, 84     } -- ( 105 )
mobList[zone][DMB+491].pos = { 390.835, -1.071, 11.709, 1      } -- ( 106 )
mobList[zone][DMB+493].pos = { 713.279, -7.865, 198.806, 145   } -- ( 107 )
mobList[zone][DMB+658].pos = { 716.741, -6.853, 221.077, 139   } -- ( 108 )
mobList[zone][DMB+661].pos = { 693.905, -14.598, 247.086, 69   } -- ( 109 )
mobList[zone][DMB+26 ].pos = { 313.455, -0.126, 4.949, 49      } -- ( 110 )
mobList[zone][DMB+29 ].pos = { 281.517, 0.000, 3.977, 135      } -- ( 111 )
mobList[zone][DMB+32 ].pos = { 257.308, -1.385, -25.174, 98    } -- ( 112 )
mobList[zone][DMB+35 ].pos = { 266.672, -2.356, -59.410, 147   } -- ( 113 )
mobList[zone][DMB+38 ].pos = { 301.975, -0.297, -50.620, 237   } -- ( 114 )
mobList[zone][DMB+41 ].pos = { 335.514, -0.512, -34.323, 247   } -- ( 115 )
mobList[zone][DMB+44 ].pos = { 248.361, 4.000, -157.225, 217   } -- ( 116 )
mobList[zone][DMB+47 ].pos = { 277.378, 3.340, -147.096, 245   } -- ( 117 )
mobList[zone][DMB+50 ].pos = { 306.276, 4.000, -164.827, 192   } -- ( 118 )
mobList[zone][DMB+396].pos = { 331.719, 0.533, -125.410, 202   } -- ( 119 )
mobList[zone][DMB+400].pos = { 627.957, -0.003, -29.334, 81    } -- ( 120 )
mobList[zone][DMB+404].pos = { 650.911, -0.059, -31.493, 84    } -- ( 121 )
mobList[zone][DMB+408].pos = { 657.631, 0.766, -4.862, 56      } -- ( 122 )
mobList[zone][DMB+411].pos = { 632.846, -0.239, 3.933, 41      } -- ( 123 )
mobList[zone][DMB+643].pos = { 679.221, 0.227, -8.568, 107     } -- ( 124 )
mobList[zone][DMB+646].pos = { 921.803, 0.809, -223.797, 141   } -- ( 125 )
mobList[zone][DMB+649].pos = { 896.764, 0.749, -205.139, 139   } -- ( 126 )
mobList[zone][DMB+652].pos = { 892.210, 0.249, -244.012, 91    } -- ( 127 )
mobList[zone][DMB+357].pos = { 911.322, -0.561, -323.268, 237  } -- ( 128 )
mobList[zone][DMB+360].pos = { 968.520, -0.415, -278.791, 99   } -- ( 129 )

-- set statue eye color
mobList[zone][SMB+75 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+76 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+25 ].eyes = dynamis.eyes.BLUE

-- set time extensions
mobList[zone][DMB+0  ].timeExtension = 60

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements    = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+0 } -- Megaboss

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
mobList[zone][DMB+26 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+29 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+32 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+35 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+38 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+41 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+44 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+47 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+50 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+396].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+400].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+404].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+408].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+411].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+643].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+646].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+649].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+652].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+357].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+360].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+204].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+207].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+210].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+213].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+216].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+219].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+222].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+224].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+226].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+228].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+473].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+475].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+477].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+479].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+481].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+483].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+485].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+487].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+489].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+491].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+493].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+658].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+661].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+1  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+4  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+7  ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+10 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+13 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+16 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+19 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+22 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+25 ].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+415].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+418].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+421].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+424].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+427].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+430].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+154].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+157].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+160].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+163].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+166].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+169].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+172].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+175].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+178].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+353].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+626].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+629].waves = { 1, nil, nil, nil, nil }
mobList[zone][DMB+632].waves = { 1, nil, nil, nil, nil }
-- Wave 2
mobList[zone][SMB+55 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+336].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+337].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+338].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+339].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+80 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+361].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+362].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+363].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+364].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+5  ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+286].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+287].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+288].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+289].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+30 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+311].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+312].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+313].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+314].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+366].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+369].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+372].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+637].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+640].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+79 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+54 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+29 ].waves = { nil, 2, nil, nil, nil }
mobList[zone][SMB+4  ].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+655].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+433].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+356].waves = { nil, 2, nil, nil, nil }
mobList[zone][DMB+664].waves = { nil, 2, nil, nil, nil }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][SMB+1  ].specificChildren = { SMB+2, SMB+3, SMB+4 } -- example
-- Wave 1
-- Flies
mobList[zone][DMB+51 ].specificChildren = { true, DMB+54, DMB+55                                                    }
mobList[zone][DMB+52 ].specificChildren = { true, DMB+56, DMB+57                                                    }
mobList[zone][DMB+53 ].specificChildren = { true, DMB+58, DMB+59                                                    }
-- Boss Area
mobList[zone][SMB+79 ].specificChildren = { true, SMB+68, SMB+58, SMB+60                                            } -- THF, DRG, SMN (025-G)
mobList[zone][SMB+54 ].specificChildren = { true, SMB+37, SMB+34, SMB+38                                            } -- THF, DRG, SMN (026-Y)
mobList[zone][SMB+29 ].specificChildren = { true, SMB+20, SMB+17, SMB+23                                            } -- THF, DRG, SMN (027-Q)
mobList[zone][SMB+4  ].specificChildren = { true, SMB-17, SMB-6, SMB-2                                              } -- THF, DRG, SMN (028-O)
mobList[zone][DMB+655].specificChildren = { true, DMB+665, DMB+666                                                  } -- Manticore     ( 029 )
mobList[zone][DMB+433].specificChildren = { true, DMB+667, DMB+668                                                  } -- Hippogryph    ( 030 )
mobList[zone][DMB+356].specificChildren = { true, DMB+669, DMB+670                                                  } -- Sabotender    ( 031 )
mobList[zone][DMB+664].specificChildren = { true, DMB+671, DMB+672                                                  } -- Sheep         ( 032 )
-- Initial Statues
mobList[zone][SMB+50 ].specificChildren = { true, SMB+40, SMB+47, SMB+36                                            } -- WHM, NIN, MNK (001-Y)
mobList[zone][SMB+51 ].specificChildren = { true, SMB+33, SMB+48, SMB+44                                            } -- BRD, BST, DRK (002-Y)
mobList[zone][SMB+52 ].specificChildren = { true, SMB+42, SMB+43, SMB+45                                            } -- PLD, BLM, SAM (003-Y)
mobList[zone][SMB+53 ].specificChildren = { true, SMB+32, SMB+41, SMB+46                                            } -- WAR, RNG, RDM (004-Y)
mobList[zone][SMB+75 ].specificChildren = { true, SMB+65, SMB+73, SMB+69                                            } -- BRD, BST, DRK (006-G)
mobList[zone][SMB+76 ].specificChildren = { true, SMB+71, SMB+70, SMB+64                                            } -- PLD, BLM, SAM (007-G)
mobList[zone][SMB+77 ].specificChildren = { true, SMB+67, SMB+66, SMB+62                                            } -- WHM, NIN, MNK (008-G)
mobList[zone][SMB+78 ].specificChildren = { true, SMB+57, SMB+72, SMB+63                                            } -- WAR, RNG, RDM (009-G)
mobList[zone][SMB+0  ].specificChildren = { true, SMB-14, SMB-8, SMB-13                                             } -- PLD, BLM, SAM (011-O)
mobList[zone][SMB+1  ].specificChildren = { true, SMB-18, SMB-16, SMB-4                                             } -- WAR, RNG, RDM (012-O)
mobList[zone][SMB+2  ].specificChildren = { true, SMB-10, SMB-3, SMB-7                                              } -- BST, BRD, DRK (013-O)
mobList[zone][SMB+3  ].specificChildren = { true, SMB-12, SMB-11, SMB-15                                            } -- WHM, NIN, MNK (014-O)
mobList[zone][SMB+25 ].specificChildren = { true, SMB+19, SMB+10, SMB+13                                            } -- WHM, NIN, MNK (016-Q)
mobList[zone][SMB+26 ].specificChildren = { true, SMB+7, SMB+16, SMB+15                                             } -- WAR, RNG, RDM (017-Q)
mobList[zone][SMB+27 ].specificChildren = { true, SMB+21, SMB+8, SMB+22                                             } -- PLD, BLM, SAM (018-Q)
mobList[zone][SMB+28 ].specificChildren = { true, SMB+9, SMB+11, SMB+14                                             } -- BRD, BST, DRK (019-Q)
mobList[zone][SMB+55 ].specificChildren = { true, SMB+318, SMB+325, SMB+319                                         } -- WAR, RNG, RDM (033-Y)
mobList[zone][SMB+336].specificChildren = { true, SMB+326, SMB+333, SMB+323                                         } -- WHM, NIN, MNK (034-Y)
mobList[zone][SMB+337].specificChildren = { true, SMB+327, SMB+331, SMB+328                                         } -- PLD, BLM, SAM (035-Y)
mobList[zone][SMB+338].specificChildren = { true, SMB+320, SMB+334, SMB+332                                         } -- BRD, BST, DRK (036-Y)
mobList[zone][SMB+339].specificChildren = { true, SMB+324, SMB+329, SMB+321                                         } -- THF, DRG, SMN (037-Y)
mobList[zone][SMB+80 ].specificChildren = { true, SMB+343, SMB+346, SMB+350                                         } -- WAR, RNG, RDM (038-G)
mobList[zone][SMB+361].specificChildren = { true, SMB+345, SMB+358, SMB+344                                         } -- WHM, NIN, MNK (039-G)
mobList[zone][SMB+362].specificChildren = { true, SMB+355, SMB+349, SMB+352                                         } -- PLD, BLM, SAM (040-G)
mobList[zone][SMB+363].specificChildren = { true, SMB+357, SMB+353, SMB+356                                         } -- BRD, BST, DRK (041-G)
mobList[zone][SMB+364].specificChildren = { true, SMB+351, SMB+359, SMB+347                                         } -- THF, DRG, SMN (042-G)
mobList[zone][SMB+5  ].specificChildren = { true, SMB+268, SMB+276, SMB+281                                         } -- WAR, RNG, RDM (043-O)
mobList[zone][SMB+286].specificChildren = { true, SMB+280, SMB+277, SMB+274                                         } -- WHM, NIN, MNK (044-O)
mobList[zone][SMB+287].specificChildren = { true, SMB+282, SMB+275, SMB+283                                         } -- PLD, BLM, SAM (045-O)
mobList[zone][SMB+288].specificChildren = { true, SMB+271, SMB+278, SMB+270                                         } -- BRD, BST, DRK (046-O)
mobList[zone][SMB+289].specificChildren = { true, SMB+269, SMB+284, SMB+272                                         } -- THF, DRG, SMN (047-O)
mobList[zone][SMB+30 ].specificChildren = { true, SMB+293, SMB+297, SMB+307                                         } -- WAR, RNG, RDM (048-Q)
mobList[zone][SMB+311].specificChildren = { true, SMB+300, SMB+295, SMB+296                                         } -- WHM, NIN, MNK (049-Q)
mobList[zone][SMB+312].specificChildren = { true, SMB+308, SMB+304, SMB+306                                         } -- PLD, BLM, SAM (050-Q)
mobList[zone][SMB+313].specificChildren = { true, SMB+305, SMB+298, SMB+294                                         } -- BRD, BST, DRK (051-Q)
mobList[zone][SMB+314].specificChildren = { true, SMB+301, SMB+302, SMB+309                                         } -- THF, DRG, SMN (052-Q)
-- Nightmare Mobs
mobList[zone][DMB+363].specificChildren = { true, DMB+364, DMB+365                                                  } -- Sabotender    ( 053 )
mobList[zone][DMB+366].specificChildren = { true, DMB+367, DMB+368                                                  } -- Sabotender    ( 054 )
mobList[zone][DMB+369].specificChildren = { true, DMB+370, DMB+371                                                  } -- Sabotender    ( 055 )
mobList[zone][DMB+372].specificChildren = { true, DMB+635, DMB+636                                                  } -- Sabotender    ( 056 )
mobList[zone][DMB+637].specificChildren = { true, DMB+638, DMB+639                                                  } -- Sabotender    ( 057 )
mobList[zone][DMB+640].specificChildren = { true, DMB+641, DMB+642                                                  } -- Sabotender    ( 058 )
mobList[zone][DMB+1  ].specificChildren = { true, DMB+2, DMB+3                                                      } -- Hippogryph    ( 059 )
mobList[zone][DMB+4  ].specificChildren = { true, DMB+5, DMB+6                                                      } -- Hippogryph    ( 060 )
mobList[zone][DMB+7  ].specificChildren = { true, DMB+8, DMB+9                                                      } -- Hippogryph    ( 061 )
mobList[zone][DMB+10 ].specificChildren = { true, DMB+11, DMB+12                                                    } -- Hippogryph    ( 062 )
mobList[zone][DMB+13 ].specificChildren = { true, DMB+14, DMB+15                                                    } -- Hippogryph    ( 063 )
mobList[zone][DMB+16 ].specificChildren = { true, DMB+17, DMB+18                                                    } -- Hippogryph    ( 064 )
mobList[zone][DMB+19 ].specificChildren = { true, DMB+20, DMB+21                                                    } -- Hippogryph    ( 065 )
mobList[zone][DMB+22 ].specificChildren = { true, DMB+23, DMB+24                                                    } -- Hippogryph    ( 066 )
mobList[zone][DMB+25 ].specificChildren = { true, DMB+413, DMB+414                                                  } -- Hippogryph    ( 067 )
mobList[zone][DMB+415].specificChildren = { true, DMB+416, DMB+417                                                  } -- Hippogryph    ( 068 )
mobList[zone][DMB+418].specificChildren = { true, DMB+419, DMB+420                                                  } -- Hippogryph    ( 069 )
mobList[zone][DMB+421].specificChildren = { true, DMB+422, DMB+423                                                  } -- Hippogryph    ( 070 )
mobList[zone][DMB+424].specificChildren = { true, DMB+425, DMB+426                                                  } -- Hippogryph    ( 071 )
mobList[zone][DMB+427].specificChildren = { true, DMB+428, DMB+429                                                  } -- Hippogryph    ( 072 )
mobList[zone][DMB+430].specificChildren = { true, DMB+431, DMB+432                                                  } -- Hippogryph    ( 073 )
mobList[zone][DMB+154].specificChildren = { true, DMB+155, DMB+156                                                  } -- Sabotender    ( 074 )
mobList[zone][DMB+157].specificChildren = { true, DMB+158, DMB+159                                                  } -- Sabotender    ( 075 )
mobList[zone][DMB+160].specificChildren = { true, DMB+161, DMB+162                                                  } -- Sabotender    ( 076 )
mobList[zone][DMB+163].specificChildren = { true, DMB+164, DMB+165                                                  } -- Sabotender    ( 077 )
mobList[zone][DMB+166].specificChildren = { true, DMB+167, DMB+168                                                  } -- Sabotender    ( 078 )
mobList[zone][DMB+169].specificChildren = { true, DMB+170, DMB+171                                                  } -- Sabotender    ( 079 )
mobList[zone][DMB+172].specificChildren = { true, DMB+173, DMB+174                                                  } -- Sabotender    ( 080 )
mobList[zone][DMB+175].specificChildren = { true, DMB+176, DMB+177                                                  } -- Sabotender    ( 081 )
mobList[zone][DMB+178].specificChildren = { true, DMB+351, DMB+352                                                  } -- Sabotender    ( 082 )
mobList[zone][DMB+353].specificChildren = { true, DMB+354, DMB+355                                                  } -- Sabotender    ( 083 )
mobList[zone][DMB+626].specificChildren = { true, DMB+627, DMB+628                                                  } -- Hippogryph    ( 084 )
mobList[zone][DMB+629].specificChildren = { true, DMB+630, DMB+631                                                  } -- Hippogryph    ( 085 )
mobList[zone][DMB+632].specificChildren = { true, DMB+633, DMB+634                                                  } -- Hippogryph    ( 086 )
mobList[zone][DMB+204].specificChildren = { true, DMB+205, DMB+206                                                  } -- Sheep         ( 087 )
mobList[zone][DMB+207].specificChildren = { true, DMB+208, DMB+209                                                  } -- Sheep         ( 088 )
mobList[zone][DMB+210].specificChildren = { true, DMB+211, DMB+212                                                  } -- Sheep         ( 089 )
mobList[zone][DMB+213].specificChildren = { true, DMB+214, DMB+215                                                  } -- Sheep         ( 090 )
mobList[zone][DMB+216].specificChildren = { true, DMB+217, DMB+218                                                  } -- Sheep         ( 091 )
mobList[zone][DMB+219].specificChildren = { true, DMB+220, DMB+221                                                  } -- Sheep         ( 092 )
mobList[zone][DMB+222].specificChildren = { true, DMB+223                                                           } -- Sheep         ( 093 )
mobList[zone][DMB+224].specificChildren = { true, DMB+225                                                           } -- Sheep         ( 094 )
mobList[zone][DMB+226].specificChildren = { true, DMB+227                                                           } -- Sheep         ( 095 )
mobList[zone][DMB+228].specificChildren = { true, DMB+472                                                           } -- Sheep         ( 096 )
mobList[zone][DMB+473].specificChildren = { true, DMB+474                                                           } -- Sheep         ( 097 )
mobList[zone][DMB+475].specificChildren = { true, DMB+476                                                           } -- Sheep         ( 098 )
mobList[zone][DMB+477].specificChildren = { true, DMB+478                                                           } -- Sheep         ( 099 )
mobList[zone][DMB+479].specificChildren = { true, DMB+480                                                           } -- Sheep         ( 100 )
mobList[zone][DMB+481].specificChildren = { true, DMB+482                                                           } -- Sheep         ( 101 )
mobList[zone][DMB+483].specificChildren = { true, DMB+484                                                           } -- Sheep         ( 102 )
mobList[zone][DMB+485].specificChildren = { true, DMB+486                                                           } -- Sheep         ( 103 )
mobList[zone][DMB+487].specificChildren = { true, DMB+488                                                           } -- Sheep         ( 104 )
mobList[zone][DMB+489].specificChildren = { true, DMB+490                                                           } -- Sheep         ( 105 )
mobList[zone][DMB+491].specificChildren = { true, DMB+492                                                           } -- Sheep         ( 106 )
mobList[zone][DMB+493].specificChildren = { true, DMB+656, DMB+657                                                  } -- Sheep         ( 107 )
mobList[zone][DMB+658].specificChildren = { true, DMB+659, DMB+660                                                  } -- Sheep         ( 108 )
mobList[zone][DMB+661].specificChildren = { true, DMB+662, DMB+663                                                  } -- Sheep         ( 109 )
mobList[zone][DMB+26 ].specificChildren = { true, DMB+27, DMB+28                                                    } -- Manticore     ( 110 )
mobList[zone][DMB+29 ].specificChildren = { true, DMB+30, DMB+31                                                    } -- Manticore     ( 111 )
mobList[zone][DMB+32 ].specificChildren = { true, DMB+33, DMB+34                                                    } -- Manticore     ( 112 )
mobList[zone][DMB+35 ].specificChildren = { true, DMB+36, DMB+37                                                    } -- Manticore     ( 113 )
mobList[zone][DMB+38 ].specificChildren = { true, DMB+39, DMB+40                                                    } -- Manticore     ( 114 )
mobList[zone][DMB+41 ].specificChildren = { true, DMB+42, DMB+43                                                    } -- Manticore     ( 115 )
mobList[zone][DMB+44 ].specificChildren = { true, DMB+45, DMB+46                                                    } -- Manticore     ( 116 )
mobList[zone][DMB+47 ].specificChildren = { true, DMB+48, DMB+49                                                    } -- Manticore     ( 117 )
mobList[zone][DMB+50 ].specificChildren = { true, DMB+394, DMB+395                                                  } -- Manticore     ( 118 )
mobList[zone][DMB+396].specificChildren = { true, DMB+397, DMB+398, DMB+399                                         } -- Manticore     ( 119 )
mobList[zone][DMB+400].specificChildren = { true, DMB+401, DMB+402, DMB+403                                         } -- Manticore     ( 120 )
mobList[zone][DMB+404].specificChildren = { true, DMB+405, DMB+406, DMB+407                                         } -- Manticore     ( 121 )
mobList[zone][DMB+408].specificChildren = { true, DMB+409, DMB+410                                                  } -- Manticore     ( 122 )
mobList[zone][DMB+411].specificChildren = { true, DMB+412, DMB+413                                                  } -- Manticore     ( 123 )
mobList[zone][DMB+643].specificChildren = { true, DMB+644, DMB+645                                                  } -- Manticore     ( 124 )
mobList[zone][DMB+646].specificChildren = { true, DMB+647, DMB+648                                                  } -- Manticore     ( 125 )
mobList[zone][DMB+649].specificChildren = { true, DMB+650, DMB+651                                                  } -- Manticore     ( 126 )
mobList[zone][DMB+652].specificChildren = { true, DMB+653, DMB+654                                                  } -- Manticore     ( 127 )
mobList[zone][DMB+357].specificChildren = { true, DMB+358, DMB+359                                                  } -- Sabotender    ( 128 )
mobList[zone][DMB+360].specificChildren = { true, DMB+361, DMB+362                                                  } -- Sabotender    ( 129 )

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