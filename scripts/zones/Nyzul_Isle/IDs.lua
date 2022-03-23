-----------------------------------
-- Area: Nyzul_Isle
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NYZUL_ISLE] =
{
    text = {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6393, -- You do not have enough gil.
        ITEMS_OBTAINED                = 6397, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7049, -- Tallying conquest results...
        COMMENCING_ASSAULT            = 7293, -- Commencing <AssultID> -- Nyzul Isle is 51
        TIME_TO_COMPLETE              = 7303, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7304, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7308, -- Time remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7309, -- Time remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7311, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        OBJECTIVE_COMPLETE            = 7348, -- Floor <number> objective complete. Rune of Transfer activated.
        CERTIFICATION_REQUIRED        = 7350, -- The certification code for all party members is required to activate this lamp.  Your certification code has been registered
        CERTIFICATION_REGISTERED      = 7351, -- Your certification code has been registered.
        LAMP_ALREADY_ACTIVATED        = 7352, -- This lamp has already been activated.
        LAMP_SAME_TIME                = 7353, -- This lamp cannot be activated unless all other lamps are activated at the same time.
        LAMP_SOME_OTHER_ACTION        = 7354, -- All lamps on this floor are activated, but some other action appears to be necessary in order to activate the Rune of Transfer.
        LAMP_MUST_WAIT                = 7355, -- It appears you cannot activate this lamp for some time...
        LAMP_SPECIFIC_ORDER           = 7356, -- Apparently, this lamp must be activated in a specific order...
        LAMP_NOT_ALL_ACTIVATED        = 7357, -- Not all lights have been activated...
        ELIMINATE_ENEMY_LEADER        = 7361, -- Objective: Eliminate enemy leader
        ELIMINATE_SPECIFIED_ENEMIES   = 7362, -- Objective: Eliminate specified enemies
        ACTIVATE_ALL_LAMPS            = 7363, -- Objective: Activate all lamps
        ELIMINATE_SPECIFIED_ENEMY     = 7364, -- Objective: Eliminate specified enemy
        ELIMINATE_ALL_ENEMIES         = 7365, -- Objective: Eliminate all enemies
        AVOID_DISCOVERY_GEARS         = 7366, -- Avoid discovery by archaic gears
        DO_NOT_DESTROY_GEARS          = 7367, -- Do not destory gears
        TIME_REDUCED_BY_MINUTES       = 7368, -- <red> Time reduced by <number> minutes.
        SECURITY_FIELD_MALFUNCTION    = 7369, -- <red> Security field malfunction.
        POTENTIAL_TOKENS_REDUCED      = 7370, -- <red> Potential token reward reduced
        PLAYER_OBTAINS_TEMP_ITEM      = 7320, -- <Player> obtains temporary item: <item>
        PLAYER_OBTAINS_ITEM           = 7322, -- <Player> obtains <item>.
        TEMP_ITEM_OBTAINED            = 7344, -- Obtained temporary item: <item>.
        ALREADY_HAVE_TEMP             = 7345, -- You already have that temporary item.
        NEW_USER_CONFIRMED            = 7461, -- New user confirmed.  Issuing <keyitem>.
        INSUFFCIENT_TOKENS            = 7480, -- Insufficient tokens.
        OBTAIN_TOKENS                 = 7482, -- You obtain <number> tokens!
        RUNIC_DISC_PROGRESS_RECORDED  = 7483, -- Data up to and including Floor ≺Numeric Parameter 1≻ has been recorded on your <keyitem>
        TRANSFER_COMPLETE             = 7484, -- Transfer complete. Welcome to floor <floor>
        FORMATION_GELINCIK            = 7503, -- Formation Gelincik! Eliminate the intruders!
        SURRENDER                     = 7504, -- You would be wise to surrender. A fate worse than death awaits those who anger an Immortal...
        I_WILL_SINK_YOUR_CORPSES      = 7505, -- I will sink your corpses to the bottom of the Cyan Deep!
        AWAKEN                        = 7506, -- Awaken, powers of the Lamiae!
        MANIFEST                      = 7507, -- Manifest, powers of the Merrow!
        CURSED_ESSENCES               = 7508, -- Cursed essences of creatures devoured... Infuse my blood with your beastly might!
        UGH                           = 7509, -- Ugh...I should not be surprised... Even Rishfee praised your strength...
        CANNOT_WIN                    = 7510, -- Hehe...hehehe... You are...too strong for me... I cannot win...in this way...
        CANNOT_LET_YOU_PASS           = 7511, -- <Wheeze>... I cannot...let you...pass...
        WHEEZE                        = 7512, -- <Wheeze>...
        WHEEZE_PHSHOOO                = 7513, -- <Wheeze>...<phshooo>!
        PHSHOOO                       = 7514, -- <Phshooo>...
        NOT_POSSIBLE                  = 7515, -- <Phshooo>... Not...possible...
        ALRRRIGHTY                    = 7516, -- Alrrrighty! Let's get this show on the rrroad! I hope ya got deep pockets!
        CHA_CHING                     = 7517, -- Cha-ching! Thirty gold coins!
        TWELVE_GOLD_COINS             = 7518, -- Hehe! This one'll cost ya twelve gold coins a punch! The grrreat gouts of blood are frrree of charge!
        NINETY_NINE_SILVER_COINS      = 7519, -- Ninety-nine silver coins a pop! A bargain, I tell ya!
        THIS_BATTLE                   = 7520, -- This battle is rrreally draggin' on... Just think of the dry cleanin' bill!
        OW                            = 7521, -- Ow...! Ya do rrrealize the medical costs are comin' outta your salary, don't ya?
        ABQUHBAH                      = 7522, -- A-Abquhbah! D-don't even think about...rrraisin' the wages... Management...is a mean world...ugh...
        OH_ARE_WE_DONE                = 7523, -- Oh, are we done? I wasn't done rrrackin' up the fees... You've got more in ya, rrright?
        NOW_WERE_TALKIN               = 7524, -- Now we're talkin'! I can hear the clinkin' of coin mountains collapsin' over my desk... Let's get this over with!
        PRAY                          = 7525, -- Pray to whatever gods you serve.
        BEHOLD                        = 7526, -- Behold the power of my eldritch gaze!
        CARVE                         = 7527, -- I will carve the soul fresh from your bones.
        RESIST_MELEE                  = 7528, -- My flesh remembers the wounds of ten thousand blades. Come, cut me again...
        RESIST_MAGIC                  = 7529, -- My skin remembers the fires of ten thousand spells. Come, burn me again...
        RESIST_RANGE                  = 7530, -- My belly remembers the punctures of ten thousand arrows. Come, shoot me again...
        NOW_UNDERSTAND                = 7531, -- Hehehe... Do you now understand what it is to fight a true Immortal? Realize your futility and embrace despair...
        MIRACLE                       = 7532, -- Ugh... Has your god granted you the miracle you seek...?
        SHALL_BE_JUDGED               = 7534, -- I am...Alexander... The meek...shall be rewarded... The defiant...shall be judged...
        OFFER_THY_WORSHIP             = 7535, -- Offer thy worship... I shall burn away...thy transgressions...
        OPEN_THINE_EYES               = 7536, -- Open thine eyes... My radiance...shall guide thee...
        CEASE_THY_STRUGGLES           = 7537, -- Cease thy struggles... I am immutable...indestructible...impervious...immortal...
        RELEASE_THY_SELF              = 7538, -- Release thy self... My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul...
        BASK_IN_MY_GLORY              = 7539, -- Bask in my glory... Mine existence...stretches into infinity...
        REPENT_THY_IRREVERENCE        = 7540, -- Repent thy irreverence... The gate to salvation...lies before thee... Revelation...is within thy reach...
        ACCEPT_THY_DESTRUCTION        = 7541, -- Accept thy destruction... Wish for eternity...yearn for immortality... Sense thy transience...know thy insignificance...
        OMEGA_SPAM                    = 7542, -- OOOOOOO
        SHALL_KNOW_OBLIVION           = 7543, -- I am...Alexander... The fearful...shall be embraced... The bold...shall know oblivion...
        JA_RESTRICTION_REMOVED        = 7371, -- Job ability restriction has been removed
        JA_RESTRICTED                 = 7372, -- Job ablities are restricted
        WS_RESTRICTION_REMOVED        = 7373, -- Weapon skill restriction has been removed
        WS_RESTRICTED                 = 7374, -- Weapon skills are restricted
        WHM_RESTRICTION_REMOVED       = 7375, -- White magic restriction has been removed
        WHM_RESTRICTED                = 7376, -- White magic is restricted
        BLM_RESTRICTION_REMOVED       = 7377, -- Black magic restriction has been removed
        BLM_RESTRICTED                = 7378, -- Black magic is restricted
        BRD_RESTRICTION_REMOVED       = 7379, -- Song restriction has been removed
        BRD_RESTRICTED                = 7380, -- Songs are restricted
        NIN_RESTRICTION_REMOVED       = 7381, -- yNinjutsu restriction has been removed
        NIN_RESTRICTED                = 7382, -- Ninjutsu is restricted
        SMN_RESTRICTION_REMOVED       = 7383, -- Summon magic restriction has been removed
        SMN_RESTRICTED                = 7384, -- Summon magic is restricted
        BLU_RESTRICTION_REMOVED       = 7385, -- Blue magic restriction has been removed
        BLU_RESTRICTED                = 7386, -- Blue magic is restricted
        ATTACK_SPEED_DOWN_REMOVED     = 7387, -- Attack speed down removed
        ATTACK_SPEED_DOWN             = 7388, -- Afflicted by attack speed down
        CAST_SPEED_DOWN_REMOVED       = 7389, -- Cast speed down removed
        CAST_SPEED_DOWN               = 7390, -- Afflicted by cast speed down
        STR_DOWN_REMOVED              = 7391, -- STR down removed
        STR_DOWN                      = 7392, -- Afflicted by STR down
        DEX_DOWN_REMOVED              = 7393, -- DEX down removed
        DEX_DOWN                      = 7394, -- Afflicted by DEX down
        VIT_DOWN_REMOVED              = 7395, -- VIT down removed
        VIT_DOWN                      = 7396, -- Afflicted by VIT down
        AGI_DOWN_REMOVED              = 7397, -- AGI down removed
        AGI_DOWN                      = 7398, -- Afflicted by AGI down
        INT_DOWN_REMOVED              = 7399, -- INT down removed
        INT_DOWN                      = 7400, -- Afflicted by INT down
        MND_DOWN_REMOVED              = 7401, -- MND down removed
        MND_DOWN                      = 7402, -- Afflicted by MND down
        CHR_DOWN_REMOVED              = 7403, -- CHR down removed
        CHR_DOWN                      = 7404, -- Afflicted by CHR down
        REGAIN_REMOVED                = 7405, -- Regain effect removed
        REGAIN_RECIEVED               = 7406, -- Recieved regain effect
        REGEN_REMOVED                 = 7407, -- Regen effect removed
        REGEN_RECIEVED                = 7408, -- Recieved regen effect
        REFRESH_REMOVED               = 7409, -- Refresh effect removed
        REFRESH_RECIEVED              = 7410, -- Recieved refresh effect
        FLURRY_REMOVED                = 7411, -- Flurry effect removed
        FLURRY_RECIEVED               = 7412, -- Recieved flurry effect
        CONCENTRATION_REMOVED         = 7413, -- Concentration effect removed
        CONCENTRATION_RECIEVED        = 7414, -- Recieved concentration effect
        STR_BOOST_REMOVED             = 7415, -- STR effect removed
        STR_BOOST_RECIEVED            = 7416, -- Recieved STR effect
        DEX_BOOST_REMOVED             = 7417, -- DEX effect removed
        DEX_BOOST_RECIEVED            = 7418, -- Recieved DEX effect
        VIT_BOOST_REMOVED             = 7419, -- VIT effect removed
        VIT_BOOST_RECIEVED            = 7420, -- Recieved VIT effect
        AGI_BOOST_REMOVED             = 7421, -- AGI effect removed
        AGI_BOOST_RECIEVED            = 7422, -- Recieved AGI effect
        INT_BOOST_REMOVED             = 7423, -- INT effect removed
        INT_BOOST_RECIEVED            = 7424, -- Recieved INT effect
        MND_BOOST_REMOVED             = 7425, -- MND effect removed
        MND_BOOST_RECIEVED            = 7426, -- Recieved MND effect
        CHR_BOOST_REMOVED             = 7427, -- CHR effect removed
        CHR_BOOST_RECIEVED            = 7428, -- Recieved CHR effect
    },

    mob = {
        -- Path of Darkness
        [51] = {
            QIQIRN_MINE         = 17092962,
        },
        [58] = {
            AMNAF_BLU           = 17093132,
            AMNAF_PSYCHEFLAYER  = 17093133,
            IMPERIAL_GEAR1      = 17093134,
            IMPERIAL_GEAR2      = 17093135,
            IMPERIAL_GEAR3      = 17093136,
            IMPERIAL_GEAR4      = 17093137,
            NAJA                = 17093142,
        },
        [59] = {
            RAZFAHD             = 17093143,
            ALEXANDER           = 17093144,
            RAUBAHN             = 17093145,
        }
    },

    npc = {
        _257       = 17093359,
        _259       = 17093361,
        QM1        = 17093472,
        BLANK1     = 17093473,
        BLANK2     = 17093474,
        BLANK3     = 17093475,
        NASHMEIRA1 = 17093476,
        NASHMEIRA2 = 17093477,
        RAZFAHD    = 17093478,
        CSNPC1     = 17093479,
        GHATSAD    = 17093480,
        ALEXANDER  = 17093481,
        CSNPC2     = 17093482,
        WEATHER    = 17093423,
    }
}

return zones[tpz.zone.NYZUL_ISLE]
