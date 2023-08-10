-----------------------------------
-- Area: Buburimu_Peninsula
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BUBURIMU_PENINSULA] =
{
    text =
    {
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6417,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6423,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6424,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6426,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6427,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET          = 6452,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7034, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7035, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7036, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7084,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7165,  -- There is a beastmen's banner.
        FIVEOFSPADES_DIALOG            = 7243,  -- GiMmefIvE! FiVe isA cArdIanOF WiN-DuRst! FIvEiS OnpA-tRol!
        FISHING_MESSAGE_OFFSET         = 7249,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7262,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7264,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET             = 7330,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        SONG_RUNES_DEFAULT             = 7369,  -- An old momument. A melancholy song of two separated lovers is written upon it.
        SONG_RUNES_REQUIRE             = 7383,  -- If only you had <item>, you could jot down the lyrics.
        SONG_RUNES_WRITING             = 7384,  -- You write down the lyrics on the <item>.
        SIGN_1                         = 7391,  -- West: Tahrongi Canyon Southeast: Mhaura
        SIGN_2                         = 7392,  -- West: Tahrongi Canyon South: Mhaura
        SIGN_3                         = 7393,  -- West: Tahrongi Canyon Southwest: Mhaura
        SIGN_4                         = 7394,  -- West: Mhaura and Tahrongi Canyon
        SIGN_5                         = 7395,  -- West: Mhaura Northwest: Tahrongi Canyon
        LOGGING_IS_POSSIBLE_HERE       = 7396,  -- Logging is possible here if you have <item>.
        CONQUEST                       = 7412,  -- You've earned conquest points!
        CONNECTING_WITH_THE_SERVER     = 7880, -- Connecting with the server. Please wait.
        UNABLE_TO_CONNECT              = 7881, -- Unable to connect
        ANOTHER_GROUP                  = 7883, -- Another group of players is currently occupying [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].
        INFORMATION_RECORDED           = 7884,
        YOU_CANNOT_ENTER_DYNAMIS       = 7888,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        DYNA_NPC_DEFAULT_MESSAGE       = 7889,  -- You hear a mysterious, floating voice: The guiding aura has not yet faded... Bring forth the <item>.
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7890,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        PLAYER_OBTAINS_ITEM            = 8100,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8101,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8102,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8103,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8108,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10286, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12307, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        BRIGANDS_CHART_QUEST           = {
            LONG_AGO                       = 7825,
            RETURN_CHART                   = 7826,
            MY_PENGUIN_RING                = 7832,
            IT_CANT_BE                     = 7838,
            ITS_BACK_NOW                   = 7839
        },
    },
    
    mob =
    {
        BACKOO        = 17260613,
        HELLDIVER_PH  =
        {
            [17260906] = 17260907, -- 509.641 0.151 -267.664
        },
        BUBURIMBOO_PH =
        {
            [17261000] = 17261003, -- 443.429 19.500 135.322
            [17261002] = 17261003, -- 442.901 19.500 109.075
            [17261001] = 17261003, -- 443.004 19.500 96.000
            [17260999] = 17261003, -- 444.224 19.499 76.000
        },
        PUFFER_PUGIL = 17261040
    },
    
    npc =
    {
        CASKET_BASE     = 17261113,
        OVERSEER_BASE   = 17261150,
        SIGNPOST_OFFSET = 17261165,
        LOGGING =
        {
            17261175,
            17261176,
            17261177,
            17261178,
            17261179,
            17261180,
        },
        JADE_ETUI =
        {
            17261035,
            17261036,
            17261037,
            17261038,
            17261039
        },
        QM1 = 17261187,
        BCQ_GHOST = 17261188,
        BCQ_SHIMMER = 17261189
    },
}

return zones[tpz.zone.BUBURIMU_PENINSULA]
