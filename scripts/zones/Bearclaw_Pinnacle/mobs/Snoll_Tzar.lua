-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Snoll Tzar
-----------------------------------
require("scripts/globals/player")
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
-----------------------------------

function onMobSpawn(mob)
    mob:AnimationSub(4) -- starting animationSub
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
end

function onMobEngaged(mob, target)   
end

function onMobFight(mob, player, target)
    local changeTime = mob:getLocalVar("changeTime")
    local delay = mob:getLocalVar("delayed")
    local cd = mob:getLocalVar("cooldown")
    local salty = mob:getLocalVar("salty")
    local melting = mob:getLocalVar("melt")

    -- handle salt usage
    if melting == 1 then
        player:messageText(player, ID.text.BEGINS_TO_MELT)
        mob:setLocalVar("melt", 0)
    end   
    
    -- handle salt cooldown 
    if (cd < os.time() and salty == 1) then
        player:messageText(player, ID.text.SHOOK_SALT)
        mob:setLocalVar("salty", 0)
    end

    -- big
    if (delay < os.time() and mob:AnimationSub() == 4 and mob:getBattleTime() - changeTime > 11) then
        mob:setLocalVar("delayed", 0)
        mob:AnimationSub(5) 
        mob:setLocalVar("changeTime", mob:getBattleTime())
    -- bigger  
    elseif (delay < os.time() and mob:AnimationSub() == 5 and mob:getBattleTime() - changeTime > 11) then
        player:messageText(player, ID.text.LARGE_STEAM) -- approx. midway point - give warning
        mob:setLocalVar("delayed", 0)
        mob:AnimationSub(6)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    -- biggest
    elseif (delay < os.time() and mob:AnimationSub() == 6 and mob:getBattleTime() - changeTime > 11) then
        mob:setLocalVar("delayed", 0)
        mob:AnimationSub(7)
        mob:setLocalVar("changeTime", mob:getBattleTime())
    -- self-destruct   
    elseif (delay < os.time() and mob:AnimationSub() == 7 and mob:getBattleTime() - changeTime > 12) then
        mob:useMobAbility(1644)
        mob:setLocalVar("changeTime", mob:getBattleTime())
        mob:setLocalVar("gameover", 1)
    end
end

function onMobDeath(mob, player, isKiller)
    local bf = mob:getBattlefield() 
    local changeTime = mob:getLocalVar("changeTime")
    local gameOver = mob:getLocalVar("gameover")

    -- end BCNM  
    if (gameOver == 1 and mob:getBattleTime() - changeTime > 3) then 
        mob:AnimationSub(4)   
        bf:lose()
        return
    end
end
