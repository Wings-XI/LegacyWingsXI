-----------------------------------
-- Area: Windurst_Waters
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WINDURST_WATERS] =
{
    text =
    {
        CONQUEST_BASE              = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED    = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED              = 6547, -- Obtained: <item>.
        GIL_OBTAINED               = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6550, -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6551, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL        = 6552, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY    = 6561, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS        = 6586, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 6587, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 6588, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET              = 6638, -- Home point set!
        YOU_ACCEPT_THE_MISSION     = 6731, -- You have accepted the mission.
        MOG_LOCKER_OFFSET          = 6807, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET     = 7046, -- You can't fish here.
        COOKING_SUPPORT            = 7150, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT   = 7164, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT         = 7172, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE        = 7179, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                = 7184, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP         = 7185, -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN         = 7201, -- You have successfully renounced your status as a ≺Multiple Choice (Parameter 5)≻[craftsman/artisan/adept] of the ≺Multiple Choice (Parameter 1)≻[Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        KOPOPO_SHOP_DIALOG         = 7840, -- Cooking is as much an art as music and painting are. Can your taste buds appreciate the full value of our works of art?
        CHOMOJINJAHL_SHOP_DIALOG   = 7845, -- The qualities needed to be a good cook are strong arms, a sense of taste, and devotion.
        ENSASA_SHOP_DIALOG         = 8912, -- Welcome to my little catalyst shop, where you'll find a range of general and unusual goods!
        UPIHKHACHLA_SHOP_DIALOG    = 8913, -- For adventurerrrs on the go, Ensasa's Catalyst Shop is the place for all you need in generrral goods!
        SHOHRUNTUHRUN_SHOP_DIALOG  = 8915, -- Oh, hidey-widey! This is the Federal Magic Reservey-wervey. What can I do for you today-oway?
        HIKOMUMAKIMU_SHOP_DIALOG   = 8916, -- Welcome to the Federal Magic Reserve, the only place in the Federation where high-level magic is allowed to be sold.
        OREZEBREZ_SHOP_DIALOG      = 8917, -- Welcome to Baren-Moren's, makers of the finest headwear. Our slogan is: The smarter the hat, the smarter the head.
        TAAJIJI_SHOP_DIALOG        = 8919, -- May I take your order, please...
        MAQUMOLPIH_OPEN_DIALOG     = 8920, -- Psst... Check out these things my suppliers in Aragoneu dug up.
        MAQUMOLPIH_CLOSED_DIALOG   = 8921, -- Sorrrry, but I'm waiting on my next shipment from Aragoneu, so I'm all out of things to sell you at the moment.
        BAEHUFAEHU_OPEN_DIALOG     = 8922, -- Can I interest you in some of Sarutabaruta's wares? Come on, have a look, and see how I fares!
        BAEHUFAEHU_CLOSED_DIALOG   = 8923, -- Sorry-dorry, but I'm taking a breaky-wakey! (Or, as you'll be knowing,  since control of Sarutabaruta was lost, I'm out of stock, so go on, get going!)
        AHYEEKIH_OPEN_DIALOG       = 8924, -- Psst... Wanna buy somethin' cheap from Kolshushu?
        AHYEEKIH_CLOSED_DIALOG     = 8925, -- Hee-hee-hee... Can you hang on a while? I can start selling you good stuff from Kolshushu once I'm ready.
        FOMINA_OPEN_DIALOG         = 8926, -- Hello, adventurer! Can I interest you in something a little different--something from Elshimo?
        FOMINA_CLOSED_DIALOG       = 8927, -- Well, um, let me see... This should be a good spot to open shop. There are some wealthy-looking Tarutaru houses nearby. It's quiet and yet there're plenty of passers-by...
        OTETE_OPEN_DIALOG          = 8928, -- He-he-he... Hey! How's about... Items from Li'Telor that you can't do without? Reckon you could do, with one of these or two?
        OTETE_CLOSED_DIALOG        = 8929, -- Oh... Phew... My heart is so blue... Bluer than these flowers... Leave me be for a couple hours...
        JOURILLE_OPEN_DIALOG       = 8930, -- Greetings.  Can I interest you in some of these goods from Ronfaure...?
        JOURILLE_CLOSED_DIALOG     = 8931, -- Greetings! I am Jourille, your friendly neighborhood traveling merchant. I would most like to sell you something from Ronfaure right now, but I regret that I am waiting on my next shipment. Please call by later!
        YOU_SHOW_OFF_THE           = 9107, -- You show off the <item>.
        CONQUEST                   = 9217, -- You've earned conquest points!
        TRICK_OR_TREAT             = 10166, -- Trick or treat...
        THANK_YOU_TREAT            = 10167, -- Thank you... And now for your treat...
        HERE_TAKE_THIS             = 10168, -- Here, take this...
        IF_YOU_WEAR_THIS           = 10169, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                  = 10170, -- Thank you...
        PRESTAPIQ_CLOSED_DIALOG    = 10660, -- Goodebyongo! Wingdorsht tooo fhar awayz fhrum mai hormtowne! Dropt arll goodhys whylle ahn trripp!
        PRESTAPIQ_OPEN_DIALOG      = 10661, -- Helgohelgo! Me's bhrink goodhys arll ja wayz fhrum hormtowne ovf Morvalporlis!
        FESTIVE_MOOGLE_DIALOG      = 11462, -- Come one, come all, kupo!
        NESSRUGETOMALL_SHOP_DIALOG = 11465, -- Welcome to the Rarab Tail Hostelry.
        DIABOLOS_UNLOCKED          = 11894, -- You are now able to summon Diabolos!
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU             = 10680, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS             = 10683, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN            = 10687, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN    = 10688, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1           = 10786, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2           = 15381, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3           = 15411, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4           = 15407, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5           = 15406, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6           = 15391, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK       = 15408, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED         = 10793, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG       = 15409, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM     = 15397, -- Here's a little something for your kindness.≺Prompt≻
        STARLIGHT_FAME_DIALOG      = 10810, -- ≺Multiple Choice (Parameter 1)≻[You haven't brought any happiness to the children!/You've done some good./You've done fairly well./You've made the children very happy!/You've brought lots of smiles!/You have the children bursting with glee!/The children love you!] ≺Multiple Choice (Parameter 1)≻[What a disappointment./You just need to give a little extra effort!/Keep it up!/You make a good smilebringer./Excellent work!/Stupendous job!/Even I think you're great!]≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS = {
            [17752097] = 564, -- Ensasa | Skeleton
            [17752098] = 368, -- Upih Khachla | Ghost
            [17752101] = 365, -- Ness Rugetomal | Hound
            [17752102] = 612, -- Maqu Molpih | Orc
            [17752103] = 535, -- Ahyeekih | Shade
        },
        HALLOWEEN_DECORATIONS = {
            [17752460] = 17752460,  -- Halloween Decoration
            [17752461] = 17752461,  -- Halloween Decoration
            [17752462] = 17752462,  -- Halloween Decoration
            [17752463] = 17752463,  -- Halloween Decoration
            [17752504] = 17752504,  -- Event Moogle Stall
            [17752228] = 17752228,  -- Festive Moogle
        },
        HALLOWEEN_ROAMING = {
            [17752291] = 17752291,  -- Trick Shadow 
            [17752292] = 17752292,  -- Trick Specter 
            [17752293] = 17752293,  -- Trick Shade 
            [17752294] = 17752294,  -- Trick Ghost
            [17752295] = 17752295,  -- Trick Spirit
            [17752296] = 17752296,  -- Trick Phantom
            [17752297] = 17752297,  -- Trick Skeleton
            [17752298] = 17752298,  -- Trick Wight
            [17752299] = 17752299,  -- Trick Bones
            [17752300] = 17752300,  -- Trick Ghast           
        },
        EGG_HUNT_DECORATIONS = {
            [17752414] = 17752414,  -- Egg Hunt Egg-stravaganza Pole
            [17752415] = 17752415,  -- Egg Hunt Egg-stravaganza Pole
            [17752416] = 17752416,  -- Egg Hunt Egg-stravaganza Pole
            [17752417] = 17752417,  -- Egg Hunt Egg-stravaganza Pole
        },
        STARLIGHT_DECORATIONS = {
            [17752471] = 17752471,  -- Starlight Festival Tree
            [17752472] = 17752472,  -- Starlight Festival Tree
            [17752473] = 17752473,  -- Starlight Festival Tree
            [17752474] = 17752474,  -- Starlight Festival Tree
            [17752475] = 17752475,  -- Starlight Festival Tree
            [17752476] = 17752476,  -- Starlight Festival Tree
            [17752477] = 17752477,  -- Starlight Festival Tree
            [17752478] = 17752478,  -- Starlight Festival Tree
            [17752479] = 17752479,  -- Starlight Festival Tree
            [17752480] = 17752480,  -- Starlight Festival Tree
            [17752481] = 17752481,  -- Starlight Festival Tree
            [17752482] = 17752482,  -- Starlight Festival Tree
            [17752483] = 17752483,  -- Starlight Festival Tree
            [17752484] = 17752484,  -- Starlight Festival Tree
            [17752485] = 17752485,  -- Starlight Festival Tree
            [17752486] = 17752486,  -- Starlight Festival Tree
            [17752487] = 17752487,  -- Starlight Festival Tree
            [17752488] = 17752488,  -- Starlight Festival Tree
            [17752489] = 17752489,  -- Starlight Festival Tree
            [17752490] = 17752490,  -- Starlight Festival Tree
            [17752504] = 17752504,  -- Event Moogle Stall
            [17752228] = 17752228,  -- Festive Moogle
            [17752253] = 17752253,  -- Event Moogle
            [17752514] = 17752514,  -- Atagei-Portagei
        },
        DOLL_FESTIVAL_DECORATIONS = {
            [17752383] = 17752383,  -- Doll Festival Stage
            [17752384] = 17752384,  -- Doll Festival Umbrella and Stand
            [17752385] = 17752385,  -- Doll Festival Umbrella and Stand
            [17752386] = 17752386,  -- Doll Festival Umbrella and Stand
            [17752387] = 17752387,  -- Doll Festival Cherry Blossom
            [17752388] = 17752388,  -- Doll Festival Cherry Blossom
            [17752389] = 17752389,  -- Doll Festival Cherry Blossom
            [17752390] = 17752390,  -- Doll Festival Cherry Blossom
            [17752391] = 17752391,  -- Doll Festival Cherry Blossom
            [17752392] = 17752392,  -- Doll Festival Cherry Blossom
            [17752393] = 17752393,  -- Doll Festival Cherry Blossom
            [17752394] = 17752394,  -- Doll Festival Cherry Blossom
            [17752395] = 17752395,  -- Doll Festival Cherry Blossom
            [17752396] = 17752396,  -- Doll Festival Cherry Blossom
            [17752397] = 17752397,  -- Doll Festival Cherry Blossom
            [17752398] = 17752398,  -- Doll Festival Cherry Blossom
            [17752399] = 17752399,  -- Doll Festival Cherry Blossom
            [17752400] = 17752400,  -- Doll Festival Cherry Blossom Petals
            [17752401] = 17752401,  -- Doll Festival Cherry Blossom Petals
            [17752402] = 17752402,  -- Doll Festival Cherry Blossom Petals
            [17752403] = 17752403,  -- Doll Festival Cherry Blossom Petals
            [17752404] = 17752404,  -- Doll Festival Cherry Blossom Petals
            [17752405] = 17752405,  -- Doll Festival Cherry Blossom Petals
            [17752406] = 17752406,  -- Doll Festival Cherry Blossom Petals
            [17752407] = 17752407,  -- Doll Festival Cherry Blossom Petals
            [17752408] = 17752408,  -- Doll Festival Cherry Blossom Petals
            [17752409] = 17752409,  -- Doll Festival Cherry Blossom Petals
            [17752410] = 17752410,  -- Doll Festival Cherry Blossom Petals
            [17752411] = 17752411,  -- Doll Festival Cherry Blossom Petals
            [17752412] = 17752412,  -- Doll Festival Cherry Blossom Petals
        },
        NEW_YEARS_DECORATIONS = {
            [17752428] = 17752428,  -- New Years Standing Tree
            [17752429] = 17752429,  -- New Years Standing Tree
            [17752430] = 17752430,  -- New Years Standing Tree
            [17752431] = 17752431,  -- New Years Standing Tree
        },
        SUNBREEZE_FESTIVAL_DECORATIONS = {
            [17752436] = 17752436,  -- Sunbreeze Festival Tree
            [17752437] = 17752437,  -- Sunbreeze Festival Tree
            [17752438] = 17752438,  -- Sunbreeze Festival Tree
            [17752439] = 17752439,  -- Sunbreeze Festival Tree
            [17752440] = 17752440,  -- Sunbreeze Festival Tree
            [17752441] = 17752441,  -- Sunbreeze Festival Tree
            [17752442] = 17752442,  -- Sunbreeze Festival Tree
            [17752443] = 17752443,  -- Sunbreeze Festival Tree
            [17752444] = 17752444,  -- Sunbreeze Festival Tree
            [17752445] = 17752445,  -- Sunbreeze Festival Tree
            [17752446] = 17752446,  -- Sunbreeze Festival Tree
            [17752447] = 17752447,  -- Sunbreeze Festival Tree
            [17752448] = 17752448,  -- Sunbreeze Festival Tree
            [17752449] = 17752449,  -- Sunbreeze Festival Tree
            [17752450] = 17752450,  -- Sunbreeze Festival Tree
            [17752451] = 17752451,  -- Sunbreeze Festival Tree
            [17752452] = 17752452,  -- Sunbreeze Festival Tree
            [17752453] = 17752453,  -- Sunbreeze Festival Tree
            [17752454] = 17752454,  -- Sunbreeze Festival Tree
            [17752455] = 17752455,  -- Sunbreeze Festival Tree
        },
        LELEROON_GREEN_DOOR = 17752333,
    },
}

return zones[tpz.zone.WINDURST_WATERS]
