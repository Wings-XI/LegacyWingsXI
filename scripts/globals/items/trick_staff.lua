-----------------------------------------
--  ID: 17565
--  Trick staff
--  Wings custom
--  Author: Twilight
-- (C) 2022, The Wings Project
--  Chance to transport to a random previously visited zone
-----------------------------------------

require("scripts/globals/settings")
require("scripts/globals/events/harvest_festivals")

function onAdditionalEffect(player, target, damage)
    local totd = VanadielTOTD()
    local teleport = math.random() < 0.15
    -- local teleport = true
    
    local destinations = {
        { 204.793, -5.289, -522.447, 127, 2 }, -- Carpenters_Landing - Next to barge dock, south
        { 490.507, -3.01, 721.811, 71, 4 }, -- Bibiki_Bay - Next to manaclipper dock
        { -328.837, -3.159, -958.698, 168, 4 }, -- Purgonorgo Isle, next to ??? Warmachine
        { -329.492, -175.231, -57.235, 11, 5 }, -- Uleguerand_Range - Top of the cliff, where you slide
        { -218.156, -175.746, 101.108, 32, 5 }, -- Uleguerand_Range - next to Jormungand
        { -709.391, 5.185, -449.249, 167, 6 },  -- Bearclaw_Pinnacle - Outside battlefield
        { -547.784, -7.819, -21.885, 255, 7 }, -- Attohwa_Chasm - West section
        { -321.076, -25.708, -10.550, 70, 7 }, -- Attohwa_Chasm - On top of the mountain (the one with the nasty climb)
        { -613.921, -1.753, 499.974, 187, 8 }, -- Boneyard_Gully - Outside battlefield
        { -8.877, 0.247, -51.948, 16, 9 }, -- Pso'Xja - Middle tower, cap 40 area
        { -312.753, 32.000, 354.962, 80, 9 }, -- Pso'Xja - NW tower, uncapped area
        { -332.401, 15.974, -238.369, 50, 9 }, -- Pso'Xja - West tower, uncapped area
        { -303.465, 16.242, 330.310, 4, 9 }, -- Pso'Xja - Middle east tower, uncapped area
        { 154.676, 11.009, -342.373, 210, 9 }, -- Pso'Xja - South tower, cap 60 area
        { 287.122, 0.247, -89.369, 183, 9 }, -- Pso'Xja - East tower, cap 50 area
        { -299.782, 0.000, -246.476, 66, 10 }, -- The_Shrouded_Maw - Outside battlefield
        { -259.565, 7.943, -45.225, 80, 11 }, -- Oldton_Movalpolos - Next to regional vendor
        { -290.789, 8.000, -260.305, 103, 11 }, -- Oldton_Movalpolos - Next to warp gobbie npc
        { -91.144, 20.000, -87.288, 202, 11 }, -- Oldton_Movalpolos - Middle of the map, lots of gobs
        { -179.364, 16.000, 129.480, 247, 12 }, -- Newton_Movalpolos - West, lots of gobs
        { -71.497, -120.000, -580.913, 254, 13 }, -- Mine_Shaft_2716 - Outside battlefied
        { 6.626, 0.000, 161.077, 144, 16 }, -- Promyvion-Holla - First floor
        { 257.378, 0.000, -186.233, 87, 16 }, -- Promyvion-Holla - Fourth floor
        { -0.132, -2.000, -250.551, 190, 17 }, -- Spire_of_Holla - Outside battlefield
        { 147.929, 0.000, -247.428, 30, 18 }, -- Promyvion-Dem - First floor
        { 171.443, 0.000, 279.999, 220, 18 }, -- Promyvion-Dem - Fourth floor
        { -0.160, -2.000, 250.192, 61, 19 }, -- Spire_of_Dem - Outside battlefield
        { -163.264, 0.000, 281.651, 113, 20 }, -- Promyvion-Mea - First floor
        { 243.594, 0.000, 128.377, 78, 20 }, -- Promyvion-Mea - Fourth floor
        { -0.187, -2.000, 252.316, 63, 21 }, -- Spire_of_Mea - Outside battlefield
        { 96.253, -0.322, -278.701, 121, 22 }, -- Promyvion-Vahzl - First floor
        { -282.381, 0.000, 117.472, 221, 22 }, -- Promyvion-Vahzl - Fifth floor
        { -0.020, -2.000, 250.075, 64, 23 }, -- Spire_of_Vahzl - Outside battlefield
        { -539.526, -6.080, -58.070, 162, 24 }, -- Lufaise_Meadows - Next to outpost
        { -40.764, -8.372, -287.438, 27, 24 }, -- Lufaise_Meadows - South
        { -257.386, -30.117, 275.203, 169, 25 }, -- Misareaux_Coast - Next to dilapitated gate
        { 0.823, -21.934, 3.786, 64, 26 }, -- Tavnazian_Safehold - On main bridge
        { 180.316, 0.986, -215.556, 190, 27 }, -- Phomiuna_Aqueducts - Ditch near entrance
        { 59.511, 1.020, 18.890, 190, 27 }, -- Phomiuna_Aqueducts - Next to minotaur
        { 20.370, -2.000, -122.685, 70, 28 }, -- Sacrarium - Classrom, next to a lot of Fomors
        { -50.021, 0.167, -429.002, 166, 29 }, -- Riverne-Site_B01 - Next to unstable displacement
        { 598.385, 0.135, -728.607, 117, 29 }, -- Riverne-Site_B01 - Next to roc, wyvern and hippogryph
        { -10.382, 4.109, 309.133, 105, 30 }, -- Riverne-Site_A01 - Next to unstable displacement
        { -71.172, 1.086, 699.834, 111, 30 }, -- Riverne-Site_A01 - Next to wyverns and bombs
        { -21.814, -1.381, -540.461, 127, 31 }, -- Monarch_Linn - Outside battlefield
        { 611.816, 132.715, 775.183, 61, 32 }, -- Sealions_Den - Outside battlefield
        { 0.354, -3.106, -719.594, 207, 33 }, -- AlTaieu - Near entrance to palace
        { -504.773, 0.000, -251.417, 187, 33 }, -- AlTaieu - Below UFO
        { -498.492, -3.000, 415.813, 156, 34 }, -- Grand_Palace_of_HuXzoi - Large room, northwest
        { -420.461, 0.000, -485.924, 64, 35 }, -- The_Garden_of_RuHmet - South
        { 539.897, 0.000, -586.010, 64, 36 }, -- Empyreal_Paradox - Outside battlefield
        { 36.996, 0.000, -59.897, 54, 48 }, -- Al_Zahbi - Next to mog house
        { -103.721, 2.000, 64.133, 156, 48 }, -- Al_Zahbi - Next to exit to Wajaom
        { -94.704, 0.000, -79.746, 103, 50 }, -- Aht_Urhgan_Whitegate - Next to mog house
        { 9.047, 2.000, -98.871, 182, 50 }, -- Aht_Urhgan_Whitegate - Next to south docks
        { 458.543, -23.637, 235.557, 108, 51 }, -- Wajaom_Woodlands - Colibri camp near Al Zahbi
        { -208.160, -8.708, 84.846, 19, 51 }, -- Wajaom_Woodlands - Leypoint
        { -646.170, -7.866, -119.478, 183, 51 }, -- Wajaom_Woodlands - Southwest, next to puks and Mamool-Ja
        { 339.696, -10.675, 283.506, 58, 52 }, -- Bhaflau_Thickets - Center
        { -33.343, -32.339, 479.859, 211, 52 }, -- Bhaflau_Thickets - West
        { -12.403, -6.000, 50.616, 19, 53 }, -- Nashmau - Next to moogle
        { 451.926, -10.000, 57.493, 185, 54 }, -- Arrapago_Reef - Inside boat with Lamia
        { 721.261, -21.969, 45.020, 50, 61 }, -- Mount_Zhayolm - Crawler xp camp
        { 243.712, 10.000, 37.788, 139, 62 }, -- Halvung - Center
        { -614.921, 9.826, -99.984, 9, 64 }, -- Navukgo_Execution_Chamber - Outside battlefield
        { -138.309, 16.300, -158.426, 115, 65 }, -- Mamook - Open area, surrounded by Mamool-Ja
        { 300.203, -0.808, -191.159, 66, 67 }, -- Jade_Sepulcher - Outside battlefield
        { -258.921, 10.909, -371.645, 76, 68 }, -- Aydeewa_Subterrane - Magic skilling cliff
        { -395.942, 10.682, -439.559, 130, 68 }, -- Aydeewa_Subterrane - South, large room, on stairs
        { 3.875, 0.000, 10.037, 80, 71 }, -- The_Colosseum - Middle
        { -59.822, -8.000, -34.512, 192, 72 }, -- Alzadaal_Undersea_Ruins - Near teleporter
        { -203.219, 0.000, -566.493, 161, 72 }, -- Alzadaal_Undersea_Ruins - Near another teleporter
        { 497.200, -226.021, -21.173, 131, 78 }, -- Hazhalm_Testing_Grounds - Outside battlefield
        { 124.472, -0.468, -552.302, 20, 79 }, -- Caedarva_Mire - South marsh
        { 479.885, -8.474, -272.257, 141, 79 }, -- Caedarva_Mire - Near staging point, next to imps
        { 162.763, -2.000, 140.384, 48, 80 }, -- Southern_San_dOria_[S] - Next to mog house
        { 450.918, -24.977,-63.413, 29, 81 }, -- East_Ronfaure_[S] - Ladybug camp
        { 270.725, 2.286, 59.218, 127, 82 }, -- Jugner_Forest_[S] - Next to barricade
        { -120.312, 0.000, -160.659, 96, 82 }, -- Jugner_Forest_[S] - Next to teleport crystal
        { 199.724, -31.836, 313.003, 240, 83 }, -- Vunkerl_Inlet_[S] - Next to Goblin NPC
        { -444.278, -30.972, 260.793, 61, 83 }, -- Vunkerl_Inlet_[S] - West exit, next to gnole
        { 294.536, 9.107, -82.783, 32, 84 }, -- Batallia_Downs_[S] - Next to Jeuno gate
        { 220.502, 3.750, -69.754, 63, 85 }, -- La_Vaule_[S] - Entrance
        { 79.009, -2.483, -151.685, 192, 85 }, -- La_Vaule_[S] - Center, surrounded by orcs
        { -182.489, -8.000, -31.534, 247, 87 }, -- Bastok_Markets_[S] - Next to mog house
        { -275.922, 12.661, 257.112, 149, 88 }, -- North_Gustaberg_[S] - Next to Lycopodium NPC
        { -56.849, -28.527, 301.248, 84, 89 }, -- Grauberg_[S] - Next to Hippogryphs
        { -125.886, -13.808, 539.527,49, 89 }, -- Grauberg_[S] - Witchfire glen
        { 342.207, 25.000, -112.589, 20, 90 }, -- Pashhow_Marshlands_[S] - Next to teleport crystal
        { -541.256, -14.183, -193.689, 209, 91 }, -- Rolanberry_Fields_[S] - Next to moat carp pond
        { 197.871, 24.382, 449.040, 215, 91 }, -- Rolanberry_Fields_[S] - Next to Jeuno gate
        { -211.068, 1.000, 93.568, 25, 92 }, -- Beadeaux_[S] - Entrance
        { 300.765, 40.854, 19.898, 222, 92 }, -- Beadeaux_[S] - Deep inside
        { 160.822, 1.000, -20.465, 48, 94 },  -- Windurst_Waters_[S] - Near mog house
        { 293.573, -20.764, 566.597, 254, 95 }, -- West_Sarutabaruta_[S] - Northeast
        { -162.036, -68.000, -123.249, 57, 96 }, -- Fort_Karugo-Narugo_[S] - Wolfsnount
        { 306.503, -14.976, 22.398, 73, 97 }, -- Meriphataud_Mountains_[S] - Next to teleport crystal
        { 357.314, 32.000, 277.314, 185, 98 }, -- Sauromugue_Champaign_[S] - Northeast
        { -381.322, 0.663, 328.457, 105, 98 }, -- Sauromugue_Champaign_[S] - Next to Jeuno gate
        { -123.136, 0.250, 1.812, 158, 99 }, -- Castle_Oztroja_[S] - First floor, room full of yags
        { -222.866, -30.833, 9.320, 29, 100 }, -- West_Ronfaure - Near Amanita
        { -444.250, -19.580, -220.014, 132, 100 }, -- West_Ronfaure - Near outpost
        { 200.806, 0.000, -517.811, 198, 101 }, -- East_Ronfaure - South, near KRT zone
        { 419.867, 19.104, 24.557, 59, 102 }, -- La_Theine_Plateau - Near teleport crystal
        { -163.696, 39.891, -499.557, 126, 102 }, -- La_Theine_Plateau - Exit 3 from Ordelle's caves
        { 143.401, -6.940, 95.631, 155, 103 }, -- Valkurm_Dunes - Near outpost
        { 923.892, 0.184, -251.310, 76, 103 }, -- Valkurm_Dunes - Southeast section, near konschtat zone
        { 61.849, 0.682, -6.319, 78, 104 }, -- Jugner_Forest - Near outpost
        { -60.595, 0.590, -353.363, 92, 104 }, -- Jugner_Forest - South fork, near Davoi
        { 192.434, 7.996, -399.700, 72, 105 }, -- Batallia_Downs - Near main necropolis entrance
        { 198.287, 15.895, -603.038, 64, 105 }, -- Batallia_Downs - Island only reachable through necropolis
        { -578.564, 40.496, 59.974, 96, 106 }, -- North_Gustaberg - Near outpost
        { 379.934, 2.543, 294.723, 187, 106 }, -- North_Gustaberg - Near Bastok
        { -525.143, 99.224, 373.543, 246, 106 }, -- North_Gustaberg - Down area reachable through Dangruf
        { -267.045, 22.540, -383.877, 209, 107 }, -- South_Gustaberg - Near leaping lizzy
        { 200.551, -59.984, -409.928, 49, 107 }, -- South_Gustaberg - Top of Vomp Hill
        { 219.767, 19.104, 303.955, 60, 108 }, -- Konschtat_Highlands - Near teleport crystal
        { -83.028, -39.846, -379.189, 19, 108 }, -- Konschtat_Highlands - Maze like area at South
        { 465.953, 24.104, 420.797, 35, 109 }, -- Pashhow_Marshlands - Near outpost
        { -412.451, 24.034, 495.296, 145, 109 }, -- Pashhow_Marshlands - Northwest area, Hoaxmarsh
        { -110.011, -7.742, -630.973, 198, 110 }, -- Rolanberry_Fields - Crawler xp camp
        { -177.756, 12.741, 247.070, 229, 110 }, -- Rolanberry_Fields - North
        { -19.359, -59.766, -108.077, 82, 111 }, -- Beaucedine_Glacier - Near outpost
        { 262.038, 0.897, 203.741, 238, 111 }, -- Beaucedine_Glacier - East, place full of gigas
        { 204.879, -23.235, -208.878, 188, 112 }, -- Xarcabard - Near outpost
        { 151.795, -21.048, -38.548, 150, 112 }, -- Xarcabard - Near teleport crystal
        { 584.968, -8.433, 295.519, 163, 112 }, -- Xarcabard - On top of a G2 NM
        { -182.083, 7.993, -67.278, 134, 113 }, -- Cape_Teriggan - Near outpost
        { 46.438, 0.120, 40.691, 240, 113 }, -- Cape_Teriggan - East, place with raptors and cocks
        { -64.447, 3.949, 225.121, 4, 114 }, -- Eastern_Altepa_Desert - Near teleport crystal
        { -255.755, 8.379, -251.769, 113, 114 }, -- Eastern_Altepa_Desert - Near outpost
        { 63.183, -8.048, -92.977, 213, 114 }, --  Eastern_Altepa_Desert - Middle of map
        { -16.065, -13.015, 317.908, 2, 115 }, -- West_Sarutabaruta - Near outpost
        { 249.301, -20.333, 599.641, 179, 115 }, -- West_Sarutabaruta - North
        { 321.070, -12.466, 87.673, 112, 116 }, -- East_Sarutabaruta - Near Lily tower
        { 97.374, 35.151, 340.160, 2, 117 }, -- Tahrongi_Canyon - Near teleport crystal
        { -265.216, -1.732, -378.223, 98, 117 }, -- Tahrongi_Canyon - Narrow path at the bottom
        { -481.604, -31.277, 53.004, 62, 118 }, -- Buburimu_Peninsula - Near outpost
        { 388.056, 15.666, 145.500, 12, 118 }, -- Buburimu_Peninsula - East beach
        { 715.969, -32.024, -18.760, 45, 119 }, -- Meriphataud_Mountains - Next to Ostroja
        { -297.536, 17.083, 417.315, 216, 119 }, -- Meriphataud_Mountains - Next to outpost
        { -406.665, 0.132, 319.796, 39, 120 }, -- Sauromugue_Champaign - Near Jeuno
        { 299.959, 0.930, -315.625, 180, 120 }, -- Up the hill, area accessible through citadel
        { -39.257, 0.608, -145.877, 68, 121 }, -- The_Sanctuary_of_ZiTah - Near outpost
        { -332.436, 0.439, 436.451, 190, 121 }, -- The_Sanctuary_of_ZiTah - North, close to Ro'Maeve zone
        { -0.504, -29.324, 60.523, 193, 122 }, -- RoMaeve - Dry fountain, next to hall of the gods
        { 176.198, -4.428, -14.212, 75, 122 }, -- RoMaeve - Next to east moongate, surrounded by weapons
        { -243.889, -0.011, -397.683, 47, 123 }, -- Yuhtunga_Jungle - Next to outpost
        { -205.564, 0.115, 359.775, 235, 123 }, -- Yuhtunga_Jungle - XP camp near kazham
        { 205.276, 0.119, -84.381, 147, 124 }, -- Yhoator_Jungle - Next to outpost
        { -281.362, 0.599, -144.020, 5, 124 }, -- Yhoator_Jungle - Next to teleport crystal
        { 254.913, 0.558, -422.338, 145, 124 }, -- Yhoator_Jungle - Next to temple entrance
        { -121.329, -7.256, -21.625, 247, 125 }, -- Western_Altepa_Desert - Revelation rock
        { -282.041, 0.113, -526.300, 63, 125 }, -- Western_Altepa_Desert - South, next to cactus and scorpion
        { -247.162, -19.632, 301.793, 67, 126 }, -- Qufim_Island - Near outpost
        { 197.069, 20.138, -164.297, 89, 126 }, -- Qufim_Island - Tunnel leading to Jeuno, next to weapons
        { -266.681, -19.480, 76.955, 40, 127 }, -- Behemoths_Dominion - All the way to the end
        { -15.845, 0.110, -7.905, 241, 128 }, -- Valley_of_Sorrows - Middle of the map
        { -134.370, -32.327, -206.262, 211, 130 }, -- RuAun_Gardens - Green teleporter
        { 274.709, -2.600, 376.842, 210, 130 }, -- RuAun_Gardens - Near teleporter to Genbu island
        { -182.181, 11.935, -218.522, 27, 131 }, -- Mordion_Gaol - Cell 10
        { -20.003, -60.006, -103.908, 81, 136 }, -- Beaucedine_Glacier_[S] - Middle
        { -182.594, -2.829, 17.439, 142, 137 }, -- Xarcabard_[S] - West area
        { 3.846, 4.000, -77.072, 89, 138 }, -- Castle_Zvahl_Baileys_[S] - First map, after drop
        { -510.120, 158.706, -211.521, 7, 139 }, -- Horlais_Peak - Outside battlefield
        { 454.470, -38.551, -9.636, 72, 139 }, -- Horlais_Peak - Hot springs
        { -57.574, -32.365, 253.549, 121, 140 }, -- Ghelsba_Outpost - Next to mission 2-3 NM
        { 95.560, -59.979, 14.797, 42, 141 }, -- Fort_Ghelsba - Large clearing in the middle
        { -210.495, -0.094, -96.721, 32, 142 }, -- Yughott_Grotto - Near entrance from Ghelsba
        { 374.694, -40.335, 141.112, 252, 142 }, -- Yughott_Grotto - Near exit to Horlais
        { 112.325, -32.000, 84.063, 114, 143 }, -- Palborough_Mines - Top floor
        { 57.092, 0.533, 138.867, 225, 143 }, -- Palborough_Mines - Bottom floor
        { -345.725, 104.679, -260.023, 0, 144 }, -- Waughroon_Shrine - Outside battlefield
        { -141.208, 0.535, 148.216, 62, 145 }, -- Giddeus - Next to Ghoo Pakya (NPC)
        { -178.958, 16.749, 152.801, 352, 145 }, -- Giddeus - Next to Uu Zhoumo (NPC)
        { 299.205, -123.296, 348.348, 62, 146 }, -- Balgas_Dais - Outside battlefield
        { -122.142, 1.000, 125.663, 35, 147 }, -- Beadeaux - Near entrance
        { -139.582, 23.953, 22.229, 139, 147 }, -- Beadeaux - Next to the Afflictor (curse thingy)
        { 11.754, 25.812, -78.545, 83, 148 }, -- Qulun_Dome - Next to Magicite
        { 277.951, 43.125, 85.021, 189, 148 }, -- Qulun_Dome - Next to Adaman Quadav NM
        { 278.796, 4.000, -229.433, 73, 149 }, -- Davoi - Clearing near entrance
        { 184.811, -2.663, -117.034, 251, 149 }, -- Davoi - Next to Sedal-Godjal (Taru NPC)
        { 55.927, -11.384, -151.819, 170, 149 }, -- Davoi - Inside cottage, next to NM
        { -12.670, -0.122, -320.218, 195, 150 }, -- Monastic_Cavern - Large room in the beginning
        { 219.704, -2.517, -103.595, 84, 150 }, -- Monastic_Cavern - Next to Orcish Overlord NM
        { -162.433, -7.398, 0.271, 199, 150 }, -- Monastic_Cavern - Next to Magicite
        { 17.481, 0.250, -19.864, 203, 151 }, -- Castle_Oztroja - Near the two lever door
        { -174.779, -15.750, -20.561, 129, 151 }, -- Castle_Oztroja - Near the four lever door
        { -99.653, -72.000, 94.800, 195, 151 }, -- Castle_Oztroja - Next to Yagudo Avatar NM
        { -340.618, 25.250, 33.545, 178, 152 }, -- Altar_Room - Next to Magicite
        { 211.821, 8.751, -44.202, 121, 153 }, -- The_Boyahda_Tree - Large clearing on first map
        { -22.172, -19.391, -214.073, 83, 153 }, -- The_Boyahda_Tree - Top floor, near aggressive crawlers
        { 77.906, 6.721, 36.070, 217, 154 }, -- Dragons_Aery - Near Fafnir ???
        { -311.805, -48.000, -21.461, 152, 155 }, -- Castle_Zvahl_Keep_[S] - Near imps
        { 106.489, -6.000, 0.270, 4, 156 }, -- Throne_Room_[S] - Outside battlefield
        { 83.249, -56.749, 89.431, 25, 157 }, -- Middle_Delkfutts_Tower - On stairs
        { -284.295, -143.571, 44.506, 64, 158 }, -- Upper_Delkfutts_Tower - Floor 10, floor with elevator key NM
        { -302.496, -159.544, 45.874, 216, 158 }, -- Upper_Delkfutts_Tower - Floor 11, middle room
        { -101.166, 0.000, 41.286, 52, 159 }, -- Temple_of_Uggalepih - Room with Tonberry NM
        { 341.276, 0.000, 227.379, 85, 159 }, -- Temple_of_Uggalepih - Next to Bonze Marberry NM
        { -59.462, 46.078, 31.180, 191, 160 }, -- Den_of_Rancor - Outside gate to sacrificial chamber
        { 36.057, 16.119, -41.130, 161, 160 }, -- Den_of_Rancor - First map, many Tonberries nearby
        { 30.061, -20.000, 32.400, 131, 161 }, -- Castle_Zvahl_Baileys - Near entrance to castle
        { -23.091, -24.010, 104.884, 135, 161 }, -- Castle_Zvahl_Baileys - Goblin area
        { -49.491, 0.600, 89.446, 125, 162 }, -- Castle_Zvahl_Keep - Place with small rooms and doors
        { 301.226, 0.085, 348.575, 186, 163 }, -- Sacrificial_Chamber - Outside battlefield
        { 144.760, -6.080, 99.065, 57, 164 }, -- Garlaige_Citadel_[S] - Storage room
        { 109.298, -6.000, 0.135, 255, 165 }, -- Throne_Room - Outside battlefield
        { 100.179, -27.641, 125.541, 128, 166 }, -- Ranguemont_Pass - Narrow passage with eyes
        { -181.140, 5.500, -174.610, 191, 166 }, -- Ranguemont_Pass - Room with elvaan NPC
        { -20.328, -0.053, -16.666, 63, 167 }, -- Bostaunieux_Oubliette - Down the trap door
        { -219.632, -0.547, 7.144, 191, 168 }, -- Chamber_of_Oracles - Outside battlefield
        { 126.230, 15.300, -20.086, 245, 169 }, -- Toraimarai_Canal - Near animastery
        { 153.618, 16.000, 58.831, 133, 169 }, -- Toraimarai_Canal - Near windy waters zone
        { -289.255, 12.059, -260.680, 129, 170 }, -- Full_Moon_Fountain - Outside battlefields
        { 196.502, -32.234, -158.848, 106, 171 }, -- Crawlers_Nest_[S] - Near Herral-Doral NPC
        { -15.359, 10.493, -144.009, 254, 172 }, -- Zeruhn_Mines - Center room
        { -57.852, 8.189, -330.016, 87, 172 }, -- Zeruhn_Mines - Next to  Makarim NPC
        { -252.158, 1.000, -1.01, 131, 173 }, -- Korroloka_Tunnel - Middle of the first map
        { -212.191, -10.000, 168.525, 226, 173 }, -- Korroloka_Tunnel - Next to NIN quest ???
        { 109.820, 0.518, 0.304, 179, 174 }, -- Kuftal_Tunnel - Middle of second map, near crabs, possibly Guivre
        { 82.597, 30.067, 112.699, 151, 174 }, -- Kuftal_Tunnel - Pond area, next to scorpions
        { 379.977, -40.000, 18.176, 120, 175 }, -- The_Eldieme_Necropolis_[S] - Near Sandy NPC
        { 20.786, 9.888, 231.369, 187, 176 }, -- Sea_Serpent_Grotto - Next to hidden door towards Norg
        { 302.033, 11.152, -6.234, 176, 176 }, -- Sea_Serpent_Grotto - Behind silver coin door
        { -3.496, 0.576, -283.818, 205, 177 }, -- VeLugannon_Palace - Near Brigandish Blade pop
        { -78.744, 32.576, -5.136, 197, 178 }, -- The_Shrine_of_RuAvitau - Kirin spawn point
        { -519.984, -4.730, 11.451, 191, 179 }, -- Stellar_Fulcrum - Outside battlefield
        { 226.900, -173.197, 358.662, 246, 180 }, -- LaLoff_Amphitheater - Outside battlefield
        { -666.345, -5.823, -32.351, 0, 181 }, -- The_Celestial_Nexus - Outside battlefield
        { -699.879, -18.000, -321.764, 196, 182 }, -- Walk_of_Echoes - Outside battlefield
        { 343.936, -0.002, 15.992, 233, 184 }, -- Lower_Delkfutts_Tower - Near basement door
        { -198.730, 8.809, 19.729, 3, 190 }, -- King_Ranperres_Tomb - First tunnel, low level gobs
        { -28.290, 7.683, 21.112, 125, 190 }, -- King_Ranperres_Tomb - Near king tomb door
        { -130.346, 4.000, 120.203, 181, 191 }, -- Dangruf_Wadi - First geyser
        { -280.986, 0.500, 114.893, 179, 192 }, -- Inner_Horutoto_Ruins - Wedingo room
        { -260.490, 0.225, -19.352, 190, 192 }, -- Inner_Horutoto_Ruins - Outside 3 mage gate
        { -104.070, 0.435, 271.441, 70, 193 }, -- Ordelles_Caves - Downstairs near PLD quest ???
        { -61.171, -27.855, 51.965, 81, 193 }, -- Ordelles_Caves - Upstairs near chest farming area
        { 515.853, -0.025, 735.151, 152, 194 }, -- Outer_Horutoto_Ruins - Room with low lever cardians
        { 177.813, -31.000, 15.357, 218, 195 }, -- The_Eldieme_Necropolis - Near center drop
        { 140.575, -15.829, 200.238, 203, 195 }, -- The_Eldieme_Necropolis - Down map 2 near nastiest mobs
        { 18.537, -40.000, -59.599, 200, 196 }, -- Gusgen_Mines - Near 3 doors in map 1
        { 126.614, -19.000, 440.324, 110, 196 }, -- Gusgen_Mines - Far north, near pond
        { 122.711, -32.160, -81.059, 89, 197 }, -- Crawlers_Nest - First drop, non-aggressive lizzies
        { 38.716, -0.065, -318.631, 173, 197 }, -- Crawlers_Nest - Middle of donut room
        { 397.633, -0.02, -82.411, 233, 198 }, -- Maze_of_Shakhrami - East area, near bubu zone
        { 125.246, 20.404, -95.542, 216, 198 }, -- Maze_of_Shakhrami - Down on map 2
        { -210.749, 0.000, 220.499, 6, 200 }, -- Garlaige_Citadel - Outside first banishing gate
        { -298.138, 19.266, 174.325, 90, 200 }, -- Garlaige_Citadel - Basement, weapons area
        { -365.098, 0.367, -382.552, 236, 201 }, -- Cloister_of_Gales - Outside battlefield
        { 538.444, -13.923, 504.687, 76, 202 }, --  Cloister_of_Storms - Outside battlefield
        { 558.427, 0.353, 592.748, 199, 203 }, -- Cloister_of_Frost - Outside battlefield
        { -247.815, -14.250, 138.571, 131, 204 }, -- FeiYin - Stairs between maps 1 and 2
        { 25.867, 20.020, -3.078, 170, 205 }, -- Ifrits_Cauldron - Circular area
        { -221.801, -24.375, 19.991, 0, 206 }, -- QuBia_Arena - Outside battlfield
        { -716.119, 0.216, -605.070, 164, 207 }, -- Cloister_of_Flames - Outside battlefield
        { -942.174, 17.229, -370.752, 39, 208 }, -- Quicksand_Caves - Next to spelunking cactuar
        { -696.144, 0.000, -422.709, 163, 208 }, -- Quicksand_Caves - Next to weighted door
        { -539.091, 1.513, -506.889, 187, 209 }, -- Cloister_of_Tremors - Outside battlefield
        { 3.829, 0.000, -2.669, 182, 210 }, -- GM_Home - Center (GM only!)
        { 564.168, 36.780, 553.347, 170, 211 }, -- Cloister_of_Tides - Outside battlefield
        { 251.193, -18.770, -16.396, 108, 212 }, -- Gustav_Tunnel - Map 1, area with flies
        { -72.460, -9.953, -183.446, 35, 212 }, -- Gustav_Tunnel - Bune room
        { 173.971, 9.824, 67.467, 211, 212 }, -- Gustav_Tunnel - 2nd map, on top of Wyvern
        { -26.338, 12.089, -58.136, 123, 213 }, -- Labyrinth_of_Onzozo - LoO spawn point
        { 36.172, 4.797, 184.412, 24, 213 }, -- Labyrinth_of_Onzozo - Northmost area
        { 157.382, -2.000, 148.507, 201, 230 }, -- Southern_San_dOria - Near mog house
        { -256.562, -4.000, 98.330, 127, 230 }, -- Southern_San_dOria - West, next to count's manor
        { 124.564, -0.199, -0.519, 28, 231 }, -- Northern_San_dOria - Near mog house
        { 76.803, -16.000, -131.760, 33, 232 }, -- Port_San_dOria - Near mog house
        { -86.107, 0.398, 76.985, 119, 233 }, -- Chateau_dOraguille - West garden
        { 110.539, 0.994, -68.949, 3, 234 }, -- Bastok_Mines - Near mog house
        { -180.677, -8.000, -29.705, 0, 235 }, -- Bastok_Markets - Near mog house
        { 57.783, 8.500, -231.096, 59, 236 }, -- Port_Bastok - Near mog house
        { -105.386, -2.100, -9.034, 247, 236 }, -- Port_Bastok - Outside airship terminal
        { 43.692, -14.000, -2.709, 253, 237 }, -- Metalworks - Center of top floor, near embassies
        { 158.656, 1.000, -15.562, 45, 238 }, -- Windurst_Waters - Near mog house
        { -199.008, -3.000, -69.471, 176, 238 }, -- Windurst_Waters - South west area
        { -49.645, -2.500, -116.158, 128, 239 }, -- Windurst_Walls - Near mog house
        { 123.669, -3.000, 110.211, 192, 239 }, -- Windurst_Walls - Next to Shantotto
        { 199.233, -12.000, 223.118, 186, 240 }, -- Port_Windurst - Near mog house
        { -190.435, -2.000, 71.822, 33, 240 }, -- Port_Windurst - Near fishing guild
        { -95.379, -4.000, 39.673, 122, 241 }, -- Windurst_Woods - Near mog house
        { -0.776, 31.250, 7.864, 61, 242 }, -- Heavens_Tower - Basement
        { 46.730, 10.000, -65.930, 47, 243 }, -- RuLude_Gardens - Near mog house
        { 8.344, 3.100, 117.428, 218, 243 }, -- RuLude_Gardens - Next to Maat
        { 37.687, -5.000, -63.425, 33, 244 }, -- Upper_Jeuno - Near mog house
        { 33.556, -5.000, 71.927, 215, 245 }, -- Lower_Jeuno - Near mog house
        { -184.143, -5.000, -0.657, 121, 246 }, -- Port_Jeuno - Near mog house
        { 6.674, 8.000, 10.177, 167, 247 }, -- Rabao - Near moogle
        { 66.502, -14.559, -1.496, 253, 248 }, -- Selbina - Near moogle
        { 17.757, -15.878, 63.429, 70, 249 }, -- Mhaura - Near moogle
        { 16.259, -8.000, -86.251, 188, 250 }, -- Kazham - Near moogle
        { 0.005, -13.127, 5.965, 193, 251 }, -- Hall_of_the_Gods - Next to computer terminal
        { -48.715, -1.247, 42.220, 222, 252 }, -- Norg - Near moogle
    }

    if teleport and (isHalloweenEnabled() ~= 0 or
                    (VanadielDayOfTheWeek() == tpz.day.DARKSDAY and IsMoonFull() and (totd == tpz.time.NIGHT or totd == tpz.time.MIDNIGHT)) or
                    (TRICK_ALWAYS_ACTIVE ~= nil and TRICK_ALWAYS_ACTIVE)) then
        
        -- Create a list of valid destionations first, so we can
        -- decide on a destination with a single random call
        local valid_dest = {}
        
        for i,v in ipairs(destinations) do
            local is_valid = false
            
            -- First condition is that the player must have already visited
            -- that zone, otherwise we could get a lot of huge shortcuts
            -- that we want to avoid, e.g. teleporting a player to sky before
            -- they even started ZM.
            if player:isZoneVisited(v[5]) then
                is_valid = true
            end
            
            -- Process any exceptions that may exclude specific zones
            if is_valid then
                -- Do not teleport non-GM characters to the GM/Debug zone
                if v[5] == 210 and player:getGMLevel() < 2 then
                    is_valid = false
                end
                -- Server admin can disable Mordion_Gaol as a valid
                -- destination in the settings file
                else if v[5] == 131 and TRICK_DISABLE_JAIL ~= nil and TRICK_DISABLE_JAIL then
                    is_valid = false
                end
            end
            
            -- End of checks
            if is_valid then
                valid_dest[#valid_dest+1] = v
            end
        
        end
        
        -- Sanity check: We must have at least one valid destination.
        -- Actually we should always have at least two since players begin in
        -- a city zones and must zone out to fight mobs.
        -- Better be safe than sorry though.
        if #valid_dest == 0 then
            return
        end

        -- Actual destination selected at random
        local selected_dest = valid_dest[math.random(#valid_dest)]

        -- If we ended up in jail, set the flags accordingly.
        if selected_dest[5] == 131 then
            player:setCharVar( "inJail", 10 )
            player:setCharVar( "JailedFromX", math.floor(player:getXPos() * 1000))
            player:setCharVar( "JailedFromY", math.floor(player:getYPos() * 1000))
            player:setCharVar( "JailedFromZ", math.floor(player:getZPos() * 1000))
            player:setCharVar( "JailedFromRot", player:getRotPos())
            player:setCharVar( "JailedFromZone", player:getZoneID())
        end
        
        -- Time to go!
        player:setPos( selected_dest[1], selected_dest[2], selected_dest[3], selected_dest[4], selected_dest[5] )
                    
    end

end
