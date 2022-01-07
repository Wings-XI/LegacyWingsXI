---------------------------------------------
-- Providence
-- Grants additional spells.
-- Breakga, Bindga, Blindga, Graviga, Slowga, Death, only used when Providence is in effect; can be dispelled.
-- Lasts one spellcast, even if interrupted.
-- The next spell instant-casts - 
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- Being silenced does not stop this skill, but does prevent casting of the spell associated
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local random = math.random(1,100)
    local spellID = 0

    if (random <= 5) then
        spellID = 367 -- Death
    elseif (random <= 15) then
        spellID = 365-- Breakga
    elseif (random <= 35) then
        spellID = 361-- Blindga
    elseif (random <= 55) then
        spellID = 366 -- Graviga
    elseif (random <= 75) then
        spellID = 357 -- Slowga
    elseif (random <= 100) then
        spellID = 362 -- Bindga
    end

    local fastCastMod = mob:getMod(tpz.mod.UFASTCAST)
    mob:setLocalVar("fastCastMod", fastCastMod)
    mob:setMod(tpz.mod.UFASTCAST, 150)
    mob:castSpell(spellID)
    mob:timer(3000, function(mob)
        mob:setMod(tpz.mod.UFASTCAST, mob:getLocalVar("fastCastMod"))
    end)
    skill:setMsg(tpz.msg.basic.NONE)
end
