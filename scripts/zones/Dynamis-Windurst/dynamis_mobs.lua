-----------------------------------
--
-- Dynamis-Windurst
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_WINDURST
local DMB = 17543168 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17543568 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier
-- drop id for statues = 3204, drop id for mobs = 3205

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    [17543169] = { id = DMB+1 }, -- Tzee_Xicu_Idol    Tzee Xicu Idol
    [17543170] = { id = DMB+2 }, -- Maa_Febi_the_Steadfast    Maa Febi the Steadfast
    [17543171] = { id = DMB+3 }, -- Muu_Febi_the_Steadfast    Muu Febi the Steadfast
    [17543172] = { id = DMB+4 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543173] = { id = DMB+5 }, -- Vanguard_Priest    Vanguard Priest
    [17543174] = { id = DMB+6 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543175] = { id = DMB+7 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543176] = { id = DMB+8 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543177] = { id = DMB+9 }, -- Vanguard_Priest    Vanguard Priest
    [17543178] = { id = DMB+10 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543179] = { id = DMB+11 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543180] = { id = DMB+12 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543181] = { id = DMB+13 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543182] = { id = DMB+14 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543183] = { id = DMB+15 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543184] = { id = DMB+16 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543185] = { id = DMB+17 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543186] = { id = DMB+18 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543187] = { id = DMB+19 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543188] = { id = DMB+20 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543189] = { id = DMB+21 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543190] = { id = DMB+22 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543191] = { id = DMB+23 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543192] = { id = DMB+24 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543193] = { id = DMB+25 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543194] = { id = DMB+26 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543195] = { id = DMB+27 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543196] = { id = DMB+28 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543197] = { id = DMB+29 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543198] = { id = DMB+30 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543199] = { id = DMB+31 }, -- Vanguard_Priest    Vanguard Priest
    [17543200] = { id = DMB+32 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543201] = { id = DMB+33 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543202] = { id = DMB+34 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543203] = { id = DMB+35 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543204] = { id = DMB+36 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543205] = { id = DMB+37 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543206] = { id = DMB+38 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543207] = { id = DMB+39 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543208] = { id = DMB+40 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543209] = { id = DMB+41 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543210] = { id = DMB+42 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543211] = { id = DMB+43 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543212] = { id = DMB+44 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543213] = { id = DMB+45 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543214] = { id = DMB+46 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543215] = { id = DMB+47 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543216] = { id = DMB+48 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543217] = { id = DMB+49 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543218] = { id = DMB+50 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543219] = { id = DMB+51 }, -- Vanguard_Priest    Vanguard Priest
    [17543220] = { id = DMB+52 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543221] = { id = DMB+53 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543222] = { id = DMB+54 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543223] = { id = DMB+55 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543224] = { id = DMB+56 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543225] = { id = DMB+57 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543226] = { id = DMB+58 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543227] = { id = DMB+59 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543228] = { id = DMB+60 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543229] = { id = DMB+61 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543230] = { id = DMB+62 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543231] = { id = DMB+63 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543232] = { id = DMB+64 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543233] = { id = DMB+65 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543234] = { id = DMB+66 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543235] = { id = DMB+67 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543236] = { id = DMB+68 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543237] = { id = DMB+69 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543238] = { id = DMB+70 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543239] = { id = DMB+71 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543240] = { id = DMB+72 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543241] = { id = DMB+73 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543242] = { id = DMB+74 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543243] = { id = DMB+75 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543244] = { id = DMB+76 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543245] = { id = DMB+77 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543246] = { id = DMB+78 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543247] = { id = DMB+79 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543248] = { id = DMB+80 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543249] = { id = DMB+81 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543250] = { id = DMB+82 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543251] = { id = DMB+83 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543252] = { id = DMB+84 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543253] = { id = DMB+85 }, -- Vanguard_Priest    Vanguard Priest
    [17543254] = { id = DMB+86 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543255] = { id = DMB+87 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543256] = { id = DMB+88 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543257] = { id = DMB+89 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543258] = { id = DMB+90 }, -- Avatar_Idol    Avatar Idol
    [17543259] = { id = DMB+91 }, -- Avatar_Idol    Avatar Idol
    [17543260] = { id = DMB+92 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543261] = { id = DMB+93 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543262] = { id = DMB+94 }, -- Vanguard_Priest    Vanguard Priest
    [17543263] = { id = DMB+95 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543264] = { id = DMB+96 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543265] = { id = DMB+97 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543266] = { id = DMB+98 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543267] = { id = DMB+99 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543268] = { id = DMB+100 }, -- Avatar_Icon    Avatar Icon
    [17543269] = { id = DMB+101 }, -- Avatar_Icon    Avatar Icon
    [17543270] = { id = DMB+102 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543271] = { id = DMB+103 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543272] = { id = DMB+104 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543273] = { id = DMB+105 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543274] = { id = DMB+106 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543275] = { id = DMB+107 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543276] = { id = DMB+108 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543277] = { id = DMB+109 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543278] = { id = DMB+110 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543279] = { id = DMB+111 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543280] = { id = DMB+112 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543281] = { id = DMB+113 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543282] = { id = DMB+114 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543283] = { id = DMB+115 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543284] = { id = DMB+116 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543285] = { id = DMB+117 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543286] = { id = DMB+118 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543287] = { id = DMB+119 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543288] = { id = DMB+120 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543289] = { id = DMB+121 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543290] = { id = DMB+122 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543291] = { id = DMB+123 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543292] = { id = DMB+124 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543293] = { id = DMB+125 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543294] = { id = DMB+126 }, -- Haa_Pevi_the_Stentorian    Haa Pevi the Stentorian
    [17543295] = { id = DMB+127 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543296] = { id = DMB+128 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543297] = { id = DMB+129 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543298] = { id = DMB+130 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543299] = { id = DMB+131 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543300] = { id = DMB+132 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543301] = { id = DMB+133 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543302] = { id = DMB+134 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543303] = { id = DMB+135 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543304] = { id = DMB+136 }, -- Vanguard_Priest    Vanguard Priest
    [17543305] = { id = DMB+137 }, -- Avatar_Icon    Avatar Icon
    [17543306] = { id = DMB+138 }, -- Avatar_Icon    Avatar Icon
    [17543307] = { id = DMB+139 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543308] = { id = DMB+140 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543309] = { id = DMB+141 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543310] = { id = DMB+142 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543311] = { id = DMB+143 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543312] = { id = DMB+144 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543313] = { id = DMB+145 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543314] = { id = DMB+146 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543315] = { id = DMB+147 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543316] = { id = DMB+148 }, -- Vanguard_Priest    Vanguard Priest
    [17543317] = { id = DMB+149 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543318] = { id = DMB+150 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543319] = { id = DMB+151 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543320] = { id = DMB+152 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543321] = { id = DMB+153 }, -- Vanguard_Priest    Vanguard Priest
    [17543322] = { id = DMB+154 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543323] = { id = DMB+155 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543324] = { id = DMB+156 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543325] = { id = DMB+157 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543326] = { id = DMB+158 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543327] = { id = DMB+159 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543328] = { id = DMB+160 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543329] = { id = DMB+161 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543330] = { id = DMB+162 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543331] = { id = DMB+163 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543332] = { id = DMB+164 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543333] = { id = DMB+165 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543334] = { id = DMB+166 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543335] = { id = DMB+167 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543336] = { id = DMB+168 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543337] = { id = DMB+169 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543338] = { id = DMB+170 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543339] = { id = DMB+171 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543340] = { id = DMB+172 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543341] = { id = DMB+173 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543342] = { id = DMB+174 }, -- Avatar_Idol    Avatar Idol
    [17543343] = { id = DMB+175 }, -- Vanguard_Priest    Vanguard Priest
    [17543344] = { id = DMB+176 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543345] = { id = DMB+177 }, -- Loo_Hepe_the_Eyepiercer    Loo Hepe the Eyepiercer
    [17543346] = { id = DMB+178 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543347] = { id = DMB+179 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543348] = { id = DMB+180 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543349] = { id = DMB+181 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543350] = { id = DMB+182 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543351] = { id = DMB+183 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543352] = { id = DMB+184 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543353] = { id = DMB+185 }, -- Avatar_Icon    Avatar Icon
    [17543354] = { id = DMB+186 }, -- Avatar_Icon    Avatar Icon
    [17543355] = { id = DMB+187 }, -- Vanguard_Priest    Vanguard Priest
    [17543356] = { id = DMB+188 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543357] = { id = DMB+189 }, -- Wuu_Qoho_the_Razorclaw    Wuu Qoho the Razorclaw
    [17543358] = { id = DMB+190 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543359] = { id = DMB+191 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543360] = { id = DMB+192 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543361] = { id = DMB+193 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543362] = { id = DMB+194 }, -- Avatar_Icon    Avatar Icon
    [17543363] = { id = DMB+195 }, -- Avatar_Icon    Avatar Icon
    [17543364] = { id = DMB+196 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543365] = { id = DMB+197 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543366] = { id = DMB+198 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543367] = { id = DMB+199 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543368] = { id = DMB+200 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543369] = { id = DMB+201 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543370] = { id = DMB+202 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543371] = { id = DMB+203 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543372] = { id = DMB+204 }, -- Avatar_Idol    Avatar Idol
    [17543373] = { id = DMB+205 }, -- Vanguard_Priest    Vanguard Priest
    [17543374] = { id = DMB+206 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543375] = { id = DMB+207 }, -- Xoo_Kaza_the_Solemn    Xoo Kaza the Solemn
    [17543376] = { id = DMB+208 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543377] = { id = DMB+209 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543378] = { id = DMB+210 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543379] = { id = DMB+211 }, -- Vanguard_Priest    Vanguard Priest
    [17543380] = { id = DMB+212 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543381] = { id = DMB+213 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543382] = { id = DMB+214 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543383] = { id = DMB+215 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543384] = { id = DMB+216 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543385] = { id = DMB+217 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543386] = { id = DMB+218 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543387] = { id = DMB+219 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543388] = { id = DMB+220 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543389] = { id = DMB+221 }, -- Vanguard_Priest    Vanguard Priest
    [17543390] = { id = DMB+222 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543391] = { id = DMB+223 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543392] = { id = DMB+224 }, -- Avatar_Icon    Avatar Icon
    [17543393] = { id = DMB+225 }, -- Avatar_Icon    Avatar Icon
    [17543394] = { id = DMB+226 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543395] = { id = DMB+227 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543396] = { id = DMB+228 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543397] = { id = DMB+229 }, -- Vanguard_Priest    Vanguard Priest
    [17543398] = { id = DMB+230 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543399] = { id = DMB+231 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543400] = { id = DMB+232 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543401] = { id = DMB+233 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543402] = { id = DMB+234 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543403] = { id = DMB+235 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543404] = { id = DMB+236 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543405] = { id = DMB+237 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543406] = { id = DMB+238 }, -- Vanguard_Ogresoother    Vanguard Ogresoother
    [17543407] = { id = DMB+239 }, -- Vanguards_Crow    Vanguard\s Crow
    [17543408] = { id = DMB+240 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543409] = { id = DMB+241 }, -- Avatar_Icon    Avatar Icon
    [17543410] = { id = DMB+242 }, -- Avatar_Icon    Avatar Icon
    [17543411] = { id = DMB+243 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543412] = { id = DMB+244 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543413] = { id = DMB+245 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543414] = { id = DMB+246 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543415] = { id = DMB+247 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543416] = { id = DMB+248 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543417] = { id = DMB+249 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543418] = { id = DMB+250 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543419] = { id = DMB+251 }, -- Avatar_Icon    Avatar Icon
    [17543420] = { id = DMB+252 }, -- Avatar_Icon    Avatar Icon
    [17543421] = { id = DMB+253 }, -- Avatar_Icon    Avatar Icon
    [17543422] = { id = DMB+254 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543423] = { id = DMB+255 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543424] = { id = DMB+256 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543425] = { id = DMB+257 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543426] = { id = DMB+258 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543427] = { id = DMB+259 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543428] = { id = DMB+260 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543429] = { id = DMB+261 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543430] = { id = DMB+262 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543431] = { id = DMB+263 }, -- Vanguard_Partisan    Vanguard Partisan
    [17543432] = { id = DMB+264 }, -- Vanguards_Wyvern    Vanguard\s Wyvern
    [17543433] = { id = DMB+265 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543434] = { id = DMB+266 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543435] = { id = DMB+267 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543436] = { id = DMB+268 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543437] = { id = DMB+269 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543438] = { id = DMB+270 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543439] = { id = DMB+271 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543440] = { id = DMB+272 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543441] = { id = DMB+273 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543442] = { id = DMB+274 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543443] = { id = DMB+275 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543444] = { id = DMB+276 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543445] = { id = DMB+277 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543446] = { id = DMB+278 }, -- Avatar_Idol    Avatar Idol
    [17543447] = { id = DMB+279 }, -- Vanguard_Skirmisher    Vanguard Skirmisher
    [17543448] = { id = DMB+280 }, -- Vanguard_Sentinel    Vanguard Sentinel
    [17543449] = { id = DMB+281 }, -- Vanguard_Priest    Vanguard Priest
    [17543450] = { id = DMB+282 }, -- Vanguard_Prelate    Vanguard Prelate
    [17543451] = { id = DMB+283 }, -- Vanguard_Visionary    Vanguard Visionary
    [17543452] = { id = DMB+284 }, -- Vanguard_Liberator    Vanguard Liberator
    [17543453] = { id = DMB+285 }, -- Vanguard_Exemplar    Vanguard Exemplar
    [17543454] = { id = DMB+286 }, -- Vanguard_Inciter    Vanguard Inciter
    [17543455] = { id = DMB+287 }, -- Vanguard_Chanter    Vanguard Chanter
    [17543456] = { id = DMB+288 }, -- Vanguard_Salvager    Vanguard Salvager
    [17543457] = { id = DMB+289 }, -- Vanguard_Persecutor    Vanguard Persecutor
    [17543458] = { id = DMB+290 }, -- Vanguard_Assassin    Vanguard Assassin
    [17543459] = { id = DMB+291 }, -- Vanguard_Oracle    Vanguard Oracle
    [17543460] = { id = DMB+292 }, -- Vanguards_Avatar    Vanguard\s Avatar
    [17543461] = { id = DMB+293 }, -- Avatar_Icon    Avatar Icon
    [17543462] = { id = DMB+294 }, -- Avatar_Icon    Avatar Icon
    [17543463] = { id = DMB+295 }, -- Avatar_Icon    Avatar Icon
    [SMB+0] = { id = SMB+0 }, -- Avatar Icon
    [SMB+1] = { id = SMB+1 }, -- Avatar Icon
    [SMB+2] = { id = SMB+2 }, -- Avatar Icon
    [SMB+3] = { id = SMB+3 }, -- Avatar Icon
    [SMB+4] = { id = SMB+4 }, -- Avatar Icon
    [SMB+5] = { id = SMB+5 }, -- Avatar Icon
    [SMB+6] = { id = SMB+6 }, -- Avatar Icon
    [SMB+7] = { id = SMB+7 }, -- Avatar Icon
    [SMB+8] = { id = SMB+8 }, -- Avatar Icon
    [SMB+9] = { id = SMB+9 }, -- Avatar Icon
    [SMB+10] = { id = SMB+10 }, -- Avatar Icon
    [SMB+11] = { id = SMB+11 }, -- Avatar Icon
    [SMB+12] = { id = SMB+12 }, -- Avatar Icon
    [SMB+13] = { id = SMB+13 }, -- Avatar Icon
    [SMB+14] = { id = SMB+14 }, -- Avatar Icon
    [SMB+15] = { id = SMB+15 }, -- Avatar Icon
    [SMB+16] = { id = SMB+16 }, -- Avatar Icon
    [SMB+17] = { id = SMB+17 }, -- Avatar Icon
    [SMB+18] = { id = SMB+18 }, -- Avatar Icon
    [SMB+19] = { id = SMB+19 }, -- Avatar Icon
    [SMB+20] = { id = SMB+20 }, -- Avatar Icon
    [SMB+21] = { id = SMB+21 }, -- Avatar Icon
    [SMB+22] = { id = SMB+22 }, -- Avatar Icon
    [SMB+23] = { id = SMB+23 }, -- Avatar Icon
    [SMB+24] = { id = SMB+24 }, -- Avatar Icon
    [SMB+25] = { id = SMB+25 }, -- Avatar Icon
    [SMB+26] = { id = SMB+26 }, -- Avatar Icon
    [SMB+27] = { id = SMB+27 }, -- Avatar Icon
    [SMB+28] = { id = SMB+28 }, -- Avatar Icon
    [SMB+29] = { id = SMB+29 }, -- Avatar Icon
    [SMB+30] = { id = SMB+30 }, -- Avatar Icon
    [SMB+31] = { id = SMB+31 }, -- Avatar Icon
    [SMB+32] = { id = SMB+32 }, -- Avatar Icon
    [SMB+33] = { id = SMB+33 }, -- Avatar Icon
    [SMB+34] = { id = SMB+34 }, -- Avatar Icon
    [SMB+35] = { id = SMB+35 }, -- Avatar Icon
    [SMB+36] = { id = SMB+36 }, -- Avatar Icon
    [SMB+37] = { id = SMB+37 }, -- Avatar Icon
    [SMB+38] = { id = SMB+38 }, -- Avatar Icon
    [SMB+39] = { id = SMB+39 }, -- Avatar Icon
    [SMB+40] = { id = SMB+40 }, -- Avatar Icon
    [SMB+41] = { id = SMB+41 }, -- Avatar Icon
    [SMB+42] = { id = SMB+42 }, -- Avatar Icon
    [SMB+43] = { id = SMB+43 }, -- Avatar Icon
    [SMB+44] = { id = SMB+44 }, -- Avatar Icon
    [SMB+45] = { id = SMB+45 }, -- Avatar Icon
    [SMB+46] = { id = SMB+46 }, -- Avatar Icon
    [SMB+47] = { id = SMB+47 }, -- Avatar Icon
    [SMB+48] = { id = SMB+48 }, -- Avatar Icon
    [SMB+49] = { id = SMB+49 }, -- Avatar Icon
    [SMB+50] = { id = SMB+50 }, -- Avatar Icon
    [SMB+51] = { id = SMB+51 }, -- Avatar Icon
    [SMB+52] = { id = SMB+52 }, -- Avatar Icon
    [SMB+53] = { id = SMB+53 }, -- Avatar Icon
    [SMB+54] = { id = SMB+54 }, -- Avatar Icon
    [SMB+55] = { id = SMB+55 }, -- Avatar Icon
    [SMB+56] = { id = SMB+56 }, -- Avatar Icon
    [SMB+57] = { id = SMB+57 }, -- Avatar Icon
    [SMB+58] = { id = SMB+58 }, -- Avatar Icon
    [SMB+59] = { id = SMB+59 }, -- Avatar Icon
    [SMB+60] = { id = SMB+60 }, -- Avatar Icon
    [SMB+61] = { id = SMB+61 }, -- Avatar Icon
    [SMB+62] = { id = SMB+62 }, -- Avatar Icon
    [SMB+63] = { id = SMB+63 }, -- Avatar Icon
    [SMB+64] = { id = SMB+64 }, -- Avatar Icon
    [SMB+65] = { id = SMB+65 }, -- Avatar Icon
    [SMB+66] = { id = SMB+66 }, -- Avatar Icon
    [SMB+67] = { id = SMB+67 }, -- Avatar Icon
    [SMB+68] = { id = SMB+68 }, -- Avatar Icon
    [SMB+69] = { id = SMB+69 }, -- Avatar Icon
    [SMB+70] = { id = SMB+70 }, -- Avatar Icon
    [SMB+71] = { id = SMB+71 }, -- Avatar Icon
    [SMB+72] = { id = SMB+72 }, -- Avatar Icon
    [SMB+73] = { id = SMB+73 }, -- Avatar Icon
    [SMB+74] = { id = SMB+74 }, -- Avatar Icon
    [SMB+75] = { id = SMB+75 }, -- Avatar Icon
    [SMB+76] = { id = SMB+76 }, -- Avatar Icon
    [SMB+77] = { id = SMB+77 }, -- Avatar Icon
    [SMB+78] = { id = SMB+78 }, -- Avatar Icon
    [SMB+79] = { id = SMB+79 }, -- Avatar Icon
    [SMB+80] = { id = SMB+80 }, -- Avatar Icon
    [SMB+81] = { id = SMB+81 }, -- Avatar Icon
    [SMB+82] = { id = SMB+82 }, -- Avatar Icon
    [SMB+83] = { id = SMB+83 }, -- Avatar Icon
    [SMB+84] = { id = SMB+84 }, -- Avatar Icon
    [SMB+85] = { id = SMB+85 }, -- Avatar Icon
    [SMB+86] = { id = SMB+86 }, -- Avatar Icon
    [SMB+87] = { id = SMB+87 }, -- Avatar Icon
    [SMB+88] = { id = SMB+88 }, -- Avatar Icon
    [SMB+89] = { id = SMB+89 }, -- Avatar Icon
    [SMB+90] = { id = SMB+90 }, -- Avatar Icon
    [SMB+91] = { id = SMB+91 }, -- Avatar Icon
    [SMB+92] = { id = SMB+92 }, -- Avatar Icon
    [SMB+93] = { id = SMB+93 }, -- Avatar Icon
    [SMB+94] = { id = SMB+94 }, -- Avatar Icon
    [SMB+95] = { id = SMB+95 }, -- Avatar Icon
    [SMB+96] = { id = SMB+96 }, -- Avatar Icon
    [SMB+97] = { id = SMB+97 }, -- Avatar Icon
    [SMB+98] = { id = SMB+98 }, -- Avatar Icon
    [SMB+99] = { id = SMB+99 }, -- Avatar Icon
    [SMB+100] = { id = SMB+100 }, -- Avatar Icon
    [SMB+101] = { id = SMB+101 }, -- Avatar Icon
    [SMB+102] = { id = SMB+102 }, -- Avatar Icon
    [SMB+103] = { id = SMB+103 }, -- Avatar Icon
    [SMB+104] = { id = SMB+104 }, -- Avatar Icon
    [SMB+105] = { id = SMB+105 }, -- Avatar Icon
    [SMB+106] = { id = SMB+106 }, -- Avatar Icon
    [SMB+107] = { id = SMB+107 }, -- Avatar Icon
    [SMB+108] = { id = SMB+108 }, -- Avatar Icon
    [SMB+109] = { id = SMB+109 }, -- Avatar Icon
    [SMB+110] = { id = SMB+110 }, -- Avatar Icon
    [SMB+111] = { id = SMB+111 }, -- Avatar Icon
    [SMB+112] = { id = SMB+112 }, -- Avatar Icon
    [SMB+113] = { id = SMB+113 }, -- Avatar Icon
    [SMB+114] = { id = SMB+114 }, -- Avatar Icon
    [SMB+115] = { id = SMB+115 }, -- Avatar Icon
    [SMB+116] = { id = SMB+116 }, -- Avatar Icon
    [SMB+117] = { id = SMB+117 }, -- Avatar Icon
    [SMB+118] = { id = SMB+118 }, -- Avatar Icon
    [SMB+119] = { id = SMB+119 }, -- Avatar Icon
    [SMB+120] = { id = SMB+120 }, -- Avatar Icon
    [SMB+121] = { id = SMB+121 }, -- Avatar Icon
    [SMB+122] = { id = SMB+122 }, -- Avatar Icon
    [SMB+123] = { id = SMB+123 }, -- Avatar Icon
    [SMB+124] = { id = SMB+124 }, -- Avatar Icon
    [SMB+125] = { id = SMB+125 }, -- Avatar Icon
    [SMB+126] = { id = SMB+126 }, -- Avatar Icon
    [SMB+127] = { id = SMB+127 }, -- Avatar Icon
    [SMB+128] = { id = SMB+128 }, -- Avatar Icon
    [SMB+129] = { id = SMB+129 }, -- Avatar Icon
    [SMB+130] = { id = SMB+130 }, -- Avatar Icon
    [SMB+131] = { id = SMB+131 }, -- Avatar Icon
    [SMB+132] = { id = SMB+132 }, -- Avatar Icon
    [SMB+133] = { id = SMB+133 }, -- Avatar Icon
    [SMB+134] = { id = SMB+134 }, -- Avatar Icon
    [SMB+135] = { id = SMB+135 }, -- Avatar Icon
    [SMB+136] = { id = SMB+136 }, -- Avatar Icon
    [SMB+137] = { id = SMB+137 }, -- Avatar Icon
    [SMB+138] = { id = SMB+138 }, -- Avatar Icon
    [SMB+139] = { id = SMB+139 }, -- Avatar Icon
    [SMB+140] = { id = SMB+140 }, -- Avatar Icon
    [SMB+141] = { id = SMB+141 }, -- Avatar Icon
    [SMB+142] = { id = SMB+142 }, -- Avatar Icon
    [SMB+143] = { id = SMB+143 }, -- Avatar Icon
    [SMB+144] = { id = SMB+144 }, -- Avatar Icon
    [SMB+145] = { id = SMB+145 }, -- Avatar Icon
    [SMB+146] = { id = SMB+146 }, -- Avatar Icon
    [SMB+147] = { id = SMB+147 }, -- Avatar Icon
    [SMB+148] = { id = SMB+148 }, -- Avatar Icon
    [SMB+149] = { id = SMB+149 }, -- Avatar Icon
    [SMB+150] = { id = SMB+150 }, -- Avatar Icon
    [SMB+151] = { id = SMB+151 }, -- Avatar Icon
    [SMB+152] = { id = SMB+152 }, -- Avatar Icon
    [SMB+153] = { id = SMB+153 }, -- Avatar Icon
    [SMB+154] = { id = SMB+154 }, -- Avatar Icon
    [SMB+155] = { id = SMB+155 }, -- Avatar Icon
    [SMB+156] = { id = SMB+156 }, -- Avatar Icon
    [SMB+157] = { id = SMB+157 }, -- Avatar Icon
    [SMB+158] = { id = SMB+158 }, -- Avatar Icon
    [SMB+159] = { id = SMB+159 }, -- Avatar Icon
    [SMB+160] = { id = SMB+160 }, -- Avatar Icon
    [SMB+161] = { id = SMB+161 }, -- Avatar Icon
    [SMB+162] = { id = SMB+162 }, -- Avatar Icon
    [SMB+163] = { id = SMB+163 }, -- Avatar Icon
    [SMB+164] = { id = SMB+164 }, -- Avatar Icon
    [SMB+165] = { id = SMB+165 }, -- Avatar Icon
    [SMB+166] = { id = SMB+166 }, -- Avatar Icon
    [SMB+167] = { id = SMB+167 }, -- Avatar Icon
    [SMB+168] = { id = SMB+168 }, -- Avatar Icon
    [SMB+169] = { id = SMB+169 }, -- Avatar Icon
    [SMB+170] = { id = SMB+170 }, -- Avatar Icon
    [SMB+171] = { id = SMB+171 }, -- Avatar Icon
    [SMB+172] = { id = SMB+172 }, -- Avatar Icon
    [SMB+173] = { id = SMB+173 }, -- Avatar Icon
    [SMB+174] = { id = SMB+174 }, -- Avatar Icon
    [SMB+175] = { id = SMB+175 }, -- Avatar Icon
    [SMB+176] = { id = SMB+176 }, -- Avatar Icon
    [SMB+177] = { id = SMB+177 }, -- Avatar Icon
    [SMB+178] = { id = SMB+178 }, -- Avatar Icon
    [SMB+179] = { id = SMB+179 }, -- Avatar Icon
    [SMB+180] = { id = SMB+180 }, -- Avatar Icon
    [SMB+181] = { id = SMB+181 }, -- Avatar Icon
    [SMB+182] = { id = SMB+182 }, -- Avatar Icon
    [SMB+183] = { id = SMB+183 }, -- Avatar Icon
    [SMB+184] = { id = SMB+184 }, -- Avatar Icon
    [SMB+185] = { id = SMB+185 }, -- Avatar Icon
    [SMB+186] = { id = SMB+186 }, -- Avatar Icon
    [SMB+187] = { id = SMB+187 }, -- Avatar Icon
    [SMB+188] = { id = SMB+188 }, -- Avatar Icon
    [SMB+189] = { id = SMB+189 }, -- Avatar Icon
    [SMB+190] = { id = SMB+190 }, -- Avatar Icon
    [SMB+191] = { id = SMB+191 }, -- Avatar Icon
    [SMB+192] = { id = SMB+192 }, -- Avatar Icon
    [SMB+193] = { id = SMB+193 }, -- Avatar Icon
    [SMB+194] = { id = SMB+194 }, -- Avatar Icon
    [SMB+195] = { id = SMB+195 }, -- Avatar Icon
    [SMB+196] = { id = SMB+196 }, -- Avatar Icon
    [SMB+197] = { id = SMB+197 }, -- Avatar Icon
    [SMB+198] = { id = SMB+198 }, -- Avatar Icon
    [SMB+199] = { id = SMB+199 }, -- Avatar Icon
    [SMB+200] = { id = SMB+200 }, -- Avatar Icon
    [SMB+201] = { id = SMB+201 }, -- Avatar Icon
    [SMB+202] = { id = SMB+202 }, -- Avatar Icon
    [SMB+203] = { id = SMB+203 }, -- Avatar Icon
    [SMB+204] = { id = SMB+204 }, -- Avatar Icon
    [SMB+205] = { id = SMB+205 }, -- Avatar Icon
    [SMB+206] = { id = SMB+206 }, -- Avatar Icon
    [SMB+207] = { id = SMB+207 }, -- Avatar Icon
    [SMB+208] = { id = SMB+208 }, -- Avatar Icon
    [SMB+209] = { id = SMB+209 }, -- Avatar Icon
    [SMB+210] = { id = SMB+210 }, -- Avatar Icon
    [SMB+211] = { id = SMB+211 }, -- Avatar Icon
    [SMB+212] = { id = SMB+212 }, -- Avatar Icon
    [SMB+213] = { id = SMB+213 }, -- Avatar Icon
    [SMB+214] = { id = SMB+214 }, -- Avatar Icon
    [SMB+215] = { id = SMB+215 }, -- Avatar Icon
    [SMB+216] = { id = SMB+216 }, -- Avatar Icon
    [SMB+217] = { id = SMB+217 }, -- Avatar Icon
    [SMB+218] = { id = SMB+218 }, -- Avatar Icon
    [SMB+219] = { id = SMB+219 }, -- Avatar Icon
    [SMB+220] = { id = SMB+220 }, -- Avatar Icon
    [SMB+221] = { id = SMB+221 }, -- Avatar Icon
    [SMB+222] = { id = SMB+222 }, -- Avatar Icon
    [SMB+223] = { id = SMB+223 }, -- Avatar Icon
    [SMB+224] = { id = SMB+224 }, -- Avatar Icon
    [SMB+225] = { id = SMB+225 }, -- Avatar Icon
    [SMB+226] = { id = SMB+226 }, -- Avatar Icon
    [SMB+227] = { id = SMB+227 }, -- Avatar Icon
    [SMB+228] = { id = SMB+228 }, -- Avatar Icon
    [SMB+229] = { id = SMB+229 }, -- Avatar Icon
    [SMB+230] = { id = SMB+230 }, -- Avatar Icon
    [SMB+231] = { id = SMB+231 }, -- Avatar Icon
    [SMB+232] = { id = SMB+232 }, -- Avatar Icon
    [SMB+233] = { id = SMB+233 }, -- Avatar Icon
    [SMB+234] = { id = SMB+234 }, -- Avatar Icon
    [SMB+235] = { id = SMB+235 }, -- Avatar Icon
    [SMB+236] = { id = SMB+236 }, -- Avatar Icon
    [SMB+237] = { id = SMB+237 }, -- Avatar Icon
    [SMB+238] = { id = SMB+238 }, -- Avatar Icon
    [SMB+239] = { id = SMB+239 }, -- Avatar Icon
    [SMB+240] = { id = SMB+240 }, -- Avatar Icon
    [SMB+241] = { id = SMB+241 }, -- Avatar Icon
    [SMB+242] = { id = SMB+242 }, -- Avatar Icon
    [SMB+243] = { id = SMB+243 }, -- Avatar Icon
    [SMB+244] = { id = SMB+244 }, -- Avatar Icon
    [SMB+245] = { id = SMB+245 }, -- Avatar Icon
    [SMB+246] = { id = SMB+246 }, -- Avatar Icon
    [SMB+247] = { id = SMB+247 }, -- Avatar Icon
    [SMB+248] = { id = SMB+248 }, -- Avatar Icon
    [SMB+249] = { id = SMB+249 }, -- Avatar Icon
    [SMB+250] = { id = SMB+250 }, -- Avatar Icon
    [SMB+251] = { id = SMB+251 }, -- Avatar Icon
    [SMB+252] = { id = SMB+252 }, -- Avatar Icon
    [SMB+253] = { id = SMB+253 }, -- Avatar Icon
    [SMB+254] = { id = SMB+254 }, -- Avatar Icon
    [SMB+255] = { id = SMB+255 }, -- Avatar Icon
    [SMB+256] = { id = SMB+256 }, -- Avatar Icon
    [SMB+257] = { id = SMB+257 }, -- Avatar Icon
    [SMB+258] = { id = SMB+258 }, -- Avatar Icon
    [SMB+259] = { id = SMB+259 }, -- Avatar Icon
    [SMB+260] = { id = SMB+260 }, -- Avatar Icon
    [SMB+261] = { id = SMB+261 }, -- Avatar Icon
    [SMB+262] = { id = SMB+262 }, -- Avatar Icon
    [SMB+263] = { id = SMB+263 }, -- Avatar Icon
    [SMB+264] = { id = SMB+264 }, -- Avatar Icon
    [SMB+265] = { id = SMB+265 }, -- Avatar Icon
    [SMB+266] = { id = SMB+266 }, -- Avatar Icon
    [SMB+267] = { id = SMB+267 }, -- Avatar Icon
    [SMB+268] = { id = SMB+268 }, -- Avatar Icon
    [SMB+269] = { id = SMB+269 }, -- Avatar Icon
    [SMB+270] = { id = SMB+270 }, -- Avatar Icon
    [SMB+271] = { id = SMB+271 }, -- Avatar Icon
    [SMB+272] = { id = SMB+272 }, -- Avatar Icon
    [SMB+273] = { id = SMB+273 }, -- Avatar Icon
    [SMB+274] = { id = SMB+274 }, -- Avatar Icon
    [SMB+275] = { id = SMB+275 }, -- Avatar Icon
    [SMB+276] = { id = SMB+276 }, -- Avatar Icon
    [SMB+277] = { id = SMB+277 }, -- Avatar Icon
    [SMB+278] = { id = SMB+278 }, -- Avatar Icon
    [SMB+279] = { id = SMB+279 }, -- Avatar Icon
    [SMB+280] = { id = SMB+280 }, -- Avatar Icon
    [SMB+281] = { id = SMB+281 }, -- Avatar Icon
    [SMB+282] = { id = SMB+282 }, -- Avatar Icon
    [SMB+283] = { id = SMB+283 }, -- Avatar Icon
    [SMB+284] = { id = SMB+284 }, -- Avatar Icon
    [SMB+285] = { id = SMB+285 }, -- Avatar Icon
    [SMB+286] = { id = SMB+286 }, -- Avatar Icon
    [SMB+287] = { id = SMB+287 }, -- Avatar Icon
    [SMB+288] = { id = SMB+288 }, -- Avatar Icon
    [SMB+289] = { id = SMB+289 }, -- Avatar Icon
    [SMB+290] = { id = SMB+290 }, -- Avatar Icon
    [SMB+291] = { id = SMB+291 }, -- Avatar Icon
    [SMB+292] = { id = SMB+292 }, -- Avatar Icon
    [SMB+293] = { id = SMB+293 }, -- Avatar Icon
    [SMB+294] = { id = SMB+294 }, -- Avatar Icon
    [SMB+295] = { id = SMB+295 }, -- Avatar Icon
    [SMB+296] = { id = SMB+296 }, -- Avatar Icon
    [SMB+297] = { id = SMB+297 }, -- Avatar Icon
    [SMB+298] = { id = SMB+298 }, -- Avatar Icon
    [SMB+299] = { id = SMB+299 }, -- Avatar Icon
    [SMB+300] = { id = SMB+300 }, -- Avatar Icon
    [SMB+301] = { id = SMB+301 }, -- Avatar Icon
    [SMB+302] = { id = SMB+302 }, -- Avatar Icon
    [SMB+303] = { id = SMB+303 }, -- Avatar Icon
    [SMB+304] = { id = SMB+304 }, -- Avatar Icon
    [SMB+305] = { id = SMB+305 }, -- Avatar Icon
    [SMB+306] = { id = SMB+306 }, -- Avatar Icon
    [SMB+307] = { id = SMB+307 }, -- Avatar Icon
    [SMB+308] = { id = SMB+308 }, -- Avatar Icon
    [SMB+309] = { id = SMB+309 }, -- Avatar Icon
    [SMB+310] = { id = SMB+310 }, -- Avatar Icon
    [SMB+311] = { id = SMB+311 }, -- Avatar Icon
    [SMB+312] = { id = SMB+312 }, -- Avatar Icon
    [SMB+313] = { id = SMB+313 }, -- Avatar Icon
    [SMB+314] = { id = SMB+314 }, -- Avatar Icon
    [SMB+315] = { id = SMB+315 }, -- Avatar Icon
    [SMB+316] = { id = SMB+316 }, -- Avatar Icon
    [SMB+317] = { id = SMB+317 }, -- Avatar Icon
    [SMB+318] = { id = SMB+318 }, -- Avatar Icon
    [SMB+319] = { id = SMB+319 }, -- Avatar Icon
    [SMB+320] = { id = SMB+320 }, -- Avatar Icon
    [SMB+321] = { id = SMB+321 }, -- Avatar Icon
    [SMB+322] = { id = SMB+322 }, -- Avatar Icon
    [SMB+323] = { id = SMB+323 }, -- Avatar Icon
    [SMB+324] = { id = SMB+324 }, -- Avatar Icon
    [SMB+325] = { id = SMB+325 }, -- Avatar Icon
    [SMB+326] = { id = SMB+326 }, -- Avatar Icon
    [SMB+327] = { id = SMB+327 }, -- Avatar Icon
    [SMB+328] = { id = SMB+328 }, -- Avatar Icon
    [SMB+329] = { id = SMB+329 }, -- Avatar Icon
    [SMB+330] = { id = SMB+330 }, -- Avatar Icon
    [SMB+331] = { id = SMB+331 }, -- Avatar Icon
    [SMB+332] = { id = SMB+332 }, -- Avatar Icon
    [SMB+333] = { id = SMB+333 }, -- Avatar Icon
    [SMB+334] = { id = SMB+334 }, -- Avatar Icon
    [SMB+335] = { id = SMB+335 }, -- Avatar Icon
    [SMB+336] = { id = SMB+336 }, -- Avatar Icon
    [SMB+337] = { id = SMB+337 }, -- Avatar Icon
    [SMB+338] = { id = SMB+338 }, -- Avatar Icon
    [SMB+339] = { id = SMB+339 }, -- Avatar Icon
    [SMB+340] = { id = SMB+340 }, -- Avatar Icon
    [SMB+341] = { id = SMB+341 }, -- Avatar Icon
    [SMB+342] = { id = SMB+342 }, -- Avatar Icon
    [SMB+343] = { id = SMB+343 }, -- Avatar Icon
    [SMB+344] = { id = SMB+344 }, -- Avatar Icon
    [SMB+345] = { id = SMB+345 }, -- Avatar Icon
    [SMB+346] = { id = SMB+346 }, -- Avatar Icon
    [SMB+347] = { id = SMB+347 }, -- Avatar Icon
    [SMB+348] = { id = SMB+348 }, -- Avatar Icon
    [SMB+349] = { id = SMB+349 }, -- Avatar Icon
    [SMB+350] = { id = SMB+350 }, -- Avatar Icon
    [SMB+351] = { id = SMB+351 }, -- Avatar Icon
    [SMB+352] = { id = SMB+352 }, -- Avatar Icon
    [SMB+353] = { id = SMB+353 }, -- Avatar Icon
    [SMB+354] = { id = SMB+354 }, -- Avatar Icon
    [SMB+355] = { id = SMB+355 }, -- Avatar Icon
    [SMB+356] = { id = SMB+356 }, -- Avatar Icon
    [SMB+357] = { id = SMB+357 }, -- Avatar Icon
    [SMB+358] = { id = SMB+358 }, -- Avatar Icon
    [SMB+359] = { id = SMB+359 }, -- Avatar Icon
    [SMB+360] = { id = SMB+360 }, -- Avatar Icon
    [SMB+361] = { id = SMB+361 }, -- Avatar Icon
    [SMB+362] = { id = SMB+362 }, -- Avatar Icon
    [SMB+363] = { id = SMB+363 }, -- Avatar Icon
    [SMB+364] = { id = SMB+364 }, -- Avatar Icon
    [SMB+365] = { id = SMB+365 }, -- Avatar Icon
    [SMB+366] = { id = SMB+366 }, -- Avatar Icon
    [SMB+367] = { id = SMB+367 }, -- Avatar Icon
    [SMB+368] = { id = SMB+368 }, -- Avatar Icon
    [SMB+369] = { id = SMB+369 }, -- Avatar Icon
    [SMB+370] = { id = SMB+370 }, -- Avatar Icon
    [SMB+371] = { id = SMB+371 }, -- Avatar Icon
    [SMB+372] = { id = SMB+372 }, -- Avatar Icon
    [SMB+373] = { id = SMB+373 }, -- Avatar Icon
    [SMB+374] = { id = SMB+374 }, -- Avatar Icon
    [SMB+375] = { id = SMB+375 }, -- Avatar Icon
    [SMB+376] = { id = SMB+376 }, -- Avatar Icon
    [SMB+377] = { id = SMB+377 }, -- Avatar Icon
    [SMB+378] = { id = SMB+378 }, -- Avatar Icon
    [SMB+379] = { id = SMB+379 }, -- Avatar Icon
    [SMB+380] = { id = SMB+380 }, -- Avatar Icon
    [SMB+381] = { id = SMB+381 }, -- Avatar Icon
    [SMB+382] = { id = SMB+382 }, -- Avatar Icon
    [SMB+383] = { id = SMB+383 }, -- Avatar Icon
    [SMB+384] = { id = SMB+384 }, -- Avatar Icon
    [SMB+385] = { id = SMB+385 }, -- Avatar Icon
    [SMB+386] = { id = SMB+386 }, -- Avatar Icon
    [SMB+387] = { id = SMB+387 }, -- Avatar Icon
    [SMB+388] = { id = SMB+388 }, -- Avatar Icon
    [SMB+389] = { id = SMB+389 }, -- Avatar Icon
    [SMB+390] = { id = SMB+390 }, -- Avatar Icon
    [SMB+391] = { id = SMB+391 }, -- Avatar Icon
    [SMB+392] = { id = SMB+392 }, -- Avatar Icon
    [SMB+393] = { id = SMB+393 }, -- Avatar Icon
    [SMB+394] = { id = SMB+394 }, -- Avatar Icon
    [SMB+395] = { id = SMB+395 }, -- Avatar Icon
    [SMB+396] = { id = SMB+396 }, -- Avatar Icon
    [SMB+397] = { id = SMB+397 }, -- Avatar Icon
    [SMB+398] = { id = SMB+398 }, -- Avatar Icon
    [SMB+399] = { id = SMB+399 }, -- Avatar Icon
    [SMB+400] = { id = SMB+400 }, -- Avatar Icon
    [SMB+401] = { id = SMB+401 }, -- Avatar Icon
    [SMB+402] = { id = SMB+402 }, -- Avatar Icon
    [SMB+403] = { id = SMB+403 }, -- Avatar Icon
    [SMB+404] = { id = SMB+404 }, -- Avatar Icon
    [SMB+405] = { id = SMB+405 }, -- Avatar Icon
    [SMB+406] = { id = SMB+406 }, -- Avatar Icon
    [SMB+407] = { id = SMB+407 }, -- Avatar Icon
    [SMB+408] = { id = SMB+408 }, -- Avatar Icon
    [SMB+409] = { id = SMB+409 }, -- Avatar Icon
    [SMB+410] = { id = SMB+410 }, -- Avatar Icon
    [SMB+411] = { id = SMB+411 }, -- Avatar Icon
    [SMB+412] = { id = SMB+412 }, -- Avatar Icon
    [SMB+413] = { id = SMB+413 }, -- Avatar Icon
    [SMB+414] = { id = SMB+414 }, -- Avatar Icon
    [SMB+415] = { id = SMB+415 }, -- Avatar Icon
    [SMB+416] = { id = SMB+416 }, -- Avatar Icon
    [SMB+417] = { id = SMB+417 }, -- Avatar Icon
    [SMB+418] = { id = SMB+418 }, -- Avatar Icon
    [SMB+419] = { id = SMB+419 }, -- Avatar Icon
    [SMB+420] = { id = SMB+420 }, -- Avatar Icon
    [SMB+421] = { id = SMB+421 }, -- Avatar Icon
    [SMB+422] = { id = SMB+422 }, -- Avatar Icon
    [SMB+423] = { id = SMB+423 }, -- Avatar Icon
    [SMB+424] = { id = SMB+424 }, -- Avatar Icon
    [SMB+425] = { id = SMB+425 }, -- Avatar Icon
    [SMB+426] = { id = SMB+426 }, -- Avatar Icon
    [SMB+427] = { id = SMB+427 }, -- Avatar Icon
    [SMB+428] = { id = SMB+428 }, -- Avatar Icon
    [SMB+429] = { id = SMB+429 }, -- Avatar Icon
    [SMB+430] = { id = SMB+430 }, -- Avatar Icon
    [SMB+431] = { id = SMB+431 }, -- Avatar Icon
    [SMB+432] = { id = SMB+432 }, -- Avatar Icon
    [SMB+433] = { id = SMB+433 }, -- Avatar Icon
    [SMB+434] = { id = SMB+434 }, -- Avatar Icon
    [SMB+435] = { id = SMB+435 }, -- Avatar Icon
    [SMB+436] = { id = SMB+436 }, -- Avatar Icon
    [SMB+437] = { id = SMB+437 }, -- Avatar Icon
    [SMB+438] = { id = SMB+438 }, -- Avatar Icon
    [SMB+439] = { id = SMB+439 }, -- Avatar Icon
    [SMB+440] = { id = SMB+440 }, -- Avatar Icon
    [SMB+441] = { id = SMB+441 }, -- Avatar Icon
    [SMB+442] = { id = SMB+442 }, -- Avatar Icon
    [SMB+443] = { id = SMB+443 }, -- Avatar Icon
    [SMB+444] = { id = SMB+444 }, -- Avatar Icon
    [SMB+445] = { id = SMB+445 }, -- Avatar Icon
    [SMB+446] = { id = SMB+446 }, -- Avatar Icon
    [SMB+447] = { id = SMB+447 }, -- Avatar Icon
    [SMB+448] = { id = SMB+448 }, -- Avatar Icon
    [SMB+449] = { id = SMB+449 }, -- Avatar Icon
    [SMB+450] = { id = SMB+450 }, -- Avatar Icon
    [SMB+451] = { id = SMB+451 }, -- Avatar Icon
    [SMB+452] = { id = SMB+452 }, -- Avatar Icon
    [SMB+453] = { id = SMB+453 }, -- Avatar Icon
    [SMB+454] = { id = SMB+454 }, -- Avatar Icon
    [SMB+455] = { id = SMB+455 }, -- Avatar Icon
    [SMB+456] = { id = SMB+456 }, -- Avatar Icon
    [SMB+457] = { id = SMB+457 }, -- Avatar Icon
    [SMB+458] = { id = SMB+458 }, -- Avatar Icon
    [SMB+459] = { id = SMB+459 }, -- Avatar Icon
    [SMB+460] = { id = SMB+460 }, -- Avatar Icon
    [SMB+461] = { id = SMB+461 }, -- Avatar Icon
    [SMB+462] = { id = SMB+462 }, -- Avatar Icon
    [SMB+463] = { id = SMB+463 }, -- Avatar Icon
    [SMB+464] = { id = SMB+464 }, -- Avatar Icon
    [SMB+465] = { id = SMB+465 }, -- Avatar Icon
    [SMB+466] = { id = SMB+466 }, -- Avatar Icon
    [SMB+467] = { id = SMB+467 }, -- Avatar Icon
    [SMB+468] = { id = SMB+468 }, -- Avatar Icon
    [SMB+469] = { id = SMB+469 }, -- Avatar Icon
    [SMB+470] = { id = SMB+470 }, -- Avatar Icon
    [SMB+471] = { id = SMB+471 }, -- Avatar Icon
    [SMB+472] = { id = SMB+472 }, -- Avatar Icon
    [SMB+473] = { id = SMB+473 }, -- Avatar Icon
    [SMB+474] = { id = SMB+474 }, -- Avatar Icon
    [SMB+475] = { id = SMB+475 }, -- Avatar Icon
    [SMB+476] = { id = SMB+476 }, -- Avatar Icon
    [SMB+477] = { id = SMB+477 }, -- Avatar Icon
    [SMB+478] = { id = SMB+478 }, -- Avatar Icon
    [SMB+479] = { id = SMB+479 }, -- Avatar Icon
    [SMB+480] = { id = SMB+480 }, -- Avatar Icon
    [SMB+481] = { id = SMB+481 }, -- Avatar Icon
    [SMB+482] = { id = SMB+482 }, -- Avatar Icon
    [SMB+483] = { id = SMB+483 }, -- Avatar Icon
    [SMB+484] = { id = SMB+484 }, -- Avatar Icon
    [SMB+485] = { id = SMB+485 }, -- Avatar Icon
    [SMB+486] = { id = SMB+486 }, -- Avatar Icon
    [SMB+487] = { id = SMB+487 }, -- Avatar Icon
    [SMB+488] = { id = SMB+488 }, -- Avatar Icon
    [SMB+489] = { id = SMB+489 }, -- Avatar Icon
    [SMB+490] = { id = SMB+490 }, -- Avatar Icon
    [SMB+491] = { id = SMB+491 }, -- Avatar Icon
    [SMB+492] = { id = SMB+492 }, -- Avatar Icon
    [SMB+493] = { id = SMB+493 }, -- Avatar Icon
    [SMB+494] = { id = SMB+494 }, -- Avatar Icon
    [SMB+495] = { id = SMB+495 }, -- Avatar Icon
    [SMB+496] = { id = SMB+496 }, -- Avatar Icon
    [SMB+497] = { id = SMB+497 }, -- Avatar Icon
    [SMB+498] = { id = SMB+498 }, -- Avatar Icon
    [SMB+499] = { id = SMB+499 }, -- Avatar Icon
    [SMB+500] = { id = SMB+500 }, -- Avatar Icon
    [SMB+501] = { id = SMB+501 }, -- Avatar Icon
    [SMB+502] = { id = SMB+502 }, -- Avatar Icon
    [SMB+503] = { id = SMB+503 }, -- Avatar Icon
    [SMB+504] = { id = SMB+504 }, -- Avatar Icon
    [SMB+505] = { id = SMB+505 }, -- Avatar Icon
    [SMB+506] = { id = SMB+506 }, -- Avatar Icon
    [SMB+507] = { id = SMB+507 }, -- Avatar Icon
    [SMB+508] = { id = SMB+508 }, -- Avatar Icon
    [SMB+509] = { id = SMB+509 }, -- Avatar Icon
    [SMB+510] = { id = SMB+510 }, -- Avatar Icon
    [SMB+511] = { id = SMB+511 }, -- Avatar Icon
    [SMB+512] = { id = SMB+512 }, -- Avatar Icon
    [SMB+513] = { id = SMB+513 }, -- Avatar Icon
    [SMB+514] = { id = SMB+514 }, -- Avatar Icon
    [SMB+515] = { id = SMB+515 }, -- Avatar Icon
    [SMB+516] = { id = SMB+516 }, -- Avatar Icon
    [SMB+517] = { id = SMB+517 }, -- Avatar Icon
    [SMB+518] = { id = SMB+518 }, -- Avatar Icon
    [SMB+519] = { id = SMB+519 }, -- Avatar Icon
    [SMB+520] = { id = SMB+520 }, -- Avatar Icon
    [SMB+521] = { id = SMB+521 }, -- Avatar Icon
    [SMB+522] = { id = SMB+522 }, -- Avatar Icon
    [SMB+523] = { id = SMB+523 }, -- Avatar Icon
    [SMB+524] = { id = SMB+524 }, -- Avatar Icon
    [SMB+525] = { id = SMB+525 }, -- Avatar Icon
    [SMB+526] = { id = SMB+526 }, -- Avatar Icon
    [SMB+527] = { id = SMB+527 }, -- Avatar Icon
    [SMB+528] = { id = SMB+528 }, -- Avatar Icon
    [SMB+529] = { id = SMB+529 }, -- Avatar Icon
    [SMB+530] = { id = SMB+530 }, -- Avatar Icon
    [SMB+531] = { id = SMB+531 }, -- Avatar Icon
    [SMB+532] = { id = SMB+532 }, -- Avatar Icon
    [SMB+533] = { id = SMB+533 }, -- Avatar Icon
    [SMB+534] = { id = SMB+534 }, -- Avatar Icon
    [SMB+535] = { id = SMB+535 }, -- Avatar Icon
    [SMB+536] = { id = SMB+536 }, -- Avatar Icon
    [SMB+537] = { id = SMB+537 }, -- Avatar Icon
    [SMB+538] = { id = SMB+538 }, -- Avatar Icon
    [SMB+539] = { id = SMB+539 }, -- Avatar Icon
    [SMB+540] = { id = SMB+540 }, -- Avatar Icon
    [SMB+541] = { id = SMB+541 }, -- Avatar Icon
    [SMB+542] = { id = SMB+542 }, -- Avatar Icon
    [SMB+543] = { id = SMB+543 }, -- Avatar Icon
    [SMB+544] = { id = SMB+544 }, -- Avatar Icon
    [SMB+545] = { id = SMB+545 }, -- Avatar Icon
    [SMB+546] = { id = SMB+546 }, -- Avatar Icon
    [SMB+547] = { id = SMB+547 }, -- Avatar Icon
    [SMB+548] = { id = SMB+548 }, -- Avatar Icon
    [SMB+549] = { id = SMB+549 }, -- Avatar Icon
    [SMB+550] = { id = SMB+550 }, -- Avatar Icon
    [SMB+551] = { id = SMB+551 }, -- Avatar Icon
    [SMB+552] = { id = SMB+552 }, -- Avatar Icon
    [SMB+553] = { id = SMB+553 }, -- Avatar Icon
    [SMB+554] = { id = SMB+554 }, -- Avatar Icon
    [SMB+555] = { id = SMB+555 }, -- Avatar Icon
    [SMB+556] = { id = SMB+556 }, -- Avatar Icon
    [SMB+557] = { id = SMB+557 }, -- Avatar Icon
    [SMB+558] = { id = SMB+558 }, -- Avatar Icon
    [SMB+559] = { id = SMB+559 }, -- Avatar Icon
    [SMB+560] = { id = SMB+560 }, -- Avatar Icon
    [SMB+561] = { id = SMB+561 }, -- Avatar Icon
    [SMB+562] = { id = SMB+562 }, -- Avatar Icon
    [SMB+563] = { id = SMB+563 }, -- Avatar Icon
    [SMB+564] = { id = SMB+564 }, -- Avatar Icon
    [SMB+565] = { id = SMB+565 }, -- Avatar Icon
    [SMB+566] = { id = SMB+566 }, -- Avatar Icon
    [SMB+567] = { id = SMB+567 }, -- Avatar Icon
    [SMB+568] = { id = SMB+568 }, -- Avatar Icon
    [SMB+569] = { id = SMB+569 }, -- Avatar Icon
    [SMB+570] = { id = SMB+570 }, -- Avatar Icon
    [SMB+571] = { id = SMB+571 }, -- Avatar Icon
    [SMB+572] = { id = SMB+572 }, -- Avatar Icon
    [SMB+573] = { id = SMB+573 }, -- Avatar Icon
    [SMB+574] = { id = SMB+574 }, -- Avatar Icon
    [SMB+575] = { id = SMB+575 }, -- Avatar Icon
    [SMB+576] = { id = SMB+576 }, -- Avatar Icon
    [SMB+577] = { id = SMB+577 }, -- Avatar Icon
    [SMB+578] = { id = SMB+578 }, -- Avatar Icon
    [SMB+579] = { id = SMB+579 }, -- Avatar Icon
    [SMB+580] = { id = SMB+580 }, -- Avatar Icon
    [SMB+581] = { id = SMB+581 }, -- Avatar Icon
    [SMB+582] = { id = SMB+582 }, -- Avatar Icon
    [SMB+583] = { id = SMB+583 }, -- Avatar Icon
    [SMB+584] = { id = SMB+584 }, -- Avatar Icon
    [SMB+585] = { id = SMB+585 }, -- Avatar Icon
    [SMB+586] = { id = SMB+586 }, -- Avatar Icon
    [SMB+587] = { id = SMB+587 }, -- Avatar Icon
    [SMB+588] = { id = SMB+588 }, -- Avatar Icon
    [SMB+589] = { id = SMB+589 }, -- Avatar Icon
    [SMB+590] = { id = SMB+590 }, -- Avatar Icon
    [SMB+591] = { id = SMB+591 }, -- Avatar Icon
    [SMB+592] = { id = SMB+592 }, -- Avatar Icon
    [SMB+593] = { id = SMB+593 }, -- Avatar Icon
    [SMB+594] = { id = SMB+594 }, -- Avatar Icon
    [SMB+595] = { id = SMB+595 }, -- Avatar Icon
    [SMB+596] = { id = SMB+596 }, -- Avatar Icon
    [SMB+597] = { id = SMB+597 }, -- Avatar Icon
    [SMB+598] = { id = SMB+598 }, -- Avatar Icon
    [SMB+599] = { id = SMB+599 }, -- Avatar Icon
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_WINDURST

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
-- Statue positions start from MH and work around the map in a counter clockwise fashion. See Dynamis Bums image for statue reference.
mobList[zone][SMB+1  ].pos = { -191.3586,  -0.8007, -119.4225, 131 }
mobList[zone][SMB+4  ].pos = { -157.1326,  -1.0388, -132.5858, 162 }
mobList[zone][SMB+7  ].pos = { -153.2661,  -1.3726, -126.0487, 169 }
mobList[zone][SMB+14 ].pos = { -133.2595,  -2.8095, -141.1245, 129 }
mobList[zone][SMB+13 ].pos = { -127.3385,  -2.5025, -141.3002, 129 }
mobList[zone][SMB+10 ].pos = { -122.0694,  -2.5000, -141.4553, 129 }
mobList[zone][SMB+16 ].pos = { -108.9324,  -2.7290, -131.4035, 78  }
mobList[zone][SMB+19 ].pos = {  -78.4401,  -2.5000, -118.3830, 115 }
mobList[zone][SMB+25 ].pos = {  -52.5199,  -2.5000, -111.0963, 115 }
mobList[zone][SMB+30 ].pos = {  -37.1980,  -2.5000,  -84.0250, 86  }
mobList[zone][SMB+31 ].pos = {  -23.3699,  -2.5000,  -59.9240, 87  }
mobList[zone][SMB+38 ].pos = {    0.4056,  -3.9816,  -64.6868, 181 }
mobList[zone][SMB+65 ].pos = {   35.9294,  -1.5051,  -73.7492, 192 } -- AH Front #1
mobList[zone][SMB+93 ].pos = {   70.7359,  -2.5000,  -84.8624, 157 }
mobList[zone][SMB+91 ].pos = {   73.4111,  -2.5000,  -82.0445, 156 }
mobList[zone][SMB+88 ].pos = {   83.9324,  -2.5000,  -96.0296, 159 }
mobList[zone][SMB+95 ].pos = {   96.5838,  -2.9733, -150.9429, 161 }
mobList[zone][SMB+69 ].pos = {   65.3009,  -2.5000,  -63.9545, 62  }
mobList[zone][SMB+62 ].pos = {   52.0825,  -2.5000,  -67.6000, 57  } -- AH Front #4
mobList[zone][SMB+59 ].pos = {   44.0394,  -2.5000,  -59.0231, 56  } -- AH Front #3
mobList[zone][SMB+56 ].pos = {   35.8530,  -1.7400,  -67.6000, 192 } -- AH Front #2
mobList[zone][SMB+50 ].pos = {   23.3167,  -2.5356,  -54.0313, 128 } -- AH W
mobList[zone][SMB+47 ].pos = {   -0.5679,  -4.6828,  -40.2208, 57  }
mobList[zone][SMB+44 ].pos = {   -4.0851,  -6.9034,  -34.4860, 55  }
mobList[zone][SMB+41 ].pos = {    3.0496,  -6.8929,  -33.3899, 66  }
mobList[zone][SMB+84 ].pos = {   32.7444,  -6.5569,  -39.2404, 91  }
mobList[zone][SMB+79 ].pos = {   49.7591,  -7.2500,  -50.2882, 125 }
mobList[zone][SMB+76 ].pos = {   65.1695,  -7.5000,  -58.1862, 188 }
mobList[zone][SMB+104].pos = {   10.2201,  -9.3104,  -12.8596, 188 }
mobList[zone][SMB+99 ].pos = {   -8.9197,  -9.1494,  -17.4656, 193 }
mobList[zone][SMB+109].pos = {   29.4569, -10.0000,    9.8415, 115 }
mobList[zone][SMB+114].pos = {   36.4718, -10.0000,   14.1809, 107 }
mobList[zone][SMB+119].pos = {   47.1577,  -9.7839,   26.4536, 203 }
mobList[zone][SMB+134].pos = {   51.1535,  -9.7235,   26.0237, 96  }
mobList[zone][SMB+132].pos = {   56.4283,  -9.9857,   22.8728, 116 }
mobList[zone][SMB+131].pos = {   63.9901,  -9.8617,   26.3874, 112 }
mobList[zone][SMB+126].pos = {   48.9704,  -9.9449,   41.3764, 90  }
mobList[zone][SMB+138].pos = {   63.9502,  -9.3320,   44.8385, 85  }
mobList[zone][SMB+136].pos = {   71.1621,  -8.2875,   41.9001, 96  }
mobList[zone][SMB+140].pos = {   84.2937,  -5.1750,   52.7730, 139 }
mobList[zone][SMB+152].pos = {   90.3063,  -4.3568,   89.1465, 120 }
mobList[zone][SMB+156].pos = {   79.5591,  -2.5393,  101.2697, 11  }
mobList[zone][SMB+141].pos = {   99.7152,  -2.5000,  112.4246, 134 }
mobList[zone][SMB+145].pos = {  100.5174,  -2.5203,  118.6604, 128 }
mobList[zone][SMB+147].pos = {  109.7585,  -8.0000,  114.0638, 133 }
mobList[zone][SMB+164].pos = {   96.7755,  -7.8592,  151.8655, 124 }
mobList[zone][SMB+169].pos = {  118.6259, -11.5000,  152.0082, 128 }
mobList[zone][SMB+166].pos = {  118.8364, -11.5000,  157.4733, 119 }
mobList[zone][SMB+159].pos = {  119.1999, -11.5000,  147.4525, 136 }
mobList[zone][SMB+163].pos = {  111.9339, -11.0061,  151.8975, 130 }
mobList[zone][SMB+165].pos = {  104.0310,  -9.4472,  175.3735, 156 }
mobList[zone][SMB+179].pos = {  105.8542,  -8.0000,  189.9759, 101 }
mobList[zone][SMB+171].pos = {  101.5380, -10.2956,  137.2695, 228 }
mobList[zone][SMB+172].pos = {   92.5824,  -7.5977,  188.4694, 97  }
mobList[zone][SMB+176].pos = {   94.0309,  -8.0000,  201.6249, 84  }
mobList[zone][SMB+182].pos = {   99.9479, -13.0000,  195.7264, 97  }
mobList[zone][SMB+187].pos = {  118.8019, -12.5000,  202.3472, 103 }
mobList[zone][SMB+196].pos = {   48.0042,  -7.5000,  213.0020, 192 } -- Bridge to HotH #4
mobList[zone][SMB+190].pos = {   54.0082,  -7.5000,  220.0016, 128 } -- Bridge to HotH #1
mobList[zone][SMB+194].pos = {   48.0043,  -7.5000,  226.0027, 64  } -- Bridge to HotH #3
mobList[zone][SMB+192].pos = {   42.0040,  -7.5000,  219.0071, 255 } -- Bridge to HotH #2
mobList[zone][SMB+227].pos = {   28.1538,   0.8503,  237.1400, 237 }
mobList[zone][SMB+231].pos = {   22.6764,   0.2154,  242.4806, 230 }
mobList[zone][SMB+234].pos = {    5.8521,  -2.5000,  277.6603, 225 }
mobList[zone][SMB+217].pos = {   14.9524,  -7.6141,  258.5253, 73  }
mobList[zone][SMB+219].pos = {    6.4487,  -7.3724,  265.7156, 2   }
mobList[zone][SMB+221].pos = {   -3.5774,  -9.8122,  272.4613, 22  }
mobList[zone][SMB+224].pos = {   -3.8707, -10.0098,  281.4271, 66  }
mobList[zone][SMB+198].pos = {  -25.9441, -13.0000,  259.9019, 63  }
mobList[zone][SMB+216].pos = {  -18.2790, -15.8131,  283.6844, 64  }
mobList[zone][SMB+211].pos = {  -20.0292, -17.5000,  271.5286, 63  }
mobList[zone][SMB+205].pos = {  -29.3468, -18.0000,  264.7773, 92  } -- HotH Roof #1
mobList[zone][SMB+242].pos = {  -38.1715, -12.5000,  243.5549, 231 }
mobList[zone][SMB+238].pos = {  -51.9927, -12.5000,  234.5901, 232 }
mobList[zone][SMB+241].pos = {  -57.1476, -12.5000,  226.7977, 198 }
mobList[zone][SMB+239].pos = {  -61.2544, -12.5000,  209.1542, 202 }
mobList[zone][SMB+255].pos = {  -90.3463, -12.5000,  205.7868, 39  }
mobList[zone][SMB+248].pos = {  -97.4772, -18.0000,  194.7494, 38  }
mobList[zone][SMB+244].pos = { -102.3704, -17.5000,  199.8088, 34  }
mobList[zone][SMB+254].pos = { -116.9012, -17.5000,  202.7513, 26  }
mobList[zone][SMB+251].pos = {  -93.9415, -13.0165,  190.3358, 35  }
mobList[zone][SMB+274].pos = {  -99.4352,  -5.3920,  150.1503, 211 }
mobList[zone][SMB+276].pos = {  -94.2243,  -5.6397,  148.8194, 203 }
mobList[zone][SMB+319].pos = { -147.0541,  -2.5000,  147.9715, 255 }
mobList[zone][SMB+317].pos = { -155.1755,  -2.5000,  147.9511, 1   }
mobList[zone][SMB+315].pos = { -166.9078,  -2.5000,  147.9220, 250 }
mobList[zone][SMB+311].pos = { -182.8609,  -2.3945,  147.8914, 1   }
mobList[zone][SMB+269].pos = { -106.9414,  -5.2500,  138.3956, 247 }
mobList[zone][SMB+261].pos = { -101.2070,  -5.2500,  136.3775, 251 }
mobList[zone][SMB+257].pos = {  -97.8836,  -5.4114,  131.3158, 240 }
mobList[zone][SMB+260].pos = {  -96.6092,  -5.0255,  126.1928, 245 }
mobList[zone][SMB+262].pos = {  -98.6045,  -5.0716,  121.7827, 252 }
mobList[zone][SMB+286].pos = { -116.7779, -10.0000,  131.8773, 239 }
mobList[zone][SMB+292].pos = { -110.5085, -10.0000,  127.4100, 242 }
mobList[zone][SMB+289].pos = { -113.9647, -10.0000,  116.8070, 239 }
mobList[zone][SMB+277].pos = {  -68.2300,  -5.0599,  123.0997, 132 }
mobList[zone][SMB+282].pos = {  -72.9114,  -5.0000,  128.4209, 152 }
mobList[zone][SMB+284].pos = {  -75.5207,  -5.6239,  122.5561, 140 }
mobList[zone][SMB+267].pos = {  -85.3194,  -7.2805,  116.8355, 191 }
mobList[zone][SMB+306].pos = {  -79.2530,  -9.6845,  112.8428, 104 }
mobList[zone][SMB+302].pos = {  -76.7854,  -9.8010,  107.8378, 108 }
mobList[zone][SMB+296].pos = {  -89.5757,  -9.4564,  104.8087, 254 } -- Island leading to HT
mobList[zone][SMB+322].pos = {  -53.2480, -13.2613,  121.7133, 170 } -- Bridge to HT #1
mobList[zone][SMB+323].pos = {  -55.4420, -13.2692,  125.4680, 42  } -- Bridge to HT #2
mobList[zone][SMB+325].pos = {  -51.1625, -13.5000,  128.1870, 42  } -- Bridge to HT #3
mobList[zone][SMB+326].pos = {  -48.9547, -13.5000,  124.2935, 170 } -- Bridge to HT #4
mobList[zone][SMB+328].pos = {  -43.1181, -13.5000,  127.9526, 170 } -- Bridge to HT #5
mobList[zone][SMB+329].pos = {  -45.7040, -13.5000,  131.2713, 42  } -- Bridge to HT #6
mobList[zone][SMB+341].pos = {  -29.6329, -16.0000,  180.4627, 67  }
mobList[zone][SMB+344].pos = {   30.1441, -16.0000,  180.0908, 66  }
mobList[zone][SMB+334].pos = {    1.5785, -16.7500,  130.8298, 68  }
mobList[zone][SMB+331].pos = {   -1.9202, -16.7500,  132.4733, 63  }
mobList[zone][SMB+337].pos = {   -0.1259, -16.7500,  135.3097, 63  }
mobList[zone][SMB+352].pos = {  -88.0727,  -5.0000,   71.9304, 61  }
mobList[zone][SMB+349].pos = {  -88.0065,  -5.0000,   68.2049, 67  }
mobList[zone][SMB+348].pos = {  -87.9502,  -4.7914,   63.2007, 69  }
mobList[zone][SMB+347].pos = {  -89.5390,  -2.5000,   39.1034, 223 }
mobList[zone][SMB+353].pos = {  -75.2515,  -2.5000,   27.8064, 32  }
mobList[zone][SMB+354].pos = {  -65.9548,  -2.5000,   19.0511, 29  }
mobList[zone][SMB+357].pos = {  -58.6351,  -2.5000,   11.6573, 30  }
mobList[zone][SMB+374].pos = { -224.4653,  -0.2500,  -98.4432, 3   }
mobList[zone][SMB+381].pos = { -224.6530,  -0.2500, -142.7501, 2   }
mobList[zone][SMB+385].pos = { -203.7979,  -0.2568, -139.7601, 127 }
mobList[zone][SMB+377].pos = { -203.1892,   0.0000, -102.3044, 139 }
mobList[zone][SMB+389].pos = {  -97.5736,  -2.5000, -123.1625, 116 }
mobList[zone][SMB+405].pos = {  -52.6701,  -2.5000, -110.9600, 114 }
mobList[zone][SMB+401].pos = {  -42.5879,  -2.5000,  -93.5101, 82  }
mobList[zone][SMB+396].pos = {  -24.7360,  -2.5000,  -62.6215, 84  }
mobList[zone][DMB+1  ].pos = {   43.6181,  -2.2996,  -65.4926, 64  }
mobList[zone][SMB+373].pos = {   52.4692,  -2.5000,  -66.7366, 80  }
mobList[zone][SMB+372].pos = {   35.9184,  -2.3574,  -65.5872, 62  }
mobList[zone][SMB+367].pos = {   40.3916,  -2.5000,  -59.3094, 67  }
mobList[zone][SMB+363].pos = {   48.2035,  -2.5000,  -59.4354, 65  }
mobList[zone][SMB+424].pos = {  -15.3458,  -9.4624,  -20.5847, 200 }
mobList[zone][SMB+414].pos = {   -8.2887,  -8.1750,    0.9049, 61  }
mobList[zone][SMB+410].pos = {    2.0926,  -9.6610,    4.3648, 52  }
mobList[zone][SMB+420].pos = {   15.3171,  -9.7436,  -20.1585, 199 }
mobList[zone][SMB+427].pos = {   83.4762,  -2.5000,   78.5478, 81  }
mobList[zone][SMB+431].pos = {   79.1087,  -2.5000,   79.9801, 78  }
mobList[zone][SMB+436].pos = {   88.7325,  -5.2644,  147.4140, 141 }
mobList[zone][SMB+441].pos = {   88.6722,  -5.4650,  153.6191, 129 }
mobList[zone][SMB+446].pos = {   88.1672,  -7.5000,  200.0317, 68  }
mobList[zone][SMB+454].pos = {  -18.3020, -12.4241,  242.4440, 165 }
mobList[zone][SMB+478].pos = {  -88.6582, -12.4611,  204.1679, 34  }
mobList[zone][SMB+473].pos = {  -67.7383, -11.6475,  182.5894, 198 }
mobList[zone][SMB+467].pos = {  -73.0340,  -8.9370,  170.9037, 218 }
mobList[zone][SMB+461].pos = {  -88.9700,  -6.1359,  162.0545, 244 }
mobList[zone][SMB+485].pos = { -151.7798,  -2.5000,  148.1190, 1   }
mobList[zone][SMB+491].pos = {   35.0899, -16.0000,  160.1173, 65  }
mobList[zone][SMB+497].pos = {   -0.2031, -16.0000,  195.0251, 63  }

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path = { 11, 22, 33, 66, 77, 88, }

mobList[zone][SMB+19 ].patrolPath = {  -99, -2.5, -123, -59, -2.5, -112, -99, -2.5, -123 } -- Entrance Bridge W
mobList[zone][SMB+30 ].patrolPath = {  -49, -2.5, -105, -25, -2.5, -64,  -49, -2.5, -105 } -- Entrance Bridge E
mobList[zone][SMB+47 ].patrolPath = {  -1, -4, -47,     -1, -7, -24,     -1, -4, -47     } -- AH W Ramp
mobList[zone][SMB+56 ].patrolPath = {   36, -2.5, -59,   36, -2.3, -66,   36, -2.5, -59  } -- AH #1
mobList[zone][SMB+59 ].patrolPath = {   44, -2.5, -66,   44, -1.7, -59,   44, -2.5, -66  } -- AH #2
mobList[zone][SMB+62 ].patrolPath = {   52, -1.7, -59,   52, -2.5, -66,   52, -1.7, -59  } -- AH #3
mobList[zone][SMB+165].patrolPath = {   99, -7.8, 179,  108, -10.8, 171,  99, -1.7, 179  } -- E House Ramp
mobList[zone][SMB+267].patrolPath = {  -84, -8.8, 111,  -85, -6,  121,   -84, -8.8, 111  } -- Island to HT
mobList[zone][SMB+348].patrolPath = {  -88, -2.5, 48,   -88, -5,  82,    -88, -2.5, 48   } -- SW Bridge #1
mobList[zone][SMB+349].patrolPath = {  -88, -2.5, 48,   -88, -5,  82,    -88, -2.5, 48   } -- SW Bridge #2
mobList[zone][SMB+352].patrolPath = {  -88, -2.5, 48,   -88, -5,  82,    -88, -2.5, 48   } -- SW Bridge #3
mobList[zone][SMB+241].patrolPath = {  -57, -12.5, 226, -61, -12.5, 209, -57, -12.5, 226 } -- NW Bridge S
mobList[zone][SMB+238].patrolPath = {  -52, -12.5, 234, -36, -12.5, 244, -52, -12.5, 234 } -- NW Bridge N
mobList[zone][SMB+196].patrolPath = {   48, -7.5, 213,  48, -7.5, 216,  48, -7.5, 213 } -- Bridge to HotH #4
mobList[zone][SMB+190].patrolPath = {   54, -7.5, 220,  51, -7.5, 220,  54, -7.5, 220 } -- Bridge to HotH #1
mobList[zone][SMB+194].patrolPath = {   48, -7.5, 226,  48, -7.5, 223,  48, -7.5, 226 } -- Bridge to HotH #3
mobList[zone][SMB+192].patrolPath = {   42, -7.5, 219,  45, -7.5, 219,  42, -7.5, 219 } -- Bridge to HotH #2

-- set statue eye color
mobList[zone][SMB+10 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+19 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+38 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+56 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+59 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+62 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+69 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+95 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+99 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+104].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+109].eyes = dynamis.eyes.RED
mobList[zone][SMB+119].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+131].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+140].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+152].eyes = dynamis.eyes.RED
mobList[zone][SMB+156].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+147].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+171].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+182].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+187].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+234].eyes = dynamis.eyes.RED
mobList[zone][SMB+224].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+210].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+211].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+205].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+253].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+254].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+319].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+311].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+269].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+292].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+262].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+277].eyes = dynamis.eyes.RED
mobList[zone][SMB+325].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+326].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+331].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+334].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+347].eyes = dynamis.eyes.RED
mobList[zone][SMB+354].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+374].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+381].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+389].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+401].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+410].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+414].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+427].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+431].eyes = dynamis.eyes.GREEN

-- set time extensions
mobList[zone][SMB+19 ].timeExtension = 20
mobList[zone][SMB+59 ].timeExtension = 20
mobList[zone][SMB+109].timeExtension = 10
mobList[zone][SMB+152].timeExtension = 20
mobList[zone][SMB+234].timeExtension = 20
mobList[zone][SMB+277].timeExtension = 20
mobList[zone][SMB+347].timeExtension = 10
mobList[zone][DMB+1  ].timeExtension = 30

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+189 } -- MNK NM spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[3] = { DMB+207 } -- BLM NM spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[4] = { DMB+126 } -- SMN NM spawns 2 Statues at Heavens Tower
mobList[zone].waveDefeatRequirements[5] = { SMB+323, SMB+322, SMB+325, SMB+326, SMB+329, SMB+328 } -- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
mobList[zone].waveDefeatRequirements[6] = { DMB+177 } -- Boss spawned on RDM NM death
mobList[zone].waveDefeatRequirements[7] = { DMB+1 } -- Final Boss spawns wave 7 when defeated
mobList[zone].waveDefeatRequirements[8] = { SMB+296 } -- pops 302/306 when defeated
mobList[zone].waveDefeatRequirements[9] = { SMB+347 } -- pops 353/354/357 on bridge when defeated
mobList[zone].waveDefeatRequirements[10] = { SMB+234 } -- pops 227/231 under bridge when defeated
mobList[zone].waveDefeatRequirements[11] = { SMB+187 } -- pops 176/179 under bridge when defeated

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+4  ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+7  ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+14 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+13 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+10 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+16 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+19 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+25 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+30 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+31 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+38 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+65 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+88 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+62 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+59 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+56 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+50 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+47 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+44 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+41 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+84 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+79 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+76 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+104].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+109].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+119].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+131].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+136].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+138].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+140].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+126].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+152].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+141].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+145].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+147].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+169].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+165].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+171].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+172].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+182].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+187].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+196].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+190].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+194].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+192].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+234].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+217].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+198].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+216].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+211].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+205].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+238].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+241].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+248].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+254].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+311].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+269].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+257].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+262].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+292].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+277].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+296].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+352].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+349].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+348].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+347].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+374].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+381].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+385].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+377].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+389].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+405].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+401].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+396].waves = {  1 ,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+323].waves = { nil, 2 ,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+322].waves = { nil, 2 ,nil,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+325].waves = { nil,nil, 3 ,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+326].waves = { nil,nil, 3 ,nil,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+328].waves = { nil,nil,nil, 4 ,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+329].waves = { nil,nil,nil, 4 ,nil,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+337].waves = { nil,nil,nil,nil, 5 ,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+341].waves = { nil,nil,nil,nil, 5 ,nil,nil,nil,nil,nil,nil }
mobList[zone][SMB+344].waves = { nil,nil,nil,nil, 5 ,nil,nil,nil,nil,nil,nil }
mobList[zone][DMB+1  ].waves = { nil,nil,nil,nil,nil, 6 ,nil,nil,nil,nil,nil }
mobList[zone][SMB+374].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+381].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+385].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+377].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+389].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+405].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+401].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+396].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+424].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+414].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+410].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+420].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+427].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+431].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+436].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+441].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+446].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+454].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+478].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+473].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+467].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+461].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+485].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+491].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+497].waves = { nil,nil,nil,nil,nil,nil, 7 ,nil,nil,nil,nil }
mobList[zone][SMB+302].waves = { nil,nil,nil,nil,nil,nil,nil, 8 ,nil,nil,nil }
mobList[zone][SMB+306].waves = { nil,nil,nil,nil,nil,nil,nil, 8 ,nil,nil,nil }
mobList[zone][SMB+353].waves = { nil,nil,nil,nil,nil,nil,nil,nil, 9 ,nil,nil }
mobList[zone][SMB+354].waves = { nil,nil,nil,nil,nil,nil,nil,nil, 9 ,nil,nil }
mobList[zone][SMB+357].waves = { nil,nil,nil,nil,nil,nil,nil,nil, 9 ,nil,nil }
mobList[zone][SMB+227].waves = { nil,nil,nil,nil,nil,nil,nil,nil,nil, 10,nil }
mobList[zone][SMB+231].waves = { nil,nil,nil,nil,nil,nil,nil,nil,nil, 10,nil }
mobList[zone][SMB+176].waves = { nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 11 }
mobList[zone][SMB+179].waves = { nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 11 }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues) boolean value = forceLink enabled yes/no (default no if unspecified)
mobList[zone][SMB+88 ].specificChildren = { SMB+91, SMB+93 }
mobList[zone][SMB+95 ].specificChildren = { SMB+69 }
mobList[zone][SMB+119].specificChildren = { SMB+114 }
mobList[zone][SMB+131].specificChildren = { true, SMB+132, SMB+134 }
mobList[zone][SMB+152].specificChildren = { SMB+156 }
mobList[zone][SMB+169].specificChildren = { true, DMB+189, SMB+159, SMB+163, SMB+166, false, SMB+164 }
mobList[zone][SMB+217].specificChildren = { SMB+219 } 
mobList[zone][SMB+219].specificChildren = { SMB+221 }
mobList[zone][SMB+221].specificChildren = { SMB+224 }
mobList[zone][SMB+198].specificChildren = { true, DMB+126 }
mobList[zone][SMB+241].specificChildren = { SMB+242 }
mobList[zone][SMB+238].specificChildren = { SMB+239 }
mobList[zone][SMB+277].specificChildren = { true, SMB+284, SMB+282 }
mobList[zone][SMB+248].specificChildren = { true, DMB+207, SMB+244, SMB+251, SMB+255 }
mobList[zone][SMB+311].specificChildren = { SMB+315, SMB+317, SMB+319 }
mobList[zone][SMB+257].specificChildren = { true, SMB+261, SMB+260 }
mobList[zone][SMB+262].specificChildren = { SMB+267 }
mobList[zone][SMB+269].specificChildren = { SMB+274, SMB+276 }
mobList[zone][SMB+292].specificChildren = { SMB+286, SMB+289 }
mobList[zone][SMB+337].specificChildren = { true, DMB+177, SMB+331, SMB+334}
mobList[zone][DMB+1  ].specificChildren = { true, DMB+2, DMB+3, SMB+367, SMB+363, SMB+372, SMB+373 }

-- set how many random children i will spawn when i engage
mobList[zone][SMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+4  ].randomChildrenCount = 2
mobList[zone][SMB+7  ].randomChildrenCount = 2
mobList[zone][SMB+14 ].randomChildrenCount = 1
mobList[zone][SMB+13 ].randomChildrenCount = 0
mobList[zone][SMB+10 ].randomChildrenCount = 2
mobList[zone][SMB+16 ].randomChildrenCount = 2
mobList[zone][SMB+19 ].randomChildrenCount = 3
mobList[zone][SMB+25 ].randomChildrenCount = 4
mobList[zone][SMB+30 ].randomChildrenCount = 0
mobList[zone][SMB+31 ].randomChildrenCount = 4
mobList[zone][SMB+41 ].randomChildrenCount = 2
mobList[zone][SMB+44 ].randomChildrenCount = 2
mobList[zone][SMB+47 ].randomChildrenCount = 2
mobList[zone][SMB+38 ].randomChildrenCount = 2
mobList[zone][SMB+50 ].randomChildrenCount = 3
mobList[zone][SMB+65 ].randomChildrenCount = 3
mobList[zone][SMB+91 ].randomChildrenCount = 1
mobList[zone][SMB+93 ].randomChildrenCount = 1
mobList[zone][SMB+88 ].randomChildrenCount = 2
mobList[zone][SMB+95 ].randomChildrenCount = 3
mobList[zone][SMB+69 ].randomChildrenCount = 3
mobList[zone][SMB+56 ].randomChildrenCount = 2
mobList[zone][SMB+59 ].randomChildrenCount = 2
mobList[zone][SMB+62 ].randomChildrenCount = 2
mobList[zone][SMB+84 ].randomChildrenCount = 3
mobList[zone][SMB+79 ].randomChildrenCount = 4
mobList[zone][SMB+76 ].randomChildrenCount = 2
mobList[zone][SMB+99 ].randomChildrenCount = 4
mobList[zone][SMB+104].randomChildrenCount = 4
mobList[zone][SMB+109].randomChildrenCount = 3
mobList[zone][SMB+114].randomChildrenCount = 3
mobList[zone][SMB+119].randomChildrenCount = 3
mobList[zone][SMB+126].randomChildrenCount = 2
mobList[zone][SMB+131].randomChildrenCount = 0
mobList[zone][SMB+132].randomChildrenCount = 1
mobList[zone][SMB+134].randomChildrenCount = 1
mobList[zone][SMB+136].randomChildrenCount = 1
mobList[zone][SMB+138].randomChildrenCount = 1
mobList[zone][SMB+140].randomChildrenCount = 0
mobList[zone][SMB+152].randomChildrenCount = 3
mobList[zone][SMB+156].randomChildrenCount = 2
mobList[zone][SMB+141].randomChildrenCount = 2
mobList[zone][SMB+145].randomChildrenCount = 1
mobList[zone][SMB+147].randomChildrenCount = 4
mobList[zone][SMB+164].randomChildrenCount = 0
mobList[zone][SMB+166].randomChildrenCount = 2
mobList[zone][SMB+163].randomChildrenCount = 0
mobList[zone][SMB+169].randomChildrenCount = 0
mobList[zone][SMB+159].randomChildrenCount = 2
mobList[zone][SMB+171].randomChildrenCount = 0
mobList[zone][SMB+172].randomChildrenCount = 3
mobList[zone][SMB+176].randomChildrenCount = 2
mobList[zone][SMB+182].randomChildrenCount = 4
mobList[zone][SMB+179].randomChildrenCount = 2
mobList[zone][SMB+187].randomChildrenCount = 1
mobList[zone][SMB+165].randomChildrenCount = 0
mobList[zone][SMB+194].randomChildrenCount = 1
mobList[zone][SMB+190].randomChildrenCount = 1
mobList[zone][SMB+196].randomChildrenCount = 1
mobList[zone][SMB+192].randomChildrenCount = 1
mobList[zone][SMB+227].randomChildrenCount = 2
mobList[zone][SMB+231].randomChildrenCount = 2
mobList[zone][SMB+217].randomChildrenCount = 1
mobList[zone][SMB+219].randomChildrenCount = 1
mobList[zone][SMB+221].randomChildrenCount = 1
mobList[zone][SMB+224].randomChildrenCount = 2
mobList[zone][SMB+234].randomChildrenCount = 3
mobList[zone][SMB+198].randomChildrenCount = 2
mobList[zone][SMB+205].randomChildrenCount = 3
mobList[zone][SMB+211].randomChildrenCount = 2
mobList[zone][SMB+216].randomChildrenCount = 0
mobList[zone][SMB+242].randomChildrenCount = 1
mobList[zone][SMB+238].randomChildrenCount = 0
mobList[zone][SMB+241].randomChildrenCount = 0
mobList[zone][SMB+239].randomChildrenCount = 1
mobList[zone][SMB+251].randomChildrenCount = 2
mobList[zone][SMB+248].randomChildrenCount = 2
mobList[zone][SMB+244].randomChildrenCount = 2
mobList[zone][SMB+255].randomChildrenCount = 1
mobList[zone][SMB+254].randomChildrenCount = 0
mobList[zone][SMB+276].randomChildrenCount = 0
mobList[zone][SMB+274].randomChildrenCount = 1
mobList[zone][SMB+319].randomChildrenCount = 1
mobList[zone][SMB+317].randomChildrenCount = 1
mobList[zone][SMB+315].randomChildrenCount = 1
mobList[zone][SMB+311].randomChildrenCount = 3
mobList[zone][SMB+269].randomChildrenCount = 3
mobList[zone][SMB+261].randomChildrenCount = 0
mobList[zone][SMB+257].randomChildrenCount = 2
mobList[zone][SMB+260].randomChildrenCount = 0
mobList[zone][SMB+262].randomChildrenCount = 3
mobList[zone][SMB+286].randomChildrenCount = 2
mobList[zone][SMB+292].randomChildrenCount = 3
mobList[zone][SMB+289].randomChildrenCount = 2
mobList[zone][SMB+277].randomChildrenCount = 3
mobList[zone][SMB+282].randomChildrenCount = 1
mobList[zone][SMB+284].randomChildrenCount = 1
mobList[zone][SMB+267].randomChildrenCount = 1
mobList[zone][SMB+306].randomChildrenCount = 3
mobList[zone][SMB+302].randomChildrenCount = 3
mobList[zone][SMB+296].randomChildrenCount = 5
mobList[zone][SMB+352].randomChildrenCount = 0
mobList[zone][SMB+349].randomChildrenCount = 1
mobList[zone][SMB+348].randomChildrenCount = 0
mobList[zone][SMB+347].randomChildrenCount = 0
mobList[zone][SMB+353].randomChildrenCount = 0
mobList[zone][SMB+354].randomChildrenCount = 1
mobList[zone][SMB+357].randomChildrenCount = 0
mobList[zone][SMB+329].randomChildrenCount = 1
mobList[zone][SMB+328].randomChildrenCount = 0
mobList[zone][SMB+326].randomChildrenCount = 1
mobList[zone][SMB+322].randomChildrenCount = 0
mobList[zone][SMB+323].randomChildrenCount = 1
mobList[zone][SMB+325].randomChildrenCount = 0
mobList[zone][SMB+341].randomChildrenCount = 2
mobList[zone][SMB+344].randomChildrenCount = 2
mobList[zone][SMB+337].randomChildrenCount = 2
mobList[zone][SMB+331].randomChildrenCount = 2
mobList[zone][SMB+334].randomChildrenCount = 2
mobList[zone][DMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+372].randomChildrenCount = 0
mobList[zone][SMB+367].randomChildrenCount = 3
mobList[zone][SMB+363].randomChildrenCount = 3
mobList[zone][SMB+373].randomChildrenCount = 0
mobList[zone][SMB+374].randomChildrenCount = 2
mobList[zone][SMB+377].randomChildrenCount = 3
mobList[zone][SMB+385].randomChildrenCount = 2
mobList[zone][SMB+381].randomChildrenCount = 3
mobList[zone][SMB+389].randomChildrenCount = 5
mobList[zone][SMB+405].randomChildrenCount = 3
mobList[zone][SMB+401].randomChildrenCount = 3
mobList[zone][SMB+396].randomChildrenCount = 3
mobList[zone][SMB+424].randomChildrenCount = 2
mobList[zone][SMB+414].randomChildrenCount = 4
mobList[zone][SMB+410].randomChildrenCount = 3
mobList[zone][SMB+420].randomChildrenCount = 2
mobList[zone][SMB+427].randomChildrenCount = 3
mobList[zone][SMB+431].randomChildrenCount = 3
mobList[zone][SMB+436].randomChildrenCount = 4
mobList[zone][SMB+441].randomChildrenCount = 4
mobList[zone][SMB+446].randomChildrenCount = 5
mobList[zone][SMB+454].randomChildrenCount = 5
mobList[zone][SMB+478].randomChildrenCount = 5
mobList[zone][SMB+473].randomChildrenCount = 4
mobList[zone][SMB+467].randomChildrenCount = 3
mobList[zone][SMB+461].randomChildrenCount = 4
mobList[zone][SMB+485].randomChildrenCount = 5
mobList[zone][SMB+497].randomChildrenCount = 5
mobList[zone][SMB+491].randomChildrenCount = 5

-- set my random children list i will pick from
mobList[zone][SMB+1  ].randomChildrenList = 1
mobList[zone][SMB+4  ].randomChildrenList = 1
mobList[zone][SMB+7  ].randomChildrenList = 1
mobList[zone][SMB+14 ].randomChildrenList = 1
mobList[zone][SMB+13 ].randomChildrenList = 1
mobList[zone][SMB+10 ].randomChildrenList = 1
mobList[zone][SMB+16 ].randomChildrenList = 1
mobList[zone][SMB+19 ].randomChildrenList = 1
mobList[zone][SMB+25 ].randomChildrenList = 1
mobList[zone][SMB+30 ].randomChildrenList = 1
mobList[zone][SMB+31 ].randomChildrenList = 2
mobList[zone][SMB+41 ].randomChildrenList = 2
mobList[zone][SMB+44 ].randomChildrenList = 2
mobList[zone][SMB+47 ].randomChildrenList = 2
mobList[zone][SMB+38 ].randomChildrenList = 2
mobList[zone][SMB+50 ].randomChildrenList = 2
mobList[zone][SMB+65 ].randomChildrenList = 2
mobList[zone][SMB+91 ].randomChildrenList = 2
mobList[zone][SMB+93 ].randomChildrenList = 2
mobList[zone][SMB+88 ].randomChildrenList = 2
mobList[zone][SMB+95 ].randomChildrenList = 2
mobList[zone][SMB+69 ].randomChildrenList = 2
mobList[zone][SMB+56 ].randomChildrenList = 2
mobList[zone][SMB+59 ].randomChildrenList = 2
mobList[zone][SMB+62 ].randomChildrenList = 3
mobList[zone][SMB+84 ].randomChildrenList = 2
mobList[zone][SMB+79 ].randomChildrenList = 2
mobList[zone][SMB+76 ].randomChildrenList = 2
mobList[zone][SMB+99 ].randomChildrenList = 2
mobList[zone][SMB+104].randomChildrenList = 2
mobList[zone][SMB+109].randomChildrenList = 2
mobList[zone][SMB+114].randomChildrenList = 2
mobList[zone][SMB+119].randomChildrenList = 2
mobList[zone][SMB+126].randomChildrenList = 5
mobList[zone][SMB+131].randomChildrenList = 2
mobList[zone][SMB+132].randomChildrenList = 2
mobList[zone][SMB+134].randomChildrenList = 2
mobList[zone][SMB+136].randomChildrenList = 2
mobList[zone][SMB+138].randomChildrenList = 2
mobList[zone][SMB+140].randomChildrenList = 2
mobList[zone][SMB+152].randomChildrenList = 1
mobList[zone][SMB+156].randomChildrenList = 3
mobList[zone][SMB+141].randomChildrenList = 1
mobList[zone][SMB+145].randomChildrenList = 1
mobList[zone][SMB+147].randomChildrenList = 1
mobList[zone][SMB+164].randomChildrenList = 1
mobList[zone][SMB+166].randomChildrenList = 1
mobList[zone][SMB+163].randomChildrenList = 1
mobList[zone][SMB+169].randomChildrenList = 1
mobList[zone][SMB+159].randomChildrenList = 1
mobList[zone][SMB+171].randomChildrenList = 1
mobList[zone][SMB+172].randomChildrenList = 1
mobList[zone][SMB+176].randomChildrenList = 1
mobList[zone][SMB+182].randomChildrenList = 1
mobList[zone][SMB+179].randomChildrenList = 1
mobList[zone][SMB+187].randomChildrenList = 1
mobList[zone][SMB+165].randomChildrenList = 1
mobList[zone][SMB+194].randomChildrenList = 1
mobList[zone][SMB+190].randomChildrenList = 1
mobList[zone][SMB+196].randomChildrenList = 1
mobList[zone][SMB+192].randomChildrenList = 1
mobList[zone][SMB+227].randomChildrenList = 1
mobList[zone][SMB+231].randomChildrenList = 1
mobList[zone][SMB+217].randomChildrenList = 1
mobList[zone][SMB+219].randomChildrenList = 1
mobList[zone][SMB+221].randomChildrenList = 1
mobList[zone][SMB+224].randomChildrenList = 1
mobList[zone][SMB+234].randomChildrenList = 1
mobList[zone][SMB+198].randomChildrenList = 4
mobList[zone][SMB+205].randomChildrenList = 4
mobList[zone][SMB+211].randomChildrenList = 4
mobList[zone][SMB+216].randomChildrenList = 4
mobList[zone][SMB+242].randomChildrenList = 1
mobList[zone][SMB+238].randomChildrenList = 1
mobList[zone][SMB+241].randomChildrenList = 1
mobList[zone][SMB+239].randomChildrenList = 1
mobList[zone][SMB+251].randomChildrenList = 1
mobList[zone][SMB+248].randomChildrenList = 1
mobList[zone][SMB+244].randomChildrenList = 1
mobList[zone][SMB+255].randomChildrenList = 1
mobList[zone][SMB+254].randomChildrenList = 1
mobList[zone][SMB+276].randomChildrenList = 1
mobList[zone][SMB+274].randomChildrenList = 1
mobList[zone][SMB+319].randomChildrenList = 1
mobList[zone][SMB+317].randomChildrenList = 1
mobList[zone][SMB+315].randomChildrenList = 1
mobList[zone][SMB+311].randomChildrenList = 1
mobList[zone][SMB+269].randomChildrenList = 1
mobList[zone][SMB+261].randomChildrenList = 1
mobList[zone][SMB+257].randomChildrenList = 1
mobList[zone][SMB+260].randomChildrenList = 1
mobList[zone][SMB+262].randomChildrenList = 1
mobList[zone][SMB+286].randomChildrenList = 1
mobList[zone][SMB+292].randomChildrenList = 1
mobList[zone][SMB+289].randomChildrenList = 1
mobList[zone][SMB+277].randomChildrenList = 1
mobList[zone][SMB+282].randomChildrenList = 1
mobList[zone][SMB+284].randomChildrenList = 1
mobList[zone][SMB+267].randomChildrenList = 1
mobList[zone][SMB+306].randomChildrenList = 1
mobList[zone][SMB+302].randomChildrenList = 1
mobList[zone][SMB+296].randomChildrenList = 1
mobList[zone][SMB+352].randomChildrenList = 2
mobList[zone][SMB+349].randomChildrenList = 2
mobList[zone][SMB+348].randomChildrenList = 2
mobList[zone][SMB+347].randomChildrenList = 2
mobList[zone][SMB+353].randomChildrenList = 2
mobList[zone][SMB+354].randomChildrenList = 5
mobList[zone][SMB+357].randomChildrenList = 2
mobList[zone][SMB+329].randomChildrenList = 1
mobList[zone][SMB+328].randomChildrenList = 1
mobList[zone][SMB+326].randomChildrenList = 1
mobList[zone][SMB+322].randomChildrenList = 1
mobList[zone][SMB+323].randomChildrenList = 1
mobList[zone][SMB+325].randomChildrenList = 1
mobList[zone][SMB+341].randomChildrenList = 1
mobList[zone][SMB+344].randomChildrenList = 3
mobList[zone][SMB+337].randomChildrenList = 1
mobList[zone][SMB+331].randomChildrenList = 1
mobList[zone][SMB+334].randomChildrenList = 1
mobList[zone][DMB+1  ].randomChildrenList = 2
mobList[zone][SMB+372].randomChildrenList = 2
mobList[zone][SMB+367].randomChildrenList = 2
mobList[zone][SMB+363].randomChildrenList = 2
mobList[zone][SMB+373].randomChildrenList = 2
mobList[zone][SMB+374].randomChildrenList = 2
mobList[zone][SMB+377].randomChildrenList = 2
mobList[zone][SMB+385].randomChildrenList = 2
mobList[zone][SMB+381].randomChildrenList = 2
mobList[zone][SMB+389].randomChildrenList = 2
mobList[zone][SMB+405].randomChildrenList = 2
mobList[zone][SMB+401].randomChildrenList = 2
mobList[zone][SMB+396].randomChildrenList = 2
mobList[zone][SMB+424].randomChildrenList = 2
mobList[zone][SMB+414].randomChildrenList = 2
mobList[zone][SMB+410].randomChildrenList = 2
mobList[zone][SMB+420].randomChildrenList = 2
mobList[zone][SMB+427].randomChildrenList = 2
mobList[zone][SMB+431].randomChildrenList = 2
mobList[zone][SMB+436].randomChildrenList = 2
mobList[zone][SMB+441].randomChildrenList = 2
mobList[zone][SMB+446].randomChildrenList = 2
mobList[zone][SMB+454].randomChildrenList = 2
mobList[zone][SMB+478].randomChildrenList = 2
mobList[zone][SMB+473].randomChildrenList = 2
mobList[zone][SMB+467].randomChildrenList = 2
mobList[zone][SMB+461].randomChildrenList = 2
mobList[zone][SMB+485].randomChildrenList = 2
mobList[zone][SMB+497].randomChildrenList = 2
mobList[zone][SMB+491].randomChildrenList = 2

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] = 
{
    [1] = -- all jobs except BST (the main list)
    {
        17543172, --Vanguard_Skirmisher
        17543173, --Vanguard_Priest
        17543174, --Vanguard_Prelate
        17543175, --Vanguard_Chanter
        17543176, --Vanguard_Sentinel
        17543177, --Vanguard_Priest
        17543178, --Vanguard_Visionary
        17543179, --Vanguard_Chanter
        17543180, --Vanguard_Liberator
        17543181, --Vanguard_Sentinel
        17543182, --Vanguard_Inciter
        17543183, --Vanguard_Exemplar
        17543184, --Vanguard_Salvager
        17543185, --Vanguard_Inciter
        17543188, --Vanguard_Persecutor
        17543189, --Vanguard_Assassin
        17543190, --Vanguard_Persecutor
        17543191, --Vanguard_Assassin
        17543192, --Vanguard_Partisan
        17543194, --Vanguard_Chanter
        17543195, --Vanguard_Salvager
        17543196, --Vanguard_Oracle
        17543198, --Vanguard_Skirmisher
        17543199, --Vanguard_Priest
        17543200, --Vanguard_Prelate
        17543201, --Vanguard_Visionary
        17543202, --Vanguard_Liberator
        17543205, --Vanguard_Chanter
        17543206, --Vanguard_Sentinel
        17543207, --Vanguard_Persecutor
        17543208, --Vanguard_Assassin
        17543209, --Vanguard_Salvager
        17543210, --Vanguard_Skirmisher
        17543211, --Vanguard_Exemplar
        17543212, --Vanguard_Skirmisher
        17543213, --Vanguard_Salvager
        17543214, --Vanguard_Salvager
        17543215, --Vanguard_Prelate
        17543216, --Vanguard_Oracle
        17543218, --Vanguard_Skirmisher
        17543219, --Vanguard_Priest
        17543220, --Vanguard_Salvager
        17543221, --Vanguard_Assassin
        17543222, --Vanguard_Prelate
        17543223, --Vanguard_Visionary
        17543224, --Vanguard_Liberator
        17543225, --Vanguard_Salvager
        17543226, --Vanguard_Liberator
        17543227, --Vanguard_Liberator
        17543228, --Vanguard_Sentinel
        17543229, --Vanguard_Partisan
        17543231, --Vanguard_Exemplar
        17543232, --Vanguard_Inciter
        17543233, --Vanguard_Exemplar
        17543234, --Vanguard_Inciter
        17543237, --Vanguard_Partisan
        17543241, --Vanguard_Partisan
        17543243, --Vanguard_Salvager
        17543244, --Vanguard_Prelate
        17543245, --Vanguard_Assassin
        17543246, --Vanguard_Persecutor
        17543247, --Vanguard_Salvager
        17543248, --Vanguard_Prelate
        17543249, --Vanguard_Assassin
        17543250, --Vanguard_Persecutor
        17543251, --Vanguard_Skirmisher
        17543252, --Vanguard_Sentinel
        17543253, --Vanguard_Priest
        17543254, --Vanguard_Prelate
        17543255, --Vanguard_Chanter
        17543256, --Vanguard_Partisan
        17543260, --Vanguard_Skirmisher
        17543261, --Vanguard_Sentinel
        17543262, --Vanguard_Priest
        17543263, --Vanguard_Prelate
        17543264, --Vanguard_Visionary
        17543265, --Vanguard_Liberator
        17543266, --Vanguard_Partisan
        17543270, --Vanguard_Salvager
        17543271, --Vanguard_Persecutor
        17543272, --Vanguard_Oracle
        17543276, --Vanguard_Skirmisher
        17543277, --Vanguard_Chanter
        17543278, --Vanguard_Liberator
        17543279, --Vanguard_Assassin
        17543280, --Vanguard_Prelate
        17543281, --Vanguard_Exemplar
        17543282, --Vanguard_Exemplar
        17543283, --Vanguard_Inciter
        17543284, --Vanguard_Inciter
        17543285, --Vanguard_Prelate
        17543286, --Vanguard_Oracle
        17543288, --Vanguard_Inciter
        17543289, --Vanguard_Exemplar
        17543290, --Vanguard_Skirmisher
        17543291, --Vanguard_Sentinel
        17543292, --Vanguard_Visionary
        17543293, --Vanguard_Liberator
        17543296, --Vanguard_Exemplar
        17543297, --Vanguard_Inciter
        17543298, --Vanguard_Prelate
        17543299, --Vanguard_Oracle
        17543301, --Vanguard_Salvager
        17543302, --Vanguard_Chanter
        17543303, --Vanguard_Assassin
        17543304, --Vanguard_Priest
        17543307, --Vanguard_Liberator
        17543308, --Vanguard_Exemplar
        17543309, --Vanguard_Assassin
        17543312, --Vanguard_Skirmisher
        17543313, --Vanguard_Skirmisher
        17543314, --Vanguard_Persecutor
        17543315, --Vanguard_Skirmisher
        17543316, --Vanguard_Priest
        17543317, --Vanguard_Visionary
        17543318, --Vanguard_Prelate
        17543319, --Vanguard_Sentinel
        17543320, --Vanguard_Liberator
        17543321, --Vanguard_Priest
        17543322, --Vanguard_Visionary
        17543323, --Vanguard_Prelate
        17543324, --Vanguard_Skirmisher
        17543325, --Vanguard_Sentinel
        17543326, --Vanguard_Sentinel
        17543327, --Vanguard_Liberator
        17543328, --Vanguard_Visionary
        17543329, --Vanguard_Exemplar
        17543330, --Vanguard_Inciter
        17543331, --Vanguard_Inciter
        17543334, --Vanguard_Assassin
        17543335, --Vanguard_Persecutor
        17543336, --Vanguard_Chanter
        17543337, --Vanguard_Oracle
        17543339, --Vanguard_Partisan
        17543341, --Vanguard_Assassin
        17543343, --Vanguard_Priest
        17543344, --Vanguard_Chanter
        17543346, --Vanguard_Exemplar
        17543347, --Vanguard_Assassin
        17543348, --Vanguard_Persecutor
        17543349, --Vanguard_Skirmisher
        17543350, --Vanguard_Visionary
        17543351, --Vanguard_Oracle
        17543355, --Vanguard_Priest
        17543356, --Vanguard_Chanter
        17543358, --Vanguard_Sentinel
        17543359, --Vanguard_Persecutor
        17543360, --Vanguard_Partisan
        17543364, --Vanguard_Assassin
        17543365, --Vanguard_Liberator
        17543366, --Vanguard_Inciter
        17543369, --Vanguard_Visionary
        17543370, --Vanguard_Persecutor
        17543371, --Vanguard_Assassin
        17543373, --Vanguard_Priest
        17543374, --Vanguard_Chanter
        17543376, --Vanguard_Salvager
        17543377, --Vanguard_Skirmisher
        17543378, --Vanguard_Skirmisher
        17543379, --Vanguard_Priest
        17543380, --Vanguard_Prelate
        17543381, --Vanguard_Visionary
        17543382, --Vanguard_Sentinel
        17543383, --Vanguard_Sentinel
        17543384, --Vanguard_Exemplar
        17543387, --Vanguard_Inciter
        17543388, --Vanguard_Liberator
        17543389, --Vanguard_Priest
        17543390, --Vanguard_Salvager
        17543391, --Vanguard_Assassin
        17543394, --Vanguard_Salvager
        17543395, --Vanguard_Inciter
        17543396, --Vanguard_Skirmisher
        17543397, --Vanguard_Priest
        17543398, --Vanguard_Prelate
        17543399, --Vanguard_Prelate
        17543400, --Vanguard_Visionary
        17543401, --Vanguard_Visionary
        17543402, --Vanguard_Skirmisher
        17543403, --Vanguard_Sentinel
        17543404, --Vanguard_Liberator
        17543405, --Vanguard_Liberator
        17543408, --Vanguard_Assassin
        17543411, --Vanguard_Salvager
        17543412, --Vanguard_Inciter
        17543413, --Vanguard_Persecutor
        17543414, --Vanguard_Chanter
        17543415, --Vanguard_Partisan
        17543417, --Vanguard_Chanter
        17543418, --Vanguard_Assassin
        17543422, --Vanguard_Salvager
        17543423, --Vanguard_Inciter
        17543424, --Vanguard_Oracle
        17543426, --Vanguard_Chanter
        17543427, --Vanguard_Persecutor
        17543428, --Vanguard_Assassin
        17543429, --Vanguard_Salvager
        17543430, --Vanguard_Salvager
        17543431, --Vanguard_Partisan
        17543433, --Vanguard_Chanter
        17543434, --Vanguard_Chanter
        17543435, --Vanguard_Persecutor
        17543436, --Vanguard_Persecutor
        17543437, --Vanguard_Assassin
        17543438, --Vanguard_Assassin
        17543439, --Vanguard_Assassin
        17543440, --Vanguard_Chanter
        17543441, --Vanguard_Persecutor
        17543442, --Vanguard_Oracle
        17543444, --Vanguard_Oracle
        17543447, --Vanguard_Skirmisher
        17543448, --Vanguard_Sentinel
        17543449, --Vanguard_Priest
        17543450, --Vanguard_Prelate
        17543451, --Vanguard_Visionary
        17543452, --Vanguard_Liberator
        17543453, --Vanguard_Exemplar
        17543454, --Vanguard_Inciter
        17543455, --Vanguard_Chanter
        17543456, --Vanguard_Salvager
        17543457, --Vanguard_Persecutor
        17543458, --Vanguard_Assassin
        17543459  --Vanguard_Oracle
    },    
    [2] = -- all jobs including BST (crows use silencega)
    {
        17543172, --Vanguard_Skirmisher
        17543173, --Vanguard_Priest
        17543174, --Vanguard_Prelate
        17543175, --Vanguard_Chanter
        17543176, --Vanguard_Sentinel
        17543177, --Vanguard_Priest
        17543178, --Vanguard_Visionary
        17543179, --Vanguard_Chanter
        17543180, --Vanguard_Liberator
        17543181, --Vanguard_Sentinel
        17543182, --Vanguard_Inciter
        17543186, --Vanguard_Ogresoother
        17543183, --Vanguard_Exemplar
        17543184, --Vanguard_Salvager
        17543185, --Vanguard_Inciter
        17543188, --Vanguard_Persecutor
        17543189, --Vanguard_Assassin
        17543190, --Vanguard_Persecutor
        17543191, --Vanguard_Assassin
        17543192, --Vanguard_Partisan
        17543194, --Vanguard_Chanter
        17543195, --Vanguard_Salvager
        17543196, --Vanguard_Oracle
        17543198, --Vanguard_Skirmisher
        17543199, --Vanguard_Priest
        17543200, --Vanguard_Prelate
        17543201, --Vanguard_Visionary
        17543202, --Vanguard_Liberator
        17543203, --Vanguard_Ogresoother
        17543205, --Vanguard_Chanter
        17543206, --Vanguard_Sentinel
        17543207, --Vanguard_Persecutor
        17543208, --Vanguard_Assassin
        17543209, --Vanguard_Salvager
        17543210, --Vanguard_Skirmisher
        17543211, --Vanguard_Exemplar
        17543212, --Vanguard_Skirmisher
        17543213, --Vanguard_Salvager
        17543214, --Vanguard_Salvager
        17543215, --Vanguard_Prelate
        17543216, --Vanguard_Oracle
        17543218, --Vanguard_Skirmisher
        17543219, --Vanguard_Priest
        17543220, --Vanguard_Salvager
        17543221, --Vanguard_Assassin
        17543222, --Vanguard_Prelate
        17543223, --Vanguard_Visionary
        17543224, --Vanguard_Liberator
        17543225, --Vanguard_Salvager
        17543226, --Vanguard_Liberator
        17543227, --Vanguard_Liberator
        17543228, --Vanguard_Sentinel
        17543229, --Vanguard_Partisan
        17543231, --Vanguard_Exemplar
        17543232, --Vanguard_Inciter
        17543233, --Vanguard_Exemplar
        17543234, --Vanguard_Inciter
        17543235, --Vanguard_Ogresoother
        17543237, --Vanguard_Partisan
        17543239, --Vanguard_Ogresoother
        17543241, --Vanguard_Partisan
        17543243, --Vanguard_Salvager
        17543244, --Vanguard_Prelate
        17543245, --Vanguard_Assassin
        17543246, --Vanguard_Persecutor
        17543247, --Vanguard_Salvager
        17543248, --Vanguard_Prelate
        17543249, --Vanguard_Assassin
        17543250, --Vanguard_Persecutor
        17543251, --Vanguard_Skirmisher
        17543252, --Vanguard_Sentinel
        17543253, --Vanguard_Priest
        17543254, --Vanguard_Prelate
        17543255, --Vanguard_Chanter
        17543256, --Vanguard_Partisan
        17543260, --Vanguard_Skirmisher
        17543261, --Vanguard_Sentinel
        17543262, --Vanguard_Priest
        17543263, --Vanguard_Prelate
        17543264, --Vanguard_Visionary
        17543265, --Vanguard_Liberator
        17543266, --Vanguard_Partisan
        17543270, --Vanguard_Salvager
        17543271, --Vanguard_Persecutor
        17543272, --Vanguard_Oracle
        17543274, --Vanguard_Ogresoother
        17543276, --Vanguard_Skirmisher
        17543277, --Vanguard_Chanter
        17543278, --Vanguard_Liberator
        17543279, --Vanguard_Assassin
        17543280, --Vanguard_Prelate
        17543281, --Vanguard_Exemplar
        17543282, --Vanguard_Exemplar
        17543283, --Vanguard_Inciter
        17543284, --Vanguard_Inciter
        17543285, --Vanguard_Prelate
        17543286, --Vanguard_Oracle
        17543288, --Vanguard_Inciter
        17543289, --Vanguard_Exemplar
        17543290, --Vanguard_Skirmisher
        17543291, --Vanguard_Sentinel
        17543292, --Vanguard_Visionary
        17543293, --Vanguard_Liberator
        17543296, --Vanguard_Exemplar
        17543297, --Vanguard_Inciter
        17543298, --Vanguard_Prelate
        17543299, --Vanguard_Oracle
        17543301, --Vanguard_Salvager
        17543302, --Vanguard_Chanter
        17543303, --Vanguard_Assassin
        17543304, --Vanguard_Priest
        17543307, --Vanguard_Liberator
        17543308, --Vanguard_Exemplar
        17543309, --Vanguard_Assassin
        17543310, --Vanguard_Ogresoother
        17543312, --Vanguard_Skirmisher
        17543313, --Vanguard_Skirmisher
        17543314, --Vanguard_Persecutor
        17543315, --Vanguard_Skirmisher
        17543316, --Vanguard_Priest
        17543317, --Vanguard_Visionary
        17543318, --Vanguard_Prelate
        17543319, --Vanguard_Sentinel
        17543320, --Vanguard_Liberator
        17543321, --Vanguard_Priest
        17543322, --Vanguard_Visionary
        17543323, --Vanguard_Prelate
        17543324, --Vanguard_Skirmisher
        17543325, --Vanguard_Sentinel
        17543326, --Vanguard_Sentinel
        17543327, --Vanguard_Liberator
        17543328, --Vanguard_Visionary
        17543329, --Vanguard_Exemplar
        17543330, --Vanguard_Inciter
        17543331, --Vanguard_Inciter
        17543332, --Vanguard_Ogresoother
        17543334, --Vanguard_Assassin
        17543335, --Vanguard_Persecutor
        17543336, --Vanguard_Chanter
        17543337, --Vanguard_Oracle
        17543339, --Vanguard_Partisan
        17543341, --Vanguard_Assassin
        17543343, --Vanguard_Priest
        17543344, --Vanguard_Chanter
        17543346, --Vanguard_Exemplar
        17543347, --Vanguard_Assassin
        17543348, --Vanguard_Persecutor
        17543349, --Vanguard_Skirmisher
        17543350, --Vanguard_Visionary
        17543351, --Vanguard_Oracle
        17543355, --Vanguard_Priest
        17543356, --Vanguard_Chanter
        17543358, --Vanguard_Sentinel
        17543359, --Vanguard_Persecutor
        17543360, --Vanguard_Partisan
        17543364, --Vanguard_Assassin
        17543365, --Vanguard_Liberator
        17543366, --Vanguard_Inciter
        17543367, --Vanguard_Ogresoother
        17543369, --Vanguard_Visionary
        17543370, --Vanguard_Persecutor
        17543371, --Vanguard_Assassin
        17543373, --Vanguard_Priest
        17543374, --Vanguard_Chanter
        17543376, --Vanguard_Salvager
        17543377, --Vanguard_Skirmisher
        17543378, --Vanguard_Skirmisher
        17543379, --Vanguard_Priest
        17543380, --Vanguard_Prelate
        17543381, --Vanguard_Visionary
        17543382, --Vanguard_Sentinel
        17543383, --Vanguard_Sentinel
        17543384, --Vanguard_Exemplar
        17543385, --Vanguard_Ogresoother
        17543387, --Vanguard_Inciter
        17543388, --Vanguard_Liberator
        17543389, --Vanguard_Priest
        17543390, --Vanguard_Salvager
        17543391, --Vanguard_Assassin
        17543394, --Vanguard_Salvager
        17543395, --Vanguard_Inciter
        17543396, --Vanguard_Skirmisher
        17543397, --Vanguard_Priest
        17543398, --Vanguard_Prelate
        17543399, --Vanguard_Prelate
        17543400, --Vanguard_Visionary
        17543401, --Vanguard_Visionary
        17543402, --Vanguard_Skirmisher
        17543403, --Vanguard_Sentinel
        17543404, --Vanguard_Liberator
        17543405, --Vanguard_Liberator
        17543406, --Vanguard_Ogresoother
        17543408, --Vanguard_Assassin
        17543411, --Vanguard_Salvager
        17543412, --Vanguard_Inciter
        17543413, --Vanguard_Persecutor
        17543414, --Vanguard_Chanter
        17543415, --Vanguard_Partisan
        17543417, --Vanguard_Chanter
        17543418, --Vanguard_Assassin
        17543422, --Vanguard_Salvager
        17543423, --Vanguard_Inciter
        17543424, --Vanguard_Oracle
        17543426, --Vanguard_Chanter
        17543427, --Vanguard_Persecutor
        17543428, --Vanguard_Assassin
        17543429, --Vanguard_Salvager
        17543430, --Vanguard_Salvager
        17543431, --Vanguard_Partisan
        17543433, --Vanguard_Chanter
        17543434, --Vanguard_Chanter
        17543435, --Vanguard_Persecutor
        17543436, --Vanguard_Persecutor
        17543437, --Vanguard_Assassin
        17543438, --Vanguard_Assassin
        17543439, --Vanguard_Assassin
        17543440, --Vanguard_Chanter
        17543441, --Vanguard_Persecutor
        17543442, --Vanguard_Oracle
        17543444, --Vanguard_Oracle
        17543447, --Vanguard_Skirmisher
        17543448, --Vanguard_Sentinel
        17543449, --Vanguard_Priest
        17543450, --Vanguard_Prelate
        17543451, --Vanguard_Visionary
        17543452, --Vanguard_Liberator
        17543453, --Vanguard_Exemplar
        17543454, --Vanguard_Inciter
        17543455, --Vanguard_Chanter
        17543456, --Vanguard_Salvager
        17543457, --Vanguard_Persecutor
        17543458, --Vanguard_Assassin
        17543459  --Vanguard_Oracle
    },
    
    [3] = -- NINs only
    {
        17543189, --Vanguard_Assassin
        17543191, --Vanguard_Assassin
        17543208, --Vanguard_Assassin
        17543221, --Vanguard_Assassin
        17543245, --Vanguard_Assassin
        17543249, --Vanguard_Assassin
        17543279, --Vanguard_Assassin
        17543303, --Vanguard_Assassin
        17543309, --Vanguard_Assassin
        17543334, --Vanguard_Assassin
        17543341, --Vanguard_Assassin
        17543347, --Vanguard_Assassin
        17543364, --Vanguard_Assassin
        17543371, --Vanguard_Assassin
        17543391, --Vanguard_Assassin
        17543408, --Vanguard_Assassin
        17543418, --Vanguard_Assassin
        17543428, --Vanguard_Assassin
        17543437, --Vanguard_Assassin
        17543438, --Vanguard_Assassin
        17543439, --Vanguard_Assassin
        17543458  --Vanguard_Assassin
    },
    
    [4] = -- SMN and WHM only, for SMN house
    {
        17543173, --Vanguard_Priest
        17543177, --Vanguard_Priest
        17543199, --Vanguard_Priest
        17543219, --Vanguard_Priest
        17543253, --Vanguard_Priest
        17543262, --Vanguard_Priest
        17543304, --Vanguard_Priest
        17543316, --Vanguard_Priest
        17543321, --Vanguard_Priest
        17543343, --Vanguard_Priest
        17543355, --Vanguard_Priest
        17543373, --Vanguard_Priest
        17543379, --Vanguard_Priest
        17543389, --Vanguard_Priest
        17543397, --Vanguard_Priest
        17543449, --Vanguard_Priest
        17543196, --Vanguard_Oracle
        17543196, --Vanguard_Oracle
        17543216, --Vanguard_Oracle
        17543216, --Vanguard_Oracle
        17543272, --Vanguard_Oracle
        17543272, --Vanguard_Oracle
        17543286, --Vanguard_Oracle
        17543286, --Vanguard_Oracle
        17543299, --Vanguard_Oracle
        17543299, --Vanguard_Oracle
        17543337, --Vanguard_Oracle
        17543337, --Vanguard_Oracle
        17543351, --Vanguard_Oracle
        17543351, --Vanguard_Oracle
        17543424, --Vanguard_Oracle
        17543424, --Vanguard_Oracle
        17543442, --Vanguard_Oracle
        17543442, --Vanguard_Oracle
        17543444, --Vanguard_Oracle
        17543444, --Vanguard_Oracle
        17543459, --Vanguard_Oracle
        17543459  --Vanguard_Oracle
    },
    
    [5] = -- BSTs only
    {
        17543186, --Vanguard_Ogresoother
        17543203, --Vanguard_Ogresoother
        17543235, --Vanguard_Ogresoother
        17543239, --Vanguard_Ogresoother
        17543274, --Vanguard_Ogresoother
        17543310, --Vanguard_Ogresoother
        17543332, --Vanguard_Ogresoother
        17543367, --Vanguard_Ogresoother
        17543385, --Vanguard_Ogresoother
        17543406  --Vanguard_Ogresoother
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{
    
}