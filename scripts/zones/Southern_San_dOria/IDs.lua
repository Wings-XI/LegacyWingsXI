-----------------------------------
-- Area: Southern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SOUTHERN_SAN_DORIA] =
{
    text =
    {
        HOMEPOINT_SET                  = 24, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED        = 6426, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6430, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6432, -- Obtained: <item>.
        GIL_OBTAINED                   = 6433, -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6435, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6436, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL            = 6437, -- You do not have enough gil.
        NOTHING_OUT_OF_ORDINARY        = 6446, -- There is nothing out of the ordinary here.
        YOU_MUST_WAIT_ANOTHER_N_DAYS   = 6463, -- You must wait another ≺number≻ [day/days] to perform that action.
        CARRIED_OVER_POINTS            = 6466, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 6477, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 6468, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST              = 6495, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO        = 6496, -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET              = 6673, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        LEATHER_SUPPORT                = 6775, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT       = 6789, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT             = 6797, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE            = 6804, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                    = 6809, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP             = 6810, -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN             = 6826, -- You have successfully renounced your status as a ≺Multiple Choice (Parameter 5)≻[craftsman/artisan/adept] of the ≺Multiple Choice (Parameter 1)≻[Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE                  = 7032, -- Tallying conquest results...
        YOU_ACCEPT_THE_MISSION         = 7196, -- You accept the mission.
        ORIGINAL_MISSION_OFFSET        = 7207, -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        TRICK_OR_TREAT                 = 7355, -- Trick or treat...
        THANK_YOU_TREAT                = 7356, -- Thank you... And now for your treat...
        HERE_TAKE_THIS                 = 7357, -- Here, take this...
        IF_YOU_WEAR_THIS               = 7358, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                      = 7359, -- Thank you...
        NOKKHI_BAD_COUNT               = 7377, -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE              = 7379, -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM                = 7380, -- I'm real sorry, but there's nothing I can do with those.
        CONNECTING_WITH_THE_SERVER     = 7406, -- Connecting with the server. Please wait.
        UNABLE_TO_CONNECT              = 7407, -- Unable to connect
        ANOTHER_GROUP                  = 7409, -- Another group of players is currently occupying [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].
        INFORMATION_RECORDED           = 7410,
        YOU_CANNOT_ENTER_DYNAMIS       = 7414, -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7416, -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7426, -- There is an unusual arrangement of branches here.
        VARCHET_BET_LOST               = 7757, -- You lose your bet of 5 gil.
        VARCHET_KEEP_PROMISE           = 7766, -- As promised, I shall go and see about those woodchippers. Maybe we can play another game later.
        FFR_ROSEL                      = 7786, -- Hrmm... Now, this is interesting! It pays to keep an eye on the competition. Thanks for letting me know!
        LUSIANE_SHOP_DIALOG            = 7960, -- Hello! Let Taumila's handle all your sundry needs!
        OSTALIE_SHOP_DIALOG            = 7961, -- Welcome, customer. Please have a look.
        ASH_THADI_ENE_SHOP_DIALOG      = 7982, -- Welcome to Helbort's Blades!
        UNLOCK_PALADIN                 = 8009, -- You can now become a paladin!
        FFR_BLENDARE                   = 8093, -- Wait! If I had magic, maybe I could keep my brother's hands off my sweets...
        RAMINEL_DELIVERY               = 8097, -- Here's your delivery!
        RAMINEL_DELIVERIES             = 8099, -- Sorry, I have deliveries to make!
        SHILAH_SHOP_DIALOG             = 8114, -- Welcome, weary traveler. Make yourself at home!
        VALERIANO_SHOP_DIALOG          = 8132, -- Oh, a fellow outsider! We are Troupe Valeriano. I am Valeriano, at your service!
        FERDOULEMIONT_SHOP_DIALOG      = 8148, -- Hello!
        FLYER_REFUSED                  = 8180, -- Your flyer is refused.
        CLETAE_DIALOG                  = 8200, -- Why, hello. All our skins are guild-approved.
        KUEH_IGUNAHMORI_DIALOG         = 8201, -- Good day! We have lots in stock today.
        PAUNELIE_DIALOG                = 8309, -- I'm sorry, can I help you?
        PAUNELIE_SHOP_DIALOG           = 8314, -- These magic shells are full of mysteries...
        ITEM_DELIVERY_DIALOG           = 8409, -- Parcels delivered to rooms anywhere in Vana'diel!
        MACHIELLE_OPEN_DIALOG          = 8415, -- Might I interest you in produce from Norvallen?
        CORUA_OPEN_DIALOG              = 8416, -- Ronfaure produce for sale!
        PHAMELISE_OPEN_DIALOG          = 8417, -- I've got fresh produce from Zulkheim!
        APAIREMANT_OPEN_DIALOG         = 8418, -- Might you be interested in produce from Gustaberg
        AVELINE_SHOP_DIALOG            = 8419, -- Welcome to Raimbroy's Grocery!
        MIOGIQUE_SHOP_DIALOG           = 8420, -- Looking for something in particular?
        BENAIGE_SHOP_DIALOG            = 8420, -- Looking for something in particular?
        CARAUTIA_SHOP_DIALOG           = 8421, -- Well, what sort of armor would you like?
        MACHIELLE_CLOSED_DIALOG        = 8422, -- We want to sell produce from Norvallen, but the entire region is under foreign control!
        CORUA_CLOSED_DIALOG            = 8423, -- We specialize in Ronfaure produce, but we cannot import from that region without a strong San d'Orian presence there.
        PHAMELISE_CLOSED_DIALOG        = 8424, -- I'd be making a killing selling produce from Zulkheim, but the region's under foreign control!
        APAIREMANT_CLOSED_DIALOG       = 8425, -- I'd love to import produce from Gustaberg, but the foreign powers in control there make me feel unsafe!
        POURETTE_OPEN_DIALOG           = 8426, -- Derfland produce for sale!
        POURETTE_CLOSED_DIALOG         = 8427, -- Listen, adventurer... I can't import from Derfland until the region knows San d'Orian power!
        CONQUEST                       = 8484, -- You've earned conquest points!
        FLYER_ACCEPTED                 = 8829, -- The flyer is accepted.
        FLYER_ALREADY                  = 8830, -- This person already has a flyer.
        FFR_LOOKS_CURIOUSLY_BASE       = 8831, -- Blendare looks over curiously for a moment.
        ROSEL_MESSAGE                  = 8832, -- Rosel looks over curiously for a moment.
        FFR_MAUGIE                     = 8833, -- A magic shop, eh? Hmm... A little magic could go a long way for making a leisurely retirement! Ho ho ho!
        MAUGIE_MESSAGE                 = 8834, -- Maugie looks over curiously for a moment.
        FFR_ADAUNEL                    = 8835, -- A magic shop? Maybe I'll check it out one of these days. Could help with my work, even...
        ADAUNEL_MESSAGE                = 8836, -- Adaunel looks over curiously for a moment.
        FFR_LEUVERET                   = 8837, -- A magic shop? That'd be a fine place to peddle my wares. I smell a profit! I'll be up to my gills in gil, I will!
        LEUVERET_MESSAGE               = 8838, -- Leuveret looks over curiously for a moment.
        LUSIANE_THANK                  = 8880, -- Thank you! My snoring will express gratitude mere words cannot! Here's something for you in return.
        IMPULSE_DRIVE_LEARNED          = 9317, -- You have learned the weapon skill Impulse Drive!
        CLOUD_BAD_COUNT                = 10105, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE               = 10109, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM                 = 10110, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CAPUCINE_SHOP_DIALOG           = 10311, -- Hello! You seem to be working very hard. I'm really thankful! But you needn't rush around so fast. Take your time! I can wait if it makes the job easier for you!
        TUTORIAL_NPC                   = 13517, -- Greetings and well met! Guardian of the Kingdom, Alaune, at your most humble service.
        YOU_WISH_TO_EXCHANGE_SPARKS    = 15362, -- You wish to exchange your sparks?
        NOT_ENOUGH_SPARKS              = 15392, -- You do not possess enough sparks of eminence to complete the transaction.
        LS_CONCIERGE_LISTING_CANCEL    = 15693, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_SAME_DAY          = 15697, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LS_CONCIERGE_REGISTERED1       = 15745, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2       = 15746, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED    = 15747, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
        TEAR_IN_FABRIC_OF_SPACE        = 16547, -- There appears to be a tear in the fabric of space...
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU                 = 9833, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS                 = 9836, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN                = 9840, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN        = 9841, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1               = 10141, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2               = 13732, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3               = 13762, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4               = 13758, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5               = 13757, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6               = 13742, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK           = 13759, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED             = 10148, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG           = 13760, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM         = 13748, -- Here's a little something for your kindness.≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17719303] = 580, -- Machielle | Yagudo
            [17719304] = 564, -- Corua | Skeleton
            [17719305] = 368, -- Phamelise | Ghost
            [17719306] = 531, -- Apairemant | Dark Stalker
            [17719493] = 612, -- Pourette | Orc
        },
        HALLOWEEN_DECORATIONS = 
        {
            [17719784] = 17719784,  -- Halloween Decoration
            [17719785] = 17719785,  -- Halloween Decoration
            [17719786] = 17719786,  -- Halloween Decoration 
        },
        EGG_HUNT_DECORATIONS = 
        {
            [17719708] = 17719708,  -- Egg Hunt Egg-stravaganza Standing Tree
            [17719709] = 17719709,  -- Egg Hunt Egg-stravaganza Standing Tree
            [17719710] = 17719710,  -- Egg Hunt Egg-stravaganza Pole
            [17719711] = 17719711,  -- Egg Hunt Egg-stravaganza Pole
            [17719712] = 17719712,  -- Egg Hunt Egg-stravaganza Pole
            [17719713] = 17719713,  -- Egg Hunt Egg-stravaganza Pole
        },
        STARLIGHT_DECORATIONS = 
        {
            [17719795] = 17719795,  -- Starlight Festival Tree
            [17719796] = 17719796,  -- Starlight Festival Tree
            [17719797] = 17719797,  -- Starlight Festival Tree
            [17719798] = 17719798,  -- Starlight Festival Tree
            [17719799] = 17719799,  -- Starlight Festival Tree
            [17719800] = 17719800,  -- Starlight Festival Tree
            [17719801] = 17719801,  -- Starlight Festival Tree
            [17719802] = 17719802,  -- Starlight Festival Tree
            [17719803] = 17719803,  -- Starlight Festival Tree
            [17719804] = 17719804,  -- Starlight Festival Tree
            [17719805] = 17719805,  -- Starlight Festival Tree
            [17719806] = 17719806,  -- Starlight Festival Tree
            [17719807] = 17719807,  -- Starlight Festival Tree
            [17719808] = 17719808,  -- Starlight Festival Tree
            [17719809] = 17719809,  -- Starlight Festival Tree
            [17719810] = 17719810,  -- Starlight Festival Tree
            [17719811] = 17719811,  -- Starlight Festival Tree
            [17719812] = 17719812,  -- Starlight Festival Tree
            [17719813] = 17719813,  -- Starlight Festival Tree
            [17719814] = 17719814,  -- Starlight Festival Tree
            [17719815] = 17719815,  -- Starlight Festival Tree
            [17719816] = 17719816,  -- Starlight Festival Tree
            [17719817] = 17719817,  -- Starlight Festival Tree
            [17719818] = 17719818,  -- Starlight Festival Tree
            [17719819] = 17719819,  -- Starlight Festival Tree
            [17719820] = 17719820,  -- Starlight Festival Tree
            [17719821] = 17719821,  -- Starlight Festival Tree
            [17719822] = 17719822,  -- Starlight Festival Tree
            [17719823] = 17719823,  -- Starlight Festival Tree
            [17719824] = 17719824,  -- Starlight Festival Tree
            [17719825] = 17719825,  -- Starlight Festival Tree
            [17719478] = 17719478,  -- Event Moogle
        },
        DOLL_FESTIVAL_DECORATIONS = 
        {
            [17719702] = 17719702,  -- Doll Festival Stage
            [17719703] = 17719703,  -- Doll Festival Umbrella and Stand
            [17719704] = 17719704,  -- Doll Festival Umbrella and Stand
            [17719705] = 17719705,  -- Doll Festival Umbrella and Stand
        },
        SUNBREEZE_FESTIVAL_DECORATIONS = 
        {
            [17719783] = 17719783,  -- Sunbreeze Festival Fireworks
	        [17719729] = 17719729,  -- Sunbreeze Festival Tree
            [17719730] = 17719730,  -- Sunbreeze Festival Tree
            [17719731] = 17719731,  -- Sunbreeze Festival Tree
            [17719732] = 17719732,  -- Sunbreeze Festival Tree
            [17719733] = 17719733,  -- Sunbreeze Festival Tree
            [17719734] = 17719734,  -- Sunbreeze Festival Tree
            [17719735] = 17719735,  -- Sunbreeze Festival Tree
            [17719736] = 17719736,  -- Sunbreeze Festival Tree
            [17719737] = 17719737,  -- Sunbreeze Festival Tree
            [17719738] = 17719738,  -- Sunbreeze Festival Tree
            [17719739] = 17719739,  -- Sunbreeze Festival Tree
            [17719740] = 17719740,  -- Sunbreeze Festival Tree
            [17719741] = 17719741,  -- Sunbreeze Festival Tree
            [17719742] = 17719742,  -- Sunbreeze Festival Tree
            [17719743] = 17719743,  -- Sunbreeze Festival Tree
            [17719744] = 17719744,  -- Sunbreeze Festival Tree
            [17719745] = 17719745,  -- Sunbreeze Festival Tree
            [17719746] = 17719746,  -- Sunbreeze Festival Tree
            [17719747] = 17719747,  -- Sunbreeze Festival Tree
            [17719748] = 17719748,  -- Sunbreeze Festival Tree
            [17719749] = 17719749,  -- Sunbreeze Festival Tree
            [17719750] = 17719750,  -- Sunbreeze Festival Tree
            [17719751] = 17719751,  -- Sunbreeze Festival Tree
            [17719752] = 17719752,  -- Sunbreeze Festival Tree
            [17719753] = 17719753,  -- Sunbreeze Festival Tree
            [17719754] = 17719754,  -- Sunbreeze Festival Tree
            [17719759] = 17719759,  -- Sunbreeze Festival Tree
            [17719760] = 17719760,  -- Sunbreeze Festival Tree
        },
        NEW_YEARS_DECORATIONS = 
        {
            [17719653] = 17719653,  -- New Year Festival Planter
            [17719654] = 17719654,  -- New Year Festival Planter
            [17719655] = 17719655,  -- New Year Festival Planter
            [17719656] = 17719656,  -- New Year Festival Planter
            [17719724] = 17719724,  -- New Years Standing Tree
            [17719728] = 17719728,  -- New Years Standing Tree
        },
        CIRCUS = 
        {
            [17719426] = 17719426, -- Mokop-Sankop
            [17719427] = 17719427, -- Cheh Raihah
            [17719424] = 17719424, -- Valeriano
            [17719428] = 17719428, -- Nalta
            [17719425] = 17719425, -- Dahjal
            [17719535] = 17719535, -- Ominous Cloud
            [17719534] = 17719534, -- Nokkhi Jinjahl
        },
        LUSIANE  = 17719350,
        ARPETION = 17719409,
    },
}

return zones[tpz.zone.SOUTHERN_SAN_DORIA]
