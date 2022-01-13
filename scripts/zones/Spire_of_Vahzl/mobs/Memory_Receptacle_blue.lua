-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
-----------------------------------

local bfOne = {
    {  -230.69, 60.75,  -0.36}, -- W
    { -239.835, 60.75,   9.62}, -- S
    {  -249.41, 60.75,  0.078}, -- E
    { -240.022, 60.75,  -9.15}, -- N
    { -255.249, 60.00,  0.028}, -- EE
    { -255.249, 60.00,  0.028}, -- EE
    { -224.921, 60.00, -0.095}, -- WW
    {  -240.32, 60.00, -14.79}, -- NN
}

local bfTwo = {
    {   10.69, 0.75,  -0.36}, -- W
    {   1.835, 0.75,   9.62}, -- S
    {   -9.41, 0.75,  0.078}, -- E
    {   0.022, 0.75,  -9.15}, -- N
    {    0.32, 0.00, -14.79}, -- EE
    {    0.32, 0.00, -14.79}, -- EE
    {  16.921, 0.00, -0.095}, -- WW
    { -15.249, 0.00,  0.028}, -- NN
}

local bfThree = {
    {  250.69, -59.75,  -0.36}, -- W
    { 241.835, -59.75,   9.62}, -- S
    {  231.41, -59.75,  0.078}, -- E
    { 240.022, -59.75,  -9.15}, -- N
    {  240.32, -60.00, -14.79}, -- EE
    {  240.32, -60.00, -14.79}, -- EE
    { 256.921, -60.00, -0.095}, -- WW
    { 225.249, -60.00,  0.028}, -- NN
}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMod(tpz.mod.DEF, 300)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("Moving", 0)

    local bfID = mob:getBattlefield():getArea()
    local battlefield = mob:getBattlefield()
    local position = battlefield:getLocalVar("positionNum")

    -- Give orbs a random spawn location
    if bfID == 1 then
        mob:setPos(bfOne[position][1],bfOne[position][2],bfOne[position][3])
    elseif bfID == 2 then
        mob:setPos(bfTwo[position[1]],bfTwo[position[2]],bfTwo[position[3]])
    elseif bfID == 3 then
        mob:setPos(bfThree[position[1]],bfThree[position[2]],bfThree[position[3]])
    end
end

function onMobFight(mob, target)
    local bfID = mob:getBattlefield():getArea()
    local battlefield = mob:getBattlefield()
    local moveTime = battlefield:getLocalVar("moveTime")
    local position = battlefield:getLocalVar("positionNum")
    local moving = mob:getLocalVar("Moving")

    -- Orbs move every 30 seconds
    if os.time() == moveTime and moving == 0 then
        mob:setLocalVar("Moving", 1)
    elseif moving == 1 then
        if bfID == 1 then
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            local nextPos = bfOne[position]
            mob:pathThrough(nextPos, tpz.path.flag.SCRIPT)
            if mob:getXPos() == bfOne[position][1] then
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:setLocalVar("Moving", 0)
            end
        elseif bfID == 2 then
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            local nextPos = bfTwo[position]
            mob:pathThrough(nextPos, tpz.path.flag.SCRIPT)
            if mob:getXPos() == bfOne[position][1] then
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:setLocalVar("Moving", 0)
            end
        elseif bfID == 3 then
            mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
            local nextPos = bfThree[position]
            mob:pathThrough(nextPos, tpz.path.flag.SCRIPT)
            if mob:getXPos() == bfOne[position][1] then
                mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
                mob:setLocalVar("Moving", 0)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
    -- Spawn mob from body and let main receptacle know you died
    local bfID = mob:getBattlefield():getArea()
    local pos = mob:getPos()
    local repiner = GetMobByID(ID.pullingThePlug[bfID].REPINER)
    repiner:setSpawn(pos.x, pos.y, pos.z, pos.rot)
    repiner:spawn()

    mob:getBattlefield():setLocalVar("BlueDead", 1)
end
