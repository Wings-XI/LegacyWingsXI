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
    [16941057] = -1, -- Apocalyptic Beast
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
    elseif string.find(mob:getName(), "Clone") or mob:isInDynamis() then
        avatar = mobID + 1
    else
        avatar = mobID + 2 -- default offset
    end

    if not GetMobByID(avatar):isSpawned() then
        GetMobByID(avatar):setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos() + 1, mob:getRotPos())
        SpawnMob(avatar):updateEnmity(mob:getTarget())
    end

    local petFamily = GetMobByID(avatar):getFamily()
    local skillId = 0

    if     petFamily == 34 or petFamily == 379 then skillId = 919 -- carbuncle searing light
    elseif petFamily == 36 or petFamily == 381 then skillId = 839 -- fenrir    howling moon
    elseif petFamily == 37 or petFamily == 382 then skillId = 916 -- garuda    aerial blast
    elseif petFamily == 38 or petFamily == 383 then skillId = 913 -- ifrit     inferno
    elseif petFamily == 40 or petFamily == 384 then skillId = 915 -- leviathan tidal wave
    elseif petFamily == 43 or petFamily == 386 then skillId = 918 -- ramuh     judgment bolt
    elseif petFamily == 44 or petFamily == 387 then skillId = 917 -- shiva     diamond dust
    elseif petFamily == 45 or petFamily == 388 then skillId = 914 -- titan     earthen fury
    else
        printf("[astral_flow_pet] received unexpected pet family %i. Defaulted skill to Searing Light.", petFamily)
        skillId = 919 -- searing light
    end

    if mob:isInDynamis() then
        GetMobByID(avatar):useMobAbility(skillId)
    end

    return tpz.effect.ASTRAL_FLOW
end
