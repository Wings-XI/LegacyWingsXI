-----------------------------------
-- Area: Windurst_Woods
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WINDURST_WOODS] =
{
    text =
    {
        CONQUEST_BASE                = 0,    -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED      = 6541, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                = 6547, -- Obtained: <item>.
        GIL_OBTAINED                 = 6548, -- Obtained <number> gil.
        KEYITEM_OBTAINED             = 6550, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                 = 6551, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL          = 6552, -- You do not have enough gil.
        YOU_MUST_WAIT_ANOTHER_N_DAYS = 6583, -- You must wait another ≺number≻ [day/days] to perform that action.
        CARRIED_OVER_POINTS          = 6586, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY      = 6587, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                 = 6588, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST            = 6610, -- You learned Trust: <name>!
        HOMEPOINT_SET                = 6638, -- Home point set!
        YOU_ACCEPT_THE_MISSION       = 6731, -- You have accepted the mission.
        PEW_SAHBARAEF_DIALOG         = 6827, -- We can deliver goods to your residence or to the residences of your friends.
        ITEM_DELIVERY_DIALOG         = 6827, -- We can deliver goods to your residence or to the residences of your friends.
        JU_KAMJA_DIALOG              = 6827, -- We can deliver goods to your residence or to the residences of your friends.
        MOG_LOCKER_OFFSET            = 6998, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        FISHING_MESSAGE_OFFSET       = 7096, -- You can't fish here.
        IMAGE_SUPPORT                = 7200, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT     = 7214, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT           = 7222, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE          = 7229, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED                  = 7234, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP           = 7235, -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN           = 7251, -- You have successfully renounced your status as a ≺Multiple Choice (Parameter 5)≻[craftsman/artisan/adept] of the ≺Multiple Choice (Parameter 1)≻[Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        VALERIANO_SHOP_DIALOG        = 7545, -- Halfling philosophers and heroine beauties, welcome to the Troupe Valeriano show! And how gorgeous and green this fair town is!
        RAKOHBUUMA_OPEN_DIALOG       = 7642, -- To expel those who would subvert the law and order of Windurst Woods... To protect the Mithra populace from all manner of threats and dangers... That is the job of us guards.
        RETTO_MARUTTO_DIALOG         = 7958, -- Allo-allo! If you're after boneworking materials, then make sure you buy them herey in Windurst! We're the cheapest in the whole wide worldy!
        SHIH_TAYUUN_DIALOG           = 7960, -- Oh, that Retto-Marutto... If he keeps carrying on while speaking to the customers, he'll get in trouble with the guildmaster again!
        KUZAH_HPIROHPON_DIALOG       = 7969, -- Sew...I mean...So, want to get your paws on the top-quality materials as used in the Weaverrrs' Guild?
        MERIRI_DIALOG                = 7971, -- If you're interested in buying some works of art from our Weavers' Guild, then you've come to the right placey-wacey.
        PERIH_VASHAI_DIALOG          = 8257, -- You can now become a ranger!
        QUESSE_SHOP_DIALOG           = 8511, -- Welcome to the Windurst Chocobo Stables.
        MONONCHAA_SHOP_DIALOG        = 8512, -- Huh...? If you be wanting anything therrre, [mister/missy], then hurry up and decide, then get the heck out of herrre!
        MANYNY_SHOP_DIALOG           = 8513, -- Are you in urgent needy-weedy of anything? I have a variety of thingy-wingies you may be interested in.
        WIJETIREN_SHOP_DIALOG        = 8518, -- From humble Mithran cold medicines to the legendary Windurstian ambrrrosia of immortality, we have it all...
        NHOBI_ZALKIA_OPEN_DIALOG     = 8521, -- Psst... Interested in some rrreal hot property? From lucky chocobo digs to bargain goods that fell off the back of an airship...all my stuff is a rrreal steal!
        NHOBI_ZALKIA_CLOSED_DIALOG   = 8522, -- You're interested in some cheap shopping, rrright? I'm real sorry. I'm not doing business rrright now.
        NYALABICCIO_OPEN_DIALOG      = 8523, -- Ladies and gentlemen, kittens and cubs! Do we have the sale that you've been waiting forrr!
        NYALABICCIO_CLOSED_DIALOG    = 8524, -- Sorry, but our shop is closed rrright now. Why don't you go to Gustaberg and help the situation out therrre?
        BIN_STEJIHNA_OPEN_DIALOG     = 8525, -- Why don't you buy something from me? You won't regrrret it! I've got all sorts of goods from the Zulkheim region!
        BIN_STEJIHNA_CLOSED_DIALOG   = 8526, -- I'm taking a brrreak from  the saleswoman gig to give dirrrections.  So...through this arrrch is the residential  area.
        TARAIHIPERUNHI_OPEN_DIALOG   = 8527, -- Ooh...do I have some great merchandise for you! Man...these are once-in-a-lifetime offers, so get them while you can.
        TARAIHIPERUNHI_CLOSED_DIALOG = 8528, -- <pant> I am but a poor  merchant. Mate, but you just wait! Strife...one day I'll live the high life. Hey, that's my dream, anyway...
        CATALIA_DIALOG               = 8559, -- While we cannot break our promise to the Windurstians, to ensure justice is served, we would secretly like you to take two shields off of the Yagudo who you meet en route.
        FORINE_DIALOG                = 8560, -- Act according to our convictions while fulfilling our promise with the Tarutaru. This is indeed a fitting course for us, the people of glorious San d'Oria.
        CONQUEST                     = 8928, -- You've earned conquest points!
        APURURU_DIALOG               = 9491, -- There's no way Semih Lafihna will just hand it over for no good reason. Maybe if you try talking with Kupipi...
        EMPYREAL_ARROW_LEARNED       = 9725, -- You have learned the weapon skill Empyreal Arrow!
        TRICK_OR_TREAT               = 9736, -- Trick or treat...
        THANK_YOU_TREAT              = 9737, -- Thank you... And now for your treat...
        HERE_TAKE_THIS               = 9738, -- Here, take this...
        IF_YOU_WEAR_THIS             = 9739, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                    = 9740, -- Thank you...
        NOKKHI_BAD_COUNT             = 9758, -- What kinda smart-alecky baloney is this!? I told you to bring me the same kinda ammunition in complete sets. And don't forget the flowers, neither.
        NOKKHI_GOOD_TRADE            = 9760, -- And here you go! Come back soon, and bring your friends!
        NOKKHI_BAD_ITEM              = 9761, -- I'm real sorry, but there's nothing I can do with those.
        MILLEROVIEUNET_OPEN_DIALOG   = 9979, -- Please have a look at these wonderful products from Qufim Island! You won't regret it!
        MILLEROVIEUNET_CLOSED_DIALOG = 9980, -- Now that I've finally learned the language here, I'd like to start my own business. If I could only find a supplier...
        CLOUD_BAD_COUNT              = 10105, -- Well, don't just stand there like an idiot! I can't do any bundlin' until you fork over a set of 99 tools and <item>! And I ain't doin' no more than seven sets at one time, so don't even try it!
        CLOUD_GOOD_TRADE             = 10109, -- Here, take 'em and scram. And don't say I ain't never did nothin' for you!
        CLOUD_BAD_ITEM               = 10110, -- What the hell is this junk!? Why don't you try bringin' what I asked for before I shove one of my sandals up your...nose!
        CHOCOBO_DIALOG               = 10404, -- Kweh!
        TRRRADE_IN_SPARKS            = 13833, -- You want to trrrade in sparks, do you?
        NOT_ENOUGH_SPARKS            = 13853, -- You do not possess enough sparks of eminence to complete the transaction.
        LS_CONCIERGE_LISTING_CANCEL  = 14181, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_SAME_DAY        = 14185, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LS_CONCIERGE_REGISTERED1     = 14233, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2     = 14234, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED  = 14235, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU               = 9985, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS               = 9988, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN              = 9992, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN      = 9993, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1             = 10117, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2             = 13419, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3             = 13451, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4             = 13447, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5             = 13446, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6             = 13439, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK         = 13448, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED           = 10124, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG         = 13449, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM       = 13441, -- Here's a little something for your kindness.≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS ={

            [17764400] = 644, -- Meriri | Quadav
            [17764401] = 580, -- Kuzah Hpirohpon | Yagudo
            [17764462] = 368, -- Taraihi-Perunhi | Ghost
            [17764464] = 535, -- Nhobi Zalkia | Shade
            [17764465] = 612, -- Millerovieunet | Orc

        },
        HALLOWEEN_DECORATIONS = 
        {
            [17764742] = 17764742,  -- Halloween Decoration
            [17764743] = 17764743,  -- Halloween Decoration
            [17764744] = 17764744,  -- Halloween Decoration
        },
        EGG_HUNT_DECORATIONS = 
        {
            [17764686] = 17764686,  -- Egg Hunt Egg-stravaganza Pole
            [17764687] = 17764687,  -- Egg Hunt Egg-stravaganza Pole
            [17764688] = 17764688,  -- Egg Hunt Egg-stravaganza Pole
            [17764689] = 17764689,  -- Egg Hunt Egg-stravaganza Pole
        },
        STARLIGHT_DECORATIONS = 
        {
            [17764751] = 17764751,  -- Starlight Festival Center Tree
            [17764752] = 17764752,  -- Starlight Festival Tree
            [17764753] = 17764753,  -- Starlight Festival Tree
            [17764754] = 17764754,  -- Starlight Festival Tree
            [17764755] = 17764755,  -- Starlight Festival Tree
            [17764756] = 17764756,  -- Starlight Festival Tree
            [17764757] = 17764757,  -- Starlight Festival Tree
            [17764758] = 17764758,  -- Starlight Festival Tree
            [17764759] = 17764759,  -- Starlight Festival Tree
            [17764760] = 17764760,  -- Starlight Festival Tree
            [17764761] = 17764761,  -- Starlight Festival Tree
            [17764762] = 17764762,  -- Starlight Festival Tree
            [17764763] = 17764763,  -- Starlight Festival Tree
            [17764563] = 17764563,  -- Event Moogle
        },
        DOLL_FESTIVAL_DECORATIONS = 
        {
            [17764670] = 17764670,  -- Doll Festival Stage
            [17764671] = 17764671,  -- Doll Festival Umbrella and Stand
            [17764672] = 17764672,  -- Doll Festival Umbrella and Stand
            [17764673] = 17764673,  -- Doll Festival Umbrella and Stand
            [17764674] = 17764674,  -- Doll Festival Umbrella and Stand
            [17764675] = 17764675,  -- Doll Festival Cherry Blossom
            [17764676] = 17764676,  -- Doll Festival Cherry Blossom
            [17764677] = 17764677,  -- Doll Festival Cherry Blossom
            [17764678] = 17764678,  -- Doll Festival Cherry Blossom
            [17764679] = 17764679,  -- Doll Festival Cherry Blossom Petals
            [17764680] = 17764680,  -- Doll Festival Cherry Blossom Petals
            [17764681] = 17764681,  -- Doll Festival Cherry Blossom Petals
            [17764682] = 17764682,  -- Doll Festival Cherry Blossom Petals
            [17764683] = 17764683,  -- Doll Festival Cherry Blossom Petals
            [17764684] = 17764684,  -- Doll Festival Cherry Blossom Petals
        },
        SUNBREEZE_FESTIVAL_DECORATIONS = 
        {
            [17764707] = 17764707,  -- Sunbreeze Festival Dancer
            [17764708] = 17764708,  -- Sunbreeze Festival Dancer
            [17764709] = 17764709,  -- Sunbreeze Festival Dancer
            [17764710] = 17764710,  -- Sunbreeze Festival Dancer
            [17764711] = 17764711,  -- Sunbreeze Festival Center Tree
            [17764741] = 17764741,  -- Sunbreeze Festival Fireworks
	        [17764712] = 17764712,  -- Sunbreeze Festival Tree
            [17764713] = 17764713,  -- Sunbreeze Festival Tree
            [17764714] = 17764714,  -- Sunbreeze Festival Tree
            [17764715] = 17764715,  -- Sunbreeze Festival Tree
            [17764716] = 17764716,  -- Sunbreeze Festival Tree
            [17764717] = 17764717,  -- Sunbreeze Festival Tree
            [17764718] = 17764718,  -- Sunbreeze Festival Tree
            [17764719] = 17764719,  -- Sunbreeze Festival Tree
            [17764720] = 17764720,  -- Sunbreeze Festival Tree
            [17764721] = 17764721,  -- Sunbreeze Festival Tree
            [17764722] = 17764722,  -- Sunbreeze Festival Tree
            [17764723] = 17764723,  -- Sunbreeze Festival Tree
        },
        NEW_YEARS_DECORATIONS = 
        {
            [17764620] = 17764620,  -- New Year Festival Planter
            [17764621] = 17764621,  -- New Year Festival Planter
            [17764622] = 17764622,  -- New Year Festival Planter
            [17764623] = 17764623,  -- New Year Festival Planter
            [17764699] = 17764699,  -- New Years Standing Tree
            [17764700] = 17764700,  -- New Years Standing Tree
            [17764701] = 17764701,  -- New Years Standing Tree
            [17764702] = 17764702,  -- New Years Standing Tree
        },
        CIRCUS = 
        {
            [17764527] = 17764527, -- Mokop-Sankop
            [17764528] = 17764528, -- Cheh Raihah
            [17764525] = 17764525, -- Valeriano
            [17764529] = 17764529, -- Nalta
            [17764526] = 17764526, -- Dahjal
            [17764582] = 17764582, -- Ominous Cloud
            [17764581] = 17764581, -- Nokkhi Jinjahl
        },
    },
}

return zones[tpz.zone.WINDURST_WOODS]
