-----------------------------------
--
-- Dynamis-Bastok
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_BASTOK
local DMB = 17539072 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17539472 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier
-- drop id for statues = 3200, drop id for mobs = 3201

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] = 
{
    [17539073] = { id =  DMB+1 }, --GuDha_Effigy	Gu'Dha Effigy
    [17539074] = { id =  DMB+2 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539075] = { id =  DMB+3 }, --Vanguard_Militant	Vanguard Militant
    [17539076] = { id =  DMB+4 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539077] = { id =  DMB+5 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539078] = { id =  DMB+6 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539079] = { id =  DMB+7 }, --Vanguard_Protector	Vanguard Protector
    [17539080] = { id =  DMB+8 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539081] = { id =  DMB+9 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539082] = { id =  DMB+10 }, --Vanguard_Defender	Vanguard Defender
    [17539083] = { id =  DMB+11 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539084] = { id =  DMB+12 }, --Vanguard_Constable	Vanguard Constable
    [17539085] = { id =  DMB+13 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539086] = { id =  DMB+14 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539087] = { id =  DMB+15 }, --Vanguard_Kusa	Vanguard Kusa
    [17539088] = { id =  DMB+16 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539089] = { id =  DMB+17 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539090] = { id =  DMB+18 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539091] = { id =  DMB+19 }, --Vanguard_Militant	Vanguard Militant
    [17539092] = { id =  DMB+20 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539093] = { id =  DMB+21 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539094] = { id =  DMB+22 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539095] = { id =  DMB+23 }, --Vanguard_Mason	Vanguard Mason
    [17539096] = { id =  DMB+24 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539097] = { id =  DMB+25 }, --Vanguard_Kusa	Vanguard Kusa
    [17539098] = { id =  DMB+26 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539099] = { id =  DMB+27 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539100] = { id =  DMB+28 }, --Vanguard_Protector	Vanguard Protector
    [17539101] = { id =  DMB+29 }, --Vanguard_Constable	Vanguard Constable
    [17539102] = { id =  DMB+30 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539103] = { id =  DMB+31 }, --Vanguard_Defender	Vanguard Defender
    [17539104] = { id =  DMB+32 }, --Vanguard_Defender	Vanguard Defender
    [17539105] = { id =  DMB+33 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539106] = { id =  DMB+34 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539107] = { id =  DMB+35 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539108] = { id =  DMB+36 }, --Vanguard_Militant	Vanguard Militant
    [17539109] = { id =  DMB+37 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539110] = { id =  DMB+38 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539111] = { id =  DMB+39 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539112] = { id =  DMB+40 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539113] = { id =  DMB+41 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539114] = { id =  DMB+42 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539115] = { id =  DMB+43 }, --Vanguard_Militant	Vanguard Militant
    [17539116] = { id =  DMB+44 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539117] = { id =  DMB+45 }, --Vanguard_Mason	Vanguard Mason
    [17539118] = { id =  DMB+46 }, --Adamantking_Effigy	Adamantking Effigy
    [17539119] = { id =  DMB+47 }, --Adamantking_Effigy	Adamantking Effigy
    [17539120] = { id =  DMB+48 }, --Adamantking_Effigy	Adamantking Effigy
    [17539121] = { id =  DMB+49 }, --Vanguard_Defender	Vanguard Defender
    [17539122] = { id =  DMB+50 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539123] = { id =  DMB+51 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539124] = { id =  DMB+52 }, --Vanguard_Protector	Vanguard Protector
    [17539125] = { id =  DMB+53 }, --Vanguard_Constable	Vanguard Constable
    [17539126] = { id =  DMB+54 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539127] = { id =  DMB+55 }, --Vanguard_Defender	Vanguard Defender
    [17539128] = { id =  DMB+56 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539129] = { id =  DMB+57 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539130] = { id =  DMB+58 }, --Vanguard_Militant	Vanguard Militant
    [17539131] = { id =  DMB+59 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539132] = { id =  DMB+60 }, --Vanguard_Mason	Vanguard Mason
    [17539133] = { id =  DMB+61 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539134] = { id =  DMB+62 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539135] = { id =  DMB+63 }, --Vanguard_Militant	Vanguard Militant
    [17539136] = { id =  DMB+64 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539137] = { id =  DMB+65 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539138] = { id =  DMB+66 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539139] = { id =  DMB+67 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539140] = { id =  DMB+68 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539141] = { id =  DMB+69 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539142] = { id =  DMB+70 }, --Adamantking_Image	Adamantking Image
    [17539143] = { id =  DMB+71 }, --GuNhi_Noondozer	Gu'Nhi Noondozer
    [17539144] = { id =  DMB+72 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539145] = { id =  DMB+73 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539146] = { id =  DMB+74 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539147] = { id =  DMB+75 }, --ZeVho_Fallsplitter	Ze'Vho Fallsplitter
    [17539148] = { id =  DMB+76 }, --Adamantking_Image	Adamantking Image
    [17539149] = { id =  DMB+77 }, --Adamantking_Image	Adamantking Image
    [17539150] = { id =  DMB+78 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539151] = { id =  DMB+79 }, --Vanguard_Kusa	Vanguard Kusa
    [17539152] = { id =  DMB+80 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539153] = { id =  DMB+81 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539154] = { id =  DMB+82 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539155] = { id =  DMB+83 }, --Vanguard_Mason	Vanguard Mason
    [17539156] = { id =  DMB+84 }, --Vanguard_Kusa	Vanguard Kusa
    [17539157] = { id =  DMB+85 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539158] = { id =  DMB+86 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539159] = { id =  DMB+87 }, --Vanguard_Militant	Vanguard Militant
    [17539160] = { id =  DMB+88 }, --Vanguard_Mason	Vanguard Mason
    [17539161] = { id =  DMB+89 }, --Adamantking_Effigy	Adamantking Effigy
    [17539162] = { id =  DMB+90 }, --Adamantking_Effigy	Adamantking Effigy
    [17539163] = { id =  DMB+91 }, --Adamantking_Effigy	Adamantking Effigy
    [17539164] = { id =  DMB+92 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539165] = { id =  DMB+93 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539166] = { id =  DMB+94 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539167] = { id =  DMB+95 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539168] = { id =  DMB+96 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539169] = { id =  DMB+97 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539170] = { id =  DMB+98 }, --Vanguard_Mason	Vanguard Mason
    [17539171] = { id =  DMB+99 }, --Adamantking_Effigy	Adamantking Effigy
    [17539172] = { id =  DMB+100 }, --Adamantking_Effigy	Adamantking Effigy
    [17539173] = { id =  DMB+101 }, --Adamantking_Effigy	Adamantking Effigy
    [17539174] = { id =  DMB+102 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539175] = { id =  DMB+103 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539176] = { id =  DMB+104 }, --Vanguard_Defender	Vanguard Defender
    [17539177] = { id =  DMB+105 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539178] = { id =  DMB+106 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539179] = { id =  DMB+107 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539180] = { id =  DMB+108 }, --Vanguard_Protector	Vanguard Protector
    [17539181] = { id =  DMB+109 }, --Vanguard_Protector	Vanguard Protector
    [17539182] = { id =  DMB+110 }, --Vanguard_Constable	Vanguard Constable
    [17539183] = { id =  DMB+111 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539184] = { id =  DMB+112 }, --Vanguard_Defender	Vanguard Defender
    [17539185] = { id =  DMB+113 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539186] = { id =  DMB+114 }, --Vanguard_Protector	Vanguard Protector
    [17539187] = { id =  DMB+115 }, --Vanguard_Constable	Vanguard Constable
    [17539188] = { id =  DMB+116 }, --GiPha_Manameister	Gi'Pha Manameister
    [17539189] = { id =  DMB+117 }, --Vanguard_Defender	Vanguard Defender
    [17539190] = { id =  DMB+118 }, --KoDho_Cannonball	Ko'Dho Cannonball
    [17539191] = { id =  DMB+119 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539192] = { id =  DMB+120 }, --Vanguard_Militant	Vanguard Militant
    [17539193] = { id =  DMB+121 }, --Vanguard_Constable	Vanguard Constable
    [17539194] = { id =  DMB+122 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539195] = { id =  DMB+123 }, --Vanguard_Protector	Vanguard Protector
    [17539196] = { id =  DMB+124 }, --Vanguard_Defender	Vanguard Defender
    [17539197] = { id =  DMB+125 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539198] = { id =  DMB+126 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539199] = { id =  DMB+127 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539200] = { id =  DMB+128 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539201] = { id =  DMB+129 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539202] = { id =  DMB+130 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539203] = { id =  DMB+131 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539204] = { id =  DMB+132 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539205] = { id =  DMB+133 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539206] = { id =  DMB+134 }, --Vanguard_Mason	Vanguard Mason
    [17539207] = { id =  DMB+135 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539208] = { id =  DMB+136 }, --Vanguard_Kusa	Vanguard Kusa
    [17539209] = { id =  DMB+137 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539210] = { id =  DMB+138 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539211] = { id =  DMB+139 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539212] = { id =  DMB+140 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539213] = { id =  DMB+141 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539214] = { id =  DMB+142 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539215] = { id =  DMB+143 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539216] = { id =  DMB+144 }, --Vanguard_Protector	Vanguard Protector
    [17539217] = { id =  DMB+145 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539218] = { id =  DMB+146 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539219] = { id =  DMB+147 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539220] = { id =  DMB+148 }, --Vanguard_Kusa	Vanguard Kusa
    [17539221] = { id =  DMB+149 }, --Vanguard_Kusa	Vanguard Kusa
    [17539222] = { id =  DMB+150 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539223] = { id =  DMB+151 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539224] = { id =  DMB+152 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539225] = { id =  DMB+153 }, --Vanguard_Protector	Vanguard Protector
    [17539226] = { id =  DMB+154 }, --Vanguard_Defender	Vanguard Defender
    [17539227] = { id =  DMB+155 }, --Adamantking_Effigy	Adamantking Effigy
    [17539228] = { id =  DMB+156 }, --Adamantking_Effigy	Adamantking Effigy
    [17539229] = { id =  DMB+157 }, --Adamantking_Effigy	Adamantking Effigy
    [17539230] = { id =  DMB+158 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539231] = { id =  DMB+159 }, --Vanguard_Kusa	Vanguard Kusa
    [17539232] = { id =  DMB+160 }, --Vanguard_Protector	Vanguard Protector
    [17539233] = { id =  DMB+161 }, --Vanguard_Defender	Vanguard Defender
    [17539234] = { id =  DMB+162 }, --Adamantking_Effigy	Adamantking Effigy
    [17539235] = { id =  DMB+163 }, --Adamantking_Effigy	Adamantking Effigy
    [17539236] = { id =  DMB+164 }, --Adamantking_Effigy	Adamantking Effigy
    [17539237] = { id =  DMB+165 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539238] = { id =  DMB+166 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539239] = { id =  DMB+167 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539240] = { id =  DMB+168 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539241] = { id =  DMB+169 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539242] = { id =  DMB+170 }, --Vanguard_Militant	Vanguard Militant
    [17539243] = { id =  DMB+171 }, --Vanguard_Constable	Vanguard Constable
    [17539244] = { id =  DMB+172 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539245] = { id =  DMB+173 }, --Vanguard_Constable	Vanguard Constable
    [17539246] = { id =  DMB+174 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539247] = { id =  DMB+175 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539248] = { id =  DMB+176 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539249] = { id =  DMB+177 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539250] = { id =  DMB+178 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539251] = { id =  DMB+179 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539252] = { id =  DMB+180 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539253] = { id =  DMB+181 }, --Adamantking_Image	Adamantking Image
    [17539254] = { id =  DMB+182 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539255] = { id =  DMB+183 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539256] = { id =  DMB+184 }, --Vanguard_Defender	Vanguard Defender
    [17539257] = { id =  DMB+185 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539258] = { id =  DMB+186 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539259] = { id =  DMB+187 }, --Vanguard_Militant	Vanguard Militant
    [17539260] = { id =  DMB+188 }, --Vanguard_Protector	Vanguard Protector
    [17539261] = { id =  DMB+189 }, --Vanguard_Militant	Vanguard Militant
    [17539262] = { id =  DMB+190 }, --Vanguard_Militant	Vanguard Militant
    [17539263] = { id =  DMB+191 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539264] = { id =  DMB+192 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539265] = { id =  DMB+193 }, --Vanguard_Protector	Vanguard Protector
    [17539266] = { id =  DMB+194 }, --Adamantking_Effigy	Adamantking Effigy
    [17539267] = { id =  DMB+195 }, --Adamantking_Effigy	Adamantking Effigy
    [17539268] = { id =  DMB+196 }, --Vanguard_Constable	Vanguard Constable
    [17539269] = { id =  DMB+197 }, --Vanguard_Constable	Vanguard Constable
    [17539270] = { id =  DMB+198 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539271] = { id =  DMB+199 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539272] = { id =  DMB+200 }, --Vanguard_Undertaker	Vanguard Undertaker
    [17539273] = { id =  DMB+201 }, --Vanguards_Avatar	Vanguard's Avatar
    [17539274] = { id =  DMB+202 }, --Adamantking_Effigy	Adamantking Effigy
    [17539275] = { id =  DMB+203 }, --Adamantking_Effigy	Adamantking Effigy
    [17539276] = { id =  DMB+204 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539277] = { id =  DMB+205 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539278] = { id =  DMB+206 }, --Vanguard_Defender	Vanguard Defender
    [17539279] = { id =  DMB+207 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539280] = { id =  DMB+208 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539281] = { id =  DMB+209 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539282] = { id =  DMB+210 }, --Vanguard_Kusa	Vanguard Kusa
    [17539283] = { id =  DMB+211 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539284] = { id =  DMB+212 }, --Vanguard_Beasttender	Vanguard Beasttender
    [17539285] = { id =  DMB+213 }, --Vanguards_Scorpion	Vanguard's Scorpion
    [17539286] = { id =  DMB+214 }, --Adamantking_Effigy	Adamantking Effigy
    [17539287] = { id =  DMB+215 }, --Adamantking_Effigy	Adamantking Effigy
    [17539288] = { id =  DMB+216 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539289] = { id =  DMB+217 }, --Vanguard_Kusa	Vanguard Kusa
    [17539290] = { id =  DMB+218 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539291] = { id =  DMB+219 }, --Vanguard_Drakekeeper	Vanguard Drakekeeper
    [17539292] = { id =  DMB+220 }, --Vanguards_Wyvern	Vanguard's Wyvern
    [17539293] = { id =  DMB+221 }, --Adamantking_Effigy	Adamantking Effigy
    [17539294] = { id =  DMB+222 }, --Adamantking_Effigy	Adamantking Effigy
    [17539295] = { id =  DMB+223 }, --Vanguard_Hatamoto	Vanguard Hatamoto
    [17539296] = { id =  DMB+224 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539297] = { id =  DMB+225 }, --Vanguard_Purloiner	Vanguard Purloiner
    [17539298] = { id =  DMB+226 }, --Vanguard_Thaumaturge	Vanguard Thaumaturge
    [17539299] = { id =  DMB+227 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539300] = { id =  DMB+228 }, --Vanguard_Vindicator	Vanguard Vindicator
    [17539301] = { id =  DMB+229 }, --Vanguard_Militant	Vanguard Militant
    [17539302] = { id =  DMB+230 }, --Vanguard_Vigilante	Vanguard Vigilante
    [17539303] = { id =  DMB+231 }, --Vanguard_Protector	Vanguard Protector
    [17539304] = { id =  DMB+232 }, --Vanguard_Constable	Vanguard Constable
    [17539305] = { id =  DMB+233 }, --Vanguard_Minstrel	Vanguard Minstrel
    [17539306] = { id =  DMB+234 }, --Adamantking_Image	Adamantking Image
    [17539307] = { id =  DMB+235 }, --AaNyu_Dismantler	AaNyu_Dismantler
    [17539308] = { id =  DMB+236 }, --BeEbo_Tortoisedriver	BeEbo_Tortoisedriver
    [17539309] = { id =  DMB+237 }, --RaGhos_Avatar	Ra'Gho's Avatar
    [17539310] = { id =  DMB+238 }, --VaZhe_Pummelsong	Va'Zhe Pummelsong
    [17539311] = { id =  DMB+239 }, --BuBho_Truesteel	Bu'Bho Truesteel
    [17539312] = { id =  DMB+240 }, --Arch_GuDha_Effigy	Arch Gu'Dha Effigy
    [17539337] = { id =  DMB+265 }, -- Effigy_Shield
    [17539338] = { id =  DMB+266 }, -- Effigy_Shield
    [17539339] = { id =  DMB+267 }, -- Effigy_Shield
    [17539340] = { id =  DMB+268 }, -- Vanguards_Scorpion
    [17539341] = { id =  DMB+269 }, -- Effigy_Shield
    [17539342] = { id =  DMB+270 }, -- Effigy_Shield
    [17539343] = { id =  DMB+271 }, -- Effigy_Shield
    [17539344] = { id =  DMB+272 }, -- Effigy_Shield
    [17539345] = { id =  DMB+273 }, -- Effigy_Shield
    [17539346] = { id =  DMB+274 }, -- Effigy_Shield
    [17539347] = { id =  DMB+275 }, -- Effigy_Shield
    [17539348] = { id =  DMB+276 }, -- Effigy_Shield
    [17539349] = { id =  DMB+277 }, -- Vanguards_Wyvern
    [17539350] = { id =  DMB+278 }, -- Effigy_Shield
    [17539351] = { id =  DMB+279 }, -- Effigy_Shield
    [17539352] = { id =  DMB+280 }, -- Effigy_Shield
    [17539353] = { id =  DMB+281 }, -- Vanguards_Avatar
    [SMB+0] = { id =  SMB+0 }, -- Adamantking Effigy
    [SMB+1] = { id =  SMB+1 }, -- Adamantking Effigy
    [SMB+2] = { id =  SMB+2 }, -- Adamantking Effigy
    [SMB+3] = { id =  SMB+3 }, -- Adamantking Effigy
    [SMB+4] = { id =  SMB+4 }, -- Adamantking Effigy
    [SMB+5] = { id =  SMB+5 }, -- Adamantking Effigy
    [SMB+6] = { id =  SMB+6 }, -- Adamantking Effigy
    [SMB+7] = { id =  SMB+7 }, -- Adamantking Effigy
    [SMB+8] = { id =  SMB+8 }, -- Adamantking Effigy
    [SMB+9] = { id =  SMB+9 }, -- Adamantking Effigy
    [SMB+10] = { id =  SMB+10 }, -- Adamantking Effigy
    [SMB+11] = { id =  SMB+11 }, -- Adamantking Effigy
    [SMB+12] = { id =  SMB+12 }, -- Adamantking Effigy
    [SMB+13] = { id =  SMB+13 }, -- Adamantking Effigy
    [SMB+14] = { id =  SMB+14 }, -- Adamantking Effigy
    [SMB+15] = { id =  SMB+15 }, -- Adamantking Effigy
    [SMB+16] = { id =  SMB+16 }, -- Adamantking Effigy
    [SMB+17] = { id =  SMB+17 }, -- Adamantking Effigy
    [SMB+18] = { id =  SMB+18 }, -- Adamantking Effigy
    [SMB+19] = { id =  SMB+19 }, -- Adamantking Effigy
    [SMB+20] = { id =  SMB+20 }, -- Adamantking Effigy
    [SMB+21] = { id =  SMB+21 }, -- Adamantking Effigy
    [SMB+22] = { id =  SMB+22 }, -- Adamantking Effigy
    [SMB+23] = { id =  SMB+23 }, -- Adamantking Effigy
    [SMB+24] = { id =  SMB+24 }, -- Adamantking Effigy
    [SMB+25] = { id =  SMB+25 }, -- Adamantking Effigy
    [SMB+26] = { id =  SMB+26 }, -- Adamantking Effigy
    [SMB+27] = { id =  SMB+27 }, -- Adamantking Effigy
    [SMB+28] = { id =  SMB+28 }, -- Adamantking Effigy
    [SMB+29] = { id =  SMB+29 }, -- Adamantking Effigy
    [SMB+30] = { id =  SMB+30 }, -- Adamantking Effigy
    [SMB+31] = { id =  SMB+31 }, -- Adamantking Effigy
    [SMB+32] = { id =  SMB+32 }, -- Adamantking Effigy
    [SMB+33] = { id =  SMB+33 }, -- Adamantking Effigy
    [SMB+34] = { id =  SMB+34 }, -- Adamantking Effigy
    [SMB+35] = { id =  SMB+35 }, -- Adamantking Effigy
    [SMB+36] = { id =  SMB+36 }, -- Adamantking Effigy
    [SMB+37] = { id =  SMB+37 }, -- Adamantking Effigy
    [SMB+38] = { id =  SMB+38 }, -- Adamantking Effigy
    [SMB+39] = { id =  SMB+39 }, -- Adamantking Effigy
    [SMB+40] = { id =  SMB+40 }, -- Adamantking Effigy
    [SMB+41] = { id =  SMB+41 }, -- Adamantking Effigy
    [SMB+42] = { id =  SMB+42 }, -- Adamantking Effigy
    [SMB+43] = { id =  SMB+43 }, -- Adamantking Effigy
    [SMB+44] = { id =  SMB+44 }, -- Adamantking Effigy
    [SMB+45] = { id =  SMB+45 }, -- Adamantking Effigy
    [SMB+46] = { id =  SMB+46 }, -- Adamantking Effigy
    [SMB+47] = { id =  SMB+47 }, -- Adamantking Effigy
    [SMB+48] = { id =  SMB+48 }, -- Adamantking Effigy
    [SMB+49] = { id =  SMB+49 }, -- Adamantking Effigy
    [SMB+50] = { id =  SMB+50 }, -- Adamantking Effigy
    [SMB+51] = { id =  SMB+51 }, -- Adamantking Effigy
    [SMB+52] = { id =  SMB+52 }, -- Adamantking Effigy
    [SMB+53] = { id =  SMB+53 }, -- Adamantking Effigy
    [SMB+54] = { id =  SMB+54 }, -- Adamantking Effigy
    [SMB+55] = { id =  SMB+55 }, -- Adamantking Effigy
    [SMB+56] = { id =  SMB+56 }, -- Adamantking Effigy
    [SMB+57] = { id =  SMB+57 }, -- Adamantking Effigy
    [SMB+58] = { id =  SMB+58 }, -- Adamantking Effigy
    [SMB+59] = { id =  SMB+59 }, -- Adamantking Effigy
    [SMB+60] = { id =  SMB+60 }, -- Adamantking Effigy
    [SMB+61] = { id =  SMB+61 }, -- Adamantking Effigy
    [SMB+62] = { id =  SMB+62 }, -- Adamantking Effigy
    [SMB+63] = { id =  SMB+63 }, -- Adamantking Effigy
    [SMB+64] = { id =  SMB+64 }, -- Adamantking Effigy
    [SMB+65] = { id =  SMB+65 }, -- Adamantking Effigy
    [SMB+66] = { id =  SMB+66 }, -- Adamantking Effigy
    [SMB+67] = { id =  SMB+67 }, -- Adamantking Effigy
    [SMB+68] = { id =  SMB+68 }, -- Adamantking Effigy
    [SMB+69] = { id =  SMB+69 }, -- Adamantking Effigy
    [SMB+70] = { id =  SMB+70 }, -- Adamantking Effigy
    [SMB+71] = { id =  SMB+71 }, -- Adamantking Effigy
    [SMB+72] = { id =  SMB+72 }, -- Adamantking Effigy
    [SMB+73] = { id =  SMB+73 }, -- Adamantking Effigy
    [SMB+74] = { id =  SMB+74 }, -- Adamantking Effigy
    [SMB+75] = { id =  SMB+75 }, -- Adamantking Effigy
    [SMB+76] = { id =  SMB+76 }, -- Adamantking Effigy
    [SMB+77] = { id =  SMB+77 }, -- Adamantking Effigy
    [SMB+78] = { id =  SMB+78 }, -- Adamantking Effigy
    [SMB+79] = { id =  SMB+79 }, -- Adamantking Effigy
    [SMB+80] = { id =  SMB+80 }, -- Adamantking Effigy
    [SMB+81] = { id =  SMB+81 }, -- Adamantking Effigy
    [SMB+82] = { id =  SMB+82 }, -- Adamantking Effigy
    [SMB+83] = { id =  SMB+83 }, -- Adamantking Effigy
    [SMB+84] = { id =  SMB+84 }, -- Adamantking Effigy
    [SMB+85] = { id =  SMB+85 }, -- Adamantking Effigy
    [SMB+86] = { id =  SMB+86 }, -- Adamantking Effigy
    [SMB+87] = { id =  SMB+87 }, -- Adamantking Effigy
    [SMB+88] = { id =  SMB+88 }, -- Adamantking Effigy
    [SMB+89] = { id =  SMB+89 }, -- Adamantking Effigy
    [SMB+90] = { id =  SMB+90 }, -- Adamantking Effigy
    [SMB+91] = { id =  SMB+91 }, -- Adamantking Effigy
    [SMB+92] = { id =  SMB+92 }, -- Adamantking Effigy
    [SMB+93] = { id =  SMB+93 }, -- Adamantking Effigy
    [SMB+94] = { id =  SMB+94 }, -- Adamantking Effigy
    [SMB+95] = { id =  SMB+95 }, -- Adamantking Effigy
    [SMB+96] = { id =  SMB+96 }, -- Adamantking Effigy
    [SMB+97] = { id =  SMB+97 }, -- Adamantking Effigy
    [SMB+98] = { id =  SMB+98 }, -- Adamantking Effigy
    [SMB+99] = { id =  SMB+99 }, -- Adamantking Effigy
    [SMB+100] = { id =  SMB+100 }, -- Adamantking Effigy
    [SMB+101] = { id =  SMB+101 }, -- Adamantking Effigy
    [SMB+102] = { id =  SMB+102 }, -- Adamantking Effigy
    [SMB+103] = { id =  SMB+103 }, -- Adamantking Effigy
    [SMB+104] = { id =  SMB+104 }, -- Adamantking Effigy
    [SMB+105] = { id =  SMB+105 }, -- Adamantking Effigy
    [SMB+106] = { id =  SMB+106 }, -- Adamantking Effigy
    [SMB+107] = { id =  SMB+107 }, -- Adamantking Effigy
    [SMB+108] = { id =  SMB+108 }, -- Adamantking Effigy
    [SMB+109] = { id =  SMB+109 }, -- Adamantking Effigy
    [SMB+110] = { id =  SMB+110 }, -- Adamantking Effigy
    [SMB+111] = { id =  SMB+111 }, -- Adamantking Effigy
    [SMB+112] = { id =  SMB+112 }, -- Adamantking Effigy
    [SMB+113] = { id =  SMB+113 }, -- Adamantking Effigy
    [SMB+114] = { id =  SMB+114 }, -- Adamantking Effigy
    [SMB+115] = { id =  SMB+115 }, -- Adamantking Effigy
    [SMB+116] = { id =  SMB+116 }, -- Adamantking Effigy
    [SMB+117] = { id =  SMB+117 }, -- Adamantking Effigy
    [SMB+118] = { id =  SMB+118 }, -- Adamantking Effigy
    [SMB+119] = { id =  SMB+119 }, -- Adamantking Effigy
    [SMB+120] = { id =  SMB+120 }, -- Adamantking Effigy
    [SMB+121] = { id =  SMB+121 }, -- Adamantking Effigy
    [SMB+122] = { id =  SMB+122 }, -- Adamantking Effigy
    [SMB+123] = { id =  SMB+123 }, -- Adamantking Effigy
    [SMB+124] = { id =  SMB+124 }, -- Adamantking Effigy
    [SMB+125] = { id =  SMB+125 }, -- Adamantking Effigy
    [SMB+126] = { id =  SMB+126 }, -- Adamantking Effigy
    [SMB+127] = { id =  SMB+127 }, -- Adamantking Effigy
    [SMB+128] = { id =  SMB+128 }, -- Adamantking Effigy
    [SMB+129] = { id =  SMB+129 }, -- Adamantking Effigy
    [SMB+130] = { id =  SMB+130 }, -- Adamantking Effigy
    [SMB+131] = { id =  SMB+131 }, -- Adamantking Effigy
    [SMB+132] = { id =  SMB+132 }, -- Adamantking Effigy
    [SMB+133] = { id =  SMB+133 }, -- Adamantking Effigy
    [SMB+134] = { id =  SMB+134 }, -- Adamantking Effigy
    [SMB+135] = { id =  SMB+135 }, -- Adamantking Effigy
    [SMB+136] = { id =  SMB+136 }, -- Adamantking Effigy
    [SMB+137] = { id =  SMB+137 }, -- Adamantking Effigy
    [SMB+138] = { id =  SMB+138 }, -- Adamantking Effigy
    [SMB+139] = { id =  SMB+139 }, -- Adamantking Effigy
    [SMB+140] = { id =  SMB+140 }, -- Adamantking Effigy
    [SMB+141] = { id =  SMB+141 }, -- Adamantking Effigy
    [SMB+142] = { id =  SMB+142 }, -- Adamantking Effigy
    [SMB+143] = { id =  SMB+143 }, -- Adamantking Effigy
    [SMB+144] = { id =  SMB+144 }, -- Adamantking Effigy
    [SMB+145] = { id =  SMB+145 }, -- Adamantking Effigy
    [SMB+146] = { id =  SMB+146 }, -- Adamantking Effigy
    [SMB+147] = { id =  SMB+147 }, -- Adamantking Effigy
    [SMB+148] = { id =  SMB+148 }, -- Adamantking Effigy
    [SMB+149] = { id =  SMB+149 }, -- Adamantking Effigy
    [SMB+150] = { id =  SMB+150 }, -- Adamantking Effigy
    [SMB+151] = { id =  SMB+151 }, -- Adamantking Effigy
    [SMB+152] = { id =  SMB+152 }, -- Adamantking Effigy
    [SMB+153] = { id =  SMB+153 }, -- Adamantking Effigy
    [SMB+154] = { id =  SMB+154 }, -- Adamantking Effigy
    [SMB+155] = { id =  SMB+155 }, -- Adamantking Effigy
    [SMB+156] = { id =  SMB+156 }, -- Adamantking Effigy
    [SMB+157] = { id =  SMB+157 }, -- Adamantking Effigy
    [SMB+158] = { id =  SMB+158 }, -- Adamantking Effigy
    [SMB+159] = { id =  SMB+159 }, -- Adamantking Effigy
    [SMB+160] = { id =  SMB+160 }, -- Adamantking Effigy
    [SMB+161] = { id =  SMB+161 }, -- Adamantking Effigy
    [SMB+162] = { id =  SMB+162 }, -- Adamantking Effigy
    [SMB+163] = { id =  SMB+163 }, -- Adamantking Effigy
    [SMB+164] = { id =  SMB+164 }, -- Adamantking Effigy
    [SMB+165] = { id =  SMB+165 }, -- Adamantking Effigy
    [SMB+166] = { id =  SMB+166 }, -- Adamantking Effigy
    [SMB+167] = { id =  SMB+167 }, -- Adamantking Effigy
    [SMB+168] = { id =  SMB+168 }, -- Adamantking Effigy
    [SMB+169] = { id =  SMB+169 }, -- Adamantking Effigy
    [SMB+170] = { id =  SMB+170 }, -- Adamantking Effigy
    [SMB+171] = { id =  SMB+171 }, -- Adamantking Effigy
    [SMB+172] = { id =  SMB+172 }, -- Adamantking Effigy
    [SMB+173] = { id =  SMB+173 }, -- Adamantking Effigy
    [SMB+174] = { id =  SMB+174 }, -- Adamantking Effigy
    [SMB+175] = { id =  SMB+175 }, -- Adamantking Effigy
    [SMB+176] = { id =  SMB+176 }, -- Adamantking Effigy
    [SMB+177] = { id =  SMB+177 }, -- Adamantking Effigy
    [SMB+178] = { id =  SMB+178 }, -- Adamantking Effigy
    [SMB+179] = { id =  SMB+179 }, -- Adamantking Effigy
    [SMB+180] = { id =  SMB+180 }, -- Adamantking Effigy
    [SMB+181] = { id =  SMB+181 }, -- Adamantking Effigy
    [SMB+182] = { id =  SMB+182 }, -- Adamantking Effigy
    [SMB+183] = { id =  SMB+183 }, -- Adamantking Effigy
    [SMB+184] = { id =  SMB+184 }, -- Adamantking Effigy
    [SMB+185] = { id =  SMB+185 }, -- Adamantking Effigy
    [SMB+186] = { id =  SMB+186 }, -- Adamantking Effigy
    [SMB+187] = { id =  SMB+187 }, -- Adamantking Effigy
    [SMB+188] = { id =  SMB+188 }, -- Adamantking Effigy
    [SMB+189] = { id =  SMB+189 }, -- Adamantking Effigy
    [SMB+190] = { id =  SMB+190 }, -- Adamantking Effigy
    [SMB+191] = { id =  SMB+191 }, -- Adamantking Effigy
    [SMB+192] = { id =  SMB+192 }, -- Adamantking Effigy
    [SMB+193] = { id =  SMB+193 }, -- Adamantking Effigy
    [SMB+194] = { id =  SMB+194 }, -- Adamantking Effigy
    [SMB+195] = { id =  SMB+195 }, -- Adamantking Effigy
    [SMB+196] = { id =  SMB+196 }, -- Adamantking Effigy
    [SMB+197] = { id =  SMB+197 }, -- Adamantking Effigy
    [SMB+198] = { id =  SMB+198 }, -- Adamantking Effigy
    [SMB+199] = { id =  SMB+199 }, -- Adamantking Effigy
    [SMB+200] = { id =  SMB+200 }, -- Adamantking Effigy
    [SMB+201] = { id =  SMB+201 }, -- Adamantking Effigy
    [SMB+202] = { id =  SMB+202 }, -- Adamantking Effigy
    [SMB+203] = { id =  SMB+203 }, -- Adamantking Effigy
    [SMB+204] = { id =  SMB+204 }, -- Adamantking Effigy
    [SMB+205] = { id =  SMB+205 }, -- Adamantking Effigy
    [SMB+206] = { id =  SMB+206 }, -- Adamantking Effigy
    [SMB+207] = { id =  SMB+207 }, -- Adamantking Effigy
    [SMB+208] = { id =  SMB+208 }, -- Adamantking Effigy
    [SMB+209] = { id =  SMB+209 }, -- Adamantking Effigy
    [SMB+210] = { id =  SMB+210 }, -- Adamantking Effigy
    [SMB+211] = { id =  SMB+211 }, -- Adamantking Effigy
    [SMB+212] = { id =  SMB+212 }, -- Adamantking Effigy
    [SMB+213] = { id =  SMB+213 }, -- Adamantking Effigy
    [SMB+214] = { id =  SMB+214 }, -- Adamantking Effigy
    [SMB+215] = { id =  SMB+215 }, -- Adamantking Effigy
    [SMB+216] = { id =  SMB+216 }, -- Adamantking Effigy
    [SMB+217] = { id =  SMB+217 }, -- Adamantking Effigy
    [SMB+218] = { id =  SMB+218 }, -- Adamantking Effigy
    [SMB+219] = { id =  SMB+219 }, -- Adamantking Effigy
    [SMB+220] = { id =  SMB+220 }, -- Adamantking Effigy
    [SMB+221] = { id =  SMB+221 }, -- Adamantking Effigy
    [SMB+222] = { id =  SMB+222 }, -- Adamantking Effigy
    [SMB+223] = { id =  SMB+223 }, -- Adamantking Effigy
    [SMB+224] = { id =  SMB+224 }, -- Adamantking Effigy
    [SMB+225] = { id =  SMB+225 }, -- Adamantking Effigy
    [SMB+226] = { id =  SMB+226 }, -- Adamantking Effigy
    [SMB+227] = { id =  SMB+227 }, -- Adamantking Effigy
    [SMB+228] = { id =  SMB+228 }, -- Adamantking Effigy
    [SMB+229] = { id =  SMB+229 }, -- Adamantking Effigy
    [SMB+230] = { id =  SMB+230 }, -- Adamantking Effigy
    [SMB+231] = { id =  SMB+231 }, -- Adamantking Effigy
    [SMB+232] = { id =  SMB+232 }, -- Adamantking Effigy
    [SMB+233] = { id =  SMB+233 }, -- Adamantking Effigy
    [SMB+234] = { id =  SMB+234 }, -- Adamantking Effigy
    [SMB+235] = { id =  SMB+235 }, -- Adamantking Effigy
    [SMB+236] = { id =  SMB+236 }, -- Adamantking Effigy
    [SMB+237] = { id =  SMB+237 }, -- Adamantking Effigy
    [SMB+238] = { id =  SMB+238 }, -- Adamantking Effigy
    [SMB+239] = { id =  SMB+239 }, -- Adamantking Effigy
    [SMB+240] = { id =  SMB+240 }, -- Adamantking Effigy
    [SMB+241] = { id =  SMB+241 }, -- Adamantking Effigy
    [SMB+242] = { id =  SMB+242 }, -- Adamantking Effigy
    [SMB+243] = { id =  SMB+243 }, -- Adamantking Effigy
    [SMB+244] = { id =  SMB+244 }, -- Adamantking Effigy
    [SMB+245] = { id =  SMB+245 }, -- Adamantking Effigy
    [SMB+246] = { id =  SMB+246 }, -- Adamantking Effigy
    [SMB+247] = { id =  SMB+247 }, -- Adamantking Effigy
    [SMB+248] = { id =  SMB+248 }, -- Adamantking Effigy
    [SMB+249] = { id =  SMB+249 }, -- Adamantking Effigy
    [SMB+250] = { id =  SMB+250 }, -- Adamantking Effigy
    [SMB+251] = { id =  SMB+251 }, -- Adamantking Effigy
    [SMB+252] = { id =  SMB+252 }, -- Adamantking Effigy
    [SMB+253] = { id =  SMB+253 }, -- Adamantking Effigy
    [SMB+254] = { id =  SMB+254 }, -- Adamantking Effigy
    [SMB+255] = { id =  SMB+255 }, -- Adamantking Effigy
    [SMB+256] = { id =  SMB+256 }, -- Adamantking Effigy
    [SMB+257] = { id =  SMB+257 }, -- Adamantking Effigy
    [SMB+258] = { id =  SMB+258 }, -- Adamantking Effigy
    [SMB+259] = { id =  SMB+259 }, -- Adamantking Effigy
    [SMB+260] = { id =  SMB+260 }, -- Adamantking Effigy
    [SMB+261] = { id =  SMB+261 }, -- Adamantking Effigy
    [SMB+262] = { id =  SMB+262 }, -- Adamantking Effigy
    [SMB+263] = { id =  SMB+263 }, -- Adamantking Effigy
    [SMB+264] = { id =  SMB+264 }, -- Adamantking Effigy
    [SMB+265] = { id =  SMB+265 }, -- Adamantking Effigy
    [SMB+266] = { id =  SMB+266 }, -- Adamantking Effigy
    [SMB+267] = { id =  SMB+267 }, -- Adamantking Effigy
    [SMB+268] = { id =  SMB+268 }, -- Adamantking Effigy
    [SMB+269] = { id =  SMB+269 }, -- Adamantking Effigy
    [SMB+270] = { id =  SMB+270 }, -- Adamantking Effigy
    [SMB+271] = { id =  SMB+271 }, -- Adamantking Effigy
    [SMB+272] = { id =  SMB+272 }, -- Adamantking Effigy
    [SMB+273] = { id =  SMB+273 }, -- Adamantking Effigy
    [SMB+274] = { id =  SMB+274 }, -- Adamantking Effigy
    [SMB+275] = { id =  SMB+275 }, -- Adamantking Effigy
    [SMB+276] = { id =  SMB+276 }, -- Adamantking Effigy
    [SMB+277] = { id =  SMB+277 }, -- Adamantking Effigy
    [SMB+278] = { id =  SMB+278 }, -- Adamantking Effigy
    [SMB+279] = { id =  SMB+279 }, -- Adamantking Effigy
    [SMB+280] = { id =  SMB+280 }, -- Adamantking Effigy
    [SMB+281] = { id =  SMB+281 }, -- Adamantking Effigy
    [SMB+282] = { id =  SMB+282 }, -- Adamantking Effigy
    [SMB+283] = { id =  SMB+283 }, -- Adamantking Effigy
    [SMB+284] = { id =  SMB+284 }, -- Adamantking Effigy
    [SMB+285] = { id =  SMB+285 }, -- Adamantking Effigy
    [SMB+286] = { id =  SMB+286 }, -- Adamantking Effigy
    [SMB+287] = { id =  SMB+287 }, -- Adamantking Effigy
    [SMB+288] = { id =  SMB+288 }, -- Adamantking Effigy
    [SMB+289] = { id =  SMB+289 }, -- Adamantking Effigy
    [SMB+290] = { id =  SMB+290 }, -- Adamantking Effigy
    [SMB+291] = { id =  SMB+291 }, -- Adamantking Effigy
    [SMB+292] = { id =  SMB+292 }, -- Adamantking Effigy
    [SMB+293] = { id =  SMB+293 }, -- Adamantking Effigy
    [SMB+294] = { id =  SMB+294 }, -- Adamantking Effigy
    [SMB+295] = { id =  SMB+295 }, -- Adamantking Effigy
    [SMB+296] = { id =  SMB+296 }, -- Adamantking Effigy
    [SMB+297] = { id =  SMB+297 }, -- Adamantking Effigy
    [SMB+298] = { id =  SMB+298 }, -- Adamantking Effigy
    [SMB+299] = { id =  SMB+299 }, -- Adamantking Effigy
    [SMB+300] = { id =  SMB+300 }, -- Adamantking Effigy
    [SMB+301] = { id =  SMB+301 }, -- Adamantking Effigy
    [SMB+302] = { id =  SMB+302 }, -- Adamantking Effigy
    [SMB+303] = { id =  SMB+303 }, -- Adamantking Effigy
    [SMB+304] = { id =  SMB+304 }, -- Adamantking Effigy
    [SMB+305] = { id =  SMB+305 }, -- Adamantking Effigy
    [SMB+306] = { id =  SMB+306 }, -- Adamantking Effigy
    [SMB+307] = { id =  SMB+307 }, -- Adamantking Effigy
    [SMB+308] = { id =  SMB+308 }, -- Adamantking Effigy
    [SMB+309] = { id =  SMB+309 }, -- Adamantking Effigy
    [SMB+310] = { id =  SMB+310 }, -- Adamantking Effigy
    [SMB+311] = { id =  SMB+311 }, -- Adamantking Effigy
    [SMB+312] = { id =  SMB+312 }, -- Adamantking Effigy
    [SMB+313] = { id =  SMB+313 }, -- Adamantking Effigy
    [SMB+314] = { id =  SMB+314 }, -- Adamantking Effigy
    [SMB+315] = { id =  SMB+315 }, -- Adamantking Effigy
    [SMB+316] = { id =  SMB+316 }, -- Adamantking Effigy
    [SMB+317] = { id =  SMB+317 }, -- Adamantking Effigy
    [SMB+318] = { id =  SMB+318 }, -- Adamantking Effigy
    [SMB+319] = { id =  SMB+319 }, -- Adamantking Effigy
    [SMB+320] = { id =  SMB+320 }, -- Adamantking Effigy
    [SMB+321] = { id =  SMB+321 }, -- Adamantking Effigy
    [SMB+322] = { id =  SMB+322 }, -- Adamantking Effigy
    [SMB+323] = { id =  SMB+323 }, -- Adamantking Effigy
    [SMB+324] = { id =  SMB+324 }, -- Adamantking Effigy
    [SMB+325] = { id =  SMB+325 }, -- Adamantking Effigy
    [SMB+326] = { id =  SMB+326 }, -- Adamantking Effigy
    [SMB+327] = { id =  SMB+327 }, -- Adamantking Effigy
    [SMB+328] = { id =  SMB+328 }, -- Adamantking Effigy
    [SMB+329] = { id =  SMB+329 }, -- Adamantking Effigy
    [SMB+330] = { id =  SMB+330 }, -- Adamantking Effigy
    [SMB+331] = { id =  SMB+331 }, -- Adamantking Effigy
    [SMB+332] = { id =  SMB+332 }, -- Adamantking Effigy
    [SMB+333] = { id =  SMB+333 }, -- Adamantking Effigy
    [SMB+334] = { id =  SMB+334 }, -- Adamantking Effigy
    [SMB+335] = { id =  SMB+335 }, -- Adamantking Effigy
    [SMB+336] = { id =  SMB+336 }, -- Adamantking Effigy
    [SMB+337] = { id =  SMB+337 }, -- Adamantking Effigy
    [SMB+338] = { id =  SMB+338 }, -- Adamantking Effigy
    [SMB+339] = { id =  SMB+339 }, -- Adamantking Effigy
    [SMB+340] = { id =  SMB+340 }, -- Adamantking Effigy
    [SMB+341] = { id =  SMB+341 }, -- Adamantking Effigy
    [SMB+342] = { id =  SMB+342 }, -- Adamantking Effigy
    [SMB+343] = { id =  SMB+343 }, -- Adamantking Effigy
    [SMB+344] = { id =  SMB+344 }, -- Adamantking Effigy
    [SMB+345] = { id =  SMB+345 }, -- Adamantking Effigy
    [SMB+346] = { id =  SMB+346 }, -- Adamantking Effigy
    [SMB+347] = { id =  SMB+347 }, -- Adamantking Effigy
    [SMB+348] = { id =  SMB+348 }, -- Adamantking Effigy
    [SMB+349] = { id =  SMB+349 }, -- Adamantking Effigy
    [SMB+350] = { id =  SMB+350 }, -- Adamantking Effigy
    [SMB+351] = { id =  SMB+351 }, -- Adamantking Effigy
    [SMB+352] = { id =  SMB+352 }, -- Adamantking Effigy
    [SMB+353] = { id =  SMB+353 }, -- Adamantking Effigy
    [SMB+354] = { id =  SMB+354 }, -- Adamantking Effigy
    [SMB+355] = { id =  SMB+355 }, -- Adamantking Effigy
    [SMB+356] = { id =  SMB+356 }, -- Adamantking Effigy
    [SMB+357] = { id =  SMB+357 }, -- Adamantking Effigy
    [SMB+358] = { id =  SMB+358 }, -- Adamantking Effigy
    [SMB+359] = { id =  SMB+359 }, -- Adamantking Effigy
    [SMB+360] = { id =  SMB+360 }, -- Adamantking Effigy
    [SMB+361] = { id =  SMB+361 }, -- Adamantking Effigy
    [SMB+362] = { id =  SMB+362 }, -- Adamantking Effigy
    [SMB+363] = { id =  SMB+363 }, -- Adamantking Effigy
    [SMB+364] = { id =  SMB+364 }, -- Adamantking Effigy
    [SMB+365] = { id =  SMB+365 }, -- Adamantking Effigy
    [SMB+366] = { id =  SMB+366 }, -- Adamantking Effigy
    [SMB+367] = { id =  SMB+367 }, -- Adamantking Effigy
    [SMB+368] = { id =  SMB+368 }, -- Adamantking Effigy
    [SMB+369] = { id =  SMB+369 }, -- Adamantking Effigy
    [SMB+370] = { id =  SMB+370 }, -- Adamantking Effigy
    [SMB+371] = { id =  SMB+371 }, -- Adamantking Effigy
    [SMB+372] = { id =  SMB+372 }, -- Adamantking Effigy
    [SMB+373] = { id =  SMB+373 }, -- Adamantking Effigy
    [SMB+374] = { id =  SMB+374 }, -- Adamantking Effigy
    [SMB+375] = { id =  SMB+375 }, -- Adamantking Effigy
    [SMB+376] = { id =  SMB+376 }, -- Adamantking Effigy
    [SMB+377] = { id =  SMB+377 }, -- Adamantking Effigy
    [SMB+378] = { id =  SMB+378 }, -- Adamantking Effigy
    [SMB+379] = { id =  SMB+379 }, -- Adamantking Effigy
    [SMB+380] = { id =  SMB+380 }, -- Adamantking Effigy
    [SMB+381] = { id =  SMB+381 }, -- Adamantking Effigy
    [SMB+382] = { id =  SMB+382 }, -- Adamantking Effigy
    [SMB+383] = { id =  SMB+383 }, -- Adamantking Effigy
    [SMB+384] = { id =  SMB+384 }, -- Adamantking Effigy
    [SMB+385] = { id =  SMB+385 }, -- Adamantking Effigy
    [SMB+386] = { id =  SMB+386 }, -- Adamantking Effigy
    [SMB+387] = { id =  SMB+387 }, -- Adamantking Effigy
    [SMB+388] = { id =  SMB+388 }, -- Adamantking Effigy
    [SMB+389] = { id =  SMB+389 }, -- Adamantking Effigy
    [SMB+390] = { id =  SMB+390 }, -- Adamantking Effigy
    [SMB+391] = { id =  SMB+391 }, -- Adamantking Effigy
    [SMB+392] = { id =  SMB+392 }, -- Adamantking Effigy
    [SMB+393] = { id =  SMB+393 }, -- Adamantking Effigy
    [SMB+394] = { id =  SMB+394 }, -- Adamantking Effigy
    [SMB+395] = { id =  SMB+395 }, -- Adamantking Effigy
    [SMB+396] = { id =  SMB+396 }, -- Adamantking Effigy
    [SMB+397] = { id =  SMB+397 }, -- Adamantking Effigy
    [SMB+398] = { id =  SMB+398 }, -- Adamantking Effigy
    [SMB+399] = { id =  SMB+399 }, -- Adamantking Effigy
    [SMB+400] = { id =  SMB+400 }, -- Adamantking Effigy
    [SMB+401] = { id =  SMB+401 }, -- Adamantking Effigy
    [SMB+402] = { id =  SMB+402 }, -- Adamantking Effigy
    [SMB+403] = { id =  SMB+403 }, -- Adamantking Effigy
    [SMB+404] = { id =  SMB+404 }, -- Adamantking Effigy
    [SMB+405] = { id =  SMB+405 }, -- Adamantking Effigy
    [SMB+406] = { id =  SMB+406 }, -- Adamantking Effigy
    [SMB+407] = { id =  SMB+407 }, -- Adamantking Effigy
    [SMB+408] = { id =  SMB+408 }, -- Adamantking Effigy
    [SMB+409] = { id =  SMB+409 }, -- Adamantking Effigy
    [SMB+410] = { id =  SMB+410 }, -- Adamantking Effigy
    [SMB+411] = { id =  SMB+411 }, -- Adamantking Effigy
    [SMB+412] = { id =  SMB+412 }, -- Adamantking Effigy
    [SMB+413] = { id =  SMB+413 }, -- Adamantking Effigy
    [SMB+414] = { id =  SMB+414 }, -- Adamantking Effigy
    [SMB+415] = { id =  SMB+415 }, -- Adamantking Effigy
    [SMB+416] = { id =  SMB+416 }, -- Adamantking Effigy
    [SMB+417] = { id =  SMB+417 }, -- Adamantking Effigy
    [SMB+418] = { id =  SMB+418 }, -- Adamantking Effigy
    [SMB+419] = { id =  SMB+419 }, -- Adamantking Effigy
    [SMB+420] = { id =  SMB+420 }, -- Adamantking Effigy
    [SMB+421] = { id =  SMB+421 }, -- Adamantking Effigy
    [SMB+422] = { id =  SMB+422 }, -- Adamantking Effigy
    [SMB+423] = { id =  SMB+423 }, -- Adamantking Effigy
    [SMB+424] = { id =  SMB+424 }, -- Adamantking Effigy
    [SMB+425] = { id =  SMB+425 }, -- Adamantking Effigy
    [SMB+426] = { id =  SMB+426 }, -- Adamantking Effigy
    [SMB+427] = { id =  SMB+427 }, -- Adamantking Effigy
    [SMB+428] = { id =  SMB+428 }, -- Adamantking Effigy
    [SMB+429] = { id =  SMB+429 }, -- Adamantking Effigy
    [SMB+430] = { id =  SMB+430 }, -- Adamantking Effigy
    [SMB+431] = { id =  SMB+431 }, -- Adamantking Effigy
    [SMB+432] = { id =  SMB+432 }, -- Adamantking Effigy
    [SMB+433] = { id =  SMB+433 }, -- Adamantking Effigy
    [SMB+434] = { id =  SMB+434 }, -- Adamantking Effigy
    [SMB+435] = { id =  SMB+435 }, -- Adamantking Effigy
    [SMB+436] = { id =  SMB+436 }, -- Adamantking Effigy
    [SMB+437] = { id =  SMB+437 }, -- Adamantking Effigy
    [SMB+438] = { id =  SMB+438 }, -- Adamantking Effigy
    [SMB+439] = { id =  SMB+439 }, -- Adamantking Effigy
    [SMB+440] = { id =  SMB+440 }, -- Adamantking Effigy
    [SMB+441] = { id =  SMB+441 }, -- Adamantking Effigy
    [SMB+442] = { id =  SMB+442 }, -- Adamantking Effigy
    [SMB+443] = { id =  SMB+443 }, -- Adamantking Effigy
    [SMB+444] = { id =  SMB+444 }, -- Adamantking Effigy
    [SMB+445] = { id =  SMB+445 }, -- Adamantking Effigy
    [SMB+446] = { id =  SMB+446 }, -- Adamantking Effigy
    [SMB+447] = { id =  SMB+447 }, -- Adamantking Effigy
    [SMB+448] = { id =  SMB+448 }, -- Adamantking Effigy
    [SMB+449] = { id =  SMB+449 }, -- Adamantking Effigy
    [SMB+450] = { id =  SMB+450 }, -- Adamantking Effigy
    [SMB+451] = { id =  SMB+451 }, -- Adamantking Effigy
    [SMB+452] = { id =  SMB+452 }, -- Adamantking Effigy
    [SMB+453] = { id =  SMB+453 }, -- Adamantking Effigy
    [SMB+454] = { id =  SMB+454 }, -- Adamantking Effigy
    [SMB+455] = { id =  SMB+455 }, -- Adamantking Effigy
    [SMB+456] = { id =  SMB+456 }, -- Adamantking Effigy
    [SMB+457] = { id =  SMB+457 }, -- Adamantking Effigy
    [SMB+458] = { id =  SMB+458 }, -- Adamantking Effigy
    [SMB+459] = { id =  SMB+459 }, -- Adamantking Effigy
    [SMB+460] = { id =  SMB+460 }, -- Adamantking Effigy
    [SMB+461] = { id =  SMB+461 }, -- Adamantking Effigy
    [SMB+462] = { id =  SMB+462 }, -- Adamantking Effigy
    [SMB+463] = { id =  SMB+463 }, -- Adamantking Effigy
    [SMB+464] = { id =  SMB+464 }, -- Adamantking Effigy
    [SMB+465] = { id =  SMB+465 }, -- Adamantking Effigy
    [SMB+466] = { id =  SMB+466 }, -- Adamantking Effigy
    [SMB+467] = { id =  SMB+467 }, -- Adamantking Effigy
    [SMB+468] = { id =  SMB+468 }, -- Adamantking Effigy
    [SMB+469] = { id =  SMB+469 }, -- Adamantking Effigy
    [SMB+470] = { id =  SMB+470 }, -- Adamantking Effigy
    [SMB+471] = { id =  SMB+471 }, -- Adamantking Effigy
    [SMB+472] = { id =  SMB+472 }, -- Adamantking Effigy
    [SMB+473] = { id =  SMB+473 }, -- Adamantking Effigy
    [SMB+474] = { id =  SMB+474 }, -- Adamantking Effigy
    [SMB+475] = { id =  SMB+475 }, -- Adamantking Effigy
    [SMB+476] = { id =  SMB+476 }, -- Adamantking Effigy
    [SMB+477] = { id =  SMB+477 }, -- Adamantking Effigy
    [SMB+478] = { id =  SMB+478 }, -- Adamantking Effigy
    [SMB+479] = { id =  SMB+479 }, -- Adamantking Effigy
    [SMB+480] = { id =  SMB+480 }, -- Adamantking Effigy
    [SMB+481] = { id =  SMB+481 }, -- Adamantking Effigy
    [SMB+482] = { id =  SMB+482 }, -- Adamantking Effigy
    [SMB+483] = { id =  SMB+483 }, -- Adamantking Effigy
    [SMB+484] = { id =  SMB+484 }, -- Adamantking Effigy
    [SMB+485] = { id =  SMB+485 }, -- Adamantking Effigy
    [SMB+486] = { id =  SMB+486 }, -- Adamantking Effigy
    [SMB+487] = { id =  SMB+487 }, -- Adamantking Effigy
    [SMB+488] = { id =  SMB+488 }, -- Adamantking Effigy
    [SMB+489] = { id =  SMB+489 }, -- Adamantking Effigy
    [SMB+490] = { id =  SMB+490 }, -- Adamantking Effigy
    [SMB+491] = { id =  SMB+491 }, -- Adamantking Effigy
    [SMB+492] = { id =  SMB+492 }, -- Adamantking Effigy
    [SMB+493] = { id =  SMB+493 }, -- Adamantking Effigy
    [SMB+494] = { id =  SMB+494 }, -- Adamantking Effigy
    [SMB+495] = { id =  SMB+495 }, -- Adamantking Effigy
    [SMB+496] = { id =  SMB+496 }, -- Adamantking Effigy
    [SMB+497] = { id =  SMB+497 }, -- Adamantking Effigy
    [SMB+498] = { id =  SMB+498 }, -- Adamantking Effigy
    [SMB+499] = { id =  SMB+499 }, -- Adamantking Effigy
    [SMB+500] = { id =  SMB+500 }, -- Adamantking Effigy
    [SMB+501] = { id =  SMB+501 }, -- Adamantking Effigy
    [SMB+502] = { id =  SMB+502 }, -- Adamantking Effigy
    [SMB+503] = { id =  SMB+503 }, -- Adamantking Effigy
    [SMB+504] = { id =  SMB+504 }, -- Adamantking Effigy
    [SMB+505] = { id =  SMB+505 }, -- Adamantking Effigy
    [SMB+506] = { id =  SMB+506 }, -- Adamantking Effigy
    [SMB+507] = { id =  SMB+507 }, -- Adamantking Effigy
    [SMB+508] = { id =  SMB+508 }, -- Adamantking Effigy
    [SMB+509] = { id =  SMB+509 }, -- Adamantking Effigy
    [SMB+510] = { id =  SMB+510 }, -- Adamantking Effigy
    [SMB+511] = { id =  SMB+511 }, -- Adamantking Effigy
    [SMB+512] = { id =  SMB+512 }, -- Adamantking Effigy
    [SMB+513] = { id =  SMB+513 }, -- Adamantking Effigy
    [SMB+514] = { id =  SMB+514 }, -- Adamantking Effigy
    [SMB+515] = { id =  SMB+515 }, -- Adamantking Effigy
    [SMB+516] = { id =  SMB+516 }, -- Adamantking Effigy
    [SMB+517] = { id =  SMB+517 }, -- Adamantking Effigy
    [SMB+518] = { id =  SMB+518 }, -- Adamantking Effigy
    [SMB+519] = { id =  SMB+519 }, -- Adamantking Effigy
    [SMB+520] = { id =  SMB+520 }, -- Adamantking Effigy
    [SMB+521] = { id =  SMB+521 }, -- Adamantking Effigy
    [SMB+522] = { id =  SMB+522 }, -- Adamantking Effigy
    [SMB+523] = { id =  SMB+523 }, -- Adamantking Effigy
    [SMB+524] = { id =  SMB+524 }, -- Adamantking Effigy
    [SMB+525] = { id =  SMB+525 }, -- Adamantking Effigy
    [SMB+526] = { id =  SMB+526 }, -- Adamantking Effigy
    [SMB+527] = { id =  SMB+527 }, -- Adamantking Effigy
    [SMB+528] = { id =  SMB+528 }, -- Adamantking Effigy
    [SMB+529] = { id =  SMB+529 }, -- Adamantking Effigy
    [SMB+530] = { id =  SMB+530 }, -- Adamantking Effigy
    [SMB+531] = { id =  SMB+531 }, -- Adamantking Effigy
    [SMB+532] = { id =  SMB+532 }, -- Adamantking Effigy
    [SMB+533] = { id =  SMB+533 }, -- Adamantking Effigy
    [SMB+534] = { id =  SMB+534 }, -- Adamantking Effigy
    [SMB+535] = { id =  SMB+535 }, -- Adamantking Effigy
    [SMB+536] = { id =  SMB+536 }, -- Adamantking Effigy
    [SMB+537] = { id =  SMB+537 }, -- Adamantking Effigy
    [SMB+538] = { id =  SMB+538 }, -- Adamantking Effigy
    [SMB+539] = { id =  SMB+539 }, -- Adamantking Effigy
    [SMB+540] = { id =  SMB+540 }, -- Adamantking Effigy
    [SMB+541] = { id =  SMB+541 }, -- Adamantking Effigy
    [SMB+542] = { id =  SMB+542 }, -- Adamantking Effigy
    [SMB+543] = { id =  SMB+543 }, -- Adamantking Effigy
    [SMB+544] = { id =  SMB+544 }, -- Adamantking Effigy
    [SMB+545] = { id =  SMB+545 }, -- Adamantking Effigy
    [SMB+546] = { id =  SMB+546 }, -- Adamantking Effigy
    [SMB+547] = { id =  SMB+547 }, -- Adamantking Effigy
    [SMB+548] = { id =  SMB+548 }, -- Adamantking Effigy
    [SMB+549] = { id =  SMB+549 }, -- Adamantking Effigy
    [SMB+550] = { id =  SMB+550 }, -- Adamantking Effigy
    [SMB+551] = { id =  SMB+551 }, -- Adamantking Effigy
    [SMB+552] = { id =  SMB+552 }, -- Adamantking Effigy
    [SMB+553] = { id =  SMB+553 }, -- Adamantking Effigy
    [SMB+554] = { id =  SMB+554 }, -- Adamantking Effigy
    [SMB+555] = { id =  SMB+555 }, -- Adamantking Effigy
    [SMB+556] = { id =  SMB+556 }, -- Adamantking Effigy
    [SMB+557] = { id =  SMB+557 }, -- Adamantking Effigy
    [SMB+558] = { id =  SMB+558 }, -- Adamantking Effigy
    [SMB+559] = { id =  SMB+559 }, -- Adamantking Effigy
    [SMB+560] = { id =  SMB+560 }, -- Adamantking Effigy
    [SMB+561] = { id =  SMB+561 }, -- Adamantking Effigy
    [SMB+562] = { id =  SMB+562 }, -- Adamantking Effigy
    [SMB+563] = { id =  SMB+563 }, -- Adamantking Effigy
    [SMB+564] = { id =  SMB+564 }, -- Adamantking Effigy
    [SMB+565] = { id =  SMB+565 }, -- Adamantking Effigy
    [SMB+566] = { id =  SMB+566 }, -- Adamantking Effigy
    [SMB+567] = { id =  SMB+567 }, -- Adamantking Effigy
    [SMB+568] = { id =  SMB+568 }, -- Adamantking Effigy
    [SMB+569] = { id =  SMB+569 }, -- Adamantking Effigy
    [SMB+570] = { id =  SMB+570 }, -- Adamantking Effigy
    [SMB+571] = { id =  SMB+571 }, -- Adamantking Effigy
    [SMB+572] = { id =  SMB+572 }, -- Adamantking Effigy
    [SMB+573] = { id =  SMB+573 }, -- Adamantking Effigy
    [SMB+574] = { id =  SMB+574 }, -- Adamantking Effigy
    [SMB+575] = { id =  SMB+575 }, -- Adamantking Effigy
    [SMB+576] = { id =  SMB+576 }, -- Adamantking Effigy
    [SMB+577] = { id =  SMB+577 }, -- Adamantking Effigy
    [SMB+578] = { id =  SMB+578 }, -- Adamantking Effigy
    [SMB+579] = { id =  SMB+579 }, -- Adamantking Effigy
    [SMB+580] = { id =  SMB+580 }, -- Adamantking Effigy
    [SMB+581] = { id =  SMB+581 }, -- Adamantking Effigy
    [SMB+582] = { id =  SMB+582 }, -- Adamantking Effigy
    [SMB+583] = { id =  SMB+583 }, -- Adamantking Effigy
    [SMB+584] = { id =  SMB+584 }, -- Adamantking Effigy
    [SMB+585] = { id =  SMB+585 }, -- Adamantking Effigy
    [SMB+586] = { id =  SMB+586 }, -- Adamantking Effigy
    [SMB+587] = { id =  SMB+587 }, -- Adamantking Effigy
    [SMB+588] = { id =  SMB+588 }, -- Adamantking Effigy
    [SMB+589] = { id =  SMB+589 }, -- Adamantking Effigy
    [SMB+590] = { id =  SMB+590 }, -- Adamantking Effigy
    [SMB+591] = { id =  SMB+591 }, -- Adamantking Effigy
    [SMB+592] = { id =  SMB+592 }, -- Adamantking Effigy
    [SMB+593] = { id =  SMB+593 }, -- Adamantking Effigy
    [SMB+594] = { id =  SMB+594 }, -- Adamantking Effigy
    [SMB+595] = { id =  SMB+595 }, -- Adamantking Effigy
    [SMB+596] = { id =  SMB+596 }, -- Adamantking Effigy
    [SMB+597] = { id =  SMB+597 }, -- Adamantking Effigy
    [SMB+598] = { id =  SMB+598 }, -- Adamantking Effigy
    [SMB+599] = { id =  SMB+599 }, -- Adamantking Effigy
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_BASTOK

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
mobList[zone][SMB+352].pos = { 81.7644, 0.0000, -71.8662, 0   } -- W1 Mog C
mobList[zone][SMB+355].pos = { 76.1541, 0.0000, -66.1046, 10  } -- W1 Mog N
mobList[zone][SMB+358].pos = { 60.4041, 0.0000, -81.5565, 8   } -- W1 Mog S
mobList[zone][SMB+347].pos = { 28.6896, 0.8720, -91.7210, 202 } -- W1 Choc W
mobList[zone][SMB+337].pos = { 39.9337, 0.7986, -88.8102, 192 } -- W1 Choc C
mobList[zone][SMB+342].pos = { 49.9168, 0.8720, -90.7635, 182 } -- W1 Choc E
mobList[zone][SMB+277].pos = {-18.9468, 0.0000, -71.3164, 77  } -- W1 AH WW
mobList[zone][SMB+288].pos = { -9.0602, 0.0000, -78.5527, 69  } -- W1 AH W
mobList[zone][SMB+280].pos = {  0.0159, 0.0000, -73.3527, 61  } -- W1 AH C
mobList[zone][SMB+291].pos = { 10.7120, 0.0000, -78.6646, 53  } -- W1 AH E
mobList[zone][SMB+285].pos = { 19.0447, 0.0000, -71.2227, 45  } -- W1 AH EE
mobList[zone][SMB+294].pos = {-16.4125,-3.0000, -54.3911, 207 } -- W1 AHtop WW
mobList[zone][SMB+295].pos = { -8.4375,-3.0000, -56.5214, 199 } -- W1 AHtop W
mobList[zone][SMB+297].pos = { -0.0019,-3.0000, -57.3668, 191 } -- W1 AHtop C
mobList[zone][SMB+298].pos = {  8.4347,-3.0000, -56.4465, 183 } -- W1 AHtop E
mobList[zone][SMB+300].pos = { 16.3665,-3.0000, -54.6565, 175 } -- W1 AHtop EE
mobList[zone][SMB+274].pos = { 42.8057, 0.0000, -56.8658, 80  } -- W1 AH E.Alley S
mobList[zone][SMB+270].pos = { 38.2376, 0.0000, -42.7884, 75  } -- W1 AH E.Alley C
mobList[zone][SMB+266].pos = { 30.4976, 0.0000, -26.9415, 55  } -- W1 AH E.Alley N
mobList[zone][SMB+262].pos = {  0.4871, 0.0000, -24.9742, 128 } -- W1 AH N.Alley C
mobList[zone][SMB+208].pos = { -4.9191, 0.0000, -17.1571, 190 } -- W1 AH N.Alley Catwalk
mobList[zone][SMB+301].pos = {  7.0503, 0.0000,-100.7739, 192 } -- W1 W of Choc
mobList[zone][SMB+327].pos = { -5.6342,-1.0008,-115.6188, 192 } -- W1 S.Gate SE
mobList[zone][SMB+330].pos = {-16.2038,-1.0008,-122.3855, 192 } -- W1 S.Gate S
mobList[zone][SMB+333].pos = {-23.9244,-1.0008,-121.6056, 227 } -- W1 spawned by 330
mobList[zone][SMB+361].pos = {-10.4154,-1.0008,-106.0800, 192 } -- W1 S.Gate C
mobList[zone][SMB+334].pos = {-26.3670,-1.0008,-121.4364, 192 } -- W1 S.Gate SW
mobList[zone][SMB+364].pos = {-24.4167,-1.0008,-106.3167, 192 } -- W1 S.Gate W
mobList[zone][SMB+305].pos = {-24.4831, 0.0000, -97.2766, 192 } -- W1 S.Gate NW
mobList[zone][SMB+309].pos = {-35.5730, 0.0000, -78.3345, 9   } -- W1 SW of AH
mobList[zone][SMB+313].pos = {-37.0065, 0.0000, -56.1556, 60  } -- W1 W of AH (S)
mobList[zone][SMB+320].pos = {-37.0648, 0.0000, -53.8018, 64  } -- W1 spawned by 313
mobList[zone][SMB+317].pos = {-38.9458, 0.0000, -58.3568, 60  } -- W1 spawned by 313
mobList[zone][SMB+314].pos = {-35.4041, 0.0000, -58.2174, 60  } -- W1 spawned by 313
mobList[zone][SMB+323].pos = {-38.4296, 0.0000, -38.0029, 60  } -- W1 W of AH (C)
mobList[zone][SMB+259].pos = {-28.5587, 0.0000, -25.8180, 82  } -- W1 W of AH (NE)
mobList[zone][SMB+374].pos = {-46.8709, 0.0000, -20.4151, 49  } -- W1 W of AH (NW)
mobList[zone][SMB+157].pos = {-41.0685, 0.0000,  -2.1238, 255 } -- W1 W of Boytz (S)
mobList[zone][SMB+156].pos = {-45.5975, 0.0000,   4.8671, 128 } -- W1 W of Boytz (C)
mobList[zone][SMB+122].pos = {-44.9282,-3.4933,  15.1018, 93  } -- W1 W of Boytz (N)
mobList[zone][SMB+207].pos = {-29.5942, 0.0000,  23.0013, 0   } -- W1 N of Boytz, Catwalk
mobList[zone][SMB+158].pos = {-64.5615, 0.0000,  41.3409, 192 } -- W1 Corner Sheds W
mobList[zone][SMB+155].pos = {-57.7503, 0.0000,  41.0368, 192 } -- W1 Corner Shed E
mobList[zone][SMB+99 ].pos = {-78.0000, 0.0000,   4.0000, 0   } -- W1 Under Bridge NE
mobList[zone][SMB+116].pos = {-74.0000, 0.0000,   0.0000, 0   } -- W1 Under Bridge E
mobList[zone][SMB+107].pos = {-78.0000, 0.0000,  -4.0000, 0   } -- W1 Under Bridge SE
mobList[zone][SMB+103].pos = {-91.2000, 0.0000,   6.0000, 0   } -- W1 Under Bridge NW
mobList[zone][SMB+119].pos = {-91.2000, 0.0000,  -1.0000, 0   } -- W1 Under Bridge W
mobList[zone][SMB+111].pos = {-91.2000, 0.0000,  -6.0000, 0   } -- W1 Under Bridge SW
mobList[zone][SMB+62 ].pos = {-108.8306, 0.0000, -9.2511, 234 } -- W1 Chokepoint/Zeruhn Sect
mobList[zone][SMB+95 ].pos = { -99.3387, 8.0000, 46.4492, 72  } -- W1 Markets S
mobList[zone][SMB+87 ].pos = {-103.6146,10.0026, 56.2027, 60  } -- W1 Markets C
mobList[zone][SMB+91 ].pos = { -96.7740,12.0000, 66.2248, 64  } -- W1 Markets E
mobList[zone][SMB+86 ].pos = {-111.2602,12.0000, 65.9353, 64  } -- W1 Markets W
mobList[zone][SMB+83 ].pos = {-104.0242,12.0000, 72.8178, 64  } -- W1 Markets N
mobList[zone][SMB+50 ].pos = {-133.1783,-0.5393,  4.0241, 64  } -- W1 Zer N.Ramp (SW)
mobList[zone][SMB+53 ].pos = {-128.0898,-0.5724, -0.9718, 64  } -- W1 Zer N.Ramp (NW)
mobList[zone][SMB+60 ].pos = {-138.1234,-11.9249,29.2820, 28  } -- W1 Zer N.Ramp (top)
mobList[zone][SMB+33 ].pos = {-147.1535, 0.0000,  4.2789, 60  } -- W1 Zer W.Clearing (NE)
mobList[zone][SMB+25 ].pos = {-155.1991, 0.0000,  2.2134, 28  } -- W1 Zer W.Clearing (N)
mobList[zone][SMB+24 ].pos = {-164.7690,-3.4933, -2.0815, 2   } -- W1 Zer W.Clearing (NW)
mobList[zone][SMB+30 ].pos = {-161.1492, 0.0000,-11.3847, 249 } -- W1 Zer W.Clearing (W)
mobList[zone][SMB+26 ].pos = {-152.0940, 0.0000,-20.0017, 245 } -- W1 Zer W.Clearing (S)
mobList[zone][SMB+13 ].pos = {-153.7795, 0.0000,-40.9650, 191 } -- W1 Zer W.Ramp Base
mobList[zone][SMB+17 ].pos = {-160.1865, 0.0000,-40.8198, 232 } -- W1 spawned by 13
mobList[zone][SMB+5  ].pos = {-175.8118,-7.7793,-21.0173, 223 } -- W1 Zer W.Ramp (S)
mobList[zone][SMB+1  ].pos = {-178.4068,-8.1360,-17.9503, 254 } -- W1 Zer W.Ramp (W)
mobList[zone][SMB+4  ].pos = {-177.2654,-8.3147,-13.5608, 17  } -- W1 spawned by 1
mobList[zone][SMB+8  ].pos = {-173.8426,-7.8933,-10.8492, 21  } -- W1 Zer W.Ramp (N)
mobList[zone][SMB+46 ].pos = {-133.5637, 0.0000,-31.0000, 96  } -- W1 Zer S.Clearing (NW)
mobList[zone][SMB+38 ].pos = {-122.6414, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (N)
mobList[zone][SMB+42 ].pos = {-117.1745, 0.0000,-43.4918, 192 } -- W1 Zer S.Clearing (NE)
mobList[zone][SMB+37 ].pos = {-123.7850,-3.4933,-74.1327, 189 } -- W1 Zer S.Clearing (S)
mobList[zone][SMB+36 ].pos = {-122.9294, 0.0000,-78.9028, 165 } -- W1 Zer S.Clearing (SE)
mobList[zone][SMB+67 ].pos = {-108.1392,-0.3415,-37.2321, 189 } -- W1 Depot Ramp Base
mobList[zone][SMB+70 ].pos = { -99.4389,-8.0000,-59.8070, 127 } -- W1 Depot Ramp Top
mobList[zone][SMB+82 ].pos = { -58.0759,-8.0000,-79.5513, 194 } -- W1 Depot Balc S
mobList[zone][SMB+76 ].pos = { -52.3919,-8.0000,-66.1270, 147 } -- W1 Depot Balc C
mobList[zone][SMB+72 ].pos = { -52.6932,-8.0000,-54.5636, 106 } -- W1 Depot Balc N
mobList[zone][SMB+256].pos = { -21.3849, 7.0000, 31.8739, 119 } -- W1 O.St. Entr N
mobList[zone][SMB+283].pos = { -20.1820, 7.0000, 27.5603, 130 } -- W1 O.St. Entr S
mobList[zone][SMB+165].pos = {  -0.3031, 0.0000, 37.6598, 125 } -- W1 O.St. Entr Catwalk
mobList[zone][SMB+168].pos = { -14.0588, 0.0000, 30.0374, 143 } -- W1 O.St. Entr Bridge
mobList[zone][SMB+171].pos = {   8.8358, 0.0000, 22.4781, 170 } -- W1 O.St. CW Enc.#1
mobList[zone][SMB+174].pos = {   2.1785, 0.0000, 10.0314, 154 } -- W1 O.St. CW Bridge
mobList[zone][SMB+177].pos = {  17.7209, 0.0000,  7.9742, 133 } -- W1 O.St. CW Enc.#2
mobList[zone][SMB+367].pos = {  36.0086, 0.0000,  8.1324, 191 } -- W1 O.St. CW Enc.#3
mobList[zone][SMB+372].pos = {  37.0316, 0.0000, 20.2594, 147 } -- W1 O.St. CW S.Well#1
mobList[zone][SMB+187].pos = {  31.0277, 0.0000, 23.8121, 64  } -- W1 O.St. CW S.Well#2
mobList[zone][SMB+235].pos = {  30.9778, 7.0000,  5.6604, 64  } -- W1 O.St. CW S.Well Base
mobList[zone][SMB+370].pos = {  60.1261, 0.0000,  8.1024, 129 } -- W1 O.St. CW Enc.#4
mobList[zone][SMB+200].pos = {  69.9259, 0.0000, 10.5869, 64  } -- W1 O.St. CW Enc.#5
mobList[zone][SMB+204].pos = {  86.0668, 0.0000, 10.5541, 64  } -- W1 O.St. CW Enc.#6
mobList[zone][SMB+181].pos = {   8.9690, 0.0000, -5.4239, 192 } -- W1 O.St. CW W Enc.#1
mobList[zone][SMB+184].pos = {   8.8837, 0.0000,-16.3382, 192 } -- W1 O.St. CW W Enc.#2
mobList[zone][SMB+190].pos = {  60.0449, 0.0000, -1.2954, 192 } -- W1 O.St. CW E Enc.#1
mobList[zone][SMB+197].pos = {  50.8795,-0.0029,-13.2487, 232 } -- W1 O.St. CW E Enc.#2
mobList[zone][SMB+193].pos = {  61.7784, 0.0000,-20.6739, 187 } -- W1 O.St. CW E Enc.#3
mobList[zone][SMB+249].pos = {   2.0635, 7.0000, 18.2131, 159 } -- W1 O.St. NW
mobList[zone][SMB+245].pos = {  -2.5034, 7.0000, -6.0080, 0   } -- W1 O.St. SW
mobList[zone][SMB+241].pos = {  14.0251, 7.0000, -8.5442, 192 } -- W1 O.St. SE
mobList[zone][SMB+237].pos = {  21.0685, 7.0000,  1.1670, 115 } -- W1 O.St. NE
mobList[zone][SMB+230].pos = {  69.9420, 7.0000,  2.5947, 64  } -- W1 Alch NW
mobList[zone][SMB+226].pos = {  81.9570, 7.0000,  2.3986, 64  } -- W1 Alch NE
mobList[zone][SMB+222].pos = {  90.2082, 7.0029, -2.4041, 128 } -- W1 Alch E
mobList[zone][SMB+225].pos = {  90.0454, 7.0000, -5.9869, 133 } -- W1 spawned by 222
mobList[zone][SMB+215].pos = {  63.8661, 7.0000,-32.7333, 215 } -- W1 Gal.Dist. W
mobList[zone][SMB+218].pos = {  73.8867, 7.0029,-34.8135, 185 } -- W1 Gal.Dist. S
mobList[zone][SMB+212].pos = {  83.5793, 7.0000,-32.4353, 145 } -- W1 Gal.Dist. E
mobList[zone][DMB+1  ].pos = {-16.1024,-1.0008,-124.9145, 192 } -- W2 Final Boss South Gate
mobList[zone][SMB+389].pos = {-31.7986,-1.0008,-122.3744, 218 } -- W2 W of Final Boss
mobList[zone][SMB+391].pos = {-25.2000,-1.0008,-122.3744, 187 } -- W2 spawned by Final Boss
mobList[zone][SMB+392].pos = {-20.7000,-1.0008,-122.3744, 190 } -- W2 spawned by Final Boss
mobList[zone][SMB+393].pos = {-16.2000,-1.0008,-122.2636, 192 } -- W2 spawned by Final Boss
mobList[zone][SMB+394].pos = {-11.7000,-1.0008,-122.3744, 194 } -- W2 spawned by Final Boss
mobList[zone][SMB+395].pos = { -7.2000,-1.0008,-122.3744, 197 } -- W2 spawned by Final Boss
mobList[zone][SMB+419].pos = {  9.4977, 0.0000,-121.5922, 201 } -- W3 far W of Choco
mobList[zone][SMB+424].pos = { 16.5175, 0.0000,-121.5445, 190 } -- W3 W of Choco (S)
mobList[zone][SMB+429].pos = { 16.5028, 0.0000,-110.3989, 198 } -- W3 W of Choco (C)
mobList[zone][SMB+434].pos = { 18.1155, 0.0000, -99.2747, 144 } -- W3 W of Choco (N)
mobList[zone][SMB+399].pos = {-20.0432,-3.0000, -58.9616, 56  } -- W3 AH WW
mobList[zone][SMB+403].pos = {-12.3780,-3.0000, -61.4330, 89  } -- W3 AH W
mobList[zone][SMB+407].pos = {  0.1313,-3.0000, -62.5700, 66  } -- W3 AH C
mobList[zone][SMB+411].pos = { 10.7283,-3.0000, -61.6430, 30  } -- W3 AH E
mobList[zone][SMB+415].pos = { 19.1724,-3.0000, -59.4239, 67  } -- W3 AH EE
mobList[zone][SMB+453].pos = { 31.6634, 0.0000, -64.0405, 86  } -- W3 Alley W
mobList[zone][SMB+460].pos = { 39.7658, 0.0000, -59.6651, 64  } -- W3 Alley E
mobList[zone][SMB+465].pos = { 54.8432, 0.0000, -67.1650, 93  } -- W3 Outside Mog NW
mobList[zone][SMB+470].pos = { 64.4780, 0.0000, -66.9347, 103 } -- W3 Outside Mog N
mobList[zone][SMB+474].pos = { 76.5238, 0.0000, -67.1802, 92  } -- W3 Outside Mog NE
mobList[zone][SMB+449].pos = { 77.0071, 0.0000, -79.6646, 140 } -- W3 Outside Mog SE
mobList[zone][SMB+445].pos = { 67.9729, 0.0000, -85.3997, 171 } -- W3 Outside Mog S
mobList[zone][SMB+441].pos = { 62.2124, 0.0000, -85.9488, 159 } -- W3 Outside Mog SW
mobList[zone][SMB+482].pos = { 90.1017, 0.6234, -71.7804, 128 } -- W3 Mog Clockwise #1
mobList[zone][SMB+478].pos = { 90.4399, 0.9944, -57.0740, 66  } -- W3 Mog Clockwise #2
mobList[zone][SMB+491].pos = {102.6341, 0.9944, -56.2798, 114 } -- W3 Mog Clockwise #3
mobList[zone][SMB+495].pos = {110.9067, 0.9944, -56.7192, 121 } -- W3 Mog Clockwise #4
mobList[zone][SMB+498].pos = {119.3663, 0.9944, -54.6408, 89  } -- W3 Mog Clockwise #5
mobList[zone][SMB+501].pos = {117.2807, 0.9944, -65.8843, 128 } -- W3 Mog Clockwise #6
mobList[zone][SMB+505].pos = {117.2442, 0.9944, -71.5537, 128 } -- W3 Mog Clockwise #7
mobList[zone][SMB+512].pos = {117.2807, 0.9944, -77.7863, 128 } -- W3 Mog Clockwise #8
mobList[zone][SMB+516].pos = {118.7241, 0.9944, -88.4772, 161 } -- W3 Mog Clockwise #9
mobList[zone][SMB+519].pos = {110.8669, 0.9944, -88.1171, 135 } -- W3 Mog Clockwise #10
mobList[zone][SMB+522].pos = {102.8179, 0.9944, -88.3096, 146 } -- W3 Mog Clockwise #11
mobList[zone][SMB+487].pos = { 90.7621, 0.9944, -87.7146, 190 } -- W3 Mog Clockwise #12
mobList[zone][SMB+526].pos = {101.4331, 0.9944, -65.9948, 185 } -- W3 Mog N
mobList[zone][SMB+531].pos = {101.6548, 0.9944, -78.9599, 69  } -- W3 Mog S

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path = { 11, 22, 33, 66, 77, 88, }

mobList[zone][SMB+337].patrolPath = {   40,    0,  -85,     40,    1,  -96,     40,    0,  -85     } -- W1 Choc C
mobList[zone][SMB+262].patrolPath = {    3,    0,  -25,    -12,    0,  -25,      3,    0,  -25     } -- W1 AH N.Alley C
mobList[zone][SMB+301].patrolPath = {    7,    0, -100,      5,    0,  -79,      7,    0, -100     } -- W1 W of Choc
mobList[zone][SMB+305].patrolPath = {  -24,    0, -100,    -24,    0,  -79,    -24,    0, -100     } -- W1 W of Choc
mobList[zone][SMB+277].patrolPath = {  -20,    0,  -79,    -16,   -3,  -64,    -20,    0,  -79     } -- W1 AH WW
mobList[zone][SMB+280].patrolPath = {    0,    0,  -79,     0,    -3,  -64,      0,    0,  -79     } -- W1 AH C
mobList[zone][SMB+285].patrolPath = {   20,    0,  -79,     16,   -3,  -64,     20,    0,  -79     } -- W1 AH EE
mobList[zone][SMB+374].patrolPath = {  -44,    0,  -29,    -42,    0,   -9,    -44,    0,  -29     } -- W1 W of AH (NW)
mobList[zone][SMB+330].patrolPath = {  -10,   -1, -114,    -25,   -1, -114,    -10,   -1, -114     } -- W1 S.Gate S
mobList[zone][SMB+323].patrolPath = {  -32,    0,  -38,    -45,    0,  -38,    -32,    0,  -38     } -- W1 W of AH (C)
mobList[zone][SMB+99 ].patrolPath = {  -78,    0,    4,    -70,    0,    9,    -78,    0,    4     } -- W1 Under Bridge NE
mobList[zone][SMB+107].patrolPath = {  -78,    0,   -4,    -70,    0,   -9,    -78,    0,   -4     } -- W1 Under Bridge SE
mobList[zone][SMB+116].patrolPath = {  -70,    0,    0,    -78,    0,    0,    -70,    0,    0     } -- W1 Under Bridge E
mobList[zone][SMB+103].patrolPath = {  -94,    0,    9,    -87,    0,    4,    -94,    0,    9     } -- W1 Under Bridge NW
mobList[zone][SMB+111].patrolPath = {  -94,    0,   -9,    -87,    0,   -4,    -94,    0,   -9     } -- W1 Under Bridge SW
mobList[zone][SMB+119].patrolPath = {  -94,    0,    0,    -86,    0,    0,    -94,    0,    0     } -- W1 Under Bridge W
mobList[zone][SMB+53 ].patrolPath = { -128, -1.6,    4,   -128,    0,   -6,   -128, -1.6,    4     } -- W1 Zer N.Ramp (SW)
mobList[zone][SMB+50 ].patrolPath = { -132,    0,   -6,   -132, -1.6,    4,   -132,    0,   -6     } -- W1 Zer N.Ramp (NW)
mobList[zone][SMB+67 ].patrolPath = { -108,   -8,  -60,   -108,    0,  -14,   -108,   -8,  -60     } -- W1 Depot Ramp Base
mobList[zone][SMB+70 ].patrolPath = { -102,   -8,  -60,    -60,    0,  -60,   -102,   -8,  -60     } -- W1 Depot Ramp Top
mobList[zone][SMB+237].patrolPath = {   31,    7,   -2,      4,    7,   -2,     31,    7,   -2     } -- W1 O.St. NE
mobList[zone][SMB+235].patrolPath = {   31,    7,    5,     31,    3,   16,     31,    7,    5     } -- W1 O.St. CW S.Well Base
mobList[zone][SMB+187].patrolPath = {   31,    0,   24,     31,    2,   18,     31,    0,   24     } -- W1 O.St. CW S.Well#2
mobList[zone][SMB+370].patrolPath = {   74,    0,    8,     60,    0,    8,     74,    0,    8     } -- W1 O.St. CW Enc.#4
mobList[zone][SMB+367].patrolPath = {   36,    0,    8,     21,    0,    8,     36,    0,    8     } -- W1 O.St. CW Enc.#3

-- set statue eye color
mobList[zone][SMB+352].eyes = dynamis.eyes.RED
mobList[zone][SMB+342].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+347].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+294].eyes = dynamis.eyes.RED
mobList[zone][SMB+330].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+333].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+320].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+156].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+157].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+155].eyes = dynamis.eyes.RED
mobList[zone][SMB+158].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+60 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+24 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+17 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+4  ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+36 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+370].eyes = dynamis.eyes.GREEN
mobList[zone][DMB+1  ].eyes = dynamis.eyes.RED
mobList[zone][SMB+389].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+419].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+424].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+399].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+407].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+415].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+453].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+460].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+470].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+474].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+445].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+482].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+491].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+498].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+516].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+522].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+526].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+531].eyes = dynamis.eyes.GREEN


-- set time extensions
mobList[zone][SMB+352].timeExtension = 20
mobList[zone][SMB+294].timeExtension = 20
mobList[zone][SMB+155].timeExtension = 20
mobList[zone][DMB+71 ].timeExtension = 30 -- Gu'Nhi Noondozer (SMN)
mobList[zone][SMB+17 ].timeExtension = 10
mobList[zone][DMB+2  ].timeExtension = 10 -- Vanguard Vindicator (Statue 17)
mobList[zone][DMB+12 ].timeExtension = 10 -- Vanguard Constable (Statue 17)
mobList[zone][DMB+1  ].timeExtension = 30 -- Gu'Dha Effigy (Final Boss)

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { DMB+75, DMB+116, DMB+235, DMB+236 } -- Ze'Vho Fallsplitter (DRK) , Gi'Pha Manameister (BLM) , Aa'Nyu Dismantler (DRK) , Be'Ebo Tortoisedriver (MNK) ... once all defeated, spawn boss
mobList[zone].waveDefeatRequirements[3] = { DMB+1 } -- Gu'Dha Effigy (Final Boss) spawns wave 3 when defeated

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
mobList[zone][SMB+352].waves = {  1 ,nil,nil }
mobList[zone][SMB+355].waves = {  1 ,nil,nil }
mobList[zone][SMB+358].waves = {  1 ,nil,nil }
mobList[zone][SMB+347].waves = {  1 ,nil,nil }
mobList[zone][SMB+337].waves = {  1 ,nil,nil }
mobList[zone][SMB+342].waves = {  1 ,nil,nil }
mobList[zone][SMB+277].waves = {  1 ,nil,nil }
mobList[zone][SMB+288].waves = {  1 ,nil,nil }
mobList[zone][SMB+280].waves = {  1 ,nil,nil }
mobList[zone][SMB+291].waves = {  1 ,nil,nil }
mobList[zone][SMB+285].waves = {  1 ,nil,nil }
mobList[zone][SMB+294].waves = {  1 ,nil,nil }
mobList[zone][SMB+295].waves = {  1 ,nil,nil }
mobList[zone][SMB+297].waves = {  1 ,nil,nil }
mobList[zone][SMB+298].waves = {  1 ,nil,nil }
mobList[zone][SMB+300].waves = {  1 ,nil,nil }
mobList[zone][SMB+274].waves = {  1 ,nil,nil }
mobList[zone][SMB+270].waves = {  1 ,nil,nil }
mobList[zone][SMB+266].waves = {  1 ,nil,nil }
mobList[zone][SMB+262].waves = {  1 ,nil,nil }
mobList[zone][SMB+208].waves = {  1 ,nil,nil }
mobList[zone][SMB+301].waves = {  1 ,nil,nil }
mobList[zone][SMB+327].waves = {  1 ,nil,nil }
mobList[zone][SMB+330].waves = {  1 ,nil,nil }
mobList[zone][SMB+361].waves = {  1 ,nil,nil }
mobList[zone][SMB+334].waves = {  1 ,nil,nil }
mobList[zone][SMB+364].waves = {  1 ,nil,nil }
mobList[zone][SMB+305].waves = {  1 ,nil,nil }
mobList[zone][SMB+309].waves = {  1 ,nil,nil }
mobList[zone][SMB+313].waves = {  1 ,nil,nil }
mobList[zone][SMB+323].waves = {  1 ,nil,nil }
mobList[zone][SMB+259].waves = {  1 ,nil,nil }
mobList[zone][SMB+374].waves = {  1 ,nil,nil }
mobList[zone][SMB+156].waves = {  1 ,nil,nil }
mobList[zone][SMB+157].waves = {  1 ,nil,nil }
mobList[zone][SMB+122].waves = {  1 ,nil,nil }
mobList[zone][SMB+207].waves = {  1 ,nil,nil }
mobList[zone][SMB+158].waves = {  1 ,nil,nil }
mobList[zone][SMB+155].waves = {  1 ,nil,nil }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+116].waves = {  1 ,nil,nil }
mobList[zone][SMB+107].waves = {  1 ,nil,nil }
mobList[zone][SMB+103].waves = {  1 ,nil,nil }
mobList[zone][SMB+119].waves = {  1 ,nil,nil }
mobList[zone][SMB+111].waves = {  1 ,nil,nil }
mobList[zone][SMB+62 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+87 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+91 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+86 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+83 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+50 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+53 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+60 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+33 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+25 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+24 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+30 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+26 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+13 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+5  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+8  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+46 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+38 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+42 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+37 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+36 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+67 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+70 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+82 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+76 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+72 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+256].waves = {  1 ,nil,nil }
mobList[zone][SMB+283].waves = {  1 ,nil,nil }
mobList[zone][SMB+168].waves = {  1 ,nil,nil }
mobList[zone][SMB+165].waves = {  1 ,nil,nil }
mobList[zone][SMB+171].waves = {  1 ,nil,nil }
mobList[zone][SMB+174].waves = {  1 ,nil,nil }
mobList[zone][SMB+177].waves = {  1 ,nil,nil }
mobList[zone][SMB+367].waves = {  1 ,nil,nil }
mobList[zone][SMB+372].waves = {  1 ,nil,nil }
mobList[zone][SMB+187].waves = {  1 ,nil,nil }
mobList[zone][SMB+235].waves = {  1 ,nil,nil }
mobList[zone][SMB+370].waves = {  1 ,nil,nil }
mobList[zone][SMB+200].waves = {  1 ,nil,nil }
mobList[zone][SMB+204].waves = {  1 ,nil,nil }
mobList[zone][SMB+181].waves = {  1 ,nil,nil }
mobList[zone][SMB+184].waves = {  1 ,nil,nil }
mobList[zone][SMB+190].waves = {  1 ,nil,nil }
mobList[zone][SMB+197].waves = {  1 ,nil,nil }
mobList[zone][SMB+193].waves = {  1 ,nil,nil }
mobList[zone][SMB+249].waves = {  1 ,nil,nil }
mobList[zone][SMB+245].waves = {  1 ,nil,nil }
mobList[zone][SMB+241].waves = {  1 ,nil,nil }
mobList[zone][SMB+237].waves = {  1 ,nil,nil }
mobList[zone][SMB+230].waves = {  1 ,nil,nil }
mobList[zone][SMB+226].waves = {  1 ,nil,nil }
mobList[zone][SMB+222].waves = {  1 ,nil,nil }
mobList[zone][SMB+215].waves = {  1 ,nil,nil }
mobList[zone][SMB+218].waves = {  1 ,nil,nil }
mobList[zone][SMB+212].waves = {  1 ,nil,nil }
mobList[zone][DMB+1  ].waves = { nil, 2 ,nil }
mobList[zone][SMB+389].waves = { nil, 2 ,nil }
mobList[zone][SMB+419].waves = { nil,nil, 3  }
mobList[zone][SMB+424].waves = { nil,nil, 3  }
mobList[zone][SMB+429].waves = { nil,nil, 3  }
mobList[zone][SMB+434].waves = { nil,nil, 3  }
mobList[zone][SMB+399].waves = { nil,nil, 3  }
mobList[zone][SMB+403].waves = { nil,nil, 3  }
mobList[zone][SMB+407].waves = { nil,nil, 3  }
mobList[zone][SMB+411].waves = { nil,nil, 3  }
mobList[zone][SMB+415].waves = { nil,nil, 3  }
mobList[zone][SMB+453].waves = { nil,nil, 3  }
mobList[zone][SMB+460].waves = { nil,nil, 3  }
mobList[zone][SMB+465].waves = { nil,nil, 3  }
mobList[zone][SMB+470].waves = { nil,nil, 3  }
mobList[zone][SMB+474].waves = { nil,nil, 3  }
mobList[zone][SMB+449].waves = { nil,nil, 3  }
mobList[zone][SMB+445].waves = { nil,nil, 3  }
mobList[zone][SMB+441].waves = { nil,nil, 3  }
mobList[zone][SMB+482].waves = { nil,nil, 3  }
mobList[zone][SMB+478].waves = { nil,nil, 3  }
mobList[zone][SMB+491].waves = { nil,nil, 3  }
mobList[zone][SMB+495].waves = { nil,nil, 3  }
mobList[zone][SMB+498].waves = { nil,nil, 3  }
mobList[zone][SMB+501].waves = { nil,nil, 3  }
mobList[zone][SMB+505].waves = { nil,nil, 3  }
mobList[zone][SMB+512].waves = { nil,nil, 3  }
mobList[zone][SMB+516].waves = { nil,nil, 3  }
mobList[zone][SMB+519].waves = { nil,nil, 3  }
mobList[zone][SMB+522].waves = { nil,nil, 3  }
mobList[zone][SMB+487].waves = { nil,nil, 3  }
mobList[zone][SMB+526].waves = { nil,nil, 3  }
mobList[zone][SMB+531].waves = { nil,nil, 3  }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues) boolean value = forceLink enabled yes/no (default no if unspecified)
mobList[zone][SMB+330].specificChildren = { true, SMB+333 }
mobList[zone][SMB+313].specificChildren = { true, SMB+314, SMB+317, SMB+320 }
mobList[zone][SMB+158].specificChildren = { true, DMB+236 } -- Be'Ebo Tortoisedriver (MNK)
mobList[zone][SMB+119].specificChildren = { true, DMB+235 } -- Aa'Nyu Dismantler (DRK)
mobList[zone][SMB+83 ].specificChildren = { true, DMB+118 } -- Ke'Dhe Cannonball (MNK)
mobList[zone][SMB+1  ].specificChildren = { true, SMB+4, DMB+75 } -- Ze'Vho Fallsplitter (DRK)
mobList[zone][SMB+13 ].specificChildren = { true, SMB+17 }
mobList[zone][SMB+17 ].specificChildren = { true, DMB+2, DMB+12 } -- Vanguard Vindicator/Constable (2x 10min TEs)
mobList[zone][SMB+222].specificChildren = { true, SMB+225, DMB+116 } -- Gi'Pha Manameister (BLM)
mobList[zone][SMB+218].specificChildren = { true, DMB+71 } -- Gu'Nhi Noondozer (SMN)
mobList[zone][DMB+1  ].specificChildren = { true, SMB+391, SMB+392, SMB+393, SMB+394, SMB+395, DMB+265, DMB+266, DMB+267, DMB+269, DMB+270 } -- final boss spawns statues "3xx" i numbered left to right starting at 391
mobList[zone][SMB+391].specificChildren = { true, DMB+271, DMB+272 } -- fifteen effigy shields in total
mobList[zone][SMB+392].specificChildren = { true, DMB+273, DMB+274 }
mobList[zone][SMB+393].specificChildren = { true, DMB+275, DMB+276 }
mobList[zone][SMB+394].specificChildren = { true, DMB+278, DMB+279 }
mobList[zone][SMB+395].specificChildren = { true, DMB+280 }

-- set how many random children i will spawn when i engage
mobList[zone][SMB+352].randomChildrenCount = 2
mobList[zone][SMB+355].randomChildrenCount = 2
mobList[zone][SMB+358].randomChildrenCount = 2
mobList[zone][SMB+342].randomChildrenCount = 2
mobList[zone][SMB+337].randomChildrenCount = 2
mobList[zone][SMB+347].randomChildrenCount = 2
mobList[zone][SMB+277].randomChildrenCount = 2
mobList[zone][SMB+288].randomChildrenCount = 2
mobList[zone][SMB+280].randomChildrenCount = 3
mobList[zone][SMB+291].randomChildrenCount = 2
mobList[zone][SMB+285].randomChildrenCount = 2
mobList[zone][SMB+294].randomChildrenCount = 0
mobList[zone][SMB+295].randomChildrenCount = 1
mobList[zone][SMB+297].randomChildrenCount = 0
mobList[zone][SMB+298].randomChildrenCount = 1
mobList[zone][SMB+300].randomChildrenCount = 0
mobList[zone][SMB+274].randomChildrenCount = 2
mobList[zone][SMB+270].randomChildrenCount = 2
mobList[zone][SMB+266].randomChildrenCount = 3
mobList[zone][SMB+262].randomChildrenCount = 3
mobList[zone][SMB+208].randomChildrenCount = 3
mobList[zone][SMB+301].randomChildrenCount = 3
mobList[zone][SMB+327].randomChildrenCount = 2
mobList[zone][SMB+330].randomChildrenCount = 2
mobList[zone][SMB+361].randomChildrenCount = 2
mobList[zone][SMB+334].randomChildrenCount = 2
mobList[zone][SMB+364].randomChildrenCount = 2
mobList[zone][SMB+305].randomChildrenCount = 2
mobList[zone][SMB+309].randomChildrenCount = 3
mobList[zone][SMB+333].randomChildrenCount = 0
mobList[zone][SMB+313].randomChildrenCount = 0
mobList[zone][SMB+323].randomChildrenCount = 3
mobList[zone][SMB+259].randomChildrenCount = 2
mobList[zone][SMB+374].randomChildrenCount = 2
mobList[zone][SMB+314].randomChildrenCount = 2
mobList[zone][SMB+317].randomChildrenCount = 2
mobList[zone][SMB+320].randomChildrenCount = 2
mobList[zone][SMB+157].randomChildrenCount = 0
mobList[zone][SMB+156].randomChildrenCount = 2
mobList[zone][SMB+122].randomChildrenCount = 1
mobList[zone][SMB+207].randomChildrenCount = 0
mobList[zone][SMB+158].randomChildrenCount = 2
mobList[zone][SMB+155].randomChildrenCount = 0
mobList[zone][SMB+99 ].randomChildrenCount = 3
mobList[zone][SMB+116].randomChildrenCount = 2
mobList[zone][SMB+107].randomChildrenCount = 3
mobList[zone][SMB+103].randomChildrenCount = 3
mobList[zone][SMB+119].randomChildrenCount = 1
mobList[zone][SMB+111].randomChildrenCount = 3
mobList[zone][SMB+62 ].randomChildrenCount = 3
mobList[zone][SMB+95 ].randomChildrenCount = 3
mobList[zone][SMB+87 ].randomChildrenCount = 3
mobList[zone][SMB+91 ].randomChildrenCount = 3
mobList[zone][SMB+86 ].randomChildrenCount = 0
mobList[zone][SMB+83 ].randomChildrenCount = 1
mobList[zone][SMB+50 ].randomChildrenCount = 2
mobList[zone][SMB+53 ].randomChildrenCount = 2
mobList[zone][SMB+60 ].randomChildrenCount = 1
mobList[zone][SMB+33 ].randomChildrenCount = 2
mobList[zone][SMB+25 ].randomChildrenCount = 0
mobList[zone][SMB+24 ].randomChildrenCount = 0
mobList[zone][SMB+30 ].randomChildrenCount = 2
mobList[zone][SMB+26 ].randomChildrenCount = 3
mobList[zone][SMB+13 ].randomChildrenCount = 3
mobList[zone][SMB+17 ].randomChildrenCount = 4
mobList[zone][SMB+5  ].randomChildrenCount = 2
mobList[zone][SMB+1  ].randomChildrenCount = 1
mobList[zone][SMB+4  ].randomChildrenCount = 0
mobList[zone][SMB+8  ].randomChildrenCount = 3
mobList[zone][SMB+46 ].randomChildrenCount = 2
mobList[zone][SMB+38 ].randomChildrenCount = 3
mobList[zone][SMB+42 ].randomChildrenCount = 3
mobList[zone][SMB+37 ].randomChildrenCount = 0
mobList[zone][SMB+36 ].randomChildrenCount = 0
mobList[zone][SMB+67 ].randomChildrenCount = 2
mobList[zone][SMB+70 ].randomChildrenCount = 1
mobList[zone][SMB+82 ].randomChildrenCount = 0
mobList[zone][SMB+76 ].randomChildrenCount = 2
mobList[zone][SMB+72 ].randomChildrenCount = 2
mobList[zone][SMB+256].randomChildrenCount = 2
mobList[zone][SMB+283].randomChildrenCount = 3
mobList[zone][SMB+168].randomChildrenCount = 2
mobList[zone][SMB+165].randomChildrenCount = 2
mobList[zone][SMB+171].randomChildrenCount = 2
mobList[zone][SMB+174].randomChildrenCount = 2
mobList[zone][SMB+177].randomChildrenCount = 2
mobList[zone][SMB+367].randomChildrenCount = 1
mobList[zone][SMB+372].randomChildrenCount = 0
mobList[zone][SMB+187].randomChildrenCount = 2
mobList[zone][SMB+235].randomChildrenCount = 1
mobList[zone][SMB+370].randomChildrenCount = 0
mobList[zone][SMB+200].randomChildrenCount = 2
mobList[zone][SMB+204].randomChildrenCount = 2
mobList[zone][SMB+181].randomChildrenCount = 2
mobList[zone][SMB+184].randomChildrenCount = 2
mobList[zone][SMB+190].randomChildrenCount = 2
mobList[zone][SMB+197].randomChildrenCount = 2
mobList[zone][SMB+193].randomChildrenCount = 2
mobList[zone][SMB+249].randomChildrenCount = 3
mobList[zone][SMB+245].randomChildrenCount = 3
mobList[zone][SMB+241].randomChildrenCount = 3
mobList[zone][SMB+237].randomChildrenCount = 3
mobList[zone][SMB+230].randomChildrenCount = 3
mobList[zone][SMB+226].randomChildrenCount = 3
mobList[zone][SMB+222].randomChildrenCount = 1
mobList[zone][SMB+225].randomChildrenCount = 0
mobList[zone][SMB+215].randomChildrenCount = 1
mobList[zone][SMB+218].randomChildrenCount = 1
mobList[zone][SMB+212].randomChildrenCount = 1
mobList[zone][SMB+389].randomChildrenCount = 0
mobList[zone][SMB+419].randomChildrenCount = 4
mobList[zone][SMB+424].randomChildrenCount = 4
mobList[zone][SMB+429].randomChildrenCount = 4
mobList[zone][SMB+434].randomChildrenCount = 4
mobList[zone][SMB+399].randomChildrenCount = 3
mobList[zone][SMB+403].randomChildrenCount = 3
mobList[zone][SMB+407].randomChildrenCount = 3
mobList[zone][SMB+411].randomChildrenCount = 3
mobList[zone][SMB+415].randomChildrenCount = 3
mobList[zone][SMB+453].randomChildrenCount = 3
mobList[zone][SMB+460].randomChildrenCount = 4
mobList[zone][SMB+465].randomChildrenCount = 4
mobList[zone][SMB+470].randomChildrenCount = 3
mobList[zone][SMB+474].randomChildrenCount = 3
mobList[zone][SMB+449].randomChildrenCount = 3
mobList[zone][SMB+445].randomChildrenCount = 3
mobList[zone][SMB+441].randomChildrenCount = 3
mobList[zone][SMB+482].randomChildrenCount = 2
mobList[zone][SMB+478].randomChildrenCount = 2
mobList[zone][SMB+491].randomChildrenCount = 3
mobList[zone][SMB+495].randomChildrenCount = 2
mobList[zone][SMB+498].randomChildrenCount = 2
mobList[zone][SMB+501].randomChildrenCount = 3
mobList[zone][SMB+505].randomChildrenCount = 3
mobList[zone][SMB+512].randomChildrenCount = 3
mobList[zone][SMB+516].randomChildrenCount = 2
mobList[zone][SMB+519].randomChildrenCount = 2
mobList[zone][SMB+522].randomChildrenCount = 3
mobList[zone][SMB+487].randomChildrenCount = 2
mobList[zone][SMB+526].randomChildrenCount = 3
mobList[zone][SMB+531].randomChildrenCount = 3

-- set my random children list i will pick from
mobList[zone][SMB+352].randomChildrenList = 1
mobList[zone][SMB+355].randomChildrenList = 1
mobList[zone][SMB+358].randomChildrenList = 1
mobList[zone][SMB+342].randomChildrenList = 3
mobList[zone][SMB+337].randomChildrenList = 3
mobList[zone][SMB+347].randomChildrenList = 3
mobList[zone][SMB+277].randomChildrenList = 1
mobList[zone][SMB+288].randomChildrenList = 1
mobList[zone][SMB+280].randomChildrenList = 1
mobList[zone][SMB+291].randomChildrenList = 1
mobList[zone][SMB+285].randomChildrenList = 1
mobList[zone][SMB+294].randomChildrenList = 1
mobList[zone][SMB+295].randomChildrenList = 1
mobList[zone][SMB+297].randomChildrenList = 1
mobList[zone][SMB+298].randomChildrenList = 1
mobList[zone][SMB+300].randomChildrenList = 1
mobList[zone][SMB+274].randomChildrenList = 1
mobList[zone][SMB+270].randomChildrenList = 1
mobList[zone][SMB+266].randomChildrenList = 1
mobList[zone][SMB+262].randomChildrenList = 1
mobList[zone][SMB+208].randomChildrenList = 1
mobList[zone][SMB+301].randomChildrenList = 1
mobList[zone][SMB+327].randomChildrenList = 1
mobList[zone][SMB+330].randomChildrenList = 1
mobList[zone][SMB+361].randomChildrenList = 1
mobList[zone][SMB+334].randomChildrenList = 1
mobList[zone][SMB+364].randomChildrenList = 1
mobList[zone][SMB+305].randomChildrenList = 1
mobList[zone][SMB+309].randomChildrenList = 1
mobList[zone][SMB+333].randomChildrenList = 1
mobList[zone][SMB+313].randomChildrenList = 1
mobList[zone][SMB+323].randomChildrenList = 1
mobList[zone][SMB+259].randomChildrenList = 1
mobList[zone][SMB+374].randomChildrenList = 1
mobList[zone][SMB+314].randomChildrenList = 1
mobList[zone][SMB+317].randomChildrenList = 1
mobList[zone][SMB+320].randomChildrenList = 1
mobList[zone][SMB+157].randomChildrenList = 1
mobList[zone][SMB+156].randomChildrenList = 3
mobList[zone][SMB+122].randomChildrenList = 1
mobList[zone][SMB+207].randomChildrenList = 1
mobList[zone][SMB+158].randomChildrenList = 3
mobList[zone][SMB+155].randomChildrenList = 1
mobList[zone][SMB+99 ].randomChildrenList = 1
mobList[zone][SMB+116].randomChildrenList = 1
mobList[zone][SMB+107].randomChildrenList = 1
mobList[zone][SMB+103].randomChildrenList = 1
mobList[zone][SMB+119].randomChildrenList = 1
mobList[zone][SMB+111].randomChildrenList = 1
mobList[zone][SMB+62 ].randomChildrenList = 2
mobList[zone][SMB+95 ].randomChildrenList = 1
mobList[zone][SMB+87 ].randomChildrenList = 1
mobList[zone][SMB+91 ].randomChildrenList = 1
mobList[zone][SMB+86 ].randomChildrenList = 1
mobList[zone][SMB+83 ].randomChildrenList = 1
mobList[zone][SMB+53 ].randomChildrenList = 1
mobList[zone][SMB+50 ].randomChildrenList = 1
mobList[zone][SMB+60 ].randomChildrenList = 1
mobList[zone][SMB+33 ].randomChildrenList = 1
mobList[zone][SMB+25 ].randomChildrenList = 1
mobList[zone][SMB+24 ].randomChildrenList = 1
mobList[zone][SMB+30 ].randomChildrenList = 1
mobList[zone][SMB+26 ].randomChildrenList = 1
mobList[zone][SMB+13 ].randomChildrenList = 1
mobList[zone][SMB+17 ].randomChildrenList = 1
mobList[zone][SMB+5  ].randomChildrenList = 1
mobList[zone][SMB+1  ].randomChildrenList = 1
mobList[zone][SMB+4  ].randomChildrenList = 1
mobList[zone][SMB+8  ].randomChildrenList = 1
mobList[zone][SMB+46 ].randomChildrenList = 1
mobList[zone][SMB+38 ].randomChildrenList = 1
mobList[zone][SMB+42 ].randomChildrenList = 1
mobList[zone][SMB+37 ].randomChildrenList = 1
mobList[zone][SMB+36 ].randomChildrenList = 1
mobList[zone][SMB+67 ].randomChildrenList = 1
mobList[zone][SMB+70 ].randomChildrenList = 1
mobList[zone][SMB+82 ].randomChildrenList = 1
mobList[zone][SMB+76 ].randomChildrenList = 1
mobList[zone][SMB+72 ].randomChildrenList = 1
mobList[zone][SMB+256].randomChildrenList = 1
mobList[zone][SMB+283].randomChildrenList = 1
mobList[zone][SMB+168].randomChildrenList = 1
mobList[zone][SMB+165].randomChildrenList = 1
mobList[zone][SMB+171].randomChildrenList = 1
mobList[zone][SMB+174].randomChildrenList = 1
mobList[zone][SMB+177].randomChildrenList = 1
mobList[zone][SMB+367].randomChildrenList = 1
mobList[zone][SMB+372].randomChildrenList = 1
mobList[zone][SMB+187].randomChildrenList = 1
mobList[zone][SMB+235].randomChildrenList = 1
mobList[zone][SMB+370].randomChildrenList = 1
mobList[zone][SMB+200].randomChildrenList = 1
mobList[zone][SMB+204].randomChildrenList = 1
mobList[zone][SMB+181].randomChildrenList = 1
mobList[zone][SMB+184].randomChildrenList = 1
mobList[zone][SMB+190].randomChildrenList = 1
mobList[zone][SMB+197].randomChildrenList = 1
mobList[zone][SMB+193].randomChildrenList = 1
mobList[zone][SMB+249].randomChildrenList = 1
mobList[zone][SMB+245].randomChildrenList = 1
mobList[zone][SMB+241].randomChildrenList = 1
mobList[zone][SMB+237].randomChildrenList = 1
mobList[zone][SMB+230].randomChildrenList = 1
mobList[zone][SMB+226].randomChildrenList = 1
mobList[zone][SMB+222].randomChildrenList = 1
mobList[zone][SMB+225].randomChildrenList = 1
mobList[zone][SMB+215].randomChildrenList = 1
mobList[zone][SMB+218].randomChildrenList = 1
mobList[zone][SMB+212].randomChildrenList = 1
mobList[zone][SMB+389].randomChildrenList = 1
mobList[zone][SMB+419].randomChildrenList = 1
mobList[zone][SMB+424].randomChildrenList = 1
mobList[zone][SMB+429].randomChildrenList = 1
mobList[zone][SMB+434].randomChildrenList = 1
mobList[zone][SMB+399].randomChildrenList = 1
mobList[zone][SMB+403].randomChildrenList = 1
mobList[zone][SMB+407].randomChildrenList = 1
mobList[zone][SMB+411].randomChildrenList = 1
mobList[zone][SMB+415].randomChildrenList = 1
mobList[zone][SMB+453].randomChildrenList = 1
mobList[zone][SMB+460].randomChildrenList = 1
mobList[zone][SMB+465].randomChildrenList = 1
mobList[zone][SMB+470].randomChildrenList = 1
mobList[zone][SMB+474].randomChildrenList = 1
mobList[zone][SMB+449].randomChildrenList = 1
mobList[zone][SMB+445].randomChildrenList = 1
mobList[zone][SMB+441].randomChildrenList = 1
mobList[zone][SMB+482].randomChildrenList = 1
mobList[zone][SMB+478].randomChildrenList = 1
mobList[zone][SMB+491].randomChildrenList = 1
mobList[zone][SMB+495].randomChildrenList = 1
mobList[zone][SMB+498].randomChildrenList = 1
mobList[zone][SMB+501].randomChildrenList = 1
mobList[zone][SMB+505].randomChildrenList = 3
mobList[zone][SMB+512].randomChildrenList = 1
mobList[zone][SMB+516].randomChildrenList = 1
mobList[zone][SMB+519].randomChildrenList = 1
mobList[zone][SMB+522].randomChildrenList = 1
mobList[zone][SMB+487].randomChildrenList = 1
mobList[zone][SMB+526].randomChildrenList = 1
mobList[zone][SMB+531].randomChildrenList = 1

-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] = 
{
    [1] = -- all jobs except BST (the main list)
    {
        17539075,
        17539078,
        17539079,
        17539080,
        17539081,
        17539082,
        17539083,
        17539085,
        17539086,
        17539087,
        17539088,
        17539090,
        17539091,
        17539092,
        17539093,
        17539094,
        17539095,
        17539096,
        17539097,
        17539098,
        17539100,
        17539101,
        17539102,
        17539103,
        17539104,
        17539105,
        17539107,
        17539108,
        17539109,
        17539112,
        17539114,
        17539115,
        17539116,
        17539117,
        17539121,
        17539122,
        17539123,
        17539124,
        17539125,
        17539126,
        17539127,
        17539128,
        17539129,
        17539130,
        17539131,
        17539132,
        17539133,
        17539134,
        17539135,
        17539136,
        17539137,
        17539138,
        17539139,
        17539140,
        17539141,
        17539145,
        17539146,
        17539150,
        17539151,
        17539152,
        17539153,
        17539154,
        17539155,
        17539156,
        17539157,
        17539158,
        17539159,
        17539160,
        17539164,
        17539166,
        17539168,
        17539169,
        17539170,
        17539174,
        17539175,
        17539176,
        17539179,
        17539180,
        17539181,
        17539182,
        17539183,
        17539184,
        17539185,
        17539186,
        17539187,
        17539189,
        17539191,
        17539192,
        17539193,
        17539194,
        17539195,
        17539196,
        17539199,
        17539201,
        17539202,
        17539203,
        17539204,
        17539205,
        17539206,
        17539207,
        17539208,
        17539209,
        17539211,
        17539215,
        17539216,
        17539217,
        17539218,
        17539219,
        17539220,
        17539221,
        17539222,
        17539224,
        17539225,
        17539226,
        17539230,
        17539231,
        17539232,
        17539233,
        17539239,
        17539241,
        17539242,
        17539243,
        17539244,
        17539245,
        17539246,
        17539249,
        17539251,
        17539252,
        17539254,
        17539255,
        17539256,
        17539257,
        17539258,
        17539259,
        17539260,
        17539261,
        17539262,
        17539263,
        17539264,
        17539265,
        17539268,
        17539269,
        17539270,
        17539271,
        17539272,
        17539276,
        17539277,
        17539278,
        17539279,
        17539280,
        17539281,
        17539282,
        17539283,
        17539288,
        17539289,
        17539290,
        17539291,
        17539295,
        17539296,
        17539297,
        17539298,
        17539299,
        17539300,
        17539301,
        17539302,
        17539303,
        17539304,
        17539305,
    },
    [2] = -- all jobs including BST and their breakga scorps (only statues in the starting area and near AH) BST is 2x likely
    {
        17539075,
        17539076,
        17539076,
        17539078,
        17539079,
        17539080,
        17539081,
        17539082,
        17539083,
        17539085,
        17539086,
        17539087,
        17539088,
        17539090,
        17539091,
        17539092,
        17539093,
        17539094,
        17539095,
        17539096,
        17539097,
        17539098,
        17539100,
        17539101,
        17539102,
        17539103,
        17539104,
        17539105,
        17539107,
        17539108,
        17539109,
        17539110,
        17539110,
        17539112,
        17539114,
        17539115,
        17539116,
        17539117,
        17539121,
        17539122,
        17539123,
        17539124,
        17539125,
        17539126,
        17539127,
        17539128,
        17539129,
        17539130,
        17539131,
        17539132,
        17539133,
        17539134,
        17539135,
        17539136,
        17539137,
        17539138,
        17539139,
        17539140,
        17539141,
        17539145,
        17539146,
        17539150,
        17539151,
        17539152,
        17539153,
        17539154,
        17539155,
        17539156,
        17539157,
        17539158,
        17539159,
        17539160,
        17539164,
        17539166,
        17539168,
        17539169,
        17539170,
        17539174,
        17539175,
        17539176,
        17539177,
        17539177,
        17539179,
        17539180,
        17539181,
        17539182,
        17539183,
        17539184,
        17539185,
        17539186,
        17539187,
        17539189,
        17539191,
        17539192,
        17539193,
        17539194,
        17539195,
        17539196,
        17539197,
        17539197,
        17539199,
        17539201,
        17539202,
        17539203,
        17539204,
        17539205,
        17539206,
        17539207,
        17539208,
        17539209,
        17539211,
        17539213,
        17539213,
        17539215,
        17539216,
        17539217,
        17539218,
        17539219,
        17539220,
        17539221,
        17539222,
        17539224,
        17539225,
        17539226,
        17539230,
        17539231,
        17539232,
        17539233,
        17539237,
        17539237,
        17539239,
        17539241,
        17539242,
        17539243,
        17539244,
        17539245,
        17539246,
        17539247,
        17539247,
        17539249,
        17539251,
        17539252,
        17539254,
        17539255,
        17539256,
        17539257,
        17539258,
        17539259,
        17539260,
        17539261,
        17539262,
        17539263,
        17539264,
        17539265,
        17539268,
        17539269,
        17539270,
        17539271,
        17539272,
        17539276,
        17539277,
        17539278,
        17539279,
        17539280,
        17539281,
        17539282,
        17539283,
        17539284,
        17539284,
        17539288,
        17539289,
        17539290,
        17539291,
        17539295,
        17539296,
        17539297,
        17539298,
        17539299,
        17539300,
        17539301,
        17539302,
        17539303,
        17539304,
        17539305,
    },
    [3] = -- BST only
    {
        17539076,
        17539110,
        17539177,
        17539197,
        17539213,
        17539237,
        17539247,
        17539284
    }
    
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] = 
{
    
}
