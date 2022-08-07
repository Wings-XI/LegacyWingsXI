-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Wulgaru
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

local PathingPoints = {
    {x = -20.0, y = -4.0, z = 188},
    {x = -20.5, y = -4.0, z = 216},
    {x = -44.0, y = -4.0, z = 189},
    {x = -41.5, y = -4.0, z = 200},
    {x = -41.0, y = -4.0, z = 212},
    {x = -25.5, y = -4.0, z = 205},
    {x = -17.5, y = -4.0, z = 200},
    {x = -10.0, y = -4.0, z = 211},
    {x =   4.0, y = -4.0, z = 208},
    {x =   4.5, y = -4.0, z = 189},
}

local function RunForYourLife(mob)
    -- pick random new destination
    local destId = math.random(1, #PathingPoints)
    mob:setLocalVar("RunDestination", destId)

    -- lame forrest gump comment
    local destination = PathingPoints[destId]
    mob:pathTo(destination.x, destination.y, destination.z, 9)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 4500)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 7500)

    mob:setMod(tpz.mod.MOVE, -15)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 4500)

    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(true)
    mob:setMod(tpz.mod.DMGPHYS, 50)
    mob:setMod(tpz.mod.DMGMAGIC, 50)
    mob:setMod(tpz.mod.REGAIN, 1500)
    mob:setTP(1500)
    
    -- phases variables
    mob:setLocalVar("phase", 1)
    mob:setLocalVar("hppAmputation", math.random(70, 80))

    -- shirtless phase might just not happen
    if math.random() > 0.5 then
        mob:setLocalVar("hppShirtless", math.random(5, 50))
    end
end

function onMobFight(mob, target)
    local hpp = mob:getHPP()
    local hppAmputation = mob:getLocalVar("hppAmputation")
    local hppShirtless = mob:getLocalVar("hppShirtless")
    local phase = mob:getLocalVar("phase")

    if phase == 1 and hpp <= hppAmputation then
        mob:setLocalVar("phase", 2)

        -- remove regain and enable auto attacks for phase 2
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:addMod(tpz.mod.DELAY, 1800)
        mob:setMod(tpz.mod.DMGPHYS, 0)
        mob:setMod(tpz.mod.DMGMAGIC, 0)
        mob:setMod(tpz.mod.REGAIN, 0)

        -- using detonating_grip to trigger next phase change
        mob:setTP(0)
        mob:useMobAbility(2074)

    elseif phase == 3 and hpp <= hppShirtless then
        mob:setLocalVar("phase", 4)
        mob:timer(3000, function(mob)
            if mob:isAlive() then
                mob:setLocalVar("phase", 5)
            end
        end)

        -- last phase (run away!)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:AnimationSub(2)

        mob:setMod(tpz.mod.DMGPHYS, -10) 
        mob:setMod(tpz.mod.DMGMAGIC, -10)
        mob:setMod(tpz.mod.MOVE, 15)

    elseif phase == 5 then
        local destId = mob:getLocalVar("RunDestination")
        if destId < 1 or mob:checkDistance(PathingPoints[destId]) < 2 then
            -- pick a new destination
            RunForYourLife(mob)
        end
    end
end

function onMobWeaponSkillPrepare(mob)
    -- will only use dire_straight on phase 1
    if mob:getLocalVar("phase") == 1 then
        return 2071
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- if skill is detonating_grip, go to phase 3
    if skill:getID() == 2074 then
        mob:setLocalVar("phase", 3)
    end
end

function onMobDeath(mob, player, isKiller)
end