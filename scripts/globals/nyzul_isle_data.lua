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
    "BOSSES_20_40",
    "BOSSES_60_100",
}

tpz.nyzul_isle_data.objectiveType = {
    "ELIMINATE_ALL_ENEMIES",
    "ELIMINATE_ENEMY_LEADER",
    "ELIMINATE_SPECIFIED_ENEMY",
    "ELIMINATE_SPECIFIED_ENEMIES",
    "ACTIVATE_ALL_LAMPS_CERTIFICATION",
    "ACTIVATE_ALL_LAMPS_SAME_TIME",
    "ACTIVATE_ALL_LAMPS_ORDERED"
}

tpz.nyzul_isle_data.subObjectiveType = {
    "DO_NOT_DESTROY_GEARS",
    "AVOID_DECTECTION_BY_GEARS"
}

tpz.nyzul_isle_data.maps = {
    "NORTH_EAST",
    "EAST",
    "CENTRAL",
    "SOUTH_EAST",
    "SOUTH",
    "SOUTH_WEST"
}
-- uses tpz.job values for key value (see status.lua)
tpz.nyzul_isle_data.jobToVigilWeaponMap = {
    18492, -- WAR - Sturdy_Axe
    18753, -- MNK - Burning_Fists
    18851, -- WHM - Werebuster
    18589, -- BLM - Mages_Staff
    17742, -- RDM - Vorpal_Sword
    18003, -- THF - Swordbuster
    17744, -- PLD - Brave_Blade
    18944, -- DRK - Death_Sickle
    17956, -- BST - Double_Axe
    18034, -- BRD - Dancing_Dagger
    18719, -- RNG - Killer_Bow
    18443, -- SAM - Windslicer
    18426, -- NIN - Sasuke_Katana
    18120, -- DRG - Radiant_Lance
    18590, -- SMN - Scepter_Staff
    17743, -- BLU - Wightslayer
    18720, -- COR - Quicksilver
    18754, -- PUP - Inferno_Claws
    19102, -- DNC - Main_Gauche
    18592 -- SCH - Elder_Staff
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
        Draugar_Blm = {17092787, 17092788, 17092789, 17092790, 17092791},
        Draugar_Thf = {17092792, 17092793, 17092794, 17092795, 17092796},
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
    GEARS = { -- there are a lot more gears in the database. 15 more Gear and 5 more Gears.  I dont know why and at this point I'm too afraid to ask
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
    BOSSES_20_40 = {
        Bosses = {17092999, 17093000, 17093001},
    },
    BOSSES_60_100 = {
        Bosses = {17093002, 17093003, 17093004},
    },
}

tpz.nyzul_isle_data.npcLists = {
    Lamps = {17093332, 17093333, 17093334, 17093335, 17093336},
    Armoury_Crates = {17092609, 17092610, 17092611, 17092612, 17092613, 17092614, 17092615, 17092616, 17092617, 17092618, 17092619, 17092620, 17092621, 17092622, 17092623},
    Armoury_Crates_For_NMs = {17092624, 17092625, 17092626, 17092627, 17092628}
}

tpz.nyzul_isle_data.bossFloorTableKeys = {
    "BOSS_ROOM_1",
    "BOSS_ROOM_2",
    "BOSS_ROOM_3",
    "BOSS_ROOM_4"
}

tpz.nyzul_isle_data.bossFloorLayouts =
{
    BOSS_ROOM_1 = { -- South Map, Western room
        BossSpawnPoints = {{x = -60, y = 0, z = -395}, {x = -60, y = 0, z = -365}, {x = -75, y = 0, z = -380}},
        RampartSpawnPoints = {{x = -35, y = 0, z = -405}, {x = -85, y = 0, z = -405}, {x = -85, y = 0, z = -355}, {x = -35, y = 0, z = -355}, {x = -60, y = 0, z = -395}, {x = -60, y = 0, z = -365}, {x = -75, y = 0, z = -380}},
        RuneOfTransferSpawnPoint = {x = -11, y = 0, z = -380},
        DoorsToClose = {17093382, 17093384, 17093387},
        DoorsToOpen = {}
    },
    BOSS_ROOM_2 = { -- SouthWest Map, Central room
        BossSpawnPoints = {{x = -380, y = 0, z = -395}, {x = -380, y = 0, z = -365}, {x = -395, y = 0, z = -380}},
        RampartSpawnPoints = {{x = -355, y = 0, z = -405}, {x = -405, y = 0, z = -405}, {x = -405, y = 0, z = -355}, {x = -355, y = 0, z = -355}, {x = -380, y = 0, z = -395}, {x = -380, y = 0, z = -365}, {x = -395, y = 0, z = -380}},
        RuneOfTransferSpawnPoint = {x = -330, y = 0, z = -380},
        DoorsToClose = {17093408, 17093409, 17093410, 17093411},
        DoorsToOpen = {}
    },
    BOSS_ROOM_3 = { -- SouthWest Map, Northern room
        BossSpawnPoints = {{x = -540, y = -4, z = -275}, {x = -540, y = -4, z = -245}, {x = -555, y = -4, z = -260}},
        RampartSpawnPoints = {{x = -565, y = -4, z = -285}, {x = -515, y = -4, z = -285}, {x = -565, y = -4, z = -235}, {x = -515, y = -4, z = -235}, {x = -540, y = -4, z = -275}, {x = -540, y = -4, z = -245}, {x = -555, y = -4, z = -260}},
        RuneOfTransferSpawnPoint = {x = -491, y = -4, z = -260},
        DoorsToClose = {17093414, 17093415, 17093416},
        DoorsToOpen = {}
    },
    BOSS_ROOM_4 = { -- SouthWest Map, Southern room
        BossSpawnPoints = {{x = -540, y = -4, z = -515}, {x = -540, y = -4, z = -485}, {x = -555, y = -4, z = -500}},
        RampartSpawnPoints = {{x = -565, y = -4, z = -475}, {x = -515, y = -4, z = -475}, {x = -565, y = -4, z = -525}, {x = -515, y = -4, z = -525}, {x = -540, y = -4, z = -515}, {x = -540, y = -4, z = -485}, {x = -555, y = -4, z = -500}},
        RuneOfTransferSpawnPoint = {x = -491, y = -4, z = -500},
        DoorsToClose = {17093402, 17093403, 17093404},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.northEastFloorTableKeys = {
    "FLOOR_NE_1",
    "FLOOR_NE_2",
    "FLOOR_NE_3",
    "FLOOR_NE_4",
    "FLOOR_NE_5",
    "FLOOR_NE_6",
}

-- Note that floor layouts do not include the starting floor (entrance to Nyzul).
-- Lamps and Mobs should not spawn in the same room as a Rune of Transfer - therefore when the RuneOfTransferSpawnPoint is within a room, exclude that room from the Rooms list
tpz.nyzul_isle_data.northEastFloorLayouts =
{
    -- MobSpawnPoints need 26 - 12 (floor mobs) + 1  (rampart) + 5 (specified enemies) + 5 (gears) + 3 (NMs)
    -- This means a minimum of 6 rooms per config minimum
    FLOOR_NE_1 = { -- NW loop
        Rooms = {"NE_B", "NE_A", "NE_C", "NE_D", "NE_E", "NE_F"},
        RuneOfTransferSpawnPoint = {x = 420, y = 0, z = 420},
        DoorsToClose = {17093378},
        DoorsToOpen = {17093379, 17093377, 17093376}
    },
    FLOOR_NE_2 = { -- SW Loop
        Rooms = {"NE_K", "NE_L", "NE_N", "NE_O", "NE_P", "NE_Q"},
        RuneOfTransferSpawnPoint = {x = 500, y = 0, z = 260},
        DoorsToClose = {17093373},
        DoorsToOpen = {17093372, 17093371, 17093370}
    },
    FLOOR_NE_3 = { -- East collection of rooms
        Rooms = {"NE_G", "NE_H", "NE_I", "NE_J", "NE_L", "NE_M"},
        RuneOfTransferSpawnPoint = {x = 580, y = 0, z = 420},
        DoorsToClose = {17093378, 17093371, 17093372},
        DoorsToOpen = {17093373, 17093374, 17093375}
    },
    FLOOR_NE_4 = { -- Another East Collection - starting in NE_F
        Rooms = {"NE_E", "NE_G", "NE_H", "NE_I", "NE_J", "NE_M"},
        RuneOfTransferSpawnPoint = {x = 500, y = 0, z = 424.5},
        DoorsToClose = {17093376, 17093377, 17093373},
        DoorsToOpen = {17093378, 17093375, 17093374}
    },
    FLOOR_NE_5 = { -- East side, long train of rooms
        Rooms = {"NE_E", "NE_F", "NE_G", "NE_J", "NE_M", "NE_L"},
        RuneOfTransferSpawnPoint = {x = 580, y = 0, z = 340},
        DoorsToClose = {17093371, 17093372, 17093374, 17093377, 17093376},
        DoorsToOpen = {17093378, 17093375, 17093373}
    },
    FLOOR_NE_6 = { -- North Loop starting in NE_C
        Rooms = {"NE_A", "NE_B", "NE_D", "NE_E", "NE_F", "NE_G"},
        RuneOfTransferSpawnPoint = {x = 460, y = 0, z = 469},
        DoorsToClose = {17093375},
        DoorsToOpen = {17093378, 17093377, 17093379, 17093376}
    }
}

tpz.nyzul_isle_data.eastFloorTableKeys = {
    "FLOOR_EAST_1",
    "FLOOR_EAST_2",
    "FLOOR_EAST_3",
    "FLOOR_EAST_4",
    "FLOOR_EAST_5",
    "FLOOR_EAST_6",
}

tpz.nyzul_isle_data.eastFloorLayouts =
{
    FLOOR_EAST_1 = { -- North side starting in EAST_F
        Rooms = {"EAST_A", "EAST_B", "EAST_C", "EAST_HALLWAY_C", "EAST_D", "EAST_E", "EAST_I", "EAST_J"},
        RuneOfTransferSpawnPoint = {x = 455.5, y = 0, z = 20},
        DoorsToClose = {17093369, 17093368, 17093366},
        DoorsToOpen = {17093367}
    },
    FLOOR_EAST_2 = { -- South side, starting at EAST_P
        Rooms = {"EAST_L", "EAST_M", "EAST_HALLWAY_M", "EAST_N", "EAST_Q", "EAST_T", "EAST_U", "EAST_V", "EAST_W"},
        RuneOfTransferSpawnPoint = {x = 379.5, y = 0, z = -140},
        DoorsToClose = {17093366, 17093365, 17093363},
        DoorsToOpen = {17093362, 17093364}
    },
    FLOOR_EAST_3 = { -- North side starting in EAST_HALLWAY_C
        Rooms = {"EAST_A", "EAST_B", "EAST_C", "EAST_D", "EAST_E", "EAST_F", "EAST_I", "EAST_J"},
        RuneOfTransferSpawnPoint = {x = 500, y = 0, z = 20},
        DoorsToClose = {17093369, 17093368, 17093366},
        DoorsToOpen = {17093367}
    },
    FLOOR_EAST_4 = { -- Center starting east of EAST_N
        Rooms = {"EAST_L", "EAST_M", "EAST_HALLWAY_M", "EAST_N", "EAST_U", "EAST_V"},
        RuneOfTransferSpawnPoint = {x = 580, y = 0, z = -100},
        DoorsToClose = {17093365, 17093366, 17093363, 17093362, 17093364},
        DoorsToOpen = {}
    },
    FLOOR_EAST_5 = { -- Center starting in EAST_HALLWAY_M
        Rooms = {"EAST_E", "EAST_F", "EAST_I", "EAST_J", "EAST_L", "EAST_M", "EAST_N", "EAST_U", "EAST_V"},
        RuneOfTransferSpawnPoint = {x = 500, y = 0, z = -140},
        DoorsToClose = {17093367, 17093368, 17093364, 17093365, 17093363, 17093362},
        DoorsToOpen = {17093366}
    },
    FLOOR_EAST_6 = { -- East side, backwards C
        Rooms = {"EAST_G", "EAST_H", "EAST_K", "EAST_O", "EAST_S", "EAST_R"},
        RuneOfTransferSpawnPoint = {x = 620, y = 0, z = -60},
        DoorsToClose = {17093369, 17093368, 17093365, 17093363},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.centralFloorTableKeys = {
    "FLOOR_CENTRAL_1",
    "FLOOR_CENTRAL_2",
    "FLOOR_CENTRAL_3",
    "FLOOR_CENTRAL_4",
    "FLOOR_CENTRAL_5",
    "FLOOR_CENTRAL_6",
}

tpz.nyzul_isle_data.centralFloorLayouts =
{
    FLOOR_CENTRAL_1 = { --North section starting east of CENTRAL_A
        Rooms = {"CENTRAL_A", "CENTRAL_B", "CENTRAL_D", "CENTRAL_E", "CENTRAL_Q", "CENTRAL_R"},
        RuneOfTransferSpawnPoint = {x = 20, y = -4, z = 180},
        DoorsToClose = {17093399, 17093398},
        DoorsToOpen = {17093401, 17093400}
    },
    FLOOR_CENTRAL_2 = { -- West, starting north of CENTRAL_G
        Rooms = {"CENTRAL_C", "CENTRAL_G", "CENTRAL_H", "CENTRAL_K", "CENTRAL_S", "CENTRAL_P"},
        RuneOfTransferSpawnPoint = {x = -100, y = 0, z = 100},
        DoorsToClose = {17093399, 17093396, 17093390, 17093391},
        DoorsToOpen = {17093397, 17093395, 17093392}
    },
    FLOOR_CENTRAL_3 = { --East starting south of CENTRAL_J
        Rooms = {"CENTRAL_D", "CENTRAL_E", "CENTRAL_F", "CENTRAL_I", "CENTRAL_J", "CENTRAL_N"},
        RuneOfTransferSpawnPoint = {x = 100, y = 0, z = 20},
        DoorsToClose = {17093400, 17093394},
        DoorsToOpen = {17093398}
    },
    FLOOR_CENTRAL_4 = { -- South/East - starts in CENTRAL_T
        Rooms = {"CENTRAL_S", "CENTRAL_P", "CENTRAL_L", "CENTRAL_M", "CENTRAL_F", "CENTRAL_I", "CENTRAL_J", "CENTRAL_N"},
        RuneOfTransferSpawnPoint = {x = 20, y = -2, z = -20.25},
        DoorsToClose = {17093392, 17093398, 17093390},
        DoorsToOpen = {17093391, 17093393, 17093394}
    },
    FLOOR_CENTRAL_5 = { -- East side reverse C, starts in CENTRAL_J
        Rooms = {"CENTRAL_D", "CENTRAL_E", "CENTRAL_F", "CENTRAL_I", "CENTRAL_L", "CENTRAL_M", "CENTRAL_N"},
        RuneOfTransferSpawnPoint = {x = 95.5, y = 0, z = 60},
        DoorsToClose = {17093400, 17093393},
        DoorsToOpen = {17093398, 17093394}
    },
    FLOOR_CENTRAL_6 = { -- North/West starting in CENTRAL_Q
        Rooms = {"CENTRAL_A", "CENTRAL_B", "CENTRAL_R", "CENTRAL_C", "CENTRAL_G", "CENTRAL_H", "CENTRAL_K"},
        RuneOfTransferSpawnPoint = {x = -60, y = -2, z = 140.25},
        DoorsToClose = {17093400, 17093392, 17093395, 17093397},
        DoorsToOpen = {17093401, 17093399, 17093396}
    }
}

tpz.nyzul_isle_data.southEastFloorTableKeys = {
    "FLOOR_SE_1",
    "FLOOR_SE_2",
    "FLOOR_SE_3",
    "FLOOR_SE_4",
    "FLOOR_SE_5",
    "FLOOR_SE_6",
}

tpz.nyzul_isle_data.southEastFloorLayouts =
{
    FLOOR_SE_1 = { -- South half starting in SE_K
        Rooms = {"SE_E_SW_HALF", "SE_I", "SE_J", "SE_G", "SE_H", "SE_L"},
        RuneOfTransferSpawnPoint = {x = 509, y = 0, z = -589},
        DoorsToClose = {17093353, 17093354, 17093357, 17093359},
        DoorsToOpen = {17093355, 17093356, 17093358}
    },
    FLOOR_SE_2 = { -- North half
        Rooms = {"SE_A", "SE_B", "SE_C", "SE_D", "SE_E_NE_HALF", "SE_F"},
        RuneOfTransferSpawnPoint = {x = 380, y = 0, z = -500},
        DoorsToClose = {17093353, 17093354, 17093357, 17093359},
        DoorsToOpen = {17093360, 17093361}
    },
    FLOOR_SE_3 = { -- Center Loop starts in SE_F
        Rooms = {"SE_B", "SE_C", "SE_D", "SE_E_SW_HALF", "SE_G", "SE_I", "SE_J", "SE_K"},
        RuneOfTransferSpawnPoint = {x = 420, y = 0, z = -540},
        DoorsToClose = {17093358, 17093361, 17093355},
        DoorsToOpen = {17093353, 17093354, 17093357, 17093356, 17093359, 17093360}
    },
    FLOOR_SE_4 = { -- Two large rooms, starts in SE_H
        Rooms = {"SE_A", "SE_B", "SE_C", "SE_D", "SE_E_NE_HALF", "SE_F", "SE_G", "SE_K"},
        RuneOfTransferSpawnPoint = {x = 560, y = 0, z = -540},
        DoorsToClose = {17093353, 17093354, 17093356, 17093357},
        DoorsToOpen = {17093360, 17093361, 17093359, 17093358}
    },
    FLOOR_SE_5 = { -- South starting in SE_L
        Rooms = {"SE_E_SW_HALF", "SE_I", "SE_J", "SE_K", "SE_G", "SE_H"},
        RuneOfTransferSpawnPoint = {x = 460, y = 0, z = -640},
        DoorsToClose = {17093353, 17093354, 17093357, 17093359},
        DoorsToOpen = {17093355, 17093356, 17093358}
    },
    FLOOR_SE_6 = { -- West section with doors closed to create a double loop
        Rooms = {"SE_B", "SE_C", "SE_D", "SE_E_SW_HALF", "SE_F", "SE_I", "SE_J"},
        RuneOfTransferSpawnPoint = {x = 380, y = 0, z = -500},
        DoorsToClose = {17093353, 17093354, 17093361, 17093359, 17093355, 17093356},
        DoorsToOpen = {17093357, 17093360}
    }
}

tpz.nyzul_isle_data.southFloorTableKeys = {
    "FLOOR_SOUTH_1",
    "FLOOR_SOUTH_2",
    "FLOOR_SOUTH_3",
    "FLOOR_SOUTH_4",
    "FLOOR_SOUTH_5",
    "FLOOR_SOUTH_6",
}

tpz.nyzul_isle_data.southFloorLayouts =
{
    FLOOR_SOUTH_1 = { -- North section
        Rooms = {"SOUTH_A", "SOUTH_B", "SOUTH_C", "SOUTH_D", "SOUTH_E", "SOUTH_H"},
        RuneOfTransferSpawnPoint = {x = 60, y = 0, z = -300},
        DoorsToClose = {17093383, 17093386, 17093387},
        DoorsToOpen = {17093388, 17093389}
    },
    FLOOR_SOUTH_2 = { -- South Section
        Rooms = {"SOUTH_G", "SOUTH_I", "SOUTH_J", "SOUTH_K", "SOUTH_L", "SOUTH_M"},
        RuneOfTransferSpawnPoint = {x = 20, y = 0, z = -420}, -- south of G
        DoorsToClose = {17093383, 17093386, 17093384, 17093382},
        DoorsToOpen = {17093380, 17093381, 17093385}
    },
    FLOOR_SOUTH_3 = { -- East Section plus north
        Rooms = {"SOUTH_C", "SOUTH_D", "SOUTH_E", "SOUTH_G", "SOUTH_H", "SOUTH_I"},
        RuneOfTransferSpawnPoint = {x = 60, y = 0, z = -460}, -- south of I
        DoorsToClose = {17093388, 17093381, 17093384},
        DoorsToOpen = {17093389, 17093383, 17093385, 17093386}
    },
    FLOOR_SOUTH_4 = { -- South Eight starting in SOUTH_G
        Rooms = {"SOUTH_E", "SOUTH_H", "SOUTH_I", "SOUTH_J", "SOUTH_K", "SOUTH_L", "SOUTH_M"},
        RuneOfTransferSpawnPoint = {x = 20, y = 0, z = -371},
        DoorsToClose = {17093382, 17093384, 17093389},
        DoorsToOpen = {17093383, 17093385, 17093386, 17093381, 17093380}
    },
    FLOOR_SOUTH_5 = { -- North Eight starting in SOUTH_G
        Rooms = {"SOUTH_A", "SOUTH_B", "SOUTH_C", "SOUTH_D", "SOUTH_E", "SOUTH_H", "SOUTH_I"},
        RuneOfTransferSpawnPoint = {x = 29, y = 0, z = -371},
        DoorsToClose = {17093381, 17093384, 17093387},
        DoorsToOpen = {17093388, 17093389, 17093383, 17093385, 17093386}
    },
    FLOOR_SOUTH_6 = { -- North East starting in SOUTH_C
        Rooms = {"SOUTH_A", "SOUTH_B", "SOUTH_D", "SOUTH_E", "SOUTH_H", "SOUTH_I"},
        RuneOfTransferSpawnPoint = {x = -20, y = 0, z = -300},
        DoorsToClose = {17093387, 17093386, 17093383, 17093385, 17093381},
        DoorsToOpen = {17093388, 17093389, 17093383}
    }
}

tpz.nyzul_isle_data.southWestFloorTableKeys = {
    "FLOOR_SW_1",
    "FLOOR_SW_2",
    "FLOOR_SW_3",
    "FLOOR_SW_4",
    "FLOOR_SW_5",
    "FLOOR_SW_6",
}

tpz.nyzul_isle_data.southWestFloorLayouts =
{
    FLOOR_SW_1 = { -- North
        Rooms = {"SW_A", "SW_B", "SW_C", "SW_ZC", "SW_E", "SW_F", "SW_G", "SW_H"},
        RuneOfTransferSpawnPoint = {x = -460, y = -2, z = -299.75},
        DoorsToClose = {17093416, 17093415, 17093413, 17093411},
        DoorsToOpen = {}
    },
    FLOOR_SW_2 = { -- West Open starting in SW_J
        Rooms = {"SW_I", "SW_L", "SW_M", "SW_N", "SW_R", "SW_S"},
        RuneOfTransferSpawnPoint = {x = -446.5, y = 0, z = -344.5},
        DoorsToClose = {17093414, 17093413, 17093404, 17093407, 17093409},
        DoorsToOpen = {17093412, 17093406}
    },
    FLOOR_SW_3 = { -- South
        Rooms = {"SW_U", "SW_V", "SW_X", "SW_Y", "SW_ZD", "SW_Z", "SW_ZA", "SW_ZB"},
        RuneOfTransferSpawnPoint = {x = -540, y = -4, z = -580},
        DoorsToClose = {17093402, 17093403, 17093407, 17093408},
        DoorsToOpen = {17093405}
    },
    FLOOR_SW_4 = { -- Central and South
        Rooms = {"SW_I", "SW_J", "SW_N", "SW_S", "SW_U", "SW_V", "SW_X", "SW_Y"},
        RuneOfTransferSpawnPoint = {x = -340, y = 0, z = -500},
        DoorsToClose = {17093414, 17093413, 17093409, 17093406, 17093403, 17093405, 17093408},
        DoorsToOpen = {17093407}
    },
    FLOOR_SW_5 = { -- West Closed starting in SW_N
        Rooms = {"SW_I", "SW_J", "SW_L", "SW_M", "SW_R", "SW_S"},
        RuneOfTransferSpawnPoint = {x = -460, y = 0, z = -380},
        DoorsToClose = {17093414, 17093413, 17093404, 17093407, 17093409, 17093406},
        DoorsToOpen = {17093412}
    },
    FLOOR_SW_6 = { -- North starting in SW_ZC
        Rooms = {"SW_A", "SW_B", "SW_C", "SW_E", "SW_F", "SW_G", "SW_H"},
        RuneOfTransferSpawnPoint = {x = -420.25, y = -2, z =-220},
        DoorsToClose = {17093416, 17093415, 17093413, 17093411},
        DoorsToOpen = {}
    }
}

tpz.nyzul_isle_data.roomConfigurations = {
    NE_A = { -- contains the connected east and west "elbow" hallways
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
        MobSpawnPoints = {{x = 584.5, y = 0, z = 375.5}, {x = 584.5, y = 0, z = 384.5}, {x = 589, y = 0, z = 393.5}, {x = 566.5, y = 0, z = 389}, {x = 580, y = 0, z = 393.5}},
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
    NE_N = { -- contains the connected north and south "elbow" hallways
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
    },
    EAST_A = {
        MobSpawnPoints = {{x = 509, y = 0, z = 100}, {x = 491, y = 0, z = 100}, {x = 491, y = 0, z = 91}, {x = 491, y = 0, z = 109}, {x = 500, y = 0, z = 91}},
        LampSpawnPoints = {{x = 500, y = 0, z = 109}, {x = 509, y = 0, z = 109}}
    },
    EAST_B = {
        MobSpawnPoints = {{x = 455.5, y = 0, z = 64.5}, {x = 455.5, y = 0, z = 55.5}, {x = 451, y = 0, z = 46.5}, {x = 473.5, y = 0, z = 51}, {x = 446.5, y = 0, z = 73.5}},
        LampSpawnPoints = {{x = 446.5, y = 0, z = 73.5}, {x = 464.5, y = 0, z = 60}}
    },
    EAST_C = {
        MobSpawnPoints = {{x = 500, y = 0, z = 60}, {x = 491, y = 0, z = 69}, {x = 509, y = 0, z = 69}, {x = 509, y = 0, z = 51}, {x = 491, y = 0, z = 51}},
        LampSpawnPoints = {{x = 500, y = 0, z = 60}, {x = 509, y = 0, z = 51}}
    },
    EAST_HALLWAY_C = {
        MobSpawnPoints = {{x = 500, y = 0, z = 20}, {x = 500, y = 0, z = 11}, {x = 500, y = 0, z = 6}, {x = 500, y = 0, z = 29}, {x = 500, y = 0, z = 33}},
        LampSpawnPoints = {{x = 500, y = 0, z = 20}, {x = 500, y = 0, z = 20}} -- yes these entries are identical
    },
    EAST_D = {
        MobSpawnPoints = {{x = 540, y = 0, z = 55.5}, {x = 544.5, y = 0, z = 73.5}, {x = 553.5, y = 0, z = 64.5}, {x = 549, y = 0, z = 46.5}, {x = 531, y = 0, z = 73.5}},
        LampSpawnPoints = {{x = 526.5, y = 0, z = 60}, {x = 540, y = 0, z = 55.5}}
    },
    EAST_E = {
        MobSpawnPoints = {{x = 375.5, y = 0, z = 20}, {x = 400, y = 0, z = 0}, {x = 400, y = 0, z = 40}, {x = 406.5, y = 0, z = 20}, {x = 393.5, y = 0, z = 20}},
        LampSpawnPoints = {{x = 393.5, y = 0, z = 20}, {x = 375.5, y = 0, z = 20}}
    },
    EAST_F = {
        MobSpawnPoints = {{x = 473.5, y = 0, z = 33.5}, {x = 468.5, y = 0, z = 24.5}, {x = 464.5, y = 0, z = 15.5}, {x = 473.5, y = 0, z = 11}, {x = 469, y = 0, z = 6.5}},
        LampSpawnPoints = {{x = 455.5, y = 0, z = 20}, {x = 446.5, y = 0, z = 33.5}}
    },
    EAST_G = {
        MobSpawnPoints = {{x = 526.5, y = 0, z = 15.5}, {x = 526.5, y = 0, z = 24.5}, {x = 540, y = 0, z = 20}, {x = 553.5, y = 0, z = 33.5}, {x = 553.5, y = 0, z = 6.5}},
        LampSpawnPoints = {{x = 531, y = 0, z = 29}, {x = 531, y = 0, z = 11}}
    },
    EAST_H = {
        MobSpawnPoints = {{x = 571, y = 0, z = 33.5}, {x = 575.5, y = 0, z = 6.5}, {x = 575.5, y = 0, z = 24.5}, {x = 584.5, y = 0, z = 24.5}, {x = 589, y = 0, z = 6.5}},
        LampSpawnPoints = {{x = 566.5, y = 0, z = 11}, {x = 566.5, y = 0, z = 29}}
    },
    EAST_I = {
        MobSpawnPoints = {{x = 500, y = 0, z = -11}, {x = 495.5, y = 0, z = -15.5}, {x = 504.5, y = 0, z = -24.5}, {x = 495.5, y = 0, z = -24.5}, {x = 504.5, y = 0, z = -15.5}},
        LampSpawnPoints = {{x = 500, y = 0, z = -20}, {x = 500, y = 0, z = -11}}
    },
    EAST_J = {
        MobSpawnPoints = {{x = 553.5, y = 0, z = -11}, {x = 553.5, y = 0, z = -33.5}, {x = 544.5, y = 0, z = -15.5}, {x = 535.5, y = 0, z = -29}, {x = 526.5, y = 0, z = -33.5}},
        LampSpawnPoints = {{x = 540, y = 0, z = -15.5}, {x = 553.5, y = 0, z = -20}}
    },
    EAST_K = {
        MobSpawnPoints = {{x = 633.5, y = 0, z = -15.5}, {x = 633.5, y = 0, z = -24.5}, {x = 611, y = 0, z = -29}, {x = 611, y = 0, z = -11}, {x = 613, y = 0, z = -20}},
        LampSpawnPoints = {{x = 606.5, y = 0, z = -20}, {x = 629, y = 0, z = -20}}
    },
    EAST_L = {
        MobSpawnPoints = {{x = 504.5, y = 0, z = -55.5}, {x = 504.5, y = 0, z = -64.5}, {x = 500, y = 0, z = -46.5}, {x = 513.5, y = 0, z = -60}, {x = 513.5, y = 0, z = -73.5}},
        LampSpawnPoints = {{x = 500, y = 0, z = -55.5}, {x = 500, y = 0, z = -64.5}}
    },
    EAST_M = {
        MobSpawnPoints = {{x = 495.5, y = 0, z = -104.5}, {x = 504.5, y = 0, z = -104.5}, {x = 500, y = 0, z = -91}, {x = 509, y = 0, z = -100}, {x = 491, y = 0, z = -100}},
        LampSpawnPoints = {{x = 500, y = 0, z = -109}, {x = 500, y = 0, z = -100}}
    },
    EAST_HALLWAY_M = {
        MobSpawnPoints = {{x = 500, y = 0, z = -144.5}, {x = 500, y = 0, z = -131}, {x = 500, y = 0, z = -135.5}, {x = 500, y = 0, z = -129}, {x = 500, y = 0, z = -151.5}},
        LampSpawnPoints = {{x = 500, y = 0, z = -140}, {x = 500, y = 0, z = -140}} -- yes these are identical
    },
    EAST_N = {
        MobSpawnPoints = {{x = 553.5, y = 0, z = -109}, {x = 544.5, y = 0, z = -113.5}, {x = 526.5, y = 0, z = -113.5}, {x = 531, y = 0, z = -86.5}, {x = 544.5, y = 0, z = -100}},
        LampSpawnPoints = {{x = 526.5, y = 0, z = -113.5}, {x = 540, y = 0, z = -104.5}}
    },
    EAST_O = {
        MobSpawnPoints = {{x = 633.5, y = 0, z = -109}, {x = 633.5, y = 0, z = -91}, {x = 620, y = 0, z = -91}, {x = 611, y = 0, z = -109}, {x = 606.5, y = 0, z = -86.5}},
        LampSpawnPoints = {{x = 611, y = 0, z = -100}, {x = 629, y = 0, z = -100}}
    },
    EAST_P = {
        MobSpawnPoints = {{x = 381.5, y = 0, z = -140}, {x = 393.5, y = 0, z = -152}, {x = 406.5, y = 0, z = -166.5}, {x = 407, y = 0, z = -129}, {x = 393.5, y = 0, z = -113.5}},
        LampSpawnPoints = {{x = 375.5, y = 0, z = -140}, {x = 400, y = 0, z = -140}}
    },
    EAST_Q = {
        MobSpawnPoints = {{x = 446.5, y = 0, z = -131}, {x = 450.5, y = 0, z = -153.5}, {x = 473, y = 0, z = -149}, {x = 464.5, y = 0, z = -144.5}, {x = 464.5, y = 0, z = -135.5}},
        LampSpawnPoints = {{x = 446.5, y = 0, z = -126.5}, {x = 455, y = 0, z = -140}}
    },
    EAST_R = {
        MobSpawnPoints = {{x = 540, y = 0, z = -140}, {x = 526.5, y = 0, z = -126.5}, {x = 526.5, y = 0, z = -153.5}, {x = 535.5, y = 0, z = -149}, {x = 549, y = 0, z = -131}},
        LampSpawnPoints = {{x = 540, y = 0, z = -140}, {x = 531, y = 0, z = -140}}
    },
    EAST_S = {
        MobSpawnPoints = {{x = 584.5, y = 0, z = -135.5}, {x = 575.5, y = 0, z = -126.5}, {x = 566.5, y = 0, z = -131}, {x = 566.5, y = 0, z = -149}, {x = 589, y = 0, z = -153.5}},
        LampSpawnPoints = {{x = 566.5, y = 0, z = -140}, {x = 580, y = 0, z = -144.5}}
    },
    EAST_T = {
        MobSpawnPoints = {{x = 473.5, y = 0, z = -184.5}, {x = 473.5, y = 0, z = -166.5}, {x = 446.5, y = 0, z = -175.5}, {x = 460, y = 0, z = -175.5}, {x = 451, y = 0, z = -184.5}},
        LampSpawnPoints = {{x = 464.5, y = 0, z = -180}, {x = 473.5, y = 0, z = -193.5}}
    },
    EAST_U = {
        MobSpawnPoints = {{x = 500, y = 0, z = -180}, {x = 509, y = 0, z = -171}, {x = 491, y = 0, z = -189}, {x = 513.5, y = 0, z = -193.5}, {x = 486.5, y = 0, z = -166.5}},
        LampSpawnPoints = {{x = 509, y = 0, z = -189}, {x = 491, y = 0, z = -171}}
    },
    EAST_V = {
        MobSpawnPoints = {{x = 544.5, y = 0, z = -193.5}, {x = 544.5, y = 0, z = -184.5}, {x = 540, y = 0, z = -175.5}, {x = 535.5, y = 0, z = -184.5}, {x = 535.5, y = 0, z = -193.5}},
        LampSpawnPoints = {{x = 526.5, y = 0, z = -193.5}, {x = 553.5, y = 0, z = -193.5}}
    },
    EAST_W = {
        MobSpawnPoints = {{x = 495.5, y = 0, z = -211}, {x = 495.5, y = 0, z = -229}, {x = 504.5, y = 0, z = -229}, {x = 504.5, y = 0, z = -211}, {x = 491, y = 0, z = -220}},
        LampSpawnPoints = {{x = 509, y = 0, z = -220}, {x = 513.5, y = 0, z = -220}}
    },
	SE_A = {
        MobSpawnPoints = {{x = 460, y = 0, z = -446.5}, {x = 460, y = 0, z = -433.5}, {x = 433.5, y = 0, z = -433.5}, {x = 486.5, y = 0, z = -433.5}, {x = 460, y = 0, z = -429}},
        LampSpawnPoints = {{x = 480, y = 0, z = -440}, {x = 460, y = 0, z = -440}, {x = 440, y = 0, z = -440}}
    },
	SE_B = {
        MobSpawnPoints = {{x = 406.5, y = 0, z = -513.5}, {x = 433.5, y = 0, z = -509}, {x = 433.5, y = 0, z = -486.5}, {x = 424.5, y = 0, z = -495.5}, {x = 415.5, y = 0, z = -495.5}},
        LampSpawnPoints = {{x = 420, y = 0, z = -504.5}, {x = 411, y = 0, z = -513.5}}
    },
	SE_C = {
        MobSpawnPoints = {{x = 473.5, y = 0, z = -486.5}, {x = 446.5, y = 0, z = -486.5}, {x = 455.5, y = 0, z = -495.5}, {x = 464.5, y = 0, z = -500}, {x = 455.5, y = 0, z = -513.5}},
        LampSpawnPoints = {{x = 451, y = 0, z = -486.5}, {x = 469, y = 0, z = -486.5}}
    },
	SE_D = {
        MobSpawnPoints = {{x = 509, y = 0, z = -500}, {x = 491, y = 0, z = -500}, {x = 491, y = 0, z = -509}, {x = 486.5, y = 0, z = -513.5}, {x = 500, y = 0, z = -486.5}},
        LampSpawnPoints = {{x = 491, y = 0, z = -500}, {x = 500, y = 0, z = -509}}
    },
	SE_E_NE_HALF = { -- hideable walls - the only two I've found in Nyzul Isle - can split Room E in half diagonally
        MobSpawnPoints = {{x = 366.5, y = 0, z = -526.5}, {x = 393.5, y = 0, z = -553.5}, {x = 393.5, y = 0, z = -526.5}, {x = 380, y = 0, z = -526.5}, {x = 393.5, y = 0, z = -540}},
        LampSpawnPoints = {{x = 366.5, y = 0, z = -526.5}, {x = 393.5, y = 0, z = -553.5}}
    },
	SE_E_SW_HALF = { -- hideable walls - the only two I've found in Nyzul Isle - can split Room E in half diagonally
        MobSpawnPoints = {{x = 366.5, y = 0, z = -535.5}, {x = 375.5, y = 0, z = -535.5}, {x = 384.5, y = 0, z = -540}, {x = 375.5, y = 0, z = -544.5}, {x = 366.5, y = 0, z = -549}},
        LampSpawnPoints = {{x = 366.5, y = 0, z = -535.5}, {x = 366.5, y = 0, z = -535.5}}
    },
	SE_F = {
        MobSpawnPoints = {{x = 433.5, y = 0, z = -553.5}, {x = 415.5, y = 0, z = -535.5}, {x = 429, y = 0, z = -531}, {x = 411, y = 0, z = -549}, {x = 420, y = 0, z = -540}},
        LampSpawnPoints = {{x = 420, y = 0, z = -540}, {x = 429, y = 0, z = -549}}
    },
	SE_G = {
        MobSpawnPoints = {{x = 500, y = 0, z = -540}, {x = 509, y = 0, z = -531}, {x = 491, y = 0, z = -549}, {x = 491, y = 0, z = -531}, {x = 509, y = 0, z = -549}},
        LampSpawnPoints = {{x = 491, y = 0, z = -540}, {x = 509, y = 0, z = -540}}
    },
	SE_H = {
        MobSpawnPoints = {{x = 553, y = 0, z = -560}, {x = 560, y = 0, z = -552.5}, {x = 560, y = 0, z = -527.5}, {x = 553.5, y = 0, z = -513.5}, {x = 553.5, y = 0, z = -540}},
        LampSpawnPoints = {{x = 560, y = 0, z = -540}, {x = 560, y = 0, z = -520}, {x = 560, y = 0, z = -560}}
    },
	SE_I = {
        MobSpawnPoints = {{x = 424.5, y = 0, z = -575.5}, {x = 415.5, y = 0, z = -580}, {x = 411, y = 0, z = -593.5}, {x = 406.5, y = 0, z = -566.5}, {x = 429, y = 0, z = -566.5}},
        LampSpawnPoints = {{x = 424.5, y = 0, z = -580}, {x = 420, y = 0, z = -575.5}}
    },
	SE_J = {
        MobSpawnPoints = {{x = 464.5, y = 0, z = -566.5}, {x = 464.5, y = 0, z = -580}, {x = 455.5, y = 0, z = -584.5}, {x = 455.5, y = 0, z = -566.5}, {x = 446.5, y = 0, z = -571}},
        LampSpawnPoints = {{x = 446.5, y = 0, z = -566.5}, {x = 473.5, y = 0, z = -566.5}}
    },
	SE_K = {
        MobSpawnPoints = {{x = 513.5, y = 0, z = -593.5}, {x = 505.5, y = 0, z = -585.5}, {x = 491, y = 0, z = -571}, {x = 486.5, y = 0, z = -566.5}, {x = 486.5, y = 0, z = -593.5}},
        LampSpawnPoints = {{x = 509, y = 0, z = -589}, {x = 491, y = 0, z = -580}}
    },
	SE_L = {
        MobSpawnPoints = {{x = 460, y = 0, z = -640}, {x = 486.5, y = 0, z = -646.5}, {x = 433.5, y = 0, z = -646.5}, {x = 486.5, y = 0, z = -633.5}, {x = 433.5, y = 0, z = -633.5}},
        LampSpawnPoints = {{x = 460, y = 0, z = -646.5}, {x = 460, y = 0, z = -633.5}}
    },
    -- consider creating "rooms" for the "elbow" hallways.  Would allow for some very high density small floors
	SOUTH_A = {
        MobSpawnPoints = {{x = -20, y = 0, z = -260}, {x = -29, y = 0, z = -260}, {x = -20, y = 0, z = -251}, {x = -11, y = 0, z = -260}, {x = -20, y = 0, z = -269}},
        LampSpawnPoints = {{x = -20, y = 0, z = -260}, {x = -20, y = 0, z = -269}}
    },
	SOUTH_B = {
        MobSpawnPoints = {{x = -51, y = 0, z = -286.5}, {x = -46.5, y = 0, z = -309}, {x = -55.5, y = 0, z = -304.5}, {x = -64.5, y = 0, z = -295.5}, {x = -69, y = 0, z = -286.5}},
        LampSpawnPoints = {{x = -46.5, y = 0, z = -300}, {x = -55.5, y = 0, z = -300}}
    },
	SOUTH_C = {
        MobSpawnPoints = {{x = -20, y = 0, z = -300}, {x = -11, y = 0, z = -300}, {x = -29, y = 0, z = -300}, {x = -11, y = 0, z = -291}, {x = -29, y = 0, z = -309}},
        LampSpawnPoints = {{x = -20, y = 0, z = -309}, {x = -20, y = 0, z = -291}}
    },
	SOUTH_D = {
        MobSpawnPoints = {{x = 29, y = 0, z = -286.5}, {x = 33.5, y = 0, z = -309}, {x = 24.5, y = 0, z = -300}, {x = 15.5, y = 0, z = -304.5}, {x = 6.5, y = 0, z = -309}},
        LampSpawnPoints = {{x = 6.5, y = 0, z = -286.5}, {x = 15, y = 0, z = -286.5}}
    },
	SOUTH_E = {
        MobSpawnPoints = {{x = 60, y = 0, z = -335.5}, {x = 69, y = 0, z = -326.5}, {x = 46, y = 0, z = -331}, {x = 55.5, y = 0, z = -353.5}, {x = 64.5, y = 0, z = -349}},
        LampSpawnPoints = {{x = 64.5, y = 0, z = -340}, {x = 55.5, y = 0, z = -340}}
    },
    -- SOUTH_F is not in this list - it is BOSS_ROOM_1.  I have never seen a capture where the boss rooms are used for anything but boss floors - so ommitting non-boss configurations
	SOUTH_G = {
        MobSpawnPoints = {{x = 29, y = 0, z = -371}, {x = 20, y = 0, z = -371}, {x = 11, y = 0, z = -380}, {x = 20, y = 0, z = -389}, {x = 29, y = 0, z = -389}},
        LampSpawnPoints = {{x = 29, y = 0, z = -380}, {x = 33.5, y = 0, z = -380}}
    },
	SOUTH_H = {
        MobSpawnPoints = {{x = 100, y = 0, z = -380}, {x = 104.5, y = 0, z = -375.5}, {x = 104.5, y = 0, z = -384.5}, {x = 94.5, y = 0, z = -375.5}, {x = 94.5, y = 0, z = -384.5}},
        LampSpawnPoints = {{x = 91, y = 0, z = -380}, {x = 109, y = 0, z = -380}}
    },
	SOUTH_I = {
        MobSpawnPoints = {{x = 46.5, y = 0, z = -406.5}, {x = 51, y = 0, z = -433.5}, {x = 73.5, y = 0, z = -429}, {x = 64.5, y = 0, z = -411}, {x = 55.5, y = 0, z = -420.5}},
        LampSpawnPoints = {{x = 73.5, y = 0, z = -420}, {x = 60, y = 0, z = -424.5}}
    },
	SOUTH_J = {
        MobSpawnPoints = {{x = -46.5, y = 0, z = -446.5}, {x = -69, y = 0, z = -446.5}, {x = -60, y = 0, z = -455.5}, {x = -55.5, y = 0, z = -460}, {x = -73.5, y = 0, z = -469}},
        LampSpawnPoints = {{x = -55.5, y = 0, z = -473.5}, {x = -46.5, y = 0, z = -473.5}}
    },
	SOUTH_K = {
        MobSpawnPoints = {{x = -33.5, y = 0, z = -473.5}, {x = -6.5, y = 0, z = -446.5}, {x = -24.5, y = 0, z = -455.5}, {x = -15.5, y = 0, z = -464.5}, {x = -11, y = 0, z = -460}},
        LampSpawnPoints = {{x = -11, y = 0, z = -451}, {x = -29, y = 0, z = -469}}
    },
	SOUTH_L = {
        MobSpawnPoints = {{x = 33.5, y = 0, z = -473.5}, {x = 33.5, y = 0, z = -451}, {x = 24.5, y = 0, z = -460}, {x = 15.5, y = 0, z = -451}, {x = 6.5, y = 0, z = -469}},
        LampSpawnPoints = {{x = 6.5, y = 0, z = -473.5}, {x = 15.5, y = 0, z = -473.5}}
    },
	SOUTH_M = {
        MobSpawnPoints = {{x = -29, y = 0, z = -504.5}, {x = -29, y = 0, z = -495.5}, {x = -20, y = 0, z = -509}, {x = -20, y = 0, z = -491}, {x = -11, y = 0, z = -500}},
        LampSpawnPoints = {{x = -20, y = 0, z = -500}, {x = -29, y = 0, z = -500}}
    },
    -- The corner long hallways ("Rooms" Q, R, S, and T) are each their own room.  They are too big to leave blank.
	CENTRAL_A = {
        MobSpawnPoints = {{x = -33.5, y = -4, z = 166.5}, {x = -6.5, y = -4, z = 171}, {x = -15.5, y = -4, z = 189}, {x = -24.5, y = -4, z = 175.5}, {x = -24.5, y = -4, z = 193.5}},
        LampSpawnPoints = {{x = -20, y = -4, z = 175.5}, {x = -20, y = -4, z = 166.5}}
    },
    CENTRAL_B = {
        MobSpawnPoints = {{x = -20, y = -4, z = 149}, {x = -29, y = -4, z = 140}, {x = -11, y = -4, z = 140}, {x = -29, y = -4, z = 131}, {x = -11, y = -4, z = 131}},
        LampSpawnPoints = {{x = -20, y = -4, z = 140}, {x = -20, y = -4, z = 131}}
    },
    CENTRAL_C = {
        MobSpawnPoints = {{x = -69, y = 0, z = 91}, {x = -51, y = 0, z = 91}, {x = -73.5, y = 0, z = 100}, {x = -46.5, y = 0, z = 86.5}, {x = -46.5, y = 0, z = 113.5}},
        LampSpawnPoints = {{x = -51, y = 0, z = 109}, {x = -51, y = 0, z = 91}}
    },
    CENTRAL_D = {
        MobSpawnPoints = {{x = -29, y = 0, z = 100}, {x = -20, y = 0, z = 104.5}, {x = -20, y = 0, z = 95.5}, {x = -6.5, y = 0, z = 109}, {x = -11, y = 0, z = 91}},
        LampSpawnPoints = {{x = -29, y = 0, z = 109}, {x = -29, y = 0, z = 91}}
    },
    CENTRAL_E = {
        MobSpawnPoints = {{x = 20, y = 0, z = 104.5}, {x = 33.5, y = 0, z = 113.5}, {x = 6.5, y = 0, z = 91}, {x = 15.5, y = 0, z = 100}, {x = 24.5, y = 0, z = 86.5}},
        LampSpawnPoints = {{x = 20, y = 0, z = 104.5}, {x = 29, y = 0, z = 113.5}}
    },
    CENTRAL_F = {
        MobSpawnPoints = {{x = 64.5, y = 0, z = 113.5}, {x = 64.5, y = 0, z = 106.5}, {x = 51, y = 0, z = 91}, {x = 73.5, y = 0, z = 86.5}, {x = 66.5, y = 0, z = 95.5}},
        LampSpawnPoints = {{x = 69, y = 0, z = 109}, {x = 60, y = 0, z = 109}}
    },
    CENTRAL_G = {
        MobSpawnPoints = {{x = -113.5, y = 0, z = 55.5}, {x = -95.5, y = 0, z = 60}, {x = -109, y = 0, z = 64.5}, {x = -91, y = 0, z = 73.5}, {x = -86.5, y = 0, z = 46.5}},
        LampSpawnPoints = {{x = -113.5, y = 0, z = 73.5}, {x = -113.5, y = 0, z = 46.5}}
    },
    CENTRAL_H = {
        MobSpawnPoints = {{x = -60, y = 0, z = 64.5}, {x = -55.5, y = 0, z = 55.5}, {x = -69, y = 0, z = 46.5}, {x = -73.5, y = 0, z = 69}, {x = -46.5, y = 0, z = 73.5}},
        LampSpawnPoints = {{x = -64.5, y = 0, z = 60}, {x = -73.5, y = 0, z = 60}}
    },
    CENTRAL_I = {
        MobSpawnPoints = {{x = 73.5, y = 0, z = 60}, {x = 64.5, y = 0, z = 60}, {x = 55.5, y = 0, z = 64.5}, {x = 51, y = 0, z = 55.5}, {x = 46.5, y = 0, z = 69}},
        LampSpawnPoints = {{x = 73.5, y = 0, z = 73.5}, {x = 73.5, y = 0, z = 46.5}}
    },
    CENTRAL_J = {
        MobSpawnPoints = {{x = 104.5, y = 0, z = 64.5}, {x = 100, y = 0, z = 55.5}, {x = 113.5, y = 0, z = 51}, {x = 86.5, y = 0, z = 46.5}, {x = 91, y = 0, z = 73.5}},
        LampSpawnPoints = {{x = 95.5, y = 0, z = 60}, {x = 113.5, y = 0, z = 73.5}}
    },
    CENTRAL_K = {
        MobSpawnPoints = {{x = -73.5, y = 0, z = 33.5}, {x = -69, y = 0, z = 11}, {x = -55.5, y = 0, z = 15.5}, {x = -51, y = 0, z = 29}, {x = -64.5, y = 0, z = 26.5}},
        LampSpawnPoints = {{x = -69, y = 0, z = 20}, {x = -51, y = 0, z = 20}}
    },
    CENTRAL_L = {
        MobSpawnPoints = {{x = -33.5, y = 0, z = 6.5}, {x = -29, y = 0, z = 24.5}, {x = -15.5, y = 0, z = 10.5}, {x = -11, y = 0, z = 29}, {x = -24.5, y = 0, z = 15.5}},
        LampSpawnPoints = {{x = -20, y = 0, z = 20}, {x = -29, y = 0, z = 11}}
    },
    CENTRAL_M = {
        MobSpawnPoints = {{x = 15.5, y = 0, z = 15.5}, {x = 24.5, y = 0, z = 20}, {x = 29, y = 0, z = 33.5}, {x = 29, y = 0, z = 6.5}, {x = 6.5, y = 0, z = 6.5}},
        LampSpawnPoints = {{x = 20, y = 0, z = 15.5}, {x = 15.5, y = 0, z = 20}}
    },
    CENTRAL_N = {
        MobSpawnPoints = {{x = 69, y = 0, z = 15.5}, {x = 69, y = 0, z = 29}, {x = 46.5, y = 0, z = 33.5}, {x = 51, y = 0, z = 11}, {x = 69, y = 0, z = 6.5}},
        LampSpawnPoints = {{x = 60, y = 0, z = 11}, {x = 60, y = 0, z = 29}}
    },
    -- CENTRAL_O ommitted - this is the entrance lobby.
    CENTRAL_P = {
        MobSpawnPoints = {{x = -15.5, y = -4, z = -60}, {x = -24.5, y = -4, z = -55.5}, {x = -24.5, y = -4, z = -73.5}, {x = -33.5, y = -4, z = -69}, {x = -33.5, y = -4, z = -46.5}},
        LampSpawnPoints = {{x = -6.5, y = -4, z = -60}, {x = -20, y = -4, z = -55.5}}
    },
    CENTRAL_Q = {
        MobSpawnPoints = {{x = -60, y = -4, z = 151.5}, {x = -60, y = 0, z = 128}, {x = -63, y = -1, z = 136}, {x = -57, y = -2, z = 139.5}, {x = -63, y = -3.5, z = 144}},
        LampSpawnPoints = {{x = -60, y = 0, z = 126.5}, {x = -60, y = -2, z = 140}}
    },
    CENTRAL_R = {
        MobSpawnPoints = {{x = 20, y = -4, z = 153.5}, {x = 20, y = 0, z = 128.5}, {x = 17, y = -2, z = 140}, {x = 23, y = -3.5, z = 144}, {x = 23, y = -1, z = 136}},
        LampSpawnPoints = {{x = 20, y = 0, z = 126.5}, {x = 20, y = -2, z = 140}}
    },
    CENTRAL_S = {
        MobSpawnPoints = {{x = -60, y = -4, z = -31.5}, {x = -60, y = 0, z = -8.5}, {x = -63, y = -1, z = -17}, {x = -63, y = -3.5, z = -24}, {x = -57, y = -2, z = -20}},
        LampSpawnPoints = {{x = -60, y = 0, z = -6.5}, {x = -60, y = -2, z = -20}}
    },
    CENTRAL_T = {
        MobSpawnPoints = {{x = 20, y = -4, z = -31.5}, {x = 20, y = 0, z = -8.5}, {x = 23, y = -1, z = -17}, {x = 23, y = -3.5, z = -24}, {x = 17, y = -2, z = -20}},
        LampSpawnPoints = {{x = 20, y = 0, z = -6.5}, {x = 20, y = -2, z = -20}}
    },
	SW_A = {
        MobSpawnPoints = {{x = -495.5, y = -4, z = -184.5}, {x = -504.5, y = -4, z = -175.5}, {x = -509, y = -4, z = -189}, {x = -491, y = -4, z = -171}, {x = -500, y = -4, z = -180}},
        LampSpawnPoints = {{x = -509, y = -4, z = -171}, {x = -491, y = -4, z = -189}}
    },
	SW_B = {
        MobSpawnPoints = {{x = -455.5, y = -4, z = -175.5}, {x = -464.5, y = -4, z = -180}, {x = -460, y = -4, z = -189}, {x = -455.5, y = -4, z = -184.5}, {x = -446.5, y = -4, z = -166.5}},
        LampSpawnPoints = {{x = -460, y = -4, z = -180}, {x = -460, y = -4, z = -171}}
    },
	SW_C = {
        MobSpawnPoints = {{x = -415.5, y = -4, z = -184.5}, {x = -406.5, y = -4, z = -175.5}, {x = -420, y = -4, z = -166.5}, {x = -420, y = -4, z = -189}, {x = -424.5, y = -4, z = -180}},
        LampSpawnPoints = {{x = -411, y = -4, z = -180}, {x = -420, y = -4, z = -180}}
    },
	-- SW_D omitted - Boss Room
	SW_E = { -- includes the hallway to the east
        MobSpawnPoints = {{x = -473.5, y = -4, z = -260}, {x = -464.5, y = -4, z = -260}, {x = -451, y = -4, z = -246.5}, {x = -446.5, y = -4, z = -273.5}, {x = -429, y = -4, z = -260}, {x = -411, y = 0, z = -260}},
        LampSpawnPoints = {{x = -420.25, y = -2, z = -260}, {x = -460, y = -4, z = -264.5}}
    },
	SW_F = {
        MobSpawnPoints = {{x = -375.5, y = 0, z = -264.5}, {x = -366.5, y = 0, z = -251}, {x = -389, y = 0, z = -260}, {x = -393.5, y = 0, z = -251}, {x = -393.5, y = 0, z = -273.5}},
        LampSpawnPoints = {{x = -380, y = 0, z = -260}, {x = -371, y = 0, z = -260}}
    },
	SW_G = {
        MobSpawnPoints = {{x = -389, y = 0, z = -286.5}, {x = -380, y = 0, z = -295.5}, {x = -393.5, y = 0, z = -313.5}, {x = -371, y = 0, z = -313.5}, {x = -366.5, y = 0, z = -291}},
        LampSpawnPoints = {{x = -393.5, y = 0, z = -304.5}, {x = -393.5, y = 0, z = -295.5}}
    },
	SW_H = {
        MobSpawnPoints = {{x = -344.5, y = 0, z = -309}, {x = -331, y = 0, z = -295.5}, {x = -349, y = 0, z = -291}, {x = -340, y = 0, z = -300}, {x = -353.5, y = 0, z = -286.5}},
        LampSpawnPoints = {{x = -331, y = 0, z = -309}, {x = -340, y = 0, z = -300}}
    },
	SW_I = { -- includes the hallway to the east
        MobSpawnPoints = {{x = -553.5, y = -4, z = -340}, {x = -544.5, y = -4, z = -331}, {x = -544.5, y = -4, z = -344.5}, {x = -535.5, y = -4, z = -349}, {x = -535.5, y = -4, z = -335.5}, {x = -500.25, y = -2, z = -340}},
        LampSpawnPoints = {{x = -549, y = -4, z = -340}, {x = -500.25, y = -2, z = -340}}
    },
	SW_J = {
        MobSpawnPoints = {{x = -460, y = 0, z = -344.5}, {x = -451, y = 0, z = -353.5}, {x = -473.5, y = 0, z = -353.5}, {x = -469, y = 0, z = -326.5}, {x = -446.5, y = 0, z = -331}},
        LampSpawnPoints = {{x = -446.5, y = 0, z = -344.5}, {x = -464.5, y = 0, z = -340}}
    },
	SW_K = {
        MobSpawnPoints = {{x = -313.5, y = 0, z = -326.5}, {x = -286.5, y = 0, z = -353.5}, {x = -309, y = 0, z = -340}, {x = -300, y = 0, z = -331}, {x = -286.5, y = 0, z = -326.5}},
        LampSpawnPoints = {{x = -309, y = 0, z = -331}, {x = -291, y = 0, z = -349}}
    },
	SW_L = {
        MobSpawnPoints = {{x = -544.5, y = -4, z = -366.5}, {x = -526.5, y = -4, z = -371}, {x = -549, y = -4, z = -393.5}, {x = -544.5, y = -4, z = -384.5}, {x = -540, y = -4, z = -375.5}},
        LampSpawnPoints = {{x = -553.5, y = -4, z = -366.5}, {x = -535.5, y = -4, z = -380}}
    },
	SW_M = {
        MobSpawnPoints = {{x = -495.5, y = -4, z = -384.5}, {x = -486.5, y = -4, z = -375.5}, {x = -504.5, y = -4, z = -375.5}, {x = -509, y = -4, z = -389}, {x = -500, y = -4, z = -380}},
        LampSpawnPoints = {{x = -491, y = -4, z = -380}, {x = -500, y = -4, z = -380}}
    },
	SW_N = {
        MobSpawnPoints = {{x = -446.5, y = 0, z = -366.5}, {x = -460, y = 0, z = -380}, {x = -473.5, y = 0, z = -393.5}, {x = -464.5, y = 0, z = -371}, {x = -473.5, y = 0, z = -366.5}},
        LampSpawnPoints = {{x = -469, y = 0, z = -380}, {x = -451, y = 0, z = -371}}
    },
	-- SW_O omitted - Boss Room
	SW_P = {
        MobSpawnPoints = {{x = -304.5, y = 0, z = -380}, {x = -291, y = 0, z = -384.5}, {x = -286.5, y = 0, z = -375.5}, {x = -313.5, y = 0, z = -366.5}, {x = -309, y = 0, z = -393.5}},
        LampSpawnPoints = {{x = -300, y = 0, z = -384.5}, {x = -300, y = 0, z = -375.5}}
    },
	SW_Q = {
        MobSpawnPoints = {{x = -260, y = 0, z = -340}, {x = -260, y = 0, z = -420}, {x = -255.5, y = 0, z = -375.5}, {x = -260, y = 0, z = -380}, {x = -264.5, y = 0, z = -384.5}},
        LampSpawnPoints = {{x = -251, y = 0, z = -380}, {x = -269, y = 0, z = -380}}
    },
	SW_R = { -- includes hallway to the east
        MobSpawnPoints = {{x = -535.5, y = -4, z = -415.5}, {x = -544.5, y = -4, z = -424.5}, {x = -509, y = -4, z = -420}, {x = -500.25, y = -2, z = -423}, {x = -486.5, y = 0, z = -420}},
        LampSpawnPoints = {{x = -540, y = -4, z = -420}, {x = -500.25, y = -2, z = -420}}
    },
	SW_S = {
        MobSpawnPoints = {{x = -455.5, y = 0, z = -424.5}, {x = -446.5, y = 0, z = -433.5}, {x = -473.5, y = 0, z = -429}, {x = -469, y = 0, z = -406.5}, {x = -446.5, y = 0, z = -415.5}},
        LampSpawnPoints = {{x = -473.5, y = 0, z = -420}, {x = -464.5, y = 0, z = -420}}
    },
	SW_T = {
        MobSpawnPoints = {{x = -291, y = 0, z = -433.5}, {x = -313.5, y = 0, z = -433.5}, {x = -309, y = 0, z = -429}, {x = -313.5, y = 0, z = -411}, {x = -309, y = 0, z = -411}},
        LampSpawnPoints = {{x = -300, y = 0, z = -429}, {x = -309, y = 0, z = -420}}
    },
	SW_U = {
        MobSpawnPoints = {{x = -380, y = 0, z = -455.5}, {x = -380, y = 0, z = -464.5}, {x = -389, y = 0, z = -473.5}, {x = -389, y = 0, z = -446.5}, {x = -366.5, y = 0, z = -473.5}},
        LampSpawnPoints = {{x = -389, y = 0, z = -455.5}, {x = -389, y = 0, z = -464.5}}
    },
	SW_V = {
        MobSpawnPoints = {{x = -344.5, y = 0, z = -451}, {x = -331, y = 0, z = -464.5}, {x = -349, y = 0, z = -469}, {x = -326.5, y = 0, z = -446.5}, {x = -335.5, y = 0, z = -455.5}},
        LampSpawnPoints = {{x = -331, y = 0, z = -451}, {x = -340, y = 0, z = -460}}
    },
	-- SW_W omitted - Boss Room
	SW_X = { -- includes hallway to the east
        MobSpawnPoints = {{x = -406.5, y = 0, z = -500}, {x = -433.5, y = -4, z = -500}, {x = -464.5, y = -4, z = -513.5}, {x = -455.5, y = -4, z = -504.5}, {x = -451, y = -4, z = -486.5}},
        LampSpawnPoints = {{x = -420.25, y = -2, z = -500}, {x = -460, y = -4, z = -495.5}}
    },
	SW_Y = {
        MobSpawnPoints = {{x = -371, y = 0, z = -513.5}, {x = -394.5, y = 0, z = -513.5}, {x = -389, y = 0, z = -500}, {x = -375.5, y = 0, z = -495.5}, {x = -366.5, y = 0, z = -486.5}},
        LampSpawnPoints = {{x = -380, y = 0, z = -509}, {x = -380, y = 0, z = -513.5}}
    },
	SW_Z = {
        MobSpawnPoints = {{x = -496.5, y = -4, z = -584.5}, {x = -486.5, y = -4, z = -593.5}, {x = -509, y = -4, z = -589}, {x = -504.5, y = -4, z = -571}, {x = -495.5, y = -4, z = -575.5}},
        LampSpawnPoints = {{x = -500, y = -4, z = -580}, {x = -491, y = -4, z = -589}}
    },
	SW_ZA = {
        MobSpawnPoints = {{x = -451, y = -4, z = -593.5}, {x = -469, y = -4, z = -584.5}, {x = -455.5, y = -4, z = -584.5}, {x = -455.5, y = -4, z = -571}, {x = -473.5, y = -4, z = -566.5}},
        LampSpawnPoints = {{x = -460, y = -4, z = -580}, {x = -460, y = -4, z = -593.5}}
    },
	SW_ZB = {
        MobSpawnPoints = {{x = -415.5, y = -4, z = -580}, {x = -424.5, y = -4, z = -590}, {x = -430, y = -4, z = -571}, {x = -406.5, y = -4, z = -566.5}, {x = -433.5, y = -4, z = -593.5}},
        LampSpawnPoints = {{x = -411, y = -4, z = -580}, {x = -406.5, y = -4, z = -580}}
    },
	SW_ZC = {
        MobSpawnPoints = {{x = -431.5, y = -4, z = -220}, {x = -408.5, y = 0, z = -220}, {x = -420, y = -2, z = -223}, {x = -417, y = -1, z = -217}, {x = -423, y = -3, z = -217}},
        LampSpawnPoints = {{x = -406.5, y = 0, z = -220}, {x = -420.25, y = -2, z =-220}}
    },
	SW_ZD = {
        MobSpawnPoints = {{x = -408.5, y = 0, z = -540}, {x = -431.5, y = -4, z = -540}, {x = -420, y = -2, z = -537}, {x = -417, y = -1, z = -543}, {x = -423, y = -3, z = -543}},
        LampSpawnPoints = {{x = -406.5, y = 0, z = -540}, {x = -420.25, y = -2, z = -540}}
    }
}




