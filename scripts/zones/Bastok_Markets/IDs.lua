-----------------------------------
-- Area: Bastok_Markets
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BASTOK_MARKETS] =
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
        YOU_MUST_WAIT_ANOTHER_N_DAYS= 6424, -- You must wait another ≺number≻ [day/days] to perform that action.
        ITEMS_OBTAINED              = 6397, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS         = 6427, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 6428, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 6429, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HOMEPOINT_SET               = 6479, -- Home point set!
        YOU_ACCEPT_THE_MISSION      = 6508, -- You have accepted the mission.
        ORIGINAL_MISSION_OFFSET     = 6513, -- You can consult the Mission section of the main menu to review your objectives. Speed and efficiency are your priorities. Dismissed.
        CONQUEST_BASE               = 6581, -- Tallying conquest results...
        MOG_LOCKER_OFFSET           = 6870, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        GOLDSMITHING_SUPPORT        = 7075, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT    = 7089, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT          = 7097, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE         = 7104, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                 = 7109, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP          = 7110, -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN          = 7126, -- You have successfully renounced your status as a ≺Multiple Choice (Parameter 5)≻[craftsman/artisan/adept] of the ≺Multiple Choice (Parameter 1)≻[Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        FISHING_MESSAGE_OFFSET      = 7206, -- You can't fish here.
        SOMNPAEMN_CLOSED_DIALOG     = 7572, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Sarutabaruta, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        YAFAFA_CLOSED_DIALOG        = 7573, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Kolshushu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        OGGODETT_CLOSED_DIALOG      = 7574, -- Sorry, I don't have anything to sell you. I'm trying to start a business selling goods from Aragoneu, but it's not easy getting stuff out of areas that aren't under Bastokan control.
        ITEM_DELIVERY_DIALOG        = 7661, -- Need something sent to a friend's house? Sending items to your own room? You've come to the right place!
        TEERTH_SHOP_DIALOG          = 7675, -- Welcome to the Goldsmiths' Guild shop. What can I do for you?
        VISALA_SHOP_DIALOG          = 7676, -- Welcome to the Goldsmiths' Guild shop. How may I help you?
        ZHIKKOM_SHOP_DIALOG         = 7677, -- Hello! Welcome to the only weaponry store in Bastok, the Dragon's Claws!
        CIQALA_SHOP_DIALOG          = 7678, -- A weapon is the most precious thing to an adventurer! Well, after his life, of course. Choose wisely.
        PERITRAGE_SHOP_DIALOG       = 7679, -- Hey! I've got just the thing for you!
        BRUNHILDE_SHOP_DIALOG       = 7680, -- Welcome to my store! You want armor, you want shields? I've got them all!
        CHARGINGCHOCOBO_SHOP_DIALOG = 7681, -- Hello. What piece of armor are you missing?
        BALTHILDA_SHOP_DIALOG       = 7682, -- Feeling defenseless of late? Brunhilde's Armory has got you covered!
        MJOLL_SHOP_DIALOG           = 7683, -- Welcome. Have a look and compare! You'll never find better wares anywhere.
        OLWYN_SHOP_DIALOG           = 7684, -- Welcome to Mjoll's Goods! What can I do for you?
        ZAIRA_SHOP_DIALOG           = 7685, -- Greetings. What spell are you looking for?
        SORORO_SHOP_DIALOG          = 7686, -- Hello-mellow, welcome to Sororo's Scribe and Notary! Hmm? No, we sell magic spells! What did you think?
        HARMODIOS_SHOP_DIALOG       = 7687, -- Add music to your adventuring life! Welcome to Harmodios's.
        CARMELIDE_SHOP_DIALOG       = 7688, -- Ah, welcome, welcome! What might I interest you in?
        RAGHD_SHOP_DIALOG           = 7689, -- Give a smile to that special someone! Welcome to Carmelide's.
        HORTENSE_SHOP_DIALOG        = 7690, -- Hello there! We have instruments and music sheets at Harmodios's!
        OGGODETT_OPEN_DIALOG        = 7691, -- Hello there! Might I interest you in some specialty goods from Aragoneu?
        YAFAFA_OPEN_DIALOG          = 7692, -- Hello! I've got some goods from Kolshushu--interested?
        SOMNPAEMN_OPEN_DIALOG       = 7693, -- Welcome! I have goods straight from Sarutabaruta! What say you?
        CONQUEST                    = 7784, -- You've earned conquest points!
        EXTENDED_MISSION_OFFSET     = 8146, -- Go to Ore Street and talk to Medicine Eagle. He says he was there when the commotion started.
        TRICK_OR_TREAT              = 8269, -- Trick or treat...
        THANK_YOU_TREAT             = 8270, -- Thank you... And now for your treat...
        HERE_TAKE_THIS              = 8271, -- Here, take this...
        IF_YOU_WEAR_THIS            = 8272, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                   = 8273, -- Thank you...
        RETRIEVE_DIALOG_ID          = 12879, -- You retrieve <item> from the porter moogle's care.
        TURNING_IN_SPARKS           = 14205, -- Ohohoho... Turning in sparks, I see.
        NOT_ENOUGH_SPARKS           = 14230, -- You do not possess enough sparks of eminence to complete the transaction.
        LS_CONCIERGE_LISTING_CANCEL = 14349, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_SAME_DAY       = 14353, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LS_CONCIERGE_REGISTERED1    = 14401, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2    = 14402, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED = 14403, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU              = 8502, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS              = 8505, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN             = 8509, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN     = 8510, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1            = 8896, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2            = 12601, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3            = 12633, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4            = 12629, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5            = 12628, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6            = 12621, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK        = 12630, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED          = 8903, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG        = 12631, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM      = 12623, -- Here's a little something for your kindness.≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
        AQUILLINA = 17739784,
        HALLOWEEN_SKINS =
        {
            [17739805] = 368, -- Olwyn | Ghost
        },
        HALLOWEEN_DECORATIONS = {
            [17740095] = 17740095,  -- Halloween Decorations
            [17740096] = 17740096,  -- Halloween Decorations
            [17740097] = 17740097,  -- Halloween Decorations
            [17740098] = 17740098,  -- Halloween Decorations
            [17740099] = 17740099,  -- Halloween Decorations
        },
        HALLOWEEN_ROAMING = {
            [17739895] = 17739895,  -- Trick Shadow 
            [17739896] = 17739896,  -- Trick Specter 
            [17739897] = 17739897,  -- Trick Shade 
            [17739898] = 17739898,  -- Trick Ghost 
            [17739899] = 17739899,  -- Trick Spirit 
            [17739900] = 17739900,  -- Trick Phantom 
            [17739901] = 17739901,  -- Trick Skeleton 
            [17739902] = 17739902,  -- Trick Wight 
            [17739903] = 17739903,  -- Trick Bones 
            [17739904] = 17739904,  -- Trick Ghast       
        },
        EGG_HUNT_DECORATIONS = {
            [17740009] = 17740009,  -- Egg Hunt Egg-stravaganza Pole
            [17740010] = 17740010,  -- Egg Hunt Egg-stravaganza Pole
            [17740011] = 17740011,  -- Egg Hunt Egg-stravaganza Pole
            [17740012] = 17740012,  -- Egg Hunt Egg-stravaganza Pole
            [17740013] = 17740013,  -- Egg Hunt Egg-stravaganza Pole
            [17740014] = 17740014,  -- Egg Hunt Egg-stravaganza Pole
        },
        STARLIGHT_DECORATIONS = {
            [17740105] = 17740105,  -- Starlight Festival Center Fountain
            [17740106] = 17740106,  -- Starlight Festival Planter
            [17740107] = 17740107,  -- Starlight Festival Planter
            [17740108] = 17740108,  -- Starlight Festival Planter
            [17740109] = 17740109,  -- Starlight Festival Planter
            [17740110] = 17740110,  -- Starlight Festival Planter
            [17740111] = 17740111,  -- Starlight Festival Planter
            [17740112] = 17740112,  -- Starlight Festival Planter
            [17740113] = 17740113,  -- Starlight Festival Planter
            [17740114] = 17740114,  -- Starlight Festival Planter
            [17740115] = 17740115,  -- Starlight Festival Planter
            [17740116] = 17740116,  -- Starlight Festival Planter
            [17740117] = 17740117,  -- Starlight Festival Planter
            [17740118] = 17740118,  -- Starlight Festival Planter
            [17740119] = 17740119,  -- Starlight Festival Planter
            [17740120] = 17740120,  -- Starlight Festival Planter
            [17740121] = 17740121,  -- Starlight Festival Planter
            [17740122] = 17740122,  -- Starlight Festival Planter
            [17740123] = 17740123,  -- Starlight Festival Planter
            [17740124] = 17740124,  -- Starlight Festival Planter
            [17740125] = 17740125,  -- Starlight Festival Planter
            [17740126] = 17740126,  -- Starlight Festival Planter
            [17740127] = 17740127,  -- Starlight Festival Planter
            [17740138] = 17740138,  -- Starlight Festival Planter
            [17740139] = 17740139,  -- Starlight Festival Planter
            [17740141] = 17740141,  -- Starlight Festival Planter
            [17740143] = 17740143,  -- Starlight Festival Planter
            [17740149] = 17740149,  -- Starlight Festival Planter
            [17739880] = 17739880,  -- Event Moogle
        },
        DOLL_FESTIVAL_DECORATIONS = {
            [17739979] = 17739979,  -- Doll Festival Stage
            [17739980] = 17739980,  -- Doll Festival Umbrella and Stand
            [17739981] = 17739981,  -- Doll Festival Umbrella and Stand
            [17739982] = 17739982,  -- Doll Festival Umbrella and Stand
            [17739983] = 17739983,  -- Doll Festival Umbrella and Stand
            [17739984] = 17739984,  -- Doll Festival Cherry Blossom
            [17739985] = 17739985,  -- Doll Festival Cherry Blossom
            [17739986] = 17739986,  -- Doll Festival Cherry Blossom
            [17739987] = 17739987,  -- Doll Festival Cherry Blossom
            [17739988] = 17739988,  -- Doll Festival Cherry Blossom
            [17739989] = 17739989,  -- Doll Festival Cherry Blossom
            [17739990] = 17739990,  -- Doll Festival Cherry Blossom
            [17739991] = 17739991,  -- Doll Festival Cherry Blossom
            [17739992] = 17739992,  -- Doll Festival Cherry Blossom
            [17739993] = 17739993,  -- Doll Festival Cherry Blossom
            [17739994] = 17739994,  -- Doll Festival Cherry Blossom
            [17739995] = 17739995,  -- Doll Festival Cherry Blossom
            [17739996] = 17739996,  -- Doll Festival Cherry Blossom
            [17739997] = 17739997,  -- Doll Festival Cherry Blossom
            [17739998] = 17739998,  -- Doll Festival Cherry Blossom
            [17739999] = 17739999,  -- Doll Festival Cherry Blossom
            [17740000] = 17740000,  -- Doll Festival Cherry Blossom Petals
            [17740001] = 17740001,  -- Doll Festival Cherry Blossom Petals
            [17740002] = 17740002,  -- Doll Festival Cherry Blossom Petals
            [17740003] = 17740003,  -- Doll Festival Cherry Blossom Petals
            [17740004] = 17740004,  -- Doll Festival Cherry Blossom Petals
            [17740005] = 17740005,  -- Doll Festival Cherry Blossom Petals
            [17740006] = 17740006,  -- Doll Festival Cherry Blossom Petals
        },
        SUNBREEZE_FESTIVAL_DECORATIONS = {
            [17740035] = 17740035,  -- Sunbreeze Festival Dancer
            [17740036] = 17740036,  -- Sunbreeze Festival Dancer
            [17740037] = 17740037,  -- Sunbreeze Festival Dancer
            [17740038] = 17740038,  -- Sunbreeze Festival Dancer
            [17740039] = 17740039,  -- Sunbreeze Festival Dancer
            [17740040] = 17740040,  -- Sunbreeze Festival Dancer
            [17740041] = 17740041,  -- Sunbreeze Festival Dancer
            [17740042] = 17740042,  -- Sunbreeze Festival Dancer
            [17740043] = 17740043,  -- Sunbreeze Festival Dancer
            [17740044] = 17740044,  -- Sunbreeze Festival Dancer
            [17740045] = 17740045,  -- Sunbreeze Festival Dancer
            [17740046] = 17740046,  -- Sunbreeze Festival Dancer
            [17740047] = 17740047,  -- Sunbreeze Festival Dancer
            [17740048] = 17740048,  -- Sunbreeze Festival Dancer
            [17740049] = 17740049,  -- Sunbreeze Festival Dancer
            [17740050] = 17740050,  -- Sunbreeze Festival Dancer
            [17740051] = 17740051,  -- Sunbreeze Festival Main Fountain
            [17740052] = 17740052,  -- Sunbreeze Festival Planter
            [17740053] = 17740053,  -- Sunbreeze Festival Planter
            [17740054] = 17740054,  -- Sunbreeze Festival Planter
            [17740055] = 17740055,  -- Sunbreeze Festival Planter
            [17740056] = 17740056,  -- Sunbreeze Festival Planter
            [17740057] = 17740057,  -- Sunbreeze Festival Planter
            [17740058] = 17740058,  -- Sunbreeze Festival Planter
            [17740059] = 17740059,  -- Sunbreeze Festival Planter
            [17740060] = 17740060,  -- Sunbreeze Festival Planter
            [17740061] = 17740061,  -- Sunbreeze Festival Planter
            [17740062] = 17740062,  -- Sunbreeze Festival Planter
            [17740063] = 17740063,  -- Sunbreeze Festival Planter
            [17740064] = 17740064,  -- Sunbreeze Festival Planter
            [17740065] = 17740065,  -- Sunbreeze Festival Planter
            [17740066] = 17740066,  -- Sunbreeze Festival Planter
            [17740067] = 17740067,  -- Sunbreeze Festival Planter
            [17740068] = 17740068,  -- Sunbreeze Festival Planter
            [17740069] = 17740069,  -- Sunbreeze Festival Planter
            [17740070] = 17740070,  -- Sunbreeze Festival Planter
            [17740071] = 17740071,  -- Sunbreeze Festival Planter
            [17740072] = 17740072,  -- Sunbreeze Festival Planter
            [17740073] = 17740073,  -- Sunbreeze Festival Planter
            [17740090] = 17740090,  -- Sunbreeze Festival Fireworks
            [17740091] = 17740091,  -- Sunbreeze Festival Fireworks
        },
        NEW_YEARS_DECORATIONS = {
            [17740015] = 17740015,  -- New Years Standing Tree
            [17740025] = 17740025,  -- New Years Standing Tree
            [17740026] = 17740026,  -- New Years Standing Tree
            [17740027] = 17740027,  -- New Years Standing Tree
            [17740028] = 17740028,  -- New Years Standing Tree
            [17740029] = 17740029,  -- New Years Standing Tree
            [17740030] = 17740030,  -- New Years Standing Tree
            [17739966] = 17739966,  -- New Years Planter
            [17739967] = 17739967,  -- New Years Planter
            [17739968] = 17739968,  -- New Years Planter
            [17739969] = 17739969,  -- New Years Planter
            [17739970] = 17739970,  -- New Years Planter
            [17739971] = 17739971,  -- New Years Planter
        },
    },
}

return zones[tpz.zone.BASTOK_MARKETS]
