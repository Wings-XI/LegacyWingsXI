-----------------------------------
-- Area: Boneyard Gully
--  Mob: Race Runner
--  ENM: Like the Wind
-- Original implementation by "Abdiah": https://github.com/AirSkyBoat/AirSkyBoat/pull/315
-----------------------------------
require("scripts/globals/pathfind")
require("scripts/globals/status")
-----------------------------------

local path =
{
    {
        {-588.6, -5.0, -458.5},
        {-577.5,  0.0, -454.3},
        {-559.6,  0.0, -470.4},
        {-539.0,  1.0, -482.1},
        {-540.6,  0.0, -451.0},
        {-564.2,  3.5, -433.4},
        {-547.5,  1.5, -418.2},
        {-579.4,  1.0, -423.0},
    },
    {
        {-28.2, -5.0, 101.2},
        { -0.3,  0.3,  88.1},
        { 22.0,  0.9,  77.7},
        { 18.4,  0.3, 109.0},
        { -2.2,  3.5, 125.7},
        { 12.2,  1.4, 142.8},
        {-17.4,  1.2, 137.5},
        {-17.3,  0.0, 107.1},
    },
    {
        {451.2, -4.8, 581.3},
        {479.3,  0.3, 563.8},
        {500.6,  0.9, 558.1},
        {498.7,  0.1, 590.5},
        {479.5,  3.5, 606.2},
        {494.2,  1.2, 623.3},
        {460.6,  1.0, 619.3},
        {436.1, -0.1, 587.0},
    },
}

function removePetHate(mob, pet)
    -- "Ignores pets. Pets cannot tank or be the target of Race Runner's attacks; it instead goes after the pet's master."
    local owner = pet:getMaster()
    mob:setVE(pet, 0)
    mob:setCE(pet, 0)
    if mob:getCE(owner) == 0 then
        mob:setCE(owner, 1)
    end
end

function onMobSpawn(mob)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.STANDBACK))
    mob:setLocalVar("hitsRequired", math.random(1, 10))
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
    mob:setMod(tpz.mod.UDMGMAGIC, -40)
    mob:setMod(tpz.mod.REGAIN, 1000)
    mob:speed(70)

    mob:addListener("TAKE_DAMAGE", "RUNNER_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        -- can't execute isPet unless attacker is a valid lua_baseentity, also can't check objType...so this is a roundabout way to confirm attacker is an object
        if attackType > 0 then
            if amount > 0 and (not attacker:isPet()) then
                mobArg:setLocalVar("currHits", mobArg:getLocalVar("currHits") + 1)
            elseif attacker:isPet() then
                removePetHate(mobArg, attacker)
            end
        else
            -- tick hit count even from DoT dmg
            mobArg:setLocalVar("currHits", mobArg:getLocalVar("currHits") + 1)
        end

        if mobArg:getLocalVar("currHits") >= mobArg:getLocalVar("hitsRequired") then
            mobArg:setLocalVar("hitsRequired", math.random(1,10))
            mobArg:setLocalVar("runControl", 1)
            mobArg:setLocalVar("currHits", 0)
        end
    end)
end

function onMobRoam(mob)
    if not mob:isFollowingPath() then
        local bfNum = mob:getBattlefield():getArea()
        local point = math.random(#path[bfNum])
        mob:pathTo(path[bfNum][point][1], path[bfNum][point][2], path[bfNum][point][3], tpz.path.flag.SCRIPT)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    if target ~= nil and target:isPet() then
        removePetHate(mob, target)
        mob:useMobAbility(1594, target:getMaster())
    end
    if target:checkDistance(mob) > 5 then
        -- "If the target with hate is out of meleé range, it uses Toxic Spit."
        return 1594
    end
end

function onMobWeaponSkill(target, mob, skill)
    -- "Runs away after using a TP move."
    mob:timer(1000, function(mobArg)
        mobArg:setLocalVar("runControl", 1)
    end)
end

function onMobMagicPrepare(mob, target)
    if target ~= nil and target:isPet() then
        removePetHate(mob, target)
        mob:useMobAbility(1594, target:getMaster())
    end
end

function onMobFight(mob, target)
    if target ~= nil and target:isPet() then
        removePetHate(mob, target)
        -- target = target:getMaster()
    end

    if mob:getLocalVar("runControl") == 1 then
        local bfNum = mob:getBattlefield():getArea()
        local point = math.random(#path[bfNum])
        mob:setLocalVar("runControl", 0)

        -- printf("running? %f %f %f", path[bfNum][point][1], path[bfNum][point][2], path[bfNum][point][3])
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(false)
        mob:pathTo(path[bfNum][point][1], path[bfNum][point][2], path[bfNum][point][3], tpz.path.flag.SCRIPT + tpz.path.flag.RUN)

        mob:timer(5000, function(mobArg)
            mobArg:SetMagicCastingEnabled(true)
            mobArg:SetMobAbilityEnabled(true)
        end)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:removeListener("RUNNER_TAKE_DAMAGE")
end
