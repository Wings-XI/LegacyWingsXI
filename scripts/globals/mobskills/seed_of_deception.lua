---------------------------------------------
--  Seed of Deception
--
--  Description: Clones a random target creating a Seed Thrall
--  Type: 
--
--
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- Target a random person?

    local ID = zones[mob:getZoneID()]
    local target = mob:getTarget()

    -- target shouldn't even be a pet
    if target and target:isPet() then
        target = target:getMaster()
    end

    for i, id in ipairs(ID.mob.SEED_THRALLS) do
        local thrall = GetMobByID(id)
        if not thrall:isSpawned() then
            -- Update thrall's Appearance, Weapon, Job(?), Level based on target

            thrall:spawn()
            if target then
                thrall:updateEnmity(target)
            end
            break
        end
    end

    return 0
end
