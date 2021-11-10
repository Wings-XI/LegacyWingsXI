---------------------------------------------------
--
-- Data for Nyzul Isle
--
---------------------------------------------------

tpz = tpz or {}
tpz.nyzul_isle_data = tpz.nyzul_isle_data or {}

tpz.nyzul_isle_data.mobType =
{   
    "AQUANS", -- first set of floor - 1
    "AMORPHS_1",
    "ARCANA_1",
    "UNDEAD",
    "VERMIN",
    "DEMONS",
    "DRAGONS",
    "BIRDS",
    "BEASTS",
    "PLANTOIDS",
    "LIZARDS",
    "AMORPHS_2",
    "MIXED_1",
    "MIXED_2",
    "AMORPHS_3",
    "ARCANA_2", --last set of floor - 16
    "RAMPARTS", -- 17
    "DAHAK",
    "IMPS", -- first specifc -- 19
    "SOULFLAYERS",
    "POROGGOS",
    "PUDDINGS",
    "QIQIRN",
    "CHARIOTS", -- last specific -- 24
    "LEADERS",
    "GEARS",
    "NMS_01_19",
    "NMS_21_39",
    "NMS_41_59",
    "NMS_61_79",
    "NMS_81_99",
    "BOSSES_20_60",
    "BOSSES_80_100",
}

tpz.nyzul_isle_data.mobsByType =
{
    AQUANS = {
        Greatclaw = {17092631, 17092632, 17092633, 17092634, 17092635, 17092636},
        Stygian_Pugil = {17092637, 17092638, 17092639, 17092640},
        Kulshedra = {17092641, 17092642},
    },
    AMORPHS_1 = {
        Bouncing_Ball = {17092643, 17092644, 17092645},
        Thousand_Eyes = {17092646, 17092647, 17092648},
        Mousse = {17092649, 17092650, 17092651, 17092652},
        Black_Pudding = {17092653, 17092654},
    },
    ARCANA_1 = {
        Killing_Weapon = {17092655, 17092656},
        Ominous_Weapon = {17092657, 17092658},
        Magic_Flagon = {17092659, 17092660},
        Friars_Lantern = {17092661, 17092662, 17092665, 17092666},
        Sweeping_Cluster = {17092663, 17092664},
    },
    ARCANA_1 = {
        Killing_Weapon = {17092655, 17092656},
        Ominous_Weapon = {17092657, 17092658},
        Magic_Flagon = {17092659, 17092660},
        Friars_Lantern = {17092661, 17092662, 17092665, 17092666},
        Sweeping_Cluster = {17092663, 17092664},
    },
    UNDEAD = {
        Garm = {17092667, 17092668, 17092669},
        Tainted_Flesh = {17092670, 17092671, 17092672},
        Draugar_Blm = {17092673, 17092674},
        Draugar_Thf = {17092675, 17092676},
        Bhoot = {17092677, 17092678},
    },
    VERMIN = {
        Carmine_Eruca = {17092679, 17092680, 17092681},
        Spinner = {17092682, 17092683, 17092684},
        Wamouracampa = {17092685, 17092686, 17092687, 17092688},
        Wamoura = {17092689, 17092690},
    },
    DEMONS = {
        Imp = {17092691, 17092692, 17092693, 17092694, 17092695, 17092696, 17092697, 17092698, 17092699, 17092700},
        Psycheflayer = {17092701, 17092702},
    },
    DRAGONS = {
        Puk = {17092703, 17092704, 17092705, 17092706, 17092707, 17092708, 17092709, 17092710, 17092711, 17092712},
        Wyvern = {17092713, 17092714},
    },
    BIRDS = {
        Marsh_Murre = {17092715, 17092716, 17092717},
        Lesser_Colibri = {17092718, 17092719, 17092720},
        Ziz = {17092721, 17092722, 17092723, 17092724},
        Peryton = {17092725, 17092726},
    },
    BEASTS = {
        Wild_Karakul = {17092727, 17092728, 17092729},
        Wajaom_Tiger = {17092730, 17092731, 17092732},
        Manticore = {17092733, 17092734, 17092735, 17092736},
        Marid = {17092737, 17092738},
    },
    PLANTOIDS = {
        Death_Cap = {17092739, 17092740, 17092741},
        Puktrap = {17092742, 17092743, 17092744},
        Leshy = {17092745, 17092746, 17092747, 17092748},
        Ameretat = {17092749, 17092750},
    },
    LIZARDS = {
        Sand_Lizard = {17092751, 17092752, 17092753},
        Deinonychus = {17092754, 17092755, 17092756},
        Bull_Bugard = {17092757, 17092758, 17092759, 17092760},
        Wivre = {17092761, 17092762},
    },
    AMORPHS_2 = {
        Bouncing_Ball = {17092763, 17092764, 17092765, 17092766, 17092767},
        Thousand_Eyes = {17092768, 17092769, 17092770, 17092771, 17092772},
        Mousse = {17092773, 17092774},
    },
    MIXED_1 = {
        Peryton = {17092775, 17092776, 17092777, 17092778, 17092779, 17092780, 17092781, 17092782, 17092783, 17092784},
        Mousse = {17092785, 17092786},
    },
    MIXED_2 = {
        Draugar = {17092787, 17092788, 17092789, 17092790, 17092791, 17092792, 17092793, 17092794, 17092795, 17092796},
        Mousse = {17092797, 17092798},
    },
    AMORPHS_3 = {
        Mousse = {17092799, 17092800, 17092801, 17092802, 17092803, 17092804},
        Black_Pudding = {17092805, 17092806, 17092807, 17092808, 17092809, 17092810},
    },
    ARCANA_2 = {
        Killing_Weapon = {17092811, 17092812, 17092813},
        Ominous_Weapon = {17092814, 17092815, 17092816},
        Magic_Flagon = {17092817, 17092818, 17092819, 17092820, 17092821, 17092822},
    },
    RAMPARTS = {
        Archaic_Rampart = {17092629, 17092630}, -- one per floor, alternate like runes of transfer
    },
    DAHAK = {
        Dahak = {17092823},
    },
    IMPS = {
        Heraldic_Imp = {17092969, 17092970, 17092971, 17092972, 17092973},
    },
    SOULFLAYERS = {
        Psycheflayer = {17092974, 17092975, 17092976, 17092977, 17092978},
    },
    POROGGOS = {
        Poroggo_Gent = {17092979, 17092980, 17092981, 17092982, 17092983},
    },
    PUDDINGS = {
        Ebony_Pudding = {17092984, 17092985, 17092986, 17092987, 17092988},
    },
    QIQIRN = {
        Qiqirn_Treasure_Hunter = {17092989, 17092990},
        Qiqirn_Archaeologist = {17092991, 17092992, 17092993},
    },
    CHARIOTS = {
        Racing_Chariot = {17092994, 17092995, 17092996, 17092997, 17092998},
    },
    LEADERS = { -- 17092962 ommitted - its a Qiqirn_Mine
        Leaders = {17092944, 17092945, 17092946, 17092947, 17092948, 17092949, 17092950, 17092951, 17092952, 17092953, 17092954, 17092955, 17092956, 17092957, 17092958, 17092959, 17092960, 17092961, 17092963, 17092964, 17092965, 17092966, 17092967, 17092968},
    },
    GEARS = { -- there are a lot more gears. 15 more Gear and 5 more Gears.  I dont know why and at this point I'm too afraid to ask
        Archaic_Gear = {17092914, 17092915, 17092916, 17092917, 17092918},
        Archaic_Gears = {17092919, 17092920, 17092921, 17092922, 17092923},
    },
    NMS_01_19 = {
        NotoriusMonsters = {17092824, 17092825, 17092826, 17092827, 17092828, 17092829, 17092830, 17092831, 17092832, 17092833, 17092834, 17092835, 17092836, 17092837, 17092838, 17092839, 17092840, 17092841},
    },
    NMS_21_39 = {
        NotoriusMonsters = {17092842, 17092843, 17092844, 17092845, 17092846, 17092847, 17092848, 17092849, 17092850, 17092851, 17092852, 17092853, 17092854, 17092855, 17092856, 17092857, 17092858, 17092859},
    },
    NMS_41_59 = {
        NotoriusMonsters = {17092860, 17092861, 17092862, 17092863, 17092864, 17092865, 17092866, 17092867, 17092868, 17092869, 17092870, 17092871, 17092872, 17092873, 17092874, 17092875, 17092876, 17092877},
    },
    NMS_61_79 = {
        NotoriusMonsters = {17092878, 17092879, 17092880, 17092881, 17092882, 17092883, 17092884, 17092885, 17092886, 17092887, 17092888, 17092889, 17092890, 17092891, 17092892, 17092893, 17092894, 17092895},
    },
    NMS_81_99 = {
        NotoriusMonsters = {17092896, 17092897, 17092898, 17092899, 17092900, 17092901, 17092902, 17092903, 17092904, 17092905, 17092906, 17092907, 17092908, 17092909, 17092910, 17092911, 17092912, 17092913},
    },
    BOSSES_20_60 = {
        Bosses = {17092999, 17093000, 17093001},
    },
    BOSSES_80_100 = {
        Bosses = {17093002, 17093003, 17093004},
    },
}

tpz.nyzul_isle_data.bossFloorLayouts =
{
    BOSS_ROOM_1 = { -- South Map, Western room
        BossSpawnPoints = {{x = -60, y = 0, z = -395}, {x = -60, y = 0, z = -365}, {x = -75, y = 0, z = -380}},
        RampartSpawnPoints = {{x = -35, y = 0, z = -405}, {x = -85, y = 0, z = -405}, {x = -85, y = 0, z = -355}, {x = -35, y = 0, z = -355}},
        RuneOfTransferSpawnPoint = {x = -11, y = 0, z = -380},
        DoorsToClose = {17093382, 17093384, 17093387},
        DoorsToOpen = {}
    },
    BOSS_ROOM_2 = { -- SouthWest Map, Central room
        BossSpawnPoints = {{x = -380, y = 0, z = -395}, {x = -380, y = 0, z = -365}, {x = -395, y = 0, z = -380}},
        RampartSpawnPoints = {{x = -355, y = 0, z = -405}, {x = -405, y = 0, z = -405}, {x = -405, y = 0, z = -355}, {x = -355, y = 0, z = -355}},
        RuneOfTransferSpawnPoint = {x = -330, y = 0, z = -380},
        DoorsToClose = {17093408, 17093409, 17093410, 17093411},
        DoorsToOpen = {}
    },
    BOSS_ROOM_3 = { -- SouthWest Map, Northern room
        BossSpawnPoints = {{x = -540, y = -4, z = -275}, {x = -540, y = -4, z = -245}, {x = -555, y = -4, z = -260}},
        RampartSpawnPoints = {{x = -565, y = -4, z = -285}, {x = -515, y = -4, z = -285}, {x = -565, y = -4, z = -235}, {x = -515, y = -4, z = -235}},
        RuneOfTransferSpawnPoint = {x = -491, y = -4, z = -260},
        DoorsToClose = {17093414, 17093415, 17093416},
        DoorsToOpen = {}
    },
    BOSS_ROOM_4 = { -- SouthWest Map, Southern room
        BossSpawnPoints = {{x = -540, y = -4, z = -515}, {x = -540, y = -4, z = -485}, {x = -555, y = -4, z = -500}},
        RampartSpawnPoints = {{x = -565, y = -4, z = -475}, {x = -515, y = -4, z = -475}, {x = -565, y = -4, z = -525}, {x = -515, y = -4, z = -525}},
        RuneOfTransferSpawnPoint = {x = -491, y = -4, z = -500},
        DoorsToClose = {17093402, 17093403, 17093404},
        DoorsToOpen = {}
    }
}

-- Note that floor layouts do not include the starting floor.  Lamps and Mobs cannot spawn in the same room as a Rune of Transfer
tpz.nyzul_isle_data.northEastFloorLayouts =
{
    -- MobSpawnPoints need 26 - 12 (floor mobs) + 1  (rampart) + 5 (specified enemies) + 5 (gears) + 3 (NMs)
    -- This means a minimum of 5 rooms per config
    FLOOR_NE_1 = {
        Rooms = {"NE_B", "NE_A", "NE_C", "NE_D", "NE_E", "NE_F", "NE_G"}, 
        RuneOfTransferSpawnPoint = {x = 420, y = 0, z = 420},
        DoorsToClose = {17093375},
        DoorsToOpen = {17093379, 17093377, 17093376, 17093378}
    },
    FLOOR_NE_2 = {
        Rooms = {}, 
        RuneOfTransferSpawnPoint = {x = 580, y = 0, z = 420},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_NE_3 = {
        Rooms = {}, 
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_NE_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_NE_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_NE_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.eastFloorLayouts =
{
    FLOOR_EAST_1 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_EAST_2 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_EAST_3 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_EAST_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_EAST_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_EAST_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.centralFloorLayouts =
{
    FLOOR_CENTRAL_1 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_CENTRAL_2 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_CENTRAL_3 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_CENTRAL_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_CENTRAL_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_CENTRAL_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.southEastFloorLayouts =
{
    FLOOR_SE_1 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SE_2 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SE_3 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SE_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SE_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SE_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.southFloorLayouts =
{
    FLOOR_SOUTH_1 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SOUTH_2 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SOUTH_3 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SOUTH_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SOUTH_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SOUTH_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.southWestFloorLayouts =
{
    FLOOR_SW_1 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SW_2 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SW_3 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SW_4 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SW_5 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    },
    FLOOR_SW_6 = {
        Rooms = {},
        RuneOfTransferSpawnPoint = {x = xxx, y = xxx, z = xxx},
        DoorsToClose = {},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.northEastRoomConfigurations = {
    NE_A = {
        MobSpawnPoints = {{x = 420, y = 0, z = 500}, {x = 500, y = 0, z = 500}, {x = 460, y = 0, z = 509}, {x = 469, y = 0, z = 500}, {x = 451, y = 0, z = 500}}, 
        LampSpawnPoints = {{x = 460, y = 0, z = 500}, {x = 460, y = 0, z = 491}}
    },
    NE_B = {
        MobSpawnPoints = {{x = 433.5, y = 0, z = 446.5}, {x = 406.5, y = 0, z = 451}, {x = 406.5, y = 0, z = 473.5}, {x = 415.5, y = 0, z = 464.5}, {x = 415.5, y = 0, z = 455.5}}, 
        LampSpawnPoints = {{x = 424.5, y = 0, z = 460}, {x = 433.5, y = 0, z = 473.5}}
    },
    NE_C = {
        MobSpawnPoints = {{x = 460, y = 0, z = 451}, {x = 469, y = 0, z = 451}, {x = 451, y = 0, z = 460}, {x = 451, y = 0, z = 469}, {x = 469, y = 0, z = 469}}, 
        LampSpawnPoints = {{x = 460, y = 0, z = 469}, {x = 473.5, y = 0, z = 473.5}}
    },
    NE_D = {
        MobSpawnPoints = {{x = 504.5, y = 0, z = 455.5}, {x = 504.5, y = 0, z = 464.5}, {x = 488.5, y = 0, z = 473.5}, {x = 490.5, y = 0, z = 446.5}, {x = 513.5, y = 0, z = 473.5}}, 
        LampSpawnPoints = {{x = 513.5, y = 0, z = 446.5}, {x = 495, y = 0, z = 460}}
    },
    NE_E = {
        MobSpawnPoints = {{x = 473.5, y = 0, z = 406.5}, {x = 460, y = 0, z = 420}, {x = 460, y = 0, z = 429}, {x = 446.5, y = 0, z = 433.5}, {x = 455.5, y = 0, z = 415.5}}, 
        LampSpawnPoints = {{x = 460, y = 0, z = 420}, {x = 446.5, y = 0, z = 406.5}}
    },
    NE_F = {
        MobSpawnPoints = {{x = 495.5, y = 0, z = 415.5}, {x = 505.5, y = 0, z = 415.5}, {x = 513.5, y = 0, z = 406.5}, {x = 513.5, y = 0, z = 433.5}, {x = 486.5, y = 0, z = 433.5}}, 
        LampSpawnPoints = {{x = 500, y = 0, z = 433.5}, {x = 500, y = 0, z = 424.5}}
    },
    NE_G = {
        MobSpawnPoints = {{x = 540, y = 0, z = 411}, {x = 535.5, y = 0, z = 424.5}, {x = 553.5, y = 0, z = 433.5}, {x = 549, y = 0, z = 420}, {x = 526.5, y = 0, z = 415.5}}, 
        LampSpawnPoints = {{x = 540, y = 0, z = 420}, {x = 533.5, y = 0, z = 433.5}}
    },
    NE_H = {
        MobSpawnPoints = {{x = 500, y = 0, z = 380}, {x = 491, y = 0, z = 389}, {x = 491, y = 0, z = 371}, {x = 509, y = 0, z = 389}, {x = 509, y = 0, z = 371}}, 
        LampSpawnPoints = {{x = 500, y = 0, z = 380}, {x = 486.5, y = 0, z = 366.5}}
    },
    NE_I = {
        MobSpawnPoints = {{x = 540, y = 0, z = 371}, {x = 549, y = 0, z = 380}, {x = 531, y = 0, z = 380}, {x = 553.5, y = 0, z = 366.5}, {x = 540, y = 0, z = 393.5}}, 
        LampSpawnPoints = {{x = 540, y = 0, z = 389}, {x = 526.5, y = 0, z = 366.5}}
    },
    NE_J = {
        MobSpawnPoints = {{x = 584.5, y = 0, z = 375.5}, {x = 584.5, y = 0, z = 384.5}, {x = 580, y = 0, z = 336.5}, {x = 566.5, y = 0, z = 380}, {x = 580, y = 0, z = 393.5}}, 
        LampSpawnPoints = {{x = 580, y = 0, z = 393.5}, {x = 575.5, y = 0, z = 380}}
    },
    NE_K = {
        MobSpawnPoints = {{x = 460, y = 0, z = 344.5}, {x = 451, y = 0, z = 340}, {x = 469, y = 0, z = 340}, {x = 464.5, y = 0, z = 331}, {x = 455.5, y = 0, z = 331}}, 
        LampSpawnPoints = {{x = 460, y = 0, z = 340}, {x = 460, y = 0, z = 349}}
    },
    NE_L = {
        MobSpawnPoints = {{x = 486.5, y = 0, z = 353.5}, {x = 495.5, y = 0, z = 340}, {x = 504.5, y = 0, z = 340}, {x = 509, y = 0, z = 353.5}, {x = 513.5, y = 0, z = 326.5}}, 
        LampSpawnPoints = {{x = 500, y = 0, z = 335.5}, {x = 486.5, y = 0, z = 326.5}}
    },
    NE_M = {
        MobSpawnPoints = {{x = 540, y = 0, z = 340}, {x = 540, y = 0, z = 349}, {x = 531, y = 0, z = 340}, {x = 549, y = 0, z = 340}, {x = 553.5, y = 0, z = 326.5}}, 
        LampSpawnPoints = {{x = 540, y = 0, z = 340}, {x = 540, y = 0, z = 331}}
    },
    NE_N = {
        MobSpawnPoints = {{x = 420, y = 0, z = 340}, {x = 420, y = 0, z = 260}, {x = 433.5, y = 0, z = 300}, {x = 406.5, y = 0, z = 309}, {x = 411, y = 0, z = 295.5}}, 
        LampSpawnPoints = {{x = 424.5, y = 0, z = 300}, {x = 433.5, y = 0, z = 286.5}}
    },
    NE_O = {
        MobSpawnPoints = {{x = 451, y = 0, z = 309}, {x = 460, y = 0, z = 309}, {x = 451, y = 0, z = 291}, {x = 460, y = 0, z = 291}, {x = 469, y = 0, z = 300}}, 
        LampSpawnPoints = {{x = 446.5, y = 0, z = 313.5}, {x = 451, y = 0, z = 300}}
    },
    NE_P = {
        MobSpawnPoints = {{x = 491, y = 0, z = 286.5}, {x = 491, y = 0, z = 313.5}, {x = 513.5, y = 0, z = 304.5}, {x = 500, y = 0, z = 304.5}, {x = 513, y = 0, z = 291}}, 
        LampSpawnPoints = {{x = 495.5, y = 0, z = 300}, {x = 486.5, y = 0, z = 300}}
    },
    NE_Q = {
        MobSpawnPoints = {{x = 460, y = 0, z = 260}, {x = 455.5, y = 0, z = 264.5}, {x = 464.5, y = 0, z = 255.5}, {x = 455.5, y = 0, z = 255.5}, {x = 464.5, y = 0, z = 264.5}}, 
        LampSpawnPoints = {{x = 460, y = 0, z = 269}, {x = 460, y = 0, z = 251}}
    }
}