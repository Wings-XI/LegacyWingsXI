-----------------------------------
-- Area: Ruhotz_Silvermines
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.RUHOTZ_SILVERMINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CANNOT_ENTER_LEVEL_RESTRICTED = 7021, -- Your party is unable to participate because certain members' levels are restricted.
        TIME_TO_COMPLETE              = 7149, -- You have ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes] (Earth time) to complete your objectives.
        TIME_REMAINING_MINUTES        = 7150, -- Time remaining: ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7151, -- Time remaining: ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[second/seconds] (Earth time).
        PARTY_FALLEN                  = 7152, -- All party members have fallen in battle. Exiting in ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes].
        CONQUEST_BASE                 = 7154, -- Tallying conquest results...
        MADE_YOUR_PEACE               = 7492, -- Have you made your peace with the Goddess?
        STUDENT_BECOME_MASTER         = 7493, -- Inconceivable!  The student has become...the master...
        UNLEARNT_SPRAT                = 7494, -- You unlearnt sprat!   Excessive studies are hampering your progress!    Ahahaha!
        ANSWER_THIS                   = 7495, -- Let us see your answer to this!
        TRUE_TEACHING                 = 7496, -- Prepare to receive the true teaching!
        MOST_IMPRESSIVE               = 7497, -- Impressive. Most impressive.     Perhaps I have been too easy on you up to now...
        PAINFUL_LESSON                = 7498, -- Ugh... A painful lesson...
    },
    mob =
    {
        ULBRECHT = 17158191,
        SAPPHIRINE_QUADAV_OFFSET = 17158192,
    },
    npc =
    {
    },
}

return zones[tpz.zone.RUHOTZ_SILVERMINES]
