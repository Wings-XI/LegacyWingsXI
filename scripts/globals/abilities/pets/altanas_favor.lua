---------------------------------------------
-- Altana's Favor
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    local level = player:getMainLvl() * 2

    if(player:getMP()<level) then
       return 87,0
    end

    return 0,0
end

function onPetAbility(target, pet, skill)
    if not target:isPC() then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
        return 0
    end
    
    skill:setMsg(tpz.msg.basic.SKILL_GAIN_EFFECT)
    
    if target:isDead() then
        target:sendRaise(4)
        skill:setMsg(tpz.msg.basic.NONE)
    elseif not target:addStatusEffect(tpz.effect.RERAISE, 3, 0, 0) then -- Infinite duration http://wiki.ffo.jp/html/30976.html
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    
    pet:getMaster():setMP(0)
    return tpz.effect.RERAISE
end
