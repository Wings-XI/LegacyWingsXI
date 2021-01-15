-----------------------------------
-- Ability: Rampart
-- Grants all party members within the area of effect -25% SDT.
-- SDT is multiplicative with regular Damage Taken; many forms of SDT are for a single type or element of damage
-- However, Rampart's SDT is for all damage types.
-- Obtained: Paladin Level 62
-- Recast Time: 5:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local duration = 30 + player:getMod(tpz.mod.RAMPART_DURATION)
    
    local power = math.floor(player:getStat(tpz.mod.VIT)/14) + 17
    if player:getMainLvl() > 69 then
        power = power + 2 -- 17+vitmod is a close estimation for base defense with Def. Bonus III trait, 19+vitmod is a close estimation with Def. Bonus IV trait (lv 70+)
    end
    power = math.floor(power * (player:getMod(tpz.mod.DEFP) + 100) / 100)
    
    local SSpower = player:getStat(tpz.mod.VIT)*2
    if SSpower < 1 then
        SSpower = 1
    end
    target:setMod(tpz.mod.RAMPART_STONESKIN, SSpower)
    
    --print(string.format("player = %u, target = %u, power = %u, SSpower = %u", player:getID(), target:getID(), power, SSpower))
    
    target:delStatusEffect(tpz.effect.DEFENSE_BOOST)
    target:addStatusEffect(tpz.effect.DEFENSE_BOOST, power+10000, 3, duration, 0, player:getMerit(tpz.merit.IRON_WILL))
end
