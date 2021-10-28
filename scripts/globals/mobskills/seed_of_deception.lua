---------------------------------------------
--  Seed of Deception
--
--  Description: Clones a random target creating a Seed Thrall
--  Type: 
--  Note: Currently not random and thrall's only use Vorpal Blade
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
    local ID = zones[mob:getZoneID()]
    local target = mob:getTarget()

    if target and target:isPet() then
        target = target:getMaster()
    end

    for i, id in ipairs(ID.mob.SEED_THRALLS) do
        local thrall = GetMobByID(id)
        if not thrall:isSpawned() then
            --Update thrall to mimic target
            local job = target:getMainJob()

            thrall:copyLook(target)
            thrall:changeJob(job)
            
            local wsType = 1
            if job == tpz.job.RNG then
                wsType = target:getWeaponSkillType(tpz.slot.RANGED)
            end
            if wsType == 1 then
                target:getWeaponSkillType(tpz.slot.MAIN)
            end
            -- Doesn't currently work & need more WS per weapon in each list
            thrall:setSkillList(2000 + wsType)

            thrall:spawn()
            thrall:delMobMod(tpz.mobMod.HP_STANDBACK, -70)
            if target then
                thrall:updateEnmity(target)
            end
            break
        end
    end

    return 0
end
