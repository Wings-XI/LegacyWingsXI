-----------------------------------
--    Area: Alzadaal Undersea Ruins
--     Mob: Armed Gears
--  Author: Spaceballs / Ascar
-----------------------------------


mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/globals/status"),
    require("scripts/mobfamilies/Gears")
}

--[[
local elementToAbsorb =  -- stole from JoL, idk what any of this is ASCAR remove if not needed
{
    [307] = tpz.mod.FIRE_ABSORB,
    [404] = tpz.mod.ICE_ABSORB, 
    [603] = tpz.mod.WIND_ABSORB,  
    [604] = tpz.mod.EARTH_ABSORB, 
    [624] = tpz.mod.LTNG_ABSORB, 
    [625] = tpz.mod.WATER_ABSORB,
    [626] = tpz.mod.DARK_ABSORB,
    [627] = tpz.mod.LIGHT_ABSORB,
}

]]--

local absorbList =  
{
    [tpz.mod.FIRE_ABSORB],
    [tpz.mod.ICE_ABSORB], 
    [tpz.mod.WIND_ABSORB],  
    [tpz.mod.EARTH_ABSORB], 
    [tpz.mod.LTNG_ABSORB], 
    [tpz.mod.WATER_ABSORB],
    [tpz.mod.DARK_ABSORB],
    [tpz.mod.LIGHT_ABSORB]
}
local spellList =  -- ASCAR fill in the spell lists for the different elements that it uses
{
    [1], --fire 6
    [2], --ice 10
    [3],  --wind 9
    [4], --earth  7
    [5], --thunder 11
    [6], --water 8
    [7], --dark 13
    [8] -- light 12
}
local enLIST =
{
    [EFFECT_ENFIRE],
    [EFFECT_ENBLIZZARD],
    [EFFECT_ENAERO],
    [EFFECT_ENSTONE],
    [EFFECT_ENTHUNDER],
    [EFFECT_ENWATER]
}

local defList = {
    FIREDEF                   = 15, -- Fire Defense
    ICEDEF                    = 16, -- Ice Defense
    WINDDEF                   = 17, -- Wind Defense
    EARTHDEF                  = 18, -- Earth Defense
    THUNDERDEF                = 19, -- Thunder Defense
    WATERDEF                  = 20, -- Water Defense
    LIGHTDEF                  = 21, -- Light Defense
    DARKDEF                   = 22, -- Dark Defense
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.effect.FAST_CAST, 25)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                                      -- 90 minutes
    mob:setMod(tpz.mod.DMG, -80)
    mob:animationSub(0)         -- 3 gears
    mob:setLocalVar("gears", 0)
    mob:setLocalVar("State",math.random(7,8))        -- starts in either light or dark mode
end

function onMobEngaged(mob, target)
    local start = mob:getLocalVar("State")
    mob:setLocalVar("absorbChange", mob:getHP()-1500)   
    mob:setLocalVar("currentAbsorb", start + 458) 
    mob:setSpellList(spellList([start]))
    mob:setMod(absorbList[start], 100)
    mob:setLocalVar("bufferTime", os.time())
    mob:setMod(defList(start), -66)
end


function onMobFight(mob, target)
    local gears = mob:getLocalVar("gears")
    local hpp = mob:getHPP()
    local hp = mob:getLocalVar("absorbChange")
    local state = mob:getLocalVar("State")
    local buffer = mob:getLocalVar("bufferTime")
    local en = enList(state)

    -- This block deals with def/mdef changes from dropping gears (can also do animations if mob family does not work)
    if gears == 0 and hpp <= 49 then
       -- mob:animationSub(1)   -- 2 gears Should be done in mob families ASCAR remove if not needed
        mob:setMod(tpz.mod.DMG, -40)
        mob:setLocalVar("gears", 1)
    elseif gears == 1 and hpp <= 25 then
       -- mob:animationSub(2)   -- 1 gear Should be done in mob families ASCAR remove if not needed
        mob:setMod(tpz.mod.DMG, 1)
        mob:setLocalVar("gears", 2)
    end

    -- This block deals with the element changes (think jailer of love)
  
    if (mob:getHP() <= hp) or ...              -- Either below HP threshhold,
        (os.time()>=buffer and ...             --  or after we give time for the mob to buff...
        (state == 1 or state == 2 or state == 3 or state == 4 or state == 5 or state == 6) and ... -- and your not in light/dark... and
        mob:hasStatusEffect(en) == 0 ) then                                                             -- you dispelled its enspell
        
        if state == 7 or state == 8 then
            local ii = math.random(1,6)
        else
            local ii = math.random(7,8)
        end

        local previousAbsorb = mob:getLocalVar("currentAbsorb")
        mob:setMod(defList(state), 0)                    -- Changing form, so remove current weakness

        if ii == 8 then                         -- apply new weak element
            mob:setMod(defList(7), -66)
        else
            mob:setMod(defList(ii +1), -66)
        end


        if state == 7 or state == 8 then -- If light or dark, go to one of the other elements
            mob:setMod(previousAbsorb, 0)                            --remove old absorb
            mob:setLocalVar("currentAbsorb", ii + 458)
            mob:setMod(absorbList[ii], 100)
            mob:setSpellList(spellList([ii]))
            mob:delStatusEffect(tpz.effect.[en])       -- This may need some syntax work ASCAR
            mob:setLocalVar("absorbChange", mob:getHP()-1500)    
            mob:setLocalVar("State", ii)
       else
            mob:setMod(previousAbsorb, 0)                            --remove old absorb
            --ASCAR force it to cast enspell of current element
            mob:setLocalVar("currentAbsorb", ii + 458)
            mob:setMod(absorbList[ii], 100)
            mob:setSpellList(spellList([ii]))
            mob:setLocalVar("absorbChange", mob:getHP()-1500)
            mob:setLocalVar("State", ii)
       end
    end
end

function onMobDeath(mob, player, isKiller)
end

