------------------------------
-- Area: Batallia Downs [S]
--   NM: La Velue
------------------------------
require("scripts/globals/hunts")
------------------------------
function onMobWeaponSkill(target, mob, skill)
    local hp = mob:getHPP()
    local ws = mob:getLocalVar("ws")
    local wsmax = mob:getLocalVar("wsmax")

    if ws == 0 and wsmax == 0 then
        if mob:getHPP() <= 50 and mob:getHPP() > 25 then
            wsmax = 1
        elseif mob:getHPP() <= 25 then
            wsmax = 2
        end
        mob:setLocalVar("wsmax", wsmax)
    end

    ws = ws + 1
    mob:setLocalVar("ws", ws)

    if ws > wsmax then
        mob:setLocalVar("ws", 0)
        mob:setLocalVar("wsmax", 0)
    else
        mob:setTP(3000)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 491)
end
