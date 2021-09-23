-----------------------------------
-- Area: Port_Bastok
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PORT_BASTOK] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE  = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL         = 6393, -- You do not have enough gil.
        CARRIED_OVER_POINTS         = 6427, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 6428, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 6429, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST           = 6451, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO     = 6452, -- You are now able to call multiple alter egos.
        HOMEPOINT_SET               = 6506, -- Home point set!
        CONQUEST_BASE               = 6526, -- Tallying conquest results...
        TENSHODO_SHOP_OPEN_DIALOG   = 6727, -- Ah, one of our members. Welcome to the Tenshodo shop.
        MOG_LOCKER_OFFSET           = 6820, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET      = 7082, -- You can't fish here.
        POWHATAN_DIALOG_1           = 7270, -- I'm sick and tired of entertaining guests.
        YOU_ACCEPT_THE_MISSION      = 7341, -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET     = 7346, -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        RONAN_DIALOG_1              = 7456, -- Do something! Isn't there anything you can do to make him come out of his shell?
        EVELYN_CLOSED_DIALOG        = 7575, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Gustaberg, but it's not easy getting stuff from areas that aren't under Bastokan control.
        ROSSWALD_CLOSED_DIALOG      = 7576, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Zulkheim, but it's not easy getting stuff from areas that aren't under Bastokan control.
        BELKA_CLOSED_DIALOG         = 7577, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Derfland, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VATTIAN_CLOSED_DIALOG       = 7578, -- I'm trying to start a business selling goods from Kuzotz, but it's not easy getting stuff from areas that aren't under Bastokan control.
        VALERIANO_SHOP_DIALOG       = 7580, -- Welcome to the Troupe Valeriano. Valeriano, at your service! Have a laugh, then spend some cash! Treats and sweets from exotic lands!
        SAWYER_SHOP_DIALOG          = 7625, -- Hi, there. For here or to go?
        MELLOA_SHOP_DIALOG          = 7626, -- Welcome to the Steaming Sheep. Would you like something to drink?
        BARTHOLOMEO_DIALOG          = 7627, -- Hello. This concourse is for arriving passengers.
        MUSTAFA_DIALOG              = 7627, -- Hello. This concourse is for arriving passengers.
        CAREY_DIALOG                = 7628, -- Hello. This concourse is for departing passengers.
        KLAUS_DIALOG                = 7628, -- Hello. This concourse is for departing passengers.
        EVELYN_OPEN_DIALOG          = 7629, -- Hello! Might I interest you in some specialty goods from Gustaberg?
        GALVIN_SHOP_DIALOG          = 7630, -- Welcome to Galvin's Travel Gear! We do our best to get the best for only the best!
        NUMA_SHOP_DIALOG            = 7631, -- Hello, hello! Won't you buy something? I'll give you a rebate!
        BELKA_OPEN_DIALOG           = 7632, -- Welcome. I've got goods from Derfland. Interested?
        ROSSWALD_OPEN_DIALOG        = 7633, -- Hello, hello! Everything I have is imported directly from Zulkheim!
        ILITA_SHOP_DIALOG           = 7634, -- Hello there. How about buying <item> to stay in touch with your friends?
        SUGANDHI_SHOP_DIALOG        = 7635, -- Traveler! I am sure my wares will prove useful on your journey. Why don't you buy some?
        DENVIHR_SHOP_DIALOG         = 7636, -- Ah, interested in my wares, are you? You can only buy these in Bastok, my friend.
        PAUJEAN_DIALOG_1            = 7647, -- Where can you find them? If you're the kind of adventurer I think you are, you should have a pretty good idea. Just don't do anything I wouldn't...heh heh.
        MOGHOUSE_EXIT               = 7945, -- You have learned your way through the back alleys of Bastok! Now you can exit to any area from your residence.
        CONQUEST                    = 8001, -- You've earned conquest points!
        VATTIAN_OPEN_DIALOG         = 8361, -- Welcome to my humble establishment. I have a wide variety of specialty goods from Kuzotz.
        ZOBYQUHYO_OPEN_DIALOG       = 8362, -- Hey therrre! I've got lots of wonderrrful goodies, fresh from the Elshimo Lowlands.
        ZOBYQUHYO_CLOSED_DIALOG     = 8363, -- I'm trrrying to start a business selling goods from the Elshimo Lowlands, but it's not easy getting stuff from areas that aren't under Bastokan contrrrol.
        DHENTEVRYUKOH_OPEN_DIALOG   = 8364, -- Welcome! Welcome! Take a wonderrr at these specialty goods from the Elshimo Uplands!
        DHENTEVRYUKOH_CLOSED_DIALOG = 8365, -- I'm trrrying to start a business selling goods from the Elshimo Uplands, but it's not easy transporting goods from areas that aren't under Bastokan contrrrol.
        UNLOCK_NINJA                = 8428, -- You can now become a ninja.
        EXTENDED_MISSION_OFFSET     = 8466, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TITAN_UNLOCKED              = 8533, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        BLABBIVIX_SHOP_DIALOG       = 8637, -- <Pshooowaaaaa> I come from the underworld. These chipshhh, you knooow, are popular among us Goblinshhh. Use with heart of shhhtatue.
        NOKKHI_BAD_COUNT            = 8789, -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE           = 8791, -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM             = 8792, -- I'm real sorry, but there's nothing I can do with those.
        ASURAN_FISTS_LEARNED        = 8808, -- You have learned the weapon skill Asuran Fists!
        BAGNOBROK_CLOSED_DIALOG     = 9120, -- Kbastok sis kweak! Smoblins yonly twant gstrong sfriends! Non sgoods mfrom Smovalpolos ytoday!
        BAGNOBROK_OPEN_DIALOG       = 9121, -- Kbastok! Crepublic sis gstrong! Smoblins lsell sgoods oto gstrong sfriends!
        CLOUD_BAD_COUNT             = 9216, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE            = 9220, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM              = 9221, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        FESTIVE_MOOGLE_DIALOG       = 9230, -- Come one, come all, kupo!
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU              = 9161, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS              = 9164, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN             = 9168, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN     = 9169, -- You've brought barrelfuls of joy to the children of Vana'diel!
    },
    mob =
    {
    },
    npc =
    {
        STARLIGHT_DECORATIONS = {

            [17744126] = 17744126,  -- Starlight Festival Fountain
            [17744127] = 17744127,  -- Starlight Festival Fountain
            [17744128] = 17744128,  -- Starlight Festival Planter
            [17744129] = 17744129,  -- Starlight Festival Planter
            [17744130] = 17744130,  -- Starlight Festival Planter
            [17744131] = 17744131,  -- Starlight Festival Planter
            [17744132] = 17744132,  -- Starlight Festival Planter
            [17744133] = 17744133,  -- Starlight Festival Planter
            [17744134] = 17744134,  -- Starlight Festival Planter
            [17744135] = 17744135,  -- Starlight Festival Planter
            [17744136] = 17744136,  -- Starlight Festival Planter
            [17744137] = 17744137,  -- Starlight Festival Planter
            [17744138] = 17744138,  -- Starlight Festival Planter
            [17744139] = 17744139,  -- Starlight Festival Planter
            [17744140] = 17744140,  -- Starlight Festival Planter
            [17744141] = 17744141,  -- Starlight Festival Planter
            [17744142] = 17744142,  -- Starlight Festival Planter
            [17744143] = 17744143,  -- Starlight Festival Planter
            [17744144] = 17744144,  -- Starlight Festival Planter
            [17744145] = 17744145,  -- Starlight Festival Planter
            [17744146] = 17744146,  -- Starlight Festival Planter
            [17744147] = 17744147,  -- Starlight Festival Planter
            [17744148] = 17744148,  -- Starlight Festival Planter
            [17744149] = 17744149,  -- Starlight Festival Planter
            [17744150] = 17744150,  -- Starlight Festival Planter
            [17744151] = 17744151,  -- Starlight Festival Planter
            [17744152] = 17744152,  -- Starlight Festival Planter
            [17744153] = 17744153,  -- Starlight Festival Planter
            [17743981] = 17743981,  -- Event Moogle Stall
            [17743985] = 17743985,  -- Festive Moogle

        },
        DOLL_FESTIVAL_DECORATIONS = {

            [17744060] = 17744060,  -- Doll Festival Stage
            [17744061] = 17744061,  -- Doll Festival Umbrella and Stand
            [17744062] = 17744062,  -- Doll Festival Umbrella and Stand
            [17744063] = 17744063,  -- Doll Festival Umbrella and Stand
            [17744064] = 17744064,  -- Doll Festival Umbrella and Stand
            [17744065] = 17744065,  -- Doll Festival Cherry Blossom
            [17744066] = 17744066,  -- Doll Festival Cherry Blossom
            [17744067] = 17744067,  -- Doll Festival Cherry Blossom
            [17744068] = 17744068,  -- Doll Festival Cherry Blossom
            [17744069] = 17744069,  -- Doll Festival Cherry Blossom
            [17744070] = 17744070,  -- Doll Festival Cherry Blossom
            [17744071] = 17744071,  -- Doll Festival Cherry Blossom
            [17744072] = 17744072,  -- Doll Festival Cherry Blossom
            [17744073] = 17744073,  -- Doll Festival Cherry Blossom Petals
            [17744074] = 17744074,  -- Doll Festival Cherry Blossom Petals
            [17744075] = 17744075,  -- Doll Festival Cherry Blossom Petals
            [17744076] = 17744076,  -- Doll Festival Cherry Blossom Petals
            [17744077] = 17744077,  -- Doll Festival Cherry Blossom Petals
            [17744078] = 17744078,  -- Doll Festival Cherry Blossom Petals
            [17744079] = 17744079,  -- Doll Festival Cherry Blossom Petals
            [17744080] = 17744080,  -- Doll Festival Cherry Blossom Petals

        },
        SUNBREEZE_FESTIVAL_DECORATIONS = {

            [17744081] = 17744081,  -- Sunbreeze Festival Fountain
            [17744082] = 17744082,  -- Sunbreeze Festival Fountain
            [17744083] = 17744083,  -- Sunbreeze Festival Planter
            [17744084] = 17744084,  -- Sunbreeze Festival Planter
            [17744085] = 17744085,  -- Sunbreeze Festival Planter
            [17744086] = 17744086,  -- Sunbreeze Festival Planter
            [17744087] = 17744087,  -- Sunbreeze Festival Planter
            [17744088] = 17744088,  -- Sunbreeze Festival Planter
            [17744089] = 17744089,  -- Sunbreeze Festival Planter
            [17744090] = 17744090,  -- Sunbreeze Festival Planter
            [17744091] = 17744091,  -- Sunbreeze Festival Planter
            [17744092] = 17744092,  -- Sunbreeze Festival Planter
            [17744093] = 17744093,  -- Sunbreeze Festival Planter
            [17744094] = 17744094,  -- Sunbreeze Festival Planter
            [17744095] = 17744095,  -- Sunbreeze Festival Planter
            [17744096] = 17744096,  -- Sunbreeze Festival Planter
            [17744097] = 17744097,  -- Sunbreeze Festival Planter
            [17744098] = 17744098,  -- Sunbreeze Festival Planter
            [17744099] = 17744099,  -- Sunbreeze Festival Planter
            [17744100] = 17744100,  -- Sunbreeze Festival Planter
            [17744101] = 17744101,  -- Sunbreeze Festival Planter
            [17744102] = 17744102,  -- Sunbreeze Festival Planter
            [17744103] = 17744103,  -- Sunbreeze Festival Planter
            [17744104] = 17744104,  -- Sunbreeze Festival Planter
            [17744105] = 17744105,  -- Sunbreeze Festival Planter
            [17744106] = 17744106,  -- Sunbreeze Festival Planter
            [17744107] = 17744107,  -- Sunbreeze Festival Planter
            [17744108] = 17744108,  -- Sunbreeze Festival Planter
            [17744125] = 17744125,  -- Sunbreeze Festival Fireworks

        },
        CIRCUS = {

            [17743968] = 17743968, -- Mokop-Sankop
            [17743969] = 17743969, -- Cheh Raihah
            [17743966] = 17743966, -- Valeriano
            [17743970] = 17743970,-- Nalta
            [17743967] = 17743967, -- Dahjal
            [17744022] = 17744022, -- Ominous Cloud
            [17744021] = 17744021, -- Nokkhi Jinjahl
            
        },
    },
}

return zones[tpz.zone.PORT_BASTOK]
