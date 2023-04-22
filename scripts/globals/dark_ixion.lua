require("scripts/globals/settings")
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
mixins = {
    require("scripts/mixins/job_special"),
}

darkixion = {}
-- mob:AnimationSub() -- 0 is normal || Charging is animation sub 1  || 2 is broken horn || 3 is glowing and repairs horn


-- TODOs, notes, and reminders

-- grav/bind res

-- for charge/trample, height check.. lower to 6 from 7 or 5.5
-- Cleanup dmg taken from front/rear (if we can)
  -- possible to edit PHYSICAL_SHIELD to do this, but a pretty substantial thing for what amounts to be a minimal combat log issue
  -- suspect LSB has functionality to do this more cleanly
  -- TODO figure out how to make TAKE_DAMAGE listener not crash zone <.<


  -- for charge, idk, maybe add roam flag 512 or 256
        -- what dodoes the flag do? it works pretty good now
        -- i think you wrote this then responded to yourself? -- mowford


darkixion.zoneinfo =
{
    [tpz.zone.JUGNER_FOREST_S] =
        {
            zoneID = tpz.zone.JUGNER_FOREST_S,
            mobID = 17113468,
            pathList = {
                -191.5	,000.0	,092.0	,
                -139.6	,005.0	,097.0	,
                -064.0	,002.5	,093.0	,
                -025.5	,004.5	,057.0	,
                025.0	,006.0	,040.0	,
                087.0	,002.0	,029.0	,
                074.0	,000.0	,-011.0	,
                087.0	,000.0	,-083.0	,
                118.0	,000.0	,-109.0	,
                088.0	,000.0	,-170.0	,
                061.0	,-002.0	,-156.0	,
                030.8	,-002.0	,-179.5	,
                -031.8	,000.0	,-196.5	,
                -098.5	,000.0	,-169.0	,
                -177.5	,000.0	,-152.0	,
                -218.0	,000.0	,-234.0	,
                -323.0	,002.0	,-260.7	,
                -225.0	,-007.0	,-110.0	,
                -220.7	,006.0	,-107.0	,
                -260.6	,006.0	,-091.0	,
                -259.0	,001.0	,-030.5	,
                -304.0	,001.4	,004.0	,
                -299.0	,002.7	,072.5	,
                -291.0	,009.0	,140.5	,
                -202.7	,002.0	,139.0	,
            }
        },
    [tpz.zone.WEST_SARUTABARUTA_S] =
        {
            zoneID = tpz.zone.WEST_SARUTABARUTA_S,
            mobID = 17166730,
            pathList = {
                231.8	,-025.0	,258.5	,
                227.5	,-017.5	,209.0	,
                134.6	,-020.5	,195.0	,
                068.0	,-012.4	,194.8	,
                068.0	,-020.0	,254.0	,
                -027.0	,-012.0	,296.4	,
                -019.0	,-011.7	,349.0	,
                016.0	,-018.0	,405.6	,
                092.0	,-022.0	,391.5	,
                143.7	,-037.5	,344.6	,
                098.8	,-027.0	,269.0	,
            }
        },
    [tpz.zone.ROLANBERRY_FIELDS_S] =
        {
            zoneID = tpz.zone.ROLANBERRY_FIELDS_S,
            mobID = 17150321,
            pathList = {
                025.0	,-008.7	,-346.8	,
                016.6	,-007.7	,-377.0	,
                -020.0	,-004.3	,-328.0	,
                -055.7	,-001.0	,-370.7	,
                -051.0	,000.0	,-465.0	,
                -092.8	,004.2	,-540.0	,
                -032.0	,004.8	,-584.5	,
                -019.0	,001.0	,-654.8	,
                -071.0	,-006.9	,-631.6	,
                -116.6	,-007.0	,-592.8	,
                -109.8	,-007.0	,-553.0	,
                -220.0	,004.0	,-478.7	,
                -219.0	,004.4	,-344.0	,
                -181.0	,004.4	,-330.0	,
                -171.0	,004.8	,-303.0	,
                -142.7	,004.6	,-234.7	,
                -185.0	,004.8	,-186.0	,
                -228.8	,004.5	,-141.5	,
                -235.7	,000.0	,-052.0	,
                -229.0	,-003.6	,-025.5	,
                -209.6	,-007.6	,-037.5	,
                -176.7	,-007.0	,-080.5	,
                -141.3	,-008.0	,-089.0	,
                -083.9	,-007.7	,-139.5	,
                -042.0	,-007.3	,-185.0	,
            }
        },
    [tpz.zone.GRAUBERG_S] =
        {
            zoneID = tpz.zone.GRAUBERG_S,
            mobID = 17142112,
            pathList = {
                344.4	,036.7	,-443.0	,
                310.5	,027.0	,-429.5	,
                273.5	,016.3	,-404.7	,
                212.0	,010.0	,-393.6	,
                158.5	,-004.8	,-380.0	,
                093.0	,-015.7	,-333.8	,
                032.0	,-019.0	,-308.8	,
                000.7	,-032.0	,-280.5	,
                063.5	,-029.5	,-373.0	,
                130.6	,-039.5	,-208.0	,
                170.0	,-023.5	,-240.5	,
                225.0	,-010.0	,-290.0	,
                249.0	,008.6	,-365.0	,
                302.0	,018.0	,-388.0	,
                367.8	,017.0	,-364.0	,
                436.0	,017.3	,-332.6	,
                506.0	,015.0	,-293.0	,
                539.5	,015.8	,-296.7	,
                528.5	,025.0	,-369.8	,
                506.5	,040.0	,-399.0	,
                461.8	,039.0	,-412.0	,
                388.8	,031.0	,-408.7	,
            }
        },
    [tpz.zone.BATALLIA_DOWNS_S] =
        {
            zoneID = tpz.zone.BATALLIA_DOWNS_S,
            mobID = 17121697,
            pathList = {
                -083.0	,-008.0	,035.0	,
                -059.0	,-008.0	,008.0	,
                -090.5	,-009.5	,-027.0	,
                -145.5	,-018.0	,-024.7	,
                -181.5	,-018.5	,-004.0	,
                -243.0	,-022.2	,-027.8	,
                -301.0	,-018.6	,-017.0	,
                -363.0	,-024.0	,-038.5	,
                -459.0	,-005.7	,033.5	,
                -443.7	,-011.5	,056.8	,
                -418.7	,-013.0	,175.0	,
                -387.5	,-013.8	,219.5	,
                -299.0	,-010.5	,220.8	,
                -261.0	,-005.5	,233.7	,
                -254.5	,-005.0	,293.8	,
                -185.5	,002.5	,294.0	,
                -086.0	,000.0	,257.5	,
                -099.5	,002.0	,164.5	,
                -049.5	,002.5	,103.0	,
                000.0	,000.0	,046.0	,
            }
        },
    [tpz.zone.FORT_KARUGO_NARUGO_S] =
        {
            zoneID = tpz.zone.FORT_KARUGO_NARUGO_S,
            mobID = 17170649,
            pathList = {
                -088.8	,-068.0	,-269.5	,
                -025.0	,-067.0	,-282.5	,
                023.7	,-068.0	,-232.0	,
                054.7   ,-069.7 ,-178.0 ,
                085.0	,-064.0	,-165.5	,
                105.5	,-065.0	,-180.0	,
                136.0	,-059.0	,-215.5	,
                180.7	,-056.0	,-195.5	,
                198.0	,-057.8	,-146.7	,
                199.0	,-043.0	,-062.5	,
                200.8   ,-040.0 ,-026.4 ,
                205.7	,-028.0	,021.3	,
                256.6	,-022.0	,025.0	,
                281.6	,-026.5	,010.0	,
                259.5	,-029.8	,-049.5	,
                239.0	,-040.5	,-100.0	,
                205.7	,-057.0	,-145.0	,
                194.0	,-054.0	,-186.0	,
                180.7	,-047.5	,-227.2	,
                135.0	,-050.8	,-251.0	,
                107.8	,-061.7	,-295.5	,
                097.0	,-061.5	,-307.5	,
                041.0	,-068.0	,-321.0	,
                -007.0	,-067.9	,-301.0	,
                -052.5	,-067.7	,-275.0	,
            }
    },
    [tpz.zone.EAST_RONFAURE_S] =
        {
            zoneID = tpz.zone.EAST_RONFAURE_S,
            mobID = 17109367,
            pathList = {
                236.0	,-020.0	,-323.0	,
                245.6	,-019.5	,-290.0	,
                291.0	,-016.0	,-257.5	,
                358.5	,-016.0	,-259.0	,
                384.7	,-015.0	,-227.0	,
                405.0	,-016.7	,-220.0	,
                434.0	,-016.7	,-220.0	,
                459.0	,-015.7	,-225.5	,
                469.0	,-015.0	,-256.0	,
                496.0	,-015.0	,-266.6	,
                498.0	,-016.0	,-303.0	,
                501.0	,-015.0	,-327.5	,
                509.0	,-005.0	,-376.8	,
                537.0	,-005.5	,-387.0	,
                537.0	,-006.0	,-437.0	,
                514.0	,-009.0	,-450.5	,
                480.0	,-009.6	,-446.6	,
                438.0	,-010.0	,-440.5	,
                411.4	,-010.0	,-393.0	,
                368.5	,-010.0	,-407.0	,
                346.0	,-007.0	,-429.8	,
                318.2	,000.0	,-437.6	,
                271.5	,004.3	,-461.6	,
                219.7   ,-17    ,-334   ,
            }
        },
}


darkixion.endStomp = function(mob)
    mob:setLocalVar("charging", 0)
    mob:AnimationSub(mob:getLocalVar("originalSub"))
    mob:speed(70)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("lastHit", 0)
    mob:setLocalVar("run", mob:getLocalVar("run") - 1)

    -- Don't move around if doing multiple tramples
    if mob:getLocalVar("run") > 0 then
        mob:setLocalVar("timeSinceWS", os.time() + 2)
    end
    mob:timer(2000, function(mobArg)
        if mobArg:getLocalVar("charging") ==  0 then
            mobArg:setBehaviour(0)
        end
    end)

    mob:SetMobSkillAttack(39)
    pos = nil
    hitList = nil

end

darkixion.itsStompinTime = function(mob)
    local targets = {}
    -- hitList is a list of all players considered for this trample. If they get out of the way, they do not get hit
    hitList = {}
    mob:setLocalVar("charging", 1)
    mob:setLocalVar("originalSub", mob:AnimationSub())
    mob:AnimationSub(1)
    -- remove bind
    mob:delStatusEffect(tpz.effect.BIND)
    mob:delStatusEffect(tpz.effect.WEIGHT)
    mob:speed(90)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobSkillAttack(0)
    mob:setBehaviour(tpz.behavior.NO_TURN + tpz.behavior.STANDBACK)
    local nearbyPlayers = mob:getPlayersInRange(30)

   for _, player in pairs(nearbyPlayers) do -- find eligible players to curb stomp
        local posP = player:getPos()
        local posM = mob:getPos()
        if math.abs(posP.y-posM.y) <= 7 and player:isAlive() and mob:checkDistance(posP) > 5 then -- no cliff jumping, may need to tune
            table.insert(targets, player)
        end
   end

    if (#targets) > 0 then -- pick one and run to it
       local target = targets[math.random(#targets)]
        pos = target:getPos()

        if mob:checkDistance(pos) < 25 then -- very short range and boring...
            local Mx = mob:getXPos()
            local Mz = mob:getZPos()
            local Ty = target:getYPos()
            local Tx = target:getXPos()
            local Tz = target:getZPos()
            local Dx = Tx - Mx
            local Dz = Tz - Mz
            local RSS = math.sqrt(Dx*Dx + Dz*Dz)


            local Ux = Dx/RSS
            local Uz = Dz/RSS
            pos = {x = Tx + (Ux * 7), y = Ty, z = Tz + (Uz * 7)}
        elseif mob:checkDistance(pos) < 5 then
            mob:lookAt(pos)
            pos = mob:getPos()
        end

        mob:lookAt(target:getPos())
        mob:setLocalVar("runPathTime", os.time() + 10) -- max time to let a single trample path
        mob:pathTo(pos.x, pos.y, pos.z, tpz.path.flag.WALLHACK + tpz.path.flag.RUN + tpz.path.flag.SCRIPT + tpz.path.flag.SLIDE)
    else
        darkixion.endStomp(mob)
    end
end

darkixion.repop = function(mob)
    DespawnMob(mob:getID())
    local keys = {}
    for k in pairs(darkixion.zoneinfo) do table.insert(keys, k) end
    randZoneID = darkixion.zoneinfo[keys[math.random(#keys)]].zoneID
    SetServerVariable("DarkIxion_ZoneID", randZoneID)
    -- wiki says "It can pop there in less than 10 seconds or take the whole 15 minutes"
    SetServerVariable("DarkIxion_PopTime", os.time() + math.random(1, 15 * 60)) -- based on onGameHour function timing
end

darkixion.roamingMods = function(mob)
    -- don't take damage until the fight officially starts
    mob:setMod(tpz.mod.UDMGPHYS   , -100)
    mob:setMod(tpz.mod.UDMGRANGE  , -100)
    mob:setMod(tpz.mod.UDMGBREATH , -100)
    mob:setMod(tpz.mod.UDMGMAGIC  , -100)

    -- restore hp just in case something caused him to regen while roaming
    local HP = GetServerVariable("DarkIxion_HP")
    if HP == 0 then
        HP = mob:getHP()
        SetServerVariable("DarkIxion_HP", HP)
    end
    mob:setHP(HP)

    -- restore horn status
    if GetServerVariable("DarkIxion_HornStatus") == 1 then
        mob:AnimationSub(2)
        mob:hideHP(false)
    else
        mob:AnimationSub(0)
        mob:hideHP(true)
    end

    mob:SetMobSkillAttack(39)
    mob:setLocalVar("charging", 0)
    mob:setLocalVar("double", 0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("lastHit", 0)
    mob:setBehaviour(0)
end

darkixion.onZoneInit = function(zone)
    local ixionID = darkixion.zoneinfo[zone:getID()].mobID
    local ixionZoneID = GetServerVariable("DarkIxion_ZoneID")
    local ixion = GetMobByID(ixionID)
	-- check this on only one zone to catch when ixion has no zone assignment
	if ixionZoneID == 0 or
        (GetServerVariable("DarkIxion_PopTime") < os.time() and ixionZoneID == zone:getID()) then
            if ixionZoneID == 0 then darkixion.repop(ixion) end
            -- "If Dark Ixion is due to spawn or is already spawned during maintenance, he will spawn shortly after server comes back online."
            SetServerVariable("DarkIxion_PopTime", os.time() + 10)
	elseif (GetServerVariable("DarkIxion_PopTime") > os.time() and ixionZoneID == zone:getID()) then
		-- leave zone alone, push back repop ... since zone was already randomized, implied by PopTime being in the future
		-- "If he was not due to spawn during this time frame (after maintenance), his spawn window will reset to 21 hours after servers come online."
		SetServerVariable("DarkIxion_PopTime", os.time() + 21 * 60 * 60)
	end
end

darkixion.onZoneGameHour = function(zone)
    local ixionID = darkixion.zoneinfo[zone:getID()].mobID
    local ixion = GetMobByID(ixionID)
    if GetServerVariable("DarkIxion_ZoneID") == zone:getID() and GetServerVariable("DarkIxion_PopTime") < os.time() - 24 * 60 * 60 then
        -- wander logic in onGameHour so even zones with no players can hold DI and cycle him out
        darkixion.repop(ixion)
	elseif not ixion:isSpawned() and
		GetServerVariable("DarkIxion_ZoneID") == zone:getID() and
		GetServerVariable("DarkIxion_PopTime") < os.time() - 45 then
            -- if gamehour flip is within 45s, randomly spawn within next twice that
			ixion:setRespawnTime(math.random(0,90))
    elseif ixion:isSpawned() and GetServerVariable("DarkIxion_ZoneID") ~= zone:getID() then
        -- really shouldn't be possible, but catch just in case
        if ixion:isEngaged() then
            ixion:disengage()
        else
            DespawnMob(ixionID)
        end
    end
end

darkixion.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.IXION_HORNBREAKER)
    -- only reset hp after being killed
    SetServerVariable("DarkIxion_HP", 0)
    SetServerVariable("DarkIxion_HornStatus", 0)
    if player then
        player:PrintToPlayer(string.format("%s : The pixies ... will ... not be ... happy about ... thisssss", mob:getName()), 0xD)
    end
    if isKiller == true then
        mob:setLocalVar("wasKilled", 1)
        -- move pixie amity towards zero
        local amity = GetServerVariable("PixieAmity")
        if amity > 150 then
            SetServerVariable("PixieAmity", utils.clamp(math.floor((amity) * .85), -255, 255))
        end
    end
end

darkixion.onMobDespawn = function(mob)
    mob:removeListener("IXION_TAKE_DAMAGE")
    DisallowRespawn(mob:getID(), true)
    if mob:getZoneID() == GetServerVariable("DarkIxion_ZoneID") then
        darkixion.repop(mob)
        if mob:getLocalVar("wasKilled") == 1 then
            if GetServerVariable("PixieAmity") > 200 then
                SetServerVariable("DarkIxion_PopTime", os.time() + math.random(60, 120) * 60) -- repop 1-2 hours after death
            else
                SetServerVariable("DarkIxion_PopTime", os.time() + math.random(20,24) * 60 * 60) -- repop 20-24 hours after death
            end
        end
    end
end

darkixion.onCriticalHit = function(mob, attacker)
    local RND = math.random(1, 100)
    if (mob:AnimationSub() == 0 or mob:AnimationSub() == 3) and
        (attacker ~= nil and attacker:isInfront(mob)) and
        RND <= 5 then
            mob:AnimationSub(2)
            mob:setLocalVar("double", 0)
            mob:hideHP(false)
    end
end

darkixion.onWeaponskillHit = function(mob, attacker, weaponskill)
    local RND = math.random(1, 100)
    if (mob:AnimationSub() == 0 or mob:AnimationSub() == 3) and
        (attacker ~= nil and attacker:isInfront(mob)) and
        RND <= 5 then
            mob:AnimationSub(2)
            mob:setLocalVar("double", 0)
            mob:hideHP(false)
    end
    return 0
end

darkixion.onMobInitialize = function(mob)
end

darkixion.onMobSpawn = function(mob)
    -- "Dark Ixion takes much less damage from the front (50-75% less) and full damage from behind it"
    --[[mob:addListener("TAKE_DAMAGE", "IXION_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        -- dmg reduction only when horn is intact
        if attacker ~= nil and mobArg:AnimationSub() ~= 2 and
            attacker:isInfront(mobArg, 128) and amount > 0 then
                -- add the HP difference between dmg taken and what it should have taken
                local dmgReduction = amount * math.random(50, 75) / 100
                mobArg:addHP(dmgReduction)
                printf("dmg taken %u dmg restored %u", amount, dmgReduction)
                if attacker:isPC() then
                    attacker:PrintToPlayer(string.format( "Adjusted damage from %s to %s from front: %u", attacker:getName(), mobArg:getName(), amount - dmgReduction ), 0xD)
                end
        end
    end)]]
    darkixion.roamingMods(mob)
    SetServerVariable("DarkIxion_PopTime", os.time())
    mob:setLocalVar("wasKilled", 0)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.STUNRES, 100)

    mob:setMobMod(tpz.mobMod.NO_REST, 10)
    mob:setAggressive(1)
end


darkixion.onMobWeaponSkillPrepare = function(mob, target)
    -- skill unknown, tp still there
    -- preserve tp from melee swings, from SetMobSkillAttack
    mob:setLocalVar("skill_tp", mob:getTP() + 64) -- give tp for the auto attack (confirmed by not replacing autos with mobskilllist)
end

darkixion.onMobWeaponSkill = function(target, mob, skill)
    -- skill chosen, tp already wiped
    if not (skill:getID() == 2340 or skill:getID() == 2341) then
        -- add slight delay to WS selection if not an autoattack
        mob:setLocalVar("timeSinceWS", os.time())
    end
end

darkixion.onMobSkillFinished = function(mob, target, skill)
    -- skill finished

    -- don't reset behavior for di_trample
    if skill:getID() ~= 2339 then
        mob:setBehaviour(0)
    end

    -- Below handles the charge > zap logic, including if DI is glowing
    -- zap -> lightning spear
    -- zap2 -> Wrath of Zeus
    if skill:getID() == 2345 then
        mob:setLocalVar("zap", mob:getLocalVar("double") == 1 and 2 or 1)
        mob:setLocalVar("zapTime", os.time()+5)
    end

    if skill:getID() == 2344 then
        mob:setLocalVar("zap2", mob:getLocalVar("double") == 1 and 2 or 1)
        mob:setLocalVar("zapTime2", os.time()+5)
    end

    -- determine if we want to run soon, do it randomly off autos, more frequent and more runs when low
    if os.time() >= mob:getLocalVar("timeSinceWS") + 2 and mob:AnimationSub() ~= 3 and (skill:getID() == 2340 or skill:getID() == 2341) then
        local R = math.random(1,100)
        if R >= 70 and mob:getHPP() < 33 then
            mob:setLocalVar("run", mob:getLocalVar("run") + math.random(1,3))

        elseif R >= 80 and mob:getHPP() < 50 then
            mob:setLocalVar("run", mob:getLocalVar("run") + math.random(1,2))

        elseif R >= 90 then
            mob:setLocalVar("run", mob:getLocalVar("run") + 1)
        end
        mob:setLocalVar("runTime", os.time()+5)
    end

    if mob:getLocalVar("run") > 3 then -- Safety net
        mob:setLocalVar("run", 3)
    end


    if skill:getID() == 2337 then -- sometimes after healing, fix horn
        if mob:AnimationSub() == 2 and math.random(1,100) <= 25 then
            mob:AnimationSub(3)
            mob:hideHP(true)
            mob:setLocalVar("double", 0)
            -- reset phasechange timer
            mob:setLocalVar("PhaseChange", os.time() + math.random(60, 240))
            -- If horn is restored by heal, we don't want to glow longterm, but animation sub cannot be changed back to back
            mob:timer(2000, function(mobArg)
                mobArg:AnimationSub(0)
            end)
        end
    end

    -- Lets keep count of how many auto attacks we have done and wipe localvar for tp for next mobskill
    if skill:getID() == 2340 or skill:getID() == 2341 then
        mob:setLocalVar("Hits",mob:getLocalVar("Hits")+1)
        -- restore tp to emulate tp gain from melee swings, from SetMobSkillAttack
        mob:addTP(mob:getLocalVar("skill_tp"))
    else
        -- add slight delay to WS selection if not an autoattack
        mob:setLocalVar("timeSinceWS", os.time())
    end
    mob:setLocalVar("skill_tp", 0)
end

darkixion.onAdditionalEffect = function(mob, target, damage)
end

darkixion.onMobRoamAction = function(mob)
end

darkixion.onMobRoam = function(mob)
    if mob:getLocalVar("RunAway") ~= 0 and mob:getLocalVar("RunAway") + 60 < os.time()
        then
            -- time to repop somewhere else
            darkixion.repop(mob)
    elseif mob:getLocalVar("RunAway") ~= 0 then
        -- run fast before repopping
        mob:speed(180) -- movement +350% = 40 * 4.5
    else
        mob:speed(70) -- movement +75% = 40 * 1.75
    end


    if math.random(1000) < 10 or mob:getLocalVar("RunAway") > os.time() then
        -- low chance to reverse path or if RunAway is later than now just stand still for a bit
        if mob:isFollowingPath() then
            tpz.path.patrolsimple(mob, darkixion.zoneinfo[mob:getZoneID()].pathList, tpz.path.flag.REVERSE)
        end
    else
        tpz.path.patrolsimple(mob, darkixion.zoneinfo[mob:getZoneID()].pathList, tpz.path.flag.RUN)
    end

end

darkixion.onMobEngaged = function(mob, target)
    mob:setMod(tpz.mod.REGAIN, 200) -- "has tp regen": https://www.bluegartr.com/threads/59044-Ixion-discussion-thread/page8
    darkixion.roamingMods(mob)
    -- if stygian ash missed or aggro via any other means, immediately disengage (even if hearing aggro "If you get too close, DI runs away")
    if mob:getLocalVar("StygianLanded") ~= 1 then
        mob:disengage()
    end
    mob:setMod(tpz.mod.UDMGPHYS   , 0)
    mob:setMod(tpz.mod.UDMGRANGE  , 0)
    mob:setMod(tpz.mod.UDMGBREATH , 0)
    mob:setMod(tpz.mod.UDMGMAGIC  , 0)

    mob:setLocalVar("run", 0)
    mob:setLocalVar("PhaseChange", os.time() + math.random(60, 240))
    mob:speed(70) -- movement +75% = 40 * 1.75
end

darkixion.onMobDisengage = function(mob)
    SetServerVariable("DarkIxion_HP", mob:getHP())
    if mob:AnimationSub() == 2 then
        SetServerVariable("DarkIxion_HornStatus", 1)
    else
        SetServerVariable("DarkIxion_HornStatus", 0)
    end

    darkixion.roamingMods(mob)
    if mob:getLocalVar("RunAway") == 0 then
        -- disengage, give one window of him standing still unclaimed before "Running away"
        mob:setLocalVar("RunAway", os.time() + 15)
    else
        -- just reset time until despawn
        mob:setLocalVar("RunAway", os.time())
    end

    -- no chance of him staying in this zone unless an ash is landed before he runs away and despawns
    mob:setAggressive(0)
    mob:setLocalVar("StygianLanded", 0)
end

darkixion.onMobFight = function(mob, target)
    -- Since its autos are technically TP moves, lets deal with the other fancy stuff here
    if ((mob:getTP() >= 2900 and mob:getHPP() > 66) or
       (mob:getTP() >= 1900 and mob:getHPP() > 33) or
       (mob:getTP() >= 900 and mob:getHPP() > 0)) and
       mob:getLocalVar("timeSinceWS") < os.time() - 3 and
       mob:actionQueueEmpty() then
        mob:setLocalVar("timeToWS", 1)
        mob:setLocalVar("Hits", 0)
    end

    if mob:getLocalVar("timeToWS") == 1 and mob:getLocalVar("timeSinceWS") < os.time() - 1 and mob:AnimationSub() ~= 1 then -- then if we has enough "tp", we can WS
        mob:setLocalVar("timeToWS", 0)
        mob:setTP(0)
        local WS = math.random(1,4)
        if math.random(1,10) == 1 then
            mob:useMobAbility(2337) -- Damsel Memento
        else
            if WS == 1 then
                mob:useMobAbility(2338, mob) -- Rampant Stance
                if mob:getLocalVar("double") == 1 then
                    mob:useMobAbility(2338, mob) -- Rampant Stance
                end
            elseif WS == 2 then
                mob:setBehaviour(tpz.behavior.NO_TURN + tpz.behavior.STANDBACK)
                local Mx = mob:getXPos()
                local Mz = mob:getZPos()
                local My = mob:getYPos()
                local Tx = target:getXPos()
                local Tz = target:getZPos()
                local Dx = Tx - Mx
                local Dz = Tz - Mz
                local away = {x = Mx-Dx, y = My, z = Mz-Dz}
                mob:lookAt(away)
                mob:useMobAbility(2336, mob) -- Acheron Kick
                if mob:getLocalVar("double") == 1 then
                    -- since no_turn is enabled, no need to change position again, just do it back to back
                    mob:useMobAbility(2336, mob) -- Acheron Kick
                end
            elseif WS == 3 then
                mob:useMobAbility(2344) -- Wrath of Zeus (target the glow first, then real WS)
            elseif WS == 4 then
                mob:useMobAbility(2345) -- Lightning Spear (target the glow first, then real WS)
            end
        end
    else


        -- This is called after charging to either perform WoZ (zap2) or LS (zap)
        if mob:getLocalVar("zap2") >= 1 and mob:getLocalVar("timeSinceWS") < os.time() - 1 and os.time() >= mob:getLocalVar("zapTime2") and mob:AnimationSub() ~= 1 then
            mob:setLocalVar("zap2", mob:getLocalVar("zap2") - 1)
            mob:setTP(0)
            mob:setBehaviour(tpz.behavior.NO_TURN + tpz.behavior.STANDBACK)
            mob:useMobAbility(2334, mob)
            mob:setLocalVar("zapTime2", os.time()+7)
        end

        if mob:getLocalVar("zap") >= 1 and mob:getLocalVar("timeSinceWS") < os.time() - 1 and os.time() >= mob:getLocalVar("zapTime") and mob:AnimationSub() ~= 1 then
            mob:setLocalVar("zap", mob:getLocalVar("zap") - 1)
            mob:setTP(0)
            mob:setBehaviour(tpz.behavior.NO_TURN + tpz.behavior.STANDBACK)
            local Mx = mob:getXPos()
            local Mz = mob:getZPos()
            local My = mob:getYPos()
            local Dx = math.random(-4,4)
            local Dz = math.random(-4,4)
            local away = {x = Mx-Dx, y = My, z = Mz-Dz}
            mob:lookAt(away)
            mob:useMobAbility(2335, mob)
            mob:setLocalVar("zapTime", os.time()+7)
        end
    end

    -- This section deals with him glowing (double TP moves)
    if os.time() >= mob:getLocalVar("PhaseChange") and mob:AnimationSub()~= 2 and (mob:AnimationSub() == 0 or mob:AnimationSub() == 3) then
        mob:setLocalVar("PhaseChange", os.time() + math.random(60, 240))
        if mob:AnimationSub() == 0 then
            mob:setLocalVar("double", 1)
            mob:AnimationSub(3)
        else
            mob:setLocalVar("double", 0)
            mob:AnimationSub(0)
        end
    end


    -- Everything below deals with his charge attack (trample)
    if mob:getLocalVar("run") >= 1 and os.time() >= mob:getLocalVar("runTime") and
        mob:getLocalVar("charging") == 0 and
        mob:AnimationSub() < 2 then -- don't trample if horn is broken
            darkixion.itsStompinTime(mob)
            mob:setTP(0)
    end

    if mob:getLocalVar("charging") == 1 then
        -- if trample is going through tank, let tank get hit, otherwise push onto the hitList without trampling
        -- if all other players are behind DI then tank should never get hit with trample
        if not target:isInfront(mob, 100) then
            table.insert(hitList, target)
        end
        if mob:checkDistance(pos) >= 2 and os.time() < mob:getLocalVar("runPathTime") then
            local nearbyPlayers = mob:getPlayersInRange(8)
            if nearbyPlayers ~= nil then
                for  aa = 1, (#nearbyPlayers) do -- look for players that are too close to ixion while he tramples, hit the ones in front
                    mob:setLocalVar("stomp", 0)

                    local dork = nearbyPlayers[aa]
                    if dork:isAlive() then
                        local nextHit = dork:getID()
                        if (#hitList) == 0 then
                            table.insert(hitList, nextHit)
                            mob:setLocalVar("stomp", 1)
                        else
                            for v = 1, (#hitList) do
                                if hitList[v] == nextHit then
                                    mob:setLocalVar("stomp", 1)
                                end
                            end
                            if mob:getLocalVar("stomp") == 0 then
                                table.insert(hitList, nextHit)
                                mob:setLocalVar("stomp", 1)
                            else
                                mob:setLocalVar("stomp", 0)
                            end
                        end
                        if dork:isInfront(mob, 20) and mob:getLocalVar("stomp") ~= 0 then
                            mob:useMobAbility(2339, dork) -- trample
                        end
                    end
                end
            end
        else
            darkixion.endStomp(mob)
        end
    end
end

darkixion.onTradeFaySpring = function(player, npc)
    local amity = GetServerVariable("PixieAmity")
    if amity == 255 then
        player:PrintToPlayer(string.format("Fay Spring : The Pixies are now happy, but something else has been disturbed from its slumber...! Dark Ixion now roams (if he wasn't already)!"), 0xD)
        -- reset DI ToD/next pop so on next game hour he begins roaming in his already-selected, random zone
        if GetServerVariable("DarkIxion_PopTime") + 1200 < os.time() then
            -- break horn if he is already up
            SetServerVariable("DarkIxion_HornStatus", 1)
        end
        SetServerVariable("DarkIxion_PopTime", os.time())
    end
end
