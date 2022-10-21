--[[
https://ffxiclopedia.fandom.com/wiki/Category:Uragnites
https://www.bg-wiki.com/bg/Category:Uragnite

Uragnite mob can optionally be modified by calling tpz.mix.uragnite.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    inShellSkillList : skill list given to mob when it enters shell (default: 250)
    noShellSkillList : skill list given to mob when it exits shell (default: 251)
    chanceToShell    : percent chance to enter shell when hit by a physical attack (default: 20)
    timeInShellMin   : least time mob can stay in shell, in seconds (default: 30)
    timeInShellMax   : most time mob can stay in shell, in seconds (default: 45)
    inShellRegen     : amount of regen mob gets while in shell (default: 50)

Example:

tpz.mix.uragnite.config(mob, {
    chanceToShell = 10,
    timeInShellMin = 45,
    timeInShellMin = 60,
})

--]]
require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------

tpz = tpz or {}
tpz.mix = tpz.mix or {}
tpz.mix.uragnite = tpz.mix.uragnite or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function enterShell(mob)
    mob:AnimationSub(mob:AnimationSub() + 1)
    mob:SetAutoAttackEnabled(false)
    mob:SetMagicCastingEnabled(false)
    mob:addMod(tpz.mod.UDMGPHYS, -75)
    mob:addMod(tpz.mod.UDMGRANGE, -75)
    mob:addMod(tpz.mod.UDMGMAGIC, -75)
    mob:addMod(tpz.mod.UDMGBREATH, -75)
    mob:addMod(tpz.mod.REGEN, mob:getLocalVar("[uragnite]inShellRegen"))
    mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]inShellSkillList"))
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

local function exitShell(mob)
    mob:AnimationSub(mob:AnimationSub() - 1)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:delMod(tpz.mod.UDMGPHYS, -75)
    mob:delMod(tpz.mod.UDMGRANGE, -75)
    mob:delMod(tpz.mod.UDMGMAGIC, -75)
    mob:delMod(tpz.mod.UDMGBREATH, -75)
    mob:delMod(tpz.mod.REGEN, mob:getLocalVar("[uragnite]inShellRegen"))
    mob:setMobMod(tpz.mobMod.SKILL_LIST, mob:getLocalVar("[uragnite]noShellSkillList"))
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

local function shellTimer(mob)
    -- Uragnites go into their shell every 40-60 seconds
    local timeToShell = mob:getLocalVar("[uragnite]shellTimer")

    if os.time() > timeToShell and bit.band(mob:AnimationSub(), 1) == 0 and mob:isFollowingPath() == false and mob:isMobType(MOBTYPE_BATTLEFIELD) == false then
        enterShell(mob)

        local timeInShell = math.random(mob:getLocalVar("[uragnite]timeInShellMin"), mob:getLocalVar("[uragnite]timeInShellMax"))
        local shellRandom = timeInShell + (os.time() + math.random(40,60))
        mob:setLocalVar("[uragnite]shellTimer", shellRandom)

        mob:timer(timeInShell * 1000, function(mob)
            exitShell(mob)
        end)
    end
end

tpz.mix.uragnite.config = function(mob, params)
    if params.inShellSkillList and type(params.inShellSkillList) == "number" then
        mob:setLocalVar("[uragnite]inShellSkillList", params.inShellSkillList)
    end
    if params.noShellSkillList and type(params.noShellSkillList) == "number" then
        mob:setLocalVar("[uragnite]noShellSkillList", params.noShellSkillList)
    end
    if params.chanceToShell and type(params.chanceToShell) == "number" then
        mob:setLocalVar("[uragnite]chanceToShell", params.chanceToShell)
    end
    if params.timeInShellMin and type(params.timeInShellMin) == "number" then
        mob:setLocalVar("[uragnite]timeInShellMin", params.timeInShellMin)
    end
    if params.timeInShellMax and type(params.timeInShellMax) == "number" then
        mob:setLocalVar("[uragnite]timeInShellMax", params.timeInShellMax)
    end
    if params.inShellRegen and type(params.inShellRegen) == "number" then
        mob:setLocalVar("[uragnite]inShellRegen", params.inShellRegen)
    end
end

g_mixins.families.uragnite = function(mob)

    -- at spawn, give mob default skill lists for in-shell and out-of-shell states
    -- these defaults can be overwritten by using tpz.mix.uragnite.config() in onMobSpawn.
    mob:addListener("SPAWN", "URAGNITE_SPAWN", function(mob)
        -- don't shell when spawning
        mob:setLocalVar("[uragnite]shellTimer", os.time() + math.random(40,60))
        mob:setLocalVar("[uragnite]noShellSkillList", 251)
        mob:setLocalVar("[uragnite]inShellSkillList", 1170)
        mob:setLocalVar("[uragnite]chanceToShell", 15)
        mob:setLocalVar("[uragnite]timeInShellMin", 20)
        mob:setLocalVar("[uragnite]timeInShellMax", 30)
        mob:setLocalVar("[uragnite]inShellRegen", 22)
    end)

    mob:addListener("TAKE_DAMAGE", "URAGNITE_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        local mobHPP = mob:getHPP()
        local newHP = mob:getHP() - amount

        if mobHPP < 100 and math.floor( mobHPP / 10) > math.floor (newHP / (mob:getMaxHP() / 10)) and bit.band(mob:AnimationSub(), 1) == 0 then
            enterShell(mob)
            mob:useMobAbility(1572) -- Going into shell caused by damage always triggers venom shell

            local timeInShell = math.random(mob:getLocalVar("[uragnite]timeInShellMin"), mob:getLocalVar("[uragnite]timeInShellMax"))
            mob:timer(timeInShell * 1000, function(mob)
                exitShell(mob)
            end)
        end
    end)

    mob:addListener("ROAM_TICK", "URAGNITE_ROAM_TIMER", function(mob)
        shellTimer(mob)
    end)

    mob:addListener("COMBAT_TICK", "URAGNITE_COMBAT_TIMER",  function(mob)
        shellTimer(mob)
    end)
end

return g_mixins.families.uragnite
