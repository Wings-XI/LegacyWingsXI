-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Apocalyptic Beast
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 40

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Buburimu/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMegaBossStats(mob)

    -- Set Mods
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.BINDRES, 50)
    mob:setMod(tpz.mod.STUNRES, 99)
    mob:setMod(tpz.mod.REGAIN, 500)
    mob:setMod(tpz.mod.REFRESH, 500)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.BLINDRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 50)
    mob:setMod(tpz.mod.SLOWRES, 50)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)

    -- Set Vars
    mob:setLocalVar("mightystrikes", 1)
    mob:setLocalVar("bloodweapon", 1)
    mob:setLocalVar("chainspell", 1)
    mob:setLocalVar("familiarcharm", 1)
    mob:setLocalVar("callwyvern", 1)
    mob:setLocalVar("manafont", 1)
    mob:setLocalVar("hundredfists", 1)
    mob:setLocalVar("eagleeyeshot", 1)
    mob:setLocalVar("benediction", 1)
    mob:setLocalVar("invincible", 1)
    mob:setLocalVar("perfectdodge", 1)
    mob:setLocalVar("astralflow", 1)
    mob:setLocalVar("mijingakure", 1)
    mob:setLocalVar("meikyoshisui", 1)
    mob:setLocalVar("soulvoice", 1)
    mob:setLocalVar("voidsong", 1)
    mob:setLocalVar("chaosblade", 1)
    mob:setLocalVar("bodyslam", 1)
    mob:setLocalVar("petroeyes", 1)
    mob:setLocalVar("windbreath", 1)
    mob:setLocalVar("thornsong", 1)
    mob:setLocalVar("flamebreath", 1)
    mob:setLocalVar("lodesong", 1)
    mob:setLocalVar("heavystomp", 1)
    mob:setLocalVar("poisonbreath", 1)
    
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
        DespawnMob(GetMobByID(ID.mob.Aitvaras))
    end
    if GetMobByID(ID.mob.Alklha):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Alklha))
    end
    if GetMobByID(ID.mob.Barong):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Barong))
    end
    if GetMobByID(ID.mob.Basilic):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Basilic))
    end
    if GetMobByID(ID.mob.Jurik):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Jurik))
    end
    if GetMobByID(ID.mob.Koschei):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Koschei))
    end
    if GetMobByID(ID.mob.Stihi):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Stihi))
    end
    if GetMobByID(ID.mob.Stollenwurm):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Stollenwurm))
    end
    if GetMobByID(ID.mob.Tarasca):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Tarasca))
    end
    if GetMobByID(ID.mob.Vishap):isAlive() then
        DespawnMob(GetMobByID(ID.mob.Vishap))
    end
end

function onMobRoamAction(mob)
end

function onMobRoam(mob)
end

function onMobEngaged(mob, target)
    local ID = zones[zone]

    mob:setLocalVar("last2hrtime", os.time())
    mob:setLocalVar("next2hr", 1)

end

function onMobFight(mob)
    local ID = zones[zone]

    local abilities2hr =
    {
        [1 ] = tpz.jsa.MIGHTY_STRIKES,
        [2 ] = tpz.jsa.HUNDRED_FISTS,
        [3 ] = tpz.jsa.BENEDICTION,
        [4 ] = tpz.jsa.MANAFONT,
        [5 ] = tpz.jsa.CHAINSPELL,
        [6 ] = tpz.jsa.PERFECT_DODGE,
        [7 ] = tpz.jsa.INVINCIBLE,
        [8 ] = tpz.jsa.BLOOD_WEAPON,
        [9 ] = tpz.jsa.FAMILIAR,
        [10] = tpz.jsa.SOUL_VOICE,
        [11] = tpz.jsa.EES_DRAGON,
        [12] = tpz.jsa.MEIKYO_SHISUI,
        [13] = tpz.jsa.MIJIN_GAKURE,
        [14] = tpz.jsa.CALL_WYVERN,
        [15] = tpz.jsa.ASTRAL_FLOW,
    }

    local manafontspells =
    {
        [1 ] = 176, -- Firaga III
        [2 ] = 181, -- Blizzaga III
        [3 ] = 186, -- Aeroga III
        [4 ] = 191, -- Stonega III
        [5 ] = 196, -- Thundaga III
        [6 ] = 201, -- Waterga III
    }

    local chainspellspells =
    {
        [1 ] = 361, -- Blindga
        [2 ] = 356, -- Paralyga
        [3 ] = 362, -- Bindga
        [4 ] = 365, -- Breakga
        [5 ] = 274, -- Sleepga II
        [6 ] = 367, -- Death
    }

    local soulvoicesongs =
    {
        [1 ] = 376, -- Horde Lullaby
        [2 ] = 373, -- Foe Requiem VI
        [3 ] = 397, -- Valor Minuet IV
        [4 ] = 420, -- Victory March
        [5 ] = 422, -- Carnage Elegy
        [6 ] = 463, -- Foe Lullaby
    }

    while os.time() >= (mob:getLocalVar("last2hrtime") + 45) do
        i = mob:getLocalVar("next2hr")
        mob:useMobAbility(abilities2hr[i])
        mob:setLocalVar("last2hrtime", os.time())
        mob:setLocalVar("next2hr", i + 1)
    end

    if mob:getLocalVar("familiarcharm") == 1 then
        if mob:getLocalVar("next2hr") == 9 and (os.time() >= (mob:getLocalVar("last2hrtime") + 43)) then
            mob:useMobAbility(710)
        end
    end

    if mob:hasStatusEffect(tpz.effect.MANAFONT) then
        if mob:getStatus() == tpz.action.NONE then
            local spell = manafontspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    end

    if mob:hasStatusEffect(tpz.effect.CHAINSPELL) then
        if mob:getStatus() == tpz.action.NONE then
            local spell = chainspellspells[math.random(1,6)]
            mob:castSpell(spell)
        end
    end

    if mob:hasStatusEffect(tpz.effect.SOUL_VOICE) then
        if mob:getStatus() == tpz.action.NONE then
            local song = soulvoicesongs[math.random(1,6)]
            mob:castSpell(song)
        end
    end

end

function onMobWeaponSkillPrepare(mob, target)
    -- Set Locals
    local ID = zones[zone]
    local voidsong = 10
    local chaosblade = 10
    local bodyslam = 10
    local petroeyes = 10
    local windbreath = 10
    local flamebreath = 10
    local lodesong = 10
    local heavystomp = 10
    local poisonbreath = 10
    local thornsong = 10
    local charm = 10

    -- Set Probabilities of Each Skill Based on Dragon Kill Status
    if GetMobByID(ID.mob.Aitvaras):getStatus() == 2 then
        voidsong = 0
    end
    if GetMobByID(ID.mob.Alklha):getStatus() == 2 then
        chaosblade = 0
    end
    if GetMobByID(ID.mob.Barong):getStatus() == 2 then
        bodyslam = 0
    end
    if GetMobByID(ID.mob.Basilic):getStatus() == 2 then
        petroeyes = 0
    end
    if GetMobByID(ID.mob.Jurik):getStatus() == 2 then
        windbreath = 0
    end
    if GetMobByID(ID.mob.Koschei):getStatus() == 2 then
        thornsong = 0
    end
    if GetMobByID(ID.mob.Stihi):getStatus() == 2 then
        flamebreath = 0
    end
    if GetMobByID(ID.mob.Stollenwurm):getStatus() == 2 then
        lodesong = 0
    end
    if GetMobByID(ID.mob.Tarasca):getStatus() == 2 then
        heavystomp = 0
    end
    if GetMobByID(ID.mob.Vishap):getStatus() == 2 then
        poisonbreath = 0
    end
    if mob:getLocalVar("familiarcharm") == 0 then
        charm = 0
    end

    local totalchance = voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm
    local randomchance = math.random(1, totalchance)

    -- Choose Skill
    if randomchance >= (totalchance - voidsong) then
        return 649 -- Voidsong
    elseif randomchance >= (totalchance - (voidsong + chaosblade)) then
        return 647 -- Chaos Blade
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam)) then
        return 645 -- Body Slam
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes)) then
        return 648 -- Petro Eyes
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath)) then
        return 644 -- Wind Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong)) then
        return 650 -- Thornsong
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath)) then
        return 642 -- Flame Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong)) then
        return 651 -- Lodesong
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp)) then
        return 646 -- Heavy Stomp
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath)) then
        return 643 -- Poison Breath
    elseif randomchance >= (totalchance - (voidsong + chaosblade + bodyslam + petroeyes + windbreath + thornsong + flamebreath + lodesong + heavystomp + poisonbreath + charm)) then
        return 710 -- Charm
    else
        return 0
    end
end


function onMobWeaponSkill(target, mob, skill)
    if mob:getLocalVar("callwyvern") == 1 then
        if skill == tpz.jsa.CALL_WYVERN then
            -- Summon 5 Dragon's Wyverns
            GetMobByID(ID.mobs.Dragons_Wyvern_1):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Dragons_Wyvern_1):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Dragons_Wyvern_1):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mobs.Dragons_Wyvern_2):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Dragons_Wyvern_2):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Dragons_Wyvern_2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mobs.Dragons_Wyvern_3):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Dragons_Wyvern_3):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Dragons_Wyvern_3):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mobs.Dragons_Wyvern_4):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Dragons_Wyvern_4):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Dragons_Wyvern_4):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mobs.Dragons_Wyvern_5):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Dragons_Wyvern_5):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Dragons_Wyvern_5):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        end
    end
end
