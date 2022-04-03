---------------------------------------------
-- Astral Flow
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

local avatarOffsets =
{
    [17444883] = 3, -- Vermilion-eared Noberry
    [17453078] = 3, -- Duke Dantalian
    [17453085] = 3, -- Duke Dantalian
    [17453092] = 3, -- Duke Dantalian
    [17506670] = 5, -- Kirin
    [16928799] = 2, -- Temenos Kindred
    [16928819] = 2, -- Temenos Tonberry
    [16928823] = 2, -- Temenos Tonberry
    [16928827] = 2, -- Temenos Tonberry
}

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(tpz.msg.basic.USES)
    local mobID = mob:getID()
    local avatar = 0

    if avatarOffsets[mobID] then
        avatar = mobID + avatarOffsets[mobID]
    elseif string.find(mob:getName(), "Clone") then
        avatar = mobID + 1
    else
        avatar = mobID + 2 -- default offset
    end

    if not GetMobByID(avatar):isSpawned() then
        GetMobByID(avatar):setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(avatar):updateEnmity(mob:getTarget())
    end

    return tpz.effect.ASTRAL_FLOW
end
