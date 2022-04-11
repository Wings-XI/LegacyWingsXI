require("scripts/globals/mixins")
require("scripts/globals/status")

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.animatedweapons = tpz.mix.animatedweapons or {}

g_mixins = g_mixins or {}

local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
local defaultDialog =
{
    [17330199] = ID.text.ANIMATED_KNUCKLES_DIALOG,
    [17330200] = ID.text.ANIMATED_DAGGER_DIALOG,
    [17330201] = ID.text.ANIMATED_LONGSWORD_DIALOG,
    [17330202] = ID.text.ANIMATED_CLAYMORE_DIALOG,
    [17330203] = ID.text.ANIMATED_TABAR_DIALOG,
    [17330204] = ID.text.ANIMATED_GREATAXE_DIALOG,
    [17330205] = ID.text.ANIMATED_SPEAR_DIALOG,
    [17330206] = ID.text.ANIMATED_SCYTHE_DIALOG,
    [17330207] = ID.text.ANIMATED_KUNAI_DIALOG,
    [17330208] = ID.text.ANIMATED_TACHI_DIALOG,
    [17330209] = ID.text.ANIMATED_HAMMER_DIALOG,
    [17330210] = ID.text.ANIMATED_STAFF_DIALOG,
    [17330211] = ID.text.ANIMATED_LONGBOW_DIALOG,
    [17330212] = ID.text.ANIMATED_GUN_DIALOG,
    [17330213] = ID.text.ANIMATED_HORN_DIALOG,
    [17330214] = ID.text.ANIMATED_SHIELD_DIALOG,
}

g_mixins.animated_weapons = function(mob)

    mob:addListener("SPAWN", "ANIMATED_WEAPON_SPAWN", function(mob)
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("dialogOne", 4)
        mob:setLocalVar("dialogTwo", 3)
    end)

    mob:addListener("ENGAGE", "ANIMATED_WEAPON_ENGAGE", function(mob, target)
        local ID = zones[mob:getZoneID()]
        mob:setLocalVar("changeTime", math.random(20, 30)) -- set wait time for Animated Weapon to use Warp.
        mob:showText(mob, defaultDialog[mob:getID()])
    end)

    mob:addListener("COMBAT_TICK", "ANIMATED_WEAPON_CTICK", function(mob)
        -- Throughout the fight, the Animated Weapon will talk to you in say and emotes, telling you how impressed or bored it is.
        -- The determination of which is dependent on how it's being fought. If it loses too much interest, it will cast Warp upon itself.
        -- There is not enough data to determine which dialog it will use at which point in the fight, so we will cycle through the dialog
        -- and emotes based on HP%.
        local dialogHPP =
        {
            90, 80, 70, 60, 50, 40, 30, 20, 10,
        }

        local dialogTrigger = mob:getLocalVar("dialogTrigger")
        local dialogQueue = mob:getLocalVar("dialogQueue")
        local mobHPP = mob:getHPP()
        for trigger, hpp in ipairs(dialogHPP) do
            if mobHPP < hpp and dialogTrigger < trigger then
                mob:setLocalVar("dialogTrigger", trigger)
                mob:setLocalVar("dialogQueue", dialogQueue + 1)
                break
            end
        end

        local dialogOne = mob:getLocalVar("dialogOne")
        local dialogTwo = mob:getLocalVar("dialogTwo")
        local dialogQueue = mob:getLocalVar("dialogQueue")
        if dialogQueue > 0 then
            local dialogQueue = mob:getLocalVar("dialogQueue") - 1
            mob:messageText(mob, defaultDialog[mob:getID()] +dialogOne) -- standard text
            mob:setLocalVar("dialogOne", dialogOne +2)
            mob:messageText(mob, defaultDialog[mob:getID()] +dialogTwo) -- emote
            mob:setLocalVar("dialogTwo", dialogTwo +2)
            mob:setLocalVar("dialogQueue", dialogQueue)
        end

        local battleTime = mob:getBattleTime()
        local changeTime = mob:getLocalVar("changeTime")
        if battleTime - changeTime >= 0 then
            mob:setLocalVar("warp", 1)
            mob:castSpell(261)
            mob:setLocalVar("changeTime", mob:getBattleTime() + math.random(10, 15)) -- if interrupted, will try to warp again, this wait time starts onCast
        end
    end)

    mob:addListener("MAGIC_START", "ANIMATED_WEAPON_MAGIC_START", function(mob, spell, action)
        if spell:getID() == 261 then
            mob:setLocalVar("warp", 0) -- don't immediately cast warp again if interrupted
        end
    end)

    mob:addListener("MAGIC_STATE_EXIT", "ANIMATED_WEAPON_MAGIC_STATE_EXIT", function (mob, spell)
        if spell:getID() == 261 then
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false) -- short delay from cast finish to despawning
            mob:SetMobAbilityEnabled(false)
            mob:setLocalVar("warp", 0)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        end
    end)

    mob:addListener("DISENGAGE", "ANIMATED_WEAPON_DISENGAGE", function (mob)
        local ID = zones[mob:getZoneID()]
        mob:showText(mob, defaultDialog[mob:getID()] +2)
    end)

    mob:addListener("DEATH", "ANIMATED_WEAPON_DEATH", function(mob, killer)
        local ID = zones[mob:getZoneID()]
        mob:showText(mob, defaultDialog[mob:getID()] +1)
    end)

end

return g_mixins.animated_weapons