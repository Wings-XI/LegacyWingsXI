require("scripts/globals/settings")
require("scripts/globals/pathfind")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/zone")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
mixins = {
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage"),
}

darkixion = {}

-- TODOs, notes, and reminders
-- DB Tweaks: Mowford is of the opinion we don't need to move them, i like seeing it more explicit in lua
  -- We can move stun and sleep resist to mob_pools
  -- can modify base speed in mob family, if we want
-- need to reference oncriticalhit and onweaponskillhit on ohter luas
  -- DONE
-- Charges currently time baised, good for testing,
  -- i want to change that logic to randomly use after WS
-- remove print statements
-- fine tune the cliff jumping distance
-- mob:AnimationSub() -- 0 is normal || Charging is animation sub 1  || 2 is broken horn || 3 is glowing and repairs horn
-- still gotta make shit cast twice if glowing, finish up charges, make it charge a lot while low
-- slow down lightning tp moves to give u time to run, figure out if it does thunder w/o horn
-- hp is supposed to be hidden until his horn is broken
  -- i assume animation sub is reset when he runs away?
  -- if not we need to store that as a server variable along with HP and reset when killed

  -- for charge, idk, maybe add roam flag 512 or 256

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
                -201    ,-30    ,147    ,
                -445    ,-16    ,78     ,
                -135    ,-1.7   ,297    ,
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
    mob:AnimationSub(0)
    mob:setMod(tpz.mod.MOVE, 70)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("lastHit", 0)
    print("done")
    mob:setLocalVar("run", os.time() + 5)
    pos = nil
    hitList = nil
    mob:setBehaviour(tpz.behavior.NO_TURN, 0)
end

darkixion.itsStompinTime = function(mob)
    local targets = {}
    hitList = {}
    print("start")
    mob:setLocalVar("charging", 1)
    mob:AnimationSub(1)
    mob:setMod(tpz.mod.MOVE, 180)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMagicCastingEnabled(false)
    local nearbyPlayers = mob:getPlayersInRange(30)

   for _, player in pairs(nearbyPlayers) do -- find eligible players to curb stomp
        local posP = player:getPos()
        local posM = mob:getPos()
        if math.abs(posP.y-posM.y) <= 7 and player:isAlive() then -- no cliff jumping, may need to tune
            table.insert(targets, player)
        end
   end

    if (#targets) > 0 then -- pick one and run to it
       local target = targets[math.random(#targets)]
        pos = target:getPos()


        mob:setBehaviour(tpz.behavior.NO_TURN, 1)
        mob:lookAt(pos)
        mob:pathTo(pos.x, pos.y, pos.z, tpz.path.flag.RUN)--, tpz.path.flag.WALLHACK) -- tpz.path.flag.RUN )--+ tpz.path.flag.SCRIPT)
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

darkixion.onZoneInit = function(zone)
    local ixionID = darkixion.zoneinfo[zone:getID()].mobID
    local ixionZoneID = GetServerVariable("DarkIxion_ZoneID")
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
	if ixion:getStatus() ~= STATUS_NORMAL and
		GetServerVariable("DarkIxion_ZoneID") == zone:getID() and
		GetServerVariable("DarkIxion_PopTime") < os.time() then
			SpawnMob(ixionID)
	end
end

darkixion.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.IXION_HORNBREAKER)
    -- only reset hp after being killed
    SetServerVariable("DarkIxion_HP", 0)
    if isKiller == true then
        mob:setLocalVar("wasKilled", 1)
    end
end

darkixion.onMobDespawn = function(mob)
    if mob:getLocalVar("wasKilled") == 1 then
        darkixion.repop(mob)
        SetServerVariable("DarkIxion_PopTime", os.time() + math.random(20,24) * 60 * 60) -- repop 20-24 hours after death same zone
    end
end

darkixion.onCriticalHit = function(mob)
    local RND = math.random(1, 100)
    if mob:AnimationSub() == 0 and RND <= 5 then
        mob:AnimationSub(2)
    end
end

darkixion.onWeaponskillHit = function(mob, attacker, weaponskill)
    local RND = math.random(1, 100)
    if mob:AnimationSub() == 0 and RND <= 5 then
        mob:AnimationSub(2)
    end
    return 0
end

darkixion.onMobInitialize = function(mob)
end

darkixion.onMobSpawn = function(mob)
    SetServerVariable("DarkIxion_PopTime", os.time())
    mob:setLocalVar("[rage]timer", 5400)
    mob:setLocalVar("wasKilled", 0)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.STUNRES, 100)
    mob:setLocalVar("charging", 0)
    mob:setLocalVar("lastHit", 0)

    mob:setMobMod(tpz.mobMod.NO_REST, 10)
end

darkixion.onAdditionalEffect = function(mob, target, damage)
    -- horn: en-bind
    -- feet: en-gravity
end

darkixion.onMobWeaponSkillPrepare = function(mob, target)
end

darkixion.onMobWeaponSkill = function(target, mob, skill)
end

darkixion.onMobRoamAction = function(mob)
end

darkixion.onMobRoam = function(mob)
    -- don't take damage until the fight officially starts
    mob:setMod(tpz.mod.UDMGPHYS   , -100)
    mob:setMod(tpz.mod.UDMGBREATH , -100)
    mob:setMod(tpz.mod.UDMGMAGIC  , -100)
    mob:setMod(tpz.mod.UDMGRANGE  , -100)
    local HP = GetServerVariable("DarkIxion_HP")
    if HP == 0 then
        HP = mob:getHP()
        SetServerVariable("DarkIxion_HP", HP)
    end
    mob:setHP(HP)
    if mob:getLocalVar("RunAway") ~= 0 and mob:getLocalVar("RunAway") + 60 < os.time()
        or  GetServerVariable("DarkIxion_PopTime") < os.time() - 24 * 60 * 60
        then
            -- time to repop somewhere else
            printf("vars %u %u", mob:getLocalVar("RunAway"), GetServerVariable("DarkIxion_PopTime"))
            darkixion.repop(mob)
    elseif mob:getLocalVar("RunAway") ~= 0 then
        -- run fast before repopping
        mob:speed(180) -- movement +350% = 40 * 4.5
    else
        mob:speed(70) -- movement +75% = 40 * 1.75
    end
    if not mob:hasStatusEffect(tpz.effect.BIND) then
        tpz.path.patrolsimple(mob, darkixion.zoneinfo[mob:getZoneID()].pathList, tpz.path.flag.RUN)
    end
end

darkixion.onMobEngaged = function(mob, target)
    -- if stygian ash missed or aggro via any other means, immediately disengage (even if hearing aggro "If you get too close, DI runs away")
    if mob:getLocalVar("StygianLanded") ~= 1 then
        mob:disengage()
    end
    mob:setMod(tpz.mod.UDMGPHYS   , 0)
    mob:setMod(tpz.mod.UDMGBREATH , 0)
    mob:setMod(tpz.mod.UDMGMAGIC  , 0)
    mob:setMod(tpz.mod.UDMGRANGE  , 0)
    mob:setLocalVar("run", os.time() + 10)
    mob:setLocalVar("PhaseChange", os.time() + math.random(60, 240))
    mob:speed(70) -- movement +75% = 40 * 1.75
end

darkixion.onMobDisengage = function(mob)
    -- disengage, give one 10-second window of him standing still unclaimed before "Running away"
    mob:addStatusEffect(tpz.effect.BIND, 0, 0, 10) -- bind will not stack if hit a second time to engage/disengage

    mob:setLocalVar("StygianLanded", 0)
    mob:setLocalVar("RunAway", os.time())
    SetServerVariable("DarkIxion_HP", mob:getHP())
end

darkixion.onMobFight = function(mob, target)
    -- mob:useMobAbility(2337) -- heal


    -- This section deals with him glowing (double TP moves)
    --[[
    if os.time() >=  mob:getLocalVar("PhaseChange") and (mob:AnimationSub() == 0 or mob:AnimationSub() == 3) then
        mob:setLocalVar("PhaseChange", os.time() + math.random(60, 240))
        if mob:AnimationSub() == 0 then
            mob:AnimationSub(3)
        else
            mob:AnimationSub(0)
        end
    end]]


    -- Everything below deals with his charge attack
    
    if os.time() >= mob:getLocalVar("run") and mob:getLocalVar("charging") == 0 then
        darkixion.itsStompinTime(mob)
    end

    if mob:getLocalVar("charging") == 1 and mob:checkDistance(pos) < 10 then
        darkixion.endStomp(mob)
    elseif mob:getLocalVar("charging") == 1 and mob:checkDistance(pos) >= 10 then

       -- mob:setBehaviour(tpz.behavior.NO_TURN, 1)
        --mob:lookAt(pos)
        --mob:pathTo(pos.x, pos.y, pos.z)

        local nearbyPlayers = mob:getPlayersInRange(5)
        if nearbyPlayers == nil then print("nothing near") return end

        for  aa = 1, (#nearbyPlayers) do -- look for players that are too close to ixion while he runs
            mob:setLocalVar("stomp", 0)

            local dork = nearbyPlayers[aa]
            if dork:isAlive() then
                local nextHit = dork:getID()
                if (#hitList) == 0 then
                    table.insert(hitList, nextHit)
                    --mob:useMobAbility(2339, nextHit) -- trample
                    print("trample")                
                    --return
                else
                    for v = 1, (#hitList) do
                        if hitList[v] == nextHit then
                            mob:setLocalVar("stomp", mob:getLocalVar("stomp")+1)
                        end
                    end
                    if mob:getLocalVar("stomp") == 0 then
                        --mob:useMobAbility(2339,dork) -- trample
                        print("trample")
                        
                        table.insert(hitList, nextHit)
                    end
                end
            end
        end
    end

    -- TODO: Remove this when fight is tuned
    -- reset hp to full if below 40%
    if mob:getHPP() < 40 then
        mob:setHP(mob:getMaxHP())
    end
end
