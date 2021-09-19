-----------------------------------
-- Area: Northern_San_dOria
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NORTHERN_SAN_DORIA] =
{
    text =
    {
        YOU_ACCEPT_THE_MISSION   = 5, -- You accept the mission.
        ORIGINAL_MISSION_OFFSET  = 16, -- Bring me one of those axes, and your mission will be a success. No running away now; we've a proud country to defend!
        HOMEPOINT_SET            = 188, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED  = 6590, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6596, -- Obtained: <item>.
        GIL_OBTAINED             = 6597, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6599, -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6600, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL      = 6601, -- You do not have enough gil.
        CARRIED_OVER_POINTS      = 6635, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 6636, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 6637, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        YOU_LEARNED_TRUST        = 6659, -- You learned Trust: <name>!
        CALL_MULTIPLE_ALTER_EGO  = 6660, -- You are now able to call multiple alter egos.
        MOG_LOCKER_OFFSET        = 6829, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        IMAGE_SUPPORT            = 6953, -- Your [fishing/woodworking/smithing/goldsmithing/clothcraft/leatherworking/bonecraft/alchemy/cooking] skills went up [a little/ever so slightly/ever so slightly].
        GUILD_TERMINATE_CONTRACT = 6967, -- You have terminated your trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild and formed a new one with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        GUILD_NEW_CONTRACT       = 6975, -- You have formed a new trading contract with the [Fishermen's/Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        NO_MORE_GP_ELIGIBLE      = 6982, -- You are not eligible to receive guild points at this time.
        GP_OBTAINED              = 6987, -- Obtained: <number> guild points.
        NOT_HAVE_ENOUGH_GP       = 6988, -- You do not have enough guild points.
        RENOUNCE_CRAFTSMAN       = 7004, -- You have successfully renounced your status as a ≺Multiple Choice (Parameter 5)≻[craftsman/artisan/adept] of the ≺Multiple Choice (Parameter 1)≻[Carpenters'/Blacksmiths'/Goldsmiths'/Weavers'/Tanners'/Boneworkers'/Alchemists'/Culinarians'] Guild.
        CONQUEST_BASE            = 7258, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7417, -- You can't fish here.
        REGIME_CANCELED          = 7973, -- Current training regime canceled.
        HUNT_ACCEPTED            = 7991, -- Hunt accepted!
        USE_SCYLDS               = 7992, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 8003, -- You record your hunt.
        OBTAIN_SCYLDS            = 8005, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 8009, -- Hunt canceled.
        FFR_GUILBERDRIER         = 11145, -- A magic shop, you say? A bit of magic would come in handy... I know! I'll have my daughter study it for me!
        ABIOLEGET_DIALOG         = 11221, -- All of Altana's children are welcome here.
        PELLIMIE_DIALOG          = 11222, -- Is this your first time here? Join us in prayer!
        FITTESEGAT_DIALOG        = 11223, -- Paradise is a place without fear, without death!
        MAURINE_DIALOG           = 11224, -- Papsque Shamonde sometimes addresses the city from the balcony, you know. I long for his blessing, if but once!
        PRERIVON_DIALOG          = 11225, -- With each sermon, I take another step closer to Paradise.
        MALFINE_DIALOG           = 11226, -- Truly fortunate are we that words of sacrament are read every day!
        COULLENE_DIALOG          = 11237, -- Goddess above, deliver us to Paradise!
        OLBERGIEUT_DIALOG        = 11269, -- Friar Faurbellant is on retreat at the Crag of Holla. Please give <item> to him.
        GUILERME_DIALOG          = 11341, -- Behold Chateau d'Oraguille, the greatest fortress in the realm!
        PHAVIANE_DIALOG          = 11345, -- This is Victory Arch. Beyond lies Southern San d'Oria.
        SOCHIENE_DIALOG          = 11346, -- You stand before Victory Arch. Southern San d'Oria is on the other side.
        PEPIGORT_DIALOG          = 11347, -- This gate leads to Port San d'Oria.
        RODAILLECE_DIALOG        = 11348, -- This is Ranperre Gate. Fiends lurk in the lands beyond, so take caution!
        GALAHAD_DIALOG           = 11361, -- Welcome to the Consulate of Jeuno. I am Galahad, Consul to San d'Oria.
        ISHWAR_DIALOG            = 11362, -- May I assist you?
        ARIENH_DIALOG            = 11363, -- If you have business with Consul Galahad, you'll find him inside.
        EMILIA_DIALOG            = 11364, -- Welcome to the Consulate of Jeuno.
        HELAKU_DIALOG            = 11393, -- Leave this building, and you'll see a great fortress to the right. That's Chateau d'Oraguille. And be polite; San d'Orians can be quite touchy.
        KASARORO_DIALOG          = 11432, -- Step right outside, and you'll see a big castle on the left. That's Chateau d'Oraguille. They're a little touchy in there, so mind your manners!
        PICKPOCKET_AUREGE        = 11461, -- A pickpocket, you say? Come to think of it, I did see a scoundrel skulking about...
        FESTIVE_MOOGLE_DIALOG    = 14188, -- Come one, come all, kupo!
        PICKPOCKET_GUILBERDRIER  = 11463, -- A pickpocket? No, can't say I've seen anyone like that. I'll keep an eye out, though.
        PICKPOCKET_PEPIGORT      = 11467, -- A pickpocket? Hey, I wonder if you mean that lady running helter-skelter over there just now...
        PICKPOCKET_GILIPESE      = 11468, -- A pickpocket? I did just see an undignified sort of woman just now. She was running toward Ranperre Gate.
        MAURINNE_DIALOG          = 11469, -- This part of town is so lively, I like watching everybody just go about their business.
        PICKPOCKET_MAURINNE      = 11470, -- A pickpocket?
        PICKPOCKET_RODAILLECE    = 11472, -- A pickpocket? Maybe it was that foul-mouthed woman just now. She called me a spoony bard! Unthinkable!
        AIVEDOIR_DIALOG          = 11503, -- That's funny. I could have sworn she asked me to meet her here...
        CAPIRIA_DIALOG           = 11504, -- He's late! I do hope he hasn't forgotten.
        BERTENONT_DIALOG         = 11505, -- Stars are more beautiful up close. Don't you agree?
        FLYER_REFUSED            = 11517, -- Your flyer is refused.
        GILIPESE_DIALOG          = 11526, -- Nothing to report!
        DOGGOMEHR_SHOP_DIALOG    = 11539, -- Welcome to the Blacksmiths' Guild shop.
        CAUZERISTE_SHOP_DIALOG   = 11607, -- Welcome! San d'Oria Carpenters' Guild shop, at your service.
        LUCRETIA_SHOP_DIALOG     = 11540, -- Blacksmiths' Guild shop, at your service!
        ANTONIAN_OPEN_DIALOG     = 11622, -- Interested in goods from Aragoneu?
        BONCORT_SHOP_DIALOG      = 11623, -- Welcome to the Phoenix Perch!
        PIRVIDIAUCE_SHOP_DIALOG  = 11624, -- Care to see what I have?
        PALGUEVION_OPEN_DIALOG   = 11625, -- I've got a shipment straight from Valdeaunia!
        VICHUEL_OPEN_DIALOG      = 11626, -- Fauregandi produce for sale!
        ARLENNE_SHOP_DIALOG      = 11627, -- Welcome to the Royal Armory!
        TAVOURINE_SHOP_DIALOG    = 11628, -- Looking for a weapon? We've got many in stock!
        JUSTI_SHOP_DIALOG        = 11630, -- Hello!
        ANTONIAN_CLOSED_DIALOG   = 11632, -- The Kingdom's influence is waning in Aragoneu. I cannot import goods from that region, though I long to.
        PALGUEVION_CLOSED_DIALOG = 11633, -- Would that Valdeaunia came again under San d'Orian dominion, I could then import its goods!
        VICHUEL_CLOSED_DIALOG    = 11634, -- I'd make a killing selling Fauregandi produce here, but that region's not under San d'Orian control!
        ATTARENA_CLOSED_DIALOG   = 11635, -- Once all of Li'Telor is back under San d'Orian influence, I'll fill my stock with unique goods from there!
        EUGBALLION_CLOSED_DIALOG = 11636, -- I'd be making a fortune selling goods from Qufim Island...if it were only under San d'Orian control!
        EUGBALLION_OPEN_DIALOG   = 11637, -- Have a look at these goods imported direct from Qufim Island!
        CHAUPIRE_SHOP_DIALOG     = 11638, -- San d'Orian woodcraft is the finest in the land!
        CONQUEST                 = 11704, -- You've earned conquest points!
        FFR_BONCORT              = 12051, -- Hmm... With magic, I could get hold of materials a mite easier. I'll have to check this mart out.
        FFR_CAPIRIA              = 12052, -- A flyer? For me? Some reading material would be a welcome change of pace, indeed!
        FFR_VILLION              = 12053, -- Opening a shop of magic, without consulting me first? I must pay this Regine a visit!
        FFR_COULLENE             = 12054, -- Magic could be of use on my journey to Paradise. Thank you so much!
        FLYER_ACCEPTED           = 12055, -- Your flyer is accepted!
        FLYER_ALREADY            = 12056, -- This person already has a flyer.
        MOGHOUSE_EXIT            = 12355, -- You have learned your way through the back alleys of San d'Oria! Now you can exit to any area from your residence.
        GAUDYLOX_SHOP_DIALOG     = 12615, -- <Phssshooooowoooo> You never see Goblinshhh from underworld? Me no bad. Me sell chipshhh. You buy. Use with shhhtone heart. You get lucky!
        MILLECHUCA_CLOSED_DIALOG = 12616, -- I've been trying to import goods from Vollbow, but it's so hard to get items from areas that aren't under San d'Orian control.
        ATTARENA_OPEN_DIALOG     = 12701, -- Good day! Take a look at my selection from Li'Telor!
        MILLECHUCA_OPEN_DIALOG   = 12702, -- Specialty goods from Vollbow! Specialty goods from Vollbow!
        SHIVA_UNLOCKED           = 12800, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        ARACHAGNON_SHOP_DIALOG   = 12904, -- Would you be interested in purchasing some adventurer-issue armor? Be careful when selecting, as we accept no refunds.
        TRICK_OR_TREAT           = 13047, -- Trick or treat...
        THANK_YOU_TREAT          = 13048, -- Thank you... And now for your treat...
        HERE_TAKE_THIS           = 13049, -- Here, take this...
        IF_YOU_WEAR_THIS         = 13050, -- If you put this on and walk around, something...unexpected might happen...
        THANK_YOU                = 13051, -- Thank you...
        FFR_LOOKS_CURIOUSLY_BASE = 13368, -- Coullene looks over curiously for a moment.
        GUILBERDRIER_MESSAGE     = 13369, -- Guilberdrier looks over curiously for a moment.
        BONCORT_MESSAGE          = 13370, -- Boncort looks over curiously for a moment.
        CAPIRIA_MESSAGE          = 13371, -- Capiria looks over curiously for a moment.
        VILLION_MESSAGE          = 13372, -- Villion looks over curiously for a moment.
        RETRIEVE_DIALOG_ID       = 18112, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 18444, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        -- Starlight Celebration Dialog -- 
        GIFT_THANK_YOU           = 13377, -- Thank you! Thank you! Thank you!
        ONLY_TWO_HANDS           = 13380, -- Another present? Sorry, but I only have two hands, (Player Gender)≻[Mr./Ms.] Adventurer!
        JOY_TO_CHILDREN          = 13384, -- You've brought joy to the children of Vana'diel!
        BARRELS_JOY_TO_CHILDREN  = 13385, -- You've brought barrelfuls of joy to the children of Vana'diel!
        STARLIGHT_CARD_1         = 13512, -- It's time once again for the Starlight Celebration!≺Prompt≻
        STARLIGHT_CARD_2         = 17787, -- Kupo ho ho! Merry Starlight! As with past celebrations, we've prepared a veritable mountain of presents for all adventurers, kupo.≺Prompt≻
        STARLIGHT_CARD_3         = 17795, -- We'd also appreciate your help in distributing cards, kupo. All you're required to do is deliver this card to the addressee. We're counting on you!≺Prompt≻
        STARLIGHT_CARD_4         = 17791, -- If you happen to forget who the card's recipient is, just show it to me, kupo.≺Prompt≻
        STARLIGHT_CARD_5         = 17790, -- You're truly a role model for all adventurers, kupo! Now then, we'd like you to take this card and give it to a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer.≺Prompt≻
        STARLIGHT_CARD_6         = 17783, -- Happy delivering, kupo!≺Prompt≻
        STARLIGHT_CARD_CHECK     = 17792, -- Let' see... This addressee of this card is a ≺Multiple Choice (Parameter 0)≻[male Hume/female Hume/male Elvaan/female Elvaan/male Tarutaru/female Tarutaru/Mithra/Galka] adventurer, kupo.≺Prompt≻
        STARLIGHT_CARD_RED       = 13519, -- Oh, I just remembered! I think that the cards are all addressed to people who are wearing red...≺Prompt≻
        STARLIGHT_CARD_WRONG     = 17793, -- Are you trying to pull a fast one, kupo!? This card isn't yours to give, nor is it addressed to you, so please take it back to where you found it.≺Prompt≻
        STARLIGHT_CARD_CONFIRM   = 17785, -- Here's a little something for your kindness.≺Prompt≻
        STARLIGHT_FAME_DIALOG    = 13536, -- ≺Multiple Choice (Parameter 1)≻[You haven't brought any happiness to the children!/You've done some good./You've done fairly well./You've made the children very happy!/You've brought lots of smiles!/You have the children bursting with glee!/The children love you!] ≺Multiple Choice (Parameter 1)≻[What a disappointment./You just need to give a little extra effort!/Keep it up!/You make a good smilebringer./Excellent work!/Stupendous job!/Even I think you're great!]≺Prompt≻
    },
    mob =
    {
    },
    npc =
    {
        HALLOWEEN_SKINS =
        {
            [17723487] = 368, -- Vichuel | Ghost
            [17723492] = 365, -- Antonian | Hound
            [17723497] = 612, -- Attarena | Orc
        },
        HALLOWEEN_DECORATIONS = {
            [17723774] = 17723774,  -- Halloween Decoration
            [17723775] = 17723775,  -- Halloween Decoration
            [17723776] = 17723776,  -- Halloween Decoration
            [17723777] = 17723777,  -- Halloween Decoration
            [17723812] = 17723812,  -- Event Moogle Stall
            [17723811] = 17723811,  -- Festive Moogle
        },
        HALLOWEEN_ROAMING = {
            [17723604] = 17723604,  -- Trick Shadow 
            [17723605] = 17723605,  -- Trick Specter 
            [17723606] = 17723606,  -- Trick Shade 
            [17723607] = 17723607,  -- Trick Ghost 
            [17723608] = 17723608,  -- Trick Spirit 
            [17723609] = 17723609,  -- Trick Phantom 
            [17723610] = 17723610,  -- Trick Skeleton
            [17723611] = 17723611,  -- Trick Wight 
            [17723612] = 17723612,  -- Trick Bones 
            [17723613] = 17723613,  -- Trick Ghast            
        },
        EGG_HUNT_DECORATIONS = {
            [17723703] = 17723703,  -- Egg Hunt Egg-stravaganza Pole
            [17723704] = 17723704,  -- Egg Hunt Egg-stravaganza Pole
            [17723705] = 17723705,  -- Egg Hunt Egg-stravaganza Pole
            [17723706] = 17723706,  -- Egg Hunt Egg-stravaganza Pole
        },
        STARLIGHT_DECORATIONS = {
            [17723785] = 17723785,  -- Starlight Banner
            [17723786] = 17723786,  -- Starlight Tree
            [17723787] = 17723787,  -- Starlight Banner
            [17723788] = 17723788,  -- Starlight Tree
            [17723789] = 17723789,  -- Starlight Tree
            [17723790] = 17723790,  -- Starlight Tree
            [17723791] = 17723791,  -- Starlight Tree
            [17723792] = 17723792,  -- Starlight Tree
            [17723793] = 17723793,  -- Starlight Tree
            [17723794] = 17723794,  -- Starlight Tree
            [17723795] = 17723795,  -- Starlight Tree
            [17723796] = 17723796,  -- Starlight Tree
            [17723797] = 17723797,  -- Starlight Tree
            [17723798] = 17723798,  -- Starlight Tree
            [17723799] = 17723799,  -- Starlight Tree
            [17723800] = 17723800,  -- Starlight Tree
            [17723801] = 17723801,  -- Starlight Tree
            [17723802] = 17723802,  -- Starlight Tree
            [17723803] = 17723803,  -- Starlight Tree
            [17723804] = 17723804,  -- Starlight Tree
            [17723805] = 17723805,  -- Starlight Tree
            [17723812] = 17723812,  -- Event Moogle Stall
            [17723811] = 17723811,  -- Festive Moogle
            [17723784] = 17723784,  -- Charmealaut
            [17723557] = 17723557,  -- Event Moogle
        },
        DOLL_FESTIVAL_DECORATIONS = {
            [17723681] = 17723681,  -- Doll Festival Stage
            [17723682] = 17723682,  -- Doll Festival Umbrella and Stand
            [17723683] = 17723683,  -- Doll Festival Umbrella and Stand
            [17723684] = 17723684,  -- Doll Festival Umbrella and Stand
            [17723685] = 17723685,  -- Doll Festival Cherry Blossom
            [17723686] = 17723686,  -- Doll Festival Cherry Blossom
            [17723687] = 17723687,  -- Doll Festival Cherry Blossom
            [17723688] = 17723688,  -- Doll Festival Cherry Blossom
            [17723689] = 17723689,  -- Doll Festival Cherry Blossom
            [17723690] = 17723690,  -- Doll Festival Cherry Blossom
	        [17723691] = 17723691,  -- Doll Festival Cherry Blossom Petals
            [17723692] = 17723692,  -- Doll Festival Cherry Blossom Petals
            [17723693] = 17723693,  -- Doll Festival Cherry Blossom Petals
            [17723694] = 17723694,  -- Doll Festival Cherry Blossom Petals
            [17723695] = 17723695,  -- Doll Festival Cherry Blossom Petals
            [17723696] = 17723696,  -- Doll Festival Cherry Blossom Petals
            [17723697] = 17723697,  -- Doll Festival Cherry Blossom Petals
            [17723698] = 17723698,  -- Doll Festival Cherry Blossom Petals
            [17723699] = 17723699,  -- Doll Festival Cherry Blossom Petals
            [17723700] = 17723700,  -- Doll Festival Cherry Blossom Petals
        },
        SUNBREEZE_FESTIVAL_DECORATIONS = {
            [17723724] = 17723724,  -- Sunbreeze Festival Dancer
            [17723725] = 17723725,  -- Sunbreeze Festival Dancer
            [17723726] = 17723726,  -- Sunbreeze Festival Dancer
            [17723727] = 17723727,  -- Sunbreeze Festival Dancer
            [17723728] = 17723728,  -- Sunbreeze Festival Dancer
            [17723729] = 17723729,  -- Sunbreeze Festival Dancer
            [17723730] = 17723730,  -- Sunbreeze Festival Dancer
            [17723731] = 17723731,  -- Sunbreeze Festival Dancer
            [17723732] = 17723732,  -- Sunbreeze Festival Ribbon
            [17723733] = 17723733,  -- Sunbreeze Festival Ribbon
            [17723734] = 17723734,  -- Sunbreeze Festival Ribbon
            [17723735] = 17723735,  -- Sunbreeze Festival Tree
            [17723736] = 17723736,  -- Sunbreeze Festival Tree
            [17723737] = 17723737,  -- Sunbreeze Festival Tree
            [17723738] = 17723738,  -- Sunbreeze Festival Tree
            [17723739] = 17723739,  -- Sunbreeze Festival Tree
            [17723740] = 17723740,  -- Sunbreeze Festival Tree
            [17723741] = 17723741,  -- Sunbreeze Festival Tree
            [17723742] = 17723742,  -- Sunbreeze Festival Tree
            [17723743] = 17723743,  -- Sunbreeze Festival Tree
            [17723744] = 17723744,  -- Sunbreeze Festival Tree
            [17723745] = 17723745,  -- Sunbreeze Festival Tree
            [17723746] = 17723746,  -- Sunbreeze Festival Tree
            [17723747] = 17723747,  -- Sunbreeze Festival Tree
            [17723748] = 17723748,  -- Sunbreeze Festival Tree
            [17723749] = 17723749,  -- Sunbreeze Festival Tree
            [17723750] = 17723750,  -- Sunbreeze Festival Tree
            [17723751] = 17723751,  -- Sunbreeze Festival Tree
            [17723752] = 17723752,  -- Sunbreeze Festival Tree
            [17723770] = 17723770,  -- Sunbreeze Festival Fireworks
        },
        NEW_YEARS_DECORATIONS = {
            [17723716] = 17723716,  -- New Years Standing Tree
            [17723717] = 17723717,  -- New Years Standing Tree
            [17723718] = 17723718,  -- New Years Standing Tree
            [17723719] = 17723719,  -- New Years Standing Tree
        },
        EXPLORER_MOOGLE = 17723648,
    },
}

return zones[tpz.zone.NORTHERN_SAN_DORIA]
