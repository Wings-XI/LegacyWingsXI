    -- Forms: 0 = Closed (no stem)  1 = Closed (stem)  2 = Open 3 = Open (closes while melee)
    -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
    -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
    -- TODO: Initial DOT Damage will count as "Magical Damage", need to track dot ticks.
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function openFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:delMod(tpz.mod.ATTP, 10)
    mob:setMod(tpz.mod.H2HRES, 2000)
    mob:setMod(tpz.mod.SLASHRES, 2000)
    mob:setMod(tpz.mod.PIERCERES, 2000)
    mob:setMod(tpz.mod.IMPACTRES, 2000)
    for n =1, #tpz.magic.resistMod, 1 do
        mob:setMod(tpz.magic.resistMod[n], 25)
    end
    for n =1, #tpz.magic.defenseMod, 1 do
        mob:setMod(tpz.magic.defenseMod[n], -128) -- 50% more damage from magic
    end
    mob:AnimationSub(2)
end

local function closeFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:addMod(tpz.mod.ATTP, 10) -- euvhi hits hard while flower is closed
    mob:setMod(tpz.mod.H2HRES, 1000)
    mob:setMod(tpz.mod.SLASHRES, 1000)
    mob:setMod(tpz.mod.PIERCERES, 1000)
    mob:setMod(tpz.mod.IMPACTRES, 1000)
    for n =1, #tpz.magic.resistMod, 1 do
        mob:setMod(tpz.magic.resistMod[n], 0)
    end
    for n =1, #tpz.magic.defenseMod, 1 do
        mob:setMod(tpz.magic.defenseMod[n], 0)
    end
    mob:setLocalVar("[euvhi]changeTime", mob:getBattleTime() + math.random(45, 60))
    mob:AnimationSub(1)
end

g_mixins.families.euvhi = function(mob)
    mob:addListener("SPAWN", "EUVHI_SPAWN", function(mob)
        mob:setLocalVar("PhysicalDamage", 0)
        mob:setLocalVar("MagicalDamage", 0)
        mob:setLocalVar("RangedDamage", 0)
        mob:setLocalVar("BreathDamage", 0)
        -- make sure flowers aren't opening and closing at the same time while roaming
        mob:setLocalVar("roamTime", os.time() + math.random(1, 10))
        mob:AnimationSub(math.random(0, 2))
    end)

    mob:addListener("ENGAGE", "EUVHI_ENGAGE", function(mob)
        if mob:AnimationSub() == 0 then
            mob:AnimationSub(1) -- stem will appear after engaging target
        end
        mob:setLocalVar("PhysicalDamage", 0)
        mob:setLocalVar("MagicalDamage", 0)
        mob:setLocalVar("RangedDamage", 0)
        mob:setLocalVar("BreathDamage", 0)
        mob:setLocalVar("[euvhi]changeTime", math.random(15, 30)) -- wait 15-30 seconds to open flower after engaging
    end)

    mob:addListener("ROAM_TICK", "EUVHI_RTICK", function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar("PhysicalDamage", 0)
            mob:setLocalVar("MagicalDamage", 0)
            mob:setLocalVar("RangedDamage", 0)
            mob:setLocalVar("BreathDamage", 0)
        end
    end)

    mob:addListener("TAKE_DAMAGE", "EUVHI_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == tpz.attackType.MAGICAL then
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + amount)
        elseif attackType == tpz.attackType.RANGED then
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + amount)
        elseif attackType == tpz.attackType.BREATH then
            mob:setLocalVar("BreathDamage", mob:getLocalVar("BreathDamage") + amount)
        else
            -- TODO: Initial DOT Damage will count as "Magical Damage", need to track dot ticks.
        end

        -- local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage") + mob:getLocalVar("BreathDamage")
        -- local physicalPercent =  mob:getLocalVar("PhysicalDamage") / sum * 100
        -- local magicalPercent =  mob:getLocalVar("MagicalDamage") / sum * 100
        -- local rangedPercent =  mob:getLocalVar("RangedDamage") / sum * 100
        -- local breathPercent = mob:getLocalVar("BreathDamage") / sum * 100
        --useful debug output
        -- printf(string.format("Physical %d %d Magical %d %d w Ranged %d %d Breath %d %d",
        -- mob:getLocalVar("PhysicalDamage"), physicalPercent, mob:getLocalVar("MagicalDamage"), magicalPercent, mob:getLocalVar("RangedDamage"), rangedPercent, mob:getLocalVar("BreathDamage"), breathPercent))

    end)

    mob:addListener("COMBAT_TICK", "EUVHI_CTICK", function(mob)
        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage") + mob:getLocalVar("BreathDamage")
        if mob:AnimationSub() == 2 and sum > 500 then
            closeFlower(mob)
        elseif mob:AnimationSub() == 1 and mob:getBattleTime() > mob:getLocalVar("[euvhi]changeTime") then
            openFlower(mob)
        else
            -- if no dmg taken - dont trigger a change
        end

    end)

end

return g_mixins.families.euvhi
