-----------------------------------
-- Ability: Mug
-- Steal gil from enemy.
-- Obtained: Thief Level 35
-- Recast Time: 5:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    local thfLevel
    local gil = 0

    if (player:getMainJob() == tpz.job.THF) then
        thfLevel = player:getMainLvl()
    else
        thfLevel = player:getSubLvl()
    end

    local mugChance = 90 + thfLevel - target:getMainLvl()

    if (target:isMob() and math.random(100) < mugChance and target:getMobMod(tpz.mobMod.MUG_GIL) > 0) then
        local purse = target:getMobMod(tpz.mobMod.MUG_GIL)
        local fatpurse = target:getGil()
        gil = fatpurse / (8 + math.random(0, 8))
        if (gil == 0) then
            gil = fatpurse / 2
        end
        if (gil == 0) then
            gil = fatpurse
        end
        if (gil > purse) then
            gil = purse
        end

        if (gil <= 0) then
            ability:setMsg(tpz.msg.basic.MUG_FAIL)
        else
            gil = gil * (1 + player:getMod(tpz.mod.MUG_EFFECT))
            player:addGil(gil)
            target:setMobMod(tpz.mobMod.MUG_GIL, target:getMobMod(tpz.mobMod.MUG_GIL) - gil)
            ability:setMsg(tpz.msg.basic.MUG_SUCCESS)
        end
    else
        ability:setMsg(tpz.msg.basic.MUG_FAIL)
        action:animation(target:getID(), 184)
    end

    return gil
end
]]

-- experimental, just copypasted from Tonberry
function onUseAbility(player, target, ability, action)
    local thfLevel
    local gil = 0

    if (player:getMainJob() == tpz.job.THF) then
        thfLevel = player:getMainLvl()
    else
        thfLevel = player:getSubLvl()
    end

    local mugChance = 90 + thfLevel - target:getMainLvl()
	
	if target:isNM() then
		mugChance = mugChance - 15
	end
	
	if target:isPC() then
		local amt = math.random(33, 120)
		if math.random() < 0.8 and target:getGil() > amt then
			player:addGil(amt)
			target:delGil(amt)
			ability:setMsg(tpz.msg.basic.MUG_SUCCESS)
			return amt
		else
			ability:setMsg(tpz.msg.basic.MUG_FAIL)
			action:animation(target:getID(), 184)
			return amt
		end
	end

    if (target:isMob() and math.random(100) < mugChance and target:getMobMod(tpz.mobMod.MUG_GIL) > 0) then
        local purse = target:getMobMod(tpz.mobMod.MUG_GIL)
        local fatpurse = math.floor(target:getGil() / 2)
        --gil = math.floor( fatpurse * 100 / (100 + math.random(0,300)) )
		gil = fatpurse
        --if (gil == 0) then
            --gil = fatpurse / 2
        --end
        --if (gil == 0) then
            --gil = fatpurse
        --end
        if (gil > purse) then
            gil = purse
        end
		
		if gil > 1000 then
			gil = ((gil - 1000) * 0.5) + 1000 -- soft cap, gil stolen past 1,000 is 50% effective
		end
		
		if gil > 2000 then
			gil = ((gil - 2000) * 0.3) + 2000 -- soft cap, gil stolen past 2,000 is 30% effective
		end
		
		gil = gil * math.random(800,1250)/1000
		
		if (gil > purse) then
            gil = purse
        end
		
        if (gil <= 0) then
            ability:setMsg(tpz.msg.basic.MUG_FAIL)
        else
            gil = gil * (1 + player:getMod(tpz.mod.MUG_EFFECT))
            player:addGil(gil)
            target:setMobMod(tpz.mobMod.MUG_GIL, target:getMobMod(tpz.mobMod.MUG_GIL) - gil)
            ability:setMsg(tpz.msg.basic.MUG_SUCCESS)
        end
    else
        ability:setMsg(tpz.msg.basic.MUG_FAIL)
        action:animation(target:getID(), 184)
    end
	
	

    return gil
end