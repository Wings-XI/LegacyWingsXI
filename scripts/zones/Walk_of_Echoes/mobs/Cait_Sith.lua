-----------------------------------
-- Area: Walk of Echoes
--  Mob: Cait Sith
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
-----------------------------------

function onMobInitialize(mob)
    -- flag nm stats
    mob:setMod(tpz.mod.HPP, 120)
    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 2)
end

function onMobSpawn(mob)
    mob:setModelId(28) -- copied modelid from cait sith pet since db value has bunk animations

    -- resistances: https://www.bg-wiki.com/ffxi/Cait_Sith_Prime
    mob:setMod(tpz.mod.UDMGMAGIC, -50)
    mob:setMod(tpz.mod.UDMGBREATH, -50)
    mob:setMod(tpz.mod.SDT_FIRE, 50)
    mob:setMod(tpz.mod.SDT_ICE, 30)
    mob:setMod(tpz.mod.SDT_WIND, 50)
    mob:setMod(tpz.mod.SDT_EARTH, 30)
    mob:setMod(tpz.mod.SDT_THUNDER, 50)
    mob:setMod(tpz.mod.SDT_WATER, 30)
    mob:setMod(tpz.mod.SDT_LIGHT, -100) -- immune
    mob:setMod(tpz.mod.SDT_DARK, 30)

    -- status resistances: https://ffxiclopedia.fandom.com/wiki/Champion_of_the_Dawn
    mob:setMod(tpz.mod.STUNRES, -10)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.SILENCERES, 50)

    -- videos show her magic is very potent
    mob:setMod(tpz.mod.INT, 20)
    mob:setMod(tpz.mod.REGAIN, 50)

    tpz.mix.jobSpecial.config(mob, {
        chance = 100,
        specials =
        {
            { id = tpz.jsa.CHAINSPELL, hpp = 50 },
        },
    })

    -- buff at spawn or dillute casting pool during fight?
    -- mob:cast(46) -- protect_iv
    -- mob:cast(51) -- shell_iv)
end

-- mob pool sets hasSpellScript to 1
function onMonsterMagicPrepare(mob, target)
    -- used pick and choose from this list
    -- SELECT CONCAT(spellid,', -- ',NAME) FROM mob_spell_lists LEFT JOIN spell_list ON spellid = spell_id WHERE spell_list_id IN (2,3) AND min_level <= 75 AND skill = 35
    local enfeebs = {
        254, -- blind
        258, -- bind
        259, -- sleep_ii
        56, -- slow
        58, -- paralyze
        59, -- silence
        216, -- gravity
        260, -- dispel
    }

    -- SELECT CONCAT(spellid,', -- ',NAME) FROM mob_spell_lists LEFT JOIN spell_list ON spellid = spell_id WHERE spell_list_id IN (2,3) AND min_level <= 75 AND (NAME LIKE "%iii" OR NAME LIKE "%iv")
    local nukes = {
        -- 146, -- fire_iii
        147, -- fire_iv
        -- 151, -- blizzard_iii
        152, -- blizzard_iv
        -- 156, -- aero_iii
        157, -- aero_iv
        -- 161, -- stone_iii
        162, -- stone_iv
        -- 166, -- thunder_iii
        167, -- thunder_iv
        -- 171, -- water_iii
        172, -- water_iv
        176, -- firaga_iii
        181, -- blizzaga_iii
        186, -- aeroga_iii
        191, -- stonega_iii
        196, -- thundaga_iii
        201, -- waterga_iii
    }

    if math.random(1,100) <= 10 then
        return 4 -- cure_iv
    end

    -- cycle spell types so parties don't get murdered during chainspell (which is not confirmed to be used by cait, she just happens to be rdm)
    if mob:getLocalVar("spell") == 0 then
        mob:setLocalVar("spell", 1)
        if not mob:hasStatusEffect(tpz.effect.ENLIGHT) then
            return 310 -- enlight
        elseif not mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            return 250 -- ice_spikes
        elseif not mob:hasStatusEffect(tpz.effect.SHELL) then
            return 51 -- shell_iv
        elseif not mob:hasStatusEffect(tpz.effect.PROTECT) then
            return 46 -- protect_iv
        elseif not mob:hasStatusEffect(tpz.effect.HASTE) then
            return 57 -- haste
        else
            return 5 -- cure v
        end
    elseif mob:getLocalVar("spell") == 1 then
        mob:setLocalVar("spell", 2)
        return nukes[math.random(1, #nukes)]
    else
        mob:setLocalVar("spell", 0)
        return enfeebs[math.random(1, #enfeebs)]
    end
end

function onMobEngaged(mob, player)
    mob:messageName(ID.text.CAIT_ENGAGE, mob)
end

function onMobFight(mob, player)
end

function onMobDeath(mob, player, isKiller)
    if player then
        player:messageSpecial(ID.text.CAIT_DEAD)
    end
end
