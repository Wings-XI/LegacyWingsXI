---------------------------------------------
--  Lightning Spear
--
--  Description: Wide Cone Attack lightning damage (600-1500) and powerful Amnesia.
--  Type: Magical
--  Notes: Will pick a random person on the hate list for this attack.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

-- could be useful mob:lookAt(target:getPos())
-- TODO how long on amnesia?
function onMobSkillCheck(target, mob, skill)
    local nearbyPlayers = mob:getPlayersInRange(20)
    local targets = {}
    if nearbyPlayers == nil then return 1 end

    for _, player in pairs(nearbyPlayers) do -- find eligible players to look at
        local posP = player:getPos()
        local posM = mob:getPos()
        if math.abs(posP.y-posM.y) <= 7 then -- no cliff jumping, may need to tune
            table.insert(targets, player) 
        end  
    end
   
    if (#targets) > 0 then 
        local target = targets[math.random(#targets)]
        mob:lookAt(target:getPos())
        print(target)
    end
    return 0
end


function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.AMNESIA
    local duration = math.random(30, 60)


    MobStatusEffectMove(mob, target, typeEffect, 1, 0, duration)

    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.THUNDER, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)
    return dmg
end

