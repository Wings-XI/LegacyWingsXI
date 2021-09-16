-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Angra Mainyu
-- Note: Mega Boss
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/dynamis")
require("scripts/globals/status")
-----------------------------------

local zone = 134

local function Teleport(mob, hideDuration)

    if mob:isDead() then
        return
    end

    mob:hideName(true)
    mob:untargetable(true)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:SetMobSkillAttack(false)
    mob:entityAnimationPacket("kesu")

    hideDuration = hideDuration or 5000

    if hideDuration < 1500 then
        hideDuration = 1500
    end

    mob:timer(hideDuration, function(mob)
    mob:hideName(false)
    mob:untargetable(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:SetMobSkillAttack(true)

        if mob:isDead() then
            return
        end

        mob:entityAnimationPacket("deru")
    end)
end

function onMobSpawn(mob)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    local mobID = mob:getID()
    dynamis.statueOnSpawn(mob, mobList[zone][mobID] ~= nil)
    local mobID = mob:getID()
    dynamis.setMegaBossStats(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)

    tpz.mix.jobSpecial.config(mob, {
        between = 300,
        specials =
        {
            {id = tpz.jsa.CHAINSPELL, hpp = 25},
        },
    })

end

function onMobEngaged(mob, target)
    require("scripts/zones/Dynamis-Beaucedine/dynamis_mobs")
    randomChildrenListArg = nil
    if mobList[zone][mob:getID()].randomChildrenList ~= nil then randomChildrenListArg = randomChildrenList[zone][mobList[zone][mob:getID()].randomChildrenList] end
    dynamis.statueOnEngaged(mob, target, mobList[zone], randomChildrenListArg)

    local mobId = mob:getID()
    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if GetMobByID(i):isSpawned() then
            pet:updateEnmity(target)
        end
    end
end


function onMobDisengage(mob)
    mob:setLocalVar("teleTime", 0)
end    

function onMobFight(mob, target)

    local mobId = mob:getID()

    teles = 
    {
    {279.4038, 20, 535.4518},
    {312.6868, 20.5267, 511.9843},
    {322.2653, 20, 481.8030},
    {295.9948, 20.7949, 483.1078},
    {269.6127, 19.5547, 505.3206},
    {240.9685, 20, 521.5283},
    {239.8057, 20.1687, 487.3961},
    {258.6785, 20.1525, 460.4170},
    }


    local teleTime = mob:getLocalVar("teleTime")
    if mob:getBattleTime() - teleTime > 30 then
        randPos = teles[math.random((1), (8))]
        Teleport(mob, 1000)
        mob:setPos(randPos, 0)
        for i = mobId + 1, mobId + 4 do
            local pet = GetMobByID(i)
            if pet:isSpawned() and mob:getHPP() <= 99 then
                pet:updateEnmity(target)
            end
        end
        mob:setLocalVar("teleTime", mob:getBattleTime())
    end

    for i = mobId + 1, mobId + 4 do
        local pet = GetMobByID(i)
        if pet:isSpawned() and pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

function onMonsterMagicPrepare(mob, target)
    if mob:getHPP() <= 25 then
        return 367 -- Death
    else
        -- Can cast Blindga, Death, Graviga, Silencega, and Sleepga II.
        -- Casts Graviga every time before he teleports.
        local rnd = math.random()

        if rnd < 0.2 then
            return 361 -- Blindga
        elseif rnd < 0.4 then
            return 367 -- Death
        elseif rnd < 0.6 then
            return 366 -- Graviga
        elseif rnd < 0.8 then
            return 274 -- Sleepga II
        else
            return 359 -- Silencega
        end
    end
end

function onMobDeath(mob, player, isKiller)
    local winQM = GetNPCByID(17326800)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(tpz.status.NORMAL)
    player:addTitle(tpz.title.DYNAMIS_BEAUCEDINE_INTERLOPER)
end
