-----------------------------------------
-- ID: 5331
-- Item: Qiqirn Mine
-- When used, Summons a bomb to blowup a wall
-----------------------------------------
require("scripts/globals/zone")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getZoneID() ~= tpz.zone.LEBROS_CAVERN then
        result = 55
    end
    return result
end

function onItemUse(target)
    local instance = target:getInstance()
    local bomb = instance:insertAlly(10633)
    local X = target:getXPos()
    local Z = target:getZPos()
    bomb:setSpawn(X + math.random(-2, 2), target:getYPos() , Z + math.random(-2, 2))

    if target:getTarget() ~= nil then
        local targetID = target:getTarget():getID()
        switch (targetID): caseof
        {
            [17035283] = function ()
                bomb:setSpawn(178, -40, 376, 196)
            end,
            [17035287] = function ()
                bomb:setSpawn(258, -30, 213, 190)
            end,
            [17035289] = function ()
                bomb:setSpawn(303, -30, 341, 167)
            end,
            [17035291] = function ()
                bomb:setSpawn(338, -30, 296, 197)
            end,
        }
    end
    bomb:spawn()
    bomb:updateEnmity(target)
end
