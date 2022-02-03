---------------------------------------------
-- Eald2 Warp Out
-- End Eald'Narche ZM16 (phase 2) teleport
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local battletarget = mob:getTarget()
    local t = battletarget:getPos()
    t.rot = battletarget:getRotPos()
    local angle = math.random() * math.pi
    local pos = 0
    if mob:getID() == 16924680 then
        local dist = math.random(1.5, 10.0)
        pos = NearLocation(t, dist, angle)
    else
        pos = NearLocation(t, 1.5, angle)
    end
    mob:teleport(pos, battletarget)
    skill:setMsg(tpz.msg.basic.NONE)
    return 0
end
