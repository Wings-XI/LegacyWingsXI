-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Tiamat summoned by Bahamut during The Wyrmking Descends
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/wyrm_wakeup")}
-----------------------------------

function onMobSpawn(mob)
    mob:SetMobSkillAttack(0) -- Resetting so it doesn't respawn in flight mode
    mob:AnimationSub(0) -- AnimationSub 0 is only used when it spawns until first flight

    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(tpz.mobMod.SIGHT_ANGLE, 90)
    mob:setMobMod(tpz.mobMod.GA_CHANCE, 70)
    mob:setMobMod(tpz.mobMod.BUFF_CHANCE, 30)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:addMod(tpz.mod.SLEEPRES, 100)
    mob:addMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.MDEF, 100) -- 385 * 1.32/2 = 254 nether blast
    mob:setMod(tpz.mod.DEF, 500)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.MATT, 0)
end

function onMobFight(mob, target)
    -- Gains a large attack boost when health is under 25% which cannot be Dispelled
    if mob:getHPP() < 25 then
        if mob:hasStatusEffect(tpz.effect.ATTACK_BOOST) == false then
            mob:addStatusEffect(tpz.effect.ATTACK_BOOST, 75, 0, 0)
            mob:getStatusEffect(tpz.effect.ATTACK_BOOST):setFlag(tpz.effectFlag.DEATH)
        end
    -- Deletes Effect if regens back up due to a wipe
    else
        if mob:hasStatusEffect(tpz.effect.ATTACK_BOOST) == true then
            mob:delStatusEffect(tpz.effect.ATTACK_BOOST)
        end
    end

    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) == false and mob:actionQueueEmpty() == true then
        local changeTime = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")
        local changeHP = mob:getLocalVar("changeHP")

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        if mob:AnimationSub() == 2 and mob:getBattleTime()/15 > twohourTime then
            mob:useMobAbility(688)
            mob:setLocalVar("twohourTime", math.random((mob:getBattleTime()/15)+4, (mob:getBattleTime()/15)+8))
        elseif mob:AnimationSub() == 0 and mob:getBattleTime() - changeTime > 60 then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", mob:getBattleTime()) -- Record the time and HP this phase was started
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- AnimationSub 1 is flight, so check if she should land
        elseif mob:AnimationSub() == 1 and (mob:getHP()/1000 <= changeHP - 10 or mob:getBattleTime() - changeTime > 120) then
            mob:useMobAbility(1282)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        -- AnimationSub 2 is grounded mode, so check if she should take off
        elseif mob:AnimationSub() == 2 and (mob:getHP()/1000 <= changeHP - 10 or mob:getBattleTime() - changeTime > 120) then
            mob:AnimationSub(1)
            mob:addStatusEffectEx(tpz.effect.TOO_HIGH, 0, 1, 0, 0)
            mob:SetMobSkillAttack(730)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            mob:setLocalVar("changeHP", mob:getHP()/1000)
        end
    end
end

-- Prevents any stuck logic due to wipes
function onMobDisengage(mob)
    mob:setLocalVar("changeTime", 0)
    mob:setLocalVar("twohourTime", 0)
    mob:setLocalVar("changeHP", 0)
end

function onCastStarting(mob, spell)
    if spell:getID() == 176 then -- firaga iii
        spell:castTime(spell:castTime()/2) -- really fast cast (2x)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE, {power = math.random(45, 90), chance = 10})
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
end
