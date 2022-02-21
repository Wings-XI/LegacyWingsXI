-----------------------------------
--
-- Dynamis-San_dOria
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_SAN_DORIA
local DMB = 17534976 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17535376 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier
-- drop id for statues = 3202, drop id for mobs = 3203

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

-- remember, statues 87, 157, 164, 243, 246, 368 are Warchief Tombstones instead of Serjeant, which are RDM instead of BLM. IDs are 17535463, 17535533, 17535540, 17535619, 17535622, 17535744

mobList[zone] =
{
    [17534977] = { id =  DMB+1 }, --	Overlords_Tombstone
    [17534978] = { id =  DMB+2 }, --	Battlechoir_Gitchfotch
    [17534979] = { id =  DMB+3 }, --	Soulsender_Fugbrag
    [17534980] = { id =  DMB+4 }, --	Vanguard_Footsoldier
    [17534981] = { id =  DMB+5 }, --	Vanguard_Trooper
    [17534982] = { id =  DMB+6 }, --	Vanguard_Amputator
    [17534983] = { id =  DMB+7 }, --	Vanguard_Vexer
    [17534984] = { id =  DMB+8 }, --	Vanguard_Pillager
    [17534985] = { id =  DMB+9 }, --	Vanguard_Mesmerizer
    [17534986] = { id =  DMB+10 }, --	Vanguard_Grappler
    [17534987] = { id =  DMB+11 }, --	Vanguard_Neckchopper
    [17534988] = { id =  DMB+12 }, --	Vanguard_Mesmerizer
    [17534989] = { id =  DMB+13 }, --	Vanguard_Bugler
    [17534990] = { id =  DMB+14 }, --	Vanguard_Gutslasher
    [17534991] = { id =  DMB+15 }, --	Vanguard_Impaler
    [17534992] = { id =  DMB+16 }, --	Vanguards_Wyvern
    [17534993] = { id =  DMB+17 }, --	Vanguard_Backstabber
    [17534994] = { id =  DMB+18 }, --	Vanguard_Hawker
    [17534995] = { id =  DMB+19 }, --	Vanguards_Hecteyes
    [17534996] = { id =  DMB+20 }, --	Vanguard_Dollmaster
    [17534997] = { id =  DMB+21 }, --	Vanguards_Avatar
    [17534998] = { id =  DMB+22 }, --	Vanguard_Vexer
    [17534999] = { id =  DMB+23 }, --	Vanguard_Predator
    [17535000] = { id =  DMB+24 }, --	Vanguard_Footsoldier
    [17535001] = { id =  DMB+25 }, --	Vanguard_Grappler
    [17535002] = { id =  DMB+26 }, --	Vanguard_Predator
    [17535003] = { id =  DMB+27 }, --	Serjeant_Tombstone
    [17535004] = { id =  DMB+28 }, --	Serjeant_Tombstone
    [17535005] = { id =  DMB+29 }, --	Serjeant_Tombstone
    [17535006] = { id =  DMB+30 }, --	Reapertongue_Gadgquok
    [17535007] = { id =  DMB+31 }, --	Vanguards_Avatar
    [17535008] = { id =  DMB+32 }, --	Vanguard_Trooper
    [17535009] = { id =  DMB+33 }, --	Vanguard_Amputator
    [17535010] = { id =  DMB+34 }, --	Vanguard_Dollmaster
    [17535011] = { id =  DMB+35 }, --	Vanguards_Avatar
    [17535012] = { id =  DMB+36 }, --	Vanguard_Footsoldier
    [17535013] = { id =  DMB+37 }, --	Vanguard_Backstabber
    [17535014] = { id =  DMB+38 }, --	Vanguard_Impaler
    [17535015] = { id =  DMB+39 }, --	Vanguards_Wyvern
    [17535016] = { id =  DMB+40 }, --	Vanguard_Footsoldier
    [17535017] = { id =  DMB+41 }, --	Vanguard_Grappler
    [17535018] = { id =  DMB+42 }, --	Vanguard_Amputator
    [17535019] = { id =  DMB+43 }, --	Vanguard_Trooper
    [17535020] = { id =  DMB+44 }, --	Vanguard_Neckchopper
    [17535021] = { id =  DMB+45 }, --	Vanguard_Pillager
    [17535022] = { id =  DMB+46 }, --	Vanguard_Bugler
    [17535023] = { id =  DMB+47 }, --	Vanguard_Predator
    [17535024] = { id =  DMB+48 }, --	Vanguard_Vexer
    [17535025] = { id =  DMB+49 }, --	Vanguard_Trooper
    [17535026] = { id =  DMB+50 }, --	Warchief_Tombstone
    [17535027] = { id =  DMB+51 }, --	Vanguard_Bugler
    [17535028] = { id =  DMB+52 }, --	Vanguard_Hawker
    [17535029] = { id =  DMB+53 }, --	Vanguards_Hecteyes
    [17535030] = { id =  DMB+54 }, --	Vanguard_Gutslasher
    [17535031] = { id =  DMB+55 }, --	Vanguard_Backstabber
    [17535032] = { id =  DMB+56 }, --	Wyrmgnasher_Bjakdek
    [17535033] = { id =  DMB+57 }, --	Vanguards_Wyvern
    [17535034] = { id =  DMB+58 }, --	Vanguard_Footsoldier
    [17535035] = { id =  DMB+59 }, --	Vanguard_Grappler
    [17535036] = { id =  DMB+60 }, --	Vanguard_Pillager
    [17535037] = { id =  DMB+61 }, --	Vanguard_Trooper
    [17535038] = { id =  DMB+62 }, --	Vanguard_Neckchopper
    [17535039] = { id =  DMB+63 }, --	Vanguard_Predator
    [17535040] = { id =  DMB+64 }, --	Vanguard_Gutslasher
    [17535041] = { id =  DMB+65 }, --	Vanguard_Backstabber
    [17535042] = { id =  DMB+66 }, --	Vanguard_Impaler
    [17535043] = { id =  DMB+67 }, --	Vanguards_Wyvern
    [17535044] = { id =  DMB+68 }, --	Voidstreaker_Butchnotch
    [17535045] = { id =  DMB+69 }, --	Vanguard_Amputator
    [17535046] = { id =  DMB+70 }, --	Vanguard_Mesmerizer
    [17535047] = { id =  DMB+71 }, --	Vanguard_Vexer
    [17535048] = { id =  DMB+72 }, --	Vanguard_Bugler
    [17535049] = { id =  DMB+73 }, --	Vanguard_Dollmaster
    [17535050] = { id =  DMB+74 }, --	Vanguards_Avatar
    [17535051] = { id =  DMB+75 }, --	Vanguard_Mesmerizer
    [17535052] = { id =  DMB+76 }, --	Vanguard_Bugler
    [17535053] = { id =  DMB+77 }, --	Vanguard_Neckchopper
    [17535054] = { id =  DMB+78 }, --	Vanguard_Pillager
    [17535055] = { id =  DMB+79 }, --	Vanguard_Vexer
    [17535056] = { id =  DMB+80 }, --	Vanguard_Trooper
    [17535057] = { id =  DMB+81 }, --	Warchief_Tombstone
    [17535058] = { id =  DMB+82 }, --	Vanguard_Footsoldier
    [17535059] = { id =  DMB+83 }, --	Vanguard_Grappler
    [17535060] = { id =  DMB+84 }, --	Vanguard_Amputator
    [17535061] = { id =  DMB+85 }, --	Vanguard_Mesmerizer
    [17535062] = { id =  DMB+86 }, --	Vanguard_Vexer
    [17535063] = { id =  DMB+87 }, --	Vanguard_Pillager
    [17535064] = { id =  DMB+88 }, --	Vanguard_Trooper
    [17535065] = { id =  DMB+89 }, --	Vanguard_Neckchopper
    [17535066] = { id =  DMB+90 }, --	Vanguard_Hawker
    [17535067] = { id =  DMB+91 }, --	Vanguards_Hecteyes
    [17535068] = { id =  DMB+92 }, --	Vanguard_Bugler
    [17535069] = { id =  DMB+93 }, --	Vanguard_Predator
    [17535070] = { id =  DMB+94 }, --	Vanguard_Gutslasher
    [17535071] = { id =  DMB+95 }, --	Vanguard_Backstabber
    [17535072] = { id =  DMB+96 }, --	Vanguard_Impaler
    [17535073] = { id =  DMB+97 }, --	Vanguards_Wyvern
    [17535074] = { id =  DMB+98 }, --	Vanguard_Dollmaster
    [17535075] = { id =  DMB+99 }, --	Vanguards_Avatar
    [17535076] = { id =  DMB+100 }, --	Vanguard_Hawker
    [17535077] = { id =  DMB+101 }, --	Vanguards_Hecteyes
    [17535078] = { id =  DMB+102 }, --	Vanguard_Bugler
    [17535079] = { id =  DMB+103 }, --	Vanguard_Grappler
    [17535080] = { id =  DMB+104 }, --	Vanguard_Mesmerizer
    [17535081] = { id =  DMB+105 }, --	Vanguard_Pillager
    [17535082] = { id =  DMB+106 }, --	Vanguard_Gutslasher
    [17535083] = { id =  DMB+107 }, --	Vanguard_Backstabber
    [17535084] = { id =  DMB+108 }, --	Vanguard_Trooper
    [17535085] = { id =  DMB+109 }, --	Vanguard_Footsoldier
    [17535086] = { id =  DMB+110 }, --	Vanguard_Amputator
    [17535087] = { id =  DMB+111 }, --	Vanguard_Neckchopper
    [17535088] = { id =  DMB+112 }, --	Vanguard_Bugler
    [17535089] = { id =  DMB+113 }, --	Vanguard_Predator
    [17535090] = { id =  DMB+114 }, --	Vanguard_Backstabber
    [17535091] = { id =  DMB+115 }, --	Vanguard_Grappler
    [17535092] = { id =  DMB+116 }, --	Vanguard_Gutslasher
    [17535093] = { id =  DMB+117 }, --	Vanguard_Predator
    [17535094] = { id =  DMB+118 }, --	Vanguard_Hawker
    [17535095] = { id =  DMB+119 }, --	Vanguards_Hecteyes
    [17535096] = { id =  DMB+120 }, --	Vanguard_Impaler
    [17535097] = { id =  DMB+121 }, --	Vanguards_Wyvern
    [17535098] = { id =  DMB+122 }, --	Vanguard_Footsoldier
    [17535099] = { id =  DMB+123 }, --	Vanguard_Amputator
    [17535100] = { id =  DMB+124 }, --	Vanguard_Bugler
    [17535101] = { id =  DMB+125 }, --	Vanguard_Predator
    [17535102] = { id =  DMB+126 }, --	Vanguard_Backstabber
    [17535103] = { id =  DMB+127 }, --	Vanguard_Grappler
    [17535104] = { id =  DMB+128 }, --	Vanguard_Gutslasher
    [17535105] = { id =  DMB+129 }, --	Vanguard_Trooper
    [17535106] = { id =  DMB+130 }, --	Vanguard_Predator
    [17535107] = { id =  DMB+131 }, --	Vanguard_Mesmerizer
    [17535108] = { id =  DMB+132 }, --	Vanguard_Vexer
    [17535109] = { id =  DMB+133 }, --	Vanguard_Neckchopper
    [17535110] = { id =  DMB+134 }, --	Vanguard_Dollmaster
    [17535111] = { id =  DMB+135 }, --	Vanguards_Avatar
    [17535112] = { id =  DMB+136 }, --	Vanguard_Backstabber
    [17535113] = { id =  DMB+137 }, --	Serjeant_Tombstone
    [17535114] = { id =  DMB+138 }, --	Serjeant_Tombstone
    [17535115] = { id =  DMB+139 }, --	Serjeant_Tombstone
    [17535116] = { id =  DMB+140 }, --	Vanguard_Footsoldier
    [17535117] = { id =  DMB+141 }, --	Vanguard_Amputator
    [17535118] = { id =  DMB+142 }, --	Vanguard_Bugler
    [17535119] = { id =  DMB+143 }, --	Vanguard_Predator
    [17535120] = { id =  DMB+144 }, --	Vanguard_Predator
    [17535121] = { id =  DMB+145 }, --	Vanguard_Vexer
    [17535122] = { id =  DMB+146 }, --	Vanguard_Neckchopper
    [17535123] = { id =  DMB+147 }, --	Vanguard_Backstabber
    [17535124] = { id =  DMB+148 }, --	Vanguard_Grappler
    [17535125] = { id =  DMB+149 }, --	Vanguard_Trooper
    [17535126] = { id =  DMB+150 }, --	Vanguard_Vexer
    [17535127] = { id =  DMB+151 }, --	Vanguard_Trooper
    [17535128] = { id =  DMB+152 }, --	Warchief_Tombstone
    [17535129] = { id =  DMB+153 }, --	Vanguard_Vexer
    [17535130] = { id =  DMB+154 }, --	Vanguard_Trooper
    [17535131] = { id =  DMB+155 }, --	Warchief_Tombstone
    [17535132] = { id =  DMB+156 }, --	Vanguard_Vexer
    [17535133] = { id =  DMB+157 }, --	Vanguard_Mesmerizer
    [17535134] = { id =  DMB+158 }, --	Vanguard_Footsoldier
    [17535135] = { id =  DMB+159 }, --	Vanguard_Pillager
    [17535136] = { id =  DMB+160 }, --	Vanguard_Predator
    [17535137] = { id =  DMB+161 }, --	Vanguard_Vexer
    [17535138] = { id =  DMB+162 }, --	Vanguard_Trooper
    [17535139] = { id =  DMB+163 }, --	Warchief_Tombstone
    [17535140] = { id =  DMB+164 }, --	Vanguard_Footsoldier
    [17535141] = { id =  DMB+165 }, --	Vanguard_Amputator
    [17535142] = { id =  DMB+166 }, --	Vanguard_Trooper
    [17535143] = { id =  DMB+167 }, --	Vanguard_Gutslasher
    [17535144] = { id =  DMB+168 }, --	Vanguard_Footsoldier
    [17535145] = { id =  DMB+169 }, --	Vanguard_Grappler
    [17535146] = { id =  DMB+170 }, --	Vanguard_Pillager
    [17535147] = { id =  DMB+171 }, --	Vanguard_Trooper
    [17535148] = { id =  DMB+172 }, --	Vanguard_Neckchopper
    [17535149] = { id =  DMB+173 }, --	Vanguard_Hawker
    [17535150] = { id =  DMB+174 }, --	Vanguards_Hecteyes
    [17535151] = { id =  DMB+175 }, --	Vanguard_Predator
    [17535152] = { id =  DMB+176 }, --	Vanguard_Impaler
    [17535153] = { id =  DMB+177 }, --	Vanguards_Wyvern
    [17535154] = { id =  DMB+178 }, --	Serjeant_Tombstone
    [17535155] = { id =  DMB+179 }, --	Serjeant_Tombstone
    [17535156] = { id =  DMB+180 }, --	Vanguard_Footsoldier
    [17535157] = { id =  DMB+181 }, --	Vanguard_Grappler
    [17535158] = { id =  DMB+182 }, --	Vanguard_Pillager
    [17535159] = { id =  DMB+183 }, --	Vanguard_Trooper
    [17535160] = { id =  DMB+184 }, --	Vanguard_Neckchopper
    [17535161] = { id =  DMB+185 }, --	Vanguard_Hawker
    [17535162] = { id =  DMB+186 }, --	Vanguards_Hecteyes
    [17535163] = { id =  DMB+187 }, --	Vanguard_Predator
    [17535164] = { id =  DMB+188 }, --	Vanguard_Impaler
    [17535165] = { id =  DMB+189 }, --	Vanguards_Wyvern
    [17535166] = { id =  DMB+190 }, --	Serjeant_Tombstone
    [17535167] = { id =  DMB+191 }, --	Serjeant_Tombstone
    [17535168] = { id =  DMB+192 }, --	Vanguard_Gutslasher
    [17535169] = { id =  DMB+193 }, --	Vanguard_Gutslasher
    [17535170] = { id =  DMB+194 }, --	Vanguard_Footsoldier
    [17535171] = { id =  DMB+195 }, --	Vanguard_Pillager
    [17535172] = { id =  DMB+196 }, --	Vanguard_Neckchopper
    [17535173] = { id =  DMB+197 }, --	Vanguard_Hawker
    [17535174] = { id =  DMB+198 }, --	Vanguards_Hecteyes
    [17535175] = { id =  DMB+199 }, --	Vanguard_Backstabber
    [17535176] = { id =  DMB+200 }, --	Vanguard_Backstabber
    [17535177] = { id =  DMB+201 }, --	Vanguard_Grappler
    [17535178] = { id =  DMB+202 }, --	Vanguard_Trooper
    [17535179] = { id =  DMB+203 }, --	Vanguard_Impaler
    [17535180] = { id =  DMB+204 }, --	Vanguards_Wyvern
    [17535181] = { id =  DMB+205 }, --	Vanguard_Dollmaster
    [17535182] = { id =  DMB+206 }, --	Vanguards_Avatar
    [17535183] = { id =  DMB+207 }, --	Vanguard_Amputator
    [17535184] = { id =  DMB+208 }, --	Vanguard_Amputator
    [17535185] = { id =  DMB+209 }, --	Vanguard_Mesmerizer
    [17535186] = { id =  DMB+210 }, --	Vanguard_Mesmerizer
    [17535187] = { id =  DMB+211 }, --	Vanguard_Vexer
    [17535188] = { id =  DMB+212 }, --	Vanguard_Vexer
    [17535189] = { id =  DMB+213 }, --	Vanguard_Bugler
    [17535190] = { id =  DMB+214 }, --	Vanguard_Bugler
    [17535191] = { id =  DMB+215 }, --	Vanguard_Dollmaster
    [17535192] = { id =  DMB+216 }, --	Vanguards_Avatar
    [17535193] = { id =  DMB+217 }, --	Serjeant_Tombstone
    [17535194] = { id =  DMB+218 }, --	Serjeant_Tombstone
    [17535195] = { id =  DMB+219 }, --	Vanguard_Amputator
    [17535196] = { id =  DMB+220 }, --	Vanguard_Amputator
    [17535197] = { id =  DMB+221 }, --	Vanguard_Mesmerizer
    [17535198] = { id =  DMB+222 }, --	Vanguard_Mesmerizer
    [17535199] = { id =  DMB+223 }, --	Vanguard_Vexer
    [17535200] = { id =  DMB+224 }, --	Vanguard_Vexer
    [17535201] = { id =  DMB+225 }, --	Vanguard_Bugler
    [17535202] = { id =  DMB+226 }, --	Vanguard_Bugler
    [17535203] = { id =  DMB+227 }, --	Vanguard_Dollmaster
    [17535204] = { id =  DMB+228 }, --	Vanguards_Avatar
    [17535205] = { id =  DMB+229 }, --	Serjeant_Tombstone
    [17535206] = { id =  DMB+230 }, --	Serjeant_Tombstone
    [17535207] = { id =  DMB+231 }, --	Bladeburner_Rokgevok
    [17535208] = { id =  DMB+232 }, --	Steelshank_Kratzvatz
    [17535209] = { id =  DMB+233 }, --	Kratzvatzs_Hecteyes
    [17535210] = { id =  DMB+234 }, --	Bloodfist_Voshgrosh
    [17535211] = { id =  DMB+235 }, --	Spellspear_Djokvukk
    [17535212] = { id =  DMB+236 }, --	Djokvukks_Wyvern
    [17535213] = { id =  DMB+237 }, --	Arch_Overlord_Tombstone
	[17535376] = { id =  SMB+0 }, -- Serjeant_Tombstone
    [17535377] = { id =  SMB+1 }, -- Serjeant_Tombstone
    [17535378] = { id =  SMB+2 }, -- Serjeant_Tombstone
    [17535379] = { id =  SMB+3 }, -- Serjeant_Tombstone
    [17535380] = { id =  SMB+4 }, -- Serjeant_Tombstone
    [17535381] = { id =  SMB+5 }, -- Serjeant_Tombstone
    [17535382] = { id =  SMB+6 }, -- Serjeant_Tombstone
    [17535383] = { id =  SMB+7 }, -- Serjeant_Tombstone
    [17535384] = { id =  SMB+8 }, -- Serjeant_Tombstone
    [17535385] = { id =  SMB+9 }, -- Serjeant_Tombstone
    [17535386] = { id =  SMB+10 }, -- Serjeant_Tombstone
    [17535387] = { id =  SMB+11 }, -- Serjeant_Tombstone
    [17535388] = { id =  SMB+12 }, -- Serjeant_Tombstone
    [17535389] = { id =  SMB+13 }, -- Serjeant_Tombstone
    [17535390] = { id =  SMB+14 }, -- Serjeant_Tombstone
    [17535391] = { id =  SMB+15 }, -- Serjeant_Tombstone
    [17535392] = { id =  SMB+16 }, -- Serjeant_Tombstone
    [17535393] = { id =  SMB+17 }, -- Serjeant_Tombstone
    [17535394] = { id =  SMB+18 }, -- Serjeant_Tombstone
    [17535395] = { id =  SMB+19 }, -- Serjeant_Tombstone
    [17535396] = { id =  SMB+20 }, -- Serjeant_Tombstone
    [17535397] = { id =  SMB+21 }, -- Serjeant_Tombstone
    [17535398] = { id =  SMB+22 }, -- Serjeant_Tombstone
    [17535399] = { id =  SMB+23 }, -- Serjeant_Tombstone
    [17535400] = { id =  SMB+24 }, -- Serjeant_Tombstone
    [17535401] = { id =  SMB+25 }, -- Serjeant_Tombstone
    [17535402] = { id =  SMB+26 }, -- Serjeant_Tombstone
    [17535403] = { id =  SMB+27 }, -- Serjeant_Tombstone
    [17535404] = { id =  SMB+28 }, -- Serjeant_Tombstone
    [17535405] = { id =  SMB+29 }, -- Serjeant_Tombstone
    [17535406] = { id =  SMB+30 }, -- Serjeant_Tombstone
    [17535407] = { id =  SMB+31 }, -- Serjeant_Tombstone
    [17535408] = { id =  SMB+32 }, -- Serjeant_Tombstone
    [17535409] = { id =  SMB+33 }, -- Serjeant_Tombstone
    [17535410] = { id =  SMB+34 }, -- Serjeant_Tombstone
    [17535411] = { id =  SMB+35 }, -- Serjeant_Tombstone
    [17535412] = { id =  SMB+36 }, -- Serjeant_Tombstone
    [17535413] = { id =  SMB+37 }, -- Serjeant_Tombstone
    [17535414] = { id =  SMB+38 }, -- Serjeant_Tombstone
    [17535415] = { id =  SMB+39 }, -- Serjeant_Tombstone
    [17535416] = { id =  SMB+40 }, -- Serjeant_Tombstone
    [17535417] = { id =  SMB+41 }, -- Serjeant_Tombstone
    [17535418] = { id =  SMB+42 }, -- Serjeant_Tombstone
    [17535419] = { id =  SMB+43 }, -- Serjeant_Tombstone
    [17535420] = { id =  SMB+44 }, -- Serjeant_Tombstone
    [17535421] = { id =  SMB+45 }, -- Serjeant_Tombstone
    [17535422] = { id =  SMB+46 }, -- Serjeant_Tombstone
    [17535423] = { id =  SMB+47 }, -- Serjeant_Tombstone
    [17535424] = { id =  SMB+48 }, -- Serjeant_Tombstone
    [17535425] = { id =  SMB+49 }, -- Serjeant_Tombstone
    [17535426] = { id =  SMB+50 }, -- Serjeant_Tombstone
    [17535427] = { id =  SMB+51 }, -- Serjeant_Tombstone
    [17535428] = { id =  SMB+52 }, -- Serjeant_Tombstone
    [17535429] = { id =  SMB+53 }, -- Serjeant_Tombstone
    [17535430] = { id =  SMB+54 }, -- Serjeant_Tombstone
    [17535431] = { id =  SMB+55 }, -- Serjeant_Tombstone
    [17535432] = { id =  SMB+56 }, -- Serjeant_Tombstone
    [17535433] = { id =  SMB+57 }, -- Serjeant_Tombstone
    [17535434] = { id =  SMB+58 }, -- Serjeant_Tombstone
    [17535435] = { id =  SMB+59 }, -- Serjeant_Tombstone
    [17535436] = { id =  SMB+60 }, -- Serjeant_Tombstone
    [17535437] = { id =  SMB+61 }, -- Serjeant_Tombstone
    [17535438] = { id =  SMB+62 }, -- Serjeant_Tombstone
    [17535439] = { id =  SMB+63 }, -- Serjeant_Tombstone
    [17535440] = { id =  SMB+64 }, -- Serjeant_Tombstone
    [17535441] = { id =  SMB+65 }, -- Serjeant_Tombstone
    [17535442] = { id =  SMB+66 }, -- Serjeant_Tombstone
    [17535443] = { id =  SMB+67 }, -- Serjeant_Tombstone
    [17535444] = { id =  SMB+68 }, -- Serjeant_Tombstone
    [17535445] = { id =  SMB+69 }, -- Serjeant_Tombstone
    [17535446] = { id =  SMB+70 }, -- Serjeant_Tombstone
    [17535447] = { id =  SMB+71 }, -- Serjeant_Tombstone
    [17535448] = { id =  SMB+72 }, -- Serjeant_Tombstone
    [17535449] = { id =  SMB+73 }, -- Serjeant_Tombstone
    [17535450] = { id =  SMB+74 }, -- Serjeant_Tombstone
    [17535451] = { id =  SMB+75 }, -- Serjeant_Tombstone
    [17535452] = { id =  SMB+76 }, -- Serjeant_Tombstone
    [17535453] = { id =  SMB+77 }, -- Serjeant_Tombstone
    [17535454] = { id =  SMB+78 }, -- Serjeant_Tombstone
    [17535455] = { id =  SMB+79 }, -- Serjeant_Tombstone
    [17535456] = { id =  SMB+80 }, -- Serjeant_Tombstone
    [17535457] = { id =  SMB+81 }, -- Serjeant_Tombstone
    [17535458] = { id =  SMB+82 }, -- Serjeant_Tombstone
    [17535459] = { id =  SMB+83 }, -- Serjeant_Tombstone
    [17535460] = { id =  SMB+84 }, -- Serjeant_Tombstone
    [17535461] = { id =  SMB+85 }, -- Serjeant_Tombstone
    [17535462] = { id =  SMB+86 }, -- Serjeant_Tombstone
    [17535463] = { id =  SMB+87 }, -- Warchief_Tombstone
    [17535464] = { id =  SMB+88 }, -- Serjeant_Tombstone
    [17535465] = { id =  SMB+89 }, -- Serjeant_Tombstone
    [17535466] = { id =  SMB+90 }, -- Serjeant_Tombstone
    [17535467] = { id =  SMB+91 }, -- Serjeant_Tombstone
    [17535468] = { id =  SMB+92 }, -- Serjeant_Tombstone
    [17535469] = { id =  SMB+93 }, -- Serjeant_Tombstone
    [17535470] = { id =  SMB+94 }, -- Serjeant_Tombstone
    [17535471] = { id =  SMB+95 }, -- Serjeant_Tombstone
    [17535472] = { id =  SMB+96 }, -- Serjeant_Tombstone
    [17535473] = { id =  SMB+97 }, -- Serjeant_Tombstone
    [17535474] = { id =  SMB+98 }, -- Serjeant_Tombstone
    [17535475] = { id =  SMB+99 }, -- Serjeant_Tombstone
    [17535476] = { id =  SMB+100 }, -- Serjeant_Tombstone
    [17535477] = { id =  SMB+101 }, -- Serjeant_Tombstone
    [17535478] = { id =  SMB+102 }, -- Serjeant_Tombstone
    [17535479] = { id =  SMB+103 }, -- Serjeant_Tombstone
    [17535480] = { id =  SMB+104 }, -- Serjeant_Tombstone
    [17535481] = { id =  SMB+105 }, -- Serjeant_Tombstone
    [17535482] = { id =  SMB+106 }, -- Serjeant_Tombstone
    [17535483] = { id =  SMB+107 }, -- Serjeant_Tombstone
    [17535484] = { id =  SMB+108 }, -- Serjeant_Tombstone
    [17535485] = { id =  SMB+109 }, -- Serjeant_Tombstone
    [17535486] = { id =  SMB+110 }, -- Serjeant_Tombstone
    [17535487] = { id =  SMB+111 }, -- Serjeant_Tombstone
    [17535488] = { id =  SMB+112 }, -- Serjeant_Tombstone
    [17535489] = { id =  SMB+113 }, -- Serjeant_Tombstone
    [17535490] = { id =  SMB+114 }, -- Serjeant_Tombstone
    [17535491] = { id =  SMB+115 }, -- Serjeant_Tombstone
    [17535492] = { id =  SMB+116 }, -- Serjeant_Tombstone
    [17535493] = { id =  SMB+117 }, -- Serjeant_Tombstone
    [17535494] = { id =  SMB+118 }, -- Serjeant_Tombstone
    [17535495] = { id =  SMB+119 }, -- Serjeant_Tombstone
    [17535496] = { id =  SMB+120 }, -- Serjeant_Tombstone
    [17535497] = { id =  SMB+121 }, -- Serjeant_Tombstone
    [17535498] = { id =  SMB+122 }, -- Serjeant_Tombstone
    [17535499] = { id =  SMB+123 }, -- Serjeant_Tombstone
    [17535500] = { id =  SMB+124 }, -- Serjeant_Tombstone
    [17535501] = { id =  SMB+125 }, -- Serjeant_Tombstone
    [17535502] = { id =  SMB+126 }, -- Serjeant_Tombstone
    [17535503] = { id =  SMB+127 }, -- Serjeant_Tombstone
    [17535504] = { id =  SMB+128 }, -- Serjeant_Tombstone
    [17535505] = { id =  SMB+129 }, -- Serjeant_Tombstone
    [17535506] = { id =  SMB+130 }, -- Serjeant_Tombstone
    [17535507] = { id =  SMB+131 }, -- Serjeant_Tombstone
    [17535508] = { id =  SMB+132 }, -- Serjeant_Tombstone
    [17535509] = { id =  SMB+133 }, -- Serjeant_Tombstone
    [17535510] = { id =  SMB+134 }, -- Serjeant_Tombstone
    [17535511] = { id =  SMB+135 }, -- Serjeant_Tombstone
    [17535512] = { id =  SMB+136 }, -- Serjeant_Tombstone
    [17535513] = { id =  SMB+137 }, -- Serjeant_Tombstone
    [17535514] = { id =  SMB+138 }, -- Serjeant_Tombstone
    [17535515] = { id =  SMB+139 }, -- Serjeant_Tombstone
    [17535516] = { id =  SMB+140 }, -- Serjeant_Tombstone
    [17535517] = { id =  SMB+141 }, -- Serjeant_Tombstone
    [17535518] = { id =  SMB+142 }, -- Serjeant_Tombstone
    [17535519] = { id =  SMB+143 }, -- Serjeant_Tombstone
    [17535520] = { id =  SMB+144 }, -- Serjeant_Tombstone
    [17535521] = { id =  SMB+145 }, -- Serjeant_Tombstone
    [17535522] = { id =  SMB+146 }, -- Serjeant_Tombstone
    [17535523] = { id =  SMB+147 }, -- Serjeant_Tombstone
    [17535524] = { id =  SMB+148 }, -- Serjeant_Tombstone
    [17535525] = { id =  SMB+149 }, -- Serjeant_Tombstone
    [17535526] = { id =  SMB+150 }, -- Serjeant_Tombstone
    [17535527] = { id =  SMB+151 }, -- Serjeant_Tombstone
    [17535528] = { id =  SMB+152 }, -- Serjeant_Tombstone
    [17535529] = { id =  SMB+153 }, -- Serjeant_Tombstone
    [17535530] = { id =  SMB+154 }, -- Serjeant_Tombstone
    [17535531] = { id =  SMB+155 }, -- Serjeant_Tombstone
    [17535532] = { id =  SMB+156 }, -- Serjeant_Tombstone
    [17535533] = { id =  SMB+157 }, -- Warchief_Tombstone
    [17535534] = { id =  SMB+158 }, -- Serjeant_Tombstone
    [17535535] = { id =  SMB+159 }, -- Serjeant_Tombstone
    [17535536] = { id =  SMB+160 }, -- Serjeant_Tombstone
    [17535537] = { id =  SMB+161 }, -- Serjeant_Tombstone
    [17535538] = { id =  SMB+162 }, -- Serjeant_Tombstone
    [17535539] = { id =  SMB+163 }, -- Serjeant_Tombstone
    [17535540] = { id =  SMB+164 }, -- Warchief_Tombstone
    [17535541] = { id =  SMB+165 }, -- Serjeant_Tombstone
    [17535542] = { id =  SMB+166 }, -- Serjeant_Tombstone
    [17535543] = { id =  SMB+167 }, -- Serjeant_Tombstone
    [17535544] = { id =  SMB+168 }, -- Serjeant_Tombstone
    [17535545] = { id =  SMB+169 }, -- Serjeant_Tombstone
    [17535546] = { id =  SMB+170 }, -- Serjeant_Tombstone
    [17535547] = { id =  SMB+171 }, -- Serjeant_Tombstone
    [17535548] = { id =  SMB+172 }, -- Serjeant_Tombstone
    [17535549] = { id =  SMB+173 }, -- Serjeant_Tombstone
    [17535550] = { id =  SMB+174 }, -- Serjeant_Tombstone
    [17535551] = { id =  SMB+175 }, -- Serjeant_Tombstone
    [17535552] = { id =  SMB+176 }, -- Serjeant_Tombstone
    [17535553] = { id =  SMB+177 }, -- Serjeant_Tombstone
    [17535554] = { id =  SMB+178 }, -- Serjeant_Tombstone
    [17535555] = { id =  SMB+179 }, -- Serjeant_Tombstone
    [17535556] = { id =  SMB+180 }, -- Serjeant_Tombstone
    [17535557] = { id =  SMB+181 }, -- Serjeant_Tombstone
    [17535558] = { id =  SMB+182 }, -- Serjeant_Tombstone
    [17535559] = { id =  SMB+183 }, -- Serjeant_Tombstone
    [17535560] = { id =  SMB+184 }, -- Serjeant_Tombstone
    [17535561] = { id =  SMB+185 }, -- Serjeant_Tombstone
    [17535562] = { id =  SMB+186 }, -- Serjeant_Tombstone
    [17535563] = { id =  SMB+187 }, -- Serjeant_Tombstone
    [17535564] = { id =  SMB+188 }, -- Serjeant_Tombstone
    [17535565] = { id =  SMB+189 }, -- Serjeant_Tombstone
    [17535566] = { id =  SMB+190 }, -- Serjeant_Tombstone
    [17535567] = { id =  SMB+191 }, -- Serjeant_Tombstone
    [17535568] = { id =  SMB+192 }, -- Serjeant_Tombstone
    [17535569] = { id =  SMB+193 }, -- Serjeant_Tombstone
    [17535570] = { id =  SMB+194 }, -- Serjeant_Tombstone
    [17535571] = { id =  SMB+195 }, -- Serjeant_Tombstone
    [17535572] = { id =  SMB+196 }, -- Serjeant_Tombstone
    [17535573] = { id =  SMB+197 }, -- Serjeant_Tombstone
    [17535574] = { id =  SMB+198 }, -- Serjeant_Tombstone
    [17535575] = { id =  SMB+199 }, -- Serjeant_Tombstone
    [17535576] = { id =  SMB+200 }, -- Serjeant_Tombstone
    [17535577] = { id =  SMB+201 }, -- Serjeant_Tombstone
    [17535578] = { id =  SMB+202 }, -- Serjeant_Tombstone
    [17535579] = { id =  SMB+203 }, -- Serjeant_Tombstone
    [17535580] = { id =  SMB+204 }, -- Serjeant_Tombstone
    [17535581] = { id =  SMB+205 }, -- Serjeant_Tombstone
    [17535582] = { id =  SMB+206 }, -- Serjeant_Tombstone
    [17535583] = { id =  SMB+207 }, -- Serjeant_Tombstone
    [17535584] = { id =  SMB+208 }, -- Serjeant_Tombstone
    [17535585] = { id =  SMB+209 }, -- Serjeant_Tombstone
    [17535586] = { id =  SMB+210 }, -- Serjeant_Tombstone
    [17535587] = { id =  SMB+211 }, -- Serjeant_Tombstone
    [17535588] = { id =  SMB+212 }, -- Serjeant_Tombstone
    [17535589] = { id =  SMB+213 }, -- Serjeant_Tombstone
    [17535590] = { id =  SMB+214 }, -- Serjeant_Tombstone
    [17535591] = { id =  SMB+215 }, -- Serjeant_Tombstone
    [17535592] = { id =  SMB+216 }, -- Serjeant_Tombstone
    [17535593] = { id =  SMB+217 }, -- Serjeant_Tombstone
    [17535594] = { id =  SMB+218 }, -- Serjeant_Tombstone
    [17535595] = { id =  SMB+219 }, -- Serjeant_Tombstone
    [17535596] = { id =  SMB+220 }, -- Serjeant_Tombstone
    [17535597] = { id =  SMB+221 }, -- Serjeant_Tombstone
    [17535598] = { id =  SMB+222 }, -- Serjeant_Tombstone
    [17535599] = { id =  SMB+223 }, -- Serjeant_Tombstone
    [17535600] = { id =  SMB+224 }, -- Serjeant_Tombstone
    [17535601] = { id =  SMB+225 }, -- Serjeant_Tombstone
    [17535602] = { id =  SMB+226 }, -- Serjeant_Tombstone
    [17535603] = { id =  SMB+227 }, -- Serjeant_Tombstone
    [17535604] = { id =  SMB+228 }, -- Serjeant_Tombstone
    [17535605] = { id =  SMB+229 }, -- Serjeant_Tombstone
    [17535606] = { id =  SMB+230 }, -- Serjeant_Tombstone
    [17535607] = { id =  SMB+231 }, -- Serjeant_Tombstone
    [17535608] = { id =  SMB+232 }, -- Serjeant_Tombstone
    [17535609] = { id =  SMB+233 }, -- Serjeant_Tombstone
    [17535610] = { id =  SMB+234 }, -- Serjeant_Tombstone
    [17535611] = { id =  SMB+235 }, -- Serjeant_Tombstone
    [17535612] = { id =  SMB+236 }, -- Serjeant_Tombstone
    [17535613] = { id =  SMB+237 }, -- Serjeant_Tombstone
    [17535614] = { id =  SMB+238 }, -- Serjeant_Tombstone
    [17535615] = { id =  SMB+239 }, -- Serjeant_Tombstone
    [17535616] = { id =  SMB+240 }, -- Serjeant_Tombstone
    [17535617] = { id =  SMB+241 }, -- Serjeant_Tombstone
    [17535618] = { id =  SMB+242 }, -- Serjeant_Tombstone
    [17535619] = { id =  SMB+243 }, -- Warchief_Tombstone
    [17535620] = { id =  SMB+244 }, -- Serjeant_Tombstone
    [17535621] = { id =  SMB+245 }, -- Serjeant_Tombstone
    [17535622] = { id =  SMB+246 }, -- Warchief_Tombstone
    [17535623] = { id =  SMB+247 }, -- Serjeant_Tombstone
    [17535624] = { id =  SMB+248 }, -- Serjeant_Tombstone
    [17535625] = { id =  SMB+249 }, -- Serjeant_Tombstone
    [17535626] = { id =  SMB+250 }, -- Serjeant_Tombstone
    [17535627] = { id =  SMB+251 }, -- Serjeant_Tombstone
    [17535628] = { id =  SMB+252 }, -- Serjeant_Tombstone
    [17535629] = { id =  SMB+253 }, -- Serjeant_Tombstone
    [17535630] = { id =  SMB+254 }, -- Serjeant_Tombstone
    [17535631] = { id =  SMB+255 }, -- Serjeant_Tombstone
    [17535632] = { id =  SMB+256 }, -- Serjeant_Tombstone
    [17535633] = { id =  SMB+257 }, -- Serjeant_Tombstone
    [17535634] = { id =  SMB+258 }, -- Serjeant_Tombstone
    [17535635] = { id =  SMB+259 }, -- Serjeant_Tombstone
    [17535636] = { id =  SMB+260 }, -- Serjeant_Tombstone
    [17535637] = { id =  SMB+261 }, -- Serjeant_Tombstone
    [17535638] = { id =  SMB+262 }, -- Serjeant_Tombstone
    [17535639] = { id =  SMB+263 }, -- Serjeant_Tombstone
    [17535640] = { id =  SMB+264 }, -- Serjeant_Tombstone
    [17535641] = { id =  SMB+265 }, -- Serjeant_Tombstone
    [17535642] = { id =  SMB+266 }, -- Serjeant_Tombstone
    [17535643] = { id =  SMB+267 }, -- Serjeant_Tombstone
    [17535644] = { id =  SMB+268 }, -- Serjeant_Tombstone
    [17535645] = { id =  SMB+269 }, -- Serjeant_Tombstone
    [17535646] = { id =  SMB+270 }, -- Serjeant_Tombstone
    [17535647] = { id =  SMB+271 }, -- Serjeant_Tombstone
    [17535648] = { id =  SMB+272 }, -- Serjeant_Tombstone
    [17535649] = { id =  SMB+273 }, -- Serjeant_Tombstone
    [17535650] = { id =  SMB+274 }, -- Serjeant_Tombstone
    [17535651] = { id =  SMB+275 }, -- Serjeant_Tombstone
    [17535652] = { id =  SMB+276 }, -- Serjeant_Tombstone
    [17535653] = { id =  SMB+277 }, -- Serjeant_Tombstone
    [17535654] = { id =  SMB+278 }, -- Serjeant_Tombstone
    [17535655] = { id =  SMB+279 }, -- Serjeant_Tombstone
    [17535656] = { id =  SMB+280 }, -- Serjeant_Tombstone
    [17535657] = { id =  SMB+281 }, -- Serjeant_Tombstone
    [17535658] = { id =  SMB+282 }, -- Serjeant_Tombstone
    [17535659] = { id =  SMB+283 }, -- Serjeant_Tombstone
    [17535660] = { id =  SMB+284 }, -- Serjeant_Tombstone
    [17535661] = { id =  SMB+285 }, -- Serjeant_Tombstone
    [17535662] = { id =  SMB+286 }, -- Serjeant_Tombstone
    [17535663] = { id =  SMB+287 }, -- Serjeant_Tombstone
    [17535664] = { id =  SMB+288 }, -- Serjeant_Tombstone
    [17535665] = { id =  SMB+289 }, -- Serjeant_Tombstone
    [17535666] = { id =  SMB+290 }, -- Serjeant_Tombstone
    [17535667] = { id =  SMB+291 }, -- Serjeant_Tombstone
    [17535668] = { id =  SMB+292 }, -- Serjeant_Tombstone
    [17535669] = { id =  SMB+293 }, -- Serjeant_Tombstone
    [17535670] = { id =  SMB+294 }, -- Serjeant_Tombstone
    [17535671] = { id =  SMB+295 }, -- Serjeant_Tombstone
    [17535672] = { id =  SMB+296 }, -- Serjeant_Tombstone
    [17535673] = { id =  SMB+297 }, -- Serjeant_Tombstone
    [17535674] = { id =  SMB+298 }, -- Serjeant_Tombstone
    [17535675] = { id =  SMB+299 }, -- Serjeant_Tombstone
    [17535676] = { id =  SMB+300 }, -- Serjeant_Tombstone
    [17535677] = { id =  SMB+301 }, -- Serjeant_Tombstone
    [17535678] = { id =  SMB+302 }, -- Serjeant_Tombstone
    [17535679] = { id =  SMB+303 }, -- Serjeant_Tombstone
    [17535680] = { id =  SMB+304 }, -- Serjeant_Tombstone
    [17535681] = { id =  SMB+305 }, -- Serjeant_Tombstone
    [17535682] = { id =  SMB+306 }, -- Serjeant_Tombstone
    [17535683] = { id =  SMB+307 }, -- Serjeant_Tombstone
    [17535684] = { id =  SMB+308 }, -- Serjeant_Tombstone
    [17535685] = { id =  SMB+309 }, -- Serjeant_Tombstone
    [17535686] = { id =  SMB+310 }, -- Serjeant_Tombstone
    [17535687] = { id =  SMB+311 }, -- Serjeant_Tombstone
    [17535688] = { id =  SMB+312 }, -- Serjeant_Tombstone
    [17535689] = { id =  SMB+313 }, -- Serjeant_Tombstone
    [17535690] = { id =  SMB+314 }, -- Serjeant_Tombstone
    [17535691] = { id =  SMB+315 }, -- Serjeant_Tombstone
    [17535692] = { id =  SMB+316 }, -- Serjeant_Tombstone
    [17535693] = { id =  SMB+317 }, -- Serjeant_Tombstone
    [17535694] = { id =  SMB+318 }, -- Serjeant_Tombstone
    [17535695] = { id =  SMB+319 }, -- Serjeant_Tombstone
    [17535696] = { id =  SMB+320 }, -- Serjeant_Tombstone
    [17535697] = { id =  SMB+321 }, -- Serjeant_Tombstone
    [17535698] = { id =  SMB+322 }, -- Serjeant_Tombstone
    [17535699] = { id =  SMB+323 }, -- Serjeant_Tombstone
    [17535700] = { id =  SMB+324 }, -- Serjeant_Tombstone
    [17535701] = { id =  SMB+325 }, -- Serjeant_Tombstone
    [17535702] = { id =  SMB+326 }, -- Serjeant_Tombstone
    [17535703] = { id =  SMB+327 }, -- Serjeant_Tombstone
    [17535704] = { id =  SMB+328 }, -- Serjeant_Tombstone
    [17535705] = { id =  SMB+329 }, -- Serjeant_Tombstone
    [17535706] = { id =  SMB+330 }, -- Serjeant_Tombstone
    [17535707] = { id =  SMB+331 }, -- Serjeant_Tombstone
    [17535708] = { id =  SMB+332 }, -- Serjeant_Tombstone
    [17535709] = { id =  SMB+333 }, -- Serjeant_Tombstone
    [17535710] = { id =  SMB+334 }, -- Serjeant_Tombstone
    [17535711] = { id =  SMB+335 }, -- Serjeant_Tombstone
    [17535712] = { id =  SMB+336 }, -- Serjeant_Tombstone
    [17535713] = { id =  SMB+337 }, -- Serjeant_Tombstone
    [17535714] = { id =  SMB+338 }, -- Serjeant_Tombstone
    [17535715] = { id =  SMB+339 }, -- Serjeant_Tombstone
    [17535716] = { id =  SMB+340 }, -- Serjeant_Tombstone
    [17535717] = { id =  SMB+341 }, -- Serjeant_Tombstone
    [17535718] = { id =  SMB+342 }, -- Serjeant_Tombstone
    [17535719] = { id =  SMB+343 }, -- Serjeant_Tombstone
    [17535720] = { id =  SMB+344 }, -- Serjeant_Tombstone
    [17535721] = { id =  SMB+345 }, -- Serjeant_Tombstone
    [17535722] = { id =  SMB+346 }, -- Serjeant_Tombstone
    [17535723] = { id =  SMB+347 }, -- Serjeant_Tombstone
    [17535724] = { id =  SMB+348 }, -- Serjeant_Tombstone
    [17535725] = { id =  SMB+349 }, -- Serjeant_Tombstone
    [17535726] = { id =  SMB+350 }, -- Serjeant_Tombstone
    [17535727] = { id =  SMB+351 }, -- Serjeant_Tombstone
    [17535728] = { id =  SMB+352 }, -- Serjeant_Tombstone
    [17535729] = { id =  SMB+353 }, -- Serjeant_Tombstone
    [17535730] = { id =  SMB+354 }, -- Serjeant_Tombstone
    [17535731] = { id =  SMB+355 }, -- Serjeant_Tombstone
    [17535732] = { id =  SMB+356 }, -- Serjeant_Tombstone
    [17535733] = { id =  SMB+357 }, -- Serjeant_Tombstone
    [17535734] = { id =  SMB+358 }, -- Serjeant_Tombstone
    [17535735] = { id =  SMB+359 }, -- Serjeant_Tombstone
    [17535736] = { id =  SMB+360 }, -- Serjeant_Tombstone
    [17535737] = { id =  SMB+361 }, -- Serjeant_Tombstone
    [17535738] = { id =  SMB+362 }, -- Serjeant_Tombstone
    [17535739] = { id =  SMB+363 }, -- Serjeant_Tombstone
    [17535740] = { id =  SMB+364 }, -- Serjeant_Tombstone
    [17535741] = { id =  SMB+365 }, -- Serjeant_Tombstone
    [17535742] = { id =  SMB+366 }, -- Serjeant_Tombstone
    [17535743] = { id =  SMB+367 }, -- Serjeant_Tombstone
    [17535744] = { id =  SMB+368 }, -- Warchief_Tombstone
    [17535745] = { id =  SMB+369 }, -- Serjeant_Tombstone
    [17535746] = { id =  SMB+370 }, -- Serjeant_Tombstone
    [17535747] = { id =  SMB+371 }, -- Serjeant_Tombstone
    [17535748] = { id =  SMB+372 }, -- Serjeant_Tombstone
    [17535749] = { id =  SMB+373 }, -- Serjeant_Tombstone
    [17535750] = { id =  SMB+374 }, -- Serjeant_Tombstone
    [17535751] = { id =  SMB+375 }, -- Serjeant_Tombstone
    [17535752] = { id =  SMB+376 }, -- Serjeant_Tombstone
    [17535753] = { id =  SMB+377 }, -- Serjeant_Tombstone
    [17535754] = { id =  SMB+378 }, -- Serjeant_Tombstone
    [17535755] = { id =  SMB+379 }, -- Serjeant_Tombstone
    [17535756] = { id =  SMB+380 }, -- Serjeant_Tombstone
    [17535757] = { id =  SMB+381 }, -- Serjeant_Tombstone
    [17535758] = { id =  SMB+382 }, -- Serjeant_Tombstone
    [17535759] = { id =  SMB+383 }, -- Serjeant_Tombstone
    [17535760] = { id =  SMB+384 }, -- Serjeant_Tombstone
    [17535761] = { id =  SMB+385 }, -- Serjeant_Tombstone
    [17535762] = { id =  SMB+386 }, -- Serjeant_Tombstone
    [17535763] = { id =  SMB+387 }, -- Serjeant_Tombstone
    [17535764] = { id =  SMB+388 }, -- Serjeant_Tombstone
    [17535765] = { id =  SMB+389 }, -- Serjeant_Tombstone
    [17535766] = { id =  SMB+390 }, -- Serjeant_Tombstone
    [17535767] = { id =  SMB+391 }, -- Serjeant_Tombstone
    [17535768] = { id =  SMB+392 }, -- Serjeant_Tombstone
    [17535769] = { id =  SMB+393 }, -- Serjeant_Tombstone
    [17535770] = { id =  SMB+394 }, -- Serjeant_Tombstone
    [17535771] = { id =  SMB+395 }, -- Serjeant_Tombstone
    [17535772] = { id =  SMB+396 }, -- Serjeant_Tombstone
    [17535773] = { id =  SMB+397 }, -- Serjeant_Tombstone
    [17535774] = { id =  SMB+398 }, -- Serjeant_Tombstone
    [17535775] = { id =  SMB+399 }, -- Serjeant_Tombstone
    [17535776] = { id =  SMB+400 }, -- Serjeant_Tombstone
    [17535777] = { id =  SMB+401 }, -- Serjeant_Tombstone
    [17535778] = { id =  SMB+402 }, -- Serjeant_Tombstone
    [17535779] = { id =  SMB+403 }, -- Serjeant_Tombstone
    [17535780] = { id =  SMB+404 }, -- Serjeant_Tombstone
    [17535781] = { id =  SMB+405 }, -- Serjeant_Tombstone
    [17535782] = { id =  SMB+406 }, -- Serjeant_Tombstone
    [17535783] = { id =  SMB+407 }, -- Serjeant_Tombstone
    [17535784] = { id =  SMB+408 }, -- Serjeant_Tombstone
    [17535785] = { id =  SMB+409 }, -- Serjeant_Tombstone
    [17535786] = { id =  SMB+410 }, -- Serjeant_Tombstone
    [17535787] = { id =  SMB+411 }, -- Serjeant_Tombstone
    [17535788] = { id =  SMB+412 }, -- Serjeant_Tombstone
    [17535789] = { id =  SMB+413 }, -- Serjeant_Tombstone
    [17535790] = { id =  SMB+414 }, -- Serjeant_Tombstone
    [17535791] = { id =  SMB+415 }, -- Serjeant_Tombstone
    [17535792] = { id =  SMB+416 }, -- Serjeant_Tombstone
    [17535793] = { id =  SMB+417 }, -- Serjeant_Tombstone
    [17535794] = { id =  SMB+418 }, -- Serjeant_Tombstone
    [17535795] = { id =  SMB+419 }, -- Serjeant_Tombstone
    [17535796] = { id =  SMB+420 }, -- Serjeant_Tombstone
    [17535797] = { id =  SMB+421 }, -- Serjeant_Tombstone
    [17535798] = { id =  SMB+422 }, -- Serjeant_Tombstone
    [17535799] = { id =  SMB+423 }, -- Serjeant_Tombstone
    [17535800] = { id =  SMB+424 }, -- Serjeant_Tombstone
    [17535801] = { id =  SMB+425 }, -- Serjeant_Tombstone
    [17535802] = { id =  SMB+426 }, -- Serjeant_Tombstone
    [17535803] = { id =  SMB+427 }, -- Serjeant_Tombstone
    [17535804] = { id =  SMB+428 }, -- Serjeant_Tombstone
    [17535805] = { id =  SMB+429 }, -- Serjeant_Tombstone
    [17535806] = { id =  SMB+430 }, -- Serjeant_Tombstone
    [17535807] = { id =  SMB+431 }, -- Serjeant_Tombstone
    [17535808] = { id =  SMB+432 }, -- Serjeant_Tombstone
    [17535809] = { id =  SMB+433 }, -- Serjeant_Tombstone
    [17535810] = { id =  SMB+434 }, -- Serjeant_Tombstone
    [17535811] = { id =  SMB+435 }, -- Serjeant_Tombstone
    [17535812] = { id =  SMB+436 }, -- Serjeant_Tombstone
    [17535813] = { id =  SMB+437 }, -- Serjeant_Tombstone
    [17535814] = { id =  SMB+438 }, -- Serjeant_Tombstone
    [17535815] = { id =  SMB+439 }, -- Serjeant_Tombstone
    [17535816] = { id =  SMB+440 }, -- Serjeant_Tombstone
    [17535817] = { id =  SMB+441 }, -- Serjeant_Tombstone
    [17535818] = { id =  SMB+442 }, -- Serjeant_Tombstone
    [17535819] = { id =  SMB+443 }, -- Serjeant_Tombstone
    [17535820] = { id =  SMB+444 }, -- Serjeant_Tombstone
    [17535821] = { id =  SMB+445 }, -- Serjeant_Tombstone
    [17535822] = { id =  SMB+446 }, -- Serjeant_Tombstone
    [17535823] = { id =  SMB+447 }, -- Serjeant_Tombstone
    [17535824] = { id =  SMB+448 }, -- Serjeant_Tombstone
    [17535825] = { id =  SMB+449 }, -- Serjeant_Tombstone
    [17535826] = { id =  SMB+450 }, -- Serjeant_Tombstone
    [17535827] = { id =  SMB+451 }, -- Serjeant_Tombstone
    [17535828] = { id =  SMB+452 }, -- Serjeant_Tombstone
    [17535829] = { id =  SMB+453 }, -- Serjeant_Tombstone
    [17535830] = { id =  SMB+454 }, -- Serjeant_Tombstone
    [17535831] = { id =  SMB+455 }, -- Serjeant_Tombstone
    [17535832] = { id =  SMB+456 }, -- Serjeant_Tombstone
    [17535833] = { id =  SMB+457 }, -- Serjeant_Tombstone
    [17535834] = { id =  SMB+458 }, -- Serjeant_Tombstone
    [17535835] = { id =  SMB+459 }, -- Serjeant_Tombstone
    [17535836] = { id =  SMB+460 }, -- Serjeant_Tombstone
    [17535837] = { id =  SMB+461 }, -- Serjeant_Tombstone
    [17535838] = { id =  SMB+462 }, -- Serjeant_Tombstone
    [17535839] = { id =  SMB+463 }, -- Serjeant_Tombstone
    [17535840] = { id =  SMB+464 }, -- Serjeant_Tombstone
    [17535841] = { id =  SMB+465 }, -- Serjeant_Tombstone
    [17535842] = { id =  SMB+466 }, -- Serjeant_Tombstone
    [17535843] = { id =  SMB+467 }, -- Serjeant_Tombstone
    [17535844] = { id =  SMB+468 }, -- Serjeant_Tombstone
    [17535845] = { id =  SMB+469 }, -- Serjeant_Tombstone
    [17535846] = { id =  SMB+470 }, -- Serjeant_Tombstone
    [17535847] = { id =  SMB+471 }, -- Serjeant_Tombstone
    [17535848] = { id =  SMB+472 }, -- Serjeant_Tombstone
    [17535849] = { id =  SMB+473 }, -- Serjeant_Tombstone
    [17535850] = { id =  SMB+474 }, -- Serjeant_Tombstone
    [17535851] = { id =  SMB+475 }, -- Serjeant_Tombstone
    [17535852] = { id =  SMB+476 }, -- Serjeant_Tombstone
    [17535853] = { id =  SMB+477 }, -- Serjeant_Tombstone
    [17535854] = { id =  SMB+478 }, -- Serjeant_Tombstone
    [17535855] = { id =  SMB+479 }, -- Serjeant_Tombstone
    [17535856] = { id =  SMB+480 }, -- Serjeant_Tombstone
    [17535857] = { id =  SMB+481 }, -- Serjeant_Tombstone
    [17535858] = { id =  SMB+482 }, -- Serjeant_Tombstone
    [17535859] = { id =  SMB+483 }, -- Serjeant_Tombstone
    [17535860] = { id =  SMB+484 }, -- Serjeant_Tombstone
    [17535861] = { id =  SMB+485 }, -- Serjeant_Tombstone
    [17535862] = { id =  SMB+486 }, -- Serjeant_Tombstone
    [17535863] = { id =  SMB+487 }, -- Serjeant_Tombstone
    [17535864] = { id =  SMB+488 }, -- Serjeant_Tombstone
    [17535865] = { id =  SMB+489 }, -- Serjeant_Tombstone
    [17535866] = { id =  SMB+490 }, -- Serjeant_Tombstone
    [17535867] = { id =  SMB+491 }, -- Serjeant_Tombstone
    [17535868] = { id =  SMB+492 }, -- Serjeant_Tombstone
    [17535869] = { id =  SMB+493 }, -- Serjeant_Tombstone
    [17535870] = { id =  SMB+494 }, -- Serjeant_Tombstone
    [17535871] = { id =  SMB+495 }, -- Serjeant_Tombstone
    [17535872] = { id =  SMB+496 }, -- Serjeant_Tombstone
    [17535873] = { id =  SMB+497 }, -- Serjeant_Tombstone
    [17535874] = { id =  SMB+498 }, -- Serjeant_Tombstone
    [17535875] = { id =  SMB+499 }, -- Serjeant_Tombstone
    [17535876] = { id =  SMB+500 }, -- Serjeant_Tombstone
    [17535877] = { id =  SMB+501 }, -- Serjeant_Tombstone
    [17535878] = { id =  SMB+502 }, -- Serjeant_Tombstone
    [17535879] = { id =  SMB+503 }, -- Serjeant_Tombstone
    [17535880] = { id =  SMB+504 }, -- Serjeant_Tombstone
    [17535881] = { id =  SMB+505 }, -- Serjeant_Tombstone
    [17535882] = { id =  SMB+506 }, -- Serjeant_Tombstone
    [17535883] = { id =  SMB+507 }, -- Serjeant_Tombstone
    [17535884] = { id =  SMB+508 }, -- Serjeant_Tombstone
    [17535885] = { id =  SMB+509 }, -- Serjeant_Tombstone
    [17535886] = { id =  SMB+510 }, -- Serjeant_Tombstone
    [17535887] = { id =  SMB+511 }, -- Serjeant_Tombstone
    [17535888] = { id =  SMB+512 }, -- Serjeant_Tombstone
    [17535889] = { id =  SMB+513 }, -- Serjeant_Tombstone
    [17535890] = { id =  SMB+514 }, -- Serjeant_Tombstone
    [17535891] = { id =  SMB+515 }, -- Serjeant_Tombstone
    [17535892] = { id =  SMB+516 }, -- Serjeant_Tombstone
    [17535893] = { id =  SMB+517 }, -- Serjeant_Tombstone
    [17535894] = { id =  SMB+518 }, -- Serjeant_Tombstone
    [17535895] = { id =  SMB+519 }, -- Serjeant_Tombstone
    [17535896] = { id =  SMB+520 }, -- Serjeant_Tombstone
    [17535897] = { id =  SMB+521 }, -- Serjeant_Tombstone
    [17535898] = { id =  SMB+522 }, -- Serjeant_Tombstone
    [17535899] = { id =  SMB+523 }, -- Serjeant_Tombstone
    [17535900] = { id =  SMB+524 }, -- Serjeant_Tombstone
    [17535901] = { id =  SMB+525 }, -- Serjeant_Tombstone
    [17535902] = { id =  SMB+526 }, -- Serjeant_Tombstone
    [17535903] = { id =  SMB+527 }, -- Serjeant_Tombstone
    [17535904] = { id =  SMB+528 }, -- Serjeant_Tombstone
    [17535905] = { id =  SMB+529 }, -- Serjeant_Tombstone
    [17535906] = { id =  SMB+530 }, -- Serjeant_Tombstone
    [17535907] = { id =  SMB+531 }, -- Serjeant_Tombstone
    [17535908] = { id =  SMB+532 }, -- Serjeant_Tombstone
    [17535909] = { id =  SMB+533 }, -- Serjeant_Tombstone
    [17535910] = { id =  SMB+534 }, -- Serjeant_Tombstone
    [17535911] = { id =  SMB+535 }, -- Serjeant_Tombstone
    [17535912] = { id =  SMB+536 }, -- Serjeant_Tombstone
    [17535913] = { id =  SMB+537 }, -- Serjeant_Tombstone
    [17535914] = { id =  SMB+538 }, -- Serjeant_Tombstone
    [17535915] = { id =  SMB+539 }, -- Serjeant_Tombstone
    [17535916] = { id =  SMB+540 }, -- Serjeant_Tombstone
    [17535917] = { id =  SMB+541 }, -- Serjeant_Tombstone
    [17535918] = { id =  SMB+542 }, -- Serjeant_Tombstone
    [17535919] = { id =  SMB+543 }, -- Serjeant_Tombstone
    [17535920] = { id =  SMB+544 }, -- Serjeant_Tombstone
    [17535921] = { id =  SMB+545 }, -- Serjeant_Tombstone
    [17535922] = { id =  SMB+546 }, -- Serjeant_Tombstone
    [17535923] = { id =  SMB+547 }, -- Serjeant_Tombstone
    [17535924] = { id =  SMB+548 }, -- Serjeant_Tombstone
    [17535925] = { id =  SMB+549 }, -- Serjeant_Tombstone
    [17535926] = { id =  SMB+550 }, -- Serjeant_Tombstone
    [17535927] = { id =  SMB+551 }, -- Serjeant_Tombstone
    [17535928] = { id =  SMB+552 }, -- Serjeant_Tombstone
    [17535929] = { id =  SMB+553 }, -- Serjeant_Tombstone
    [17535930] = { id =  SMB+554 }, -- Serjeant_Tombstone
    [17535931] = { id =  SMB+555 }, -- Serjeant_Tombstone
    [17535932] = { id =  SMB+556 }, -- Serjeant_Tombstone
    [17535933] = { id =  SMB+557 }, -- Serjeant_Tombstone
    [17535934] = { id =  SMB+558 }, -- Serjeant_Tombstone
    [17535935] = { id =  SMB+559 }, -- Serjeant_Tombstone
    [17535936] = { id =  SMB+560 }, -- Serjeant_Tombstone
    [17535937] = { id =  SMB+561 }, -- Serjeant_Tombstone
    [17535938] = { id =  SMB+562 }, -- Serjeant_Tombstone
    [17535939] = { id =  SMB+563 }, -- Serjeant_Tombstone
    [17535940] = { id =  SMB+564 }, -- Serjeant_Tombstone
    [17535941] = { id =  SMB+565 }, -- Serjeant_Tombstone
    [17535942] = { id =  SMB+566 }, -- Serjeant_Tombstone
    [17535943] = { id =  SMB+567 }, -- Serjeant_Tombstone
    [17535944] = { id =  SMB+568 }, -- Serjeant_Tombstone
    [17535945] = { id =  SMB+569 }, -- Serjeant_Tombstone
    [17535946] = { id =  SMB+570 }, -- Serjeant_Tombstone
    [17535947] = { id =  SMB+571 }, -- Serjeant_Tombstone
    [17535948] = { id =  SMB+572 }, -- Serjeant_Tombstone
    [17535949] = { id =  SMB+573 }, -- Serjeant_Tombstone
    [17535950] = { id =  SMB+574 }, -- Serjeant_Tombstone
    [17535951] = { id =  SMB+575 }, -- Serjeant_Tombstone
    [17535952] = { id =  SMB+576 }, -- Serjeant_Tombstone
    [17535953] = { id =  SMB+577 }, -- Serjeant_Tombstone
    [17535954] = { id =  SMB+578 }, -- Serjeant_Tombstone
    [17535955] = { id =  SMB+579 }, -- Serjeant_Tombstone
    [17535956] = { id =  SMB+580 }, -- Serjeant_Tombstone
    [17535957] = { id =  SMB+581 }, -- Serjeant_Tombstone
    [17535958] = { id =  SMB+582 }, -- Serjeant_Tombstone
    [17535959] = { id =  SMB+583 }, -- Serjeant_Tombstone
    [17535960] = { id =  SMB+584 }, -- Serjeant_Tombstone
    [17535961] = { id =  SMB+585 }, -- Serjeant_Tombstone
    [17535962] = { id =  SMB+586 }, -- Serjeant_Tombstone
    [17535963] = { id =  SMB+587 }, -- Serjeant_Tombstone
    [17535964] = { id =  SMB+588 }, -- Serjeant_Tombstone
    [17535965] = { id =  SMB+589 }, -- Serjeant_Tombstone
    [17535966] = { id =  SMB+590 }, -- Serjeant_Tombstone
    [17535967] = { id =  SMB+591 }, -- Serjeant_Tombstone
    [17535968] = { id =  SMB+592 }, -- Serjeant_Tombstone
    [17535969] = { id =  SMB+593 }, -- Serjeant_Tombstone
    [17535970] = { id =  SMB+594 }, -- Serjeant_Tombstone
    [17535971] = { id =  SMB+595 }, -- Serjeant_Tombstone
    [17535972] = { id =  SMB+596 }, -- Serjeant_Tombstone
    [17535973] = { id =  SMB+597 }, -- Serjeant_Tombstone
    [17535974] = { id =  SMB+598 }, -- Serjeant_Tombstone
    [17535975] = { id =  SMB+599 }  -- Serjeant_Tombstone

}

mobList[zone].zoneID = tpz.zone.DYNAMIS_SAN_DORIA

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
mobList[zone][SMB+1  ].pos = { 137.0790, -2.0000,  105.1504, 225   } -- Residential Area
mobList[zone][SMB+4  ].pos = { 116.4000,  0.0000,   91.6443, 225   } -- Lion Square Fount. N
mobList[zone][SMB+8  ].pos = { 123.5808,  0.0000,   84.2734, 225     } -- Lion Square Fount. E
mobList[zone][SMB+12 ].pos = { 119.8963,  0.0000,   80.3786, 225    } -- Lion Square Fount. S
mobList[zone][SMB+16 ].pos = { 112.5138,  0.0000,   87.5595, 225   } -- Lion Square Fount. W
mobList[zone][SMB+20 ].pos = { 100.0876,  1.0000,  103.6861, 32    } -- Lion Tavern
mobList[zone][SMB+24 ].pos = { 104.0628,  1.9165,   72.0631, 226   } -- on stair, SW of Lion Square Fount.
mobList[zone][SMB+25 ].pos = {  98.8329,  4.0000,   68.6029, 255   } -- Helbort's Blades N
mobList[zone][SMB+28 ].pos = {  93.7486,  4.0000,   56.9143, 255   } -- Helbort's Blades S
mobList[zone][SMB+31 ].pos = { 101.2500,  4.0000,   50.0912, 160   } -- Door Across Helbort's Blades
mobList[zone][SMB+42 ].pos = {  97.8056,  4.0000,   45.2697, 194   } -- Alleyway, Btw. Wep+Armor Shops
mobList[zone][SMB+39 ].pos = { 101.4410,  4.0000,   32.0477, 151   } -- Door Across Rosel's Armour
mobList[zone][SMB+34 ].pos = {  94.8431,  4.0000,   38.0928, 1   } -- Rosel's Armour
mobList[zone][SMB+58 ].pos = { 140.8978,  0.0000,   55.7513, 165   } -- Sq.Alley N
mobList[zone][SMB+59 ].pos = { 144.9005,  0.0000,   59.3423, 161   } -- Sq.Alley Northern Bldg.
mobList[zone][SMB+45 ].pos = { 142.4358,  0.0000,   69.3664, 70    } -- Sq.Alley Under Staircase
mobList[zone][SMB+54 ].pos = { 147.7160,  0.0000,   42.0697, 177   } -- Sq.Alley C
mobList[zone][SMB+50 ].pos = { 156.4780, -1.0000,   41.9830, 128   } -- Sq.Alley Eastern Bldg.
mobList[zone][SMB+60 ].pos = { 143.5072,  0.0000,   27.3608, 94    } -- Sq.Alley S
mobList[zone][SMB+61 ].pos = { 130.5417,  0.0000,   14.2169, 127   } -- Sq.Alley SW
mobList[zone][SMB+64 ].pos = { 112.9542,  2.0000,   14.0701, 127   } -- Sq.Alley SW2
mobList[zone][SMB+69 ].pos = {  79.7930,  2.0000,   12.7828, 33    } -- Cavalry Way Stair W
mobList[zone][SMB+71 ].pos = {  86.0373,  2.0000,    6.8098, 224   } -- Cavalry Way Stair C
mobList[zone][SMB+67 ].pos = {  93.6929,  2.0000,   -0.2982, 158   } -- Cavalry Way Stair E
mobList[zone][SMB+152].pos = {  55.7694, -8.6001,  -30.0464, 192   } -- W of Eastgate Entrance
mobList[zone][SMB+74 ].pos = {  76.0000,  2.0000,  -4.0000, 160   } -- Eastgate Outside E
mobList[zone][SMB+77 ].pos = {  68.0000,  2.0000,  -12.0000, 160   } -- Eastgate Outside C
mobList[zone][SMB+80 ].pos = {  60.0000,  2.0000,  -20.0000, 160   } -- Eastgate Outside W
mobList[zone][SMB+99 ].pos = {  92.3483,  2.0000,  -20.5081, 160   } -- Eastgate Arches E
mobList[zone][SMB+92 ].pos = {  83.9514,  2.0000,  -28.2492, 160   } -- Eastgate Arches C
mobList[zone][SMB+95 ].pos = {  76.0243,  2.0000,  -36.1443, 160   } -- Eastgate Arches W
mobList[zone][SMB+87 ].pos = {  97.2104,  1.0000,  -41.3545, 160   } -- Eastgate C
mobList[zone][SMB+98 ].pos = { 100.0918,  1.0000,  -36.0744, 154   } -- Eastgate E
mobList[zone][SMB+100].pos = {  92.1923,  1.0000,  -44.0674, 166   } -- Eastgate W
mobList[zone][SMB+101].pos = {  85.4025,  1.0000,  -70.3379, 188   } -- Eastgate Far Corner
mobList[zone][SMB+131].pos = {  40.0124,  2.0000,  -29.8986, 232   } -- Near AH: Choco Tunnel E
mobList[zone][SMB+134].pos = {  28.0243,  2.0000,  -18.3093, 64    } -- Near AH: E Tent
mobList[zone][SMB+139].pos = {  -0.0834,  2.0000,   -8.9377, 64    } -- Near AH: Between Tents
mobList[zone][SMB+144].pos = { -28.0377,  2.0000,  -17.1347, 64    } -- Near AH: W Tent
mobList[zone][SMB+149].pos = { -39.8505,  2.0000,  -29.8840, 150   } -- Near AH: Choco Tunnel W
mobList[zone][SMB+118].pos = {  14.0580,  1.7000,  -28.4680, 192   } -- AH: E
mobList[zone][SMB+114].pos = {  -0.0485,  1.7000,  -25.1019, 192   } -- AH: C
mobList[zone][SMB+121].pos = { -13.9513,  1.7000,  -29.0579, 192   } -- AH: W
mobList[zone][SMB+127].pos = {  11.0112, -3.0000,  -33.8374, 192   } -- AH: Atop E
mobList[zone][SMB+124].pos = {  -1.0120, -3.0000,  -35.0168, 192   } -- AH: Atop C
mobList[zone][SMB+129].pos = { -11.0031, -3.0000,  -33.8110, 192   } -- AH: Atop W
mobList[zone][SMB+190].pos = {  20.0000,  2.0000,    5.0000, 64    } -- Victory Square SE
mobList[zone][SMB+196].pos = { -20.0000,  2.0000,    5.0000, 64    } -- Victory Square SW
mobList[zone][SMB+199].pos = { -20.0000,  0.0000,   24.0000, 64    } -- Victory Square NW
mobList[zone][SMB+193].pos = {  20.0000,  0.0000,   24.0000, 64    } -- Victory Square NE
mobList[zone][SMB+175].pos = {   0.0000,  0.5000,   13.0000, 64    } -- Victory Square Main Path C
mobList[zone][SMB+180].pos = {   5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path E
mobList[zone][SMB+185].pos = {  -5.0000,  0.0000,   22.0000, 64    } -- Victory Square Main Path W
mobList[zone][SMB+107].pos = {   5.4815,  2.0000,  -74.6288, 241   } -- Choco Stable E
mobList[zone][SMB+102].pos = {  -7.7872,  2.0000,  -80.4531, 240   } -- Choco Stable S
mobList[zone][SMB+105].pos = { -12.3592,  2.0000,  -73.7705, 249   } -- Choco Stable W
mobList[zone][SMB+109].pos = {   6.3619,  2.2000,  -86.8097, 161   } -- Choco Stable Gate
mobList[zone][SMB+112].pos = {  18.1228,  2.2000,  -96.3732, 192   } -- Choco Stable Grass W
mobList[zone][SMB+113].pos = {  23.1852,  2.2000,  -96.2487, 192   } -- Choco Stable Grass E
mobList[zone][SMB+153].pos = { -55.8101, -8.6000,  -30.2507, 192   } -- E of Westgate Entrance
mobList[zone][SMB+227].pos = { -66.9165,  2.0000,   -3.3724, 96    } -- Between Street Vendors by Westgate
mobList[zone][SMB+222].pos = { -88.0000,  2.0000,  -16.0000, 224   } -- Westgate Outside W
mobList[zone][SMB+217].pos = { -68.0000,  2.0000,  -12.0000, 224   } -- Westgate Outside C
mobList[zone][SMB+214].pos = { -72.0000,  2.0000,  -32.0000, 224   } -- Westgate Outside E
mobList[zone][SMB+259].pos = { -78.5584,  2.0000,  -38.5455, 224   } -- Westgate Arches E
mobList[zone][SMB+258].pos = { -86.5756,  2.0000,  -30.6161, 224   } -- Westgate Arches C
mobList[zone][SMB+257].pos = { -94.4234,  2.0000,  -22.1406, 224   } -- Westgate Arches W
mobList[zone][SMB+246].pos = { -97.3463,  1.0000,  -41.3016, 224   } -- Westgate C
mobList[zone][SMB+251].pos = { -91.8674,  1.0000,  -44.1162, 224   } -- Westgate E
mobList[zone][SMB+254].pos = {-100.0368,  1.0000,  -36.6710, 224   } -- Westgate W
mobList[zone][SMB+260].pos = {-127.4794,  1.0000,  -29.5681, 5     } -- Westgate Far Corner
mobList[zone][SMB+243].pos = { -97.5497, -2.0000,   17.4388, 32    } -- Stairs to W District C
mobList[zone][SMB+234].pos = { -92.8513, -2.0000,   22.3543, 32    } -- Stairs to W District E
mobList[zone][SMB+231].pos = {-103.0301, -2.0000,   12.5769, 32    } -- Stairs to W District W
mobList[zone][SMB+261].pos = {-114.0525, -2.0000,   16.5393, 12    } -- Guarding Entr. to Atop Westgate
mobList[zone][SMB+237].pos = {-111.2418, -2.0000,   30.9008, 32    } -- Raimbroy's Grocery
mobList[zone][SMB+264].pos = {-130.7194, -2.0000,   18.6867, 247   } -- Between Raimbroy's and Taumila's
mobList[zone][SMB+267].pos = {-141.3845, -2.0000,   18.2596, 0     } -- Taumila's Sundries
mobList[zone][SMB+270].pos = {-156.1573, -2.2000,   25.2480, 65    } -- Entrance to Raimbroy's Catwalks
mobList[zone][SMB+283].pos = {-175.0301, -1.5000,   36.6927, 95    } -- Across LW Guild
mobList[zone][SMB+286].pos = {-184.4630, -1.0000,   27.4167, 224   } -- LW Guild C
mobList[zone][SMB+273].pos = {-174.8346, -1.0000,   24.6105, 217   } -- LW Guild E
mobList[zone][SMB+278].pos = {-186.9280, -1.0000,   37.5468, 237   } -- LW Guild W
mobList[zone][SMB+292].pos = {-196.5302, -8.8000,   39.1053, 251   } -- LW Guild Catwalks N
mobList[zone][SMB+291].pos = {-172.7534, -8.8000,   15.4853, 190   } -- LW Guild Catwalks S
mobList[zone][SMB+293].pos = {-194.0204, -1.5000,   57.7439, 63    } -- Pikeman's Way S
mobList[zone][SMB+298].pos = {-193.5726, -2.0000,   68.4073, 63    } -- Pikeman's Way C
mobList[zone][SMB+313].pos = {-203.9909, -2.0000,   88.3699, 33    } -- Pikeman's Way N
mobList[zone][SMB+301].pos = {-187.3062, -8.8000,   84.3538, 53    } -- Pikeman's Way Catwalks
mobList[zone][SMB+316].pos = {-221.7831, -2.0000,   98.2201, 0     } -- Path to Manor
mobList[zone][SMB+320].pos = {-240.9783, -4.0000,   98.0767, 0     } -- Stairs to Manor
mobList[zone][SMB+368].pos = {-268.0030, -4.0000,   97.9851, 0     } -- Manor
mobList[zone][SMB+370].pos = {-257.8550, -3.6000,  117.6251, 51    } -- Manor Pop N
mobList[zone][SMB+373].pos = {-257.8173, -3.6000,   82.3046, 207   } -- Manor Pop S
mobList[zone][SMB+349].pos = { -94.6474, -4.0000,   41.1507, 95    } -- Watchdog Alley Stairs
mobList[zone][SMB+346].pos = { -89.7747, -4.0000,   49.9768, 81    } -- Watchdog Alley S
mobList[zone][SMB+335].pos = { -94.2479, -6.0000,   74.2410, 57    } -- Watchdog Alley C
mobList[zone][SMB+330].pos = {-110.3660, -6.0000,   86.0028, 24    } -- Watchdog Alley N
mobList[zone][SMB+345].pos = {-125.7547, -6.0000,   89.0013, 10    } -- Watchdog Alley NW
mobList[zone][SMB+323].pos = {-139.4806, -6.0000,   90.0122, 3     } -- Watchdog Alley Catwalk Entrance
mobList[zone][SMB+341].pos = {-132.1907, -4.5000,   74.1945, 64    } -- Back of Watchdog Alley #1
mobList[zone][SMB+343].pos = {-132.1623, -5.2500,   77.2359, 64    } -- Back of Watchdog Alley #2
mobList[zone][SMB+365].pos = {-137.6403,-10.8000,   65.0534, 32    } -- Courtyard Catwalk
mobList[zone][SMB+340].pos = {-132.2272, -4.0000,   70.2963, 64    } -- Courtyard to WD Alley Connector
mobList[zone][SMB+352].pos = {-152.3566, -2.0000,   54.9211, 133   } -- Courtyard SE
mobList[zone][SMB+360].pos = {-166.8674, -2.0000,   54.1991, 142   } -- Courtyard SW
mobList[zone][SMB+357].pos = {-159.2271, -2.0000,   67.6593, 113   } -- Courtyard N
mobList[zone][SMB+309].pos = {-210.2554, -2.0000,   95.1729, 130   } -- W2 Pikeman's Way N
mobList[zone][SMB+305].pos = {-202.6147, -2.0000,   85.8321, 157   } -- W2 Pikeman's Way C
mobList[zone][DMB+1  ].pos = {   0.0735, -2.0000,   44.0171, 64    } -- W2 Megaboss
mobList[zone][SMB+157].pos = {   4.0815, -2.0000,   41.0436, 68    } -- W2 Megaboss Pop Near E
mobList[zone][SMB+164].pos = {  -4.0629, -2.0000,   40.9907, 60    } -- W2 Megaboss Pop Near W
mobList[zone][SMB+172].pos = { -24.8356,  0.0000,   36.8744, 44    } -- W2 Megaboss Pop Far W
mobList[zone][SMB+174].pos = { -17.5909,  0.0000,   37.1444, 53    } -- W2 Megaboss Pop's Pop Far W
mobList[zone][SMB+171].pos = {  23.2271,  0.0000,   35.1004, 77    } -- W2 Megaboss Pop Far E
mobList[zone][SMB+173].pos = {  15.7737,  0.0000,   34.9563, 77    } -- W2 Megaboss Pop's Pop Far E
mobList[zone][SMB+207].pos = { -23.9535,  2.0000,  -12.1383, 0     } -- W2 Victory Square Tent W
mobList[zone][SMB+202].pos = {  23.8516,  2.0000,  -12.4577, 128   } -- W2 Victory Square Tent E
mobList[zone][SMB+212].pos = {  -5.0312,  2.0000,  -11.8298, 51    } -- W2 Victory Square Pop Btw. Tents W
mobList[zone][SMB+213].pos = {   5.0829,  2.0000,  -11.8420, 75    } -- W2 Victory Square Pop Btw. Tents E
mobList[zone][SMB+83 ].pos = {  67.5852,  2.0000,   -3.5269, 32    } -- W2 Btw. Street Vendors by Eastgate
mobList[zone][SMB+444].pos = {-197.3283, -8.8011,   90.7618, 95    } -- W3 Pikeman's Way Catwalk
mobList[zone][SMB+469].pos = {-166.9782, -2.0000,   58.5803, 128   } -- W3 Courtyard W
mobList[zone][SMB+464].pos = {-151.4307, -2.0000,   60.1692, 123   } -- W3 Courtyard E
mobList[zone][SMB+439].pos = {-198.8831, -1.0000,   41.6770, 237   } -- W3 LW Guild N
mobList[zone][SMB+432].pos = {-167.9602, -1.0000,   12.0282, 201   } -- W3 LW Guild S
mobList[zone][SMB+427].pos = {-103.4151,  2.0000,   -8.4370, 59    } -- W3 Westgate Corner N
mobList[zone][SMB+423].pos = {-125.6019,  1.0000,  -29.4409, 251   } -- W3 Westgate Corner W
mobList[zone][SMB+419].pos = { -85.4643,  1.0000,  -70.9384, 190   } -- W3 Westgate Corner S
mobList[zone][SMB+415].pos = { -62.5682,  2.0000,  -48.1542, 122   } -- W3 Westgate Corner E
mobList[zone][SMB+481].pos = { -38.0342,  0.0000,   12.9522, 0     } -- W3 Victory Square SW
mobList[zone][SMB+475].pos = { -36.9843,  0.0000,   30.0222, 23    } -- W3 Victory Square NW
mobList[zone][SMB+494].pos = {  36.9442,  0.0000,   30.2140, 96    } -- W3 Victory Square NE
mobList[zone][SMB+488].pos = {  37.9635,  0.0000,   12.9962, 127   } -- W3 Victory Square SE
mobList[zone][SMB+501].pos = {   0.0676, -3.0000,  -29.7543, 191   } -- W3 Atop AH
mobList[zone][SMB+451].pos = {  28.3832,  2.2000,  -89.9126, 134   } -- W3 Chocobo Stables Grass N
mobList[zone][SMB+457].pos = {  28.3091,  2.2000,  -94.2068, 142   } -- W3 Chocobo Stables Grass S
mobList[zone][SMB+392].pos = {  75.1727,  2.0000,    4.8686, 32    } -- W3 Beside Street Vendor By Eastgate
mobList[zone][SMB+396].pos = {  61.9606,  2.0000,  -47.8880, 253   } -- W3 Eastegate Corner W
mobList[zone][SMB+408].pos = {  85.3854,  1.0000,  -69.5495, 188   } -- W3 Eastegate Corner S
mobList[zone][SMB+404].pos = { 126.1979,  1.0000,  -29.2587, 126   } -- W3 Eastegate Corner E
mobList[zone][SMB+400].pos = { 103.9707,  2.0000,   -6.3490, 64    } -- W3 Eastegate Corner N
mobList[zone][SMB+384].pos = { 101.5461,  4.0000,   25.6043, 91    } -- W3 Cavalry Way 3-way Intersection
mobList[zone][SMB+380].pos = { 103.6767,  4.0000,   40.9239, 126   } -- W3 Across Rosel's Armour Shop
mobList[zone][SMB+376].pos = {  92.4537,  4.0000,   47.9614, 1     } -- W3 Between Rosel's/Helbort's
mobList[zone][SMB+388].pos = { 133.0893,  0.0000,    9.8870, 193   } -- W3 Cavalry Way Ramp Entrance
mobList[zone][SMB+14 ].pos = { 116.5853,  0.0000,   74.9059, 96    } -- W4 Lion Square Fountain S
mobList[zone][SMB+18 ].pos = { 108.8902,  0.0000,   85.6102, 96    } -- W4 Lion Square Fountain W
mobList[zone][SMB+10 ].pos = { 130.6248, -1.2500,  105.9016, 96    } -- W4 Lion Square Stairs W
mobList[zone][SMB+6  ].pos = { 137.5452, -1.0000,   98.5752, 96    } -- W4 Lion Square Stairs S


-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- add mob patrol paths for statues that are supposed to patrol
-- mobList[zone][mob].patrolPath = { }
--Wave 1 pathing
mobList[zone][SMB+4  ].patrolPath = { 121, 0, 96,		127, 0, 102, 	121, 0, 96  	}
mobList[zone][SMB+8  ].patrolPath = { 128, 0, 89,		134, 0, 95, 	128, 0, 89  	}
mobList[zone][SMB+16 ].patrolPath = { 112, 0, 87,		106, 0, 82, 	112, 0, 87  	}
mobList[zone][SMB+12 ].patrolPath = { 119, 0, 80,		113, 0, 75, 	119, 0, 80  	}
mobList[zone][SMB+25 ].patrolPath = { 98, 4, 68,		98, 4, 62, 	    98, 4, 68   	}
mobList[zone][SMB+42 ].patrolPath = { 98, 4, 16, 		98, 4, 56,		98, 4, 16  		}
mobList[zone][SMB+58 ].patrolPath = { 130, 0, 68, 		152, 0, 45,		130, 0, 68 		}
mobList[zone][SMB+54 ].patrolPath = { 148, 0, 49, 		148, 0, 33,		148, 0, 49 		}
mobList[zone][SMB+60 ].patrolPath = { 146, 0, 30, 		135, 0, 18,		146, 0, 30 		}
mobList[zone][SMB+61 ].patrolPath = { 118, 2, 14, 		133, 0, 14,		118, 2, 14 		}
mobList[zone][SMB+64 ].patrolPath = { 104, 4, 14, 		116, 2, 14,		104, 4, 15 		}
mobList[zone][SMB+71 ].patrolPath = { 93, 4, 14, 		81, 2, 2,		93, 4, 14  		}
mobList[zone][SMB+92 ].patrolPath = { 89, 2, -33, 		83, 2, -27,		89, 2, -33 		}
mobList[zone][SMB+77 ].patrolPath = { 68, 2, -12, 		80, 2, -24,		68, 2, -12 		}
mobList[zone][SMB+95 ].patrolPath = { 75, 2, -35, 		81, 2, -41,		75, 2, -35 		}
mobList[zone][SMB+80 ].patrolPath = { 60, 2, -20, 		72, 2, -32,		60, 2, -20 		}
mobList[zone][SMB+99 ].patrolPath = { 91, 2, -19, 		98, 2, -26,		91, 2, -19 		}
mobList[zone][SMB+74 ].patrolPath = { 76, 2, -4, 		88, 2, -16,		76, 2, -4 		}
mobList[zone][SMB+107].patrolPath = { 5, 2, -74, 		18, 2, -74,		5, 2, -74 		}
mobList[zone][SMB+105].patrolPath = { 2, 2, -74, 	    -12, 2, -74,	2, 2, -74 		}
mobList[zone][SMB+102].patrolPath = { -8, 2, -80, 	    -23, 2, -80,	-8, 2, -80 		}
mobList[zone][SMB+149].patrolPath = { -40, 2, -17,		-40, 2, -38,	-40, 2, -17 	}
mobList[zone][SMB+131].patrolPath = { 40, 2, -17, 		40, 2, -37,		40, 2, -17 		}
mobList[zone][SMB+133].patrolPath = { 25, 2, 23, 		25, 2, 1,		25, 2, 23 		}
mobList[zone][SMB+134].patrolPath = { 34, 2, -18, 		14, 2, -18,		34, 2, -18 		}
mobList[zone][SMB+144].patrolPath = { -34, 2, -18, 		-14, 2, -18,	-34, 2, -18 	}
mobList[zone][SMB+139].patrolPath = { 0, 2, -21, 		0, 2, -4,		0, 2, -21 		}
mobList[zone][SMB+141].patrolPath = { 125, 0, 104, 		129, 0, 100,	125, 0, 104		}
mobList[zone][SMB+142].patrolPath = { 132, 0, 97, 		136, 0, 93,		132, 0, 97 		}
mobList[zone][SMB+175].patrolPath = { 0, 0, 26, 		0, 2, 3,		0, 0, 26 		}
mobList[zone][SMB+180].patrolPath = { 5, 0, 19,         5, 2, -9,       5, 0, 19        } -- Victory Square Main Path E
mobList[zone][SMB+185].patrolPath = { -5, 0, 19,        -5, 2, -9,      -5, 0, 19       } -- Victory Square Main Path W
mobList[zone][SMB+190].patrolPath = { 20, 2, 5,         20, 2, -13,     20, 2, 5        }
mobList[zone][SMB+193].patrolPath = { 20, 0, 24,        20, 2, 8,       20, 0, 24       }
mobList[zone][SMB+199].patrolPath = { -24, 2, 15,       -24, 2, 0,      -24, 2, 15      }
mobList[zone][SMB+196].patrolPath = { -20, 2, 5,        -20, 2, -13,    -20, 2, 5       }
mobList[zone][SMB+243].patrolPath = { -96, -2, 16, 		-84, 2, 4,		-96, -2, 16 	} 
mobList[zone][SMB+217].patrolPath = { -80, 2, -24, 		-68, 2, -12,	-80, 2, -24 	}
mobList[zone][SMB+214].patrolPath = { -72, 2, -32, 		-60, 2, -20,	-72, 2, -32 	}
mobList[zone][SMB+222].patrolPath = { -88, 2, -16, 		-76, 2, -4,	    -88, 2, -16 	}
mobList[zone][SMB+257].patrolPath = { -91, 2, -19, 		-99, 2, -27,	-91, 2, -19 	}
mobList[zone][SMB+258].patrolPath = { -83, 2, -27, 		-91, 2, -35,	-83, 2, -27 	}
mobList[zone][SMB+259].patrolPath = { -75, 2, -35, 		-83, 2, -43,	-75, 2, -35 	}
mobList[zone][SMB+261].patrolPath = { -118, -2, 12, 	-99, -2, 27,	-118, -2, 12 	}
mobList[zone][SMB+264].patrolPath = { -118, -2, 18, 	-136, -2, 18,	-118, -2, 18 	}
mobList[zone][SMB+267].patrolPath = { -140, -2, 18, 	-163, -1, 18,	-140, -2, 18 	}
mobList[zone][SMB+293].patrolPath = { -190, -1, 43, 	-193, -1, 55,	-190, -1, 43 	}
mobList[zone][SMB+298].patrolPath = { -194, -2, 61, 	-194, -2, 78,	-194, -2, 61 	}
mobList[zone][SMB+313].patrolPath = { -194, -2, 80, 	-212, -2, 98,	-194, -2, 80 	}
mobList[zone][SMB+316].patrolPath = { -231, -2, 98, 	-213, -2, 98,	-231, -2, 98 	}
mobList[zone][SMB+320].patrolPath = { -240, -4, 98, 	-260, -4, 98,	-240, -4, 98 	}
mobList[zone][SMB+330].patrolPath = { -94, -6, 74, 		-104, -6, 84,	-94, -6, 74 	}
mobList[zone][SMB+335].patrolPath = { -90, -6, 57, 		-93, -6, 71,	-90, -6, 57 	}
mobList[zone][SMB+340].patrolPath = { -132, -4, 72, 	-132, -4, 63,	-132, -4, 72 	}
mobList[zone][SMB+345].patrolPath = { -106, -6, 88, 	-128, -6, 88,	-106, -6, 88 	}
mobList[zone][SMB+346].patrolPath = { -90, -4, 46, 	    -90, -4, 56,    -90, -4, 46 	}
mobList[zone][SMB+349].patrolPath = { -101, 2, 34, 	    -91, 4, 44,	    -101, 2, 34 	}
mobList[zone][SMB+352].patrolPath = { -144, -2, 60,	    -154, -2, 60,	-144, -2, 60 	}
mobList[zone][SMB+360].patrolPath = { -169, -2, 60, 	-156, -2, 60,	-169, -2, 60 	}


--Wave 2 pathing
mobList[zone][SMB+309].patrolPath = { -212, -2, 96, 	-229, -2, 98,	-212, -2, 96 	}
mobList[zone][SMB+305].patrolPath = { -200, -2, 87, 	-193, -2, 69,	-200, -2, 87 	}
mobList[zone][SMB+18 ].patrolPath = {  110, 0, 80, 	     104, 0, 87,	 110, 0, 80 	}
mobList[zone][SMB+14 ].patrolPath = {  118, 0, 71, 	     112, 0, 78,	 118, 0, 71 	}
mobList[zone][SMB+10 ].patrolPath = {  132, -1, 103, 	 128, -1, 107,	 132, -1, 103 	}
mobList[zone][SMB+6  ].patrolPath = {  135, -1, 100, 	 139, -1, 96,	 135, -1, 100 	}


-- set statue eye color
mobList[zone][SMB+20 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+24 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+28 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+31 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+39 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+61 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+64 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+77 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+152].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+87 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+101].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+134].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+139].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+144].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+124].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+175].eyes = dynamis.eyes.RED
mobList[zone][SMB+112].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+113].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+153].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+217].eyes = dynamis.eyes.RED
mobList[zone][SMB+246].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+260].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+243].eyes = dynamis.eyes.RED
mobList[zone][SMB+237].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+264].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+267].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+286].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+273].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+278].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+292].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+291].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+316].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+320].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+368].eyes = dynamis.eyes.RED
mobList[zone][SMB+349].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+346].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+345].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+365].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+357].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+157].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+164].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+174].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+173].eyes = dynamis.eyes.BLUE

-- set time extensions
mobList[zone][SMB+24 ].timeExtension = 15 -- Serjeant Tombstone
mobList[zone][SMB+28 ].timeExtension = 15 -- Serjeant Tombstone
mobList[zone][SMB+77 ].timeExtension = 25 -- Serjeant Tombstone
mobList[zone][SMB+175].timeExtension = 30 -- Serjeant Tombstone
mobList[zone][SMB+217].timeExtension = 25 -- Serjeant Tombstone
mobList[zone][SMB+243].timeExtension = 10 -- Warchief Tombstone
mobList[zone][DMB+68 ].timeExtension = 30 -- Voidstreaker Butchnotch

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+68 } -- kill Voidstreaker to spawn random statues
mobList[zone].waveDefeatRequirements[3] = { DMB+1 } -- megaboss kill does a mass repop of the zone
mobList[zone].waveDefeatRequirements[4] = { DMB+30, DMB+56 } -- kill of Wyrmgnasher Bjakdek and Reapertongue_Gadgquok to spawn Overlords Tombstone

-- miniWave is used when the same mobID needs to be used twice for a spawn wave or smaller size-waves
mobList[zone][DMB+30].miniWave = { SMB+14, SMB+18 } -- Kill of Reapertongue_Gadgquok spawns 2x statue near entrance
mobList[zone][DMB+56].miniWave = { SMB+10, SMB+6 } -- kill of Wyrmgnasher Bjakdek spawns 2x statue near entrance

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+4  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+8  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+12 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+16 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+20 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+24 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+25 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+28 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+31 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+42 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+39 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+34 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+58 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+59 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+54 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+60 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+61 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+64 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+69 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+71 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+67 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+152].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+74 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+77 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+80 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+92 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+87 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+98 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+100].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+101].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+131].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+134].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+139].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+144].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+149].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+118].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+114].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+121].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+127].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+124].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+129].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+190].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+196].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+199].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+193].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+175].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+180].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+185].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+107].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+102].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+105].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+109].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+112].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+113].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+153].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+227].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+222].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+217].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+214].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+259].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+258].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+257].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+246].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+251].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+254].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+260].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+243].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+234].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+231].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+261].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+237].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+264].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+267].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+270].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+283].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+286].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+273].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+278].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+292].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+291].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+293].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+298].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+313].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+301].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+316].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+320].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+368].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+349].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+346].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+335].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+330].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+345].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+323].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+365].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+340].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+352].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+360].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+357].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+309].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+305].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+207].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+202].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+83 ].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+444].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+469].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+464].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+439].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+432].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+427].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+423].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+419].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+415].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+481].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+475].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+494].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+488].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+501].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+451].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+457].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+392].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+396].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+408].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+404].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+400].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+384].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+380].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+376].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+388].waves = { nil,nil, 3 ,nil  }
mobList[zone][DMB+1  ].waves = { nil,nil,nil, 4   }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues) boolean value = forceLink enabled yes/no (default no if unspecified)
mobList[zone][SMB+58 ].specificChildren = { SMB+45 } -- Squire Square N, Spawns another statue
mobList[zone][SMB+59 ].specificChildren = { SMB+50 } -- Squire Square E, Spawns another statue
mobList[zone][SMB+87 ].specificChildren = { true, DMB+56 } -- Eastgate NM Wyrmgnasher Bjakdek (DRG)
mobList[zone][SMB+246].specificChildren = { true, DMB+30 } -- Westgate NM Reapertongue Gadguok (SMN)
mobList[zone][SMB+368].specificChildren = { true, DMB+68, SMB+370, SMB+373 } -- Manor NM Voidstreaker Butchnotch (NIN) as well as N/S manor pop statues
mobList[zone][SMB+340].specificChildren = { true, SMB+341, SMB+343 } -- Courtyard/WD Alley connector +2 stats
mobList[zone][DMB+1  ].specificChildren = { true, DMB+2, DMB+3, SMB+157, SMB+164, SMB+171, SMB+172 } -- Megaboss spawns twin BRD NMs Battlechoir Gitchfotch and Soulsender Fugbrag and a bunch of statues
mobList[zone][SMB+172].specificChildren = { true, SMB+174 } -- Megaboss's W statue spawns an extra blue eyes
mobList[zone][SMB+171].specificChildren = { true, SMB+173 } -- Megaboss's E statue spawns an extra blue eyes
mobList[zone][SMB+207].specificChildren = { SMB+212, SMB+213 } -- W3 W Tent Pops 2 stats Btw. Tents

-- set how many mobs pop from each statue
mobList[zone][SMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+4  ].randomChildrenCount = 1
mobList[zone][SMB+6  ].randomChildrenCount = 1
mobList[zone][SMB+8  ].randomChildrenCount = 1
mobList[zone][SMB+10 ].randomChildrenCount = 1
mobList[zone][SMB+12 ].randomChildrenCount = 1
mobList[zone][SMB+14 ].randomChildrenCount = 1
mobList[zone][SMB+16 ].randomChildrenCount = 1
mobList[zone][SMB+18 ].randomChildrenCount = 1
mobList[zone][SMB+20 ].randomChildrenCount = 3
mobList[zone][SMB+24 ].randomChildrenCount = 0
mobList[zone][SMB+25 ].randomChildrenCount = 2
mobList[zone][SMB+28 ].randomChildrenCount = 2
mobList[zone][SMB+31 ].randomChildrenCount = 2
mobList[zone][SMB+34 ].randomChildrenCount = 2
mobList[zone][SMB+39 ].randomChildrenCount = 2
mobList[zone][SMB+42 ].randomChildrenCount = 2
mobList[zone][SMB+45 ].randomChildrenCount = 3
mobList[zone][SMB+50 ].randomChildrenCount = 3
mobList[zone][SMB+54 ].randomChildrenCount = 3
mobList[zone][SMB+58 ].randomChildrenCount = 0
mobList[zone][SMB+59 ].randomChildrenCount = 0
mobList[zone][SMB+60 ].randomChildrenCount = 0
mobList[zone][SMB+61 ].randomChildrenCount = 2
mobList[zone][SMB+64 ].randomChildrenCount = 2
mobList[zone][SMB+67 ].randomChildrenCount = 1
mobList[zone][SMB+69 ].randomChildrenCount = 1
mobList[zone][SMB+71 ].randomChildrenCount = 2
mobList[zone][SMB+74 ].randomChildrenCount = 2
mobList[zone][SMB+77 ].randomChildrenCount = 2
mobList[zone][SMB+80 ].randomChildrenCount = 2
mobList[zone][SMB+83 ].randomChildrenCount = 3
mobList[zone][SMB+87 ].randomChildrenCount = 2
mobList[zone][SMB+92 ].randomChildrenCount = 2
mobList[zone][SMB+95 ].randomChildrenCount = 2
mobList[zone][SMB+98 ].randomChildrenCount = 0
mobList[zone][SMB+99 ].randomChildrenCount = 0
mobList[zone][SMB+100].randomChildrenCount = 0
mobList[zone][SMB+101].randomChildrenCount = 0
mobList[zone][SMB+102].randomChildrenCount = 2
mobList[zone][SMB+105].randomChildrenCount = 1
mobList[zone][SMB+107].randomChildrenCount = 1
mobList[zone][SMB+109].randomChildrenCount = 2
mobList[zone][SMB+112].randomChildrenCount = 0
mobList[zone][SMB+113].randomChildrenCount = 0
mobList[zone][SMB+114].randomChildrenCount = 3
mobList[zone][SMB+118].randomChildrenCount = 2
mobList[zone][SMB+121].randomChildrenCount = 2
mobList[zone][SMB+124].randomChildrenCount = 2
mobList[zone][SMB+127].randomChildrenCount = 1
mobList[zone][SMB+129].randomChildrenCount = 1
mobList[zone][SMB+131].randomChildrenCount = 2
mobList[zone][SMB+134].randomChildrenCount = 2
mobList[zone][SMB+139].randomChildrenCount = 2
mobList[zone][SMB+144].randomChildrenCount = 2
mobList[zone][SMB+149].randomChildrenCount = 2
mobList[zone][SMB+152].randomChildrenCount = 0
mobList[zone][SMB+153].randomChildrenCount = 0
mobList[zone][SMB+157].randomChildrenCount = 3
mobList[zone][SMB+164].randomChildrenCount = 3
mobList[zone][SMB+171].randomChildrenCount = 0
mobList[zone][SMB+172].randomChildrenCount = 0
mobList[zone][SMB+173].randomChildrenCount = 0
mobList[zone][SMB+174].randomChildrenCount = 0
mobList[zone][SMB+175].randomChildrenCount = 2
mobList[zone][SMB+180].randomChildrenCount = 2
mobList[zone][SMB+185].randomChildrenCount = 2
mobList[zone][SMB+190].randomChildrenCount = 2
mobList[zone][SMB+193].randomChildrenCount = 2
mobList[zone][SMB+196].randomChildrenCount = 2
mobList[zone][SMB+199].randomChildrenCount = 2
mobList[zone][SMB+202].randomChildrenCount = 2
mobList[zone][SMB+207].randomChildrenCount = 2
mobList[zone][SMB+212].randomChildrenCount = 0
mobList[zone][SMB+213].randomChildrenCount = 0
mobList[zone][SMB+214].randomChildrenCount = 2
mobList[zone][SMB+217].randomChildrenCount = 2
mobList[zone][SMB+222].randomChildrenCount = 2
mobList[zone][SMB+227].randomChildrenCount = 3
mobList[zone][SMB+231].randomChildrenCount = 2
mobList[zone][SMB+234].randomChildrenCount = 2
mobList[zone][SMB+237].randomChildrenCount = 5
mobList[zone][SMB+243].randomChildrenCount = 2
mobList[zone][SMB+246].randomChildrenCount = 2
mobList[zone][SMB+251].randomChildrenCount = 2
mobList[zone][SMB+254].randomChildrenCount = 2
mobList[zone][SMB+257].randomChildrenCount = 0
mobList[zone][SMB+258].randomChildrenCount = 0
mobList[zone][SMB+259].randomChildrenCount = 0
mobList[zone][SMB+260].randomChildrenCount = 0
mobList[zone][SMB+261].randomChildrenCount = 2
mobList[zone][SMB+264].randomChildrenCount = 2
mobList[zone][SMB+267].randomChildrenCount = 2
mobList[zone][SMB+270].randomChildrenCount = 2
mobList[zone][SMB+273].randomChildrenCount = 2
mobList[zone][SMB+278].randomChildrenCount = 2
mobList[zone][SMB+283].randomChildrenCount = 1
mobList[zone][SMB+286].randomChildrenCount = 2
mobList[zone][SMB+291].randomChildrenCount = 0
mobList[zone][SMB+292].randomChildrenCount = 0
mobList[zone][SMB+293].randomChildrenCount = 4
mobList[zone][SMB+298].randomChildrenCount = 2
mobList[zone][SMB+301].randomChildrenCount = 3
mobList[zone][SMB+305].randomChildrenCount = 3
mobList[zone][SMB+309].randomChildrenCount = 3
mobList[zone][SMB+313].randomChildrenCount = 2
mobList[zone][SMB+316].randomChildrenCount = 3
mobList[zone][SMB+320].randomChildrenCount = 2
mobList[zone][SMB+323].randomChildrenCount = 4
mobList[zone][SMB+330].randomChildrenCount = 4
mobList[zone][SMB+335].randomChildrenCount = 4
mobList[zone][SMB+340].randomChildrenCount = 0
mobList[zone][SMB+341].randomChildrenCount = 1
mobList[zone][SMB+343].randomChildrenCount = 1
mobList[zone][SMB+345].randomChildrenCount = 0
mobList[zone][SMB+346].randomChildrenCount = 2
mobList[zone][SMB+349].randomChildrenCount = 2
mobList[zone][SMB+352].randomChildrenCount = 2
mobList[zone][SMB+357].randomChildrenCount = 2
mobList[zone][SMB+360].randomChildrenCount = 2
mobList[zone][SMB+365].randomChildrenCount = 2
mobList[zone][SMB+368].randomChildrenCount = 0
mobList[zone][SMB+370].randomChildrenCount = 2
mobList[zone][SMB+373].randomChildrenCount = 2
mobList[zone][SMB+376].randomChildrenCount = 3
mobList[zone][SMB+380].randomChildrenCount = 3
mobList[zone][SMB+384].randomChildrenCount = 3
mobList[zone][SMB+388].randomChildrenCount = 3
mobList[zone][SMB+392].randomChildrenCount = 3
mobList[zone][SMB+396].randomChildrenCount = 3
mobList[zone][SMB+400].randomChildrenCount = 3
mobList[zone][SMB+404].randomChildrenCount = 3
mobList[zone][SMB+408].randomChildrenCount = 3
mobList[zone][SMB+415].randomChildrenCount = 3
mobList[zone][SMB+419].randomChildrenCount = 3
mobList[zone][SMB+423].randomChildrenCount = 3
mobList[zone][SMB+427].randomChildrenCount = 4
mobList[zone][SMB+432].randomChildrenCount = 2
mobList[zone][SMB+439].randomChildrenCount = 3
mobList[zone][SMB+444].randomChildrenCount = 4
mobList[zone][SMB+451].randomChildrenCount = 5
mobList[zone][SMB+457].randomChildrenCount = 6
mobList[zone][SMB+464].randomChildrenCount = 4
mobList[zone][SMB+469].randomChildrenCount = 5
mobList[zone][SMB+475].randomChildrenCount = 5
mobList[zone][SMB+481].randomChildrenCount = 3
mobList[zone][SMB+488].randomChildrenCount = 5
mobList[zone][SMB+494].randomChildrenCount = 6
mobList[zone][SMB+501].randomChildrenCount = 3
mobList[zone][DMB+1  ].randomChildrenCount = 0


-- set which mobs will spawn from each statue
mobList[zone][SMB+1  ].randomChildrenList = { 5, 5 }
mobList[zone][DMB+1  ].randomChildrenList = { 5, 5 }
mobList[zone][SMB+4  ].randomChildrenList = { 6 }
mobList[zone][SMB+6  ].randomChildrenList = { 7 }
mobList[zone][SMB+8  ].randomChildrenList = { 6 }
mobList[zone][SMB+10 ].randomChildrenList = { 7 }
mobList[zone][SMB+12 ].randomChildrenList = { 15 }
mobList[zone][SMB+14 ].randomChildrenList = { 6 }
mobList[zone][SMB+16 ].randomChildrenList = { 15 }
mobList[zone][SMB+18 ].randomChildrenList = { 6 }
mobList[zone][SMB+20 ].randomChildrenList = { 6, 6, 6 }
mobList[zone][SMB+25 ].randomChildrenList = { 14, 11 }
mobList[zone][SMB+28 ].randomChildrenList = { 5, 5 }
mobList[zone][SMB+31 ].randomChildrenList = { 15, 15 }
mobList[zone][SMB+34 ].randomChildrenList = { 9, 9 }
mobList[zone][SMB+39 ].randomChildrenList = { 1, 1 }
mobList[zone][SMB+42 ].randomChildrenList = { 12, 12 }
mobList[zone][SMB+45 ].randomChildrenList = { 8, 10, 10 }
mobList[zone][SMB+50 ].randomChildrenList = { 14, 13, 13 }
mobList[zone][SMB+54 ].randomChildrenList = { 6, 10, 10 }
mobList[zone][SMB+61 ].randomChildrenList = { 7, 7 }
mobList[zone][SMB+64 ].randomChildrenList = { 2, 2 }
mobList[zone][SMB+67 ].randomChildrenList = { 12 }
mobList[zone][SMB+69 ].randomChildrenList = { 12 }
mobList[zone][SMB+71 ].randomChildrenList = { 1, 10 }
mobList[zone][SMB+99 ].randomChildrenList = { 12, 3 } -- Changed to SMB+99 as per era video (map doesnt show correct positions)
mobList[zone][SMB+92 ].randomChildrenList = { 12, 3 } -- Changed to SMB+92 as per era video (map doesnt show correct positions)
mobList[zone][SMB+95 ].randomChildrenList = { 12, 3 } -- Changed to SMB+95 as per era video (map doesnt show correct positions)
mobList[zone][SMB+83 ].randomChildrenList = { 12, 12, 3 }
mobList[zone][SMB+87 ].randomChildrenList = { 11, 11 }
mobList[zone][SMB+92 ].randomChildrenList = { 13, 13 }
mobList[zone][SMB+95 ].randomChildrenList = { 1, 1 }
mobList[zone][SMB+102].randomChildrenList = { 12, 12 }
mobList[zone][SMB+105].randomChildrenList = { 1 }
mobList[zone][SMB+107].randomChildrenList = { 1 }
mobList[zone][SMB+109].randomChildrenList = { 14, 14 }
mobList[zone][SMB+114].randomChildrenList = { 14, 5, 5 }
mobList[zone][SMB+118].randomChildrenList = { 6, 5 }
mobList[zone][SMB+121].randomChildrenList = { 6, 5 }
mobList[zone][SMB+124].randomChildrenList = { 13, 13 }
mobList[zone][SMB+127].randomChildrenList = { 1 }
mobList[zone][SMB+129].randomChildrenList = { 1 }
mobList[zone][SMB+131].randomChildrenList = { 7, 7 }
mobList[zone][SMB+134].randomChildrenList = { 8, 8 }
mobList[zone][SMB+139].randomChildrenList = { 4, 4 }
mobList[zone][SMB+144].randomChildrenList = { 8, 8 }
mobList[zone][SMB+149].randomChildrenList = { 7, 7 }
mobList[zone][SMB+157].randomChildrenList = { 9, 9, 9 }
mobList[zone][SMB+164].randomChildrenList = { 4, 4, 4 }
mobList[zone][SMB+175].randomChildrenList = { 4, 4 }
mobList[zone][SMB+180].randomChildrenList = { 4, 4 }
mobList[zone][SMB+185].randomChildrenList = { 4, 4 }
mobList[zone][SMB+190].randomChildrenList = { 13, 13 }
mobList[zone][SMB+193].randomChildrenList = { 2, 2 }
mobList[zone][SMB+196].randomChildrenList = { 2, 2 }
mobList[zone][SMB+199].randomChildrenList = { 13, 13 }
mobList[zone][SMB+202].randomChildrenList = { 4, 4 }
mobList[zone][SMB+207].randomChildrenList = { 4, 4 }
mobList[zone][SMB+259].randomChildrenList = { 11, 11 }
mobList[zone][SMB+258].randomChildrenList = { 9, 9 }
mobList[zone][SMB+257].randomChildrenList = { 8, 8 }
mobList[zone][SMB+227].randomChildrenList = { 6, 6, 3 }
mobList[zone][SMB+231].randomChildrenList = { 2, 2 }
mobList[zone][SMB+234].randomChildrenList = { 7, 7 }
mobList[zone][SMB+237].randomChildrenList = { 1, 1, 13, 13, 13 }
mobList[zone][SMB+243].randomChildrenList = { 7, 2 }
mobList[zone][SMB+246].randomChildrenList = { 6, 6 }
mobList[zone][SMB+251].randomChildrenList = { 15, 15 }
mobList[zone][SMB+254].randomChildrenList = { 10, 10 }
mobList[zone][SMB+261].randomChildrenList = { 11, 11 }
mobList[zone][SMB+264].randomChildrenList = { 10, 10 }
mobList[zone][SMB+267].randomChildrenList = { 1, 1 }
mobList[zone][SMB+270].randomChildrenList = { 15, 15 }
mobList[zone][SMB+273].randomChildrenList = { 8, 8 }
mobList[zone][SMB+278].randomChildrenList = { 8, 8 }
mobList[zone][SMB+283].randomChildrenList = { 8 }
mobList[zone][SMB+286].randomChildrenList = { 8, 8 }
mobList[zone][SMB+293].randomChildrenList = { 15, 15, 10, 10 }
mobList[zone][SMB+298].randomChildrenList = { 14, 14 }
mobList[zone][SMB+301].randomChildrenList = { 13, 13, 13 }
mobList[zone][SMB+305].randomChildrenList = { 14, 14, 14 }
mobList[zone][SMB+309].randomChildrenList = { 11, 11, 11 }
mobList[zone][SMB+313].randomChildrenList = { 11, 11 }
mobList[zone][SMB+316].randomChildrenList = { 15, 5, 5 }
mobList[zone][SMB+320].randomChildrenList = { 3, 3 }
mobList[zone][SMB+323].randomChildrenList = { 9, 9, 5, 5 }
mobList[zone][SMB+330].randomChildrenList = { 11, 11, 15, 15 }
mobList[zone][SMB+335].randomChildrenList = { 5, 5, 14, 14 }
mobList[zone][SMB+341].randomChildrenList = { 3 }
mobList[zone][SMB+343].randomChildrenList = { 3 }
mobList[zone][SMB+346].randomChildrenList = { 2, 2 }
mobList[zone][SMB+349].randomChildrenList = { 7, 7 }
mobList[zone][SMB+352].randomChildrenList = { 9, 9 }
mobList[zone][SMB+357].randomChildrenList = { 13, 13 }
mobList[zone][SMB+360].randomChildrenList = { 9, 9 }
mobList[zone][SMB+365].randomChildrenList = { 14, 14 }
mobList[zone][SMB+370].randomChildrenList = { 2, 2 }
mobList[zone][SMB+373].randomChildrenList = { 2, 2 }
mobList[zone][SMB+376].randomChildrenList = { 5, 5, 5 }
mobList[zone][SMB+380].randomChildrenList = { 6, 6, 6 }
mobList[zone][SMB+384].randomChildrenList = { 1, 1, 1 }
mobList[zone][SMB+388].randomChildrenList = { 10, 10, 10 }
mobList[zone][SMB+392].randomChildrenList = { 15, 15, 15 }
mobList[zone][SMB+396].randomChildrenList = { 12, 12, 12 }
mobList[zone][SMB+400].randomChildrenList = { 14, 14, 14 }
mobList[zone][SMB+404].randomChildrenList = { 11, 11, 11 }
mobList[zone][SMB+408].randomChildrenList = { 8, 8, 8 }
mobList[zone][SMB+415].randomChildrenList = { 3, 3, 3 }
mobList[zone][SMB+419].randomChildrenList = { 13, 13, 13 }
mobList[zone][SMB+423].randomChildrenList = { 7, 7, 7 }
mobList[zone][SMB+427].randomChildrenList = { 2, 2, 2, 2 }
mobList[zone][SMB+432].randomChildrenList = { 9, 9, 9 }
mobList[zone][SMB+439].randomChildrenList = { 4, 4 }
mobList[zone][SMB+444].randomChildrenList = { 4, 4, 3, 3 }
mobList[zone][SMB+451].randomChildrenList = { 12, 12, 12, 3, 3 }
mobList[zone][SMB+457].randomChildrenList = { 7, 7, 15, 15, 10, 10 }
mobList[zone][SMB+464].randomChildrenList = { 5, 5, 1, 1 }
mobList[zone][SMB+469].randomChildrenList = { 6, 6, 6, 1, 1 }
mobList[zone][SMB+475].randomChildrenList = { 11, 11, 11, 10, 10 }
mobList[zone][SMB+481].randomChildrenList = { 8, 8, 8 }
mobList[zone][SMB+488].randomChildrenList = { 14, 14, 14, 12, 12 }
mobList[zone][SMB+494].randomChildrenList = { 7, 7, 15, 15, 3, 3 }
mobList[zone][SMB+501].randomChildrenList = { 9, 9, 9 }

-- random children list - groups assigned to specific mob groups
randomChildrenList[zone] =
{
    [1] = -- Vanguard_Amputator
    {
        DMB+6, -- Vanguard_Amputator
        DMB+33, -- Vanguard_Amputator
        DMB+42, -- Vanguard_Amputator
        DMB+69, -- Vanguard_Amputator
        DMB+84, -- Vanguard_Amputator
        DMB+110, -- Vanguard_Amputator
        DMB+123, -- Vanguard_Amputator
        DMB+141, -- Vanguard_Amputator
        DMB+165, -- Vanguard_Amputator
        DMB+207, -- Vanguard_Amputator
        DMB+208, -- Vanguard_Amputator
        DMB+219, -- Vanguard_Amputator
        DMB+220, -- Vanguard_Amputator
    },

    [2] = -- Vanguard_Backstabber
    {
        DMB+17, -- Vanguard_Backstabber
        DMB+37, -- Vanguard_Backstabber
        DMB+55, -- Vanguard_Backstabber
        DMB+65, -- Vanguard_Backstabber
        DMB+95, -- Vanguard_Backstabber
        DMB+107, -- Vanguard_Backstabber
        DMB+114, -- Vanguard_Backstabber
        DMB+126, -- Vanguard_Backstabber
        DMB+136, -- Vanguard_Backstabber
        DMB+147, -- Vanguard_Backstabber
        DMB+199, -- Vanguard_Backstabber
        DMB+200, -- Vanguard_Backstabber
    },

    [3] = -- Vanguard_Bugler
    {
        DMB+13, -- Vanguard_Bugler
        DMB+46, -- Vanguard_Bugler
        DMB+51, -- Vanguard_Bugler
        DMB+72, -- Vanguard_Bugler
        DMB+76, -- Vanguard_Bugler
        DMB+92, -- Vanguard_Bugler
        DMB+102, -- Vanguard_Bugler
        DMB+112, -- Vanguard_Bugler
        DMB+124, -- Vanguard_Bugler
        DMB+142, -- Vanguard_Bugler
        DMB+213, -- Vanguard_Bugler
        DMB+214, -- Vanguard_Bugler
        DMB+225, -- Vanguard_Bugler
        DMB+226, -- Vanguard_Bugler
    },

    [4] = -- Vanguard_Dollmaster
    {
        DMB+20, -- Vanguard_Dollmaster
        DMB+34, -- Vanguard_Dollmaster
        DMB+73, -- Vanguard_Dollmaster
        DMB+98, -- Vanguard_Dollmaster
        DMB+134, -- Vanguard_Dollmaster
        DMB+205, -- Vanguard_Dollmaster
        DMB+215, -- Vanguard_Dollmaster
        DMB+227, -- Vanguard_Dollmaster
    },

    [5] = -- Vanguard_Footsoldier
    {
        DMB+4, -- Vanguard_Footsoldier
        DMB+24, -- Vanguard_Footsoldier
        DMB+36, -- Vanguard_Footsoldier
        DMB+40, -- Vanguard_Footsoldier
        DMB+58, -- Vanguard_Footsoldier
        DMB+82, -- Vanguard_Footsoldier
        DMB+109, -- Vanguard_Footsoldier
        DMB+122, -- Vanguard_Footsoldier
        DMB+140, -- Vanguard_Footsoldier
        DMB+158, -- Vanguard_Footsoldier
        DMB+164, -- Vanguard_Footsoldier
        DMB+168, -- Vanguard_Footsoldier
        DMB+180, -- Vanguard_Footsoldier
        DMB+194, -- Vanguard_Footsoldier
    },

    [6] = -- Vanguard_Grappler
    {
        DMB+10, -- Vanguard_Grappler
        DMB+25, -- Vanguard_Grappler
        DMB+41, -- Vanguard_Grappler
        DMB+59, -- Vanguard_Grappler
        DMB+83, -- Vanguard_Grappler
        DMB+103, -- Vanguard_Grappler
        DMB+115, -- Vanguard_Grappler
        DMB+127, -- Vanguard_Grappler
        DMB+148, -- Vanguard_Grappler
        DMB+169, -- Vanguard_Grappler
        DMB+181, -- Vanguard_Grappler
        DMB+201, -- Vanguard_Grappler
    },

    [7] = -- Vanguard_Gutslasher
    {
        DMB+14, -- Vanguard_Gutslasher
        DMB+54, -- Vanguard_Gutslasher
        DMB+64, -- Vanguard_Gutslasher
        DMB+94, -- Vanguard_Gutslasher
        DMB+106, -- Vanguard_Gutslasher
        DMB+116, -- Vanguard_Gutslasher
        DMB+128, -- Vanguard_Gutslasher
        DMB+167, -- Vanguard_Gutslasher
        DMB+192, -- Vanguard_Gutslasher
        DMB+193, -- Vanguard_Gutslasher
    },

    [8] = -- Vanguard_Hawker
    {
        DMB+18, -- Vanguard_Hawker
        DMB+52, -- Vanguard_Hawker
        DMB+90, -- Vanguard_Hawker
        DMB+100, -- Vanguard_Hawker
        DMB+118, -- Vanguard_Hawker
        DMB+173, -- Vanguard_Hawker
        DMB+185, -- Vanguard_Hawker
        DMB+197, -- Vanguard_Hawker
    },

    [9] = -- Vanguard_Impaler
    {
        DMB+15, -- Vanguard_Impaler
        DMB+38, -- Vanguard_Impaler
        DMB+66, -- Vanguard_Impaler
        DMB+96, -- Vanguard_Impaler
        DMB+120, -- Vanguard_Impaler
        DMB+176, -- Vanguard_Impaler
        DMB+188, -- Vanguard_Impaler
        DMB+203, -- Vanguard_Impaler
    },

    [10] = -- Vanguard_Mesmerizer
    {
        DMB+9, -- Vanguard_Mesmerizer
        DMB+12, -- Vanguard_Mesmerizer
        DMB+70, -- Vanguard_Mesmerizer
        DMB+75, -- Vanguard_Mesmerizer
        DMB+85, -- Vanguard_Mesmerizer
        DMB+104, -- Vanguard_Mesmerizer
        DMB+131, -- Vanguard_Mesmerizer
        DMB+157, -- Vanguard_Mesmerizer
        DMB+209, -- Vanguard_Mesmerizer
        DMB+210, -- Vanguard_Mesmerizer
        DMB+221, -- Vanguard_Mesmerizer
        DMB+222, -- Vanguard_Mesmerizer
    },

    [11] = -- Vanguard_Neckchopper
    {
        DMB+11, -- Vanguard_Neckchopper
        DMB+44, -- Vanguard_Neckchopper
        DMB+62, -- Vanguard_Neckchopper
        DMB+77, -- Vanguard_Neckchopper
        DMB+89, -- Vanguard_Neckchopper
        DMB+111, -- Vanguard_Neckchopper
        DMB+133, -- Vanguard_Neckchopper
        DMB+146, -- Vanguard_Neckchopper
        DMB+172, -- Vanguard_Neckchopper
        DMB+184, -- Vanguard_Neckchopper
        DMB+196, -- Vanguard_Neckchopper
    },

    [12] = -- Vanguard_Pillager
    {
        DMB+8, -- Vanguard_Pillager
        DMB+45, -- Vanguard_Pillager
        DMB+60, -- Vanguard_Pillager
        DMB+78, -- Vanguard_Pillager
        DMB+87, -- Vanguard_Pillager
        DMB+105, -- Vanguard_Pillager
        DMB+159, -- Vanguard_Pillager
        DMB+170, -- Vanguard_Pillager
        DMB+182, -- Vanguard_Pillager
        DMB+195, -- Vanguard_Pillager
    },

    [13] = -- Vanguard_Predator
    {
        DMB+23, -- Vanguard_Predator
        DMB+26, -- Vanguard_Predator
        DMB+47, -- Vanguard_Predator
        DMB+63, -- Vanguard_Predator
        DMB+93, -- Vanguard_Predator
        DMB+113, -- Vanguard_Predator
        DMB+117, -- Vanguard_Predator
        DMB+125, -- Vanguard_Predator
        DMB+130, -- Vanguard_Predator
        DMB+143, -- Vanguard_Predator
        DMB+144, -- Vanguard_Predator
        DMB+160, -- Vanguard_Predator
        DMB+175, -- Vanguard_Predator
        DMB+187, -- Vanguard_Predator
    },

    [14] = -- Vanguard_Trooper
    {
        DMB+5, -- Vanguard_Trooper
        DMB+32, -- Vanguard_Trooper
        DMB+43, -- Vanguard_Trooper
        DMB+49, -- Vanguard_Trooper
        DMB+61, -- Vanguard_Trooper
        DMB+80, -- Vanguard_Trooper
        DMB+88, -- Vanguard_Trooper
        DMB+108, -- Vanguard_Trooper
        DMB+129, -- Vanguard_Trooper
        DMB+149, -- Vanguard_Trooper
        DMB+151, -- Vanguard_Trooper
        DMB+154, -- Vanguard_Trooper
        DMB+162, -- Vanguard_Trooper
        DMB+166, -- Vanguard_Trooper
        DMB+171, -- Vanguard_Trooper
        DMB+183, -- Vanguard_Trooper
        DMB+202, -- Vanguard_Trooper
    },

    [15] = -- Vanguard_Vexer
    {
        DMB+7, -- Vanguard_Vexer
        DMB+22, -- Vanguard_Vexer
        DMB+48, -- Vanguard_Vexer
        DMB+71, -- Vanguard_Vexer
        DMB+79, -- Vanguard_Vexer
        DMB+86, -- Vanguard_Vexer
        DMB+132, -- Vanguard_Vexer
        DMB+145, -- Vanguard_Vexer
        DMB+150, -- Vanguard_Vexer
        DMB+153, -- Vanguard_Vexer
        DMB+156, -- Vanguard_Vexer
        DMB+161, -- Vanguard_Vexer
        DMB+211, -- Vanguard_Vexer
        DMB+212, -- Vanguard_Vexer
        DMB+223, -- Vanguard_Vexer
        DMB+224, -- Vanguard_Vexer
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] =
{

}
