-----------------------------------
--
-- Dynamis-Beaucedine
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/dynamis")
require("scripts/globals/zone")

-----------------------------------

local zone = tpz.zone.DYNAMIS_BEAUCEDINE
local DMB = 17326080 -- dynamis mob base, where zone's mob targetid = 0
local SMB = 17326820 -- statue mob base to allow mobID represented as format SMB + db where db is the dynamisbums.com identifier
-- drop id for statues = 3200, drop id for mobs = 3201

mobList = mobList or { }
randomChildrenList = randomChildrenList or { }
npcList = npcList or { }

mobList[zone] =
{
    [17326081] = { id = DMB+1  }, -- 'Angra_Mainyu'
    [17326082] = { id = DMB+2  }, -- 'Fire_Pukis'
    [17326083] = { id = DMB+3  }, -- 'Poison_Pukis'
    [17326084] = { id = DMB+4  }, -- 'Wind_Pukis'
    [17326085] = { id = DMB+5  }, -- 'Petro_Pukis'
    [17326086] = { id = DMB+6  }, -- 'Goublefaupe'
    [17326087] = { id = DMB+7  }, -- 'Quiebitiel'
    [17326088] = { id = DMB+8  }, -- 'Mildaunegeux'
    [17326089] = { id = DMB+9  }, -- 'Velosareon'
    [17326090] = { id = DMB+10 }, -- 'Dagourmarche'
    [17326091] = { id = DMB+11 }, -- 'Dagourmarches_Wyvern'
    [17326092] = { id = DMB+12 }, -- 'Dagourmarches_Avatar'
    [17326093] = { id = DMB+13 }, -- 'Taquede'
    [17326094] = { id = DMB+14 }, -- 'Taquedes_Wyvern'
    [17326095] = { id = DMB+15 }, -- 'Pignonpausard'
    [17326096] = { id = DMB+16 }, -- 'Hitaume'
    [17326097] = { id = DMB+17 }, -- 'Cavanneche'
    [17326098] = { id = DMB+18 }, -- 'Arch_Angra_Mainyu'
    [17326099] = { id = DMB+19 }, -- 'Vanguard_Vindicator'
    [17326100] = { id = DMB+20 }, -- 'Vanguard_Vindicator'
    [17326101] = { id = DMB+21 }, -- 'Vanguard_Protector'
    [17326102] = { id = DMB+22 }, -- 'Vanguard_Protector'
    [17326103] = { id = DMB+23 }, -- 'Vanguard_Beasttender'
    [17326104] = { id = DMB+24 }, -- 'Vanguards_Scorpion'
    [17326105] = { id = DMB+25 }, -- 'Vanguard_Minstrel'
    [17326106] = { id = DMB+26 }, -- 'GuNha_Wallstormer'
    [17326107] = { id = DMB+27 }, -- 'Vanguard_Militant'
    [17326108] = { id = DMB+28 }, -- 'Vanguard_Militant'
    [17326109] = { id = DMB+29 }, -- 'Vanguard_Protector'
    [17326110] = { id = DMB+30 }, -- 'Vanguard_Protector'
    [17326111] = { id = DMB+31 }, -- 'Vanguard_Drakekeeper'
    [17326112] = { id = DMB+32 }, -- 'Vanguards_Wyvern'
    [17326113] = { id = DMB+33 }, -- 'Vanguard_Minstrel'
    [17326114] = { id = DMB+34 }, -- 'NaHya_Floodmaker'
    [17326115] = { id = DMB+35 }, -- 'Vanguard_Constable'
    [17326116] = { id = DMB+36 }, -- 'Vanguard_Defender'
    [17326117] = { id = DMB+37 }, -- 'Vanguard_Protector'
    [17326118] = { id = DMB+38 }, -- 'Vanguard_Hatamoto'
    [17326119] = { id = DMB+39 }, -- 'Vanguard_Kusa'
    [17326120] = { id = DMB+40 }, -- 'Vanguard_Protector'
    [17326121] = { id = DMB+41 }, -- 'Vanguard_Purloiner'
    [17326122] = { id = DMB+42 }, -- 'Vanguard_Mason'
    [17326123] = { id = DMB+43 }, -- 'Vanguard_Mason'
    [17326124] = { id = DMB+44 }, -- 'Vanguard_Undertaker'
    [17326125] = { id = DMB+45 }, -- 'Vanguards_Avatar'
    [17326126] = { id = DMB+46 }, -- 'JiFhu_Infiltrator'
    [17326127] = { id = DMB+47 }, -- 'Vanguard_Militant'
    [17326128] = { id = DMB+48 }, -- 'Vanguard_Protector'
    [17326129] = { id = DMB+49 }, -- 'Vanguard_Purloiner'
    [17326130] = { id = DMB+50 }, -- 'Vanguard_Vigilante'
    [17326131] = { id = DMB+51 }, -- 'Vanguard_Vindicator'
    [17326132] = { id = DMB+52 }, -- 'Vanguard_Vindicator'
    [17326133] = { id = DMB+53 }, -- 'Vanguard_Militant'
    [17326134] = { id = DMB+54 }, -- 'Vanguard_Constable'
    [17326135] = { id = DMB+55 }, -- 'GaFho_Venomtouch'
    [17326136] = { id = DMB+56 }, -- 'Vanguard_Militant'
    [17326137] = { id = DMB+57 }, -- 'Vanguard_Purloiner'
    [17326138] = { id = DMB+58 }, -- 'Vanguard_Defender'
    [17326139] = { id = DMB+59 }, -- 'Vanguard_Vigilante'
    [17326140] = { id = DMB+60 }, -- 'Vanguard_Vigilante'
    [17326141] = { id = DMB+61 }, -- 'Vanguard_Constable'
    [17326142] = { id = DMB+62 }, -- 'Vanguard_Constable'
    [17326143] = { id = DMB+63 }, -- 'Vanguard_Beasttender'
    [17326144] = { id = DMB+64 }, -- 'Vanguards_Scorpion'
    [17326145] = { id = DMB+65 }, -- 'TaHyu_Gallanthunter'
    [17326146] = { id = DMB+66 }, -- 'Vanguard_Undertaker'
    [17326147] = { id = DMB+67 }, -- 'Vanguards_Avatar'
    [17326148] = { id = DMB+68 }, -- 'Vanguard_Vindicator'
    [17326149] = { id = DMB+69 }, -- 'Vanguard_Vindicator'
    [17326150] = { id = DMB+70 }, -- 'Vanguard_Minstrel'
    [17326151] = { id = DMB+71 }, -- 'NuBhi_Spiraleye'
    [17326152] = { id = DMB+72 }, -- 'Vanguard_Constable'
    [17326153] = { id = DMB+73 }, -- 'Vanguard_Thaumaturge'
    [17326154] = { id = DMB+74 }, -- 'Vanguard_Thaumaturge'
    [17326155] = { id = DMB+75 }, -- 'Vanguard_Protector'
    [17326156] = { id = DMB+76 }, -- 'DeBho_Pyrohand'
    [17326157] = { id = DMB+77 }, -- 'Vanguard_Drakekeeper'
    [17326158] = { id = DMB+78 }, -- 'Vanguards_Wyvern'
    [17326159] = { id = DMB+79 }, -- 'Vanguard_Hatamoto'
    [17326160] = { id = DMB+80 }, -- 'Vanguard_Hatamoto'
    [17326161] = { id = DMB+81 }, -- 'Vanguard_Kusa'
    [17326162] = { id = DMB+82 }, -- 'GoTyo_Magenapper'
    [17326163] = { id = DMB+83 }, -- 'Vanguards_Wyvern'
    [17326164] = { id = DMB+84 }, -- 'Vanguard_Thaumaturge'
    [17326165] = { id = DMB+85 }, -- 'Vanguard_Vigilante'
    [17326166] = { id = DMB+86 }, -- 'Vanguard_Militant'
    [17326167] = { id = DMB+87 }, -- 'Vanguard_Militant'
    [17326168] = { id = DMB+88 }, -- 'SoZho_Metalbender'
    [17326169] = { id = DMB+89 }, -- 'Vanguard_Vindicator'
    [17326170] = { id = DMB+90 }, -- 'Vanguard_Constable'
    [17326171] = { id = DMB+91 }, -- 'Vanguard_Defender'
    [17326172] = { id = DMB+92 }, -- 'Vanguard_Defender'
    [17326173] = { id = DMB+93 }, -- 'MuGha_Legionkiller'
    [17326174] = { id = DMB+94 }, -- 'Vanguard_Purloiner'
    [17326175] = { id = DMB+95 }, -- 'Vanguard_Purloiner'
    [17326176] = { id = DMB+96 }, -- 'Vanguard_Minstrel'
    [17326177] = { id = DMB+97 }, -- 'Vanguard_Beasttender'
    [17326178] = { id = DMB+98 }, -- 'Vanguards_Scorpion'
    [17326179] = { id = DMB+99 }, -- 'SoGho_Adderhandler'
    [17326180] = { id = DMB+100}, -- 'Vanguards_Scorpion'
    [17326181] = { id = DMB+101}, -- 'Vanguard_Vigilante'
    [17326182] = { id = DMB+102}, -- 'Vanguard_Hatamoto'
    [17326183] = { id = DMB+103}, -- 'Vanguard_Mason'
    [17326184] = { id = DMB+104}, -- 'Vanguard_Mason'
    [17326185] = { id = DMB+105}, -- 'GuKhu_Dukesniper'
    [17326186] = { id = DMB+106}, -- 'Vanguard_Constable'
    [17326187] = { id = DMB+107}, -- 'Vanguard_Thaumaturge'
    [17326188] = { id = DMB+108}, -- 'Vanguard_Hatamoto'
    [17326189] = { id = DMB+109}, -- 'Vanguard_Hatamoto'
    [17326190] = { id = DMB+110}, -- 'JiKhu_Towercleaver'
    [17326191] = { id = DMB+111}, -- 'Vanguard_Protector'
    [17326192] = { id = DMB+112}, -- 'Vanguard_Militant'
    [17326193] = { id = DMB+113}, -- 'Vanguard_Kusa'
    [17326194] = { id = DMB+114}, -- 'Vanguard_Kusa'
    [17326195] = { id = DMB+115}, -- 'MiRhe_Whisperblade'
    [17326196] = { id = DMB+116}, -- 'Vanguard_Thaumaturge'
    [17326197] = { id = DMB+117}, -- 'Vanguard_Thaumaturge'
    [17326198] = { id = DMB+118}, -- 'Vanguard_Thaumaturge'
    [17326199] = { id = DMB+119}, -- 'Vanguard_Undertaker'
    [17326200] = { id = DMB+120}, -- 'Vanguards_Avatar'
    [17326201] = { id = DMB+121}, -- 'BeZhe_Keeprazer'
    [17326202] = { id = DMB+122}, -- 'Vanguards_Avatar'
    [17326203] = { id = DMB+123}, -- 'Adamantking_Effigy'
    [17326204] = { id = DMB+124}, -- 'Adamantking_Effigy'
    [17326205] = { id = DMB+125}, -- 'Adamantking_Effigy'
    [17326206] = { id = DMB+126}, -- 'Adamantking_Effigy'
    [17326207] = { id = DMB+127}, -- 'Adamantking_Image'
    [17326208] = { id = DMB+128}, -- 'Vanguard_Trooper'
    [17326209] = { id = DMB+129}, -- 'Vanguard_Neckchopper'
    [17326210] = { id = DMB+130}, -- 'Vanguard_Footsoldier'
    [17326211] = { id = DMB+131}, -- 'Vanguard_Footsoldier'
    [17326212] = { id = DMB+132}, -- 'Humegutter_Adzjbadj'
    [17326213] = { id = DMB+133}, -- 'Vanguard_Vexer'
    [17326214] = { id = DMB+134}, -- 'Vanguard_Vexer'
    [17326215] = { id = DMB+135}, -- 'Vanguard_Backstabber'
    [17326216] = { id = DMB+136}, -- 'Jeunoraider_Gepkzip'
    [17326217] = { id = DMB+137}, -- 'Vanguard_Grappler'
    [17326218] = { id = DMB+138}, -- 'Cobraclaw_Buchzvotch'
    [17326219] = { id = DMB+139}, -- 'Vanguard_Footsoldier'
    [17326220] = { id = DMB+140}, -- 'Vanguard_Gutslasher'
    [17326221] = { id = DMB+141}, -- 'Vanguard_Amputator'
    [17326222] = { id = DMB+142}, -- 'Vanguard_Amputator'
    [17326223] = { id = DMB+143}, -- 'Wraithdancer_Gidbnod'
    [17326224] = { id = DMB+144}, -- 'Vanguard_Backstabber'
    [17326225] = { id = DMB+145}, -- 'Vanguard_Impaler'
    [17326226] = { id = DMB+146}, -- 'Vanguards_Wyvern'
    [17326227] = { id = DMB+147}, -- 'Vanguard_Predator'
    [17326228] = { id = DMB+148}, -- 'Vanguard_Predator'
    [17326229] = { id = DMB+149}, -- 'Galkarider_Retzpratz'
    [17326230] = { id = DMB+150}, -- 'Vanguard_Grappler'
    [17326231] = { id = DMB+151}, -- 'Vanguard_Dollmaster'
    [17326232] = { id = DMB+152}, -- 'Vanguards_Avatar'
    [17326233] = { id = DMB+153}, -- 'Deathcaller_Bidfbid'
    [17326234] = { id = DMB+154}, -- 'Vanguards_Avatar'
    [17326235] = { id = DMB+155}, -- 'Vanguard_Vexer'
    [17326236] = { id = DMB+156}, -- 'Vanguard_Vexer'
    [17326237] = { id = DMB+157}, -- 'Spinalsucker_Galflmall'
    [17326238] = { id = DMB+158}, -- 'Vanguard_Mesmerizer'
    [17326239] = { id = DMB+159}, -- 'Vanguard_Hawker'
    [17326240] = { id = DMB+160}, -- 'Vanguards_Hecteyes'
    [17326241] = { id = DMB+161}, -- 'Vanguard_Pillager'
    [17326242] = { id = DMB+162}, -- 'Vanguard_Pillager'
    [17326243] = { id = DMB+163}, -- 'Lockbuster_Zapdjipp'
    [17326244] = { id = DMB+164}, -- 'Vanguard_Pillager'
    [17326245] = { id = DMB+165}, -- 'Vanguard_Predator'
    [17326246] = { id = DMB+166}, -- 'Vanguard_Trooper'
    [17326247] = { id = DMB+167}, -- 'Vanguard_Trooper'
    [17326248] = { id = DMB+168}, -- 'Heavymail_Djidzbad'
    [17326249] = { id = DMB+169}, -- 'Vanguard_Neckchopper'
    [17326250] = { id = DMB+170}, -- 'Vanguard_Footsoldier'
    [17326251] = { id = DMB+171}, -- 'Vanguard_Bugler'
    [17326252] = { id = DMB+172}, -- 'Vanguard_Dollmaster'
    [17326253] = { id = DMB+173}, -- 'Vanguards_Avatar'
    [17326254] = { id = DMB+174}, -- 'Vanguard_Gutslasher'
    [17326255] = { id = DMB+175}, -- 'Elvaanlopper_Grokdok'
    [17326256] = { id = DMB+176}, -- 'Vanguard_Neckchopper'
    [17326257] = { id = DMB+177}, -- 'Vanguard_Neckchopper'
    [17326258] = { id = DMB+178}, -- 'Skinmask_Ugghfogg'
    [17326259] = { id = DMB+179}, -- 'Vanguard_Amputator'
    [17326260] = { id = DMB+180}, -- 'Vanguard_Mesmerizer'
    [17326261] = { id = DMB+181}, -- 'Vanguard_Mesmerizer'
    [17326262] = { id = DMB+182}, -- 'Taruroaster_Biggsjig'
    [17326263] = { id = DMB+183}, -- 'Vanguard_Hawker'
    [17326264] = { id = DMB+184}, -- 'Vanguards_Hecteyes'
    [17326265] = { id = DMB+185}, -- 'Mithraslaver_Debhabob'
    [17326266] = { id = DMB+186}, -- 'Vanguards_Hecteyes'
    [17326267] = { id = DMB+187}, -- 'Vanguard_Bugler'
    [17326268] = { id = DMB+188}, -- 'Vanguard_Bugler'
    [17326269] = { id = DMB+189}, -- 'Vanguard_Bugler'
    [17326270] = { id = DMB+190}, -- 'Ultrasonic_Zeknajak'
    [17326271] = { id = DMB+191}, -- 'Vanguard_Impaler'
    [17326272] = { id = DMB+192}, -- 'Vanguards_Wyvern'
    [17326273] = { id = DMB+193}, -- 'Drakefeast_Wubmfub'
    [17326274] = { id = DMB+194}, -- 'Vanguards_Wyvern'
    [17326275] = { id = DMB+195}, -- 'Serjeant_Tombstone'
    [17326276] = { id = DMB+196}, -- 'Serjeant_Tombstone'
    [17326277] = { id = DMB+197}, -- 'Serjeant_Tombstone'
    [17326278] = { id = DMB+198}, -- 'Serjeant_Tombstone'
    [17326279] = { id = DMB+199}, -- 'Warchief_Tombstone'
    [17326280] = { id = DMB+200}, -- 'Vanguard_Sentinel'
    [17326281] = { id = DMB+201}, -- 'Vanguard_Assassin'
    [17326282] = { id = DMB+202}, -- 'Vanguard_Skirmisher'
    [17326283] = { id = DMB+203}, -- 'Vanguard_Skirmisher'
    [17326284] = { id = DMB+204}, -- 'Foo_Peku_the_Bloodcloak'
    [17326285] = { id = DMB+205}, -- 'Vanguard_Visionary'
    [17326286] = { id = DMB+206}, -- 'Vanguard_Liberator'
    [17326287] = { id = DMB+207}, -- 'Vanguard_Sentinel'
    [17326288] = { id = DMB+208}, -- 'Vanguard_Sentinel'
    [17326289] = { id = DMB+209}, -- 'Xaa_Chau_the_Roctalon'
    [17326290] = { id = DMB+210}, -- 'Vanguard_Exemplar'
    [17326291] = { id = DMB+211}, -- 'Vanguard_Ogresoother'
    [17326292] = { id = DMB+212}, -- 'Vanguards_Crow'
    [17326293] = { id = DMB+213}, -- 'Vanguard_Priest'
    [17326294] = { id = DMB+214}, -- 'Vanguard_Priest'
    [17326295] = { id = DMB+215}, -- 'Koo_Saxu_the_Everfast'
    [17326296] = { id = DMB+216}, -- 'Vanguard_Inciter'
    [17326297] = { id = DMB+217}, -- 'Vanguard_Chanter'
    [17326298] = { id = DMB+218}, -- 'Vanguard_Prelate'
    [17326299] = { id = DMB+219}, -- 'Vanguard_Prelate'
    [17326300] = { id = DMB+220}, -- 'Bhuu_Wjato_the_Firepool'
    [17326301] = { id = DMB+221}, -- 'Vanguard_Skirmisher'
    [17326302] = { id = DMB+222}, -- 'Vanguard_Visionary'
    [17326303] = { id = DMB+223}, -- 'Vanguard_Visionary'
    [17326304] = { id = DMB+224}, -- 'Caa_Xaza_the_Madpiercer'
    [17326305] = { id = DMB+225}, -- 'Vanguard_Partisan'
    [17326306] = { id = DMB+226}, -- 'Vanguards_Wyvern'
    [17326307] = { id = DMB+227}, -- 'Maa_Zaua_the_Wyrmkeeper'
    [17326308] = { id = DMB+228}, -- 'Vanguards_Wyvern'
    [17326309] = { id = DMB+229}, -- 'Vanguard_Skirmisher'
    [17326310] = { id = DMB+230}, -- 'Vanguard_Priest'
    [17326311] = { id = DMB+231}, -- 'Vanguard_Liberator'
    [17326312] = { id = DMB+232}, -- 'Vanguard_Liberator'
    [17326313] = { id = DMB+233}, -- 'Ryy_Qihi_the_Idolrobber'
    [17326314] = { id = DMB+234}, -- 'Vanguard_Salvager'
    [17326315] = { id = DMB+235}, -- 'Vanguard_Oracle'
    [17326316] = { id = DMB+236}, -- 'Vanguards_Avatar'
    [17326317] = { id = DMB+237}, -- 'Vanguard_Exemplar'
    [17326318] = { id = DMB+238}, -- 'Vanguard_Exemplar'
    [17326319] = { id = DMB+239}, -- 'Guu_Waji_the_Preacher'
    [17326320] = { id = DMB+240}, -- 'Vanguard_Prelate'
    [17326321] = { id = DMB+265}, -- 'Vanguard_Inciter'
    [17326322] = { id = DMB+266}, -- 'Vanguard_Inciter'
    [17326323] = { id = DMB+267}, -- 'Nee_Huxa_the_Judgmental'
    [17326324] = { id = DMB+268}, -- 'Vanguard_Assassin'
    [17326325] = { id = DMB+269}, -- 'Kuu_Xuka_the_Nimble'
    [17326326] = { id = DMB+270}, -- 'Vanguard_Ogresoother'
    [17326327] = { id = DMB+271}, -- 'Vanguards_Crow'
    [17326328] = { id = DMB+272}, -- 'Soo_Jopo_the_Fiendking'
    [17326329] = { id = DMB+273}, -- 'Vanguards_Crow'
    [17326330] = { id = DMB+274}, -- 'Vanguard_Persecutor'
    [17326331] = { id = DMB+275}, -- 'Vanguard_Partisan'
    [17326332] = { id = DMB+276}, -- 'Vanguards_Wyvern'
    [17326333] = { id = DMB+277}, -- 'Vanguard_Chanter'
    [17326334] = { id = DMB+278}, -- 'Vanguard_Chanter'
    [17326335] = { id = DMB+279}, -- 'Xhoo_Fuza_the_Sublime'
    [17326336] = { id = DMB+280}, -- 'Vanguard_Liberator'
    [17326337] = { id = DMB+281}, -- 'Vanguard_Prelate'
    [17326338] = { id = DMB+282}, -- 'Vanguard_Salvager'
    [17326339] = { id = DMB+283}, -- 'Vanguard_Salvager'
    [17326340] = { id = DMB+284}, -- 'Hee_Mida_the_Meticulous'
    [17326341] = { id = DMB+285}, -- 'Vanguard_Assassin'
    [17326342] = { id = DMB+286}, -- 'Vanguard_Persecutor'
    [17326343] = { id = DMB+287}, -- 'Vanguard_Persecutor'
    [17326344] = { id = DMB+288}, -- 'Knii_Hoqo_the_Bisector'
    [17326345] = { id = DMB+289}, -- 'Vanguard_Oracle'
    [17326346] = { id = DMB+290}, -- 'Vanguards_Avatar'
    [17326347] = { id = DMB+291}, -- 'Puu_Timu_the_Phantasmal'
    [17326348] = { id = DMB+292}, -- 'Vanguards_Avatar'
    [17326349] = { id = DMB+293}, -- 'Avatar_Icon'
    [17326350] = { id = DMB+294}, -- 'Avatar_Icon'
    [17326351] = { id = DMB+295}, -- 'Avatar_Icon'
    [17326352] = { id = DMB+296}, -- 'Avatar_Icon'
    [17326353] = { id = DMB+297}, -- 'Avatar_Idol'
    [17326354] = { id = DMB+298}, -- 'Vanguard_Smithy'
    [17326355] = { id = DMB+299}, -- 'Vanguard_Pitfighter'
    [17326356] = { id = DMB+300}, -- 'Vanguard_Shaman'
    [17326357] = { id = DMB+301}, -- 'Vanguard_Enchanter'
    [17326358] = { id = DMB+302}, -- 'Vanguard_Pathfinder'
    [17326359] = { id = DMB+303}, -- 'Vanguards_Slime'
    [17326360] = { id = DMB+304}, -- 'Vanguard_Maestro'
    [17326361] = { id = DMB+305}, -- 'Vanguard_Enchanter'
    [17326362] = { id = DMB+306}, -- 'Vanguard_Welldigger'
    [17326363] = { id = DMB+307}, -- 'Vanguard_Armorer'
    [17326364] = { id = DMB+308}, -- 'Vanguard_Shaman'
    [17326365] = { id = DMB+309}, -- 'Vanguard_Armorer'
    [17326366] = { id = DMB+310}, -- 'Vanguard_Maestro'
    [17326367] = { id = DMB+311}, -- 'Vanguard_Ambusher'
    [17326368] = { id = DMB+312}, -- 'Vanguard_Necromancer'
    [17326369] = { id = DMB+313}, -- 'Vanguards_Avatar'
    [17326370] = { id = DMB+314}, -- 'Vanguard_Welldigger'
    [17326371] = { id = DMB+315}, -- 'Vanguard_Armorer'
    [17326372] = { id = DMB+316}, -- 'Vanguard_Smithy'
    [17326373] = { id = DMB+317}, -- 'Vanguard_Smithy'
    [17326374] = { id = DMB+318}, -- 'Moltenox_Stubthumbs'
    [17326375] = { id = DMB+319}, -- 'Vanguard_Ronin'
    [17326376] = { id = DMB+320}, -- 'Vanguard_Hitman'
    [17326377] = { id = DMB+321}, -- 'Vanguard_Pitfighter'
    [17326378] = { id = DMB+322}, -- 'Vanguard_Pitfighter'
    [17326379] = { id = DMB+323}, -- 'Droprix_Granitepalms'
    [17326380] = { id = DMB+324}, -- 'Vanguard_Shaman'
    [17326381] = { id = DMB+325}, -- 'Vanguard_Enchanter'
    [17326382] = { id = DMB+326}, -- 'Vanguard_Welldigger'
    [17326383] = { id = DMB+327}, -- 'Vanguard_Dragontamer'
    [17326384] = { id = DMB+328}, -- 'Vanguards_Wyvern'
    [17326385] = { id = DMB+329}, -- 'Vanguard_Alchemist'
    [17326386] = { id = DMB+330}, -- 'Vanguard_Alchemist'
    [17326387] = { id = DMB+331}, -- 'Brewnix_Bittypupils'
    [17326388] = { id = DMB+332}, -- 'Vanguard_Smithy'
    [17326389] = { id = DMB+333}, -- 'Vanguard_Enchanter'
    [17326390] = { id = DMB+334}, -- 'Vanguard_Alchemist'
    [17326391] = { id = DMB+335}, -- 'Vanguard_Necromancer'
    [17326392] = { id = DMB+336}, -- 'Vanguards_Avatar'
    [17326393] = { id = DMB+337}, -- 'Vanguard_Pitfighter'
    [17326394] = { id = DMB+338}, -- 'Vanguard_Ambusher'
    [17326395] = { id = DMB+339}, -- 'Vanguard_Shaman'
    [17326396] = { id = DMB+340}, -- 'Vanguard_Shaman'
    [17326397] = { id = DMB+341}, -- 'Ascetox_Ratgums'
    [17326398] = { id = DMB+342}, -- 'Vanguard_Armorer'
    [17326399] = { id = DMB+343}, -- 'Vanguard_Enchanter'
    [17326400] = { id = DMB+344}, -- 'Vanguard_Enchanter'
    [17326401] = { id = DMB+345}, -- 'Gibberox_Pimplebeak'
    [17326402] = { id = DMB+346}, -- 'Vanguard_Welldigger'
    [17326403] = { id = DMB+347}, -- 'Vanguard_Hitman'
    [17326404] = { id = DMB+348}, -- 'Vanguard_Hitman'
    [17326405] = { id = DMB+349}, -- 'Swypestix_Tigershins'
    [17326406] = { id = DMB+350}, -- 'Vanguard_Pathfinder'
    [17326407] = { id = DMB+351}, -- 'Vanguards_Slime'
    [17326408] = { id = DMB+352}, -- 'Vanguard_Welldigger'
    [17326409] = { id = DMB+353}, -- 'Vanguard_Welldigger'
    [17326410] = { id = DMB+354}, -- 'Bordox_Kittyback'
    [17326411] = { id = DMB+355}, -- 'Vanguard_Tinkerer'
    [17326412] = { id = DMB+356}, -- 'Vanguard_Maestro'
    [17326413] = { id = DMB+357}, -- 'Vanguard_Armorer'
    [17326414] = { id = DMB+358}, -- 'Vanguard_Armorer'
    [17326415] = { id = DMB+359}, -- 'Ruffbix_Jumbolobes'
    [17326416] = { id = DMB+360}, -- 'Vanguard_Maestro'
    [17326417] = { id = DMB+361}, -- 'Vanguard_Pathfinder'
    [17326418] = { id = DMB+362}, -- 'Vanguards_Slime'
    [17326419] = { id = DMB+363}, -- 'Vanguard_Dragontamer'
    [17326420] = { id = DMB+364}, -- 'Vanguards_Wyvern'
    [17326421] = { id = DMB+365}, -- 'Draklix_Scalecrust'
    [17326422] = { id = DMB+366}, -- 'Vanguards_Wyvern'
    [17326423] = { id = DMB+367}, -- 'Vanguard_Smithy'
    [17326424] = { id = DMB+368}, -- 'Vanguard_Pitfighter'
    [17326425] = { id = DMB+369}, -- 'Vanguard_Tinkerer'
    [17326426] = { id = DMB+370}, -- 'Vanguard_Tinkerer'
    [17326427] = { id = DMB+371}, -- 'Tocktix_Thinlids'
    [17326428] = { id = DMB+372}, -- 'Vanguard_Pitfighter'
    [17326429] = { id = DMB+373}, -- 'Vanguard_Pitfighter'
    [17326430] = { id = DMB+374}, -- 'Vanguard_Pitfighter'
    [17326431] = { id = DMB+375}, -- 'Vanguard_Alchemist'
    [17326432] = { id = DMB+376}, -- 'Vanguard_Alchemist'
    [17326433] = { id = DMB+377}, -- 'Vanguard_Alchemist'
    [17326434] = { id = DMB+378}, -- 'Vanguard_Maestro'
    [17326435] = { id = DMB+379}, -- 'Vanguard_Dragontamer'
    [17326436] = { id = DMB+380}, -- 'Vanguards_Wyvern'
    [17326437] = { id = DMB+381}, -- 'Vanguard_Pathfinder'
    [17326438] = { id = DMB+382}, -- 'Vanguards_Slime'
    [17326439] = { id = DMB+383}, -- 'Routsix_Rubbertendon'
    [17326440] = { id = DMB+384}, -- 'Vanguards_Slime'
    [17326441] = { id = DMB+385}, -- 'Vanguard_Armorer'
    [17326442] = { id = DMB+386}, -- 'Vanguard_Shaman'
    [17326443] = { id = DMB+387}, -- 'Vanguard_Enchanter'
    [17326444] = { id = DMB+388}, -- 'Vanguard_Necromancer'
    [17326445] = { id = DMB+389}, -- 'Vanguards_Avatar'
    [17326446] = { id = DMB+390}, -- 'Morblox_Chubbychin'
    [17326447] = { id = DMB+391}, -- 'Vanguards_Avatar'
    [17326448] = { id = DMB+392}, -- 'Vanguard_Armorer'
    [17326449] = { id = DMB+393}, -- 'Vanguard_Ronin'
    [17326450] = { id = DMB+394}, -- 'Vanguard_Maestro'
    [17326451] = { id = DMB+395}, -- 'Vanguard_Maestro'
    [17326452] = { id = DMB+396}, -- 'Whistrix_Toadthroat'
    [17326453] = { id = DMB+397}, -- 'Vanguard_Welldigger'
    [17326454] = { id = DMB+398}, -- 'Vanguard_Dragontamer'
    [17326455] = { id = DMB+399}, -- 'Vanguards_Wyvern'
    [17326456] = { id = DMB+400}, -- 'Vanguard_Ambusher'
    [17326457] = { id = DMB+401}, -- 'Vanguard_Ambusher'
    [17326458] = { id = DMB+402}, -- 'Slinkix_Trufflesniff'
    [17326459] = { id = DMB+403}, -- 'Vanguard_Pitfighter'
    [17326460] = { id = DMB+404}, -- 'Vanguard_Hitman'
    [17326461] = { id = DMB+405}, -- 'Vanguard_Ronin'
    [17326462] = { id = DMB+406}, -- 'Vanguard_Ronin'
    [17326463] = { id = DMB+407}, -- 'Shisox_Widebrow'
    [17326464] = { id = DMB+408}, -- 'Goblin_Replica'
    [17326465] = { id = DMB+409}, -- 'Goblin_Replica'
    [17326466] = { id = DMB+410}, -- 'Goblin_Replica'
    [17326467] = { id = DMB+411}, -- 'Goblin_Replica'
    [17326468] = { id = DMB+412}, -- 'Goblin_Statue'
    [17326469] = { id = DMB+413}, -- 'Hydra_Warrior'
    [17326470] = { id = DMB+414}, -- 'Hydra_Monk'
    [17326471] = { id = DMB+415}, -- 'Hydra_White_Mage'
    [17326472] = { id = DMB+416}, -- 'Hydra_Red_Mage'
    [17326473] = { id = DMB+417}, -- 'Vanguard_Eye'
    [17326474] = { id = DMB+418}, -- 'Hydra_Monk'
    [17326475] = { id = DMB+419}, -- 'Hydra_Black_Mage'
    [17326476] = { id = DMB+420}, -- 'Hydra_Red_Mage'
    [17326477] = { id = DMB+421}, -- 'Hydra_Thief'
    [17326478] = { id = DMB+422}, -- 'Vanguard_Eye'
    [17326479] = { id = DMB+423}, -- 'Hydra_White_Mage'
    [17326480] = { id = DMB+424}, -- 'Hydra_Paladin'
    [17326481] = { id = DMB+425}, -- 'Hydra_Dark_Knight'
    [17326482] = { id = DMB+426}, -- 'Hydra_Beastmaster'
    [17326483] = { id = DMB+427}, -- 'Hydras_Hound'
    [17326484] = { id = DMB+428}, -- 'Vanguard_Eye'
    [17326485] = { id = DMB+429}, -- 'Hydra_Bard'
    [17326486] = { id = DMB+430}, -- 'Hydra_Ranger'
    [17326487] = { id = DMB+431}, -- 'Hydra_Samurai'
    [17326488] = { id = DMB+432}, -- 'Hydra_Samurai'
    [17326489] = { id = DMB+433}, -- 'Hydra_Samurai'
    [17326490] = { id = DMB+434}, -- 'Hydra_Ninja'
    [17326491] = { id = DMB+435}, -- 'Hydra_Ninja'
    [17326492] = { id = DMB+436}, -- 'Hydra_Dragoon'
    [17326493] = { id = DMB+437}, -- 'Hydras_Wyvern'
    [17326494] = { id = DMB+438}, -- 'Vanguard_Eye'
    [17326495] = { id = DMB+439}, -- 'Hydra_Samurai'
    [17326496] = { id = DMB+440}, -- 'Hydra_Samurai'
    [17326497] = { id = DMB+441}, -- 'Hydra_Ninja'
    [17326498] = { id = DMB+442}, -- 'Hydra_Ninja'
    [17326499] = { id = DMB+443}, -- 'Hydra_Summoner'
    [17326500] = { id = DMB+444}, -- 'Hydras_Avatar'
    [17326501] = { id = DMB+445}, -- 'Vanguard_Eye'
    [17326502] = { id = DMB+446}, -- 'Hydra_Warrior'
    [17326503] = { id = DMB+447}, -- 'Hydra_Dragoon'
    [17326504] = { id = DMB+448}, -- 'Hydras_Wyvern'
    [17326505] = { id = DMB+449}, -- 'Hydra_Summoner'
    [17326506] = { id = DMB+450}, -- 'Hydras_Avatar'
    [17326507] = { id = DMB+451}, -- 'Vanguard_Eye'
    [17326508] = { id = DMB+452}, -- 'Hydra_Warrior'
    [17326509] = { id = DMB+453}, -- 'Hydra_Beastmaster'
    [17326510] = { id = DMB+454}, -- 'Hydras_Hound'
    [17326511] = { id = DMB+455}, -- 'Hydra_Samurai'
    [17326512] = { id = DMB+456}, -- 'Hydra_Warrior'
    [17326513] = { id = DMB+457}, -- 'Hydra_Samurai'
    [17326514] = { id = DMB+458}, -- 'Vanguard_Eye'
    [17326515] = { id = DMB+459}, -- 'Hydra_Monk'
    [17326516] = { id = DMB+460}, -- 'Hydra_Ranger'
    [17326517] = { id = DMB+461}, -- 'Hydra_White_Mage'
    [17326518] = { id = DMB+462}, -- 'Hydra_Red_Mage'
    [17326519] = { id = DMB+463}, -- 'Vanguard_Eye'
    [17326520] = { id = DMB+464}, -- 'Hydra_Paladin'
    [17326521] = { id = DMB+465}, -- 'Hydra_Black_Mage'
    [17326522] = { id = DMB+466}, -- 'Hydra_White_Mage'
    [17326523] = { id = DMB+467}, -- 'Hydra_Red_Mage'
    [17326524] = { id = DMB+468}, -- 'Hydra_Thief'
    [17326525] = { id = DMB+469}, -- 'Vanguard_Eye'
    [17326526] = { id = DMB+470}, -- 'Hydra_Bard'
    [17326527] = { id = DMB+471}, -- 'Hydra_Paladin'
    [17326528] = { id = DMB+472}, -- 'Hydra_White_Mage'
    [17326529] = { id = DMB+473}, -- 'Hydra_Ninja'
    [17326530] = { id = DMB+474}, -- 'Vanguard_Eye'
    [17326531] = { id = DMB+475}, -- 'Hydra_Dragoon'
    [17326532] = { id = DMB+476}, -- 'Hydras_Wyvern'
    [17326533] = { id = DMB+477}, -- 'Hydra_Bard'
    [17326534] = { id = DMB+478}, -- 'Hydra_Dark_Knight'
    [17326535] = { id = DMB+479}, -- 'Hydra_Ninja'
    [17326536] = { id = DMB+480}, -- 'Vanguard_Eye'
    [17326537] = { id = DMB+481}, -- 'Hydra_Paladin'
    [17326538] = { id = DMB+482}, -- 'Hydra_Warrior'
    [17326539] = { id = DMB+483}, -- 'Hydra_Monk'
    [17326540] = { id = DMB+484}, -- 'Hydra_Summoner'
    [17326541] = { id = DMB+485}, -- 'Hydras_Avatar'
    [17326542] = { id = DMB+486}, -- 'Vanguard_Eye'
    [17326543] = { id = DMB+487}, -- 'Hydra_Ranger'
    [17326544] = { id = DMB+488}, -- 'Hydra_White_Mage'
    [17326545] = { id = DMB+489}, -- 'Hydra_Black_Mage'
    [17326546] = { id = DMB+490}, -- 'Hydra_Paladin'
    [17326547] = { id = DMB+491}, -- 'Vanguard_Eye'
    [17326548] = { id = DMB+492}, -- 'Hydra_Paladin'
    [17326549] = { id = DMB+493}, -- 'Hydra_Dragoon'
    [17326550] = { id = DMB+494}, -- 'Hydras_Wyvern'
    [17326551] = { id = DMB+495}, -- 'Hydra_Dark_Knight'
    [17326552] = { id = DMB+496}, -- 'Hydra_Ranger'
    [17326553] = { id = DMB+497}, -- 'Vanguard_Eye'
    [17326554] = { id = DMB+498}, -- 'Hydra_Dark_Knight'
    [17326555] = { id = DMB+499}, -- 'Hydra_Thief'
    [17326556] = { id = DMB+500}, -- 'Hydra_Samurai'
    [17326557] = { id = DMB+501}, -- 'Hydra_Ninja'
    [17326558] = { id = DMB+502}, -- 'Vanguard_Eye'
    [17326559] = { id = DMB+503}, -- 'Hydra_Warrior'
    [17326560] = { id = DMB+504}, -- 'Hydra_White_Mage'
    [17326561] = { id = DMB+505}, -- 'Hydra_Black_Mage'
    [17326562] = { id = DMB+506}, -- 'Hydra_Warrior'
    [17326563] = { id = DMB+507}, -- 'Hydra_White_Mage'
    [17326564] = { id = DMB+508}, -- 'Hydra_Black_Mage'
    [17326565] = { id = DMB+509}, -- 'Vanguard_Eye'
    [17326566] = { id = DMB+510}, -- 'Hydra_Samurai'
    [17326567] = { id = DMB+511}, -- 'Hydra_Ninja'
    [17326568] = { id = DMB+512}, -- 'Hydra_Monk'
    [17326569] = { id = DMB+513}, -- 'Hydra_Samurai'
    [17326570] = { id = DMB+514}, -- 'Hydra_Ninja'
    [17326571] = { id = DMB+515}, -- 'Hydra_Monk'
    [17326572] = { id = DMB+516}, -- 'Vanguard_Eye'
    [17326573] = { id = DMB+517}, -- 'Hydra_White_Mage'
    [17326574] = { id = DMB+518}, -- 'Hydra_Black_Mage'
    [17326575] = { id = DMB+519}, -- 'Hydra_Red_Mage'
    [17326576] = { id = DMB+520}, -- 'Hydra_White_Mage'
    [17326577] = { id = DMB+521}, -- 'Hydra_Black_Mage'
    [17326578] = { id = DMB+522}, -- 'Hydra_Red_Mage'
    [17326579] = { id = DMB+523}, -- 'Vanguard_Eye'
    [17326580] = { id = DMB+524}, -- 'Hydra_Thief'
    [17326581] = { id = DMB+525}, -- 'Hydra_Dark_Knight'
    [17326582] = { id = DMB+526}, -- 'Hydra_Thief'
    [17326583] = { id = DMB+527}, -- 'Hydra_Dark_Knight'
    [17326584] = { id = DMB+528}, -- 'Hydra_Summoner'
    [17326585] = { id = DMB+529}, -- 'Hydras_Avatar'
    [17326586] = { id = DMB+530}, -- 'Vanguard_Eye'
    [17326587] = { id = DMB+531}, -- 'Hydra_Beastmaster'
    [17326588] = { id = DMB+532}, -- 'Hydras_Hound'
    [17326589] = { id = DMB+533}, -- 'Hydra_Bard'
    [17326590] = { id = DMB+534}, -- 'Hydra_Ranger'
    [17326591] = { id = DMB+535}, -- 'Hydra_Bard'
    [17326592] = { id = DMB+536}, -- 'Hydra_Ranger'
    [17326593] = { id = DMB+537}, -- 'Vanguard_Eye'
    [17326594] = { id = DMB+538}, -- 'Hydra_Dragoon'
    [17326595] = { id = DMB+539}, -- 'Hydras_Wyvern'
    [17326596] = { id = DMB+540}, -- 'Hydra_Paladin'
    [17326597] = { id = DMB+541}, -- 'Hydra_Thief'
    [17326598] = { id = DMB+542}, -- 'Hydra_Paladin'
    [17326599] = { id = DMB+543}, -- 'Hydra_Thief'
    [17326600] = { id = DMB+544}, -- 'Vanguard_Eye'
    [17326601] = { id = DMB+545}, -- 'Hydra_Beastmaster'
    [17326602] = { id = DMB+546}, -- 'Hydras_Hound'
    [17326603] = { id = DMB+547}, -- 'Hydra_Beastmaster'
    [17326604] = { id = DMB+548}, -- 'Hydras_Hound'
    [17326605] = { id = DMB+549}, -- 'Hydra_Thief'
    [17326606] = { id = DMB+550}, -- 'Hydra_Dark_Knight'
    [17326607] = { id = DMB+551}, -- 'Vanguard_Eye'
    [17326608] = { id = DMB+552}, -- 'Hydra_Warrior'
    [17326609] = { id = DMB+553}, -- 'Hydra_Warrior'
    [17326610] = { id = DMB+554}, -- 'Hydra_Bard'
    [17326611] = { id = DMB+555}, -- 'Hydra_Ranger'
    [17326612] = { id = DMB+556}, -- 'Vanguard_Eye'
    [17326613] = { id = DMB+557}, -- 'Hydra_White_Mage'
    [17326614] = { id = DMB+558}, -- 'Hydra_White_Mage'
    [17326615] = { id = DMB+559}, -- 'Hydra_Thief'
    [17326616] = { id = DMB+560}, -- 'Hydra_Dark_Knight'
    [17326617] = { id = DMB+561}, -- 'Vanguard_Eye'
    [17326618] = { id = DMB+562}, -- 'Hydra_Monk'
    [17326619] = { id = DMB+563}, -- 'Hydra_Monk'
    [17326620] = { id = DMB+564}, -- 'Hydra_Ninja'
    [17326621] = { id = DMB+565}, -- 'Hydra_Summoner'
    [17326622] = { id = DMB+566}, -- 'Hydras_Avatar'
    [17326623] = { id = DMB+567}, -- 'Vanguard_Eye'
    [17326624] = { id = DMB+568}, -- 'Hydra_Black_Mage'
    [17326625] = { id = DMB+569}, -- 'Hydra_Black_Mage'
    [17326626] = { id = DMB+570}, -- 'Hydra_Warrior'
    [17326627] = { id = DMB+571}, -- 'Hydra_Dragoon'
    [17326628] = { id = DMB+572}, -- 'Hydras_Wyvern'
    [17326629] = { id = DMB+573}, -- 'Vanguard_Eye'
    [17326630] = { id = DMB+574}, -- 'Hydra_Red_Mage'
    [17326631] = { id = DMB+575}, -- 'Hydra_Red_Mage'
    [17326632] = { id = DMB+576}, -- 'Hydra_Paladin'
    [17326633] = { id = DMB+577}, -- 'Hydra_Monk'
    [17326634] = { id = DMB+578}, -- 'Vanguard_Eye'
    [17326635] = { id = DMB+579}, -- 'Hydra_Thief'
    [17326636] = { id = DMB+580}, -- 'Hydra_Thief'
    [17326637] = { id = DMB+581}, -- 'Hydra_White_Mage'
    [17326638] = { id = DMB+582}, -- 'Hydra_Samurai'
    [17326639] = { id = DMB+583}, -- 'Vanguard_Eye'
    [17326640] = { id = DMB+584}, -- 'Hydra_Dragoon'
    [17326641] = { id = DMB+585}, -- 'Hydras_Wyvern'
    [17326642] = { id = DMB+586}, -- 'Hydra_Dragoon'
    [17326643] = { id = DMB+587}, -- 'Hydras_Wyvern'
    [17326644] = { id = DMB+588}, -- 'Hydra_Red_Mage'
    [17326645] = { id = DMB+589}, -- 'Hydra_Bard'
    [17326646] = { id = DMB+590}, -- 'Vanguard_Eye'
    [17326647] = { id = DMB+591}, -- 'Hydra_Paladin'
    [17326648] = { id = DMB+592}, -- 'Hydra_Paladin'
    [17326649] = { id = DMB+593}, -- 'Hydra_Monk'
    [17326650] = { id = DMB+594}, -- 'Hydra_Thief'
    [17326651] = { id = DMB+595}, -- 'Vanguard_Eye'
    [17326652] = { id = DMB+596}, -- 'Hydra_Dark_Knight'
    [17326653] = { id = DMB+597}, -- 'Hydra_Dark_Knight'
    [17326654] = { id = DMB+598}, -- 'Hydra_White_Mage'
    [17326655] = { id = DMB+599}, -- 'Hydra_Black_Mage'
    [17326656] = { id = DMB+600}, -- 'Vanguard_Eye'
    [17326657] = { id = DMB+601}, -- 'Hydra_Bard'
    [17326658] = { id = DMB+602}, -- 'Hydra_Bard'
    [17326659] = { id = DMB+603}, -- 'Hydra_Samurai'
    [17326660] = { id = DMB+604}, -- 'Hydra_Monk'
    [17326661] = { id = DMB+605}, -- 'Vanguard_Eye'
    [17326662] = { id = DMB+606}, -- 'Hydra_Summoner'
    [17326663] = { id = DMB+607}, -- 'Hydras_Avatar'
    [17326664] = { id = DMB+608}, -- 'Hydra_Summoner'
    [17326665] = { id = DMB+609}, -- 'Hydras_Avatar'
    [17326666] = { id = DMB+610}, -- 'Hydra_Ninja'
    [17326667] = { id = DMB+611}, -- 'Hydra_Dark_Knight'
    [17326668] = { id = DMB+612}, -- 'Vanguard_Eye'
    [17326669] = { id = DMB+613}, -- 'Hydra_Ranger'
    [17326670] = { id = DMB+614}, -- 'Hydra_Ranger'
    [17326671] = { id = DMB+615}, -- 'Hydra_Dark_Knight'
    [17326672] = { id = DMB+616}, -- 'Hydra_Ninja'
    [17326673] = { id = DMB+617}, -- 'Vanguard_Eye'
    [17326674] = { id = DMB+618}, -- 'Hydra_Samurai'
    [17326675] = { id = DMB+619}, -- 'Hydra_Samurai'
    [17326676] = { id = DMB+620}, -- 'Hydra_Warrior'
    [17326677] = { id = DMB+621}, -- 'Hydra_White_Mage'
    [17326678] = { id = DMB+622}, -- 'Vanguard_Eye'
    [17326679] = { id = DMB+623}, -- 'Hydra_Ninja'
    [17326680] = { id = DMB+624}, -- 'Hydra_Ninja'
    [17326681] = { id = DMB+625}, -- 'Hydra_Black_Mage'
    [17326682] = { id = DMB+626}, -- 'Hydra_Paladin'
    [17326683] = { id = DMB+627}, -- 'Vanguard_Eye'
    [17326684] = { id = DMB+628}, -- 'Hydra_Thief'
    [17326685] = { id = DMB+629}, -- 'Hydra_Beastmaster'
    [17326686] = { id = DMB+630}, -- 'Hydras_Hound'
    [17326687] = { id = DMB+631}, -- 'Hydra_Ranger'
    [17326688] = { id = DMB+632}, -- 'Vanguard_Eye'
    [17326689] = { id = DMB+633}, -- 'Hydra_Black_Mage'
    [17326690] = { id = DMB+634}, -- 'Hydra_Paladin'
    [17326691] = { id = DMB+635}, -- 'Hydra_Ninja'
    [17326692] = { id = DMB+636}, -- 'Vanguard_Eye'
    [17326693] = { id = DMB+637}, -- 'Hydra_Warrior'
    [17326694] = { id = DMB+638}, -- 'Hydra_Monk'
    [17326695] = { id = DMB+639}, -- 'Hydra_Samurai'
    [17326696] = { id = DMB+640}, -- 'Vanguard_Eye'
    [17326697] = { id = DMB+641}, -- 'Hydra_White_Mage'
    [17326698] = { id = DMB+642}, -- 'Hydra_Dark_Knight'
    [17326699] = { id = DMB+643}, -- 'Hydra_Summoner'
    [17326700] = { id = DMB+644}, -- 'Hydras_Avatar'
    [17326701] = { id = DMB+645}, -- 'Vanguard_Eye'
    [17326702] = { id = DMB+646}, -- 'Hydra_Red_Mage'
    [17326703] = { id = DMB+647}, -- 'Hydra_Bard'
    [17326704] = { id = DMB+648}, -- 'Hydra_Dragoon'
    [17326705] = { id = DMB+649}, -- 'Hydras_Wyvern'
    [17326706] = { id = DMB+650}, -- 'Vanguard_Eye'
    [17326707] = { id = DMB+651}, -- 'Hydra_Warrior'
    [17326708] = { id = DMB+652}, -- 'Hydra_White_Mage'
    [17326709] = { id = DMB+653}, -- 'Hydra_Monk'
    [17326710] = { id = DMB+654}, -- 'Hydra_Red_Mage'
    [17326711] = { id = DMB+655}, -- 'Hydra_White_Mage'
    [17326712] = { id = DMB+656}, -- 'Hydra_Thief'
    [17326713] = { id = DMB+657}, -- 'Hydra_Paladin'
    [17326714] = { id = DMB+658}, -- 'Hydra_Dark_Knight'
    [17326715] = { id = DMB+659}, -- 'Hydra_Beastmaster'
    [17326716] = { id = DMB+660}, -- 'Hydras_Hound'
    [17326717] = { id = DMB+661}, -- 'Hydra_Warrior'
    [17326718] = { id = DMB+662}, -- 'Hydra_Thief'
    [17326719] = { id = DMB+663}, -- 'Hydra_Bard'
    [17326720] = { id = DMB+664}, -- 'Hydra_White_Mage'
    [17326721] = { id = DMB+665}, -- 'Vanguard_Eye'
    [17326722] = { id = DMB+666}, -- 'Hydra_Monk'
    [17326723] = { id = DMB+667}, -- 'Hydra_Samurai'
    [17326724] = { id = DMB+668}, -- 'Hydra_Summoner'
    [17326725] = { id = DMB+669}, -- 'Hydras_Avatar'
    [17326726] = { id = DMB+670}, -- 'Hydra_Red_Mage'
    [17326727] = { id = DMB+671}, -- 'Vanguard_Eye'
    [17326728] = { id = DMB+672}, -- 'Hydra_Paladin'
    [17326729] = { id = DMB+673}, -- 'Hydra_Ninja'
    [17326730] = { id = DMB+674}, -- 'Hydra_Ranger'
    [17326731] = { id = DMB+675}, -- 'Hydra_Black_Mage'
    [17326732] = { id = DMB+676}, -- 'Vanguard_Eye'
    [17326733] = { id = DMB+677}, -- 'Hydra_Dark_Knight'
    [17326734] = { id = DMB+678}, -- 'Hydra_Dragoon'
    [17326735] = { id = DMB+679}, -- 'Hydras_Wyvern'
    [17326736] = { id = DMB+680}, -- 'Hydra_White_Mage'
    [17326737] = { id = DMB+681}, -- 'Vanguard_Eye'
    [17326738] = { id = DMB+682}, -- 'Hydra_Paladin'
    [17326739] = { id = DMB+683}, -- 'Hydra_Warrior'
    [17326740] = { id = DMB+684}, -- 'Hydra_White_Mage'
    [17326741] = { id = DMB+685}, -- 'Hydra_Thief'
    [17326742] = { id = DMB+686}, -- 'Rearguard_Eye'
    [17326743] = { id = DMB+687}, -- 'Hydra_Monk'
    [17326744] = { id = DMB+688}, -- 'Hydra_Bard'
    [17326745] = { id = DMB+689}, -- 'Hydra_Ranger'
    [17326746] = { id = DMB+690}, -- 'Hydra_Dragoon'
    [17326747] = { id = DMB+691}, -- 'Hydras_Wyvern'
    [17326748] = { id = DMB+692}, -- 'Rearguard_Eye'
    [17326749] = { id = DMB+693}, -- 'Hydra_Dark_Knight'
    [17326750] = { id = DMB+694}, -- 'Hydra_Samurai'
    [17326751] = { id = DMB+695}, -- 'Hydra_Ninja'
    [17326752] = { id = DMB+696}, -- 'Hydra_Summoner'
    [17326753] = { id = DMB+697}, -- 'Hydras_Avatar'
    [17326754] = { id = DMB+698}, -- 'Rearguard_Eye'
    [17326755] = { id = DMB+699}, -- 'Hydra_White_Mage'
    [17326756] = { id = DMB+700}, -- 'Hydra_Black_Mage'
    [17326757] = { id = DMB+701}, -- 'Hydra_Red_Mage'
    [17326758] = { id = DMB+702}, -- 'Hydra_Beastmaster'
    [17326759] = { id = DMB+703}, -- 'Hydras_Hound'
    [17326760] = { id = DMB+704}, -- 'Rearguard_Eye'
    [17326761] = { id = DMB+705}, -- 'Hydra_Black_Mage'
    [17326762] = { id = DMB+706}, -- 'Hydra_Dark_Knight'
    [17326763] = { id = DMB+707}, -- 'Hydra_Ranger'
    [17326764] = { id = DMB+708}, -- 'Hydra_Ninja'
    [17326765] = { id = DMB+709}, -- 'Rearguard_Eye'
    [17326766] = { id = DMB+710}, -- 'Hydra_Warrior'
    [17326767] = { id = DMB+711}, -- 'Hydra_Red_Mage'
    [17326768] = { id = DMB+712}, -- 'Hydra_Ninja'
    [17326769] = { id = DMB+713}, -- 'Hydra_Dragoon'
    [17326770] = { id = DMB+714}, -- 'Hydras_Wyvern'
    [17326771] = { id = DMB+715}, -- 'Rearguard_Eye'
    [17326772] = { id = DMB+716}, -- 'Hydra_Monk'
    [17326773] = { id = DMB+717}, -- 'Hydra_White_Mage'
    [17326774] = { id = DMB+718}, -- 'Hydra_Black_Mage'
    [17326775] = { id = DMB+719}, -- 'Hydra_Summoner'
    [17326776] = { id = DMB+720}, -- 'Hydras_Avatar'
    [17326777] = { id = DMB+721}, -- 'Hydra_Bard'
    [17326778] = { id = DMB+722}, -- 'Hydra_White_Mage'
    [17326779] = { id = DMB+723}, -- 'Hydra_Thief'
    [17326780] = { id = DMB+724}, -- 'Hydra_Paladin'
    [17326781] = { id = DMB+725}, -- 'Vanguard_Eye'
    [17326782] = { id = DMB+726}, -- 'Hydra_Warrior'
    [17326783] = { id = DMB+727}, -- 'Hydra_Beastmaster'
    [17326784] = { id = DMB+728}, -- 'Hydras_Hound'
    [17326785] = { id = DMB+729}, -- 'Hydra_Monk'
    [17326786] = { id = DMB+730}, -- 'Vanguard_Eye'
    [17326787] = { id = DMB+731}, -- 'Hydra_Black_Mage'
    [17326788] = { id = DMB+732}, -- 'Hydra_Red_Mage'
    [17326789] = { id = DMB+733}, -- 'Hydra_Dark_Knight'
    [17326790] = { id = DMB+734}, -- 'Vanguard_Eye'
    [SMB+0] = { id =  SMB+0 }, -- Avatar Icon
    [SMB+1] = { id =  SMB+1 }, -- Adamantking Effigy
    [SMB+2] = { id =  SMB+2 }, -- Serjent Tombstone
    [SMB+3] = { id =  SMB+3 }, -- Goblin Replica
    [SMB+4] = { id =  SMB+4 }, -- Serjent Tombstone
    [SMB+5] = { id =  SMB+5 }, -- Adamantking Effigy
    [SMB+6] = { id =  SMB+6 }, -- Avatar Icon
    [SMB+7] = { id =  SMB+7 }, -- Goblin replica
    [SMB+8] = { id =  SMB+8 }, -- Avatar Icon
    [SMB+9] = { id =  SMB+9 }, -- Avatar Icon
    [SMB+10] = { id =  SMB+10 }, -- Avatar Icon
    [SMB+11] = { id =  SMB+11 }, -- Avatar Icon
    [SMB+12] = { id =  SMB+12 }, -- Avatar Icon
    [SMB+13] = { id =  SMB+13 }, -- Avatar Icon
    [SMB+14] = { id =  SMB+14 }, -- Avatar Icon
    [SMB+15] = { id =  SMB+15 }, -- Avatar Icon
    [SMB+16] = { id =  SMB+16 }, -- Avatar Icon
    [SMB+17] = { id =  SMB+17 }, -- Avatar Icon
    [SMB+18] = { id =  SMB+18 }, -- Avatar Icon
    [SMB+19] = { id =  SMB+19 }, -- Avatar Icon
    [SMB+20] = { id =  SMB+20 }, -- Avatar Icon
    [SMB+21] = { id =  SMB+21 }, -- Avatar Icon
    [SMB+22] = { id =  SMB+22 }, -- Avatar Icon
    [SMB+23] = { id =  SMB+23 }, -- Avatar Icon
    [SMB+24] = { id =  SMB+24 }, -- Avatar Icon
    [SMB+25] = { id =  SMB+25 }, -- Avatar Icon
    [SMB+26] = { id =  SMB+26 }, -- Avatar Icon
    [SMB+27] = { id =  SMB+27 }, -- Avatar Icon
    [SMB+28] = { id =  SMB+28 }, -- Avatar Icon
    [SMB+29] = { id =  SMB+29 }, -- Dynamis Icon
    [SMB+30] = { id =  SMB+30 }, -- Goblin Statue
    [SMB+31] = { id =  SMB+31 }, -- Goblin Statue
    [SMB+32] = { id =  SMB+32 }, -- Goblin Statue
    [SMB+33] = { id =  SMB+33 }, -- Goblin Statue
    [SMB+34] = { id =  SMB+34 }, -- Goblin Statue
    [SMB+35] = { id =  SMB+35 }, -- Goblin Statue
    [SMB+36] = { id =  SMB+36 }, -- Goblin Statue
    [SMB+37] = { id =  SMB+37 }, -- Goblin Statue
    [SMB+38] = { id =  SMB+38 }, -- Goblin Statue
    [SMB+39] = { id =  SMB+39 }, -- Goblin Statue
    [SMB+40] = { id =  SMB+40 }, -- Goblin Statue
    [SMB+41] = { id =  SMB+41 }, -- Goblin Statue
    [SMB+42] = { id =  SMB+42 }, -- Goblin Statue
    [SMB+43] = { id =  SMB+43 }, -- Goblin Statue
    [SMB+44] = { id =  SMB+44 }, -- Dynamis Statue
    [SMB+45] = { id =  SMB+45 }, -- Goblin Statue
    [SMB+46] = { id =  SMB+46 }, -- Goblin Statue
    [SMB+47] = { id =  SMB+47 }, -- Goblin Statue
    [SMB+48] = { id =  SMB+48 }, -- Goblin Statue
    [SMB+49] = { id =  SMB+49 }, -- Goblin Statue
    [SMB+50] = { id =  SMB+50 }, -- Goblin Statue
    [SMB+51] = { id =  SMB+51 }, -- Goblin Statue
    [SMB+52] = { id =  SMB+52 }, -- Goblin Statue
    [SMB+53] = { id =  SMB+53 }, -- Adamantking Effigy
    [SMB+54] = { id =  SMB+54 }, -- Adamantking Effigy
    [SMB+55] = { id =  SMB+55 }, -- Adamantking Effigy
    [SMB+56] = { id =  SMB+56 }, -- Adamantking Effigy
    [SMB+57] = { id =  SMB+57 }, -- Dynamis Effigy
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
    [SMB+76] = { id =  SMB+76 }, -- Dynamis Tombstone
    [SMB+77] = { id =  SMB+77 }, -- Serjeant Tombstone
    [SMB+78] = { id =  SMB+78 }, -- Serjeant Tombstone
    [SMB+79] = { id =  SMB+79 }, -- Serjeant Tombstone
    [SMB+80] = { id =  SMB+80 }, -- Serjeant Tombstone
    [SMB+81] = { id =  SMB+81 }, -- Serjeant Tombstone
    [SMB+82] = { id =  SMB+82 }, -- Serjeant Tombstone
    [SMB+83] = { id =  SMB+83 }, -- Serjeant Tombstone
    [SMB+84] = { id =  SMB+84 }, -- Serjeant Tombstone
    [SMB+85] = { id =  SMB+85 }, -- Serjeant Tombstone
    [SMB+86] = { id =  SMB+86 }, -- Serjeant Tombstone
    [SMB+87] = { id =  SMB+87 }, -- Serjeant Tombstone
    [SMB+88] = { id =  SMB+88 }, -- Serjeant Tombstone
    [SMB+89] = { id =  SMB+89 }, -- Serjeant Tombstone
    [SMB+90] = { id =  SMB+90 }, -- Serjeant Tombstone
    [SMB+91] = { id =  SMB+91 }, -- Serjeant Tombstone
    [SMB+92] = { id =  SMB+92 }, -- Serjeant Tombstone
    [SMB+93] = { id =  SMB+93 }, -- Serjeant Tombstone
    [SMB+94] = { id =  SMB+94 }, -- Serjeant Tombstone
    [SMB+95] = { id =  SMB+95 }, -- Serjeant Tombstone
    [SMB+96] = { id =  SMB+96 }, -- Serjeant Tombstone
    [SMB+97] = { id =  SMB+97 }, -- Serjeant Tombstone
    [SMB+98] = { id =  SMB+98 }, -- Serjeant Tombstone
    [SMB+99] = { id =  SMB+99 }, -- Adanantking Effigy
    [SMB+100] = { id =  SMB+100 }, -- Avatar Icon
    [SMB+101] = { id =  SMB+101 }, -- GOblin Replica
    [SMB+102] = { id =  SMB+102 }, -- Adanamtking Effigy
    [SMB+103] = { id =  SMB+103 }, -- Goblin Replica
    [SMB+104] = { id =  SMB+104 }, -- Serjeant Tombstone
    [SMB+105] = { id =  SMB+105 }, -- Avatar Icon
    [SMB+106] = { id =  SMB+106 }, -- Vanguard Eye
    [SMB+107] = { id =  SMB+107 }, -- Vanguard Eye
    [SMB+108] = { id =  SMB+108 }, -- Vanguard Eye
    [SMB+109] = { id =  SMB+109 }, -- Vanguard Eye
    [SMB+110] = { id =  SMB+110 }, -- Vanguard Eye
    [SMB+111] = { id =  SMB+111 }, -- Vanguard Eye
    [SMB+112] = { id =  SMB+112 }, -- Vanguard Eye
    [SMB+113] = { id =  SMB+113 }, -- Vanguard Eye
    [SMB+114] = { id =  SMB+114 }, -- Vanguard Eye
    [SMB+115] = { id =  SMB+115 }, -- Vanguard Eye
    [SMB+116] = { id =  SMB+116 }, -- Vanguard Eye
    [SMB+117] = { id =  SMB+117 }, -- Vanguard Eye
    [SMB+118] = { id =  SMB+118 }, -- Vanguard Eye
    [SMB+119] = { id =  SMB+119 }, -- Vanguard Eye
    [SMB+120] = { id =  SMB+120 }, -- Vanguard Eye
    [SMB+121] = { id =  SMB+121 }, -- Vanguard Eye
    [SMB+122] = { id =  SMB+122 }, -- Vanguard Eye
    [SMB+123] = { id =  SMB+123 }, -- Vanguard Eye
    [SMB+124] = { id =  SMB+124 }, -- Vanguard Eye
    [SMB+125] = { id =  SMB+125 }, -- Vanguard Eye
    [SMB+126] = { id =  SMB+126 }, -- Vanguard Eye
    [SMB+127] = { id =  SMB+127 }, -- Vanguard Eye
    [SMB+128] = { id =  SMB+128 }, -- Vanguard Eye
    [SMB+129] = { id =  SMB+129 }, -- Vanguard Eye
    [SMB+130] = { id =  SMB+130 }, -- Vanguard Eye
    [SMB+131] = { id =  SMB+131 }, -- Vanguard Eye
    [SMB+132] = { id =  SMB+132 }, -- Vanguard Eye
    [SMB+133] = { id =  SMB+133 }, -- Vanguard Eye
    [SMB+134] = { id =  SMB+134 }, -- Vanguard Eye
    [SMB+135] = { id =  SMB+135 }, -- Vanguard Eye
    [SMB+136] = { id =  SMB+136 }, -- Vanguard Eye
    [SMB+137] = { id =  SMB+137 }, -- Vanguard Eye
    [SMB+138] = { id =  SMB+138 }, -- Vanguard Eye
    [SMB+139] = { id =  SMB+139 }, -- Vanguard Eye
    [SMB+140] = { id =  SMB+140 }, -- Vanguard Eye
    [SMB+141] = { id =  SMB+141 }, -- Vanguard Eye
    [SMB+142] = { id =  SMB+142 }, -- Vanguard Eye
    [SMB+143] = { id =  SMB+143 }, -- Vanguard Eye
    [SMB+144] = { id =  SMB+144 }, -- Vanguard Eye
    [SMB+145] = { id =  SMB+145 }, -- Vanguard Eye
    [SMB+146] = { id =  SMB+146 }, -- Vanguard Eye
    [SMB+147] = { id =  SMB+147 }, -- Vanguard Eye
    [SMB+148] = { id =  SMB+148 }, -- Vanguard Eye
    [SMB+149] = { id =  SMB+149 }, -- Vanguard Eye
    [SMB+150] = { id =  SMB+150 }, -- Vanguard Eye
    [SMB+151] = { id =  SMB+151 }, -- Vanguard Eye
    [SMB+152] = { id =  SMB+152 }, -- Vanguard Eye
    [SMB+153] = { id =  SMB+153 }, -- Vanguard Eye
    [SMB+154] = { id =  SMB+154 }, -- Vanguard Eye
    [SMB+155] = { id =  SMB+155 }, -- Vanguard Eye
    [SMB+156] = { id =  SMB+156 }, -- Vanguard Eye
}

mobList[zone].zoneID = tpz.zone.DYNAMIS_BEAUCEDINE

-- set positions for mobs that have placements (x,y,z,rot) and rotation is required
-- child monsters' positions are optional. if left unset, they are randomly placed closely around their parent monster when the parent mob engages

mobList[zone][SMB+0  ].pos = {-279.0733, -39.1011, -341.9998, 8 }
mobList[zone][SMB+1  ].pos = {-260.1787, -39.0101, -362.4289, 70 }
mobList[zone][SMB+2  ].pos = {-239.1913, -40.0000, -362.8879, 156 }
mobList[zone][SMB+3  ].pos = {-232.9155, -39.8400, -335.9303, 127 }
mobList[zone][SMB+4  ].pos = {-285.3470, -40.0557, -315.7200, 244 }
mobList[zone][SMB+5  ].pos = {-297.7608, -39.8339, -272.4887, 14 }
mobList[zone][SMB+6  ].pos = {-263.2965, -40.9416, -300.3301, 95 }
mobList[zone][SMB+7  ].pos = {-310.9539, -40.1066, -287.0196, 17 }
mobList[zone][SMB+8  ].pos = {-194.2248, -39.7044, -211.3219, 149 }
mobList[zone][SMB+9  ].pos = {-180.1325, -39.5770, -205.7526, 190 }
mobList[zone][SMB+10 ].pos = {-192.1449, -39.8455, -227.0389, 107 }
mobList[zone][SMB+11 ].pos = {-167.3895, -39.7587, -212.6639, 236 }
mobList[zone][SMB+12 ].pos = {-179.9195, -39.6378, -234.3385, 60 }
mobList[zone][SMB+13 ].pos = { -49.6709, -39.7176, -202.2746, 147 }
mobList[zone][SMB+14 ].pos = { -15.7695, -40.4197, -223.8477, 148 }
mobList[zone][SMB+15 ].pos = {  18.3990, -40.2073, -202.0281, 153 }
mobList[zone][SMB+16 ].pos = { -56.6927, -40.1790, -211.7740, 155 }
mobList[zone][SMB+17 ].pos = { -33.1590, -40.1141, -193.4986, 60 }
mobList[zone][SMB+18 ].pos = { -37.0947, -40.5000, -254.2856, 175 }
mobList[zone][SMB+19 ].pos = { -82.8389, -40.1366, -259.2798, 5 }
mobList[zone][SMB+20 ].pos = { 118.0029, -40.0000, -1.4011, 253 }
mobList[zone][SMB+21 ].pos = {  72.3558, -40.0457, -6.2216, 249 }
mobList[zone][SMB+22 ].pos = {  73.2736, -39.8664, 4.0085, 254 }
mobList[zone][SMB+23 ].pos = {  92.3657, -41.3116, 67.6632, 95 }
mobList[zone][SMB+24 ].pos = {  83.8304, -40.0000, 75.9769, 97 }
mobList[zone][SMB+25 ].pos = {  90.8688, -40.6044, 59.7961, 10 }
mobList[zone][SMB+26 ].pos = {  73.7746, -39.8908, 72.4544, 95 }
mobList[zone][SMB+27 ].pos = {  79.1487, -39.1406, 57.2114, 90 }
mobList[zone][SMB+28 ].pos = {  72.2687, -39.6224, 64.4010, 92 }
mobList[zone][SMB+29 ].pos = {  85.0448, -39.9585, 70.5809, 96 }
mobList[zone][SMB+30 ].pos = {-135.8315, -60.5272, -197.7793, 224 }
mobList[zone][SMB+31 ].pos = {-144.8487, -59.7218, -189.4915, 235 }
mobList[zone][SMB+32 ].pos = {-127.8651, -59.3734, -206.4330, 208 }
mobList[zone][SMB+33 ].pos = { -43.1630, -59.8697, -113.3710, 255 }
mobList[zone][SMB+34 ].pos = { -40.4508, -59.7970, -128.0826, 246 }
mobList[zone][SMB+35 ].pos = { -35.7644, -59.1369, -142.6632, 235 }
mobList[zone][SMB+36 ].pos = { -16.7373, -60.5292, -135.3285, 126 }
mobList[zone][SMB+37 ].pos = {  -7.3716, -59.6279, -148.7619, 115 }
mobList[zone][SMB+38 ].pos = {  81.3941, -59.9388, -74.7523, 109 }
mobList[zone][SMB+39 ].pos = {  72.3541, -59.9692, -51.4561, 126 }
mobList[zone][SMB+40 ].pos = {  73.7183, -59.8871, -38.8825, 123 }
mobList[zone][SMB+41 ].pos = {  77.3184, -59.1610, -63.1964, 128 }
mobList[zone][SMB+42 ].pos = {  90.8498, -59.6799, -35.1627, 109 }
mobList[zone][SMB+43 ].pos = { 102.1677, -61.0401, -53.2106, 111 }
mobList[zone][SMB+44 ].pos = {  85.8646, -59.7906, -50.6917, 117 }
mobList[zone][SMB+45 ].pos = {  -6.0992, -59.5607, 60.9312, 242 }
mobList[zone][SMB+46 ].pos = {  -5.4384, -59.9930, 85.6257, 9 }
mobList[zone][SMB+47 ].pos = {  16.6093, -59.7430, 64.7391, 139 }
mobList[zone][SMB+48 ].pos = {  28.0952, -61.6794, 149.9339, 15 }
mobList[zone][SMB+49 ].pos = {  53.0996, -60.4462, 161.8882, 108 }
mobList[zone][SMB+50 ].pos = {  71.8310, -60.8405, 209.4839, 74 }
mobList[zone][SMB+51 ].pos = {  88.7690, -60.6208, 210.0924, 33 }
mobList[zone][SMB+52 ].pos = { 113.1226, -59.8573, 203.7245, 114 }
mobList[zone][SMB+53 ].pos = { 160.4106, -19.7059, 30.0949, 124 }
mobList[zone][SMB+54 ].pos = { 168.1705, -19.4408, 15.7383, 134 }
mobList[zone][SMB+55 ].pos = { 166.2367, -19.4045, 26.2815, 132 }
mobList[zone][SMB+56 ].pos = { 162.6362, -19.6409, 11.2047, 141 }
mobList[zone][SMB+57 ].pos = { 257.6411, -21.1347, -142.0784, 131 }
mobList[zone][SMB+58 ].pos = { 255.8613, -19.2185, -119.8784, 125 }
mobList[zone][SMB+59 ].pos = { 273.8611, -19.8943, -116.1189, 114 }
mobList[zone][SMB+60 ].pos = { 293.3825, -20.2153, -127.9682, 119 }
mobList[zone][SMB+61 ].pos = { 256.3311, -19.2941, -165.6130, 130 }
mobList[zone][SMB+62 ].pos = { 227.9596, -21.2556, -146.4416, 143 }
mobList[zone][SMB+63 ].pos = { 230.3858, -19.9755, -132.9917, 139 }
mobList[zone][SMB+64 ].pos = { 232.3072, -19.8166, -124.0341, 143 }
mobList[zone][SMB+65 ].pos = { 243.9701, -20.2420, -110.1599, 143 }
mobList[zone][SMB+66 ].pos = {  82.2491, -20.0000, -195.9017, 134 }
mobList[zone][SMB+67 ].pos = {  72.8168, -19.8691, -212.5843, 150 }
mobList[zone][SMB+68 ].pos = {  66.0040, -19.8042, -221.2624, 150 }
mobList[zone][SMB+69 ].pos = {  60.7676, -19.0500, -235.8141, 150 }
mobList[zone][SMB+70 ].pos = {  59.9181, -19.2985, -250.7721, 139 }
mobList[zone][SMB+71 ].pos = { 137.6571, -20.3000, -197.3645, 82 }
mobList[zone][SMB+72 ].pos = { -63.1991, -21.0329, -293.5439, 163 }
mobList[zone][SMB+73 ].pos = { -42.4831, -19.5290, -287.9989, 179 }
mobList[zone][SMB+74 ].pos = { -74.3709, -20.1062, -332.8462, 151 }
mobList[zone][SMB+75 ].pos = { -80.6846, -20.7738, -270.7316, 55 }
mobList[zone][SMB+76 ].pos = { 350.0000, 0.1359, -155.9000, 128 }
mobList[zone][SMB+77 ].pos = { 335.0000, 0.6565, -163.8019, 128 }
mobList[zone][SMB+78 ].pos = { 345.0000, 0.0874, -163.8019, 128 }
mobList[zone][SMB+79 ].pos = { 355.0000, 0.0627, -163.8019, 128 }
mobList[zone][SMB+80 ].pos = { 365.0000, 0.0749, -163.8019, 128 }
mobList[zone][SMB+81 ].pos = { 335.0000, 0.2920, -148.0000, 128 }
mobList[zone][SMB+82 ].pos = { 345.0000, 0.5045, -148.0000, 128 }
mobList[zone][SMB+83 ].pos = { 355.0000, 0.5428, -148.0000, 128 }
mobList[zone][SMB+84 ].pos = { 365.0000, 0.4668, -148.0000, 128 }
mobList[zone][SMB+85 ].pos = { -21.0316, 0.2199, -320.4573, 38 }
mobList[zone][SMB+86 ].pos = { -28.5544, 0.0000, -305.9902, 24 }
mobList[zone][SMB+87 ].pos = { -48.0951, -0.0097, -302.7363, 244 }
mobList[zone][SMB+88 ].pos = { -58.3921, 0.1868, -314.9998, 195 }
mobList[zone][SMB+89 ].pos = { -60.2255, 0.2000, -332.1296, 201 }
mobList[zone][SMB+90 ].pos = {-116.1668, 0.4220, -372.3102, 16 }
mobList[zone][SMB+91 ].pos = {-114.2561, 0.4379, -386.6913, 241 }
mobList[zone][SMB+92 ].pos = {-100.6849, 0.9646, -396.2882, 206 }
mobList[zone][SMB+93 ].pos = { 405.0992, 0.4061, -5.5113, 144 }
mobList[zone][SMB+94 ].pos = { 406.4566, -0.0185, 10.1297, 144 }
mobList[zone][SMB+95 ].pos = { 408.7980, 1.0967, 22.5814,	144 }
mobList[zone][SMB+96 ].pos = { 409.5340, -1.7055, 33.6995, 144 }
mobList[zone][SMB+97 ].pos = { 408.8476, -0.4056, 46.6788, 144 }
mobList[zone][SMB+98 ].pos = { 263.4912, -0.97039, 58.8165, 29 }
mobList[zone][SMB+99 ].pos = { 268.7820, -0.5453, 70.0471, 19 }
mobList[zone][SMB+100].pos = { 267.6158, 0.4338, 83.5243, 31 }
mobList[zone][SMB+101].pos = { 260.9484, -0.5514, 98.2945, 41 }
mobList[zone][SMB+102].pos = { 264.6924, 0.7262, 243.3394, 59 }
mobList[zone][SMB+103].pos = { 285.0459, -0.0535, 242.4564, 101 }
mobList[zone][SMB+104].pos = { 287.2189, -0.0928, 230.3786, 133 }
mobList[zone][SMB+105].pos = { 288.0384, -0.1970, 205.6502, 129 }
mobList[zone][SMB+106].pos = { -44.0915, -63.6540, 99.7354, 255 }
mobList[zone][SMB+107].pos = { -40.3174, -79.6383, 113.0489, 133 }
mobList[zone][SMB+108].pos = { -29.2701, -80.3479, 123.5728, 138 }
mobList[zone][SMB+109].pos = { -30.9502, -79.7086, 134.8122, 131 }
mobList[zone][SMB+110].pos = { -39.4031, -80.1331, 166.6385, 76 }
mobList[zone][SMB+111].pos = { -96.4499, -79.6777, 146.0539, 101 }
mobList[zone][SMB+112].pos = { -83.3049, -80.0000, 121.3884, 130 }
mobList[zone][SMB+113].pos = {-123.5741, -79.2257, 144.2114, 55 }
mobList[zone][SMB+114].pos = {-112.6828, -79.8353, 162.7629, 55 }
mobList[zone][SMB+115].pos = {-140.6943, -79.7930, 140.1634, 55 }
mobList[zone][SMB+116].pos = {-138.7632, -79.0630, 161.4096, 55 }
mobList[zone][SMB+117].pos = {-127.9832, -80.0000, 189.8156, 55 }
mobList[zone][SMB+118].pos = {-154.8108, -79.9417, 155.8926, 55 }
mobList[zone][SMB+119].pos = {-160.5700, -79.3930, 134.1153, 55 }
mobList[zone][SMB+120].pos = { -71.0217, -79.8245, 74.5786, 126 }
mobList[zone][SMB+121].pos = { -71.5218, -80.0654, 86.2477, 126 }
mobList[zone][SMB+122].pos = { -22.0972, -80.7410, 64.2880, 178 }
mobList[zone][SMB+123].pos = { -24.0412, -79.9206, 9.5265, 185 }
mobList[zone][SMB+124].pos = { -62.9328, -80.0783, -51.2713, 196 }
mobList[zone][SMB+125].pos = { -88.6876, -80.9274, -64.3945, 234 }
mobList[zone][SMB+126].pos = {-101.6736, -80.0000, -119.9976, 183 }
mobList[zone][SMB+127].pos = {-118.1774, -80.0000, -137.8634, 246 }
mobList[zone][SMB+128].pos = {-144.3036, -80.5000, -163.8153, 181 }
mobList[zone][SMB+129].pos = {-168.8876, -79.6787, -165.5847, 195 }
mobList[zone][SMB+130].pos = {-164.6790, -79.1044, -139.3900, 255 }
mobList[zone][SMB+131].pos = {-174.2991, -79.3748, -116.3493, 65 }
mobList[zone][SMB+132].pos = {-175.4636, -79.6582, -132.1770, 64 }
mobList[zone][SMB+133].pos = {-245.4614, -80.1574, -126.6808, 11 }
mobList[zone][SMB+134].pos = {-193.0234, -80.0800, -127.0653, 64 }
mobList[zone][SMB+135].pos = {-179.9060, -79.3061, -113.0376, 60 }
mobList[zone][SMB+136].pos = {-241.0599, -80.0729, -114.5646, 15 }
mobList[zone][SMB+137].pos = {-292.4296, -80.5000, -113.2843, 16 }
mobList[zone][SMB+138].pos = {-281.6393, -79.1325, -97.3740, 19 }
mobList[zone][SMB+139].pos = {-280.3488, -80.0000, -76.3263, 70 }
mobList[zone][SMB+140].pos = {-152.9554, -100.1509, 6.9910, 121 }
mobList[zone][SMB+141].pos = {-137.0686, -99.6546, -16.1596, 130 }
mobList[zone][SMB+142].pos = {-136.4481, -100.3073, -52.0000, 129 }
mobList[zone][SMB+143].pos = {-124.3648, -99.6392, -68.7928, 135 }
mobList[zone][SMB+144].pos = {-126.0454, -99.5554, -102.0939, 183 }
mobList[zone][SMB+145].pos = {-103.1679, -100.3910, -54.7808, 151 }
mobList[zone][SMB+146].pos = { -65.4576, -99.7153, 60.5501, 74 }
mobList[zone][SMB+147].pos = { -61.8848, -101.1865, 23.1000, 91 }
mobList[zone][SMB+148].pos = {-245.7510, -99.8712, 11.2572, 3 }
mobList[zone][SMB+149].pos = {-246.2604, -99.4197, 23.7584, 3 }
mobList[zone][SMB+150].pos = {-244.2214, -100.0123, 37.5050, 3 }
mobList[zone][SMB+151].pos = {-298.8714, -99.7872, 38.3348, 49 }
mobList[zone][SMB+152].pos = {-309.1874, -100.0000, 55.2101, 27 }
mobList[zone][SMB+153].pos = {-345.4541, -100.0125, 65.2495, 12 }
mobList[zone][SMB+154].pos = {-361.3637, -99.4463, 106.4152, 54 }
mobList[zone][SMB+155].pos = {-338.0219, -101.0014, 104.1122, 118 }
mobList[zone][SMB+156].pos = {-339.8712, -100.2500, 136.2033, 63 }
mobList[zone][DMB+1  ].pos = { 280.0817, 20.0000, 536.5154, 65 }
mobList[zone][DMB+2  ].pos = { 275.2877, 20, 544.6065, 63 }
mobList[zone][DMB+3  ].pos = { 283.5459, 20, 545.8229, 63 }
mobList[zone][DMB+4  ].pos = { 285.7335, 20, 532.6114, 63 }
mobList[zone][DMB+5  ].pos = { 274.4853, 20, 532.4368, 63 }
mobList[zone][DMB+6  ].pos = { 100.1128, -20.2500, 137.1149, 63 }
mobList[zone][DMB+7  ].pos = { -20.0183, -60.2500, -64.0732, 62 }
mobList[zone][DMB+8  ].pos = {  60.1032, -0.2500, -336.3712, 191 }
mobList[zone][DMB+9  ].pos = { 263.2100, -0.2500, -19.8968, 253 }
mobList[zone][DMB+10 ].pos = {-176.4133, -40.2500, -219.9464, 0 }

-- instead of standing still, i will patrol across these given points (triplets of x,y,z)
-- todo: this is not yet functional, this will most likely use dynamis.mobOnRoamAction
-- mobList[zone][SMB+1].path = { 11, 22, 33, 66, 77, 88, }

-- set statue eye color

mobList[zone][SMB+6  ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+11 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+17 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+21 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+27 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+36 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+40 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+43 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+46 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+50 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+53 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+60 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+64 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+67 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+72 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+77 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+86 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+90 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+94 ].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+102].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+104].eyes = dynamis.eyes.BLUE
mobList[zone][SMB+7  ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+12 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+15 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+22 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+24 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+28 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+37 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+41 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+42 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+47 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+51 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+56 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+58 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+62 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+69 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+74 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+80 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+81 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+88 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+92 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+96 ].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+103].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+105].eyes = dynamis.eyes.GREEN
mobList[zone][SMB+8  ].eyes = dynamis.eyes.RED
mobList[zone][SMB+19 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+30 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+52 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+71 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+75 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+91 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+95 ].eyes = dynamis.eyes.RED
mobList[zone][SMB+117].eyes = dynamis.eyes.RED
mobList[zone][SMB+147].eyes = dynamis.eyes.RED

-- set time extensions
mobList[zone][SMB+8  ].timeExtension = 15
mobList[zone][SMB+19 ].timeExtension = 15
mobList[zone][SMB+30 ].timeExtension = 15
mobList[zone][SMB+52 ].timeExtension = 15
mobList[zone][SMB+71 ].timeExtension = 15
mobList[zone][SMB+75 ].timeExtension = 15
mobList[zone][SMB+91 ].timeExtension = 15
mobList[zone][SMB+95 ].timeExtension = 15
mobList[zone][SMB+117].timeExtension = 15
mobList[zone][SMB+147].timeExtension = 15

-- list of mobs to spawn the wave. ALL of them must be defeated (in any order)
mobList[zone].waveDefeatRequirements = { }
mobList[zone].waveDefeatRequirements[1] = { } --
mobList[zone].waveDefeatRequirements[2] = {SMB+156} --

-- set which waves this monster will spawn on (can be multiple)
-- wave 1 is spawned on the creation of the dynamis instance

mobList[zone][SMB+0  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+1  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+2  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+3  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+4  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+5  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+6  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+7  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+8  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+9  ].waves = {  1 ,nil,nil }
mobList[zone][SMB+10 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+11 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+12 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+13 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+14 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+15 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+16 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+17 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+18 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+19 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+20 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+21 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+22 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+23 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+24 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+25 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+26 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+27 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+28 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+29 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+30 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+31 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+32 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+33 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+34 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+35 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+36 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+37 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+38 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+39 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+40 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+41 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+42 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+43 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+44 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+45 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+46 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+47 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+48 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+49 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+50 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+51 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+52 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+53 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+54 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+55 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+56 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+57 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+58 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+59 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+60 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+61 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+62 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+63 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+64 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+65 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+66 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+67 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+68 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+69 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+70 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+71 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+72 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+73 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+74 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+75 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+76 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+77 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+78 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+79 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+80 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+81 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+82 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+83 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+84 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+85 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+86 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+87 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+88 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+89 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+90 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+91 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+92 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+93 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+94 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+95 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+96 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+97 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+98 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+99 ].waves = {  1 ,nil,nil }
mobList[zone][SMB+100].waves = {  1 ,nil,nil }
mobList[zone][SMB+101].waves = {  1 ,nil,nil }
mobList[zone][SMB+102].waves = {  1 ,nil,nil }
mobList[zone][SMB+103].waves = {  1 ,nil,nil }
mobList[zone][SMB+104].waves = {  1 ,nil,nil }
mobList[zone][SMB+105].waves = {  1 ,nil,nil }
mobList[zone][SMB+106].waves = {  1 ,nil,nil }
mobList[zone][SMB+107].waves = {  1 ,nil,nil }
mobList[zone][SMB+108].waves = {  1 ,nil,nil }
mobList[zone][SMB+109].waves = {  1 ,nil,nil }
mobList[zone][SMB+110].waves = {  1 ,nil,nil }
mobList[zone][SMB+111].waves = {  1 ,nil,nil }
mobList[zone][SMB+112].waves = {  1 ,nil,nil }
mobList[zone][SMB+113].waves = {  1 ,nil,nil }
mobList[zone][SMB+114].waves = {  1 ,nil,nil }
mobList[zone][SMB+115].waves = {  1 ,nil,nil }
mobList[zone][SMB+116].waves = {  1 ,nil,nil }
mobList[zone][SMB+118].waves = {  1 ,nil,nil }
mobList[zone][SMB+119].waves = {  1 ,nil,nil }
mobList[zone][SMB+120].waves = {  1 ,nil,nil }
mobList[zone][SMB+121].waves = {  1 ,nil,nil }
mobList[zone][SMB+122].waves = {  1 ,nil,nil }
mobList[zone][SMB+123].waves = {  1 ,nil,nil }
mobList[zone][SMB+124].waves = {  1 ,nil,nil }
mobList[zone][SMB+125].waves = {  1 ,nil,nil }
mobList[zone][SMB+126].waves = {  1 ,nil,nil }
mobList[zone][SMB+127].waves = {  1 ,nil,nil }
mobList[zone][SMB+128].waves = {  1 ,nil,nil }
mobList[zone][SMB+129].waves = {  1 ,nil,nil }
mobList[zone][SMB+130].waves = {  1 ,nil,nil }
mobList[zone][SMB+131].waves = {  1 ,nil,nil }
mobList[zone][SMB+132].waves = {  1 ,nil,nil }
mobList[zone][SMB+133].waves = {  1 ,nil,nil }
mobList[zone][SMB+134].waves = {  1 ,nil,nil }
mobList[zone][SMB+135].waves = {  1 ,nil,nil }
mobList[zone][SMB+136].waves = {  1 ,nil,nil }
mobList[zone][SMB+137].waves = {  1 ,nil,nil }
mobList[zone][SMB+138].waves = {  1 ,nil,nil }
mobList[zone][SMB+139].waves = {  1 ,nil,nil }
mobList[zone][SMB+140].waves = {  1 ,nil,nil }
mobList[zone][SMB+141].waves = {  1 ,nil,nil }
mobList[zone][SMB+142].waves = {  1 ,nil,nil }
mobList[zone][SMB+143].waves = {  1 ,nil,nil }
mobList[zone][SMB+144].waves = {  1 ,nil,nil }
mobList[zone][SMB+145].waves = {  1 ,nil,nil }
mobList[zone][SMB+146].waves = {  1 ,nil,nil }
mobList[zone][SMB+147].waves = {  1 ,nil,nil }
mobList[zone][SMB+148].waves = {  1 ,nil,nil }
mobList[zone][SMB+149].waves = {  1 ,nil,nil }
mobList[zone][SMB+150].waves = {  1 ,nil,nil }
mobList[zone][SMB+151].waves = {  1 ,nil,nil }
mobList[zone][SMB+152].waves = {  1 ,nil,nil }
mobList[zone][SMB+153].waves = {  1 ,nil,nil }
mobList[zone][SMB+154].waves = {  1 ,nil,nil }
mobList[zone][SMB+155].waves = {  1 ,nil,nil }
mobList[zone][SMB+156].waves = {  1 ,nil,nil }
mobList[zone][DMB+1  ].waves = {  1 ,nil,nil }
mobList[zone][DMB+6  ].waves = {  nil , 2 ,nil }
mobList[zone][DMB+7  ].waves = {  nil , 2 ,nil }
mobList[zone][DMB+8  ].waves = {  nil , 2 ,nil }
mobList[zone][DMB+9  ].waves = {  nil , 2 ,nil }
mobList[zone][DMB+10 ].waves = {  nil , 2 ,nil }
-- set what mobIDs i will spawn when i engage (such as NMs or other statues) boolean value = forceLink enabled yes/no (default no if unspecified)
mobList[zone][SMB+8  ].specificChildren = { true, DMB+209 }
mobList[zone][SMB+13 ].specificChildren = { true, DMB+248 }
mobList[zone][SMB+15 ].specificChildren = { true, DMB+260 }
mobList[zone][SMB+16 ].specificChildren = { true, DMB+227 }
mobList[zone][SMB+18 ].specificChildren = { true, DMB+255 }
mobList[zone][SMB+19 ].specificChildren = { true, DMB+267 }
mobList[zone][SMB+20 ].specificChildren = { true, DMB+204 }
mobList[zone][SMB+25 ].specificChildren = { true, DMB+220 }
mobList[zone][SMB+26 ].specificChildren = { true, DMB+224 }
mobList[zone][SMB+29 ].specificChildren = { true, DMB+215, DMB+245, DMB+239, DMB+243 }
mobList[zone][SMB+30 ].specificChildren = { true, DMB+299 }
mobList[zone][SMB+33 ].specificChildren = { true, DMB+317 }
mobList[zone][SMB+34 ].specificChildren = { true, DMB+330 }
mobList[zone][SMB+42 ].specificChildren = { true, DMB+359 }
mobList[zone][SMB+43 ].specificChildren = { true, DMB+372 }
mobList[zone][SMB+44 ].specificChildren = { true, DMB+366, DMB+294, DMB+378, DMB+335 }
mobList[zone][SMB+46 ].specificChildren = { true, DMB+325 }
mobList[zone][SMB+47 ].specificChildren = { true, DMB+341 }
mobList[zone][SMB+49 ].specificChildren = { true, DMB+383 }
mobList[zone][SMB+52 ].specificChildren = { true, DMB+321 }
mobList[zone][SMB+54 ].specificChildren = { true, DMB+46 }
mobList[zone][SMB+55 ].specificChildren = { true, DMB+65 }
mobList[zone][SMB+57 ].specificChildren = { true, DMB+88, DMB+55, DMB+76, DMB+99}
mobList[zone][SMB+58 ].specificChildren = { true, DMB+110 }
mobList[zone][SMB+62 ].specificChildren = { true, DMB+82 }
mobList[zone][SMB+66 ].specificChildren = { true, DMB+93 }
mobList[zone][SMB+68 ].specificChildren = { true, DMB+115 }
mobList[zone][SMB+70 ].specificChildren = { true, DMB+71 }
mobList[zone][SMB+71 ].specificChildren = { true, DMB+211 }
mobList[zone][SMB+75 ].specificChildren = { true, DMB+34 }
mobList[zone][SMB+76 ].specificChildren = { true, DMB+193, DMB+157, DMB+175, DMB+132 }
mobList[zone][SMB+77 ].specificChildren = { true, DMB+185 }
mobList[zone][SMB+81 ].specificChildren = { true, DMB+143 }
mobList[zone][SMB+87 ].specificChildren = { true, DMB+153 }
mobList[zone][SMB+90 ].specificChildren = { true, DMB+178 }
mobList[zone][SMB+91 ].specificChildren = { true, DMB+168 }
mobList[zone][SMB+92 ].specificChildren = { true, DMB+182 }
mobList[zone][SMB+94 ].specificChildren = { true, DMB+163 }
mobList[zone][SMB+95 ].specificChildren = { true, DMB+138 }
mobList[zone][SMB+96 ].specificChildren = { true, DMB+149 }
mobList[zone][SMB+102].specificChildren = { true, DMB+105, DMB+26 }
mobList[zone][SMB+103].specificChildren = { true, DMB+307, DMB+347 }
mobList[zone][SMB+104].specificChildren = { true, DMB+190, DMB+136 }
mobList[zone][SMB+105].specificChildren = { true, DMB+233, DMB+264 }
mobList[zone][SMB+108].specificChildren = { false, SMB+117 }
mobList[zone][DMB+6  ].specificChildren = { true, DMB+392, DMB+396, DMB+400, DMB+440, DMB+432, DMB+428 }
mobList[zone][DMB+7  ].specificChildren = { true, DMB+395, DMB+441, DMB+391, DMB+399, DMB+405, DMB+446 }
mobList[zone][DMB+8  ].specificChildren = { true, DMB+410, DMB+411, DMB+435, DMB+459, DMB+444, DMB+475 }
mobList[zone][DMB+9  ].specificChildren = { true, DMB+474, DMB+471, DMB+476, DMB+489, DMB+510, DMB+512 }
mobList[zone][DMB+10 ].specificChildren = { true, DMB+523, DMB+521, DMB+547, DMB+560, DMB+460, DMB+504 }
mobList[zone][DMB+1  ].specificChildren = { true, DMB+2, DMB+3, DMB+4, DMB+5 }

-- set how many random children i will spawn when i engage
mobList[zone][SMB+0  ].randomChildrenCount = 2
mobList[zone][SMB+1  ].randomChildrenCount = 2
mobList[zone][SMB+2  ].randomChildrenCount = 2
mobList[zone][SMB+3  ].randomChildrenCount = 2
mobList[zone][SMB+4  ].randomChildrenCount = 2
mobList[zone][SMB+5  ].randomChildrenCount = 2
mobList[zone][SMB+6  ].randomChildrenCount = 2
mobList[zone][SMB+7  ].randomChildrenCount = 2
mobList[zone][SMB+8  ].randomChildrenCount = 2
mobList[zone][SMB+9  ].randomChildrenCount = 1
mobList[zone][SMB+10 ].randomChildrenCount = 1
mobList[zone][SMB+11 ].randomChildrenCount = 2
mobList[zone][SMB+12 ].randomChildrenCount = 2
mobList[zone][SMB+13 ].randomChildrenCount = 1
mobList[zone][SMB+14 ].randomChildrenCount = 1
mobList[zone][SMB+15 ].randomChildrenCount = 1
mobList[zone][SMB+16 ].randomChildrenCount = 1
mobList[zone][SMB+17 ].randomChildrenCount = 1
mobList[zone][SMB+18 ].randomChildrenCount = 1
mobList[zone][SMB+19 ].randomChildrenCount = 1
mobList[zone][SMB+21 ].randomChildrenCount = 2
mobList[zone][SMB+22 ].randomChildrenCount = 2
mobList[zone][SMB+23 ].randomChildrenCount = 2
mobList[zone][SMB+24 ].randomChildrenCount = 2
mobList[zone][SMB+25 ].randomChildrenCount = 1
mobList[zone][SMB+26 ].randomChildrenCount = 1
mobList[zone][SMB+27 ].randomChildrenCount = 2
mobList[zone][SMB+28 ].randomChildrenCount = 2
mobList[zone][SMB+30 ].randomChildrenCount = 1
mobList[zone][SMB+31 ].randomChildrenCount = 2
mobList[zone][SMB+32 ].randomChildrenCount = 2
mobList[zone][SMB+33 ].randomChildrenCount = 1
mobList[zone][SMB+34 ].randomChildrenCount = 1
mobList[zone][SMB+35 ].randomChildrenCount = 1
mobList[zone][SMB+36 ].randomChildrenCount = 2
mobList[zone][SMB+37 ].randomChildrenCount = 2
mobList[zone][SMB+38 ].randomChildrenCount = 1
mobList[zone][SMB+39 ].randomChildrenCount = 1
mobList[zone][SMB+40 ].randomChildrenCount = 2
mobList[zone][SMB+41 ].randomChildrenCount = 2
mobList[zone][SMB+42 ].randomChildrenCount = 1
mobList[zone][SMB+43 ].randomChildrenCount = 1
mobList[zone][SMB+45 ].randomChildrenCount = 2
mobList[zone][SMB+46 ].randomChildrenCount = 1
mobList[zone][SMB+47 ].randomChildrenCount = 1
mobList[zone][SMB+48 ].randomChildrenCount = 2
mobList[zone][SMB+49 ].randomChildrenCount = 1
mobList[zone][SMB+50 ].randomChildrenCount = 2
mobList[zone][SMB+51 ].randomChildrenCount = 2
mobList[zone][SMB+52 ].randomChildrenCount = 1
mobList[zone][SMB+53 ].randomChildrenCount = 2
mobList[zone][SMB+54 ].randomChildrenCount = 1
mobList[zone][SMB+55 ].randomChildrenCount = 1
mobList[zone][SMB+56 ].randomChildrenCount = 2
mobList[zone][SMB+58 ].randomChildrenCount = 1
mobList[zone][SMB+59 ].randomChildrenCount = 1
mobList[zone][SMB+60 ].randomChildrenCount = 2
mobList[zone][SMB+61 ].randomChildrenCount = 1
mobList[zone][SMB+62 ].randomChildrenCount = 1
mobList[zone][SMB+63 ].randomChildrenCount = 1
mobList[zone][SMB+64 ].randomChildrenCount = 2
mobList[zone][SMB+65 ].randomChildrenCount = 1
mobList[zone][SMB+66 ].randomChildrenCount = 1
mobList[zone][SMB+67 ].randomChildrenCount = 1
mobList[zone][SMB+68 ].randomChildrenCount = 1
mobList[zone][SMB+69 ].randomChildrenCount = 1
mobList[zone][SMB+70 ].randomChildrenCount = 1
mobList[zone][SMB+71 ].randomChildrenCount = 2
mobList[zone][SMB+72 ].randomChildrenCount = 2
mobList[zone][SMB+73 ].randomChildrenCount = 2
mobList[zone][SMB+74 ].randomChildrenCount = 2
mobList[zone][SMB+75 ].randomChildrenCount = 1
mobList[zone][SMB+77 ].randomChildrenCount = 1
mobList[zone][SMB+78 ].randomChildrenCount = 1
mobList[zone][SMB+79 ].randomChildrenCount = 1
mobList[zone][SMB+80 ].randomChildrenCount = 2
mobList[zone][SMB+81 ].randomChildrenCount = 1
mobList[zone][SMB+82 ].randomChildrenCount = 1
mobList[zone][SMB+83 ].randomChildrenCount = 1
mobList[zone][SMB+84 ].randomChildrenCount = 2
mobList[zone][SMB+85 ].randomChildrenCount = 2
mobList[zone][SMB+86 ].randomChildrenCount = 2
mobList[zone][SMB+87 ].randomChildrenCount = 1
mobList[zone][SMB+88 ].randomChildrenCount = 2
mobList[zone][SMB+89 ].randomChildrenCount = 2
mobList[zone][SMB+90 ].randomChildrenCount = 1
mobList[zone][SMB+91 ].randomChildrenCount = 1
mobList[zone][SMB+92 ].randomChildrenCount = 1
mobList[zone][SMB+93 ].randomChildrenCount = 2
mobList[zone][SMB+94 ].randomChildrenCount = 1
mobList[zone][SMB+95 ].randomChildrenCount = 1
mobList[zone][SMB+96 ].randomChildrenCount = 1
mobList[zone][SMB+97 ].randomChildrenCount = 2
mobList[zone][SMB+98 ].randomChildrenCount = 1
mobList[zone][SMB+99 ].randomChildrenCount = 1
mobList[zone][SMB+100].randomChildrenCount = 1
mobList[zone][SMB+101].randomChildrenCount = 1
mobList[zone][SMB+102].randomChildrenCount = 1
mobList[zone][SMB+103].randomChildrenCount = 1
mobList[zone][SMB+104].randomChildrenCount = 1
mobList[zone][SMB+105].randomChildrenCount = 1
mobList[zone][SMB+106].randomChildrenCount = 3
mobList[zone][SMB+107].randomChildrenCount = 1
mobList[zone][SMB+108].randomChildrenCount = 2
mobList[zone][SMB+109].randomChildrenCount = 2
mobList[zone][SMB+110].randomChildrenCount = 2
mobList[zone][SMB+111].randomChildrenCount = 2
mobList[zone][SMB+112].randomChildrenCount = 2
mobList[zone][SMB+113].randomChildrenCount = 1
mobList[zone][SMB+114].randomChildrenCount = 2
mobList[zone][SMB+115].randomChildrenCount = 1
mobList[zone][SMB+116].randomChildrenCount = 1
mobList[zone][SMB+117].randomChildrenCount = 2
mobList[zone][SMB+118].randomChildrenCount = 1
mobList[zone][SMB+119].randomChildrenCount = 1
mobList[zone][SMB+120].randomChildrenCount = 1
mobList[zone][SMB+121].randomChildrenCount = 1
mobList[zone][SMB+122].randomChildrenCount = 1
mobList[zone][SMB+123].randomChildrenCount = 1
mobList[zone][SMB+124].randomChildrenCount = 2
mobList[zone][SMB+125].randomChildrenCount = 1
mobList[zone][SMB+126].randomChildrenCount = 1
mobList[zone][SMB+127].randomChildrenCount = 2
mobList[zone][SMB+128].randomChildrenCount = 1
mobList[zone][SMB+129].randomChildrenCount = 1
mobList[zone][SMB+130].randomChildrenCount = 2
mobList[zone][SMB+131].randomChildrenCount = 1
mobList[zone][SMB+132].randomChildrenCount = 1
mobList[zone][SMB+133].randomChildrenCount = 2
mobList[zone][SMB+134].randomChildrenCount = 1
mobList[zone][SMB+135].randomChildrenCount = 1
mobList[zone][SMB+136].randomChildrenCount = 2
mobList[zone][SMB+137].randomChildrenCount = 1
mobList[zone][SMB+138].randomChildrenCount = 1
mobList[zone][SMB+139].randomChildrenCount = 1
mobList[zone][SMB+140].randomChildrenCount = 1
mobList[zone][SMB+141].randomChildrenCount = 1
mobList[zone][SMB+142].randomChildrenCount = 1
mobList[zone][SMB+143].randomChildrenCount = 1
mobList[zone][SMB+144].randomChildrenCount = 1
mobList[zone][SMB+145].randomChildrenCount = 1
mobList[zone][SMB+146].randomChildrenCount = 2
mobList[zone][SMB+147].randomChildrenCount = 2
mobList[zone][SMB+148].randomChildrenCount = 1
mobList[zone][SMB+149].randomChildrenCount = 2
mobList[zone][SMB+150].randomChildrenCount = 1
mobList[zone][SMB+151].randomChildrenCount = 1
mobList[zone][SMB+153].randomChildrenCount = 1
mobList[zone][SMB+154].randomChildrenCount = 1
mobList[zone][SMB+155].randomChildrenCount = 2
mobList[zone][SMB+156].randomChildrenCount = 5
mobList[zone][DMB+1  ].randomChildrenCount = 0
mobList[zone][DMB+6  ].randomChildrenCount = 0
mobList[zone][DMB+7  ].randomChildrenCount = 0
mobList[zone][DMB+8  ].randomChildrenCount = 0
mobList[zone][DMB+9  ].randomChildrenCount = 0
mobList[zone][DMB+10 ].randomChildrenCount = 0

-- set my random children list i will pick from
mobList[zone][SMB+0  ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+1  ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+2  ].randomChildrenList = 1 -- Serjent Tombstone
mobList[zone][SMB+3  ].randomChildrenList = 2 -- Goblin Replica
mobList[zone][SMB+4  ].randomChildrenList = 1 -- Serjent Tombstone
mobList[zone][SMB+5  ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+6  ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+7  ].randomChildrenList = 2 -- Goblin replica
mobList[zone][SMB+8  ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+9  ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+10 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+11 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+12 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+13 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+14 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+15 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+16 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+17 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+18 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+19 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+20 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+21 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+22 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+23 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+24 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+25 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+26 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+27 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+28 ].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+29 ].randomChildrenList = 3 -- Dynamis Icon
mobList[zone][SMB+30 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+31 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+32 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+33 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+34 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+35 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+36 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+37 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+38 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+39 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+40 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+41 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+42 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+43 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+44 ].randomChildrenList = 2 -- Dynamis Statue
mobList[zone][SMB+45 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+46 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+47 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+48 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+49 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+50 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+51 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+52 ].randomChildrenList = 2 -- Goblin Statue
mobList[zone][SMB+53 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+54 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+55 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+56 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+57 ].randomChildrenList = 4 -- Dynamis Effigy
mobList[zone][SMB+58 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+59 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+60 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+61 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+62 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+63 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+64 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+65 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+66 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+67 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+68 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+69 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+70 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+71 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+72 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+73 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+74 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+75 ].randomChildrenList = 4 -- Adamantking Effigy
mobList[zone][SMB+76 ].randomChildrenList = 1 -- Dynamis Tombstone
mobList[zone][SMB+77 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+78 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+79 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+80 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+81 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+82 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+83 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+84 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+85 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+86 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+87 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+88 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+89 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+90 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+91 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+92 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+93 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+94 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+95 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+96 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+97 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+98 ].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+99 ].randomChildrenList = 4 -- Adanantking Effigy
mobList[zone][SMB+100].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+101].randomChildrenList = 2 -- GOblin Replica
mobList[zone][SMB+102].randomChildrenList = 4 -- Adanamtking Effigy
mobList[zone][SMB+103].randomChildrenList = 2 -- Goblin Replica
mobList[zone][SMB+104].randomChildrenList = 1 -- Serjeant Tombstone
mobList[zone][SMB+105].randomChildrenList = 3 -- Avatar Icon
mobList[zone][SMB+106].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+107].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+108].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+109].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+110].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+111].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+112].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+113].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+114].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+115].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+116].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+117].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+118].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+119].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+120].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+121].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+122].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+123].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+124].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+125].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+126].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+127].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+128].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+129].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+130].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+131].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+132].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+133].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+134].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+135].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+136].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+137].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+138].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+139].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+140].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+141].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+142].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+143].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+144].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+145].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+146].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+147].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+148].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+149].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+150].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+151].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+152].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+153].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+154].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+155].randomChildrenList = 5 -- Vanguard Eye
mobList[zone][SMB+156].randomChildrenList = 5 -- Vanguard Eye


-- random children list, i.e. a statue can pick from a long list of mobs with varying jobs
randomChildrenList[zone] =
{
    [1] = -- Orcs
    {
        17326208,
        17326209,
        17326210,
        17326211,
        17326213,
        17326214,
        17326215,
        17326217,
        17326219,
        17326220,
        17326221,
        17326222,
        17326224,
        17326225,
        17326227,
        17326228,
        17326230,
        17326231,
        17326235,
        17326236,
        17326238,
        17326239,
        17326241,
        17326242,
        17326244,
        17326245,
        17326246,
        17326247,
        17326249,
        17326250,
        17326251,
        17326252,
        17326254,
        17326256,
        17326257,
        17326259,
        17326260,
        17326261,
        17326263,
        17326267,
        17326268,
        17326269,
        17326271
    },

    [2] = -- Goblins
    {
        17326354,
        17326355,
        17326356,
        17326357,
        17326358,
        17326360,
        17326361,
        17326362,
        17326363,
        17326364,
        17326365,
        17326366,
        17326367,
        17326368,
        17326370,
        17326371,
        17326372,
        17326373,
        17326375,
        17326376,
        17326377,
        17326378,
        17326380,
        17326381,
        17326382,
        17326383,
        17326385,
        17326386,
        17326388,
        17326389,
        17326390,
        17326391,
        17326393,
        17326394,
        17326395,
        17326396,
        17326398,
        17326399,
        17326400,
        17326402,
        17326403,
        17326404,
        17326406,
        17326408,
        17326409,
        17326411,
        17326412,
        17326413,
        17326414,
        17326416,
        17326417,
        17326419,
        17326423,
        17326424,
        17326425,
        17326426,
        17326428,
        17326429,
        17326430,
        17326431,
        17326432,
        17326433,
        17326434,
        17326435,
        17326437,
        17326441,
        17326442,
        17326443,
        17326444,
        17326448,
        17326449,
        17326450,
        17326451,
        17326453,
        17326454,
        17326456,
        17326457,
        17326459,
        17326460,
        17326461,
        17326462
    },

    [3] = -- Yagudo
    {
        17326280,
        17326281,
        17326282,
        17326283,
        17326285,
        17326286,
        17326287,
        17326288,
        17326290,
        17326291,
        17326293,
        17326294,
        17326296,
        17326297,
        17326298,
        17326299,
        17326301,
        17326302,
        17326303,
        17326305,
        17326309,
        17326310,
        17326311,
        17326312,
        17326314,
        17326315,
        17326317,
        17326318,
        17326320,
        17326321,
        17326322,
        17326324,
        17326326,
        17326330,
        17326331,
        17326333,
        17326334,
        17326336,
        17326337,
        17326338,
        17326339,
        17326341,
        17326342,
        17326343,
        17326345
    },

    [4] = -- Quads
    {
        17326099,
        17326100,
        17326101,
        17326102,
        17326103,
        17326105,
        17326107,
        17326108,
        17326109,
        17326110,
        17326111,
        17326113,
        17326115,
        17326116,
        17326117,
        17326118,
        17326119,
        17326120,
        17326121,
        17326122,
        17326123,
        17326124,
        17326127,
        17326128,
        17326129,
        17326130,
        17326131,
        17326132,
        17326133,
        17326134,
        17326136,
        17326137,
        17326138,
        17326139,
        17326140,
        17326141,
        17326142,
        17326143,
        17326146,
        17326148,
        17326149,
        17326150,
        17326152,
        17326153,
        17326154,
        17326155,
        17326157,
        17326159,
        17326160,
        17326161,
        17326164,
        17326165,
        17326166,
        17326167,
        17326169,
        17326170,
        17326171,
        17326172,
        17326174,
        17326175,
        17326176,
        17326177,
        17326181,
        17326182,
        17326183,
        17326184,
        17326186,
        17326187,
        17326188,
        17326189,
        17326191,
        17326192,
        17326193,
        17326194,
        17326196,
        17326197,
        17326198,
        17326199
    },

    [5] = -- Hydra
    {
        17326469,
        17326470,
        17326471,
        17326472,
        17326474,
        17326475,
        17326476,
        17326477,
        17326479,
        17326480,
        17326481,
        17326482,
        17326485,
        17326486,
        17326487,
        17326488,
        17326489,
        17326490,
        17326491,
        17326492,
        17326495,
        17326496,
        17326497,
        17326498,
        17326499,
        17326502,
        17326503,
        17326505,
        17326508,
        17326509,
        17326511,
        17326512,
        17326513,
        17326515,
        17326516,
        17326517,
        17326518,
        17326520,
        17326521,
        17326522,
        17326523,
        17326524,
        17326526,
        17326527,
        17326528,
        17326529,
        17326531,
        17326533,
        17326534,
        17326535,
        17326537,
        17326538,
        17326539,
        17326540,
        17326543,
        17326544,
        17326545,
        17326546,
        17326548,
        17326549,
        17326551,
        17326552,
        17326554,
        17326555,
        17326556,
        17326557,
        17326559,
        17326560,
        17326561,
        17326562,
        17326563,
        17326564,
        17326566,
        17326567,
        17326568,
        17326569,
        17326570,
        17326571,
        17326573,
        17326574,
        17326575,
        17326576,
        17326577,
        17326578,
        17326580,
        17326581,
        17326582,
        17326583,
        17326584,
        17326587,
        17326589,
        17326590,
        17326591,
        17326592,
        17326594,
        17326596,
        17326597,
        17326598,
        17326599,
        17326601,
        17326603,
        17326605,
        17326606,
        17326608,
        17326609,
        17326610,
        17326611,
        17326613,
        17326614,
        17326615,
        17326616,
        17326618,
        17326619,
        17326620,
        17326621,
        17326624,
        17326625,
        17326626,
        17326627,
        17326630,
        17326631,
        17326632,
        17326633,
        17326635,
        17326636,
        17326637,
        17326638,
        17326640,
        17326642,
        17326644,
        17326645,
        17326647,
        17326648,
        17326649,
        17326650,
        17326652,
        17326653,
        17326654,
        17326655,
        17326657,
        17326658,
        17326659,
        17326660,
        17326662,
        17326664,
        17326666,
        17326667,
        17326669,
        17326670,
        17326671,
        17326672,
        17326674,
        17326675,
        17326676,
        17326677,
        17326679,
        17326680,
        17326681,
        17326682,
        17326684,
        17326685,
        17326687,
        17326689,
        17326690,
        17326691,
        17326693,
        17326694,
        17326695,
        17326697,
        17326698,
        17326699,
        17326702,
        17326703,
        17326704,
        17326707,
        17326708,
        17326709,
        17326710,
        17326711,
        17326712,
        17326713,
        17326714,
        17326715,
        17326717,
        17326718,
        17326719,
        17326720,
        17326722,
        17326723,
        17326724,
        17326726,
        17326728,
        17326729,
        17326730,
        17326731,
        17326733,
        17326734,
        17326736,
        17326738,
        17326739,
        17326740,
        17326741,
        17326743,
        17326744,
        17326745,
        17326746,
        17326749,
        17326750,
        17326751,
        17326752,
        17326755,
        17326756,
        17326757,
        17326758,
        17326761,
        17326762,
        17326763,
        17326764,
        17326766,
        17326767,
        17326768,
        17326769,
        17326772,
        17326773,
        17326774,
        17326775,
        17326777,
        17326778,
        17326779,
        17326780,
        17326782,
        17326783,
        17326785,
        17326787,
        17326788,
        17326789
    }

}

-- NPC list, only really need to add NPCs that need to be spawned at the start
-- example: [5151] = { id = 5151, spawnAtStart = true },
npcList[zone] =
{

}
