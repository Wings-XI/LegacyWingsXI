-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Memory Receptacles
-----------------------------------
local ID = require("scripts/zones/Spire_of_Vahzl/IDs")
require("scripts/globals/pathfind")
-----------------------------------

local bfOne = {
    {  -230.65, 60.75,   9.29}, -- SW
    {  -249.31, 60.75,  10.03}, -- SE
    {  -249.45, 60.75,  -8.71}, -- NE
    { -230.980, 60.75,  -8.65}, -- NW
    {  -240.32, 60.00, -14.79}, -- NN
    { -224.921, 60.00, -0.095}, -- WW
    {  -240.32, 60.00, -14.79}, -- NN
    { -255.249, 60.00,  0.028}, -- EE
}

local bfTwo = {
    {   10.65, 0.75,   9.29}, -- SW
    {   -9.31, 0.75,  10.03}, -- SE
    {   -9.45, 0.75,  -8.71}, -- NE
    {  10.980, 0.75,  -8.65}, -- NW
    { -15.249, 0.00,  0.028}, -- NN
    {  16.921, 0.00, -0.095}, -- WW
    { -15.249, 0.00,  0.028}, -- NN
    {    0.32, 0.00, -14.79}, -- EE
}

local bfThree = {
    {  250.65, -59.75,   9.29}, -- SW
    {  231.31, -59.75,  10.03}, -- SE
    {  231.45, -59.75,  -8.71}, -- NE
    { 250.980, -59.75,  -8.65}, -- NW
    { 225.249, -60.00,  0.028}, -- NN
    { 256.921, -60.00, -0.095}, -- WW
    { 225.249, -60.00,  0.028}, -- NN
    {  240.32, -60.00, -14.79}, -- EE
}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setLocalVar("Moving", 0)
    mob:setMod(tpz.mod.DEF, 300)

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
    local contemplator = GetMobByID(ID.pullingThePlug[bfID].CONTEMPLATOR)
    contemplator:setSpawn(pos.x, pos.y, pos.z, pos.rot)
    contemplator:spawn()

    mob:getBattlefield():setLocalVar("TealDead", 1)
end