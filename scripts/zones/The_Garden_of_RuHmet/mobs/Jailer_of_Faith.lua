-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.RESBUILD_GRAVITY, 25) -- builds resistance to gravity quickly
    mob:addListener("TAKE_DAMAGE", "FAITH_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:setLocalVar("PhysicalDamage", mob:getLocalVar("PhysicalDamage") + amount)
        elseif attackType == tpz.attackType.MAGICAL then
            mob:setLocalVar("MagicalDamage", mob:getLocalVar("MagicalDamage") + amount)
        elseif attackType == tpz.attackType.RANGED then
            mob:setLocalVar("RangedDamage", mob:getLocalVar("RangedDamage") + amount)
        elseif attackType == tpz.attackType.BREATH then
            mob:setLocalVar("BreathDamage", mob:getLocalVar("BreathDamage") + amount)
        else
            -- ignore Untyped Damage
        end

        -- local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage") + mob:getLocalVar("BreathDamage")
        -- local physicalPercent = mob:getLocalVar("PhysicalDamage") / sum * 100
        -- local magicalPercent = mob:getLocalVar("MagicalDamage") / sum * 100
        -- local rangedPercent = mob:getLocalVar("RangedDamage") / sum * 100
        -- local breathPercent = mob:getLocalVar("BreathDamage") / sum * 100

        -- --useful debug output
        -- printf(string.format("Physical %d %d Magical %d %d w Ranged %d %d Breath %d %d",
        -- mob:getLocalVar("PhysicalDamage"), physicalPercent, mob:getLocalVar("MagicalDamage"), magicalPercent, mob:getLocalVar("RangedDamage"), rangedPercent, mob:getLocalVar("BreathDamage"), breathPercent))

    end)
end

-- Jailer of Faith takes 12.5% extra damage while folower is open
local function openFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:delMod(tpz.mod.ATTP, 10)
    mob:setMod(tpz.mod.HTHRES, 1250)
    mob:setMod(tpz.mod.SLASHRES, 1250)
    mob:setMod(tpz.mod.PIERCERES, 1250)
    mob:setMod(tpz.mod.IMPACTRES, 1250)
    for n = 1, #tpz.magic.resistMod, 1 do
        mob:setMod(tpz.magic.resistMod[n], 0)
    end
    for n = 1, #tpz.magic.defenseMod, 1 do
        mob:setMod(tpz.magic.defenseMod[n], -32) -- 12.5% extra magic damage
    end
    mob:AnimationSub(2)
end

-- Jailer of Faith takes -25% damage while flower is closed
local function closeFlower(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    mob:addMod(tpz.mod.ATTP, 10) -- hits harder while flower is closed
    mob:setMod(tpz.mod.HTHRES, 750)
    mob:setMod(tpz.mod.SLASHRES, 750)
    mob:setMod(tpz.mod.PIERCERES, 750)
    mob:setMod(tpz.mod.IMPACTRES, 750)
    for n = 1, #tpz.magic.resistMod, 1 do
        mob:delMod(tpz.magic.resistMod[n], 0)
    end
    for n = 1, #tpz.magic.defenseMod, 1 do
        mob:setMod(tpz.magic.defenseMod[n], 64)
    end
    mob:setLocalVar("[faith]changeTime", mob:getBattleTime() + math.random(20, 40))
    mob:AnimationSub(1)
end

function onMobSpawn(mob)
    mob:setLocalVar("PhysicalDamage", 0)
    mob:setLocalVar("MagicalDamage", 0)
    mob:setLocalVar("RangedDamage", 0)
    mob:setLocalVar("BreathDamage", 0)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MANAFONT,
                endCode = function(mob) -- Uses Manafont and casts Quake II -- only casts this during manafont.
                    mob:castSpell(211) -- quake II
                end,
            },
        },
    })
    -- Change animation to open
    mob:AnimationSub(2)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 0)
    mob:setMod(tpz.mod.FASTCAST, 30) -- taken from timing of spells from multiple captures
    mob:setMod(tpz.mod.DEF, 450)
end

function onMobEngaged(mob, target)
    mob:setLocalVar("[faith]changeTime", 0)
end

function onMonsterMagicPrepare(mob, target)
    local rnd = math.random()
    if rnd < 0.5 and mob:hasStatusEffect(tpz.effect.MANAFONT) == true then -- quake II replaces existing earth damage spells during manafont
        return 211 -- quake II casted exclusively while Manafont is active.
    elseif rnd < 0.25 then
        return 162 -- stone iv
    elseif rnd < 0.5 then
        return 191 -- stonega iii
    elseif rnd < 0.75 then
        return 365 -- breakga'
    else
        return 357 -- slowga
    end
end

function onMobFight(mob)
    mob:addListener("COMBAT_TICK", "FAITH_CTICK", function(mob)
        local sum = mob:getLocalVar("PhysicalDamage") + mob:getLocalVar("MagicalDamage") + mob:getLocalVar("RangedDamage") + mob:getLocalVar("BreathDamage")
        if mob:AnimationSub() == 2 and sum > 1500 then -- Faith will close flower upon taking 1500 damage combined.
            closeFlower(mob)
        elseif mob:AnimationSub() <= 1 and mob:getBattleTime() > mob:getLocalVar("[faith]changeTime") then
            openFlower(mob)
        else
            -- if no dmg taken - dont trigger a change
        end
    end)
end

function onMobDeath(mob)
end

function onMobDespawn(mob)
    -- Move QM to random location
    local qmFaith = GetNPCByID(ID.npc.QM_JAILER_OF_FAITH)
    qmFaith:setPos(unpack(ID.npc.QM_JAILER_OF_FAITH_POS[math.random(1, 5)]))
    qmFaith:setLocalVar("nextMove", 0)
end
