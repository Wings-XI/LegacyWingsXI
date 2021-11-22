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
    local mobID = mob:getID()
    local target = mob:getTarget()

    if target and target:isPet() then
        target = target:getMaster()
    end

    for i = mobID + 1, mobID + 6 do
        local thrall = GetMobByID(i)
        if not thrall:isSpawned() then
            --Update thrall to mimic target
            local job = target:getMainJob()

            thrall:copyLook(target)
            thrall:changeJob(job)
            
            local wsType = 1
            if job == tpz.job.RNG then
                wsType = target:getWeaponSkillType(tpz.slot.RANGED)
            end
            if wsType == 1 or wsType == 27 then
                wsType = target:getWeaponSkillType(tpz.slot.MAIN)
            end

            thrall:spawn()

            local standBack = thrall:getMobMod(tpz.mobMod.HP_STANDBACK)
            if standBack > 0 then
                thrall:delMobMod(tpz.mobMod.HP_STANDBACK, -standBack)
            end
            thrall:setMobMod(tpz.mobMod.SKILL_LIST, 2000 + wsType)
            
            if target then
                thrall:updateEnmity(target)
            end
            break
        end
    end

    return 0
end
