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
    mob:setTP(0)
end

function onMobEngaged(mob, target)
    -- Dragontrap Kill Check: If not killed should spawn 2 Morbols on Engage.
    if GetMobByID(ID.mobs.Dragontrap_1):getStatus() ~= 2 or GetMobByID(ID.mobs.Dragontrap_2):getStatus() ~= 2 or GetMobByID(ID.mobs.Dragontrap_3):getStatus() ~= 2 then
        if mob:getLocalVar("PetsSpawned") ~= 1 then
            local morbol = GetMobByID(ID.mobs.Nightmare_Morbol_1)
            morbol:setDropID(0) -- don't drop 100-type pieces
            morbol:setSpawn(mobX, mobY, mobZ)
            morbol:setPos(mobX, mobY, mobZ)
            SpawnMob(morbol:getID()):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())

            morbol = GetMobByID(ID.mobs.Nightmare_Morbol_2)
            morbol:setDropID(0) -- don't drop 100-type pieces
            morbol:setSpawn(mobX, mobY, mobZ)
            morbol:setPos(mobX, mobY, mobZ)
            SpawnMob(morbol:getID()):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())

            mob:setLocalVar("PetsSpawned", 1)
        end
    end
end

function onMobFight(mob)
    mob:setMod(tpz.mod.REGAIN, 500)
    local ID = zones[zone]
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()


    -- wiki says these moves are "inhibited" when the respective NMs are defeated
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
    local baseTPMoveChance = 12
    local fragrantbreath = baseTPMoveChance
    local miasmicbreath = baseTPMoveChance
    local putridbreath = baseTPMoveChance
    local vampiriclash = baseTPMoveChance
    local extremelybadbreath = baseTPMoveChance

    -- Set Probabilities of Each Skill Based on NM Kill Status
    -- https://wiki-ffo-jp.translate.goog/html/25159.html?_x_tr_sch=http&_x_tr_sl=auto&_x_tr_tl=en&_x_tr_hl=it&_x_tr_pto=wapp
    -- tl;dr:
    -- nantina reduces chance of fragrant breath
    -- fairy ring reduces chance of miasmic breath
    -- dragontraps reduce chance of extremely bad breath (by doubling chance of all the others)
    if GetMobByID(ID.mobs.Nantina):getStatus() == 2 then
        -- equivalent: Deodorant moss
        fragrantbreath = baseTPMoveChance / 2
        vampiriclash = baseTPMoveChance * 2
    end
    if GetMobByID(ID.mobs.Fairy_Ring):getStatus() == 2 then
        -- equivalent: odorless mushroom
        miasmicbreath = baseTPMoveChance / 2
        vampiriclash = baseTPMoveChance * 2
    end

    local totalchance = fragrantbreath + miasmicbreath + putridbreath + vampiriclash
    if GetMobByID(ID.mobs.Dragontrap_1):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_2):getStatus() == 2 and GetMobByID(ID.mobs.Dragontrap_3):getStatus() == 2 then
        -- reduces chance of extremely bad breath
        totalchance = totalchance * 2
    end
    local randomchance = math.random(1, totalchance + extremelybadbreath)

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
        return 1610 -- Extremely Bad Breath remainder of random range
    end
end