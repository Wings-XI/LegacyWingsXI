-----------------------------------
--
-- Dynamis-Xarcabard
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_XARCABARD
local DMB = 17330176 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17330810 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] =
{
    [17330177] = { id = DMB+1 }, -- Dynamis Lord
    [17330178] = { id = DMB+2 }, -- Dynamis Lord
    [17330179] = { id = DMB+3 }, -- Dynamis Lord
    [17330180] = { id = DMB+4 }, -- Dynamis Lord
    [17330181] = { id = DMB+5 }, -- Dynamis Lord
    [17330182] = { id = DMB+6 }, -- Dynamis Lord
    [17330183] = { id = DMB+7 }, -- Ying
    [17330184] = { id = DMB+8 }, -- Yang
    [17330185] = { id = DMB+9 }, -- Duke Haures
    [17330186] = { id = DMB+10 }, -- Marquis Caim
    [17330187] = { id = DMB+11 }, -- Caim's Vouivre
    [17330188] = { id = DMB+12 }, -- Baron Avnas
    [17330189] = { id = DMB+13 }, -- Count Haagenti
    [17330190] = { id = DMB+14 }, -- Haagenti's Avatar
    [17330191] = { id = DMB+15 }, -- Arch Dynamis Lord
    [17330192] = { id = DMB+16 }, -- Arch Dynamis Lord
    [17330193] = { id = DMB+17 }, -- Arch Dynamis Lord
    [17330194] = { id = DMB+18 }, -- Arch Dynamis Lord
    [17330195] = { id = DMB+19 }, -- Arch Dynamis Lord
    [17330196] = { id = DMB+20 }, -- Arch Dynamis Lord
    [17330197] = { id = DMB+21 }, -- Arch Dynamis Lord
    [17330198] = { id = DMB+22 }, -- Arch Dynamis Lord
    [17330199] = { id = DMB+23 }, -- Animated Knuckles
    [17330200] = { id = DMB+24 }, -- Animated Dagger
    [17330201] = { id = DMB+25 }, -- Animated Longsword
    [17330202] = { id = DMB+26 }, -- Animated Claymore
    [17330203] = { id = DMB+27 }, -- Animated Tabar
    [17330204] = { id = DMB+28 }, -- Animated Great Axe
    [17330205] = { id = DMB+29 }, -- Animated Spear
    [17330206] = { id = DMB+30 }, -- Animated Scythe
    [17330207] = { id = DMB+31 }, -- Animated Kunai
    [17330208] = { id = DMB+32 }, -- Animated Tachi
    [17330209] = { id = DMB+33 }, -- Animated Hammer
    [17330210] = { id = DMB+34 }, -- Animated Staff
    [17330211] = { id = DMB+35 }, -- Animated Longbow
    [17330212] = { id = DMB+36 }, -- Animated Gun
    [17330213] = { id = DMB+37 }, -- Animated Horn
    [17330214] = { id = DMB+38 }, -- Animated Shield
    [17330215] = { id = DMB+39 }, -- Kindred Paladin
    [17330216] = { id = DMB+40 }, -- Kindred Paladin
    [17330217] = { id = DMB+41 }, -- Kindred Dark Knight
    [17330218] = { id = DMB+42 }, -- Kindred Dark Knight
    [17330219] = { id = DMB+43 }, -- Kindred Beastmaster
    [17330220] = { id = DMB+44 }, -- Kindred's Vouivre
    [17330221] = { id = DMB+45 }, -- Kindred Ranger
    [17330222] = { id = DMB+46 }, -- Kindred Bard
    [17330223] = { id = DMB+47 }, -- Marquis Decarabia
    [17330224] = { id = DMB+48 }, -- Kindred Samurai
    [17330225] = { id = DMB+49 }, -- Kindred Samurai
    [17330226] = { id = DMB+50 }, -- Kindred Ninja
    [17330227] = { id = DMB+51 }, -- Kindred Ninja
    [17330228] = { id = DMB+52 }, -- Kindred Summoner
    [17330229] = { id = DMB+53 }, -- Kindred's Avatar
    [17330230] = { id = DMB+54 }, -- Adamantking Effigy
    [17330231] = { id = DMB+55 }, -- Adamantking Effigy
    [17330232] = { id = DMB+56 }, -- Kindred Dragoon
    [17330233] = { id = DMB+57 }, -- Kindred's Wyvern
    [17330234] = { id = DMB+58 }, -- Kindred Dragoon
    [17330235] = { id = DMB+59 }, -- Kindred's Wyvern
    [17330236] = { id = DMB+60 }, -- Kindred White Mage
    [17330237] = { id = DMB+61 }, -- Kindred Black Mage
    [17330238] = { id = DMB+62 }, -- Kindred Red Mage
    [17330239] = { id = DMB+63 }, -- Kindred Bard
    [17330240] = { id = DMB+64 }, -- Adamantking Effigy
    [17330241] = { id = DMB+65 }, -- Adamantking Effigy
    [17330242] = { id = DMB+66 }, -- Kindred Warrior
    [17330243] = { id = DMB+67 }, -- Kindred Warrior
    [17330244] = { id = DMB+68 }, -- Kindred Monk
    [17330245] = { id = DMB+69 }, -- Kindred Thief
    [17330246] = { id = DMB+70 }, -- Kindred Beastmaster
    [17330247] = { id = DMB+71 }, -- Kindred's Vouivre
    [17330248] = { id = DMB+72 }, -- Serjeant Tombstone
    [17330249] = { id = DMB+73 }, -- Serjeant Tombstone
    [17330250] = { id = DMB+74 }, -- Kindred Paladin
    [17330251] = { id = DMB+75 }, -- Kindred Paladin
    [17330252] = { id = DMB+76 }, -- Kindred Samurai
    [17330253] = { id = DMB+77 }, -- Kindred Ninja
    [17330254] = { id = DMB+78 }, -- Kindred Summoner
    [17330255] = { id = DMB+79 }, -- Kindred's Avatar
    [17330256] = { id = DMB+80 }, -- Serjeant Tombstone
    [17330257] = { id = DMB+81 }, -- Serjeant Tombstone
    [17330258] = { id = DMB+82 }, -- Kindred Dark Knight
    [17330259] = { id = DMB+83 }, -- Kindred Dark Knight
    [17330260] = { id = DMB+84 }, -- Kindred Red Mage
    [17330261] = { id = DMB+85 }, -- Kindred Black Mage
    [17330262] = { id = DMB+86 }, -- Kindred Bard
    [17330263] = { id = DMB+87 }, -- Kindred Dragoon
    [17330264] = { id = DMB+88 }, -- Kindred's Wyvern
    [17330265] = { id = DMB+89 }, -- Kindred Ranger
    [17330266] = { id = DMB+90 }, -- Kindred Ranger
    [17330267] = { id = DMB+91 }, -- Kindred Samurai
    [17330268] = { id = DMB+92 }, -- Kindred Samurai
    [17330269] = { id = DMB+93 }, -- Kindred Ninja
    [17330270] = { id = DMB+94 }, -- Kindred Ninja
    [17330271] = { id = DMB+95 }, -- Kindred Thief
    [17330272] = { id = DMB+96 }, -- Kindred Thief
    [17330273] = { id = DMB+97 }, -- Avatar Icon
    [17330274] = { id = DMB+98 }, -- Avatar Icon
    [17330275] = { id = DMB+99 }, -- Kindred White Mage
    [17330276] = { id = DMB+100 }, -- Kindred White Mage
    [17330277] = { id = DMB+101 }, -- Kindred Black Mage
    [17330278] = { id = DMB+102 }, -- Kindred Black Mage
    [17330279] = { id = DMB+103 }, -- Kindred Red Mage
    [17330280] = { id = DMB+104 }, -- Kindred Red Mage
    [17330281] = { id = DMB+105 }, -- Kindred Summoner
    [17330282] = { id = DMB+106 }, -- Kindred's Avatar
    [17330283] = { id = DMB+107 }, -- Kindred Summoner
    [17330284] = { id = DMB+108 }, -- Kindred's Avatar
    [17330285] = { id = DMB+109 }, -- Avatar Icon
    [17330286] = { id = DMB+110 }, -- Avatar Icon
    [17330287] = { id = DMB+111 }, -- Kindred Paladin
    [17330288] = { id = DMB+112 }, -- Kindred Paladin
    [17330289] = { id = DMB+113 }, -- Kindred White Mage
    [17330290] = { id = DMB+114 }, -- Satellite Shield
    [17330291] = { id = DMB+115 }, -- Satellite Shield
    [17330292] = { id = DMB+116 }, -- Satellite Shield
    [17330293] = { id = DMB+117 }, -- Vanguard Eye
    [17330294] = { id = DMB+118 }, -- Kindred Paladin
    [17330295] = { id = DMB+119 }, -- Kindred Paladin
    [17330296] = { id = DMB+120 }, -- Kindred Beastmaster
    [17330297] = { id = DMB+121 }, -- Kindred's Vouivre
    [17330298] = { id = DMB+122 }, -- Kindred Black Mage
    [17330299] = { id = DMB+123 }, -- Satellite Shield
    [17330300] = { id = DMB+124 }, -- Satellite Shield
    [17330301] = { id = DMB+125 }, -- Satellite Shield
    [17330302] = { id = DMB+126 }, -- Vanguard Eye
    [17330303] = { id = DMB+127 }, -- Kindred Monk
    [17330304] = { id = DMB+128 }, -- Duke Gomory
    [17330305] = { id = DMB+129 }, -- Kindred Thief
    [17330306] = { id = DMB+130 }, -- Satellite Daggers
    [17330307] = { id = DMB+131 }, -- Satellite Daggers
    [17330308] = { id = DMB+132 }, -- Satellite Daggers
    [17330309] = { id = DMB+133 }, -- Satellite Knuckles
    [17330310] = { id = DMB+134 }, -- Satellite Knuckles
    [17330311] = { id = DMB+135 }, -- Satellite Knuckles
    [17330312] = { id = DMB+136 }, -- Vanguard Eye
    [17330313] = { id = DMB+137 }, -- Kindred Monk
    [17330314] = { id = DMB+138 }, -- Kindred Thief
    [17330315] = { id = DMB+139 }, -- Count Raum
    [17330316] = { id = DMB+140 }, -- Satellite Daggers
    [17330317] = { id = DMB+141 }, -- Satellite Daggers
    [17330318] = { id = DMB+142 }, -- Satellite Daggers
    [17330319] = { id = DMB+143 }, -- Satellite Knuckles
    [17330320] = { id = DMB+144 }, -- Satellite Knuckles
    [17330321] = { id = DMB+145 }, -- Satellite Knuckles
    [17330322] = { id = DMB+146 }, -- Vanguard Eye
    [17330323] = { id = DMB+147 }, -- Kindred Warrior
    [17330324] = { id = DMB+148 }, -- Kindred Monk
    [17330325] = { id = DMB+149 }, -- Kindred Ranger
    [17330326] = { id = DMB+150 }, -- Kindred White Mage
    [17330327] = { id = DMB+151 }, -- Kindred Black Mage
    [17330328] = { id = DMB+152 }, -- Kindred Dark Knight
    [17330329] = { id = DMB+153 }, -- Kindred Dragoon
    [17330330] = { id = DMB+154 }, -- Kindred's Wyvern
    [17330331] = { id = DMB+155 }, -- Kindred White Mage
    [17330332] = { id = DMB+156 }, -- Prince Seere
    [17330333] = { id = DMB+157 }, -- Kindred Black Mage
    [17330334] = { id = DMB+158 }, -- Satellite Hammers
    [17330335] = { id = DMB+159 }, -- Satellite Hammers
    [17330336] = { id = DMB+160 }, -- Satellite Hammers
    [17330337] = { id = DMB+161 }, -- Satellite Staves
    [17330338] = { id = DMB+162 }, -- Satellite Staves
    [17330339] = { id = DMB+163 }, -- Satellite Staves
    [17330340] = { id = DMB+164 }, -- Vanguard Eye
    [17330341] = { id = DMB+165 }, -- Kindred White Mage
    [17330342] = { id = DMB+166 }, -- Kindred Black Mage
    [17330343] = { id = DMB+167 }, -- Marquis Orias
    [17330344] = { id = DMB+168 }, -- Satellite Hammers
    [17330345] = { id = DMB+169 }, -- Satellite Hammers
    [17330346] = { id = DMB+170 }, -- Satellite Hammers
    [17330347] = { id = DMB+171 }, -- Satellite Staves
    [17330348] = { id = DMB+172 }, -- Satellite Staves
    [17330349] = { id = DMB+173 }, -- Satellite Staves
    [17330350] = { id = DMB+174 }, -- Vanguard Eye
    [17330351] = { id = DMB+175 }, -- Kindred Paladin
    [17330352] = { id = DMB+176 }, -- Kindred Red Mage
    [17330353] = { id = DMB+177 }, -- Duke Berith
    [17330354] = { id = DMB+178 }, -- Kindred Red Mage
    [17330355] = { id = DMB+179 }, -- Satellite Longswords
    [17330356] = { id = DMB+180 }, -- Satellite Longswords
    [17330357] = { id = DMB+181 }, -- Satellite Longswords
    [17330358] = { id = DMB+182 }, -- Vanguard Eye
    [17330359] = { id = DMB+183 }, -- Kindred Paladin
    [17330360] = { id = DMB+184 }, -- Marquis Sabnak
    [17330361] = { id = DMB+185 }, -- Kindred Dark Knight
    [17330362] = { id = DMB+186 }, -- Satellite Longswords
    [17330363] = { id = DMB+187 }, -- Satellite Longswords
    [17330364] = { id = DMB+188 }, -- Satellite Longswords
    [17330365] = { id = DMB+189 }, -- Satellite Claymores
    [17330366] = { id = DMB+190 }, -- Satellite Claymores
    [17330367] = { id = DMB+191 }, -- Satellite Claymores
    [17330368] = { id = DMB+192 }, -- Vanguard Eye
    [17330369] = { id = DMB+193 }, -- Kindred Dark Knight
    [17330370] = { id = DMB+194 }, -- Kindred Dark Knight
    [17330371] = { id = DMB+195 }, -- Kindred Black Mage
    [17330372] = { id = DMB+196 }, -- Satellite Claymores
    [17330373] = { id = DMB+197 }, -- Satellite Claymores
    [17330374] = { id = DMB+198 }, -- Satellite Claymores
    [17330375] = { id = DMB+199 }, -- Vanguard Eye
    [17330376] = { id = DMB+200 }, -- Kindred Warrior
    [17330377] = { id = DMB+201 }, -- Count Zaebos
    [17330378] = { id = DMB+202 }, -- Kindred Beastmaster
    [17330379] = { id = DMB+203 }, -- Kindred's Vouivre
    [17330380] = { id = DMB+204 }, -- Satellite Tabars
    [17330381] = { id = DMB+205 }, -- Satellite Tabars
    [17330382] = { id = DMB+206 }, -- Satellite Tabars
    [17330383] = { id = DMB+207 }, -- Satellite Great Axes
    [17330384] = { id = DMB+208 }, -- Satellite Great Axes
    [17330385] = { id = DMB+209 }, -- Satellite Great Axes
    [17330386] = { id = DMB+210 }, -- Vanguard Eye
    [17330387] = { id = DMB+211 }, -- Kindred Warrior
    [17330388] = { id = DMB+212 }, -- Kindred Beastmaster
    [17330389] = { id = DMB+213 }, -- Kindred's Vouivre
    [17330390] = { id = DMB+214 }, -- Marquis Andras
    [17330391] = { id = DMB+215 }, -- Andras's Vouivre
    [17330392] = { id = DMB+216 }, -- Satellite Tabars
    [17330393] = { id = DMB+217 }, -- Satellite Tabars
    [17330394] = { id = DMB+218 }, -- Satellite Tabars
    [17330395] = { id = DMB+219 }, -- Satellite Great Axes
    [17330396] = { id = DMB+220 }, -- Satellite Great Axes
    [17330397] = { id = DMB+221 }, -- Satellite Great Axes
    [17330398] = { id = DMB+222 }, -- Vanguard Eye
    [17330399] = { id = DMB+223 }, -- Kindred Thief
    [17330400] = { id = DMB+224 }, -- Kindred Ninja
    [17330401] = { id = DMB+225 }, -- Kindred Ranger
    [17330402] = { id = DMB+226 }, -- Kindred Thief
    [17330403] = { id = DMB+227 }, -- Kindred Ninja
    [17330404] = { id = DMB+228 }, -- Kindred Ranger
    [17330405] = { id = DMB+229 }, -- Kindred Warrior
    [17330406] = { id = DMB+230 }, -- Kindred Monk
    [17330407] = { id = DMB+231 }, -- Kindred White Mage
    [17330408] = { id = DMB+232 }, -- Kindred Black Mage
    [17330409] = { id = DMB+233 }, -- Kindred Red Mage
    [17330410] = { id = DMB+234 }, -- Kindred Paladin
    [17330411] = { id = DMB+235 }, -- Kindred Dark Knight
    [17330412] = { id = DMB+236 }, -- Kindred Thief
    [17330413] = { id = DMB+237 }, -- Kindred Ninja
    [17330414] = { id = DMB+238 }, -- Kindred Ranger
    [17330415] = { id = DMB+239 }, -- Marquis Cimeries
    [17330416] = { id = DMB+240 }, -- Kindred Dark Knight
    [17330417] = { id = DMB+241 }, -- Duke Scox
    [17330418] = { id = DMB+242 }, -- Kindred Dragoon
    [17330419] = { id = DMB+243 }, -- Kindred's Wyvern
    [17330420] = { id = DMB+244 }, -- Satellite Scythes
    [17330421] = { id = DMB+245 }, -- Satellite Scythes
    [17330422] = { id = DMB+246 }, -- Satellite Scythes
    [17330423] = { id = DMB+247 }, -- Satellite Spears
    [17330424] = { id = DMB+248 }, -- Satellite Spears
    [17330425] = { id = DMB+249 }, -- Satellite Spears
    [17330426] = { id = DMB+250 }, -- Vanguard Eye
    [17330427] = { id = DMB+251 }, -- Kindred Dark Knight
    [17330428] = { id = DMB+252 }, -- Kindred Dragoon
    [17330429] = { id = DMB+253 }, -- Kindred's Wyvern
    [17330430] = { id = DMB+254 }, -- King Zagan
    [17330431] = { id = DMB+255 }, -- Zagan's Wyvern
    [17330432] = { id = DMB+256 }, -- Satellite Scythes
    [17330433] = { id = DMB+257 }, -- Satellite Scythes
    [17330434] = { id = DMB+258 }, -- Satellite Scythes
    [17330435] = { id = DMB+259 }, -- Satellite Spears
    [17330436] = { id = DMB+260 }, -- Satellite Spears
    [17330437] = { id = DMB+261 }, -- Satellite Spears
    [17330438] = { id = DMB+262 }, -- Vanguard Eye
    [17330439] = { id = DMB+263 }, -- Kindred Samurai
    [17330440] = { id = DMB+264 }, -- Count Vine
    [17330441] = { id = DMB+265 }, -- Kindred Ninja
    [17330442] = { id = DMB+266 }, -- Satellite Kunai
    [17330443] = { id = DMB+267 }, -- Satellite Kunai
    [17330444] = { id = DMB+268 }, -- Satellite Kunai
    [17330445] = { id = DMB+269 }, -- Satellite Tachi
    [17330446] = { id = DMB+270 }, -- Satellite Tachi
    [17330447] = { id = DMB+271 }, -- Satellite Tachi
    [17330448] = { id = DMB+272 }, -- Vanguard Eye
    [17330449] = { id = DMB+273 }, -- Kindred Samurai
    [17330450] = { id = DMB+274 }, -- Kindred Ninja
    [17330451] = { id = DMB+275 }, -- Marquis Gamygyn
    [17330452] = { id = DMB+276 }, -- Kindred Summoner
    [17330453] = { id = DMB+277 }, -- Kindred's Avatar
    [17330454] = { id = DMB+278 }, -- Satellite Kunai
    [17330455] = { id = DMB+279 }, -- Satellite Kunai
    [17330456] = { id = DMB+280 }, -- Satellite Kunai
    [17330457] = { id = DMB+281 }, -- Satellite Tachi
    [17330458] = { id = DMB+282 }, -- Satellite Tachi
    [17330459] = { id = DMB+283 }, -- Satellite Tachi
    [17330460] = { id = DMB+284 }, -- Vanguard Eye
    [17330461] = { id = DMB+285 }, -- Kindred Warrior
    [17330462] = { id = DMB+286 }, -- Kindred Monk
    [17330463] = { id = DMB+287 }, -- Kindred White Mage
    [17330464] = { id = DMB+288 }, -- Kindred Black Mage
    [17330465] = { id = DMB+289 }, -- Kindred Red Mage
    [17330466] = { id = DMB+290 }, -- Kindred Thief
    [17330467] = { id = DMB+291 }, -- Kindred Paladin
    [17330468] = { id = DMB+292 }, -- Kindred Dark Knight
    [17330469] = { id = DMB+293 }, -- Kindred Beastmaster
    [17330470] = { id = DMB+294 }, -- Kindred's Vouivre
    [17330471] = { id = DMB+295 }, -- Goblin Replica
    [17330472] = { id = DMB+296 }, -- Goblin Replica
    [17330473] = { id = DMB+297 }, -- Kindred Bard
    [17330474] = { id = DMB+298 }, -- Kindred Ranger
    [17330475] = { id = DMB+299 }, -- Kindred Samurai
    [17330476] = { id = DMB+300 }, -- Kindred Ninja
    [17330477] = { id = DMB+301 }, -- Kindred Dragoon
    [17330478] = { id = DMB+302 }, -- Kindred's Wyvern
    [17330479] = { id = DMB+303 }, -- Kindred Summoner
    [17330480] = { id = DMB+304 }, -- Kindred's Avatar
    [17330481] = { id = DMB+305 }, -- Marquis Nebiros
    [17330482] = { id = DMB+306 }, -- Nebiros's Avatar
    [17330483] = { id = DMB+307 }, -- Goblin Replica
    [17330484] = { id = DMB+308 }, -- Goblin Replica
    [17330485] = { id = DMB+309 }, -- Kindred Warrior
    [17330486] = { id = DMB+310 }, -- Kindred Monk
    [17330487] = { id = DMB+311 }, -- Kindred White Mage
    [17330488] = { id = DMB+312 }, -- Kindred Black Mage
    [17330489] = { id = DMB+313 }, -- Kindred Red Mage
    [17330490] = { id = DMB+314 }, -- Kindred Thief
    [17330491] = { id = DMB+315 }, -- Kindred Bard
    [17330492] = { id = DMB+316 }, -- Kindred Bard
    [17330493] = { id = DMB+317 }, -- Kindred Summoner
    [17330494] = { id = DMB+318 }, -- Kindred's Avatar
	[17330495] = { id = DMB+319 }, -- Satellite Horns
    [17330496] = { id = DMB+320 }, -- Satellite Horns
    [17330497] = { id = DMB+321 }, -- Satellite Horns
    [17330498] = { id = DMB+322 }, -- Vanguard Eye
    [17330499] = { id = DMB+323 }, -- Kindred Bard
    [17330500] = { id = DMB+324 }, -- Kindred Bard
    [17330501] = { id = DMB+325 }, -- Kindred Summoner
    [17330502] = { id = DMB+326 }, -- Kindred's Avatar
    [17330503] = { id = DMB+327 }, -- Satellite Horns
    [17330504] = { id = DMB+328 }, -- Satellite Horns
    [17330505] = { id = DMB+329 }, -- Satellite Horns
    [17330506] = { id = DMB+330 }, -- Vanguard Eye
    [17330507] = { id = DMB+331 }, -- Vanguard Dragon
    [17330508] = { id = DMB+332 }, -- Vanguard Dragon
    [17330509] = { id = DMB+333 }, -- Vanguard Dragon
    [17330510] = { id = DMB+334 }, -- Vanguard Dragon
    [17330511] = { id = DMB+335 }, -- Vanguard Dragon
    [17330512] = { id = DMB+336 }, -- Vanguard Dragon
    [17330513] = { id = DMB+337 }, -- Satellite Guns
    [17330514] = { id = DMB+338 }, -- Satellite Guns
    [17330515] = { id = DMB+339 }, -- Satellite Guns
    [17330516] = { id = DMB+340 }, -- Satellite Guns
    [17330517] = { id = DMB+341 }, -- Satellite Guns
    [17330518] = { id = DMB+342 }, -- Satellite Guns
    [17330519] = { id = DMB+343 }, -- Vanguard Dragon
    [17330520] = { id = DMB+344 }, -- Vanguard Dragon
    [17330521] = { id = DMB+345 }, -- Vanguard Dragon
    [17330522] = { id = DMB+346 }, -- Satellite Longbows
    [17330523] = { id = DMB+347 }, -- Satellite Longbows
    [17330524] = { id = DMB+348 }, -- Satellite Longbows
    [17330525] = { id = DMB+349 }, -- Satellite Longbows
    [17330526] = { id = DMB+350 }, -- Satellite Longbows
    [17330527] = { id = DMB+351 }, -- Satellite Longbows
    [17330528] = { id = DMB+352 }, -- Vanguard Dragon
    [17330529] = { id = DMB+353 }, -- Vanguard Dragon
    [17330530] = { id = DMB+354 }, -- Vanguard Dragon
    [17330531] = { id = DMB+355 }, -- Tombstone Prototype
    [17330532] = { id = DMB+356 }, -- Effigy Prototype
    [17330533] = { id = DMB+357 }, -- Icon Prototype
    [17330534] = { id = DMB+358 }, -- Statue Prototype
    [17330535] = { id = DMB+359 }, -- Prototype Eye
    [17330536] = { id = DMB+360 }, -- Kindred Warrior
    [17330537] = { id = DMB+361 }, -- Kindred Warrior
    [17330538] = { id = DMB+362 }, -- Kindred White Mage
    [17330539] = { id = DMB+363 }, -- Kindred White Mage
    [17330540] = { id = DMB+364 }, -- Kindred Red Mage
    [17330541] = { id = DMB+365 }, -- Kindred Red Mage
    [17330542] = { id = DMB+366 }, -- Vanguard Eye
    [17330543] = { id = DMB+367 }, -- Kindred Monk
    [17330544] = { id = DMB+368 }, -- Kindred Monk
    [17330545] = { id = DMB+369 }, -- Kindred Black Mage
    [17330546] = { id = DMB+370 }, -- Kindred Black Mage
    [17330547] = { id = DMB+371 }, -- Kindred Thief
    [17330548] = { id = DMB+372 }, -- Kindred Thief
    [17330549] = { id = DMB+373 }, -- Vanguard Eye
    [17330550] = { id = DMB+374 }, -- Kindred Paladin
    [17330551] = { id = DMB+375 }, -- Kindred Paladin
    [17330552] = { id = DMB+376 }, -- Kindred Dark Knight
    [17330553] = { id = DMB+377 }, -- Kindred Dark Knight
    [17330554] = { id = DMB+378 }, -- Kindred Beastmaster
    [17330555] = { id = DMB+379 }, -- Kindred's Vouivre
    [17330556] = { id = DMB+380 }, -- Kindred Bard
    [17330557] = { id = DMB+381 }, -- Kindred Bard
    [17330558] = { id = DMB+382 }, -- Kindred Ranger
    [17330559] = { id = DMB+383 }, -- Kindred Ranger
    [17330560] = { id = DMB+384 }, -- Kindred Beastmaster
    [17330561] = { id = DMB+385 }, -- Kindred's Vouivre
    [17330562] = { id = DMB+386 }, -- Vanguard Eye
    [17330563] = { id = DMB+387 }, -- Kindred White Mage
    [17330564] = { id = DMB+388 }, -- Kindred Red Mage
    [17330565] = { id = DMB+389 }, -- Kindred Black Mage
    [17330566] = { id = DMB+390 }, -- Kindred Bard
    [17330567] = { id = DMB+391 }, -- Vanguard Eye
    [17330568] = { id = DMB+392 }, -- Kindred Samurai
    [17330569] = { id = DMB+393 }, -- Kindred Samurai
    [17330570] = { id = DMB+394 }, -- Kindred Ninja
    [17330571] = { id = DMB+395 }, -- Kindred Ninja
    [17330572] = { id = DMB+396 }, -- Kindred Dragoon
    [17330573] = { id = DMB+397 }, -- Kindred's Wyvern
    [17330574] = { id = DMB+398 }, -- Kindred Summoner
    [17330575] = { id = DMB+399 }, -- Kindred's Avatar
    [17330576] = { id = DMB+400 }, -- Kindred White Mage
    [17330577] = { id = DMB+401 }, -- Kindred Paladin
    [17330578] = { id = DMB+402 }, -- Kindred Dark Knight
    [17330579] = { id = DMB+403 }, -- Kindred Bard
    [17330580] = { id = DMB+404 }, -- Kindred Ranger
    [17330581] = { id = DMB+405 }, -- Vanguard Eye
    [17330582] = { id = DMB+406 }, -- Kindred Thief
    [17330583] = { id = DMB+407 }, -- Kindred Ranger
    [17330584] = { id = DMB+408 }, -- Kindred Samurai
    [17330585] = { id = DMB+409 }, -- Kindred Ninja
    [17330586] = { id = DMB+410 }, -- Vanguard Eye
    [17330587] = { id = DMB+411 }, -- Kindred Warrior
    [17330588] = { id = DMB+412 }, -- Kindred Monk
    [17330589] = { id = DMB+413 }, -- Kindred Dark Knight
    [17330590] = { id = DMB+414 }, -- Kindred Samurai
    [17330591] = { id = DMB+415 }, -- Kindred Ninja
    [17330592] = { id = DMB+416 }, -- Kindred White Mage
    [17330593] = { id = DMB+417 }, -- Kindred Black Mage
    [17330594] = { id = DMB+418 }, -- Kindred Red Mage
    [17330595] = { id = DMB+419 }, -- Kindred Thief
    [17330596] = { id = DMB+420 }, -- Kindred Summoner
    [17330597] = { id = DMB+421 }, -- Kindred's Avatar
    [17330598] = { id = DMB+422 }, -- Kindred Paladin
    [17330599] = { id = DMB+423 }, -- Kindred Beastmaster
    [17330600] = { id = DMB+424 }, -- Kindred's Vouivre
    [17330601] = { id = DMB+425 }, -- Kindred Bard
    [17330602] = { id = DMB+426 }, -- Kindred Ranger
    [17330603] = { id = DMB+427 }, -- Kindred Samurai
    [17330604] = { id = DMB+428 }, -- Kindred Bard
    [17330605] = { id = DMB+429 }, -- Kindred Bard
    [17330606] = { id = DMB+430 }, -- Kindred Samurai
    [17330607] = { id = DMB+431 }, -- Kindred Samurai
    [17330608] = { id = DMB+432 }, -- Kindred Dragoon
    [17330609] = { id = DMB+433 }, -- Kindred's Wyvern
    [17330610] = { id = DMB+434 }, -- Vanguard Eye
    [17330611] = { id = DMB+435 }, -- Kindred Ranger
    [17330612] = { id = DMB+436 }, -- Kindred Ranger
    [17330613] = { id = DMB+437 }, -- Kindred Ninja
    [17330614] = { id = DMB+438 }, -- Kindred Ninja
    [17330615] = { id = DMB+439 }, -- Kindred Summoner
    [17330616] = { id = DMB+440 }, -- Kindred's Avatar
    [17330617] = { id = DMB+441 }, -- Vanguard Eye
    [17330618] = { id = DMB+442 }, -- Kindred Warrior
    [17330619] = { id = DMB+443 }, -- Kindred White Mage
    [17330620] = { id = DMB+444 }, -- Kindred Black Mage
    [17330621] = { id = DMB+445 }, -- Kindred Thief
    [17330622] = { id = DMB+446 }, -- Kindred Warrior
    [17330623] = { id = DMB+447 }, -- Kindred Monk
    [17330624] = { id = DMB+448 }, -- Kindred Black Mage
    [17330625] = { id = DMB+449 }, -- Kindred Red Mage
    [17330626] = { id = DMB+450 }, -- Kindred Monk
    [17330627] = { id = DMB+451 }, -- Kindred White Mage
    [17330628] = { id = DMB+452 }, -- Kindred Black Mage
    [17330629] = { id = DMB+453 }, -- Kindred Red Mage
    [17330630] = { id = DMB+454 }, -- Kindred Thief
    [17330631] = { id = DMB+455 }, -- Vanguard Eye
    [17330632] = { id = DMB+456 }, -- Kindred Paladin
    [17330633] = { id = DMB+457 }, -- Kindred Dark Knight
    [17330634] = { id = DMB+458 }, -- Kindred Beastmaster
    [17330635] = { id = DMB+459 }, -- Kindred's Vouivre
    [17330636] = { id = DMB+460 }, -- Vanguard Eye
    [17330637] = { id = DMB+461 }, -- Kindred Bard
    [17330638] = { id = DMB+462 }, -- Kindred Ranger
    [17330639] = { id = DMB+463 }, -- Kindred Dragoon
    [17330640] = { id = DMB+464 }, -- Kindred's Wyvern
    [17330641] = { id = DMB+465 }, -- Kindred Samurai
    [17330642] = { id = DMB+466 }, -- Kindred Ninja
    [17330643] = { id = DMB+467 }, -- Kindred Dragoon
    [17330644] = { id = DMB+468 }, -- Kindred's Wyvern
    [17330645] = { id = DMB+469 }, -- Kindred Summoner
    [17330646] = { id = DMB+470 }, -- Kindred's Avatar
    [17330647] = { id = DMB+471 }, -- Kindred Thief
    [17330648] = { id = DMB+472 }, -- Kindred Bard
    [17330649] = { id = DMB+473 }, -- Kindred Ranger
    [17330650] = { id = DMB+474 }, -- Kindred Ranger
    [17330651] = { id = DMB+475 }, -- Kindred Dark Knight
    [17330652] = { id = DMB+476 }, -- Kindred Samurai
    [17330653] = { id = DMB+477 }, -- Kindred Dragoon
    [17330654] = { id = DMB+478 }, -- Kindred's Wyvern
    [17330655] = { id = DMB+479 }, -- Kindred Red Mage
    [17330656] = { id = DMB+480 }, -- Kindred Paladin
    [17330657] = { id = DMB+481 }, -- Kindred White Mage
    [17330658] = { id = DMB+482 }, -- Kindred White Mage
    [17330659] = { id = DMB+483 }, -- Kindred Black Mage
    [17330660] = { id = DMB+484 }, -- Kindred Black Mage
    [17330661] = { id = DMB+485 }, -- Kindred Red Mage
    [17330662] = { id = DMB+486 }, -- Vanguard Eye
    [17330663] = { id = DMB+487 }, -- Kindred Warrior
    [17330664] = { id = DMB+488 }, -- Kindred Thief
    [17330665] = { id = DMB+489 }, -- Kindred Thief
    [17330666] = { id = DMB+490 }, -- Kindred Paladin
    [17330667] = { id = DMB+491 }, -- Kindred Paladin
    [17330668] = { id = DMB+492 }, -- Vanguard Eye
    [17330669] = { id = DMB+493 }, -- Kindred Dark Knight
    [17330670] = { id = DMB+494 }, -- Kindred Beastmaster
    [17330671] = { id = DMB+495 }, -- Kindred's Vouivre
    [17330672] = { id = DMB+496 }, -- Kindred Bard
    [17330673] = { id = DMB+497 }, -- Kindred Samurai
    [17330674] = { id = DMB+498 }, -- Kindred Samurai
    [17330675] = { id = DMB+499 }, -- Kindred Ninja
    [17330676] = { id = DMB+500 }, -- Kindred Ninja
    [17330677] = { id = DMB+501 }, -- Kindred Summoner
    [17330678] = { id = DMB+502 }, -- Kindred's Avatar
    [17330679] = { id = DMB+503 }, -- Kindred Warrior
    [17330680] = { id = DMB+504 }, -- Kindred Monk
    [17330681] = { id = DMB+505 }, -- Kindred Thief
    [17330682] = { id = DMB+506 }, -- Kindred Paladin
    [17330683] = { id = DMB+507 }, -- Kindred Dark Knight
    [17330684] = { id = DMB+508 }, -- Kindred Ranger
    [17330685] = { id = DMB+509 }, -- Vanguard Eye
    [17330686] = { id = DMB+510 }, -- Kindred White Mage
    [17330687] = { id = DMB+511 }, -- Kindred Black Mage
    [17330688] = { id = DMB+512 }, -- Kindred Red Mage
    [17330689] = { id = DMB+513 }, -- Kindred Bard
    [17330690] = { id = DMB+514 }, -- Vanguard Eye
    [17330691] = { id = DMB+515 }, -- Kindred Samurai
    [17330692] = { id = DMB+516 }, -- Kindred Ninja
    [17330693] = { id = DMB+517 }, -- Kindred Dragoon
    [17330694] = { id = DMB+518 }, -- Kindred's Wyvern
    [17330695] = { id = DMB+519 }, -- Kindred Summoner
    [17330696] = { id = DMB+520 }, -- Kindred's Avatar
    [17330697] = { id = DMB+521 }, -- Kindred Samurai
    [17330698] = { id = DMB+522 }, -- Kindred Ninja
    [17330699] = { id = DMB+523 }, -- Kindred Dragoon
    [17330700] = { id = DMB+524 }, -- Kindred's Wyvern
    [17330701] = { id = DMB+525 }, -- Kindred Summoner
    [17330702] = { id = DMB+526 }, -- Kindred's Avatar
    [17330703] = { id = DMB+527 }, -- Kindred Paladin
    [17330704] = { id = DMB+528 }, -- Kindred Paladin
    [17330705] = { id = DMB+529 }, -- Kindred Dark Knight
    [17330706] = { id = DMB+530 }, -- Kindred Dark Knight
    [17330707] = { id = DMB+531 }, -- Kindred Bard
    [17330708] = { id = DMB+532 }, -- Kindred Ninja
    [17330709] = { id = DMB+533 }, -- Kindred Ninja
    [17330710] = { id = DMB+534 }, -- Kindred Dragoon
    [17330711] = { id = DMB+535 }, -- Kindred's Wyvern
    [17330712] = { id = DMB+536 }, -- Kindred Dark Knight
    [17330713] = { id = DMB+537 }, -- Kindred Black Mage
    [17330714] = { id = DMB+538 }, -- Kindred Summoner
    [17330715] = { id = DMB+539 }, -- Kindred's Avatar
    [17330716] = { id = DMB+540 }, -- Kindred Summoner
    [17330717] = { id = DMB+541 }, -- Kindred's Avatar
    [17330718] = { id = DMB+542 }, -- Vanguard Eye
    [17330719] = { id = DMB+543 }, -- Kindred Ranger
    [17330720] = { id = DMB+544 }, -- Kindred Ranger
    [17330721] = { id = DMB+545 }, -- Kindred Warrior
    [17330722] = { id = DMB+546 }, -- Kindred Monk
    [17330723] = { id = DMB+547 }, -- Kindred Monk
    [17330724] = { id = DMB+548 }, -- Kindred Samurai
    [17330725] = { id = DMB+549 }, -- Kindred Samurai
    [17330726] = { id = DMB+550 }, -- Kindred Bard
    [17330727] = { id = DMB+551 }, -- Kindred Bard
    [17330728] = { id = DMB+552 }, -- Kindred Red Mage
    [17330729] = { id = DMB+553 }, -- Kindred Thief
    [17330730] = { id = DMB+554 }, -- Kindred Thief
    [17330731] = { id = DMB+555 }, -- Vanguard Eye
    [17330732] = { id = DMB+556 }, -- Kindred Warrior
    [17330733] = { id = DMB+557 }, -- Kindred White Mage
    [17330734] = { id = DMB+558 }, -- Kindred Beastmaster
    [17330735] = { id = DMB+559 }, -- Kindred's Vouivre
    [17330736] = { id = DMB+560 }, -- Kindred Beastmaster
    [17330737] = { id = DMB+561 }, -- Kindred's Vouivre
    [17330738] = { id = DMB+562 }, -- Kindred Bard
    [17330739] = { id = DMB+563 }, -- Kindred Samurai
    [17330740] = { id = DMB+564 }, -- Kindred Ninja
    [17330741] = { id = DMB+565 }, -- Kindred Ninja
    [17330742] = { id = DMB+566 }, -- Kindred Thief
    [17330743] = { id = DMB+567 }, -- Kindred Ranger
    [17330744] = { id = DMB+568 }, -- Kindred Dragoon
    [17330745] = { id = DMB+569 }, -- Kindred's Wyvern
    [17330746] = { id = DMB+570 }, -- Vanguard Eye
    [17330747] = { id = DMB+571 }, -- Kindred Thief
    [17330748] = { id = DMB+572 }, -- Kindred Ranger
    [17330749] = { id = DMB+573 }, -- Vanguard Eye
    [17330750] = { id = DMB+574 }, -- Kindred Warrior
    [17330751] = { id = DMB+575 }, -- Kindred Monk
    [17330752] = { id = DMB+576 }, -- Kindred White Mage
    [17330753] = { id = DMB+577 }, -- Kindred Black Mage
    [17330754] = { id = DMB+578 }, -- Kindred Red Mage
    [17330755] = { id = DMB+579 }, -- Kindred Thief
    [17330756] = { id = DMB+580 }, -- Vanguard Eye
    [17330757] = { id = DMB+581 }, -- Kindred Paladin
    [17330758] = { id = DMB+582 }, -- Kindred Dark Knight
    [17330759] = { id = DMB+583 }, -- Kindred Beastmaster
    [17330760] = { id = DMB+584 }, -- Kindred's Vouivre
    [17330761] = { id = DMB+585 }, -- Kindred Bard
    [17330762] = { id = DMB+586 }, -- Vanguard Eye
    [17330763] = { id = DMB+587 }, -- Kindred Ranger
    [17330764] = { id = DMB+588 }, -- Kindred Samurai
    [17330765] = { id = DMB+589 }, -- Kindred Ninja
    [17330766] = { id = DMB+590 }, -- Kindred Dragoon
    [17330767] = { id = DMB+591 }, -- Kindred's Wyvern
    [17330768] = { id = DMB+592 }, -- Kindred Summoner
    [17330769] = { id = DMB+593 }, -- Kindred's Avatar
    [17330770] = { id = DMB+594 }, -- Vanguard Eye
    [SMB+0] = { id = SMB+0 }, --
    [SMB+1] = { id = SMB+1 }, -- Vanguard Eye
    [SMB+2] = { id = SMB+2 }, -- Vanguard Eye
    [SMB+3] = { id = SMB+3 }, -- Vanguard Eye
    [SMB+4] = { id = SMB+4 }, -- Vanguard Eye
    [SMB+5] = { id = SMB+5 }, -- Statue Prototype
    [SMB+6] = { id = SMB+6 }, -- Vanguard Eye
    [SMB+7] = { id = SMB+7 }, -- Vanguard Eye
    [SMB+8] = { id = SMB+8 }, -- Vanguard Eye
    [SMB+9] = { id = SMB+9 }, -- Vanguard Eye
    [SMB+10] = { id = SMB+10 }, -- Tombstone Prototype TE30
    [SMB+11] = { id = SMB+11 }, -- Vanguard Eye
    [SMB+12] = { id = SMB+12 }, -- Effigy Prototype
    [SMB+13] = { id = SMB+13 }, -- Vanguard Eye
    [SMB+14] = { id = SMB+14 }, -- Vanguard Eye
    [SMB+15] = { id = SMB+15 }, -- Vanguard Eye
    [SMB+16] = { id = SMB+16 }, -- Vanguard Eye
    [SMB+17] = { id = SMB+17 }, -- Vanguard Eye
    [SMB+18] = { id = SMB+18 }, -- Vanguard Eye
    [SMB+19] = { id = SMB+19 }, -- Vanguard Eye
    [SMB+20] = { id = SMB+20 }, -- Vanguard Eye
    [SMB+21] = { id = SMB+21 }, -- Vanguard Eye
    [SMB+22] = { id = SMB+22 }, -- Vanguard Eye
    [SMB+23] = { id = SMB+23 }, -- Vanguard Eye
    [SMB+24] = { id = SMB+24 }, -- Vanguard Eye
    [SMB+25] = { id = SMB+25 }, -- Vanguard Eye
    [SMB+26] = { id = SMB+26 }, -- Vanguard Eye
    [SMB+27] = { id = SMB+27 }, -- Vanguard Eye
    [SMB+28] = { id = SMB+28 }, -- Vanguard Eye
    [SMB+29] = { id = SMB+29 }, -- Vanguard Eye
    [SMB+30] = { id = SMB+30 }, -- Vanguard Eye
    [SMB+31] = { id = SMB+31 }, -- Vanguard Eye
    [SMB+32] = { id = SMB+32 }, -- Vanguard Eye
    [SMB+33] = { id = SMB+33 }, -- Vanguard Eye
    [SMB+34] = { id = SMB+34 }, -- Vanguard Eye
    [SMB+35] = { id = SMB+35 }, -- Vanguard Eye (spawns 36-38)
    [SMB+36] = { id = SMB+36 }, -- Vanguard Eye
    [SMB+37] = { id = SMB+37 }, -- Vanguard Eye
    [SMB+38] = { id = SMB+38 }, -- Vanguard Eye
    [SMB+39] = { id = SMB+39 }, -- Vanguard Eye (spawns 40-42)
    [SMB+40] = { id = SMB+40 }, -- Vanguard Eye
    [SMB+41] = { id = SMB+41 }, -- Vanguard Eye
    [SMB+42] = { id = SMB+42 }, -- Vanguard Eye
    [SMB+43] = { id = SMB+43 }, -- Icon Prototype TE 30
    [SMB+44] = { id = SMB+44 }, -- Vanguard Eye
    [SMB+45] = { id = SMB+45 }, -- Vanguard Eye
    [SMB+46] = { id = SMB+46 }, -- Vanguard Eye
    [SMB+47] = { id = SMB+47 }, -- Vanguard Eye
    [SMB+48] = { id = SMB+48 }, -- Vanguard Eye
    [SMB+49] = { id = SMB+49 }, -- Vanguard Eye
    [SMB+50] = { id = SMB+50 }, -- Vanguard Eye
    [SMB+51] = { id = SMB+51 }, -- Vanguard Eye
    [SMB+52] = { id = SMB+52 }, -- Icon Prototype MP
    [SMB+53] = { id = SMB+53 }, -- Vanguard Eye
    [SMB+54] = { id = SMB+54 }, -- Vanguard Eye
    [SMB+55] = { id = SMB+55 }, -- Vanguard Eye
    [SMB+56] = { id = SMB+56 }, -- Vanguard Eye
    [SMB+57] = { id = SMB+57 }, -- Vanguard Eye
    [SMB+58] = { id = SMB+58 }, -- Vanguard Eye
    [SMB+59] = { id = SMB+59 }, -- Vanguard Eye
    [SMB+60] = { id = SMB+60 }, -- Tombstone Prototype TE 30
    [SMB+61] = { id = SMB+61 }, -- Vanguard Eye
    [SMB+62] = { id = SMB+62 }, -- Vanguard Eye
    [SMB+63] = { id = SMB+63 }, -- Vanguard Eye
    [SMB+64] = { id = SMB+64 }, -- Vanguard Eye
    [SMB+65] = { id = SMB+65 }, -- Vanguard Eye
    [SMB+66] = { id = SMB+66 }, -- Vanguard Eye
    [SMB+67] = { id = SMB+67 }, -- Vanguard Eye
    [SMB+68] = { id = SMB+68 }, -- Vanguard Eye
    [SMB+69] = { id = SMB+69 }, -- Vanguard Eye
    [SMB+70] = { id = SMB+70 }, -- Vanguard Eye
    [SMB+71] = { id = SMB+71 }, -- Vanguard Eye
    [SMB+72] = { id = SMB+72 }, -- Vanguard Eye
    [SMB+73] = { id = SMB+73 }, -- Icon Prototype (MP)
    [SMB+74] = { id = SMB+74 }, -- Vanguard Eye
    [SMB+75] = { id = SMB+75 }, -- Vanguard Eye
    [SMB+76] = { id = SMB+76 }, -- Vanguard Eye
    [SMB+77] = { id = SMB+77 }, -- Tombstone Prototype (MP)
    [SMB+78] = { id = SMB+78 }, -- Vanguard Eye
    [SMB+79] = { id = SMB+79 }, -- Vanguard Eye
    [SMB+80] = { id = SMB+80 }, -- Vanguard Eye
    [SMB+81] = { id = SMB+81 }, -- Vanguard Eye
    [SMB+82] = { id = SMB+82 }, -- Vanguard Eye
    [SMB+83] = { id = SMB+83 }, -- Vanguard Eye
    [SMB+84] = { id = SMB+84 }, -- Vanguard Eye
    [SMB+85] = { id = SMB+85 }, -- Vanguard Eye
    [SMB+86] = { id = SMB+86 }, -- Vanguard Eye
    [SMB+87] = { id = SMB+87 }, -- Vanguard Eye
    [SMB+88] = { id = SMB+88 }, -- Vanguard Eye
    [SMB+89] = { id = SMB+89 }, -- Vanguard Eye
    [SMB+90] = { id = SMB+90 }, -- Vanguard Eye
    [SMB+91] = { id = SMB+91 }, -- Vanguard Eye
    [SMB+92] = { id = SMB+92 }, -- Vanguard Eye
    [SMB+93] = { id = SMB+93 }, -- Vanguard Eye
    [SMB+94] = { id = SMB+94 }, -- Vanguard Eye
    [SMB+95] = { id = SMB+95 }, -- Vanguard Eye
    [SMB+96] = { id = SMB+96 }, -- Vanguard Eye
    [SMB+97] = { id = SMB+97 }, -- Vanguard Eye
    [SMB+98] = { id = SMB+98 }, -- Vanguard Eye
    [SMB+99] = { id = SMB+99 }, -- Vanguard Eye
    [SMB+100] = { id = SMB+100 }, -- Vanguard Eye
    [SMB+101] = { id = SMB+101 }, -- Vanguard Eye
    [SMB+102] = { id = SMB+102 }, -- Vanguard Eye
    [SMB+103] = { id = SMB+103 }, -- Vanguard Eye
    [SMB+104] = { id = SMB+104 }, -- Vanguard Eye
    [SMB+105] = { id = SMB+105 }, -- Vanguard Eye
    [SMB+106] = { id = SMB+106 }, -- Vanguard Eye
    [SMB+107] = { id = SMB+107 }, -- Vanguard Eye
    [SMB+108] = { id = SMB+108 }, -- Vanguard Eye
    [SMB+109] = { id = SMB+109 }, -- Vanguard Eye
    [SMB+110] = { id = SMB+110 }, -- Vanguard Eye
    [SMB+111] = { id = SMB+111 }, -- Vanguard Eye
    [SMB+112] = { id = SMB+112 }, -- Effigy Prototype HP
    [SMB+113] = { id = SMB+113 }, -- Vanguard Eye
    [SMB+114] = { id = SMB+114 }, -- Vanguard Eye
    [SMB+115] = { id = SMB+115 }, -- Vanguard Eye
    [SMB+116] = { id = SMB+116 }, -- Vanguard Eye
    [SMB+117] = { id = SMB+117 }, -- Vanguard Eye
    [SMB+118] = { id = SMB+118 }, -- Vanguard Eye
    [SMB+119] = { id = SMB+119 }, -- Vanguard Eye
    [SMB+120] = { id = SMB+120 }, -- Vanguard Eye
    [SMB+121] = { id = SMB+121 }, -- Vanguard Eye
    [SMB+122] = { id = SMB+122 }, -- Vanguard Eye
    [SMB+123] = { id = SMB+123 }, -- Vanguard Eye
    [SMB+124] = { id = SMB+124 }, -- Vanguard Eye
    [SMB+125] = { id = SMB+125 }, -- Vanguard Eye
    [SMB+126] = { id = SMB+126 }, -- Vanguard Eye
    [SMB+127] = { id = SMB+127 }, -- Vanguard Eye -- Marquis Decarabia BRD
    [SMB+128] = { id = SMB+128 }, -- Vanguard Eye -- Count Zaebos WAR
    [SMB+129] = { id = SMB+129 }, -- Vanguard Eye -- Duke Berith RDM
    [SMB+130] = { id = SMB+130 }, -- Vanguard Eye -- Prince Seere WHM
    [SMB+131] = { id = SMB+131 }, -- Vanguard Eye -- Duke Gomory MNK
    [SMB+132] = { id = SMB+132 }, -- Vanguard Eye -- Marquis Andras BST
    [SMB+133] = { id = SMB+133 }, -- Vanguard Eye -- Marquis Gamygyn NIN
    [SMB+134] = { id = SMB+134 }, -- Vanguard Eye -- Duke Scox DRK
    [SMB+135] = { id = SMB+135 }, -- Vanguard Eye -- Marquis Orias BLM
    [SMB+136] = { id = SMB+136 }, -- Vanguard Eye -- Count Raum THF
    [SMB+137] = { id = SMB+137 }, -- Vanguard Eye -- Marquis Sabnak PLD
    [SMB+138] = { id = SMB+138 }, -- Vanguard Eye -- Marquis Nebiros SMN
    [SMB+139] = { id = SMB+139 }, -- Vanguard Eye -- King Zagan DRG
    [SMB+140] = { id = SMB+140 }, -- Vanguard Eye -- Count Vine SAM
    [SMB+141] = { id = SMB+141 }, -- Vanguard Eye -- Marquis Cimeries RNG
    [SMB+142] = { id = SMB+142 }, -- Effigy Prototype HP
    [SMB+143] = { id = SMB+143 }, -- Statue Prototype TE 30
    [SMB+144] = { id = SMB+144 }, -- Vanguard Eye
    [SMB+145] = { id = SMB+145 }, -- Vanguard Eye
    [SMB+146] = { id = SMB+146 }, -- Vanguard Eye
    [SMB+147] = { id = SMB+147 }, -- Vanguard Eye
    [SMB+148] = { id = SMB+148 }, -- Vanguard Eye
    [SMB+149] = { id = SMB+149 }, -- Vanguard Eye
    [SMB+150] = { id = SMB+150 }, -- Statue Prototype TE 30
    [SMB+151] = { id = SMB+151 }, --
    [SMB+152] = { id = SMB+152 }, --
    [SMB+153] = { id = SMB+153 }, --
    [SMB+154] = { id = SMB+154 }, --
    [SMB+155] = { id = SMB+155 }, --
    [SMB+156] = { id = SMB+156 }, --
    [SMB+157] = { id = SMB+157 }, --
    [SMB+158] = { id = SMB+158 }, --
    [SMB+159] = { id = SMB+159 }, --
    [SMB+160] = { id = SMB+160 }, --
    [SMB+161] = { id = SMB+161 }, --
    [SMB+162] = { id = SMB+162 }, --
    [SMB+163] = { id = SMB+163 }, --
    [SMB+164] = { id = SMB+164 }, --
    [SMB+165] = { id = SMB+165 }, --
    [SMB+166] = { id = SMB+166 }, --
    [SMB+167] = { id = SMB+167 }, -- Vanguard Dragon
    [SMB+168] = { id = SMB+168 }, -- Vanguard Dragon
    [SMB+169] = { id = SMB+169 }, -- Vanguard Dragon
    [SMB+170] = { id = SMB+170 }, -- Vanguard Dragon
    [SMB+171] = { id = SMB+171 }, -- Vanguard Dragon
    [SMB+172] = { id = SMB+172 }, -- Vanguard Dragon
    [SMB+173] = { id = SMB+173 }, -- Vanguard Dragon
    [SMB+174] = { id = SMB+174 }, -- Vanguard Dragon
    [SMB+175] = { id = SMB+175 }, -- Vanguard Dragon
    [SMB+176] = { id = SMB+176 }, -- Vanguard Dragon
    [SMB+177] = { id = SMB+177 }, --
    [SMB+178] = { id = SMB+178 }, --
    [SMB+179] = { id = SMB+179 }, --
    [SMB+180] = { id = SMB+180 }, --
    [SMB+181] = { id = SMB+181 }, --
    [SMB+182] = { id = SMB+182 }, --
    [SMB+183] = { id = SMB+183 }, --
    [SMB+184] = { id = SMB+184 }, --
    [SMB+185] = { id = SMB+185 }, --
    [SMB+186] = { id = SMB+186 }, --
    [SMB+187] = { id = SMB+187 }, --
    [SMB+188] = { id = SMB+188 }, --
    [SMB+189] = { id = SMB+189 }, --
    [SMB+190] = { id = SMB+190 }, --
    [SMB+191] = { id = SMB+191 }, --
    [SMB+192] = { id = SMB+192 }, --
    [SMB+193] = { id = SMB+193 }, --
    [SMB+194] = { id = SMB+194 }, --
    [SMB+195] = { id = SMB+195 }, --
    [SMB+196] = { id = SMB+196 }, --
    [SMB+197] = { id = SMB+197 }, --
    [SMB+198] = { id = SMB+198 }, --
    [SMB+199] = { id = SMB+199 }, --
    [SMB+200] = { id = SMB+200 }, --
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_XARCABARD

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
mobList[zone][DMB+1  ].pos = { -414.2820, -44.0000, 20.4270, 0   }
mobList[zone][SMB+1  ].pos = {  424.1293, 0.4751, -178.5404, 118 }
mobList[zone][SMB+2  ].pos = {  411.1541,-0.2269, -172.5790, 47  }
mobList[zone][SMB+3  ].pos = {  406.5320, 0.2936, -187.7396, 232 }
mobList[zone][SMB+4  ].pos = {  419.7373, 0.5091, -190.8261, 163 }
mobList[zone][SMB+5  ].pos = {  414.4022,-0.3546, -182.0117, 0   }
mobList[zone][SMB+6  ].pos = {  349.2125, 8.2605, -192.8115, 160 }
mobList[zone][SMB+7  ].pos = {  346.6184, 8.4416, -200.3669, 116 }
mobList[zone][SMB+8  ].pos = {  360.3178, 7.9544, -204.3077, 33  }
mobList[zone][SMB+9  ].pos = {  361.7702, 8.0233, -195.5119, 247 }
mobList[zone][SMB+10 ].pos = {  354.4850, 8.0746, -198.8310, 201 }
mobList[zone][SMB+11 ].pos = {  366.3824, 0.5812, -253.2608, 222 }
mobList[zone][SMB+12 ].pos = {  360.5640, 0.2452, -248.9267, 219 }
mobList[zone][SMB+13 ].pos = {  352.6051, 0.0714, -245.5541, 211 }
mobList[zone][SMB+14 ].pos = {  343.9028, 0.2481, -289.3212, 210 }
mobList[zone][SMB+15 ].pos = {  338.4755, 0.4983, -288.4618, 195 }
mobList[zone][SMB+16 ].pos = {  331.9529, 0.2026, -287.8621, 187 }
mobList[zone][SMB+17 ].pos = {  304.9144, 6.1379, -249.2820, 58  }
mobList[zone][SMB+18 ].pos = {  311.8788, 7.5565, -237.4718, 251 }
mobList[zone][SMB+19 ].pos = {  310.6456, 6.1862, -218.2143, 228 }
mobList[zone][SMB+20 ].pos = {  242.8440, -8.3035, -236.5309, 19 }
mobList[zone][SMB+21 ].pos = {  247.3115, -10.3789, -225.4024, 10}
mobList[zone][SMB+22 ].pos = {  251.7796, -11.8153, -214.2299, 15}
mobList[zone][SMB+23 ].pos = {  264.3314, -6.3296, -198.5750, 31 }
mobList[zone][SMB+24 ].pos = {  270.2761, -5.7290, -187.2165, 31 }
mobList[zone][SMB+25 ].pos = {  276.8286, -5.6503, -177.1220, 21 }
mobList[zone][SMB+26 ].pos = {  381.9445, -4.0833, -95.9521, 32  }
mobList[zone][SMB+27 ].pos = {  378.4275, -5.7032, -92.4321, 32  }
mobList[zone][SMB+28 ].pos = {  374.8895, -6.5000, -88.8913, 32  }
mobList[zone][SMB+29 ].pos = {  297.7394, -5.2740, -102.6164, 62 }
mobList[zone][SMB+30 ].pos = {  298.0390, -7.7612, -97.1668, 191 }
mobList[zone][SMB+31 ].pos = {  291.0302, -7.3199, -97.3795, 62  }
mobList[zone][SMB+32 ].pos = {  290.7523, -8.2855, -92.5171, 189 }
mobList[zone][SMB+33 ].pos = {  283.7681, -7.4053, -92.8302, 64  }
mobList[zone][SMB+34 ].pos = {  283.6383, -7.8111, -87.8017, 190 }
mobList[zone][SMB+35 ].pos = {  232.0036, -19.0781, -165.1964, 150 }
mobList[zone][SMB+36 ].pos = {  229.4250, -20.7388, -168.6801, 149 }
mobList[zone][SMB+37 ].pos = {  232.7480, -20.7388, -170.5852, 159 }
mobList[zone][SMB+38 ].pos = {  234.2837, -20.6722, -166.8051, 155 }
mobList[zone][SMB+39 ].pos = {  234.5874, -19.1802, -161.8466, 147 }
mobList[zone][SMB+40 ].pos = {  235.5074, -20.7388, -157.9036, 150 }
mobList[zone][SMB+41 ].pos = {  238.2971, -20.7388, -159.5938, 141 }
mobList[zone][SMB+42 ].pos = {  236.8613, -20.7052, -162.9283, 155 }
mobList[zone][SMB+43 ].pos = {  235.3885, -20.6618, -164.8875, 149 }
mobList[zone][SMB+44 ].pos = {  212.2299, -17.2562, -225.9583, 253 }
mobList[zone][SMB+45 ].pos = {  208.1801, -16.7650, -228.9911, 62  }
mobList[zone][SMB+46 ].pos = {  204.6303, -18.8527, -225.5164, 135 }
mobList[zone][SMB+47 ].pos = {  208.4378, -18.8582, -222.6815, 194 }
mobList[zone][SMB+48 ].pos = {  174.3926, -18.8233, -139.4571, 29  }
mobList[zone][SMB+49 ].pos = {  163.9518, -20.3809, -139.4437, 94  }
mobList[zone][SMB+50 ].pos = {  164.5739, -16.9460, -129.4864, 160 }
mobList[zone][SMB+51 ].pos = {  173.8166, -17.7018, -129.4484, 223 }
mobList[zone][SMB+52 ].pos = {  169.2042, -18.2180, -134.7736, 0   }
mobList[zone][SMB+53 ].pos = {  149.4144, -18.4039, -99.3362, 22   }
mobList[zone][SMB+54 ].pos = {  240.6901, -15.3077, -138.7996, 1   }
mobList[zone][SMB+55 ].pos = {  237.2858, -8.0000, -82.7372, 18    }
mobList[zone][SMB+56 ].pos = {  160.4315, -16.0000, -79.9672, 30   }
mobList[zone][SMB+57 ].pos = {  197.4896, -7.4749, 26.6946, 59     }
mobList[zone][SMB+58 ].pos = {  202.4719, -7.4778, 26.7363, 75     }
mobList[zone][SMB+59 ].pos = {  207.2917, -7.8752, 25.2688, 83     }
mobList[zone][SMB+60 ].pos = {  204.1456, -7.9310, 34.5961, 75     }
mobList[zone][SMB+61 ].pos = {  278.9015, -7.7302, 49.4191, 83     }
mobList[zone][SMB+62 ].pos = {  275.8966, -7.2308, 55.7405, 126    }
mobList[zone][SMB+63 ].pos = {  280.3802, -7.0575, 61.1266, 195    }
mobList[zone][SMB+64 ].pos = {  286.5690, -7.3786, 57.6816, 236    }
mobList[zone][SMB+65 ].pos = {  286.6652, -7.7961, 50.4755, 18     }
mobList[zone][SMB+66 ].pos = {  367.8774, -7.8073, 120.7682, 5     }
mobList[zone][SMB+67 ].pos = {  367.1385, -8.1712, 112.7752, 8     }
mobList[zone][SMB+68 ].pos = {  355.6019, -7.2450, -58.0073, 61    }
mobList[zone][SMB+69 ].pos = {  368.1302, -8.8291, -58.4434, 62    }
mobList[zone][SMB+70 ].pos = {  380.6304, -3.1784, -58.9766, 64    }
mobList[zone][SMB+71 ].pos = {  392.9741, -0.7745, -61.0018, 64    }
mobList[zone][SMB+72 ].pos = {  405.4319, 0.4546, -62.2839, 68     }
mobList[zone][SMB+73 ].pos = {  384.3539, -3.1706, -44.0433, 77    }
mobList[zone][SMB+74 ].pos = {  398.0475, -5.6198, -15.0955, 63    }
mobList[zone][SMB+75 ].pos = {  390.0092, -7.7016, 0.9627, 157     }
mobList[zone][SMB+76 ].pos = {  404.8032, -7.8646, 1.9129, 223     }
mobList[zone][SMB+77 ].pos = {  397.8393, -7.8562, -5.2043, 63     }
mobList[zone][SMB+78 ].pos = {  433.9671, -1.6716, 52.7199, 95     }
mobList[zone][SMB+79 ].pos = {  433.7292, -5.0768, 62.3223, 156    }
mobList[zone][SMB+80 ].pos = {  443.8177, -5.6656, 62.6060, 222    }
mobList[zone][SMB+81 ].pos = {  444.6903, -2.6507, 53.6754, 30     }
mobList[zone][SMB+82 ].pos = {  438.9351, -3.8096, 57.6335, 61     }
mobList[zone][SMB+83 ].pos = {  488.6499, -0.3915, 37.6619, 175    }
mobList[zone][SMB+84 ].pos = {  482.3507, -0.1661, 32.7014, 162    }
mobList[zone][SMB+85 ].pos = {  489.0281, -0.2256, 29.6058, 156    }
mobList[zone][SMB+86 ].pos = {  501.9442, -7.8484, 198.5639, 68    }
mobList[zone][SMB+87 ].pos = {  504.2140, -8.1312, 207.0567, 70    }
mobList[zone][SMB+88 ].pos = {  534.2434, -7.8169, 221.5235, 119   }
mobList[zone][SMB+89 ].pos = {  60.5113, -24.0736, -267.0519, 182  }
mobList[zone][SMB+90 ].pos = {  60.1930, -23.8032, -274.8913, 71   }
mobList[zone][SMB+91 ].pos = {  91.3642, -24.0450, -251.7222, 158  }
mobList[zone][SMB+92 ].pos = {  97.5249, -23.9710, -264.3413, 48   }
mobList[zone][SMB+93 ].pos = {  6.8732, -23.8575, -362.9837, 195   }
mobList[zone][SMB+94 ].pos = {  16.8527, -23.1585, -363.1671, 196  }
mobList[zone][SMB+95 ].pos = {  26.8581, -23.4904, -362.9120, 191  }
mobList[zone][SMB+96 ].pos = {  36.8740, -24.0000, -362.7977, 191  }
mobList[zone][SMB+97 ].pos = { -28.5253, -15.6275, 42.0637, 0      }
mobList[zone][SMB+98 ].pos = { -27.8314, -15.8221, 33.8259, 0      }
mobList[zone][SMB+99 ].pos = { 49.7393, -15.7784, 15.4163, 36      }
mobList[zone][SMB+100].pos = { 43.6486, -15.6278, 11.4668, 48      }
mobList[zone][SMB+101].pos = { 36.3999, -15.7803, 8.4163, 43       }
mobList[zone][SMB+102].pos = { 65.5793, -17.6682, -47.7914, 14     }
mobList[zone][SMB+103].pos = { 67.9447, -18.0770, -40.1728, 255    }
mobList[zone][SMB+104].pos = { 64.0896, -24.0238, -74.4542, 58     }
mobList[zone][SMB+105].pos = { 80.9163, -23.7844, -74.2179, 65     }
mobList[zone][SMB+106].pos = {  23.2533, -33.0965, 139.2529, 67    }
mobList[zone][SMB+107].pos = {  23.0874, -34.1983, 144.2162, 0     }
mobList[zone][SMB+108].pos = {  23.0806, -34.8438, 149.1463, 125   }
mobList[zone][SMB+109].pos = {  22.5083, -35.0776, 154.2627, 181   }
mobList[zone][SMB+110].pos = {-117.4516, -36.0000, 80.3362, 73     }
mobList[zone][SMB+111].pos = {-111.8803, -36.2595, 80.4930, 63     }
mobList[zone][SMB+112].pos = {-107.7923, -39.8030, 35.8958, 159    }
mobList[zone][SMB+113].pos = {-136.6303, -28.1860, 85.6807, 61     }
mobList[zone][SMB+114].pos = {-138.6653, -20.2562, 115.8844, 54    }
mobList[zone][SMB+115].pos = { 44.6229, -35.7960, 110.5585, 191    }
mobList[zone][SMB+116].pos = { 38.1159, -35.7175, 110.3267, 199    }
mobList[zone][SMB+117].pos = { 219.4501, -23.0169, 133.2112, 63    }
mobList[zone][SMB+118].pos = { 215.0627, -24.7103, 137.4886, 65    }
mobList[zone][SMB+119].pos = { 219.4539, -25.7846, 142.8087, 62    }
mobList[zone][SMB+120].pos = { 223.0426, -24.8310, 137.9934, 63    }
mobList[zone][SMB+121].pos = { 173.1911, -33.3553, 68.7402, 131    }
mobList[zone][SMB+122].pos = { 190.3257, -28.9476, 88.3894, 187    }
mobList[zone][SMB+123].pos = { 240.7466, -27.3345, 94.7047, 190    }
mobList[zone][SMB+124].pos = { 246.9428, -27.4052, 95.9730, 190    }
mobList[zone][SMB+125].pos = { 300.8132, -27.8000, 220.3610, 63    }
mobList[zone][SMB+126].pos = { 298.7344, -28.0975, 229.8743, 63    }
mobList[zone][SMB+127].pos = { 150.5660, -21.0480, -36.7252, 94    }
mobList[zone][SMB+128].pos = { 155.2857, -21.0238, -40.4494, 92    }
mobList[zone][SMB+129].pos = { 159.5335, -21.0480, -44.6545, 94    }
mobList[zone][SMB+130].pos = { 119.6976, -28.7700, -112.1791, 127  }
mobList[zone][SMB+131].pos = { 119.6369, -28.7261, -118.1067, 129  }
mobList[zone][SMB+132].pos = { 119.5703, -28.7700, -124.0673, 128  }
mobList[zone][SMB+133].pos = {  66.0471, -28.5111, -200.4550, 97   }
mobList[zone][SMB+134].pos = {  61.7481, -28.4765, -196.2649, 95   }
mobList[zone][SMB+135].pos = {  57.0693, -28.5111, -192.5350, 95   }
mobList[zone][SMB+136].pos = {  39.2806, -28.7143, -139.9675, 125  }
mobList[zone][SMB+137].pos = {  39.5865, -28.6676, -134.0237, 127  }
mobList[zone][SMB+138].pos = {  39.5281, -28.7143, -128.0194, 126  }
mobList[zone][SMB+139].pos = {  -7.1555, -28.5546, -106.6829, 144  }
mobList[zone][SMB+140].pos = {  -4.9817, -28.4989, -101.1111, 139  }
mobList[zone][SMB+141].pos = {  -2.8697, -28.5546, -95.5164, 146   }
mobList[zone][SMB+142].pos = { -45.5989, -24.2095, -125.2383, 230  }
mobList[zone][SMB+143].pos = { -86.0996, -24.2289, -85.1929, 232   }
mobList[zone][SMB+144].pos = {-129.0694, -23.7477, -43.8721, 6     }
mobList[zone][SMB+145].pos = {-128.6296, -23.2130, -33.8281, 9     }
mobList[zone][SMB+146].pos = {-127.8140, -22.4947, -23.8494, 6     }
mobList[zone][SMB+147].pos = {-127.0488, -18.8946, -13.8742, 6     }
mobList[zone][SMB+148].pos = {-125.7572, -15.9298, -4.0155, 9      }
mobList[zone][SMB+149].pos = {-124.7990, -16.0928, 5.8331, 27      }
mobList[zone][SMB+150].pos = {-150.0562, -16.1019, -6.8322, 23     }
mobList[zone][DMB+7  ].pos = { -365.6851, -36.0043, 15.7061, 253   } -- ying
mobList[zone][DMB+8  ].pos = { -366.2450, -36.3298, 24.8477, 255   } -- yang
mobList[zone][DMB+23 ].pos = { 342.1594, -27.8198, 378.1761, 68    } -- animated knuckles
mobList[zone][DMB+24 ].pos = { 146.8420, -25.2636, -226.5739, 3    } -- animated dagger
mobList[zone][DMB+25 ].pos = { 582.5316, -8.0575, 296.7370, 73     } -- animated longsword
mobList[zone][DMB+26 ].pos = { -22.1978, -24.5956, -493.4288, 199  } -- animated claymore
mobList[zone][DMB+27 ].pos = { -122.0494, -36.0412, 124.8039, 58   } -- animated tabar
mobList[zone][DMB+28 ].pos = { 320.5472, -8.3209, 168.3653, 72     } -- animated great axe
mobList[zone][DMB+29 ].pos = { 152.0960, -35.9728, 19.3087, 224    } -- animated spear
mobList[zone][DMB+30 ].pos = { 577.9836, 0.1949, -18.2714, 195     } -- animated scythe
mobList[zone][DMB+31 ].pos = { 241.9540, -28.4264, 63.3540, 199    } -- animated kunai
mobList[zone][DMB+32 ].pos = { -100.4566, -15.8000, 138.8280, 128  } -- animated tachi
mobList[zone][DMB+33 ].pos = { 338.2422, 0.0671, -377.4373, 192    } -- animated hammer
mobList[zone][DMB+34 ].pos = { 49.1101, -36.2815, 61.7415, 183     } -- animated staff
mobList[zone][DMB+35 ].pos = {-296.0583, -25.8233, 161.7301, 68    } -- animated longbow
mobList[zone][DMB+36 ].pos = {-255.5342, -17.6566, -161.5427, 192  } -- animated gun
mobList[zone][DMB+37 ].pos = { 386.6498, -9.5122, 25.9243, 21      } -- animated horn
mobList[zone][DMB+38 ].pos = { 90.9604, -24.0000, -375.0468, 218   } -- animated shield
mobList[zone][DMB+331].pos = {-213.8854, -6.7935, 42.7936, 1       }
mobList[zone][DMB+332].pos = {-237.1062, -11.4733, 66.6790, 228    }
mobList[zone][DMB+333].pos = {-247.0509, -11.9911, -11.5988, 253   }
mobList[zone][DMB+334].pos = {-235.2860, -11.7157, -87.2030, 0     }
mobList[zone][DMB+335].pos = {-276.5036, -20.0000, -81.0512, 255   }
mobList[zone][DMB+336].pos = {-268.2993, -18.4545, 33.5037, 45     }
mobList[zone][DMB+343].pos = {-284.7049, -20.2053, 121.2283, 59    }
mobList[zone][DMB+344].pos = {-317.0527, -27.8170, 72.3022, 21     }
mobList[zone][DMB+345].pos = {-297.9739, -23.4600, -2.6931, 226    }
mobList[zone][DMB+352].pos = {-308.7357, -26.5187, -37.8035, 226   }

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path = { 11, 22, 33, 66, 77, 88, }

-- set statue eye color
mobList[zone][SMB+10 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+43 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+52 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+60 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+73 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+77 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+112].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+142].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+143].eyes = dynamis.eyes.RED
mobList[zone][SMB+150].eyes = dynamis.eyes.RED
-- set time extensions
mobList[zone][SMB+10 ].timeExtension = 30 -- Tombstone Prototype
mobList[zone][SMB+43 ].timeExtension = 30 -- Icon Prototype TE
mobList[zone][SMB+60 ].timeExtension = 30 -- Tombstone Prototype
mobList[zone][SMB+143].timeExtension = 30 -- Statue Prototype
mobList[zone][SMB+150].timeExtension = 30 -- Statue Prototype

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { SMB+035, SMB+039 } -- spawns 043 when defeated
mobList[zone].waveDefeatRequirements[3] = { SMB+058 } -- spawns 060 when defeated
mobList[zone].waveDefeatRequirements[4] = { SMB+142, SMB+143, SMB+144, SMB+145, SMB+146, SMB+147, SMB+148, SMB+149 } -- spawns 050 when defeated
mobList[zone].waveDefeatRequirements[5] = { DMB+47, DMB+201, DMB+177, DMB+156, DMB+128, DMB+214, DMB+275, DMB+241,
                                            DMB+167, DMB+139, DMB+184, DMB+305, DMB+254, DMB+264, DMB+239 } -- Demon NMs spawn Animated Weapons, Vanguard Dragons, Ying, Yang
mobList[zone].waveDefeatRequirements[6] = { DMB+7, DMB+8 } -- spawns Dynamis Lord when Yin and Yang are defeated

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+2  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+3  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+4  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+5  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+6  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+7  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+8  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+9  ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+10 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+11 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+12 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+13 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+14 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+15 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+16 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+17 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+18 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+19 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+20 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+21 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+22 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+23 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+24 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+25 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+26 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+27 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+28 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+29 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+30 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+31 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+32 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+33 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+34 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+38 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+42 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+44 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+45 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+46 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+47 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+48 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+49 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+50 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+51 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+52 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+53 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+54 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+55 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+56 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+57 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+58 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+59 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+61 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+62 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+63 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+64 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+65 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+66 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+67 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+68 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+69 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+70 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+71 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+72 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+73 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+74 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+75 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+76 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+77 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+78 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+79 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+80 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+81 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+82 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+83 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+84 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+85 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+86 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+87 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+88 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+89 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+90 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+91 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+92 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+93 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+94 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+96 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+97 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+98 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+100].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+101].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+102].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+103].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+104].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+105].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+106].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+107].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+108].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+109].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+110].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+111].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+112].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+113].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+114].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+115].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+116].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+117].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+118].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+119].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+120].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+121].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+122].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+123].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+124].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+125].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+126].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+127].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+128].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+129].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+130].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+131].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+132].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+133].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+134].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+135].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+136].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+137].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+138].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+139].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+140].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+141].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+142].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+143].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+144].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+145].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+146].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+147].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+148].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+149].waves = {  1 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+43 ].waves = { nil, 2 ,nil,nil,nil,nil }
mobList[zone][SMB+60 ].waves = { nil,nil, 3 ,nil,nil,nil }
mobList[zone][SMB+150].waves = { nil,nil,nil, 4 ,nil,nil } -- Statue Prototype
mobList[zone][DMB+23 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Knuckels
mobList[zone][DMB+24 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Dagger
mobList[zone][DMB+25 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Longsw
mobList[zone][DMB+26 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Claymo
mobList[zone][DMB+27 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Tabar
mobList[zone][DMB+28 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Great
mobList[zone][DMB+29 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Spear
mobList[zone][DMB+30 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Scythe
mobList[zone][DMB+31 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Kunai
mobList[zone][DMB+32 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Tachi
mobList[zone][DMB+33 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Hammer
mobList[zone][DMB+34 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Staff
mobList[zone][DMB+35 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Longbo
mobList[zone][DMB+36 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Gun
mobList[zone][DMB+37 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Horn
mobList[zone][DMB+38 ].waves = { nil,nil,nil,nil, 5 ,nil } -- Animated Shield
mobList[zone][DMB+331].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+332].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+333].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+334].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+335].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+336].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+343].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+344].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+345].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+352].waves = { nil,nil,nil,nil, 5 ,nil } -- Vanguard Dragon
mobList[zone][DMB+7  ].waves = { nil,nil,nil,nil, 5 ,nil } -- Ying
mobList[zone][DMB+8  ].waves = { nil,nil,nil,nil, 5 ,nil } -- Yang
mobList[zone][DMB+1  ].waves = { nil,nil,nil,nil, nil, 6 } -- Dynamis Lord

-- set what mobIDs i will spawn when i engage (such as NMs or other statues)
-- mobList[zone][DMB+1  ].specificChildren = { true, DMB+7, DMB+8 }
mobList[zone][SMB+38 ].specificChildren = { true, SMB+35, SMB+36, SMB+37 }
mobList[zone][SMB+42 ].specificChildren = { true, SMB+39, SMB+40, SMB+41 }
mobList[zone][SMB+127].specificChildren = { true, DMB+47  } -- BRD NM
mobList[zone][SMB+128].specificChildren = { true, DMB+201 } -- WAR NM
mobList[zone][SMB+129].specificChildren = { true, DMB+177 } -- RDM NM
mobList[zone][SMB+130].specificChildren = { true, DMB+156 } -- WHM NM
mobList[zone][SMB+131].specificChildren = { true, DMB+128 } -- MNK NM
mobList[zone][SMB+132].specificChildren = { true, DMB+214 } -- BST NM
mobList[zone][SMB+133].specificChildren = { true, DMB+275 } -- NIN NM
mobList[zone][SMB+134].specificChildren = { true, DMB+241 } -- DRK NM
mobList[zone][SMB+135].specificChildren = { true, DMB+167 } -- BLM NM
mobList[zone][SMB+136].specificChildren = { true, DMB+139 } -- THF NM
mobList[zone][SMB+137].specificChildren = { true, DMB+184 } -- PLD NM
mobList[zone][SMB+138].specificChildren = { true, DMB+305 } -- SMN NM
mobList[zone][SMB+139].specificChildren = { true, DMB+254 } -- DRG NM
mobList[zone][SMB+140].specificChildren = { true, DMB+264 } -- SAM NM
mobList[zone][SMB+141].specificChildren = { true, DMB+239 } -- RNG NM
mobList[zone][DMB+23 ].specificChildren = { true, DMB+133, DMB+134, DMB+135, DMB+143, DMB+144, DMB+145 } -- Animated Knuckels
mobList[zone][DMB+24 ].specificChildren = { true, DMB+130, DMB+131, DMB+132, DMB+140, DMB+141, DMB+142 } -- Animated Dagger
mobList[zone][DMB+25 ].specificChildren = { true, DMB+179, DMB+180, DMB+181, DMB+186, DMB+187, DMB+188 } -- Animated Longsword
mobList[zone][DMB+26 ].specificChildren = { true, DMB+189, DMB+190, DMB+191, DMB+196, DMB+197, DMB+198 } -- Animated Claymo
mobList[zone][DMB+27 ].specificChildren = { true, DMB+204, DMB+205, DMB+206, DMB+216, DMB+217, DMB+218 } -- Animated Tabar
mobList[zone][DMB+28 ].specificChildren = { true, DMB+207, DMB+208, DMB+209, DMB+219, DMB+220, DMB+221 } -- Animated Great
mobList[zone][DMB+29 ].specificChildren = { true, DMB+247, DMB+248, DMB+249, DMB+259, DMB+260, DMB+261 } -- Animated Spear
mobList[zone][DMB+30 ].specificChildren = { true, DMB+244, DMB+245, DMB+246, DMB+256, DMB+257, DMB+258 } -- Animated Scythe
mobList[zone][DMB+31 ].specificChildren = { true, DMB+266, DMB+267, DMB+268, DMB+278, DMB+279, DMB+280 } -- Animated Kunai
mobList[zone][DMB+32 ].specificChildren = { true, DMB+269, DMB+270, DMB+271, DMB+281, DMB+282, DMB+283 } -- Animated Tachi
mobList[zone][DMB+33 ].specificChildren = { true, DMB+158, DMB+159, DMB+160, DMB+168, DMB+169, DMB+170 } -- Animated Hammer
mobList[zone][DMB+34 ].specificChildren = { true, DMB+161, DMB+162, DMB+163, DMB+171, DMB+172, DMB+173 } -- Animated Staff
mobList[zone][DMB+35 ].specificChildren = { true, DMB+346, DMB+347, DMB+348, DMB+349, DMB+350, DMB+351 } -- Animated Longbo
mobList[zone][DMB+36 ].specificChildren = { true, DMB+337, DMB+338, DMB+339, DMB+340, DMB+341, DMB+342 } -- Animated Gun
mobList[zone][DMB+37 ].specificChildren = { true, DMB+319, DMB+320, DMB+321, DMB+327, DMB+328, DMB+329 } -- Animated Horn
mobList[zone][DMB+38 ].specificChildren = { true, DMB+114, DMB+115, DMB+116, DMB+123, DMB+124, DMB+125 } -- Animated Shield
-- set how many random children i will spawn when i engage
mobList[zone][SMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+2  ].randomChildrenCount = 2
mobList[zone][SMB+3  ].randomChildrenCount = 2
mobList[zone][SMB+4  ].randomChildrenCount = 2
mobList[zone][SMB+5  ].randomChildrenCount = 0
mobList[zone][SMB+6  ].randomChildrenCount = 3
mobList[zone][SMB+7  ].randomChildrenCount = 3
mobList[zone][SMB+8  ].randomChildrenCount = 3
mobList[zone][SMB+9  ].randomChildrenCount = 3
mobList[zone][SMB+11 ].randomChildrenCount = 6
mobList[zone][SMB+12 ].randomChildrenCount = 0
mobList[zone][SMB+13 ].randomChildrenCount = 6
mobList[zone][SMB+14 ].randomChildrenCount = 2
mobList[zone][SMB+15 ].randomChildrenCount = 2
mobList[zone][SMB+16 ].randomChildrenCount = 2
mobList[zone][SMB+17 ].randomChildrenCount = 4
mobList[zone][SMB+18 ].randomChildrenCount = 4
mobList[zone][SMB+19 ].randomChildrenCount = 4
mobList[zone][SMB+20 ].randomChildrenCount = 3
mobList[zone][SMB+21 ].randomChildrenCount = 2
mobList[zone][SMB+22 ].randomChildrenCount = 3
mobList[zone][SMB+23 ].randomChildrenCount = 3
mobList[zone][SMB+24 ].randomChildrenCount = 2
mobList[zone][SMB+25 ].randomChildrenCount = 3
mobList[zone][SMB+26 ].randomChildrenCount = 2
mobList[zone][SMB+27 ].randomChildrenCount = 2
mobList[zone][SMB+28 ].randomChildrenCount = 2
mobList[zone][SMB+29 ].randomChildrenCount = 2
mobList[zone][SMB+30 ].randomChildrenCount = 2
mobList[zone][SMB+31 ].randomChildrenCount = 2
mobList[zone][SMB+32 ].randomChildrenCount = 2
mobList[zone][SMB+33 ].randomChildrenCount = 2
mobList[zone][SMB+34 ].randomChildrenCount = 2
mobList[zone][SMB+35 ].randomChildrenCount = 0
mobList[zone][SMB+36 ].randomChildrenCount = 0
mobList[zone][SMB+37 ].randomChildrenCount = 0
mobList[zone][SMB+38 ].randomChildrenCount = 0
mobList[zone][SMB+39 ].randomChildrenCount = 0
mobList[zone][SMB+40 ].randomChildrenCount = 0
mobList[zone][SMB+41 ].randomChildrenCount = 0
mobList[zone][SMB+42 ].randomChildrenCount = 0
mobList[zone][SMB+43 ].randomChildrenCount = 0
mobList[zone][SMB+44 ].randomChildrenCount = 2
mobList[zone][SMB+45 ].randomChildrenCount = 2
mobList[zone][SMB+46 ].randomChildrenCount = 2
mobList[zone][SMB+47 ].randomChildrenCount = 2
mobList[zone][SMB+48 ].randomChildrenCount = 4
mobList[zone][SMB+49 ].randomChildrenCount = 3
mobList[zone][SMB+50 ].randomChildrenCount = 4
mobList[zone][SMB+51 ].randomChildrenCount = 3
mobList[zone][SMB+52 ].randomChildrenCount = 0
mobList[zone][SMB+53 ].randomChildrenCount = 4
mobList[zone][SMB+54 ].randomChildrenCount = 5
mobList[zone][SMB+55 ].randomChildrenCount = 4
mobList[zone][SMB+56 ].randomChildrenCount = 5
mobList[zone][SMB+57 ].randomChildrenCount = 3
mobList[zone][SMB+58 ].randomChildrenCount = 3
mobList[zone][SMB+59 ].randomChildrenCount = 3
mobList[zone][SMB+60 ].randomChildrenCount = 3
mobList[zone][SMB+61 ].randomChildrenCount = 3
mobList[zone][SMB+62 ].randomChildrenCount = 3
mobList[zone][SMB+63 ].randomChildrenCount = 3
mobList[zone][SMB+64 ].randomChildrenCount = 3
mobList[zone][SMB+65 ].randomChildrenCount = 3
mobList[zone][SMB+66 ].randomChildrenCount = 4
mobList[zone][SMB+67 ].randomChildrenCount = 4
mobList[zone][SMB+68 ].randomChildrenCount = 2
mobList[zone][SMB+69 ].randomChildrenCount = 2
mobList[zone][SMB+70 ].randomChildrenCount = 2
mobList[zone][SMB+71 ].randomChildrenCount = 3
mobList[zone][SMB+72 ].randomChildrenCount = 2
mobList[zone][SMB+73 ].randomChildrenCount = 0
mobList[zone][SMB+74 ].randomChildrenCount = 2
mobList[zone][SMB+75 ].randomChildrenCount = 2
mobList[zone][SMB+76 ].randomChildrenCount = 3
mobList[zone][SMB+77 ].randomChildrenCount = 0
mobList[zone][SMB+78 ].randomChildrenCount = 2
mobList[zone][SMB+79 ].randomChildrenCount = 2
mobList[zone][SMB+80 ].randomChildrenCount = 2
mobList[zone][SMB+81 ].randomChildrenCount = 2
mobList[zone][SMB+82 ].randomChildrenCount = 2
mobList[zone][SMB+83 ].randomChildrenCount = 3
mobList[zone][SMB+84 ].randomChildrenCount = 2
mobList[zone][SMB+85 ].randomChildrenCount = 3
mobList[zone][SMB+86 ].randomChildrenCount = 2
mobList[zone][SMB+87 ].randomChildrenCount = 2
mobList[zone][SMB+88 ].randomChildrenCount = 2
mobList[zone][SMB+89 ].randomChildrenCount = 3
mobList[zone][SMB+90 ].randomChildrenCount = 3
mobList[zone][SMB+91 ].randomChildrenCount = 3
mobList[zone][SMB+92 ].randomChildrenCount = 3
mobList[zone][SMB+93 ].randomChildrenCount = 2
mobList[zone][SMB+94 ].randomChildrenCount = 3
mobList[zone][SMB+95 ].randomChildrenCount = 2
mobList[zone][SMB+96 ].randomChildrenCount = 3
mobList[zone][SMB+97 ].randomChildrenCount = 3
mobList[zone][SMB+98 ].randomChildrenCount = 3
mobList[zone][SMB+99 ].randomChildrenCount = 2
mobList[zone][SMB+100].randomChildrenCount = 2
mobList[zone][SMB+101].randomChildrenCount = 2
mobList[zone][SMB+102].randomChildrenCount = 3
mobList[zone][SMB+103].randomChildrenCount = 3
mobList[zone][SMB+104].randomChildrenCount = 3
mobList[zone][SMB+105].randomChildrenCount = 3
mobList[zone][SMB+106].randomChildrenCount = 2
mobList[zone][SMB+107].randomChildrenCount = 3
mobList[zone][SMB+108].randomChildrenCount = 3
mobList[zone][SMB+109].randomChildrenCount = 3
mobList[zone][SMB+110].randomChildrenCount = 2
mobList[zone][SMB+111].randomChildrenCount = 2
mobList[zone][SMB+112].randomChildrenCount = 0
mobList[zone][SMB+113].randomChildrenCount = 2
mobList[zone][SMB+114].randomChildrenCount = 3
mobList[zone][SMB+115].randomChildrenCount = 2
mobList[zone][SMB+116].randomChildrenCount = 2
mobList[zone][SMB+117].randomChildrenCount = 2
mobList[zone][SMB+118].randomChildrenCount = 2
mobList[zone][SMB+119].randomChildrenCount = 3
mobList[zone][SMB+120].randomChildrenCount = 2
mobList[zone][SMB+121].randomChildrenCount = 1
mobList[zone][SMB+122].randomChildrenCount = 2
mobList[zone][SMB+123].randomChildrenCount = 1
mobList[zone][SMB+124].randomChildrenCount = 3
mobList[zone][SMB+125].randomChildrenCount = 3
mobList[zone][SMB+126].randomChildrenCount = 2
mobList[zone][SMB+127].randomChildrenCount = 0
mobList[zone][SMB+128].randomChildrenCount = 0
mobList[zone][SMB+129].randomChildrenCount = 0
mobList[zone][SMB+130].randomChildrenCount = 0
mobList[zone][SMB+131].randomChildrenCount = 0
mobList[zone][SMB+132].randomChildrenCount = 0
mobList[zone][SMB+133].randomChildrenCount = 0
mobList[zone][SMB+134].randomChildrenCount = 0
mobList[zone][SMB+135].randomChildrenCount = 0
mobList[zone][SMB+136].randomChildrenCount = 0
mobList[zone][SMB+137].randomChildrenCount = 0
mobList[zone][SMB+138].randomChildrenCount = 0
mobList[zone][SMB+139].randomChildrenCount = 0
mobList[zone][SMB+140].randomChildrenCount = 0
mobList[zone][SMB+141].randomChildrenCount = 0
mobList[zone][SMB+142].randomChildrenCount = 0
mobList[zone][SMB+143].randomChildrenCount = 0
mobList[zone][SMB+144].randomChildrenCount = 2
mobList[zone][SMB+145].randomChildrenCount = 2
mobList[zone][SMB+146].randomChildrenCount = 2
mobList[zone][SMB+147].randomChildrenCount = 2
mobList[zone][SMB+148].randomChildrenCount = 2
mobList[zone][SMB+149].randomChildrenCount = 2
mobList[zone][SMB+150].randomChildrenCount = 0

-- set my random children list i will pick from
mobList[zone][SMB+1  ].randomChildrenList = 12
mobList[zone][SMB+2  ].randomChildrenList = 15
mobList[zone][SMB+3  ].randomChildrenList = 14
mobList[zone][SMB+4  ].randomChildrenList = 13
mobList[zone][SMB+5  ].randomChildrenList = 0
mobList[zone][SMB+6  ].randomChildrenList = 9
mobList[zone][SMB+7  ].randomChildrenList = 16
mobList[zone][SMB+8  ].randomChildrenList = 16
mobList[zone][SMB+9  ].randomChildrenList = 16
mobList[zone][SMB+11 ].randomChildrenList = 16
mobList[zone][SMB+12 ].randomChildrenList = 0
mobList[zone][SMB+13 ].randomChildrenList = 16
mobList[zone][SMB+14 ].randomChildrenList = 16
mobList[zone][SMB+15 ].randomChildrenList = 16
mobList[zone][SMB+16 ].randomChildrenList = 16
mobList[zone][SMB+17 ].randomChildrenList = 16
mobList[zone][SMB+18 ].randomChildrenList = 16
mobList[zone][SMB+19 ].randomChildrenList = 16
mobList[zone][SMB+20 ].randomChildrenList = 16
mobList[zone][SMB+21 ].randomChildrenList = 16
mobList[zone][SMB+22 ].randomChildrenList = 16
mobList[zone][SMB+23 ].randomChildrenList = 16
mobList[zone][SMB+24 ].randomChildrenList = 16
mobList[zone][SMB+25 ].randomChildrenList = 16
mobList[zone][SMB+26 ].randomChildrenList = 14
mobList[zone][SMB+27 ].randomChildrenList = 9
mobList[zone][SMB+28 ].randomChildrenList = 15
mobList[zone][SMB+29 ].randomChildrenList = 1
mobList[zone][SMB+30 ].randomChildrenList = 2
mobList[zone][SMB+31 ].randomChildrenList = 3
mobList[zone][SMB+32 ].randomChildrenList = 4
mobList[zone][SMB+33 ].randomChildrenList = 5
mobList[zone][SMB+34 ].randomChildrenList = 6
mobList[zone][SMB+35 ].randomChildrenList = 0
mobList[zone][SMB+36 ].randomChildrenList = 0
mobList[zone][SMB+37 ].randomChildrenList = 0
mobList[zone][SMB+38 ].randomChildrenList = 0
mobList[zone][SMB+39 ].randomChildrenList = 0
mobList[zone][SMB+40 ].randomChildrenList = 0
mobList[zone][SMB+41 ].randomChildrenList = 0
mobList[zone][SMB+42 ].randomChildrenList = 0
mobList[zone][SMB+43 ].randomChildrenList = 0
mobList[zone][SMB+44 ].randomChildrenList = 16
mobList[zone][SMB+45 ].randomChildrenList = 16
mobList[zone][SMB+46 ].randomChildrenList = 16
mobList[zone][SMB+47 ].randomChildrenList = 16
mobList[zone][SMB+48 ].randomChildrenList = 16
mobList[zone][SMB+49 ].randomChildrenList = 16
mobList[zone][SMB+50 ].randomChildrenList = 16
mobList[zone][SMB+51 ].randomChildrenList = 16
mobList[zone][SMB+52 ].randomChildrenList = 0
mobList[zone][SMB+53 ].randomChildrenList = 16
mobList[zone][SMB+54 ].randomChildrenList = 16
mobList[zone][SMB+55 ].randomChildrenList = 16
mobList[zone][SMB+56 ].randomChildrenList = 16
mobList[zone][SMB+57 ].randomChildrenList = 16
mobList[zone][SMB+58 ].randomChildrenList = 16
mobList[zone][SMB+59 ].randomChildrenList = 16
mobList[zone][SMB+60 ].randomChildrenList = 0
mobList[zone][SMB+61 ].randomChildrenList = 16
mobList[zone][SMB+62 ].randomChildrenList = 16
mobList[zone][SMB+63 ].randomChildrenList = 5
mobList[zone][SMB+64 ].randomChildrenList = 16
mobList[zone][SMB+65 ].randomChildrenList = 16
mobList[zone][SMB+66 ].randomChildrenList = 16
mobList[zone][SMB+67 ].randomChildrenList = 16
mobList[zone][SMB+68 ].randomChildrenList = 16
mobList[zone][SMB+69 ].randomChildrenList = 7
mobList[zone][SMB+70 ].randomChildrenList = 7
mobList[zone][SMB+71 ].randomChildrenList = 2
mobList[zone][SMB+72 ].randomChildrenList = 16
mobList[zone][SMB+73 ].randomChildrenList = 0
mobList[zone][SMB+74 ].randomChildrenList = 14
mobList[zone][SMB+75 ].randomChildrenList = 9
mobList[zone][SMB+76 ].randomChildrenList = 15
mobList[zone][SMB+77 ].randomChildrenList = 0
mobList[zone][SMB+78 ].randomChildrenList = 9
mobList[zone][SMB+79 ].randomChildrenList = 8
mobList[zone][SMB+80 ].randomChildrenList = 11
mobList[zone][SMB+81 ].randomChildrenList = 7
mobList[zone][SMB+82 ].randomChildrenList = 10
mobList[zone][SMB+83 ].randomChildrenList = 16
mobList[zone][SMB+84 ].randomChildrenList = 4
mobList[zone][SMB+85 ].randomChildrenList = 16
mobList[zone][SMB+86 ].randomChildrenList = 16
mobList[zone][SMB+87 ].randomChildrenList = 16
mobList[zone][SMB+88 ].randomChildrenList = 3
mobList[zone][SMB+89 ].randomChildrenList = 16
mobList[zone][SMB+90 ].randomChildrenList = 16
mobList[zone][SMB+91 ].randomChildrenList = 16
mobList[zone][SMB+92 ].randomChildrenList = 16
mobList[zone][SMB+93 ].randomChildrenList = 11
mobList[zone][SMB+94 ].randomChildrenList = 12
mobList[zone][SMB+95 ].randomChildrenList = 11
mobList[zone][SMB+96 ].randomChildrenList = 6
mobList[zone][SMB+97 ].randomChildrenList = 16
mobList[zone][SMB+98 ].randomChildrenList = 16
mobList[zone][SMB+99 ].randomChildrenList = 16
mobList[zone][SMB+100].randomChildrenList = 16
mobList[zone][SMB+101].randomChildrenList = 16
mobList[zone][SMB+102].randomChildrenList = 16
mobList[zone][SMB+103].randomChildrenList = 16
mobList[zone][SMB+104].randomChildrenList = 16
mobList[zone][SMB+105].randomChildrenList = 16
mobList[zone][SMB+106].randomChildrenList = 7
mobList[zone][SMB+107].randomChildrenList = 16
mobList[zone][SMB+108].randomChildrenList = 16
mobList[zone][SMB+109].randomChildrenList = 16
mobList[zone][SMB+110].randomChildrenList = 15
mobList[zone][SMB+111].randomChildrenList = 9
mobList[zone][SMB+112].randomChildrenList = 0
mobList[zone][SMB+113].randomChildrenList = 9
mobList[zone][SMB+114].randomChildrenList = 15
mobList[zone][SMB+115].randomChildrenList = 16
mobList[zone][SMB+116].randomChildrenList = 16
mobList[zone][SMB+117].randomChildrenList = 16
mobList[zone][SMB+118].randomChildrenList = 16
mobList[zone][SMB+119].randomChildrenList = 11
mobList[zone][SMB+120].randomChildrenList = 16
mobList[zone][SMB+121].randomChildrenList = 5
mobList[zone][SMB+122].randomChildrenList = 13
mobList[zone][SMB+123].randomChildrenList = 5
mobList[zone][SMB+124].randomChildrenList = 16
mobList[zone][SMB+125].randomChildrenList = 16
mobList[zone][SMB+126].randomChildrenList = 8
mobList[zone][SMB+127].randomChildrenList = 0
mobList[zone][SMB+128].randomChildrenList = 0
mobList[zone][SMB+129].randomChildrenList = 0
mobList[zone][SMB+130].randomChildrenList = 0
mobList[zone][SMB+131].randomChildrenList = 0
mobList[zone][SMB+132].randomChildrenList = 0
mobList[zone][SMB+133].randomChildrenList = 0
mobList[zone][SMB+134].randomChildrenList = 0
mobList[zone][SMB+135].randomChildrenList = 0
mobList[zone][SMB+136].randomChildrenList = 0
mobList[zone][SMB+137].randomChildrenList = 0
mobList[zone][SMB+138].randomChildrenList = 0
mobList[zone][SMB+139].randomChildrenList = 0
mobList[zone][SMB+140].randomChildrenList = 0
mobList[zone][SMB+141].randomChildrenList = 0
mobList[zone][SMB+142].randomChildrenList = 0
mobList[zone][SMB+143].randomChildrenList = 0
mobList[zone][SMB+144].randomChildrenList = 16
mobList[zone][SMB+145].randomChildrenList = 16
mobList[zone][SMB+146].randomChildrenList = 16
mobList[zone][SMB+147].randomChildrenList = 14
mobList[zone][SMB+148].randomChildrenList = 8
mobList[zone][SMB+149].randomChildrenList = 7
mobList[zone][SMB+150].randomChildrenList = 0

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
-- there are several eyes in xarcabard that spawn all of the same job type, anything with various job types will use list #16 which includes all jobs
randomChildrenList[zone] =
{
    [1] = -- Warrior
    {
        17330323, -- Kindred Warrior
        17330242, -- Kindred Warrior
        17330243, -- Kindred Warrior
        17330376, -- Kindred Warrior
        17330387, -- Kindred Warrior
        17330405, -- Kindred Warrior
        17330461, -- Kindred Warrior
        17330485, -- Kindred Warrior
        17330536, -- Kindred Warrior
        17330537, -- Kindred Warrior
        17330587, -- Kindred Warrior
        17330618, -- Kindred Warrior
        17330622, -- Kindred Warrior
        17330663, -- Kindred Warrior
        17330679, -- Kindred Warrior
        17330721, -- Kindred Warrior
        17330732, -- Kindred Warrior
        17330750, -- Kindred Warrior
    },
    [2] = -- Monk
    {
        17330244, -- Kindred Monk
        17330303, -- Kindred Monk
        17330313, -- Kindred Monk
        17330324, -- Kindred Monk
        17330406, -- Kindred Monk
        17330462, -- Kindred Monk
        17330486, -- Kindred Monk
        17330543, -- Kindred Monk
        17330544, -- Kindred Monk
        17330588, -- Kindred Monk
        17330623, -- Kindred Monk
        17330626, -- Kindred Monk
        17330680, -- Kindred Monk
        17330722, -- Kindred Monk
        17330723, -- Kindred Monk
        17330751, -- Kindred Monk
    },
    [3] = -- WHM
    {
        17330236, -- Kindred White Mage
        17330275, -- Kindred White Mage
        17330276, -- Kindred White Mage
        17330289, -- Kindred White Mage
        17330326, -- Kindred White Mage
        17330331, -- Kindred White Mage
        17330341, -- Kindred White Mage
        17330407, -- Kindred White Mage
        17330463, -- Kindred White Mage
        17330487, -- Kindred White Mage
        17330538, -- Kindred White Mage
        17330539, -- Kindred White Mage
        17330563, -- Kindred White Mage
        17330576, -- Kindred White Mage
        17330592, -- Kindred White Mage
        17330619, -- Kindred White Mage
        17330627, -- Kindred White Mage
        17330657, -- Kindred White Mage
        17330658, -- Kindred White Mage
        17330686, -- Kindred White Mage
        17330733, -- Kindred White Mage
        17330752, -- Kindred White Mage
    },
    [4] = -- BLM
    {
        17330237, -- Kindred Black Mage
        17330261, -- Kindred Black Mage
        17330277, -- Kindred Black Mage
        17330278, -- Kindred Black Mage
        17330298, -- Kindred Black Mage
        17330327, -- Kindred Black Mage
        17330333, -- Kindred Black Mage
        17330342, -- Kindred Black Mage
        17330371, -- Kindred Black Mage
        17330408, -- Kindred Black Mage
        17330464, -- Kindred Black Mage
        17330488, -- Kindred Black Mage
        17330545, -- Kindred Black Mage
        17330546, -- Kindred Black Mage
        17330565, -- Kindred Black Mage
        17330593, -- Kindred Black Mage
        17330620, -- Kindred Black Mage
        17330624, -- Kindred Black Mage
        17330628, -- Kindred Black Mage
        17330659, -- Kindred Black Mage
        17330660, -- Kindred Black Mage
        17330687, -- Kindred Black Mage
        17330713, -- Kindred Black Mage
        17330753, -- Kindred Black Mage
    },
    [5] = -- RDM
    {
        17330238, -- Kindred Red Mage
        17330260, -- Kindred Red Mage
        17330279, -- Kindred Red Mage
        17330280, -- Kindred Red Mage
        17330352, -- Kindred Red Mage
        17330354, -- Kindred Red Mage
        17330409, -- Kindred Red Mage
        17330465, -- Kindred Red Mage
        17330489, -- Kindred Red Mage
        17330540, -- Kindred Red Mage
        17330541, -- Kindred Red Mage
        17330564, -- Kindred Red Mage
        17330594, -- Kindred Red Mage
        17330625, -- Kindred Red Mage
        17330629, -- Kindred Red Mage
        17330655, -- Kindred Red Mage
        17330661, -- Kindred Red Mage
        17330688, -- Kindred Red Mage
        17330728, -- Kindred Red Mage
        17330754, -- Kindred Red Mage
    },
    [6] = -- THF
    {
        17330245, -- Kindred Thief
        17330271, -- Kindred Thief
        17330272, -- Kindred Thief
        17330305, -- Kindred Thief
        17330314, -- Kindred Thief
        17330399, -- Kindred Thief
        17330402, -- Kindred Thief
        17330412, -- Kindred Thief
        17330466, -- Kindred Thief
        17330490, -- Kindred Thief
        17330547, -- Kindred Thief
        17330548, -- Kindred Thief
        17330582, -- Kindred Thief
        17330595, -- Kindred Thief
        17330621, -- Kindred Thief
        17330630, -- Kindred Thief
        17330647, -- Kindred Thief
        17330664, -- Kindred Thief
        17330665, -- Kindred Thief
        17330681, -- Kindred Thief
        17330729, -- Kindred Thief
        17330730, -- Kindred Thief
        17330742, -- Kindred Thief
        17330747, -- Kindred Thief
        17330755, -- Kindred Thief
    },
    [7] = -- PLD
    {
        17330215, -- Kindred Paladin
        17330216, -- Kindred Paladin
        17330250, -- Kindred Paladin
        17330251, -- Kindred Paladin
        17330287, -- Kindred Paladin
        17330288, -- Kindred Paladin
        17330294, -- Kindred Paladin
        17330295, -- Kindred Paladin
        17330351, -- Kindred Paladin
        17330359, -- Kindred Paladin
        17330410, -- Kindred Paladin
        17330467, -- Kindred Paladin
        17330550, -- Kindred Paladin
        17330551, -- Kindred Paladin
        17330577, -- Kindred Paladin
        17330598, -- Kindred Paladin
        17330632, -- Kindred Paladin
        17330656, -- Kindred Paladin
        17330666, -- Kindred Paladin
        17330667, -- Kindred Paladin
        17330682, -- Kindred Paladin
        17330703, -- Kindred Paladin
        17330704, -- Kindred Paladin
        17330757, -- Kindred Paladin
    },
    [8] = -- DRK
    {
        17330217, -- Kindred Dark Knight
        17330218, -- Kindred Dark Knight
        17330258, -- Kindred Dark Knight
        17330259, -- Kindred Dark Knight
        17330328, -- Kindred Dark Knight
        17330361, -- Kindred Dark Knight
        17330369, -- Kindred Dark Knight
        17330370, -- Kindred Dark Knight
        17330411, -- Kindred Dark Knight
        17330416, -- Kindred Dark Knight
        17330427, -- Kindred Dark Knight
        17330468, -- Kindred Dark Knight
        17330552, -- Kindred Dark Knight
        17330553, -- Kindred Dark Knight
        17330578, -- Kindred Dark Knight
        17330589, -- Kindred Dark Knight
        17330633, -- Kindred Dark Knight
        17330651, -- Kindred Dark Knight
        17330669, -- Kindred Dark Knight
        17330683, -- Kindred Dark Knight
        17330705, -- Kindred Dark Knight
        17330706, -- Kindred Dark Knight
        17330712, -- Kindred Dark Knight
        17330758, -- Kindred Dark Knight
    },
    [9] = -- BST
    {
        17330219, -- Kindred Beastmaster
        17330246, -- Kindred Beastmaster
        17330296, -- Kindred Beastmaster
        17330378, -- Kindred Beastmaster
        17330388, -- Kindred Beastmaster
        17330469, -- Kindred Beastmaster
        17330554, -- Kindred Beastmaster
        17330560, -- Kindred Beastmaster
        17330599, -- Kindred Beastmaster
        17330634, -- Kindred Beastmaster
        17330670, -- Kindred Beastmaster
        17330734, -- Kindred Beastmaster
        17330736, -- Kindred Beastmaster
        17330759, -- Kindred Beastmaster
    },
    [10] = -- BRD
    {
        17330222, -- Kindred Bard
        17330239, -- Kindred Bard
        17330262, -- Kindred Bard
        17330473, -- Kindred Bard
        17330491, -- Kindred Bard
        17330492, -- Kindred Bard
        17330499, -- Kindred Bard
        17330500, -- Kindred Bard
        17330556, -- Kindred Bard
        17330557, -- Kindred Bard
        17330566, -- Kindred Bard
        17330579, -- Kindred Bard
        17330601, -- Kindred Bard
        17330604, -- Kindred Bard
        17330605, -- Kindred Bard
        17330637, -- Kindred Bard
        17330648, -- Kindred Bard
        17330672, -- Kindred Bard
        17330689, -- Kindred Bard
        17330707, -- Kindred Bard
        17330726, -- Kindred Bard
        17330727, -- Kindred Bard
        17330738, -- Kindred Bard
        17330761, -- Kindred Bard
    },
    [11] = -- RNG
    {
        17330221, -- Kindred Ranger
        17330265, -- Kindred Ranger
        17330266, -- Kindred Ranger
        17330325, -- Kindred Ranger
        17330401, -- Kindred Ranger
        17330404, -- Kindred Ranger
        17330414, -- Kindred Ranger
        17330474, -- Kindred Ranger
        17330558, -- Kindred Ranger
        17330559, -- Kindred Ranger
        17330580, -- Kindred Ranger
        17330583, -- Kindred Ranger
        17330602, -- Kindred Ranger
        17330611, -- Kindred Ranger
        17330612, -- Kindred Ranger
        17330638, -- Kindred Ranger
        17330649, -- Kindred Ranger
        17330650, -- Kindred Ranger
        17330684, -- Kindred Ranger
        17330719, -- Kindred Ranger
        17330720, -- Kindred Ranger
        17330743, -- Kindred Ranger
        17330748, -- Kindred Ranger
        17330763, -- Kindred Ranger
    },
    [12] = -- SAM
    {
        17330224, -- Kindred Samurai
        17330225, -- Kindred Samurai
        17330252, -- Kindred Samurai
        17330267, -- Kindred Samurai
        17330268, -- Kindred Samurai
        17330439, -- Kindred Samurai
        17330449, -- Kindred Samurai
        17330475, -- Kindred Samurai
        17330568, -- Kindred Samurai
        17330569, -- Kindred Samurai
        17330584, -- Kindred Samurai
        17330590, -- Kindred Samurai
        17330603, -- Kindred Samurai
        17330606, -- Kindred Samurai
        17330607, -- Kindred Samurai
        17330641, -- Kindred Samurai
        17330652, -- Kindred Samurai
        17330673, -- Kindred Samurai
        17330674, -- Kindred Samurai
        17330691, -- Kindred Samurai
        17330697, -- Kindred Samurai
        17330724, -- Kindred Samurai
        17330725, -- Kindred Samurai
        17330739, -- Kindred Samurai
        17330764, -- Kindred Samurai
    },
    [13] = -- NIN
    {
        17330226, -- Kindred Ninja
        17330227, -- Kindred Ninja
        17330253, -- Kindred Ninja
        17330269, -- Kindred Ninja
        17330270, -- Kindred Ninja
        17330400, -- Kindred Ninja
        17330403, -- Kindred Ninja
        17330413, -- Kindred Ninja
        17330441, -- Kindred Ninja
        17330450, -- Kindred Ninja
        17330476, -- Kindred Ninja
        17330570, -- Kindred Ninja
        17330571, -- Kindred Ninja
        17330585, -- Kindred Ninja
        17330591, -- Kindred Ninja
        17330613, -- Kindred Ninja
        17330614, -- Kindred Ninja
        17330642, -- Kindred Ninja
        17330675, -- Kindred Ninja
        17330676, -- Kindred Ninja
        17330692, -- Kindred Ninja
        17330698, -- Kindred Ninja
        17330708, -- Kindred Ninja
        17330709, -- Kindred Ninja
        17330740, -- Kindred Ninja
        17330741, -- Kindred Ninja
        17330765, -- Kindred Ninja
    },
    [14] = -- DRG
    {
        17330232, -- Kindred Dragoon
        17330234, -- Kindred Dragoon
        17330263, -- Kindred Dragoon
        17330329, -- Kindred Dragoon
        17330418, -- Kindred Dragoon
        17330428, -- Kindred Dragoon
        17330477, -- Kindred Dragoon
        17330572, -- Kindred Dragoon
        17330608, -- Kindred Dragoon
        17330639, -- Kindred Dragoon
        17330643, -- Kindred Dragoon
        17330653, -- Kindred Dragoon
        17330693, -- Kindred Dragoon
        17330699, -- Kindred Dragoon
        17330710, -- Kindred Dragoon
        17330744, -- Kindred Dragoon
        17330766, -- Kindred Dragoon
    },
    [15] = -- SMN
    {
        17330228, -- Kindred Summoner
        17330254, -- Kindred Summoner
        17330281, -- Kindred Summoner
        17330283, -- Kindred Summoner
        17330452, -- Kindred Summoner
        17330479, -- Kindred Summoner
        17330493, -- Kindred Summoner
        17330501, -- Kindred Summoner
        17330574, -- Kindred Summoner
        17330596, -- Kindred Summoner
        17330615, -- Kindred Summoner
        17330645, -- Kindred Summoner
        17330677, -- Kindred Summoner
        17330695, -- Kindred Summoner
        17330701, -- Kindred Summoner
        17330714, -- Kindred Summoner
        17330716, -- Kindred Summoner
        17330768, -- Kindred Summoner
    },
    [16] = -- All Jobs minues statues/eyes
    {
        17330323, -- Kindred Warrior
        17330242, -- Kindred Warrior
        17330243, -- Kindred Warrior
        17330376, -- Kindred Warrior
        17330387, -- Kindred Warrior
        17330405, -- Kindred Warrior
        17330461, -- Kindred Warrior
        17330485, -- Kindred Warrior
        17330536, -- Kindred Warrior
        17330537, -- Kindred Warrior
        17330587, -- Kindred Warrior
        17330618, -- Kindred Warrior
        17330622, -- Kindred Warrior
        17330663, -- Kindred Warrior
        17330679, -- Kindred Warrior
        17330721, -- Kindred Warrior
        17330732, -- Kindred Warrior
        17330750, -- Kindred Warrior
        17330244, -- Kindred Monk
        17330303, -- Kindred Monk
        17330313, -- Kindred Monk
        17330324, -- Kindred Monk
        17330406, -- Kindred Monk
        17330462, -- Kindred Monk
        17330486, -- Kindred Monk
        17330543, -- Kindred Monk
        17330544, -- Kindred Monk
        17330588, -- Kindred Monk
        17330623, -- Kindred Monk
        17330626, -- Kindred Monk
        17330680, -- Kindred Monk
        17330722, -- Kindred Monk
        17330723, -- Kindred Monk
        17330751, -- Kindred Monk
        17330236, -- Kindred White Mage
        17330275, -- Kindred White Mage
        17330276, -- Kindred White Mage
        17330289, -- Kindred White Mage
        17330326, -- Kindred White Mage
        17330331, -- Kindred White Mage
        17330341, -- Kindred White Mage
        17330407, -- Kindred White Mage
        17330463, -- Kindred White Mage
        17330487, -- Kindred White Mage
        17330538, -- Kindred White Mage
        17330539, -- Kindred White Mage
        17330563, -- Kindred White Mage
        17330576, -- Kindred White Mage
        17330592, -- Kindred White Mage
        17330619, -- Kindred White Mage
        17330627, -- Kindred White Mage
        17330657, -- Kindred White Mage
        17330658, -- Kindred White Mage
        17330686, -- Kindred White Mage
        17330733, -- Kindred White Mage
        17330752, -- Kindred White Mage
        17330237, -- Kindred Black Mage
        17330261, -- Kindred Black Mage
        17330277, -- Kindred Black Mage
        17330278, -- Kindred Black Mage
        17330298, -- Kindred Black Mage
        17330327, -- Kindred Black Mage
        17330333, -- Kindred Black Mage
        17330342, -- Kindred Black Mage
        17330371, -- Kindred Black Mage
        17330408, -- Kindred Black Mage
        17330464, -- Kindred Black Mage
        17330488, -- Kindred Black Mage
        17330545, -- Kindred Black Mage
        17330546, -- Kindred Black Mage
        17330565, -- Kindred Black Mage
        17330593, -- Kindred Black Mage
        17330620, -- Kindred Black Mage
        17330624, -- Kindred Black Mage
        17330628, -- Kindred Black Mage
        17330659, -- Kindred Black Mage
        17330660, -- Kindred Black Mage
        17330687, -- Kindred Black Mage
        17330713, -- Kindred Black Mage
        17330753, -- Kindred Black Mage
        17330238, -- Kindred Red Mage
        17330260, -- Kindred Red Mage
        17330279, -- Kindred Red Mage
        17330280, -- Kindred Red Mage
        17330352, -- Kindred Red Mage
        17330354, -- Kindred Red Mage
        17330409, -- Kindred Red Mage
        17330465, -- Kindred Red Mage
        17330489, -- Kindred Red Mage
        17330540, -- Kindred Red Mage
        17330541, -- Kindred Red Mage
        17330564, -- Kindred Red Mage
        17330594, -- Kindred Red Mage
        17330625, -- Kindred Red Mage
        17330629, -- Kindred Red Mage
        17330655, -- Kindred Red Mage
        17330661, -- Kindred Red Mage
        17330688, -- Kindred Red Mage
        17330728, -- Kindred Red Mage
        17330754, -- Kindred Red Mage
        17330245, -- Kindred Thief
        17330271, -- Kindred Thief
        17330272, -- Kindred Thief
        17330305, -- Kindred Thief
        17330314, -- Kindred Thief
        17330399, -- Kindred Thief
        17330402, -- Kindred Thief
        17330412, -- Kindred Thief
        17330466, -- Kindred Thief
        17330490, -- Kindred Thief
        17330547, -- Kindred Thief
        17330548, -- Kindred Thief
        17330582, -- Kindred Thief
        17330595, -- Kindred Thief
        17330621, -- Kindred Thief
        17330630, -- Kindred Thief
        17330647, -- Kindred Thief
        17330664, -- Kindred Thief
        17330665, -- Kindred Thief
        17330681, -- Kindred Thief
        17330729, -- Kindred Thief
        17330730, -- Kindred Thief
        17330742, -- Kindred Thief
        17330747, -- Kindred Thief
        17330755, -- Kindred Thief
        17330215, -- Kindred Paladin
        17330216, -- Kindred Paladin
        17330250, -- Kindred Paladin
        17330251, -- Kindred Paladin
        17330287, -- Kindred Paladin
        17330288, -- Kindred Paladin
        17330294, -- Kindred Paladin
        17330295, -- Kindred Paladin
        17330351, -- Kindred Paladin
        17330359, -- Kindred Paladin
        17330410, -- Kindred Paladin
        17330467, -- Kindred Paladin
        17330550, -- Kindred Paladin
        17330551, -- Kindred Paladin
        17330577, -- Kindred Paladin
        17330598, -- Kindred Paladin
        17330632, -- Kindred Paladin
        17330656, -- Kindred Paladin
        17330666, -- Kindred Paladin
        17330667, -- Kindred Paladin
        17330682, -- Kindred Paladin
        17330703, -- Kindred Paladin
        17330704, -- Kindred Paladin
        17330757, -- Kindred Paladin
        17330217, -- Kindred Dark Knight
        17330218, -- Kindred Dark Knight
        17330258, -- Kindred Dark Knight
        17330259, -- Kindred Dark Knight
        17330328, -- Kindred Dark Knight
        17330361, -- Kindred Dark Knight
        17330369, -- Kindred Dark Knight
        17330370, -- Kindred Dark Knight
        17330411, -- Kindred Dark Knight
        17330416, -- Kindred Dark Knight
        17330427, -- Kindred Dark Knight
        17330468, -- Kindred Dark Knight
        17330552, -- Kindred Dark Knight
        17330553, -- Kindred Dark Knight
        17330578, -- Kindred Dark Knight
        17330589, -- Kindred Dark Knight
        17330633, -- Kindred Dark Knight
        17330651, -- Kindred Dark Knight
        17330669, -- Kindred Dark Knight
        17330683, -- Kindred Dark Knight
        17330705, -- Kindred Dark Knight
        17330706, -- Kindred Dark Knight
        17330712, -- Kindred Dark Knight
        17330758, -- Kindred Dark Knight
        17330219, -- Kindred Beastmaster
        17330246, -- Kindred Beastmaster
        17330296, -- Kindred Beastmaster
        17330378, -- Kindred Beastmaster
        17330388, -- Kindred Beastmaster
        17330469, -- Kindred Beastmaster
        17330554, -- Kindred Beastmaster
        17330560, -- Kindred Beastmaster
        17330599, -- Kindred Beastmaster
        17330634, -- Kindred Beastmaster
        17330670, -- Kindred Beastmaster
        17330734, -- Kindred Beastmaster
        17330736, -- Kindred Beastmaster
        17330759, -- Kindred Beastmaster
        17330222, -- Kindred Bard
        17330239, -- Kindred Bard
        17330262, -- Kindred Bard
        17330473, -- Kindred Bard
        17330491, -- Kindred Bard
        17330492, -- Kindred Bard
        17330499, -- Kindred Bard
        17330500, -- Kindred Bard
        17330556, -- Kindred Bard
        17330557, -- Kindred Bard
        17330566, -- Kindred Bard
        17330579, -- Kindred Bard
        17330601, -- Kindred Bard
        17330604, -- Kindred Bard
        17330605, -- Kindred Bard
        17330637, -- Kindred Bard
        17330648, -- Kindred Bard
        17330672, -- Kindred Bard
        17330689, -- Kindred Bard
        17330707, -- Kindred Bard
        17330726, -- Kindred Bard
        17330727, -- Kindred Bard
        17330738, -- Kindred Bard
        17330761, -- Kindred Bard
        17330221, -- Kindred Ranger
        17330265, -- Kindred Ranger
        17330266, -- Kindred Ranger
        17330325, -- Kindred Ranger
        17330401, -- Kindred Ranger
        17330404, -- Kindred Ranger
        17330414, -- Kindred Ranger
        17330474, -- Kindred Ranger
        17330558, -- Kindred Ranger
        17330559, -- Kindred Ranger
        17330580, -- Kindred Ranger
        17330583, -- Kindred Ranger
        17330602, -- Kindred Ranger
        17330611, -- Kindred Ranger
        17330612, -- Kindred Ranger
        17330638, -- Kindred Ranger
        17330649, -- Kindred Ranger
        17330650, -- Kindred Ranger
        17330684, -- Kindred Ranger
        17330719, -- Kindred Ranger
        17330720, -- Kindred Ranger
        17330743, -- Kindred Ranger
        17330748, -- Kindred Ranger
        17330763, -- Kindred Ranger
        17330224, -- Kindred Samurai
        17330225, -- Kindred Samurai
        17330252, -- Kindred Samurai
        17330267, -- Kindred Samurai
        17330268, -- Kindred Samurai
        17330439, -- Kindred Samurai
        17330449, -- Kindred Samurai
        17330475, -- Kindred Samurai
        17330568, -- Kindred Samurai
        17330569, -- Kindred Samurai
        17330584, -- Kindred Samurai
        17330590, -- Kindred Samurai
        17330603, -- Kindred Samurai
        17330606, -- Kindred Samurai
        17330607, -- Kindred Samurai
        17330641, -- Kindred Samurai
        17330652, -- Kindred Samurai
        17330673, -- Kindred Samurai
        17330674, -- Kindred Samurai
        17330691, -- Kindred Samurai
        17330697, -- Kindred Samurai
        17330724, -- Kindred Samurai
        17330725, -- Kindred Samurai
        17330739, -- Kindred Samurai
        17330764, -- Kindred Samurai
        17330226, -- Kindred Ninja
        17330227, -- Kindred Ninja
        17330253, -- Kindred Ninja
        17330269, -- Kindred Ninja
        17330270, -- Kindred Ninja
        17330400, -- Kindred Ninja
        17330403, -- Kindred Ninja
        17330413, -- Kindred Ninja
        17330441, -- Kindred Ninja
        17330450, -- Kindred Ninja
        17330476, -- Kindred Ninja
        17330570, -- Kindred Ninja
        17330571, -- Kindred Ninja
        17330585, -- Kindred Ninja
        17330591, -- Kindred Ninja
        17330613, -- Kindred Ninja
        17330614, -- Kindred Ninja
        17330642, -- Kindred Ninja
        17330675, -- Kindred Ninja
        17330676, -- Kindred Ninja
        17330692, -- Kindred Ninja
        17330698, -- Kindred Ninja
        17330708, -- Kindred Ninja
        17330709, -- Kindred Ninja
        17330740, -- Kindred Ninja
        17330741, -- Kindred Ninja
        17330765, -- Kindred Ninja
        17330232, -- Kindred Dragoon
        17330234, -- Kindred Dragoon
        17330263, -- Kindred Dragoon
        17330329, -- Kindred Dragoon
        17330418, -- Kindred Dragoon
        17330428, -- Kindred Dragoon
        17330477, -- Kindred Dragoon
        17330572, -- Kindred Dragoon
        17330608, -- Kindred Dragoon
        17330639, -- Kindred Dragoon
        17330643, -- Kindred Dragoon
        17330653, -- Kindred Dragoon
        17330693, -- Kindred Dragoon
        17330699, -- Kindred Dragoon
        17330710, -- Kindred Dragoon
        17330744, -- Kindred Dragoon
        17330766, -- Kindred Dragoon
        17330228, -- Kindred Summoner
        17330254, -- Kindred Summoner
        17330281, -- Kindred Summoner
        17330283, -- Kindred Summoner
        17330452, -- Kindred Summoner
        17330479, -- Kindred Summoner
        17330493, -- Kindred Summoner
        17330501, -- Kindred Summoner
        17330574, -- Kindred Summoner
        17330596, -- Kindred Summoner
        17330615, -- Kindred Summoner
        17330645, -- Kindred Summoner
        17330677, -- Kindred Summoner
        17330695, -- Kindred Summoner
        17330701, -- Kindred Summoner
        17330714, -- Kindred Summoner
        17330716, -- Kindred Summoner
        17330768, -- Kindred Summoner
    },
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] =
{

}