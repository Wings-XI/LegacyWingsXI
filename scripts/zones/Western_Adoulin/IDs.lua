-----------------------------------
-- Area: Western Adoulin (256)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WESTERN_ADOULIN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6392, -- Lost key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6395, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED          = 7005, -- You have obtained <number> bayld!
        YOU_CAN_NOW_BECOME      = 7009, -- You can now become a <geomancer/rune fencer>!
        MOG_LOCKER_OFFSET       = 7569, -- Your Mog Locker lease is valid until <timestamp>, kupo.
        RETRIEVE_DIALOG_ID      = 7742, -- You retrieve <item> from the porter moogle's care.
        CONQUEST_BASE           = 8121, -- Tallying conquest results...
        HOMEPOINT_SET           = 8301, -- Home point set!
        HUJETTE_SHOP_TEXT       = 9790, -- How about indulging in some regional delicacies while taking a load off those tired feet of yours?
        PRETERIG_SHOP_TEXT      = 9791, -- Want a way to beat the heat? Try some of the tasty beverages we have on hand.
        LEDERICUS_SHOP_TEXT     = 9825, -- We've got a doozy of a magic scroll selection, tailored especially to your pioneering needs!
        ISHVAD_SHOP_TEXT        = 9826, -- ...A pioneer, are ya? If that's the case, maybe we've finally found a client for our geomantic plates.
        EUKALLINE_SHOP_TEXT     = 9827, -- Why, hello there! If you're looking for geomantic plates, look no further! I don't like to brag, but I'd say our selection is a bit more...sophisticated than what they offer next door.
        FLAPANO_SHOP_TEXT       = 9828, -- Welcome, welcome! Going out into the eye of the jungle's storm? Then the last thing you want is your stomach rumbling during an important battle!
        THEOPHYLACTE_SHOP_TEXT  = 9833, -- Would you care for some of my wares? If you do not, I cannot fault you, but please keep in mind that my revolutionary research into a new Ulbukan toxin antidote will have to be put on hold unless I can accrue the necessary funds.
        KANIL_SHOP_TEXT         = 9834, -- Good day, [good sir/fair maiden]! You're certainly not in the Middle Lands anymore, but would you care for some products from your homeland in addition to some more traditional fare
        DEFLIAA_SHOP_TEXT       = 9852, -- Hi there, pioneer! We wouldn't want you going out to the scary jungle on an empty stomach. Stock up on some of our delicious bread for the journey!
        ANSEGUSELE_SHOP_TEXT    = 9853, -- Would you care for some fresh vegetables direct from the Rala Waterways? They're some of our most popular items!
        TEVIGOGO_SHOP_TEXT      = 9854, -- Hidey ho! Make sure not to forgetaru anything before heading out into the great unknown!
        MINNIFI_DIALOGUE        = 10237, -- Come, ladies and gentlemen, and enjoy our delightful array of frrresh vegetables!
        SPARK_EXCHANGE          = 11357, -- Hm? Oh, spark exchange... Of course.
        NOT_ENOUGH_SPARKS       = 11371, -- You do not possess enough sparks of eminence to complete the transaction.
        LS_CONCIERGE_LISTING_CANCEL = 12747, -- It was my pleasure to meet with you this fine day. May you encounter many friendly faces throughout your travels.
        LS_CONCIERGE_SAME_DAY       = 12751, -- In the interest of fairness, I am unable to distribute multiple linkpearls to someone on the same day. Please come back tomorrow.
        LS_CONCIERGE_REGISTERED1    = 12799, -- Your registration is officially complete.
        LS_CONCIERGE_REGISTERED2    = 12800, -- May your journeys lead you to many as-yet-unmet friends, and may the bonds you forge last a lifetime.
        LS_CONCIERGE_ALREADY_LISTED = 12801, -- Another member of that linkshell currently has an active registration. Please wait until that registration expires and try again.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.WESTERN_ADOULIN]
