------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarina
------------------------------
require("scripts/globals/hunts")
------------------------------


function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_SLEEP, 1)
    mob:setMod(tpz.mod.RESBUILD_BIND, 1)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 1)
    mob:setMod(tpz.mod.RESBUILD_LULLABY, 1)
    mob:setMod(tpz.mod.KICK_ATTACK_RATE, 3) -- Note this is in addition to the base 12% KICK_ATTACK_RATE an 80+ mnk gets
    mob:setMod(tpz.mod.KICK_DMG, 200)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 433)
end

function updateRegen(mob)
    local hour = VanadielHour()
    local regen = mob:getMod(tpz.mod.REGEN)

    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00
        if regen <= 20 then -- using less than as Bailarina can use Photosynthesis for REGEN 37.
            mob:setMod(tpz.mod.REGEN, 20) -- Low auto-regen during the daytime
        end
    else
        if regen == 20 then -- using equal to 20 so Photosynthesis regen is not removed during the night.
            mob:setMod(tpz.mod.REGEN, 0) 
        end
    end
end

function onMobSpawn(mob)
    updateRegen(mob)
end

function onMobFight(mob)
    updateRegen(mob)
end

function onMobRoam(mob)
    updateRegen(mob)
end

function onMobWeaponSkillPrepare(mob, target)
    local hour = VanadielHour()
    local photosynthesis = 324
    local oneThousandNeedles = 322
    if hour > 3 and hour < 20 then -- daytime between 4:00 and 20:00, 50/50 between two ws
	    if math.random() < 0.5 then
		    return photosynthesis
	    end
    end -- night time, only use 1,000 Needles
    return oneThousandNeedles
end

function onMobWeaponSkill(target, mob, skill)
        local hp = skill:getMobHPP()
        local tp = skill:getTP()
        
        if (tp >= 1000) then -- if tp is over 1k, this is a natural ws - not an additional ws
            if(40 >= hp and hp >=21) then
                mob:useMobAbility(onMobWeaponSkillPrepare(mob, target))
            end
            if (hp <= 20) then
                mob:useMobAbility(onMobWeaponSkillPrepare(mob, target))
                mob:useMobAbility(onMobWeaponSkillPrepare(mob, target))
            end
        end
end