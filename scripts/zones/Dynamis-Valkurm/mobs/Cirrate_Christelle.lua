-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Cirrate Christelle
-- Note: Mega Boss
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 39

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil and mobList[zone][mobID].eyes or 0)
    dynamis.setMegaBossStats(mob)

    -- Set Mods
    mob:speed(140)
    mob:SetAutoAttackEnabled(false)
    
    -- Set Power Vars
    local miasmicbreathpower = math.random(150, 200)
    mob:setLocalVar("fragrantbreathduration", 180)
    mob:setLocalVar("miasmicbreathpower", miasmicbreathpower)
    mob:setLocalVar("putridbreathcap", 1500)
    mob:setLocalVar("vampiriclashpower", 5)
end

function onMobDeath(mob, player, isKiller)
    require("scripts/zones/Dynamis-Valkurm/dynamis_mobs")
    local ID = require("scripts/zones/Dynamis-Valkurm/IDs")
    dynamis.statueOnDeath(mob, player, isKiller)
    dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local winQM = GetNPCByID(16937586)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_VALKURM_INTERLOPER)
end

function onMobRoamAction(mob)
    dynamis.mobOnRoamAction(mob)
end

function onMobRoam(mob)
    dynamis.mobOnRoam(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
    mob:setTP(0)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob)
    mob:setMod(tpz.mod.REGAIN, 1250)
    local ID = zones[zone]
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

    -- Dragontrap Kill Check: If not killed should spawn 2 Morbols on Engage.
    if GetMobByID(ID.mobs.Dragontrap_1):getStatus() ~= 2 or GetMobByID(ID.mobs.Dragontrap_2):getStatus() ~= 2 or GetMobByID(ID.mobs.Dragontrap_3):getStatus() ~= 2 then
        if mob:getLocalVar("PetsSpawned") ~= 1 then
            GetMobByID(ID.mobs.Nightmare_Morbol_1):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Nightmare_Morbol_1):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Nightmare_Morbol_1):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mobs.Nightmare_Morbol_2):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mobs.Nightmare_Morbol_2):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mobs.Nightmare_Morbol_2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            mob:setLocalVar("PetsSpawned", 1)
        end
    end
    if GetMobByID(ID.mobs.Dragontrap_1):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_2):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_3):getStatus() == 2 then
        mob:setLocalVar("putridbreathcap", 500)
    end
    if GetMobByID(ID.mobs.Fairy_Ring):getStatus() == 2 then
        mob:speed(40)
        mob:setLocalVar("miasmicbreathpower", 30)
    end
    if GetMobByID(ID.mobs.Nantina):getStatus() == 2 then
        mob:setLocalVar("fragrantbreathduration", 30)
    end
    if GetMobByID(ID.mobs.Stcemqestcint):getStatus() == 2 then
        mob:setLocalVar("vampiriclashpower", 1)
    end

    

end

function onMobWeaponSkillPrepare(mob, target)
    -- Set Locals
    local ID = zones[zone]
    local fragrantbreath = 24
    local miasmicbreath = 24
    local putridbreath = 24
    local vampiriclash = 24
    local randomchance = math.random(1, 100)
    local totalchance = 100

    -- Set Probabilities of Each Skill Based on NM Kill Status
    if GetMobByID(ID.mobs.Nantina):getStatus() == 2 then
        fragrantbreath = 12
    end
    if GetMobByID(ID.mobs.Fairy_Ring):getStatus() == 2 then
        miasmicbreath = 12
    end
    if GetMobByID(ID.mobs.Dragontrap_1):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_2):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_3):getStatus() == 2 then
        putridbreath = 12
    end
    if GetMobByID(ID.mobs.Stcemqestcint):getStatus() == 2 then
        vampiriclash = 12
    end

    -- Choose Skill
    if randomchance >= (totalchance - fragrantbreath) then
        return 1607 -- Fragrant Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath)) then
        return 1605 -- Miasmic Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath)) then
        return 1609 -- Putrid Breath
    elseif randomchance >= (totalchance - (fragrantbreath + miasmicbreath + putridbreath + vampiriclash)) then
        return 1611 -- Vampiric Lash
    else
        return 1610 -- Extremely Bad Breath: Gains Chance as Other Skills are Mitigated
    end
end