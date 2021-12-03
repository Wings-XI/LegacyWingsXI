-----------------------------------
--
-- Dynamis-Jeuno
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_JEUNO
local DMB = 17547264 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17547664 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] =
{
    [DMB+1  ] = { id = DMB+1   }, -- Goblin_Golem
    [DMB+2  ] = { id = DMB+2   }, -- Vanguard_Smithy
    [DMB+3  ] = { id = DMB+3   }, -- Vanguard_Welldigger
    [DMB+4  ] = { id = DMB+4   }, -- Vanguard_Pathfinder
    [DMB+5  ] = { id = DMB+5   }, -- Vanguards_Slime
    [DMB+6  ] = { id = DMB+6   }, -- Vanguard_Shaman
    [DMB+7  ] = { id = DMB+7   }, -- Vanguard_Enchanter
    [DMB+8  ] = { id = DMB+8   }, -- Vanguard_Pathfinder
    [DMB+9  ] = { id = DMB+9   }, -- Vanguards_Slime
    [DMB+10 ] = { id = DMB+10  }, -- Vanguard_Tinkerer
    [DMB+11 ] = { id = DMB+11  }, -- Vanguard_Armorer
    [DMB+12 ] = { id = DMB+12  }, -- Vanguard_Hitman
    [DMB+13 ] = { id = DMB+13  }, -- Gabblox_Magpietongue
    [DMB+14 ] = { id = DMB+14  }, -- Vanguard_Pitfighter
    [DMB+15 ] = { id = DMB+15  }, -- Vanguard_Alchemist
    [DMB+16 ] = { id = DMB+16  }, -- Vanguard_Maestro
    [DMB+17 ] = { id = DMB+17  }, -- Vanguard_Tinkerer
    [DMB+18 ] = { id = DMB+18  }, -- Vanguard_Dragontamer
    [DMB+19 ] = { id = DMB+19  }, -- Vanguards_Wyvern
    [DMB+20 ] = { id = DMB+20  }, -- Vanguard_Enchanter
    [DMB+21 ] = { id = DMB+21  }, -- Vanguard_Ambusher
    [DMB+22 ] = { id = DMB+22  }, -- Vanguard_Necromancer
    [DMB+23 ] = { id = DMB+23  }, -- Vanguards_Avatar
    [DMB+24 ] = { id = DMB+24  }, -- Vanguard_Ronin
    [DMB+25 ] = { id = DMB+25  }, -- Vanguard_Armorer
    [DMB+26 ] = { id = DMB+26  }, -- Vanguard_Hitman
    [DMB+27 ] = { id = DMB+27  }, -- Tufflix_Loglimbs
    [DMB+28 ] = { id = DMB+28  }, -- Vanguard_Armorer
    [DMB+29 ] = { id = DMB+29  }, -- Vanguard_Hitman
    [DMB+30 ] = { id = DMB+30  }, -- Cloktix_Longnail
    [DMB+31 ] = { id = DMB+31  }, -- Goblin_Replica
    [DMB+32 ] = { id = DMB+32  }, -- Goblin_Replica
    [DMB+33 ] = { id = DMB+33  }, -- Goblin_Replica
    [DMB+34 ] = { id = DMB+34  }, -- Smeltix_Thickhide
    [DMB+35 ] = { id = DMB+35  }, -- Jabkix_Pigeonpecs
    [DMB+36 ] = { id = DMB+36  }, -- Wasabix_Callusdigit
    [DMB+37 ] = { id = DMB+37  }, -- Goblin_Statue
    [DMB+38 ] = { id = DMB+38  }, -- Goblin_Statue
    [DMB+39 ] = { id = DMB+39  }, -- Goblin_Statue
    [DMB+40 ] = { id = DMB+40  }, -- Vanguard_Smithy
    [DMB+41 ] = { id = DMB+41  }, -- Vanguard_Welldigger
    [DMB+42 ] = { id = DMB+42  }, -- Vanguard_Ambusher
    [DMB+43 ] = { id = DMB+43  }, -- Vanguard_Armorer
    [DMB+44 ] = { id = DMB+44  }, -- Vanguard_Alchemist
    [DMB+45 ] = { id = DMB+45  }, -- Vanguard_Welldigger
    [DMB+46 ] = { id = DMB+46  }, -- Vanguard_Enchanter
    [DMB+47 ] = { id = DMB+47  }, -- Hermitrix_Toothrot
    [DMB+48 ] = { id = DMB+48  }, -- Wyrmwix_Snakespecs
    [DMB+49 ] = { id = DMB+49  }, -- Vanguards_Wyvern
    [DMB+50 ] = { id = DMB+50  }, -- Vanguard_Smithy
    [DMB+51 ] = { id = DMB+51  }, -- Vanguard_Pitfighter
    [DMB+52 ] = { id = DMB+52  }, -- Vanguard_Ronin
    [DMB+53 ] = { id = DMB+53  }, -- Vanguard_Necromancer
    [DMB+54 ] = { id = DMB+54  }, -- Vanguards_Avatar
    [DMB+55 ] = { id = DMB+55  }, -- Vanguard_Alchemist
    [DMB+56 ] = { id = DMB+56  }, -- Vanguard_Shaman
    [DMB+57 ] = { id = DMB+57  }, -- Vanguard_Enchanter
    [DMB+58 ] = { id = DMB+58  }, -- Morgmox_Moldnoggin
    [DMB+59 ] = { id = DMB+59  }, -- Vanguards_Avatar
    [DMB+60 ] = { id = DMB+60  }, -- Sparkspox_Sweatbrow
    [DMB+61 ] = { id = DMB+61  }, -- Vanguard_Welldigger
    [DMB+62 ] = { id = DMB+62  }, -- Vanguard_Maestro
    [DMB+63 ] = { id = DMB+63  }, -- Vanguard_Necromancer
    [DMB+64 ] = { id = DMB+64  }, -- Vanguards_Avatar
    [DMB+65 ] = { id = DMB+65  }, -- Sparkspox_Sweatbrow
    [DMB+66 ] = { id = DMB+66  }, -- Vanguard_Ronin
    [DMB+67 ] = { id = DMB+67  }, -- Vanguard_Maestro
    [DMB+68 ] = { id = DMB+68  }, -- Vanguard_Dragontamer
    [DMB+69 ] = { id = DMB+69  }, -- Vanguards_Wyvern
    [DMB+70 ] = { id = DMB+70  }, -- Vanguard_Alchemist
    [DMB+71 ] = { id = DMB+71  }, -- Vanguard_Shaman
    [DMB+72 ] = { id = DMB+72  }, -- Vanguard_Enchanter
    [DMB+73 ] = { id = DMB+73  }, -- Morgmox_Moldnoggin
    [DMB+74 ] = { id = DMB+74  }, -- Vanguards_Avatar
    [DMB+75 ] = { id = DMB+75  }, -- Vanguard_Welldigger
    [DMB+76 ] = { id = DMB+76  }, -- Vanguard_Ambusher
    [DMB+77 ] = { id = DMB+77  }, -- Vanguard_Pathfinder
    [DMB+78 ] = { id = DMB+78  }, -- Vanguards_Slime
    [DMB+79 ] = { id = DMB+79  }, -- Vanguard_Pitfighter
    [DMB+80 ] = { id = DMB+80  }, -- Vanguard_Enchanter
    [DMB+81 ] = { id = DMB+81  }, -- Vanguard_Maestro
    [DMB+82 ] = { id = DMB+82  }, -- Vanguard_Ambusher
    [DMB+83 ] = { id = DMB+83  }, -- Vanguard_Ambusher
    [DMB+84 ] = { id = DMB+84  }, -- Vanguard_Dragontamer
    [DMB+85 ] = { id = DMB+85  }, -- Vanguards_Wyvern
    [DMB+86 ] = { id = DMB+86  }, -- Vanguard_Pitfighter
    [DMB+87 ] = { id = DMB+87  }, -- Vanguard_Alchemist
    [DMB+88 ] = { id = DMB+88  }, -- Vanguard_Tinkerer
    [DMB+89 ] = { id = DMB+89  }, -- Vanguard_Armorer
    [DMB+90 ] = { id = DMB+90  }, -- Vanguard_Hitman
    [DMB+91 ] = { id = DMB+91  }, -- Elixmix_Hooknose
    [DMB+92 ] = { id = DMB+92  }, -- Bandrix_Rockjaw
    [DMB+93 ] = { id = DMB+93  }, -- Vanguard_Smithy
    [DMB+94 ] = { id = DMB+94  }, -- Vanguard_Shaman
    [DMB+95 ] = { id = DMB+95  }, -- Vanguard_Maestro
    [DMB+96 ] = { id = DMB+96  }, -- Vanguard_Welldigger
    [DMB+97 ] = { id = DMB+97  }, -- Vanguard_Tinkerer
    [DMB+98 ] = { id = DMB+98  }, -- Vanguard_Ambusher
    [DMB+99 ] = { id = DMB+99  }, -- Vanguard_Smithy
    [DMB+100] = { id = DMB+100 }, -- Vanguard_Armorer
    [DMB+101] = { id = DMB+101 }, -- Vanguard_Pathfinder
    [DMB+102] = { id = DMB+102 }, -- Vanguards_Slime
    [DMB+103] = { id = DMB+103 }, -- Vanguard_Ronin
    [DMB+104] = { id = DMB+104 }, -- Vanguard_Hitman
    [DMB+105] = { id = DMB+105 }, -- Vanguard_Pathfinder
    [DMB+106] = { id = DMB+106 }, -- Vanguards_Slime
    [DMB+107] = { id = DMB+107 }, -- Vanguard_Armorer
    [DMB+108] = { id = DMB+108 }, -- Vanguard_Shaman
    [DMB+109] = { id = DMB+109 }, -- Vanguard_Necromancer
    [DMB+110] = { id = DMB+110 }, -- Vanguards_Avatar
    [DMB+111] = { id = DMB+111 }, -- Vanguard_Pitfighter
    [DMB+112] = { id = DMB+112 }, -- Vanguard_Tinkerer
    [DMB+113] = { id = DMB+113 }, -- Buffrix_Eargone
    [DMB+114] = { id = DMB+114 }, -- Humnox_Drumbelly
    [DMB+115] = { id = DMB+115 }, -- Vanguard_Smithy
    [DMB+116] = { id = DMB+116 }, -- Vanguard_Alchemist
    [DMB+117] = { id = DMB+117 }, -- Buffrix_Eargone
    [DMB+118] = { id = DMB+118 }, -- Humnox_Drumbelly
    [DMB+119] = { id = DMB+119 }, -- Vanguard_Ronin
    [DMB+120] = { id = DMB+120 }, -- Vanguard_Hitman
    [DMB+121] = { id = DMB+121 }, -- Vanguard_Alchemist
    [DMB+122] = { id = DMB+122 }, -- Vanguard_Maestro
    [DMB+123] = { id = DMB+123 }, -- Buffrix_Eargone
    [DMB+124] = { id = DMB+124 }, -- Humnox_Drumbelly
    [DMB+125] = { id = DMB+125 }, -- Goblin_Statue
    [DMB+126] = { id = DMB+126 }, -- Goblin_Statue
    [DMB+127] = { id = DMB+127 }, -- Goblin_Replica
    [DMB+128] = { id = DMB+128 }, -- Goblin_Replica
    [DMB+129] = { id = DMB+129 }, -- Goblin_Replica
    [DMB+130] = { id = DMB+130 }, -- Ticktox_Beadyeyes
    [DMB+131] = { id = DMB+131 }, -- Lurklox_Dhalmelneck
    [DMB+132] = { id = DMB+132 }, -- Trailblix_Goatmug
    [DMB+133] = { id = DMB+133 }, -- Vanguards_Slime
    [DMB+134] = { id = DMB+134 }, -- Vanguard_Smithy
    [DMB+135] = { id = DMB+135 }, -- Vanguard_Pitfighter
    [DMB+136] = { id = DMB+136 }, -- Vanguard_Welldigger
    [DMB+137] = { id = DMB+137 }, -- Vanguard_Alchemist
    [DMB+138] = { id = DMB+138 }, -- Kikklix_Longlegs
    [DMB+139] = { id = DMB+139 }, -- Vanguard_Smithy
    [DMB+140] = { id = DMB+140 }, -- Vanguard_Pitfighter
    [DMB+141] = { id = DMB+141 }, -- Vanguard_Welldigger
    [DMB+142] = { id = DMB+142 }, -- Vanguard_Shaman
    [DMB+143] = { id = DMB+143 }, -- Kikklix_Longlegs
    [DMB+144] = { id = DMB+144 }, -- Vanguard_Smithy
    [DMB+145] = { id = DMB+145 }, -- Vanguard_Pitfighter
    [DMB+146] = { id = DMB+146 }, -- Vanguard_Welldigger
    [DMB+147] = { id = DMB+147 }, -- Vanguard_Enchanter
    [DMB+148] = { id = DMB+148 }, -- Vanguard_Alchemist
    [DMB+149] = { id = DMB+149 }, -- Vanguard_Shaman
    [DMB+150] = { id = DMB+150 }, -- Vanguard_Smithy
    [DMB+151] = { id = DMB+151 }, -- Vanguard_Pitfighter
    [DMB+152] = { id = DMB+152 }, -- Vanguard_Alchemist
    [DMB+153] = { id = DMB+153 }, -- Vanguard_Shaman
    [DMB+154] = { id = DMB+154 }, -- Vanguard_Enchanter
    [DMB+155] = { id = DMB+155 }, -- Vanguard_Welldigger
    [DMB+156] = { id = DMB+156 }, -- Goblin_Statue
    [DMB+157] = { id = DMB+157 }, -- Goblin_Replica
    [DMB+158] = { id = DMB+158 }, -- Goblin_Replica
    [DMB+159] = { id = DMB+159 }, -- Goblin_Replica
    [DMB+160] = { id = DMB+160 }, -- Karashix_Swollenskull
    [DMB+161] = { id = DMB+161 }, -- Vanguard_Tinkerer
    [DMB+162] = { id = DMB+162 }, -- Vanguard_Dragontamer
    [DMB+163] = { id = DMB+163 }, -- Vanguards_Wyvern
    [DMB+164] = { id = DMB+164 }, -- Vanguard_Pathfinder
    [DMB+165] = { id = DMB+165 }, -- Vanguards_Slime
    [DMB+166] = { id = DMB+166 }, -- Vanguard_Maestro
    [DMB+167] = { id = DMB+167 }, -- Vanguard_Ronin
    [DMB+168] = { id = DMB+168 }, -- Vanguard_Armorer
    [DMB+169] = { id = DMB+169 }, -- Vanguard_Maestro
    [DMB+170] = { id = DMB+170 }, -- Vanguard_Tinkerer
    [DMB+171] = { id = DMB+171 }, -- Vanguard_Ronin
    [DMB+172] = { id = DMB+172 }, -- Vanguard_Necromancer
    [DMB+173] = { id = DMB+173 }, -- Vanguards_Avatar
    [DMB+174] = { id = DMB+174 }, -- Mortilox_Wartpaws
    [DMB+175] = { id = DMB+175 }, -- Vanguards_Avatar
    [DMB+176] = { id = DMB+176 }, -- Karashix_Swollenskull
    [DMB+177] = { id = DMB+177 }, -- Vanguard_Tinkerer
    [DMB+178] = { id = DMB+178 }, -- Vanguard_Ronin
    [DMB+179] = { id = DMB+179 }, -- Vanguard_Necromancer
    [DMB+180] = { id = DMB+180 }, -- Vanguards_Avatar
    [DMB+181] = { id = DMB+181 }, -- Vanguard_Maestro
    [DMB+182] = { id = DMB+182 }, -- Vanguard_Ronin
    [DMB+183] = { id = DMB+183 }, -- Vanguard_Armorer
    [DMB+184] = { id = DMB+184 }, -- Vanguard_Maestro
    [DMB+185] = { id = DMB+185 }, -- Vanguard_Tinkerer
    [DMB+186] = { id = DMB+186 }, -- Vanguard_Pathfinder
    [DMB+187] = { id = DMB+187 }, -- Vanguards_Slime
    [DMB+188] = { id = DMB+188 }, -- Vanguard_Dragontamer
    [DMB+189] = { id = DMB+189 }, -- Vanguards_Wyvern
    [DMB+190] = { id = DMB+190 }, -- Rutrix_Hamgams
    [DMB+191] = { id = DMB+191 }, -- Vanguards_Slime
    [DMB+192] = { id = DMB+192 }, -- Goblin_Replica
    [DMB+193] = { id = DMB+193 }, -- Goblin_Replica
    [DMB+194] = { id = DMB+194 }, -- Goblin_Replica
    [DMB+195] = { id = DMB+195 }, -- Vanguard_Ambusher
    [DMB+196] = { id = DMB+196 }, -- Vanguard_Hitman
    [DMB+197] = { id = DMB+197 }, -- Vanguard_Ambusher
    [DMB+198] = { id = DMB+198 }, -- Vanguard_Hitman
    [DMB+199] = { id = DMB+199 }, -- Vanguard_Ambusher
    [DMB+200] = { id = DMB+200 }, -- Vanguard_Hitman
    [DMB+201] = { id = DMB+201 }, -- Vanguard_Ambusher
    [DMB+202] = { id = DMB+202 }, -- Vanguard_Hitman
    [DMB+203] = { id = DMB+203 }, -- Goblin_Statue
    [DMB+204] = { id = DMB+204 }, -- Snypestix_Eaglebeak
    [DMB+205] = { id = DMB+205 }, -- Vanguard_Smithy
    [DMB+206] = { id = DMB+206 }, -- Vanguard_Pitfighter
    [DMB+207] = { id = DMB+207 }, -- Vanguard_Welldigger
    [DMB+208] = { id = DMB+208 }, -- Anvilix_Sootwrists
    [DMB+209] = { id = DMB+209 }, -- Bootrix_Jaggedelbow
    [DMB+210] = { id = DMB+210 }, -- Mobpix_Mucousmouth
    [DMB+211] = { id = DMB+211 }, -- Vanguard_Alchemist
    [DMB+212] = { id = DMB+212 }, -- Vanguard_Shaman
    [DMB+213] = { id = DMB+213 }, -- Vanguard_Enchanter
    [DMB+214] = { id = DMB+214 }, -- Distilix_Stickytoes
    [DMB+215] = { id = DMB+215 }, -- Eremix_Snottynostril
    [DMB+216] = { id = DMB+216 }, -- Jabbrox_Grannyguise
    [DMB+217] = { id = DMB+217 }, -- Vanguard_Armorer
    [DMB+218] = { id = DMB+218 }, -- Vanguard_Tinkerer
    [DMB+219] = { id = DMB+219 }, -- Vanguard_Pathfinder
    [DMB+220] = { id = DMB+220 }, -- Vanguards_Slime
    [DMB+221] = { id = DMB+221 }, -- Scruffix_Shaggychest
    [DMB+222] = { id = DMB+222 }, -- Tymexox_Ninefingers
    [DMB+223] = { id = DMB+223 }, -- Blazox_Boneybod
    [DMB+224] = { id = DMB+224 }, -- Vanguards_Slime
    [DMB+225] = { id = DMB+225 }, -- Vanguard_Ambusher
    [DMB+226] = { id = DMB+226 }, -- Prowlox_Barrelbelly
    [DMB+227] = { id = DMB+227 }, -- Vanguard_Hitman
    [DMB+228] = { id = DMB+228 }, -- Slystix_Megapeepers
    [DMB+229] = { id = DMB+229 }, -- Quicktrix_Hexhands
    [DMB+230] = { id = DMB+230 }, -- Feralox_Honeylips
    [DMB+231] = { id = DMB+231 }, -- Feraloxs_Slime
    [DMB+232] = { id = DMB+232 }, -- Scourquix_Scaleskin
    [DMB+233] = { id = DMB+233 }, -- Scourquixs_Wyvern
    [DMB+234] = { id = DMB+234 }, -- Wilywox_Tenderpalm
    [DMB+235] = { id = DMB+235 }, -- Arch_Goblin_Golem
    [SMB+0  ] = { id = SMB+0   }, -- Goblin Replica
    [SMB+1  ] = { id = SMB+1   }, -- Goblin Replica
    [SMB+2  ] = { id = SMB+2   }, -- Goblin Replica
    [SMB+3  ] = { id = SMB+3   }, -- Goblin Replica
    [SMB+4  ] = { id = SMB+4   }, -- Goblin Replica
    [SMB+5  ] = { id = SMB+5   }, -- Goblin Replica
    [SMB+6  ] = { id = SMB+6   }, -- Goblin Replica
    [SMB+7  ] = { id = SMB+7   }, -- Goblin Replica
    [SMB+8  ] = { id = SMB+8   }, -- Goblin Replica
    [SMB+9  ] = { id = SMB+9   }, -- Goblin Replica
    [SMB+10 ] = { id = SMB+10  }, -- Goblin Replica
    [SMB+11 ] = { id = SMB+11  }, -- Goblin Replica
    [SMB+12 ] = { id = SMB+12  }, -- Goblin Replica
    [SMB+13 ] = { id = SMB+13  }, -- Goblin Replica
    [SMB+14 ] = { id = SMB+14  }, -- Goblin Replica
    [SMB+15 ] = { id = SMB+15  }, -- Goblin Replica
    [SMB+16 ] = { id = SMB+16  }, -- Goblin Replica
    [SMB+17 ] = { id = SMB+17  }, -- Goblin Replica
    [SMB+18 ] = { id = SMB+18  }, -- Goblin Replica
    [SMB+19 ] = { id = SMB+19  }, -- Goblin Replica
    [SMB+20 ] = { id = SMB+20  }, -- Goblin Replica
    [SMB+21 ] = { id = SMB+21  }, -- Goblin Replica
    [SMB+22 ] = { id = SMB+22  }, -- Goblin Replica
    [SMB+23 ] = { id = SMB+23  }, -- Goblin Replica
    [SMB+24 ] = { id = SMB+24  }, -- Goblin Replica
    [SMB+25 ] = { id = SMB+25  }, -- Goblin Replica
    [SMB+26 ] = { id = SMB+26  }, -- Goblin Replica
    [SMB+27 ] = { id = SMB+27  }, -- Goblin Replica
    [SMB+28 ] = { id = SMB+28  }, -- Goblin Replica
    [SMB+29 ] = { id = SMB+29  }, -- Goblin Replica
    [SMB+30 ] = { id = SMB+30  }, -- Goblin Replica
    [SMB+31 ] = { id = SMB+31  }, -- Goblin Replica
    [SMB+32 ] = { id = SMB+32  }, -- Goblin Replica
    [SMB+33 ] = { id = SMB+33  }, -- Goblin Replica
    [SMB+34 ] = { id = SMB+34  }, -- Goblin Replica
    [SMB+35 ] = { id = SMB+35  }, -- Goblin Replica
    [SMB+36 ] = { id = SMB+36  }, -- Goblin Replica
    [SMB+37 ] = { id = SMB+37  }, -- Goblin Replica
    [SMB+38 ] = { id = SMB+38  }, -- Goblin Replica
    [SMB+39 ] = { id = SMB+39  }, -- Goblin Replica
    [SMB+40 ] = { id = SMB+40  }, -- Goblin Replica
    [SMB+41 ] = { id = SMB+41  }, -- Goblin Replica
    [SMB+42 ] = { id = SMB+42  }, -- Goblin Replica
    [SMB+43 ] = { id = SMB+43  }, -- Goblin Replica
    [SMB+44 ] = { id = SMB+44  }, -- Goblin Replica
    [SMB+45 ] = { id = SMB+45  }, -- Goblin Replica
    [SMB+46 ] = { id = SMB+46  }, -- Goblin Replica
    [SMB+47 ] = { id = SMB+47  }, -- Goblin Replica
    [SMB+48 ] = { id = SMB+48  }, -- Goblin Replica
    [SMB+49 ] = { id = SMB+49  }, -- Goblin Replica
    [SMB+50 ] = { id = SMB+50  }, -- Goblin Replica
    [SMB+51 ] = { id = SMB+51  }, -- Goblin Replica
    [SMB+52 ] = { id = SMB+52  }, -- Goblin Replica
    [SMB+53 ] = { id = SMB+53  }, -- Goblin Replica
    [SMB+54 ] = { id = SMB+54  }, -- Goblin Replica
    [SMB+55 ] = { id = SMB+55  }, -- Goblin Replica
    [SMB+56 ] = { id = SMB+56  }, -- Goblin Replica
    [SMB+57 ] = { id = SMB+57  }, -- Goblin Replica
    [SMB+58 ] = { id = SMB+58  }, -- Goblin Replica
    [SMB+59 ] = { id = SMB+59  }, -- Goblin Replica
    [SMB+60 ] = { id = SMB+60  }, -- Goblin Replica
    [SMB+61 ] = { id = SMB+61  }, -- Goblin Replica
    [SMB+62 ] = { id = SMB+62  }, -- Goblin Replica
    [SMB+63 ] = { id = SMB+63  }, -- Goblin Replica
    [SMB+64 ] = { id = SMB+64  }, -- Goblin Replica
    [SMB+65 ] = { id = SMB+65  }, -- Goblin Replica
    [SMB+66 ] = { id = SMB+66  }, -- Goblin Replica
    [SMB+67 ] = { id = SMB+67  }, -- Goblin Replica
    [SMB+68 ] = { id = SMB+68  }, -- Goblin Replica
    [SMB+69 ] = { id = SMB+69  }, -- Goblin Replica
    [SMB+70 ] = { id = SMB+70  }, -- Goblin Replica
    [SMB+71 ] = { id = SMB+71  }, -- Goblin Replica
    [SMB+72 ] = { id = SMB+72  }, -- Goblin Replica
    [SMB+73 ] = { id = SMB+73  }, -- Goblin Replica
    [SMB+74 ] = { id = SMB+74  }, -- Goblin Replica
    [SMB+75 ] = { id = SMB+75  }, -- Goblin Replica
    [SMB+76 ] = { id = SMB+76  }, -- Goblin Replica
    [SMB+77 ] = { id = SMB+77  }, -- Goblin Replica
    [SMB+78 ] = { id = SMB+78  }, -- Goblin Replica
    [SMB+79 ] = { id = SMB+79  }, -- Goblin Replica
    [SMB+80 ] = { id = SMB+80  }, -- Goblin Replica
    [SMB+81 ] = { id = SMB+81  }, -- Goblin Replica
    [SMB+82 ] = { id = SMB+82  }, -- Goblin Replica
    [SMB+83 ] = { id = SMB+83  }, -- Goblin Replica
    [SMB+84 ] = { id = SMB+84  }, -- Goblin Replica
    [SMB+85 ] = { id = SMB+85  }, -- Goblin Replica
    [SMB+86 ] = { id = SMB+86  }, -- Goblin Replica
    [SMB+87 ] = { id = SMB+87  }, -- Goblin Replica
    [SMB+88 ] = { id = SMB+88  }, -- Goblin Replica
    [SMB+89 ] = { id = SMB+89  }, -- Goblin Replica
    [SMB+90 ] = { id = SMB+90  }, -- Goblin Replica
    [SMB+91 ] = { id = SMB+91  }, -- Goblin Replica
    [SMB+92 ] = { id = SMB+92  }, -- Goblin Replica
    [SMB+93 ] = { id = SMB+93  }, -- Goblin Replica
    [SMB+94 ] = { id = SMB+94  }, -- Goblin Replica
    [SMB+95 ] = { id = SMB+95  }, -- Goblin Replica
    [SMB+96 ] = { id = SMB+96  }, -- Goblin Replica
    [SMB+97 ] = { id = SMB+97  }, -- Goblin Replica
    [SMB+98 ] = { id = SMB+98  }, -- Goblin Replica
    [SMB+99 ] = { id = SMB+99  }, -- Goblin Replica
    [SMB+100] = { id = SMB+100 }, -- Goblin Replica
    [SMB+101] = { id = SMB+101 }, -- Goblin Replica
    [SMB+102] = { id = SMB+102 }, -- Goblin Replica
    [SMB+103] = { id = SMB+103 }, -- Goblin Replica
    [SMB+104] = { id = SMB+104 }, -- Goblin Replica
    [SMB+105] = { id = SMB+105 }, -- Goblin Replica
    [SMB+106] = { id = SMB+106 }, -- Goblin Replica
    [SMB+107] = { id = SMB+107 }, -- Goblin Replica
    [SMB+108] = { id = SMB+108 }, -- Goblin Replica
    [SMB+109] = { id = SMB+109 }, -- Goblin Replica
    [SMB+110] = { id = SMB+110 }, -- Goblin Replica
    [SMB+111] = { id = SMB+111 }, -- Goblin Replica
    [SMB+112] = { id = SMB+112 }, -- Goblin Replica
    [SMB+113] = { id = SMB+113 }, -- Goblin Replica
    [SMB+114] = { id = SMB+114 }, -- Goblin Replica
    [SMB+115] = { id = SMB+115 }, -- Goblin Replica
    [SMB+116] = { id = SMB+116 }, -- Goblin Replica
    [SMB+117] = { id = SMB+117 }, -- Goblin Replica
    [SMB+118] = { id = SMB+118 }, -- Goblin Replica
    [SMB+119] = { id = SMB+119 }, -- Goblin Replica
    [SMB+120] = { id = SMB+120 }, -- Goblin Replica
    [SMB+121] = { id = SMB+121 }, -- Goblin Replica
    [SMB+122] = { id = SMB+122 }, -- Goblin Replica
    [SMB+123] = { id = SMB+123 }, -- Goblin Replica
    [SMB+124] = { id = SMB+124 }, -- Goblin Replica
    [SMB+125] = { id = SMB+125 }, -- Goblin Replica
    [SMB+126] = { id = SMB+126 }, -- Goblin Replica
    [SMB+127] = { id = SMB+127 }, -- Goblin Replica
    [SMB+128] = { id = SMB+128 }, -- Goblin Replica
    [SMB+129] = { id = SMB+129 }, -- Goblin Replica
    [SMB+130] = { id = SMB+130 }, -- Goblin Replica
    [SMB+131] = { id = SMB+131 }, -- Goblin Replica
    [SMB+132] = { id = SMB+132 }, -- Goblin Replica
    [SMB+133] = { id = SMB+133 }, -- Goblin Replica
    [SMB+134] = { id = SMB+134 }, -- Goblin Replica
    [SMB+135] = { id = SMB+135 }, -- Goblin Replica
    [SMB+136] = { id = SMB+136 }, -- Goblin Replica
    [SMB+137] = { id = SMB+137 }, -- Goblin Replica
    [SMB+138] = { id = SMB+138 }, -- Goblin Replica
    [SMB+139] = { id = SMB+139 }, -- Goblin Replica
    [SMB+140] = { id = SMB+140 }, -- Goblin Replica
    [SMB+141] = { id = SMB+141 }, -- Goblin Replica
    [SMB+142] = { id = SMB+142 }, -- Goblin Replica
    [SMB+143] = { id = SMB+143 }, -- Goblin Replica
    [SMB+144] = { id = SMB+144 }, -- Goblin Replica
    [SMB+145] = { id = SMB+145 }, -- Goblin Replica
    [SMB+146] = { id = SMB+146 }, -- Goblin Replica
    [SMB+147] = { id = SMB+147 }, -- Goblin Replica
    [SMB+148] = { id = SMB+148 }, -- Goblin Replica
    [SMB+149] = { id = SMB+149 }, -- Goblin Replica
    [SMB+150] = { id = SMB+150 }, -- Goblin Replica
    [SMB+151] = { id = SMB+151 }, -- Goblin Replica
    [SMB+152] = { id = SMB+152 }, -- Goblin Replica
    [SMB+153] = { id = SMB+153 }, -- Goblin Replica
    [SMB+154] = { id = SMB+154 }, -- Goblin Replica
    [SMB+155] = { id = SMB+155 }, -- Goblin Replica
    [SMB+156] = { id = SMB+156 }, -- Goblin Replica
    [SMB+157] = { id = SMB+157 }, -- Goblin Replica
    [SMB+158] = { id = SMB+158 }, -- Goblin Replica
    [SMB+159] = { id = SMB+159 }, -- Goblin Replica
    [SMB+160] = { id = SMB+160 }, -- Goblin Replica
    [SMB+161] = { id = SMB+161 }, -- Goblin Replica
    [SMB+162] = { id = SMB+162 }, -- Goblin Replica
    [SMB+163] = { id = SMB+163 }, -- Goblin Replica
    [SMB+164] = { id = SMB+164 }, -- Goblin Replica
    [SMB+165] = { id = SMB+165 }, -- Goblin Replica
    [SMB+166] = { id = SMB+166 }, -- Goblin Replica
    [SMB+167] = { id = SMB+167 }, -- Goblin Replica
    [SMB+168] = { id = SMB+168 }, -- Goblin Replica
    [SMB+169] = { id = SMB+169 }, -- Goblin Replica
    [SMB+170] = { id = SMB+170 }, -- Goblin Replica
    [SMB+171] = { id = SMB+171 }, -- Goblin Replica
    [SMB+172] = { id = SMB+172 }, -- Goblin Replica
    [SMB+173] = { id = SMB+173 }, -- Goblin Replica
    [SMB+174] = { id = SMB+174 }, -- Goblin Replica
    [SMB+175] = { id = SMB+175 }, -- Goblin Replica
    [SMB+176] = { id = SMB+176 }, -- Goblin Replica
    [SMB+177] = { id = SMB+177 }, -- Goblin Replica
    [SMB+178] = { id = SMB+178 }, -- Goblin Replica
    [SMB+179] = { id = SMB+179 }, -- Goblin Replica
    [SMB+180] = { id = SMB+180 }, -- Goblin Replica
    [SMB+181] = { id = SMB+181 }, -- Goblin Replica
    [SMB+182] = { id = SMB+182 }, -- Goblin Replica
    [SMB+183] = { id = SMB+183 }, -- Goblin Replica
    [SMB+184] = { id = SMB+184 }, -- Goblin Replica
    [SMB+185] = { id = SMB+185 }, -- Goblin Replica
    [SMB+186] = { id = SMB+186 }, -- Goblin Replica
    [SMB+187] = { id = SMB+187 }, -- Goblin Replica
    [SMB+188] = { id = SMB+188 }, -- Goblin Replica
    [SMB+189] = { id = SMB+189 }, -- Goblin Replica
    [SMB+190] = { id = SMB+190 }, -- Goblin Replica
    [SMB+191] = { id = SMB+191 }, -- Goblin Replica
    [SMB+192] = { id = SMB+192 }, -- Goblin Replica
    [SMB+193] = { id = SMB+193 }, -- Goblin Replica
    [SMB+194] = { id = SMB+194 }, -- Goblin Replica
    [SMB+195] = { id = SMB+195 }, -- Goblin Replica
    [SMB+196] = { id = SMB+196 }, -- Goblin Replica
    [SMB+197] = { id = SMB+197 }, -- Goblin Replica
    [SMB+198] = { id = SMB+198 }, -- Goblin Replica
    [SMB+199] = { id = SMB+199 }, -- Goblin Replica
    [SMB+200] = { id = SMB+200 }, -- Goblin Replica
    [SMB+201] = { id = SMB+201 }, -- Goblin Replica
    [SMB+202] = { id = SMB+202 }, -- Goblin Replica
    [SMB+203] = { id = SMB+203 }, -- Goblin Replica
    [SMB+204] = { id = SMB+204 }, -- Goblin Replica
    [SMB+205] = { id = SMB+205 }, -- Goblin Replica
    [SMB+206] = { id = SMB+206 }, -- Goblin Replica
    [SMB+207] = { id = SMB+207 }, -- Goblin Replica
    [SMB+208] = { id = SMB+208 }, -- Goblin Replica
    [SMB+209] = { id = SMB+209 }, -- Goblin Replica
    [SMB+210] = { id = SMB+210 }, -- Goblin Replica
    [SMB+211] = { id = SMB+211 }, -- Goblin Replica
    [SMB+212] = { id = SMB+212 }, -- Goblin Replica
    [SMB+213] = { id = SMB+213 }, -- Goblin Replica
    [SMB+214] = { id = SMB+214 }, -- Goblin Replica
    [SMB+215] = { id = SMB+215 }, -- Goblin Replica
    [SMB+216] = { id = SMB+216 }, -- Goblin Replica
    [SMB+217] = { id = SMB+217 }, -- Goblin Replica
    [SMB+218] = { id = SMB+218 }, -- Goblin Replica
    [SMB+219] = { id = SMB+219 }, -- Goblin Replica
    [SMB+220] = { id = SMB+220 }, -- Goblin Replica
    [SMB+221] = { id = SMB+221 }, -- Goblin Replica
    [SMB+222] = { id = SMB+222 }, -- Goblin Replica
    [SMB+223] = { id = SMB+223 }, -- Goblin Replica
    [SMB+224] = { id = SMB+224 }, -- Goblin Replica
    [SMB+225] = { id = SMB+225 }, -- Goblin Replica
    [SMB+226] = { id = SMB+226 }, -- Goblin Replica
    [SMB+227] = { id = SMB+227 }, -- Goblin Replica
    [SMB+228] = { id = SMB+228 }, -- Goblin Replica
    [SMB+229] = { id = SMB+229 }, -- Goblin Replica
    [SMB+230] = { id = SMB+230 }, -- Goblin Replica
    [SMB+231] = { id = SMB+231 }, -- Goblin Replica
    [SMB+232] = { id = SMB+232 }, -- Goblin Replica
    [SMB+233] = { id = SMB+233 }, -- Goblin Replica
    [SMB+234] = { id = SMB+234 }, -- Goblin Replica
    [SMB+235] = { id = SMB+235 }, -- Goblin Replica
    [SMB+236] = { id = SMB+236 }, -- Goblin Replica
    [SMB+237] = { id = SMB+237 }, -- Goblin Replica
    [SMB+238] = { id = SMB+238 }, -- Goblin Replica
    [SMB+239] = { id = SMB+239 }, -- Goblin Replica
    [SMB+240] = { id = SMB+240 }, -- Goblin Replica
    [SMB+241] = { id = SMB+241 }, -- Goblin Replica
    [SMB+242] = { id = SMB+242 }, -- Goblin Replica
    [SMB+243] = { id = SMB+243 }, -- Goblin Replica
    [SMB+244] = { id = SMB+244 }, -- Goblin Replica
    [SMB+245] = { id = SMB+245 }, -- Goblin Replica
    [SMB+246] = { id = SMB+246 }, -- Goblin Replica
    [SMB+247] = { id = SMB+247 }, -- Goblin Replica
    [SMB+248] = { id = SMB+248 }, -- Goblin Replica
    [SMB+249] = { id = SMB+249 }, -- Goblin Replica
    [SMB+250] = { id = SMB+250 }, -- Goblin Replica
    [SMB+251] = { id = SMB+251 }, -- Goblin Replica
    [SMB+252] = { id = SMB+252 }, -- Goblin Replica
    [SMB+253] = { id = SMB+253 }, -- Goblin Replica
    [SMB+254] = { id = SMB+254 }, -- Goblin Replica
    [SMB+255] = { id = SMB+255 }, -- Goblin Replica
    [SMB+256] = { id = SMB+256 }, -- Goblin Replica
    [SMB+257] = { id = SMB+257 }, -- Goblin Replica
    [SMB+258] = { id = SMB+258 }, -- Goblin Replica
    [SMB+259] = { id = SMB+259 }, -- Goblin Replica
    [SMB+260] = { id = SMB+260 }, -- Goblin Replica
    [SMB+261] = { id = SMB+261 }, -- Goblin Replica
    [SMB+262] = { id = SMB+262 }, -- Goblin Replica
    [SMB+263] = { id = SMB+263 }, -- Goblin Replica
    [SMB+264] = { id = SMB+264 }, -- Goblin Replica
    [SMB+265] = { id = SMB+265 }, -- Goblin Replica
    [SMB+266] = { id = SMB+266 }, -- Goblin Replica
    [SMB+267] = { id = SMB+267 }, -- Goblin Replica
    [SMB+268] = { id = SMB+268 }, -- Goblin Replica
    [SMB+269] = { id = SMB+269 }, -- Goblin Replica
    [SMB+270] = { id = SMB+270 }, -- Goblin Replica
    [SMB+271] = { id = SMB+271 }, -- Goblin Replica
    [SMB+272] = { id = SMB+272 }, -- Goblin Replica
    [SMB+273] = { id = SMB+273 }, -- Goblin Replica
    [SMB+274] = { id = SMB+274 }, -- Goblin Replica
    [SMB+275] = { id = SMB+275 }, -- Goblin Replica
    [SMB+276] = { id = SMB+276 }, -- Goblin Replica
    [SMB+277] = { id = SMB+277 }, -- Goblin Replica
    [SMB+278] = { id = SMB+278 }, -- Goblin Replica
    [SMB+279] = { id = SMB+279 }, -- Goblin Replica
    [SMB+280] = { id = SMB+280 }, -- Goblin Replica
    [SMB+281] = { id = SMB+281 }, -- Goblin Replica
    [SMB+282] = { id = SMB+282 }, -- Goblin Replica
    [SMB+283] = { id = SMB+283 }, -- Goblin Replica
    [SMB+284] = { id = SMB+284 }, -- Goblin Replica
    [SMB+285] = { id = SMB+285 }, -- Goblin Replica
    [SMB+286] = { id = SMB+286 }, -- Goblin Replica
    [SMB+287] = { id = SMB+287 }, -- Goblin Replica
    [SMB+288] = { id = SMB+288 }, -- Goblin Replica
    [SMB+289] = { id = SMB+289 }, -- Goblin Replica
    [SMB+290] = { id = SMB+290 }, -- Goblin Replica
    [SMB+291] = { id = SMB+291 }, -- Goblin Replica
    [SMB+292] = { id = SMB+292 }, -- Goblin Replica
    [SMB+293] = { id = SMB+293 }, -- Goblin Replica
    [SMB+294] = { id = SMB+294 }, -- Goblin Replica
    [SMB+295] = { id = SMB+295 }, -- Goblin Replica
    [SMB+296] = { id = SMB+296 }, -- Goblin Replica
    [SMB+297] = { id = SMB+297 }, -- Goblin Replica
    [SMB+298] = { id = SMB+298 }, -- Goblin Replica
    [SMB+299] = { id = SMB+299 }, -- Goblin Replica
    [SMB+300] = { id = SMB+300 }, -- Goblin Replica
    [SMB+301] = { id = SMB+301 }, -- Goblin Replica
    [SMB+302] = { id = SMB+302 }, -- Goblin Replica
    [SMB+303] = { id = SMB+303 }, -- Goblin Replica
    [SMB+304] = { id = SMB+304 }, -- Goblin Replica
    [SMB+305] = { id = SMB+305 }, -- Goblin Replica
    [SMB+306] = { id = SMB+306 }, -- Goblin Replica
    [SMB+307] = { id = SMB+307 }, -- Goblin Replica
    [SMB+308] = { id = SMB+308 }, -- Goblin Replica
    [SMB+309] = { id = SMB+309 }, -- Goblin Replica
    [SMB+310] = { id = SMB+310 }, -- Goblin Replica
    [SMB+311] = { id = SMB+311 }, -- Goblin Replica
    [SMB+312] = { id = SMB+312 }, -- Goblin Replica
    [SMB+313] = { id = SMB+313 }, -- Goblin Replica
    [SMB+314] = { id = SMB+314 }, -- Goblin Replica
    [SMB+315] = { id = SMB+315 }, -- Goblin Replica
    [SMB+316] = { id = SMB+316 }, -- Goblin Replica
    [SMB+317] = { id = SMB+317 }, -- Goblin Replica
    [SMB+318] = { id = SMB+318 }, -- Goblin Replica
    [SMB+319] = { id = SMB+319 }, -- Goblin Replica
    [SMB+320] = { id = SMB+320 }, -- Goblin Replica
    [SMB+321] = { id = SMB+321 }, -- Goblin Replica
    [SMB+322] = { id = SMB+322 }, -- Goblin Replica
    [SMB+323] = { id = SMB+323 }, -- Goblin Replica
    [SMB+324] = { id = SMB+324 }, -- Goblin Replica
    [SMB+325] = { id = SMB+325 }, -- Goblin Replica
    [SMB+326] = { id = SMB+326 }, -- Goblin Replica
    [SMB+327] = { id = SMB+327 }, -- Goblin Replica
    [SMB+328] = { id = SMB+328 }, -- Goblin Replica
    [SMB+329] = { id = SMB+329 }, -- Goblin Replica
    [SMB+330] = { id = SMB+330 }, -- Goblin Replica
    [SMB+331] = { id = SMB+331 }, -- Goblin Replica
    [SMB+332] = { id = SMB+332 }, -- Goblin Replica
    [SMB+333] = { id = SMB+333 }, -- Goblin Replica
    [SMB+334] = { id = SMB+334 }, -- Goblin Replica
    [SMB+335] = { id = SMB+335 }, -- Goblin Replica
    [SMB+336] = { id = SMB+336 }, -- Goblin Replica
    [SMB+337] = { id = SMB+337 }, -- Goblin Replica
    [SMB+338] = { id = SMB+338 }, -- Goblin Replica
    [SMB+339] = { id = SMB+339 }, -- Goblin Replica
    [SMB+340] = { id = SMB+340 }, -- Goblin Replica
    [SMB+341] = { id = SMB+341 }, -- Goblin Replica
    [SMB+342] = { id = SMB+342 }, -- Goblin Replica
    [SMB+343] = { id = SMB+343 }, -- Goblin Replica
    [SMB+344] = { id = SMB+344 }, -- Goblin Replica
    [SMB+345] = { id = SMB+345 }, -- Goblin Replica
    [SMB+346] = { id = SMB+346 }, -- Goblin Replica
    [SMB+347] = { id = SMB+347 }, -- Goblin Replica
    [SMB+348] = { id = SMB+348 }, -- Goblin Replica
    [SMB+349] = { id = SMB+349 }, -- Goblin Replica
    [SMB+350] = { id = SMB+350 }, -- Goblin Replica
    [SMB+351] = { id = SMB+351 }, -- Goblin Replica
    [SMB+352] = { id = SMB+352 }, -- Goblin Replica
    [SMB+353] = { id = SMB+353 }, -- Goblin Replica
    [SMB+354] = { id = SMB+354 }, -- Goblin Replica
    [SMB+355] = { id = SMB+355 }, -- Goblin Replica
    [SMB+356] = { id = SMB+356 }, -- Goblin Replica
    [SMB+357] = { id = SMB+357 }, -- Goblin Replica
    [SMB+358] = { id = SMB+358 }, -- Goblin Replica
    [SMB+359] = { id = SMB+359 }, -- Goblin Replica
    [SMB+360] = { id = SMB+360 }, -- Goblin Replica
    [SMB+361] = { id = SMB+361 }, -- Goblin Replica
    [SMB+362] = { id = SMB+362 }, -- Goblin Replica
    [SMB+363] = { id = SMB+363 }, -- Goblin Replica
    [SMB+364] = { id = SMB+364 }, -- Goblin Replica
    [SMB+365] = { id = SMB+365 }, -- Goblin Replica
    [SMB+366] = { id = SMB+366 }, -- Goblin Replica
    [SMB+367] = { id = SMB+367 }, -- Goblin Replica
    [SMB+368] = { id = SMB+368 }, -- Goblin Replica
    [SMB+369] = { id = SMB+369 }, -- Goblin Replica
    [SMB+370] = { id = SMB+370 }, -- Goblin Replica
    [SMB+371] = { id = SMB+371 }, -- Goblin Replica
    [SMB+372] = { id = SMB+372 }, -- Goblin Replica
    [SMB+373] = { id = SMB+373 }, -- Goblin Replica
    [SMB+374] = { id = SMB+374 }, -- Goblin Replica
    [SMB+375] = { id = SMB+375 }, -- Goblin Replica
    [SMB+376] = { id = SMB+376 }, -- Goblin Replica
    [SMB+377] = { id = SMB+377 }, -- Goblin Replica
    [SMB+378] = { id = SMB+378 }, -- Goblin Replica
    [SMB+379] = { id = SMB+379 }, -- Goblin Replica
    [SMB+380] = { id = SMB+380 }, -- Goblin Replica
    [SMB+381] = { id = SMB+381 }, -- Goblin Replica
    [SMB+382] = { id = SMB+382 }, -- Goblin Replica
    [SMB+383] = { id = SMB+383 }, -- Goblin Replica
    [SMB+384] = { id = SMB+384 }, -- Goblin Replica
    [SMB+385] = { id = SMB+385 }, -- Goblin Replica
    [SMB+386] = { id = SMB+386 }, -- Goblin Replica
    [SMB+387] = { id = SMB+387 }, -- Goblin Replica
    [SMB+388] = { id = SMB+388 }, -- Goblin Replica
    [SMB+389] = { id = SMB+389 }, -- Goblin Replica
    [SMB+390] = { id = SMB+390 }, -- Goblin Replica
    [SMB+391] = { id = SMB+391 }, -- Goblin Replica
    [SMB+392] = { id = SMB+392 }, -- Goblin Replica
    [SMB+393] = { id = SMB+393 }, -- Goblin Replica
    [SMB+394] = { id = SMB+394 }, -- Goblin Replica
    [SMB+395] = { id = SMB+395 }, -- Goblin Replica
    [SMB+396] = { id = SMB+396 }, -- Goblin Replica
    [SMB+397] = { id = SMB+397 }, -- Goblin Replica
    [SMB+398] = { id = SMB+398 }, -- Goblin Replica
    [SMB+399] = { id = SMB+399 }, -- Goblin Replica
    [SMB+400] = { id = SMB+400 }, -- Goblin Replica
    [SMB+401] = { id = SMB+401 }, -- Goblin Replica
    [SMB+402] = { id = SMB+402 }, -- Goblin Replica
    [SMB+403] = { id = SMB+403 }, -- Goblin Replica
    [SMB+404] = { id = SMB+404 }, -- Goblin Replica
    [SMB+405] = { id = SMB+405 }, -- Goblin Replica
    [SMB+406] = { id = SMB+406 }, -- Goblin Replica
    [SMB+407] = { id = SMB+407 }, -- Goblin Replica
    [SMB+408] = { id = SMB+408 }, -- Goblin Replica
    [SMB+409] = { id = SMB+409 }, -- Goblin Replica
    [SMB+410] = { id = SMB+410 }, -- Goblin Replica
    [SMB+411] = { id = SMB+411 }, -- Goblin Replica
    [SMB+412] = { id = SMB+412 }, -- Goblin Replica
    [SMB+413] = { id = SMB+413 }, -- Goblin Replica
    [SMB+414] = { id = SMB+414 }, -- Goblin Replica
    [SMB+415] = { id = SMB+415 }, -- Goblin Replica
    [SMB+416] = { id = SMB+416 }, -- Goblin Replica
    [SMB+417] = { id = SMB+417 }, -- Goblin Replica
    [SMB+418] = { id = SMB+418 }, -- Goblin Replica
    [SMB+419] = { id = SMB+419 }, -- Goblin Replica
    [SMB+420] = { id = SMB+420 }, -- Goblin Replica
    [SMB+421] = { id = SMB+421 }, -- Goblin Replica
    [SMB+422] = { id = SMB+422 }, -- Goblin Replica
    [SMB+423] = { id = SMB+423 }, -- Goblin Replica
    [SMB+424] = { id = SMB+424 }, -- Goblin Replica
    [SMB+425] = { id = SMB+425 }, -- Goblin Replica
    [SMB+426] = { id = SMB+426 }, -- Goblin Replica
    [SMB+427] = { id = SMB+427 }, -- Goblin Replica
    [SMB+428] = { id = SMB+428 }, -- Goblin Replica
    [SMB+429] = { id = SMB+429 }, -- Goblin Replica
    [SMB+430] = { id = SMB+430 }, -- Goblin Replica
    [SMB+431] = { id = SMB+431 }, -- Goblin Replica
    [SMB+432] = { id = SMB+432 }, -- Goblin Replica
    [SMB+433] = { id = SMB+433 }, -- Goblin Replica
    [SMB+434] = { id = SMB+434 }, -- Goblin Replica
    [SMB+435] = { id = SMB+435 }, -- Goblin Replica
    [SMB+436] = { id = SMB+436 }, -- Goblin Replica
    [SMB+437] = { id = SMB+437 }, -- Goblin Replica
    [SMB+438] = { id = SMB+438 }, -- Goblin Replica
    [SMB+439] = { id = SMB+439 }, -- Goblin Replica
    [SMB+440] = { id = SMB+440 }, -- Goblin Replica
    [SMB+441] = { id = SMB+441 }, -- Goblin Replica
    [SMB+442] = { id = SMB+442 }, -- Goblin Replica
    [SMB+443] = { id = SMB+443 }, -- Goblin Replica
    [SMB+444] = { id = SMB+444 }, -- Goblin Replica
    [SMB+445] = { id = SMB+445 }, -- Goblin Replica
    [SMB+446] = { id = SMB+446 }, -- Goblin Replica
    [SMB+447] = { id = SMB+447 }, -- Goblin Replica
    [SMB+448] = { id = SMB+448 }, -- Goblin Replica
    [SMB+449] = { id = SMB+449 }, -- Goblin Replica
    [SMB+450] = { id = SMB+450 }, -- Goblin Replica
    [SMB+451] = { id = SMB+451 }, -- Goblin Replica
    [SMB+452] = { id = SMB+452 }, -- Goblin Replica
    [SMB+453] = { id = SMB+453 }, -- Goblin Replica
    [SMB+454] = { id = SMB+454 }, -- Goblin Replica
    [SMB+455] = { id = SMB+455 }, -- Goblin Replica
    [SMB+456] = { id = SMB+456 }, -- Goblin Replica
    [SMB+457] = { id = SMB+457 }, -- Goblin Replica
    [SMB+458] = { id = SMB+458 }, -- Goblin Replica
    [SMB+459] = { id = SMB+459 }, -- Goblin Replica
    [SMB+460] = { id = SMB+460 }, -- Goblin Replica
    [SMB+461] = { id = SMB+461 }, -- Goblin Replica
    [SMB+462] = { id = SMB+462 }, -- Goblin Replica
    [SMB+463] = { id = SMB+463 }, -- Goblin Replica
    [SMB+464] = { id = SMB+464 }, -- Goblin Replica
    [SMB+465] = { id = SMB+465 }, -- Goblin Replica
    [SMB+466] = { id = SMB+466 }, -- Goblin Replica
    [SMB+467] = { id = SMB+467 }, -- Goblin Replica
    [SMB+468] = { id = SMB+468 }, -- Goblin Replica
    [SMB+469] = { id = SMB+469 }, -- Goblin Replica
    [SMB+470] = { id = SMB+470 }, -- Goblin Replica
    [SMB+471] = { id = SMB+471 }, -- Goblin Replica
    [SMB+472] = { id = SMB+472 }, -- Goblin Replica
    [SMB+473] = { id = SMB+473 }, -- Goblin Replica
    [SMB+474] = { id = SMB+474 }, -- Goblin Replica
    [SMB+475] = { id = SMB+475 }, -- Goblin Replica
    [SMB+476] = { id = SMB+476 }, -- Goblin Replica
    [SMB+477] = { id = SMB+477 }, -- Goblin Replica
    [SMB+478] = { id = SMB+478 }, -- Goblin Replica
    [SMB+479] = { id = SMB+479 }, -- Goblin Replica
    [SMB+480] = { id = SMB+480 }, -- Goblin Replica
    [SMB+481] = { id = SMB+481 }, -- Goblin Replica
    [SMB+482] = { id = SMB+482 }, -- Goblin Replica
    [SMB+483] = { id = SMB+483 }, -- Goblin Replica
    [SMB+484] = { id = SMB+484 }, -- Goblin Replica
    [SMB+485] = { id = SMB+485 }, -- Goblin Replica
    [SMB+486] = { id = SMB+486 }, -- Goblin Replica
    [SMB+487] = { id = SMB+487 }, -- Goblin Replica
    [SMB+488] = { id = SMB+488 }, -- Goblin Replica
    [SMB+489] = { id = SMB+489 }, -- Goblin Replica
    [SMB+490] = { id = SMB+490 }, -- Goblin Replica
    [SMB+491] = { id = SMB+491 }, -- Goblin Replica
    [SMB+492] = { id = SMB+492 }, -- Goblin Replica
    [SMB+493] = { id = SMB+493 }, -- Goblin Replica
    [SMB+494] = { id = SMB+494 }, -- Goblin Replica
    [SMB+495] = { id = SMB+495 }, -- Goblin Replica
    [SMB+496] = { id = SMB+496 }, -- Goblin Replica
    [SMB+497] = { id = SMB+497 }, -- Goblin Replica
    [SMB+498] = { id = SMB+498 }, -- Goblin Replica
    [SMB+499] = { id = SMB+499 }, -- Goblin Replica
    [SMB+500] = { id = SMB+500 }, -- Goblin Replica
    [SMB+501] = { id = SMB+501 }, -- Goblin Replica
    [SMB+502] = { id = SMB+502 }, -- Goblin Replica
    [SMB+503] = { id = SMB+503 }, -- Goblin Replica
    [SMB+504] = { id = SMB+504 }, -- Goblin Replica
    [SMB+505] = { id = SMB+505 }, -- Goblin Replica
    [SMB+506] = { id = SMB+506 }, -- Goblin Replica
    [SMB+507] = { id = SMB+507 }, -- Goblin Replica
    [SMB+508] = { id = SMB+508 }, -- Goblin Replica
    [SMB+509] = { id = SMB+509 }, -- Goblin Replica
    [SMB+510] = { id = SMB+510 }, -- Goblin Replica
    [SMB+511] = { id = SMB+511 }, -- Goblin Replica
    [SMB+512] = { id = SMB+512 }, -- Goblin Replica
    [SMB+513] = { id = SMB+513 }, -- Goblin Replica
    [SMB+514] = { id = SMB+514 }, -- Goblin Replica
    [SMB+515] = { id = SMB+515 }, -- Goblin Replica
    [SMB+516] = { id = SMB+516 }, -- Goblin Replica
    [SMB+517] = { id = SMB+517 }, -- Goblin Replica
    [SMB+518] = { id = SMB+518 }, -- Goblin Replica
    [SMB+519] = { id = SMB+519 }, -- Goblin Replica
    [SMB+520] = { id = SMB+520 }, -- Goblin Replica
    [SMB+521] = { id = SMB+521 }, -- Goblin Replica
    [SMB+522] = { id = SMB+522 }, -- Goblin Replica
    [SMB+523] = { id = SMB+523 }, -- Goblin Replica
    [SMB+524] = { id = SMB+524 }, -- Goblin Replica
    [SMB+525] = { id = SMB+525 }, -- Goblin Replica
    [SMB+526] = { id = SMB+526 }, -- Goblin Replica
    [SMB+527] = { id = SMB+527 }, -- Goblin Replica
    [SMB+528] = { id = SMB+528 }, -- Goblin Replica
    [SMB+529] = { id = SMB+529 }, -- Goblin Replica
    [SMB+530] = { id = SMB+530 }, -- Goblin Replica
    [SMB+531] = { id = SMB+531 }, -- Goblin Replica
    [SMB+532] = { id = SMB+532 }, -- Goblin Replica
    [SMB+533] = { id = SMB+533 }, -- Goblin Replica
    [SMB+534] = { id = SMB+534 }, -- Goblin Replica
    [SMB+535] = { id = SMB+535 }, -- Goblin Replica
    [SMB+536] = { id = SMB+536 }, -- Goblin Replica
    [SMB+537] = { id = SMB+537 }, -- Goblin Replica
    [SMB+538] = { id = SMB+538 }, -- Goblin Replica
    [SMB+539] = { id = SMB+539 }, -- Goblin Replica
    [SMB+540] = { id = SMB+540 }, -- Goblin Replica
    [SMB+541] = { id = SMB+541 }, -- Goblin Replica
    [SMB+542] = { id = SMB+542 }, -- Goblin Replica
    [SMB+543] = { id = SMB+543 }, -- Goblin Replica
    [SMB+544] = { id = SMB+544 }, -- Goblin Replica
    [SMB+545] = { id = SMB+545 }, -- Goblin Replica
    [SMB+546] = { id = SMB+546 }, -- Goblin Replica
    [SMB+547] = { id = SMB+547 }, -- Goblin Replica
    [SMB+548] = { id = SMB+548 }, -- Goblin Replica
    [SMB+549] = { id = SMB+549 }, -- Goblin Replica
    [SMB+550] = { id = SMB+550 }, -- Goblin Replica
    [SMB+551] = { id = SMB+551 }, -- Goblin Replica
    [SMB+552] = { id = SMB+552 }, -- Goblin Replica
    [SMB+553] = { id = SMB+553 }, -- Goblin Replica
    [SMB+554] = { id = SMB+554 }, -- Goblin Replica
    [SMB+555] = { id = SMB+555 }, -- Goblin Replica
    [SMB+556] = { id = SMB+556 }, -- Goblin Replica
    [SMB+557] = { id = SMB+557 }, -- Goblin Replica
    [SMB+558] = { id = SMB+558 }, -- Goblin Replica
    [SMB+559] = { id = SMB+559 }, -- Goblin Replica
    [SMB+560] = { id = SMB+560 }, -- Goblin Replica
    [SMB+561] = { id = SMB+561 }, -- Goblin Replica
    [SMB+562] = { id = SMB+562 }, -- Goblin Replica
    [SMB+563] = { id = SMB+563 }, -- Goblin Replica
    [SMB+564] = { id = SMB+564 }, -- Goblin Replica
    [SMB+565] = { id = SMB+565 }, -- Goblin Replica
    [SMB+566] = { id = SMB+566 }, -- Goblin Replica
    [SMB+567] = { id = SMB+567 }, -- Goblin Replica
    [SMB+568] = { id = SMB+568 }, -- Goblin Replica
    [SMB+569] = { id = SMB+569 }, -- Goblin Replica
    [SMB+570] = { id = SMB+570 }, -- Goblin Replica
    [SMB+571] = { id = SMB+571 }, -- Goblin Replica
    [SMB+572] = { id = SMB+572 }, -- Goblin Replica
    [SMB+573] = { id = SMB+573 }, -- Goblin Replica
    [SMB+574] = { id = SMB+574 }, -- Goblin Replica
    [SMB+575] = { id = SMB+575 }, -- Goblin Replica
    [SMB+576] = { id = SMB+576 }, -- Goblin Replica
    [SMB+577] = { id = SMB+577 }, -- Goblin Replica
    [SMB+578] = { id = SMB+578 }, -- Goblin Replica
    [SMB+579] = { id = SMB+579 }, -- Goblin Replica
    [SMB+580] = { id = SMB+580 }, -- Goblin Replica
    [SMB+581] = { id = SMB+581 }, -- Goblin Replica
    [SMB+582] = { id = SMB+582 }, -- Goblin Replica
    [SMB+583] = { id = SMB+583 }, -- Goblin Replica
    [SMB+584] = { id = SMB+584 }, -- Goblin Replica
    [SMB+585] = { id = SMB+585 }, -- Goblin Replica
    [SMB+586] = { id = SMB+586 }, -- Goblin Replica
    [SMB+587] = { id = SMB+587 }, -- Goblin Replica
    [SMB+588] = { id = SMB+588 }, -- Goblin Replica
    [SMB+589] = { id = SMB+589 }, -- Goblin Replica
    [SMB+590] = { id = SMB+590 }, -- Goblin Replica
    [SMB+591] = { id = SMB+591 }, -- Goblin Replica
    [SMB+592] = { id = SMB+592 }, -- Goblin Replica
    [SMB+593] = { id = SMB+593 }, -- Goblin Replica
    [SMB+594] = { id = SMB+594 }, -- Goblin Replica
    [SMB+595] = { id = SMB+595 }, -- Goblin Replica
    [SMB+596] = { id = SMB+596 }, -- Goblin Replica
    [SMB+597] = { id = SMB+597 }, -- Goblin Replica
    [SMB+598] = { id = SMB+598 }, -- Goblin Replica
    [SMB+599] = { id = SMB+599 }, -- Goblin Replica
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_JEUNO

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages
mobList[zone][DMB+1  ].pos = { 0.0749, 0.0000, -93.0086, 190  }
mobList[zone][SMB+1  ].pos = { 43.1376, 9.0000, -52.9255, 0   }
mobList[zone][SMB+4  ].pos = { 34.4879, 9.0015, -52.9089, 0   } -- maybe roams east to west?
mobList[zone][SMB+7  ].pos = { 19.6648, 9.0000, -54.4987, 0   }
mobList[zone][SMB+10 ].pos = { 19.6648, 9.0000, -49.4087, 130 }
mobList[zone][SMB+13 ].pos = { -0.0188, 9.0000, -50.0981, 65  }
mobList[zone][SMB+16 ].pos = { -6.0517, 9.000, -43.9738, 130  }
mobList[zone][SMB+18 ].pos = { -0.1306, 9.0000, -38.4865, 190 }
mobList[zone][SMB+21 ].pos = { 6.1837, 9.0000, -43.9038, 0    }
mobList[zone][SMB+24 ].pos = { 3.9751, 9.0000, -65.7631, 190  }
mobList[zone][SMB+28 ].pos = { -17.9315, 9.0009, -49.9812, 0  }
mobList[zone][SMB+33 ].pos = { 20.0000, 9.0000, -36.0000, 130 }
mobList[zone][SMB+38 ].pos = { 2.0283, 9.0000, -29.8182, 190  }
mobList[zone][SMB+41 ].pos = { -1.9480, 9.0000, -29.7821, 190 }
mobList[zone][SMB+44 ].pos = { 49.5210, 9.0013, -49.1009, 65  }
mobList[zone][SMB+45 ].pos = { 46.9714, 9.0013, -49.1009, 65  }
mobList[zone][SMB+46 ].pos = { 52.2955, 9.0013, -49.1009, 65  }
mobList[zone][SMB+47 ].pos = { 21.0395, 9.000, -50.6540, 130  } -- pats
mobList[zone][SMB+50 ].pos = { 21.0395, 9.000, -53.2894, 0    } -- pats
mobList[zone][SMB+53 ].pos = { 6.1837, 9.0000, -43.9038, 0    }
mobList[zone][SMB+58 ].pos = { -0.0188, 9.0000, -50.0981, 65  }
mobList[zone][SMB+63 ].pos = { -6.0517, 9.000, -43.9738, 130  }
mobList[zone][SMB+68 ].pos = { 2.0283, 9.0000, -34.9261, 65   }
mobList[zone][SMB+71 ].pos = { -1.9480, 9.0000, -34.9261, 65  }
mobList[zone][SMB+74 ].pos = { 2.0283, 9.0000, -29.8182, 65   }
mobList[zone][SMB+75 ].pos = { -1.9480, 9.0000, -29.7821, 65  }
mobList[zone][SMB+76 ].pos = { 3.9751, 9.0000, -65.7631, 190  }
mobList[zone][SMB+78 ].pos = { -17.9315, 9.0009, -49.9812, 0  }
mobList[zone][SMB+80 ].pos = { 22.2683, 9.0000, -36.0087, 130 }
mobList[zone][SMB+82 ].pos = { 49.8322, 0.0000, -18.8849, 65  }
mobList[zone][SMB+87 ].pos = { 38.9497, -0.0001, -24.1140, 190}
mobList[zone][SMB+88 ].pos = { 38.2169, 0.0014, -26.8918, 130 }
mobList[zone][SMB+91 ].pos = { 33.5763, 0.0042, -2.1827, 65   }
mobList[zone][SMB+95 ].pos = { 31.2905, 0.0000, -19.2071, 65  } -- supposed to roam, bad spot
mobList[zone][SMB+96 ].pos = { 29.0720, 0.0000, -19.2071, 65  } -- supposed to roam, bad spot
mobList[zone][SMB+98 ].pos = { 33.1334, 0.0000, -19.2071, 65  } -- supposed to roam, bad spot
mobList[zone][SMB+99 ].pos = { 23.0952, 0.0000, -35.9893, 0   }
mobList[zone][SMB+105].pos = { 34.0702, 0.000, -45.0205, 130  }
mobList[zone][SMB+108].pos = { 26.1526, -1.5000, -57.9633, 0  }
mobList[zone][SMB+109].pos = { 33.9525, 0.0024, -78.0398, 160 }
mobList[zone][SMB+112].pos = { 19.9441, 0.0024, -74.0152, 190 } -- should roam east to west X 32.5000 to 5.3479
mobList[zone][SMB+114].pos = { 14.4597, 0.0040, -79.1646, 190 }
mobList[zone][SMB+118].pos = { 4.0190, 0.0031, -66.7020, 65   }
mobList[zone][SMB+121].pos = { -0.0232, 0.0000, -91.1894, 190 }
mobList[zone][SMB+129].pos = { 1.0406, 0.0050, -77.0060, 190  }
mobList[zone][SMB+131].pos = { -25.9116, 0.0050, -74.0152, 0  } -- should roam east to west
mobList[zone][SMB+134].pos = { -14.5780, 0.0050, -77.8301, 190}
mobList[zone][SMB+137].pos = { -24.3918, 3.0000, -1.7301, 65  }
mobList[zone][SMB+138].pos = { -4.2340, 3.0000, 0.2719, 33    }
mobList[zone][SMB+141].pos = { 21.2359, 0.5000, -1.1463, 65   }
mobList[zone][SMB+145].pos = { 0.2318, 3.0008, -10.1361, 190  }
mobList[zone][SMB+147].pos = { -26.0966, 3.0000, -5.8975, 0   } -- should roam east to west
mobList[zone][SMB+150].pos = { -29.8497, 3.0000, -5.7874, 130 } -- should roam east to west, Into AH and back
mobList[zone][SMB+159].pos = { -24.9341, 3.0000, -21.2504, 130}
mobList[zone][SMB+161].pos = { -34.9040, 3.0000, -21.2504, 0  }
mobList[zone][SMB+163].pos = { -24.9261, 0.0050, -65.6945, 130}
mobList[zone][SMB+166].pos = { -28.0926, 0.0000, -38.0390, 190} -- should roam north south
mobList[zone][SMB+170].pos = { -21.7690, 0.0032, -50.0607, 130}
mobList[zone][SMB+173].pos = { -38.5505, 0.0050, -63.8930, 223} -- should roam north south
mobList[zone][SMB+174].pos = { -39.8175, 0.0050, -45.9352, 0  }
mobList[zone][SMB+177].pos = { -39.8891, 0.0050, -57.8393, 0  }
mobList[zone][SMB+181].pos = { -60.7635, 6.0000, -3.8839, 190 } -- roams north away from 185
mobList[zone][SMB+183].pos = { -60.7635, 6.0000, -6.9070, 65  } -- roams south away from 185
mobList[zone][SMB+185].pos = { -57.6199, 6.0000, -5.9592, 0   }
mobList[zone][SMB+188].pos = { -72.2384, 5.5910, -4.9069, 0   }
mobList[zone][SMB+195].pos = { -57.6458, 6.0006, 7.5649, 98   }
mobList[zone][SMB+198].pos = { -72.1065, 5.5910, -14.4949, 0  }
mobList[zone][SMB+200].pos = { -40.9000, 8.0000, -19.0985, 130}
mobList[zone][SMB+202].pos = { -62.4598, 12.0000, -22.7011, 0 }
mobList[zone][SMB+205].pos = { -54.3511, 12.0000, -34.3394, 160}
mobList[zone][SMB+210].pos = { -67.3458, 12.0003, -33.0227, 0  }
mobList[zone][SMB+211].pos = { -40.9000, 8.0000, -19.0985, 130}
mobList[zone][SMB+213].pos = { -59.8750, 6.0000, -16.1639, 190}
mobList[zone][SMB+216].pos = { -54.0123, 6.0000, -6.0302, 130 }
mobList[zone][SMB+218].pos = { -72.2384, 5.5910, -4.9069, 0   }
mobList[zone][SMB+225].pos = { -60.9682, 6.0000, 6.9735, 65   }
mobList[zone][SMB+227].pos = { -65.0228, 6.0000, 6.9843, 65   }
mobList[zone][SMB+229].pos = { -36.9195, 3.0000, -9.1650, 130 }
mobList[zone][SMB+231].pos = { -36.9195, 3.0000, -5.9379, 130 }
mobList[zone][SMB+232].pos = { -36.9195, 3.0000, -3.2173, 130 }
mobList[zone][SMB+234].pos = { -0.1149, 3.0000, 12.9113, 65   }
mobList[zone][SMB+241].pos = { -12.0053, 2.0000, 38.0744, 190 }
mobList[zone][SMB+244].pos = { 12.0062, 2.0000, 38.1344, 190  }
mobList[zone][SMB+247].pos = { -0.0486, -2.0000, 55.2411, 65  }
mobList[zone][SMB+251].pos = { 0.1410, -5.0000, 66.5419, 60   }
-- mobList[zone][SMB+253].pos = { -0.0368, -5.0000, 39.7876, 65  } -- Removed statue temporarily to avoid linking the entire palace
mobList[zone][SMB+255].pos = { -11.8244, -4.9990, 52.1048, 130}
mobList[zone][SMB+258].pos = { -0.0631, 2.0000, 82.0938, 65   }
mobList[zone][SMB+260].pos = { 11.8094, -4.9990, 52.1927, 0   }
mobList[zone][SMB+263].pos = { 14.6010, 2.0000, 57.7371, 130  }
mobList[zone][SMB+265].pos = { -15.5002, 2.0000, 56.0989, 0   }
mobList[zone][SMB+267].pos = { 21.9514, 2.0000, 63.9278, 130  }
mobList[zone][SMB+269].pos = { -21.8274, 2.0000, 64.0809, 0   }
mobList[zone][SMB+271].pos = { 8.3778, 2.0000, 74.4057, 65    }
mobList[zone][SMB+272].pos = { -8.6289, 2.0000, 74.2613, 65   }
mobList[zone][SMB+273].pos = { -0.0725, -5.0000, 26.9398, 65  }
mobList[zone][SMB+276].pos = { 0.1481, 3.0000, 100.5307, 65   }
mobList[zone][SMB+281].pos = { 2.6637, 3.1000, 109.0261, 130  }
mobList[zone][SMB+283].pos = { -2.932, 3.1000, 109.0261, 0    }
mobList[zone][SMB+285].pos = { 2.6637, 3.100, 113.9294, 130   }
mobList[zone][SMB+289].pos = { -2.7932, 3.1000, 113.9294, 0   }
mobList[zone][SMB+293].pos = { 0.1155, 2.0000, 127.1585, 65   }
mobList[zone][SMB+294].pos = { 2.2990, 2.0000, 78.8475, 190}
mobList[zone][SMB+296].pos = { -2.4698, 2.0000, 78.8475, 190  }
mobList[zone][SMB+298].pos = { 14.7040, 2.0000, 70.1075, 130  }
mobList[zone][SMB+300].pos = { 14.9679, 2.0000, 47.9873, 130  }
mobList[zone][SMB+302].pos = { -7.0011, 2.0000, 37.1796, 190  }
mobList[zone][SMB+304].pos = { 7.3787, 2.0000, 37.6357, 190   }
mobList[zone][SMB+306].pos = { -13.5885, 2.0000, 70.0867, 0   }
mobList[zone][SMB+308].pos = { -14.4171, 2.0000, 53.5306, 0   }
mobList[zone][SMB+310].pos = { -0.0368, -5.0000, 39.7876, 65  }
mobList[zone][SMB+316].pos = { -0.1623, 3.0000, 21.7420, 190  }
mobList[zone][SMB+323].pos = { 0.1535, 3.0000, -1.1011, 190   }
mobList[zone][SMB+330].pos = { 7.0810, 0.0039, -72.9543, 130  }
mobList[zone][SMB+336].pos = { 3.8888, 0.0029, -75.0935, 190  }
mobList[zone][SMB+342].pos = { 2.0312, 0.0039, -72.9543, 0    }
mobList[zone][SMB+348].pos = { 3.8888, 0.0029, -69.6916, 65   }
mobList[zone][SMB+354].pos = { 1.8302, 0.0000, -87.3202, 190  }
mobList[zone][SMB+355].pos = { -2.0232, 0.0000, -87.3202, 190 }
mobList[zone][SMB+356].pos = { 0.0749, 0.0000, -90.1231, 190  }
mobList[zone][SMB+364].pos = { 32.1929, 0.0000, -25.3724, 65  }
mobList[zone][SMB+367].pos = { 28.6972, 0.0000, -25.3724, 65  }
mobList[zone][SMB+370].pos = { 34.4471, -1.5000, -57.9160, 130}
mobList[zone][SMB+373].pos = { 34.0226, 0.0000, -42.4347, 130 }
mobList[zone][SMB+376].pos = { 23.9921, 0.0000, -35.9794, 0   }
mobList[zone][SMB+381].pos = { 36.9862, 0.0043, -5.9051, 65   }
mobList[zone][SMB+384].pos = { 33.0990, 0.0043, -5.9051, 65   }
mobList[zone][SMB+387].pos = { 29.2118, 0.0043, -5.9051, 65   }
mobList[zone][SMB+390].pos = { 33.0990, 0.0043, -1.6651, 65   }
mobList[zone][SMB+397].pos = { 44.4816, 0.0010, -19.2162, 130 }
mobList[zone][SMB+402].pos = { -29.9606, 0.0050, -64.2050, 65 }
mobList[zone][SMB+407].pos = { -26.9746, 0.0000, -51.0322, 65 }
mobList[zone][SMB+411].pos = { -38.7977, 0.0050, -51.8374, 65 }
mobList[zone][SMB+416].pos = { -29.6286, 0.0000, -37.1918, 65 }
mobList[zone][SMB+423].pos = { -29.9306, 3.0000, -21.0314, 65 }
mobList[zone][SMB+430].pos = { -30.2499, 3.0000, -3.2392, 0   }
mobList[zone][SMB+433].pos = { -26.3001, 3.0000, -3.2392, 130 }
mobList[zone][SMB+437].pos = { -26.3001, 3.0000, -5.7314, 130 }
mobList[zone][SMB+440].pos = { -30.2499, 3.0000, -5.7314, 0   }
mobList[zone][SMB+444].pos = { -13.3908, 3.0000, -7.1402, 190 }
mobList[zone][SMB+448].pos = { -9.4717, 3.0000, -7.1402, 190  }
mobList[zone][SMB+452].pos = { -6.1601, 3.0000, -7.1402, 190  }
mobList[zone][SMB+456].pos = { 11.1059, 3.0000, -5.8691, 130  }
mobList[zone][SMB+464].pos = {  0.064, 4.001, -13.768, 64  }
mobList[zone][SMB+471].pos = { 0.0209, 3.0000, 14.43874, 65   }
mobList[zone][SMB+479].pos = { 7.6508, 9.0000, -32.9514, 65   }
mobList[zone][SMB+485].pos = { -7.4481, 9.0000, -33.8018, 65  }
mobList[zone][SMB+491].pos = { 49.7721, 4.7500, -37.1094, 190 }
mobList[zone][SMB+499].pos = { 3.6888, 9.0000, -54.3085, 190  }
mobList[zone][SMB+504].pos = { 48.9400, 9.0009, -53.2185, 190 }

-- add mob patrol paths for statues that are supposed to patrol
-- mobList[zone][mob].patrolPath = { }
mobList[zone][SMB+4  ].patrolPath = { 40, 9, -52, 	21, 9, -52, 	40, 9, -52  }
mobList[zone][SMB+96 ].patrolPath = { 29, 0, -5, 	29, 0, -47, 	29, 0, -5   }
mobList[zone][SMB+95 ].patrolPath = { 31, 0, -5, 	31, 0, -47, 	31, 0, -5   }
mobList[zone][SMB+98 ].patrolPath = { 33, 0, -5,	33, 0, -47, 	33, 0, -5   }
mobList[zone][SMB+112].patrolPath = { 33, 0, -74,	2, 0, -74,		33, 0, -74	}
mobList[zone][SMB+131].patrolPath = { -31, 0, -74,	-1, 0, -74, 	-31, 0, -74 }
mobList[zone][SMB+129].patrolPath = { 0, 0, -87,	0, 0, -72,		0, 0, -87	}
mobList[zone][SMB+166].patrolPath = { -28, 0, -38, 	-28, 0, -65, 	-28, 0, -38 }
mobList[zone][SMB+173].patrolPath = { -38, 0, -64, 	-38, 0, -41,	-38, 0, -64 }
mobList[zone][SMB+147].patrolPath = { -25, 3, -6, 	10, 3, -6,		-25, 3, -6 	}
mobList[zone][SMB+150].patrolPath = { -30, 3, -6,	-53, 6, -6,		-30, 3, -6	}
mobList[zone][SMB+181].patrolPath = { -61, 6, -3,	-61, 6, 8,		-61, 6, -3	}
mobList[zone][SMB+183].patrolPath = { -61, 6, -6,	-61, 6, -15,	-61, 6, -6	}
mobList[zone][SMB+247].patrolPath = { 0, -5, 63,	0, 2, 42,		0, -5, 63	}
mobList[zone][SMB+316].patrolPath = { 0, 3, 11,		0, 3, 29,		0, 3, 11	}
mobList[zone][SMB+323].patrolPath = { 0, 3, -8,		0, 3, 9,		0, 3, -8	}


-- set statue eye color
mobList[zone][DMB+1  ].eyes = dynamis.eyes.RED
mobList[zone][SMB+4  ].eyes = dynamis.eyes.RED
mobList[zone][SMB+7  ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+10 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+38 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+41 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+74 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+75 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+87 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+88 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+91 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+105].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+108].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+118].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+129].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+137].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+147].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+150].eyes = dynamis.eyes.RED
mobList[zone][SMB+166].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+170].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+174].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+177].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+188].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+198].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+210].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+225].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+227].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+234].eyes = dynamis.eyes.RED
mobList[zone][SMB+251].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+271].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+272].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+285].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+289].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+293].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+296].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+298].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+300].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+302].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+304].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+306].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+308].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+354].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+355].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+407].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+411].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+430].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+433].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+437].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+440].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+464].eyes = dynamis.eyes.GREEN

-- set time extensions
mobList[zone][DMB+1  ].timeExtension = 30 -- Goblin Golem
mobList[zone][SMB+4  ].timeExtension = 30
mobList[zone][SMB+87 ].timeExtension = 30
mobList[zone][SMB+150].timeExtension = 30
mobList[zone][SMB+234].timeExtension = 30

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } -- always leave this empty
mobList[zone].waveDefeatRequirements[2] = { SMB+33  } -- 44-46: Spawns when 33 defeated
mobList[zone].waveDefeatRequirements[3] = { SMB+44  } -- 47-80: Spawns when 44 defeated
mobList[zone].waveDefeatRequirements[4] = { SMB+210 } -- 211-232: Spawns when 210 defeated
mobList[zone].waveDefeatRequirements[5] = { SMB+293 } -- 294-356, Goblin_Golem: Spawns when 293 defeated
mobList[zone].waveDefeatRequirements[6] = { DMB+1   } -- 364-504: Spawns when Goblin_Golem defeated

-- miniWave is used when the same mobID needs to be used twice for a spawn wave or smaller size-waves
-- mobList[zone][DMB+30].miniWave = { SMB+14, SMB+18 }

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+4  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+5  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+7  ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+10 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+13 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+16 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+18 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+21 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+24 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+28 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+33 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+38 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+41 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+82 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+87 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+88 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+91 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+96 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+98 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+105].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+108].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+109].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+112].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+114].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+118].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+121].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+129].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+131].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+134].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+138].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+141].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+145].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+147].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+150].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+157].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+159].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+161].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+163].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+166].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+170].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+173].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+174].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+177].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+181].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+183].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+185].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+188].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+195].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+198].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+200].waves = {  1 ,nil,nil,nil  }
-- mobList[zone][SMB+201].waves = {  1 ,nil,nil,nil  } -- In old DAT but not on map
mobList[zone][SMB+202].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+205].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+210].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+234].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+241].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+244].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+247].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+251].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+253].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+255].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+258].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+260].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+263].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+265].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+267].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+269].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+271].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+272].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+273].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+276].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+281].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+283].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+285].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+289].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+293].waves = {  1 ,nil,nil,nil  }
mobList[zone][SMB+44 ].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+45 ].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+46 ].waves = { nil, 2 ,nil,nil  }
mobList[zone][SMB+47 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+50 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+53 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+58 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+63 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+68 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+71 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+74 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+75 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+76 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+78 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+80 ].waves = { nil,nil, 3 ,nil  }
mobList[zone][SMB+211].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+213].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+216].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+218].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+225].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+227].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+229].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+231].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+232].waves = { nil,nil,nil, 4 ,nil,nil }
mobList[zone][SMB+294].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+296].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+298].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+300].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+302].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+304].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+306].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+308].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+310].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+316].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+323].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+330].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+336].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+342].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+348].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+354].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+355].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+356].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][DMB+1  ].waves = { nil,nil,nil,nil, 5 ,nil }
mobList[zone][SMB+364].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+367].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+370].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+373].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+376].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+381].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+384].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+387].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+390].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+397].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+402].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+407].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+411].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+416].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+423].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+430].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+433].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+437].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+440].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+444].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+448].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+452].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+456].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+464].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+471].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+479].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+485].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+491].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+499].waves = { nil,nil,nil,nil,nil, 6  }
mobList[zone][SMB+504].waves = { nil,nil,nil,nil,nil, 6  }

-- set what mobIDs i will spawn when i engage (such as NMs or other statues) boolean value = forceLink enabled yes/no (default no if unspecified)
mobList[zone][SMB+24 ].specificChildren = { true, DMB+30  } -- Cloktix_Longnail
mobList[zone][SMB+28 ].specificChildren = { true, DMB+27  } -- Tufflix_Loglimbs
mobList[zone][SMB+33 ].specificChildren = { true, DMB+13  } -- Gabblox_Magpietongue
mobList[zone][SMB+53 ].specificChildren = { true, DMB+34  } -- Smeltix_Thickhide
mobList[zone][SMB+58 ].specificChildren = { true, DMB+36  } -- Wasabix_Callusdigit
mobList[zone][SMB+63 ].specificChildren = { true, DMB+35  } -- Jabkix_Pigeonpecs
mobList[zone][SMB+82 ].specificChildren = { true, DMB+48  } -- Wyrmwix_Snakespecs
mobList[zone][SMB+99 ].specificChildren = { true, DMB+47  } -- Hermitrix_Toothrot
mobList[zone][SMB+121].specificChildren = { true, DMB+58  } -- Morgmox_Moldnoggin
mobList[zone][SMB+150].specificChildren = { true, DMB+60  } -- Sparkspox_Sweatbrow
mobList[zone][SMB+170].specificChildren = { true, DMB+113 } -- Buffrix_Eargone
mobList[zone][SMB+177].specificChildren = { true, DMB+114 } -- Humnox_Drumbelly
mobList[zone][SMB+198].specificChildren = { true, DMB+91  } -- Elixmix_Hooknose
mobList[zone][SMB+205].specificChildren = { true, DMB+132 } -- Trailblix_Goatmug
mobList[zone][SMB+218].specificChildren = { true, DMB+174 } -- Mortilox_Wartpaws
mobList[zone][SMB+234].specificChildren = { true, DMB+92  } -- Bandrix_Rockjaw
mobList[zone][SMB+247].specificChildren = { true, DMB+131 } -- Lurklox_Dhalmelneck
mobList[zone][SMB+289].specificChildren = { true, DMB+130 } -- Ticktox_Beadyeyes
mobList[zone][SMB+310].specificChildren = { true, DMB+160 } -- Karashix_Swollenskull
mobList[zone][SMB+316].specificChildren = { true, DMB+190 } -- Rutrix_Hamgams
mobList[zone][SMB+323].specificChildren = { true, DMB+204 } -- Snypestix_Eaglebeak
mobList[zone][SMB+356].specificChildren = { true, DMB+138 } -- Kikklix_Longlegs
mobList[zone][SMB+376].specificChildren = { true, DMB+221 } -- Scruffix_Shaggychest
mobList[zone][SMB+390].specificChildren = { true, DMB+210 } -- Mobpix_Mucousmouth
mobList[zone][SMB+416].specificChildren = { true, DMB+222 } -- Tymexox_Ninefingers
mobList[zone][SMB+423].specificChildren = { true, DMB+228 } -- Slystix_Megapeepers
mobList[zone][SMB+456].specificChildren = { true, DMB+208 } -- Anvilix_Sootwrists
mobList[zone][SMB+464].specificChildren = { true, DMB+214 } -- Distilix_Stickytoes
mobList[zone][SMB+471].specificChildren = { true, DMB+209 } -- Bootrix_Jaggedelbow
mobList[zone][SMB+479].specificChildren = { true, DMB+226 } -- Prowlox_Barrelbelly
mobList[zone][SMB+485].specificChildren = { true, DMB+216 } -- Jabbrox_Grannyguise
mobList[zone][SMB+491].specificChildren = { true, DMB+223 } -- Blazox_Boneybod
mobList[zone][SMB+504].specificChildren = { true, DMB+215 } -- Eremix_Snottynostril

-- set how many mobs pop from each statue
mobList[zone][SMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+4  ].randomChildrenCount = 2
mobList[zone][SMB+7  ].randomChildrenCount = 2
mobList[zone][SMB+10 ].randomChildrenCount = 2
mobList[zone][SMB+13 ].randomChildrenCount = 1
mobList[zone][SMB+16 ].randomChildrenCount = 1
mobList[zone][SMB+18 ].randomChildrenCount = 1
mobList[zone][SMB+21 ].randomChildrenCount = 1
mobList[zone][SMB+24 ].randomChildrenCount = 2
mobList[zone][SMB+28 ].randomChildrenCount = 2
mobList[zone][SMB+33 ].randomChildrenCount = 2
mobList[zone][SMB+38 ].randomChildrenCount = 2
mobList[zone][SMB+41 ].randomChildrenCount = 2
mobList[zone][SMB+47 ].randomChildrenCount = 2
mobList[zone][SMB+50 ].randomChildrenCount = 2
mobList[zone][SMB+53 ].randomChildrenCount = 2
mobList[zone][SMB+58 ].randomChildrenCount = 2
mobList[zone][SMB+63 ].randomChildrenCount = 2
mobList[zone][SMB+68 ].randomChildrenCount = 2
mobList[zone][SMB+71 ].randomChildrenCount = 2
mobList[zone][SMB+76 ].randomChildrenCount = 1
mobList[zone][SMB+78 ].randomChildrenCount = 1
mobList[zone][SMB+80 ].randomChildrenCount = 1
mobList[zone][SMB+82 ].randomChildrenCount = 2
mobList[zone][SMB+88 ].randomChildrenCount = 2
mobList[zone][SMB+91 ].randomChildrenCount = 2
mobList[zone][SMB+96 ].randomChildrenCount = 1
mobList[zone][SMB+99 ].randomChildrenCount = 3
mobList[zone][SMB+105].randomChildrenCount = 2
mobList[zone][SMB+109].randomChildrenCount = 2
mobList[zone][SMB+112].randomChildrenCount = 1
mobList[zone][SMB+114].randomChildrenCount = 2
mobList[zone][SMB+118].randomChildrenCount = 2
mobList[zone][SMB+121].randomChildrenCount = 5
mobList[zone][SMB+129].randomChildrenCount = 1
mobList[zone][SMB+131].randomChildrenCount = 2
mobList[zone][SMB+134].randomChildrenCount = 2
mobList[zone][SMB+138].randomChildrenCount = 1
mobList[zone][SMB+141].randomChildrenCount = 2
mobList[zone][SMB+145].randomChildrenCount = 1
mobList[zone][SMB+147].randomChildrenCount = 1
mobList[zone][SMB+150].randomChildrenCount = 5
mobList[zone][SMB+157].randomChildrenCount = 1
mobList[zone][SMB+159].randomChildrenCount = 1
mobList[zone][SMB+161].randomChildrenCount = 1
mobList[zone][SMB+163].randomChildrenCount = 1
mobList[zone][SMB+166].randomChildrenCount = 2
mobList[zone][SMB+170].randomChildrenCount = 1
mobList[zone][SMB+174].randomChildrenCount = 2
mobList[zone][SMB+177].randomChildrenCount = 1
mobList[zone][SMB+181].randomChildrenCount = 1
mobList[zone][SMB+183].randomChildrenCount = 1
mobList[zone][SMB+185].randomChildrenCount = 2
mobList[zone][SMB+188].randomChildrenCount = 3
mobList[zone][SMB+195].randomChildrenCount = 2
mobList[zone][SMB+202].randomChildrenCount = 2
mobList[zone][SMB+205].randomChildrenCount = 2
mobList[zone][SMB+211].randomChildrenCount = 1
mobList[zone][SMB+213].randomChildrenCount = 1
mobList[zone][SMB+216].randomChildrenCount = 1
mobList[zone][SMB+218].randomChildrenCount = 2
mobList[zone][SMB+225].randomChildrenCount = 1
mobList[zone][SMB+227].randomChildrenCount = 1
mobList[zone][SMB+229].randomChildrenCount = 1
mobList[zone][SMB+232].randomChildrenCount = 1
mobList[zone][SMB+234].randomChildrenCount = 5
mobList[zone][SMB+241].randomChildrenCount = 1
mobList[zone][SMB+244].randomChildrenCount = 1
mobList[zone][SMB+247].randomChildrenCount = 2
mobList[zone][SMB+251].randomChildrenCount = 1
mobList[zone][SMB+253].randomChildrenCount = 1
mobList[zone][SMB+255].randomChildrenCount = 1
mobList[zone][SMB+258].randomChildrenCount = 1
mobList[zone][SMB+260].randomChildrenCount = 1
mobList[zone][SMB+263].randomChildrenCount = 1
mobList[zone][SMB+265].randomChildrenCount = 1
mobList[zone][SMB+267].randomChildrenCount = 1
mobList[zone][SMB+269].randomChildrenCount = 1
mobList[zone][SMB+273].randomChildrenCount = 2
mobList[zone][SMB+276].randomChildrenCount = 2
mobList[zone][SMB+281].randomChildrenCount = 1
mobList[zone][SMB+283].randomChildrenCount = 1
mobList[zone][SMB+285].randomChildrenCount = 3
mobList[zone][SMB+289].randomChildrenCount = 2
mobList[zone][SMB+294].randomChildrenCount = 1
mobList[zone][SMB+296].randomChildrenCount = 1
mobList[zone][SMB+298].randomChildrenCount = 1
mobList[zone][SMB+300].randomChildrenCount = 1
mobList[zone][SMB+302].randomChildrenCount = 1
mobList[zone][SMB+304].randomChildrenCount = 1
mobList[zone][SMB+306].randomChildrenCount = 1
mobList[zone][SMB+308].randomChildrenCount = 1
mobList[zone][SMB+310].randomChildrenCount = 4
mobList[zone][SMB+316].randomChildrenCount = 4
mobList[zone][SMB+323].randomChildrenCount = 3
mobList[zone][SMB+330].randomChildrenCount = 4
mobList[zone][SMB+336].randomChildrenCount = 4
mobList[zone][SMB+342].randomChildrenCount = 4
mobList[zone][SMB+348].randomChildrenCount = 4
mobList[zone][SMB+356].randomChildrenCount = 5
mobList[zone][SMB+364].randomChildrenCount = 2
mobList[zone][SMB+367].randomChildrenCount = 2
mobList[zone][SMB+370].randomChildrenCount = 2
mobList[zone][SMB+373].randomChildrenCount = 2
mobList[zone][SMB+376].randomChildrenCount = 3
mobList[zone][SMB+381].randomChildrenCount = 1
mobList[zone][SMB+384].randomChildrenCount = 1
mobList[zone][SMB+387].randomChildrenCount = 1
mobList[zone][SMB+390].randomChildrenCount = 5
mobList[zone][SMB+397].randomChildrenCount = 4
mobList[zone][SMB+402].randomChildrenCount = 3
mobList[zone][SMB+407].randomChildrenCount = 2
mobList[zone][SMB+411].randomChildrenCount = 3
mobList[zone][SMB+416].randomChildrenCount = 4
mobList[zone][SMB+423].randomChildrenCount = 5
mobList[zone][SMB+430].randomChildrenCount = 2
mobList[zone][SMB+433].randomChildrenCount = 2
mobList[zone][SMB+437].randomChildrenCount = 2
mobList[zone][SMB+440].randomChildrenCount = 2
mobList[zone][SMB+444].randomChildrenCount = 2
mobList[zone][SMB+448].randomChildrenCount = 2
mobList[zone][SMB+452].randomChildrenCount = 2
mobList[zone][SMB+456].randomChildrenCount = 5
mobList[zone][SMB+464].randomChildrenCount = 5
mobList[zone][SMB+471].randomChildrenCount = 5
mobList[zone][SMB+479].randomChildrenCount = 4
mobList[zone][SMB+485].randomChildrenCount = 4
mobList[zone][SMB+491].randomChildrenCount = 5
mobList[zone][SMB+499].randomChildrenCount = 2
mobList[zone][SMB+504].randomChildrenCount = 5

-- set which mobs will spawn from each statue
mobList[zone][SMB+1  ].randomChildrenList = { 13, 10 }
mobList[zone][SMB+4  ].randomChildrenList = { 5, 7 }
mobList[zone][SMB+7  ].randomChildrenList = { 14, 2 }
mobList[zone][SMB+10 ].randomChildrenList = { 11, 6 }
mobList[zone][SMB+13 ].randomChildrenList = { 9 }
mobList[zone][SMB+16 ].randomChildrenList = { 12 }
mobList[zone][SMB+18 ].randomChildrenList = { 8 }
mobList[zone][SMB+21 ].randomChildrenList = { 4 }
mobList[zone][SMB+24 ].randomChildrenList = { 1, 6 }
mobList[zone][SMB+28 ].randomChildrenList = { 15, 4 }
mobList[zone][SMB+33 ].randomChildrenList = { 2, 8 }
mobList[zone][SMB+38 ].randomChildrenList = { 13, 1 }
mobList[zone][SMB+41 ].randomChildrenList = { 10, 12 }
mobList[zone][SMB+47 ].randomChildrenList = { 5, 3 }
mobList[zone][SMB+50 ].randomChildrenList = { 12, 2 }
mobList[zone][SMB+53 ].randomChildrenList = { 1, 9 }
mobList[zone][SMB+58 ].randomChildrenList = { 5, 8 }
mobList[zone][SMB+63 ].randomChildrenList = { 12, 4 }
mobList[zone][SMB+68 ].randomChildrenList = { 15, 7 }
mobList[zone][SMB+71 ].randomChildrenList = { 15, 7 }
mobList[zone][SMB+76 ].randomChildrenList = { 14 }
mobList[zone][SMB+78 ].randomChildrenList = { 3 }
mobList[zone][SMB+80 ].randomChildrenList = { 11 }
mobList[zone][SMB+82 ].randomChildrenList = { 3, 14 }
mobList[zone][SMB+88 ].randomChildrenList = { 15, 6 }
mobList[zone][SMB+91 ].randomChildrenList = { 10, 9 }
mobList[zone][SMB+96 ].randomChildrenList = { 7 }
mobList[zone][SMB+99 ].randomChildrenList = { 13, 1, 8 }
mobList[zone][SMB+105].randomChildrenList = { 5, 11 }
mobList[zone][SMB+109].randomChildrenList = { 10, 10 }
mobList[zone][SMB+112].randomChildrenList = { 6 }
mobList[zone][SMB+114].randomChildrenList = { 5, 9 }
mobList[zone][SMB+118].randomChildrenList = { 3, 14 }
mobList[zone][SMB+121].randomChildrenList = { 12, 2, 2, 2, 2 }
mobList[zone][SMB+129].randomChildrenList = { 1 }
mobList[zone][SMB+131].randomChildrenList = { 13, 7 }
mobList[zone][SMB+134].randomChildrenList = { 15, 4 }
mobList[zone][SMB+138].randomChildrenList = { 8 }
mobList[zone][SMB+141].randomChildrenList = { 11, 4 }
mobList[zone][SMB+145].randomChildrenList = { 6 }
mobList[zone][SMB+147].randomChildrenList = { 9 }
mobList[zone][SMB+150].randomChildrenList = { 10, 1, 12, 5, 15 }
mobList[zone][SMB+157].randomChildrenList = { 7 }
mobList[zone][SMB+159].randomChildrenList = { 11 }
mobList[zone][SMB+161].randomChildrenList = { 6 }
mobList[zone][SMB+163].randomChildrenList = { 4 }
mobList[zone][SMB+166].randomChildrenList = { 15, 9 }
mobList[zone][SMB+170].randomChildrenList = { 14 }
mobList[zone][SMB+174].randomChildrenList = { 13, 1 }
mobList[zone][SMB+177].randomChildrenList = { 8 }
mobList[zone][SMB+181].randomChildrenList = { 12 }
mobList[zone][SMB+183].randomChildrenList = { 7 }
mobList[zone][SMB+185].randomChildrenList = { 13, 15 }
mobList[zone][SMB+188].randomChildrenList = { 8, 8, 8 }
mobList[zone][SMB+195].randomChildrenList = { 3, 14 }
mobList[zone][SMB+202].randomChildrenList = { 10, 5 }
mobList[zone][SMB+205].randomChildrenList = { 6, 6 }
mobList[zone][SMB+211].randomChildrenList = { 12 }
mobList[zone][SMB+213].randomChildrenList = { 4 }
mobList[zone][SMB+216].randomChildrenList = { 11 }
mobList[zone][SMB+218].randomChildrenList = { 8, 8 }
mobList[zone][SMB+225].randomChildrenList = { 13 }
mobList[zone][SMB+227].randomChildrenList = { 10 }
mobList[zone][SMB+229].randomChildrenList = { 5 }
mobList[zone][SMB+232].randomChildrenList = { 5 }
mobList[zone][SMB+234].randomChildrenList = { 1, 5, 3, 14, 7 }
mobList[zone][SMB+241].randomChildrenList = { 9 }
mobList[zone][SMB+244].randomChildrenList = { 9 }
mobList[zone][SMB+247].randomChildrenList = { 2, 2 }
mobList[zone][SMB+251].randomChildrenList = { 3 }
mobList[zone][SMB+253].randomChildrenList = { 11 }
mobList[zone][SMB+255].randomChildrenList = { 4 }
mobList[zone][SMB+258].randomChildrenList = { 6 }
mobList[zone][SMB+260].randomChildrenList = { 8 }
mobList[zone][SMB+263].randomChildrenList = { 10 }
mobList[zone][SMB+265].randomChildrenList = { 13 }
mobList[zone][SMB+267].randomChildrenList = { 12 }
mobList[zone][SMB+269].randomChildrenList = { 12 }
mobList[zone][SMB+273].randomChildrenList = { 1, 12 }
mobList[zone][SMB+276].randomChildrenList = { 4, 4 }
mobList[zone][SMB+281].randomChildrenList = { 3 }
mobList[zone][SMB+283].randomChildrenList = { 5 }
mobList[zone][SMB+285].randomChildrenList = { 13, 1, 15 }
mobList[zone][SMB+289].randomChildrenList = { 7, 11 }
mobList[zone][SMB+294].randomChildrenList = { 3 }
mobList[zone][SMB+296].randomChildrenList = { 14 }
mobList[zone][SMB+298].randomChildrenList = { 6 }
mobList[zone][SMB+300].randomChildrenList = { 1 }
mobList[zone][SMB+302].randomChildrenList = { 11 }
mobList[zone][SMB+304].randomChildrenList = { 13 }
mobList[zone][SMB+306].randomChildrenList = { 2 }
mobList[zone][SMB+308].randomChildrenList = { 7 }
mobList[zone][SMB+310].randomChildrenList = { 12, 12, 12, 15 }
mobList[zone][SMB+316].randomChildrenList = { 3, 14, 7, 2 }
mobList[zone][SMB+323].randomChildrenList = { 11, 4, 8 }
mobList[zone][SMB+330].randomChildrenList = { 10, 1, 9, 11 }
mobList[zone][SMB+336].randomChildrenList = { 15, 3, 6, 4 }
mobList[zone][SMB+342].randomChildrenList = { 13, 14, 9, 7 }
mobList[zone][SMB+348].randomChildrenList = { 12, 5, 2, 8 }
mobList[zone][SMB+356].randomChildrenList = { 13, 1, 12, 5, 15 }
mobList[zone][SMB+364].randomChildrenList = { 10, 15 }
mobList[zone][SMB+367].randomChildrenList = { 13, 11 }
mobList[zone][SMB+370].randomChildrenList = { 1, 12 }
mobList[zone][SMB+373].randomChildrenList = { 5, 7 }
mobList[zone][SMB+376].randomChildrenList = { 14, 2, 6 }
mobList[zone][SMB+381].randomChildrenList = { 9 }
mobList[zone][SMB+384].randomChildrenList = { 4 }
mobList[zone][SMB+387].randomChildrenList = { 8 }
mobList[zone][SMB+390].randomChildrenList = { 13, 10, 1, 12, 5 }
mobList[zone][SMB+397].randomChildrenList = { 3, 3, 3, 7 }
mobList[zone][SMB+402].randomChildrenList = { 13, 12, 4 }
mobList[zone][SMB+407].randomChildrenList = { 9, 11 }
mobList[zone][SMB+411].randomChildrenList = { 10, 15, 8 }
mobList[zone][SMB+416].randomChildrenList = { 3, 9, 7, 2 }
mobList[zone][SMB+423].randomChildrenList = { 2, 2, 6, 6, 6 }
mobList[zone][SMB+430].randomChildrenList = { 1, 14 }
mobList[zone][SMB+433].randomChildrenList = { 5, 4 }
mobList[zone][SMB+437].randomChildrenList = { 1, 14 }
mobList[zone][SMB+440].randomChildrenList = { 5, 8 }
mobList[zone][SMB+444].randomChildrenList = { 9, 11 }
mobList[zone][SMB+448].randomChildrenList = { 12, 9 }
mobList[zone][SMB+452].randomChildrenList = { 10, 9 }
mobList[zone][SMB+456].randomChildrenList = { 15, 7, 11, 11, 4 }
mobList[zone][SMB+464].randomChildrenList = { 5, 15, 3, 7, 6 }
mobList[zone][SMB+471].randomChildrenList = { 13, 12, 14, 2, 8 }
mobList[zone][SMB+479].randomChildrenList = { 13, 10, 15, 11 }
mobList[zone][SMB+485].randomChildrenList = { 1, 12, 7, 6 }
mobList[zone][SMB+491].randomChildrenList = { 5, 3, 14, 7, 6}
mobList[zone][SMB+499].randomChildrenList = { 4, 8 }
mobList[zone][SMB+504].randomChildrenList = { 13, 10, 10, 1, 2 }

-- random children list - groups assigned to specific mob groups
randomChildrenList[zone] =
{
    [1] = -- Vanguard_Alchemist
    {
        DMB+15 , -- Vanguard_Alchemist
        DMB+44 , -- Vanguard_Alchemist
        DMB+55 , -- Vanguard_Alchemist
        DMB+70 , -- Vanguard_Alchemist
        DMB+87 , -- Vanguard_Alchemist
        DMB+116, -- Vanguard_Alchemist
        DMB+121, -- Vanguard_Alchemist
        DMB+137, -- Vanguard_Alchemist
        DMB+148, -- Vanguard_Alchemist
        DMB+152, -- Vanguard_Alchemist
        DMB+211, -- Vanguard_Alchemist
    },

    [2] = -- Vanguard_Ambusher
    {
        DMB+21 , -- Vanguard_Ambusher
        DMB+42 , -- Vanguard_Ambusher
        DMB+76 , -- Vanguard_Ambusher
        DMB+82 , -- Vanguard_Ambusher
        DMB+83 , -- Vanguard_Ambusher
        DMB+98 , -- Vanguard_Ambusher
        DMB+195, -- Vanguard_Ambusher
        DMB+197, -- Vanguard_Ambusher
        DMB+199, -- Vanguard_Ambusher
        DMB+201, -- Vanguard_Ambusher
        DMB+225, -- Vanguard_Ambusher
    },

    [3] = -- Vanguard_Armorer
    {
        DMB+11 , -- Vanguard_Armorer
        DMB+25 , -- Vanguard_Armorer
        DMB+28 , -- Vanguard_Armorer
        DMB+43 , -- Vanguard_Armorer
        DMB+89 , -- Vanguard_Armorer
        DMB+100, -- Vanguard_Armorer
        DMB+107, -- Vanguard_Armorer
        DMB+168, -- Vanguard_Armorer
        DMB+183, -- Vanguard_Armorer
        DMB+217, -- Vanguard_Armorer
    },

    [4] = -- Vanguard_Dragontamer
    {
        DMB+18 , -- Vanguard_Dragontamer
        DMB+68 , -- Vanguard_Dragontamer
        DMB+84 , -- Vanguard_Dragontamer
        DMB+162, -- Vanguard_Dragontamer
        DMB+188, -- Vanguard_Dragontamer
    },

    [5] = -- Vanguard_Enchanter
    {
        DMB+7  , -- Vanguard_Enchanter
        DMB+20 , -- Vanguard_Enchanter
        DMB+46 , -- Vanguard_Enchanter
        DMB+57 , -- Vanguard_Enchanter
        DMB+72 , -- Vanguard_Enchanter
        DMB+80 , -- Vanguard_Enchanter
        DMB+147, -- Vanguard_Enchanter
        DMB+154, -- Vanguard_Enchanter
        DMB+213, -- Vanguard_Enchanter
    },

    [6] = -- Vanguard_Hitman
    {
        DMB+12 , -- Vanguard_Hitman
        DMB+26 , -- Vanguard_Hitman
        DMB+29 , -- Vanguard_Hitman
        DMB+90 , -- Vanguard_Hitman
        DMB+104, -- Vanguard_Hitman
        DMB+120, -- Vanguard_Hitman
        DMB+196, -- Vanguard_Hitman
        DMB+198, -- Vanguard_Hitman
        DMB+200, -- Vanguard_Hitman
        DMB+202, -- Vanguard_Hitman
        DMB+227, -- Vanguard_Hitman
    },

    [7] = -- Vanguard_Maestro
    {
        DMB+16 , -- Vanguard_Maestro
        DMB+62 , -- Vanguard_Maestro
        DMB+67 , -- Vanguard_Maestro
        DMB+81 , -- Vanguard_Maestro
        DMB+95 , -- Vanguard_Maestro
        DMB+122, -- Vanguard_Maestro
        DMB+166, -- Vanguard_Maestro
        DMB+169, -- Vanguard_Maestro
        DMB+181, -- Vanguard_Maestro
        DMB+184, -- Vanguard_Maestro
    },

    [8] = -- Vanguard_Necromancer
    {
        DMB+22 , -- Vanguard_Necromancer
        DMB+53 , -- Vanguard_Necromancer
        DMB+63 , -- Vanguard_Necromancer
        DMB+109, -- Vanguard_Necromancer
        DMB+172, -- Vanguard_Necromancer
        DMB+179, -- Vanguard_Necromancer
    },

    [9] = -- Vanguard_Pathfinder
    {
        DMB+4  , -- Vanguard_Pathfinder
        DMB+8  , -- Vanguard_Pathfinder
        DMB+77 , -- Vanguard_Pathfinder
        DMB+101, -- Vanguard_Pathfinder
        DMB+105, -- Vanguard_Pathfinder
        DMB+164, -- Vanguard_Pathfinder
        DMB+186, -- Vanguard_Pathfinder
        DMB+219, -- Vanguard_Pathfinder
    },

    [10] = -- Vanguard_Pitfighter
    {
        DMB+14 , -- Vanguard_Pitfighter
        DMB+51 , -- Vanguard_Pitfighter
        DMB+79 , -- Vanguard_Pitfighter
        DMB+86 , -- Vanguard_Pitfighter
        DMB+111, -- Vanguard_Pitfighter
        DMB+135, -- Vanguard_Pitfighter
        DMB+140, -- Vanguard_Pitfighter
        DMB+145, -- Vanguard_Pitfighter
        DMB+151, -- Vanguard_Pitfighter
        DMB+206, -- Vanguard_Pitfighter
    },

    [11] = -- Vanguard_Ronin
    {
        DMB+24 , -- Vanguard_Ronin
        DMB+52 , -- Vanguard_Ronin
        DMB+66 , -- Vanguard_Ronin
        DMB+103, -- Vanguard_Ronin
        DMB+119, -- Vanguard_Ronin
        DMB+167, -- Vanguard_Ronin
        DMB+171, -- Vanguard_Ronin
        DMB+178, -- Vanguard_Ronin
        DMB+182, -- Vanguard_Ronin
    },

    [12] = -- Vanguard_Shaman
    {
        DMB+6  , -- Vanguard_Shaman
        DMB+56 , -- Vanguard_Shaman
        DMB+71 , -- Vanguard_Shaman
        DMB+94 , -- Vanguard_Shaman
        DMB+108, -- Vanguard_Shaman
        DMB+142, -- Vanguard_Shaman
        DMB+149, -- Vanguard_Shaman
        DMB+153, -- Vanguard_Shaman
        DMB+212, -- Vanguard_Shaman
    },

    [13] = -- Vanguard_Smithy
    {
        DMB+2  , -- Vanguard_Smithy
        DMB+40 , -- Vanguard_Smithy
        DMB+50 , -- Vanguard_Smithy
        DMB+93 , -- Vanguard_Smithy
        DMB+99 , -- Vanguard_Smithy
        DMB+115, -- Vanguard_Smithy
        DMB+134, -- Vanguard_Smithy
        DMB+139, -- Vanguard_Smithy
        DMB+144, -- Vanguard_Smithy
        DMB+150, -- Vanguard_Smithy
        DMB+205, -- Vanguard_Smithy
    },

    [14] = -- Vanguard_Tinkerer
    {
        DMB+10 , -- Vanguard_Tinkerer
        DMB+17 , -- Vanguard_Tinkerer
        DMB+88 , -- Vanguard_Tinkerer
        DMB+97 , -- Vanguard_Tinkerer
        DMB+112, -- Vanguard_Tinkerer
        DMB+161, -- Vanguard_Tinkerer
        DMB+170, -- Vanguard_Tinkerer
        DMB+177, -- Vanguard_Tinkerer
        DMB+185, -- Vanguard_Tinkerer
        DMB+218, -- Vanguard_Tinkerer
    },

    [15] = -- Vanguard_Welldigger
    {
        DMB+3  , -- Vanguard_Welldigger
        DMB+41 , -- Vanguard_Welldigger
        DMB+45 , -- Vanguard_Welldigger
        DMB+61 , -- Vanguard_Welldigger
        DMB+75 , -- Vanguard_Welldigger
        DMB+96 , -- Vanguard_Welldigger
        DMB+136, -- Vanguard_Welldigger
        DMB+141, -- Vanguard_Welldigger
        DMB+146, -- Vanguard_Welldigger
        DMB+155, -- Vanguard_Welldigger
        DMB+207, -- Vanguard_Welldigger
    }
}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] =
{

}
