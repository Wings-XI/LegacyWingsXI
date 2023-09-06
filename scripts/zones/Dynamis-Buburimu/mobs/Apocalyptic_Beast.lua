-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Apocalyptic Beast
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

local zone = 40

-- "Roams the entire zone"
ApocBeastPath = {
    -201    ,-30    ,147    ,
    -204    ,-22    ,102    ,
    -293    ,-22    ,96     ,
    -358    ,-22    ,19     ,
    -359    ,-24    ,-44    ,
    -284    ,-16    ,-118   ,
    -238    ,-16    ,-85    ,
    -191    ,-9     ,-89    ,
    -143    ,-8.5   ,-130   ,
    -45.5   ,-7     ,-100   ,
    166     ,-8     ,-46.4  ,
    335     ,-7.7   ,-118   ,
    386     ,0      ,45     ,
    321     ,0      ,120.5  ,
    227     ,-16    ,228    ,
    152     ,-15.8  ,119.8  ,
    77.5    ,-8.7   ,88     ,
    -109    ,-20    ,57     ,
    -147    ,-21    ,96     ,
    -204    ,-22    ,102    ,
}

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMegaBossStats(mob)

    -- Set Mods
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.BINDRES, 50)
    mob:setMod(tpz.mod.STUNRES, 50)
    mob:setMod(tpz.mod.REGAIN, 500)
    mob:setMod(tpz.mod.REFRESH, 500)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.BLINDRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 50)
    mob:setMod(tpz.mod.SLOWRES, 50)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)

    -- for spells to land/do non-trivial damage
    mob:setMod(tpz.mod.MATT, 100)
    mob:setMod(tpz.mod.MACC, 150)

    -- for songs (lullaby) to land more reliably
    mob:setMod(tpz.mod.SINGING, 200)

    -- Set Vars
    mob:setLocalVar("next2hr", 1) -- 2hr rotation not reset by a wipe
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local winQM = GetNPCByID(16941677)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_BUBURIMU_INTERLOPER)
    if GetMobByID(ID.mob.Aitvaras):isAlive() then
        DespawnMob(ID.mob.Aitvaras)
    end
    if GetMobByID(ID.mob.Alklha):isAlive() then
        DespawnMob(ID.mob.Alklha)
    end
    if GetMobByID(ID.mob.Barong):isAlive() then
        DespawnMob(ID.mob.Barong)
    end
    if GetMobByID(ID.mob.Basilic):isAlive() then
        DespawnMob(ID.mob.Basilic)
    end
    if GetMobByID(ID.mob.Jurik):isAlive() then
        DespawnMob(ID.mob.Jurik)
    end
    if GetMobByID(ID.mob.Koschei):isAlive() then
        DespawnMob(ID.mob.Koschei)
    end
    if GetMobByID(ID.mob.Stihi):isAlive() then
        DespawnMob(ID.mob.Stihi)
    end
    if GetMobByID(ID.mob.Stollenwurm):isAlive() then
        DespawnMob(ID.mob.Stollenwurm)
    end
    if GetMobByID(ID.mob.Tarasca):isAlive() then
        DespawnMob(ID.mob.Tarasca)
    end
    if GetMobByID(ID.mob.Vishap):isAlive() then
        DespawnMob(ID.mob.Vishap)
    end
end

function onMobRoam(mob)
    -- patrol function instead?
    tpz.path.patrolsimple(mob, ApocBeastPath)
    mob:setTP(0)
end

function onMobEngaged(mob, target)
    local ID = zones[zone]
    mob:setTP(0)
    mob:setLocalVar("next2hrtime", os.time() + 5) -- 5s after aggro
end

function onMobFight(mob, target)
    -- https://ffxiclopedia.fandom.com/wiki/Apocalyptic_Beast?oldid=1064856
    local ID = require("scripts/zones/Dynamis-Buburimu/IDs")

    local abilities2hr =
    {
        {tpz.jsa.MIGHTY_STRIKES, ID.mob.QuPho_Bloodspiller},
        {tpz.jsa.HUNDRED_FISTS, ID.mob.Hamfist_Gukhbuk},
        {tpz.jsa.BENEDICTION, ID.mob.GiBhe_Fleshfeaster},
        {tpz.jsa.MANAFONT, ID.mob.Flamecaller_Zoeqdoq},
        {tpz.jsa.CHAINSPELL, ID.mob.Gosspix_Blabberlips},
        {tpz.jsa.PERFECT_DODGE, ID.mob.VaRhu_Bodysnatcher},
        {tpz.jsa.INVINCIBLE, ID.mob.TeZha_Ironclad},
        {tpz.jsa.BLOOD_WEAPON, ID.mob.Shamblix_Rottenheart},
        {tpz.jsa.FAMILIAR, ID.mob.Woodnix_Shrillwhistle},
        {tpz.jsa.SOUL_VOICE, ID.mob.Ree_Nata_The_Melomanic},
        {tpz.jsa.EES_KINDRED, ID.mob.Lyncean_Juwgneg},
        {tpz.jsa.MEIKYO_SHISUI, ID.mob.Koo_Rahi_The_Levinblade},
        {tpz.jsa.MIJIN_GAKURE, ID.mob.Doo_Peku_The_Fleetfoot},
        {tpz.jsa.CALL_WYVERN, ID.mob.Elvaansticker_Bxafraff},
        {tpz.jsa.ASTRAL_FLOW, ID.mob.Baa_Dava_The_Bibliopage},
    }

    local usablemobabilities =
    {
        {650, ID.mob.Koschei}, -- Thornsong
        {647, ID.mob.Alklha}, -- Chaos Blade
        {645, ID.mob.Barong}, -- Body Slam
        {648, ID.mob.Basilic}, -- Petro Eyes
        {644, ID.mob.Jurik}, -- Wind Breath
        {649, ID.mob.Aitvaras}, -- Voidsong
        {642, ID.mob.Stihi}, -- Flame Breath
        {651, ID.mob.Stollenwurm}, -- Lodesong
        {646, ID.mob.Tarasca}, -- Heavy Stomp
        {643, ID.mob.Vishap}, -- Poison Breath
        -- {1337, ID.mob.Woodnix_Shrillwhistle}, -- Charm only during 2hr window
    }

    local manafontspells =
    {
        176, -- Firaga III
        181, -- Blizzaga III
        186, -- Aeroga III
        191, -- Stonega III
        196, -- Thundaga III
        201, -- Waterga III
    }

    local chainspellspells =
    {
        361, -- Blindga
        356, -- Paralyga
        362, -- Bindga
        365, -- Breakga
        274, -- Sleepga II
        367, -- Death
    }

    local soulvoicesongs =
    {
        376, -- Horde Lullaby
        373, -- Foe Requiem VI
        397, -- Valor Minuet IV
        420, -- Victory March
        422, -- Carnage Elegy
        463, -- Foe Lullaby
    }
    local checked2hrs = 0
    if mob:getCurrentAction() <= 1 then
        while os.time() >= (mob:getLocalVar("next2hrtime")) and checked2hrs < #abilities2hr do
            i = mob:getLocalVar("next2hr")
            -- skip 2hrs from dead NMs (var is set in dynamis.mobOnDeath)
            if GetMobByID(abilities2hr[i][2]):getLocalVar("dynamisMobOnDeathTriggered") ~= 1 then
                mob:setLocalVar("next2hrtime", os.time() + math.random(45,75)) -- 45s-75s after previous usage
                if abilities2hr[i][1] == tpz.jsa.FAMILIAR then
                    -- charm
                    mob:useMobAbility(710)
                else
                    mob:useMobAbility(abilities2hr[i][1])
                end
                checked2hrs = 0
            end
            -- After going through all two-hour abilities, it will start over again
            mob:setLocalVar("next2hr", (i % #abilities2hr) + 1)
            -- if all 2hrs are skipped, don't keep looping
            checked2hrs = checked2hrs + 1
        end
    end


    if mob:hasStatusEffect(tpz.effect.MANAFONT) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local spell = manafontspells[math.random(#manafontspells)]
            mob:castSpell(spell)
        end
    end

    -- take care not to spam castSpell, as the spell queuing system will stack them alllll up
    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local spell = chainspellspells[math.random(#chainspellspells)]
            mob:castSpell(spell)
        end
    end

    if mob:hasStatusEffect(tpz.effect.SOUL_VOICE) then
        -- ensure only spells
        mob:setTP(0)
        if mob:getCurrentAction() <= 1 then
            local song = soulvoicesongs[math.random(#soulvoicesongs)]
            mob:castSpell(song)
        end
    end

    -- use mobskills explicitly in onMobFight as returning a mobskill in onMobWeaponSkillPrepare doesn't guarantee its use
    -- (if the target isn't valid it moves on to the rest of the skill list)
    if ((mob:getTP() >= 2900 and mob:getHPP() > 66) or
       (mob:getTP() >= 1900 and mob:getHPP() > 33) or
       (mob:getTP() >= 900 and mob:getHPP() > 0)) and
       mob:getLocalVar("timeSinceWS") < os.time() - 5 and
       mob:actionQueueEmpty()
    then
        mob:setLocalVar("timeToWS", 1)
    end

    if mob:getLocalVar("timeToWS") == 1 and mob:getLocalVar("timeSinceWS") < os.time() - 1 and
        (target and mob:checkDistance(target) < 15)
    then -- then if we has enough "tp", we can WS
        mob:setLocalVar("timeToWS", 0)
        mob:setLocalVar("timeSinceWS", os.time())
        mob:setTP(0)
        local totalchance = 0
        local skippedabilities = 0
        local i = 1
        local randomchance = math.random(10 * (#usablemobabilities))
        while totalchance <= randomchance and skippedabilities < #usablemobabilities do
            -- skip abilities from dead NMs (var is set in dynamis.mobOnDeath)
            if GetMobByID(usablemobabilities[i][2]):getLocalVar("dynamisMobOnDeathTriggered") ~= 1 then
                totalchance = totalchance + 10
                if totalchance >= randomchance then
                    if mob:getLocalVar("next2hr") > 1 and abilities2hr[(mob:getLocalVar("next2hr") - 1) % #abilities2hr][1] == tpz.jsa.FAMILIAR and math.random(1,10) < 5 then -- high chance of charm during bst 2hr window
                        mob:useMobAbility(1337)
                    else
                        mob:useMobAbility(usablemobabilities[i][1])
                    end
                    skippedabilities = #usablemobabilities
                else
                    skippedabilities = 0
                end
            else
                -- if all abilities are skipped, don't keep looping
                skippedabilities = skippedabilities + 1
            end
            -- loop back to start of list until randomchance is surpassed
            i = (i % #usablemobabilities) + 1
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    mob:setLocalVar("timeSinceWS", os.time())
    if skill:getID() == tpz.jsa.CALL_WYVERN then
        local ID = require("scripts/zones/Dynamis-Buburimu/IDs")
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        -- Summon 5 Dragon's Wyverns
        for i, v in pairs(ID.mob.Dragons_Wyverns) do
            local wyvern = GetMobByID(v)
            local x = mobX + math.random(-2,2)
            local z = mobZ + math.random(-2,2)
            wyvern:setSpawn(x, mobY, z)
            wyvern:setPos(x, mobY, z)
            SpawnMob(wyvern:getID()):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        end
        skill:setMsg(tpz.msg.basic.NONE)
    end
end
