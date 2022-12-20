-----------------------------------
--    Area: Alzadaal Undersea Ruins
--     Mob: Armed Gears
--  Author: Spaceballs
-----------------------------------

mixins = {require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/mobfamilies/Gears")

local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")

local function clearAbsorb(mob) -- we can use this block to "clean the slate" for absorbs and elemental def
    mob:setMod(tpz.mod.FIRE_ABSORB, 0)
    mob:setMod(tpz.mod.EARTH_ABSORB, 0)
    mob:setMod(tpz.mod.WATER_ABSORB, 0)
    mob:setMod(tpz.mod.WIND_ABSORB, 0)
    mob:setMod(tpz.mod.ICE_ABSORB, 0)
    mob:setMod(tpz.mod.LTNG_ABSORB, 0)
    mob:setMod(tpz.mod.LIGHT_ABSORB, 0)
    mob:setMod(tpz.mod.DARK_ABSORB, 0)
    mob:setMod(tpz.mod.FIREDEF, 231)
    mob:setMod(tpz.mod.EARTHDEF, 231)
    mob:setMod(tpz.mod.WATERDEF, 231)
    mob:setMod(tpz.mod.WINDDEF, 231)
    mob:setMod(tpz.mod.ICEDEF, 231)
    mob:setMod(tpz.mod.THUNDERDEF, 231)
    mob:setMod(tpz.mod.LIGHTDEF, 231)
    mob:setMod(tpz.mod.DARKDEF, 231)
end

local function formChange(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    clearAbsorb(mob)

    if mob:getLocalVar("State") == 1 then     -- Fire
        mob:setSpellList(554)
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
        mob:setMod(tpz.mod.WATERDEF, 0)
        mob:setMod(tpz.mod.FIREDEF, 0)
    elseif mob:getLocalVar("State") == 2 then -- Earth
        mob:setSpellList(555)
        mob:setMod(tpz.mod.EARTH_ABSORB, 100)
        mob:setMod(tpz.mod.WINDDEF, 0)
        mob:setMod(tpz.mod.EARTHDEF, 0)
    elseif mob:getLocalVar("State") == 3 then -- Water
        mob:setSpellList(556)
        mob:setMod(tpz.mod.WATER_ABSORB, 100)
        mob:setMod(tpz.mod.THUNDERDEF, 0)
        mob:setMod(tpz.mod.WATERDEF, 0)
    elseif mob:getLocalVar("State") == 4 then -- Wind
        mob:setSpellList(557)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
        mob:setMod(tpz.mod.ICEDEF, 0)
        mob:setMod(tpz.mod.WINDDEF, 0)
    elseif mob:getLocalVar("State") == 5 then -- Ice
        mob:setSpellList(558)
        mob:setMod(tpz.mod.ICE_ABSORB, 100)
        mob:setMod(tpz.mod.FIREDEF, 0)
        mob:setMod(tpz.mod.ICEDEF, 0)
    elseif mob:getLocalVar("State") == 6 then -- Lightning
        mob:setSpellList(559)
        mob:setMod(tpz.mod.LTNG_ABSORB, 100)
        mob:setMod(tpz.mod.EARTHDEF, 0)
        mob:setMod(tpz.mod.THUNDERDEF, 0)
    elseif mob:getLocalVar("State") == 7 then -- Light
        mob:setSpellList(560)
        mob:setMod(tpz.mod.LIGHT_ABSORB, 100)
        mob:setMod(tpz.mod.DARKDEF, 0)
        mob:setMod(tpz.mod.LIGHTDEF, 0)
    else                                      -- Dark
        mob:setSpellList(561)
        mob:setMod(tpz.mod.DARK_ABSORB, 100)
        mob:setMod(tpz.mod.LIGHTDEF, 0)
        mob:setMod(tpz.mod.DARKDEF, 0)
    end
    mob:setLocalVar("Dispelled", 0)
end


function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000)
    mob:setMod(tpz.mod.UFASTCAST, 50)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 5400)                                      -- 90 minutes
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    mob:AnimationSub(0)         -- 3 gears
    mob:setLocalVar("gears", 3)
    mob:setLocalVar("State", math.random(7,8))        -- starts in either light or dark mode
   
    mob:setLocalVar("Change", 0)
    mob:setLocalVar("Dispelled", 0)
    mob:setLocalVar("HP", mob:getHP()-1500)
    formChange(mob)
end

function onMobFight(mob, target)

    -- This Block deals with WHEN it is time to change form

    if mob:getLocalVar("Dispelled") == 1 then -- need to also check for en-spell
        --Means State was 1-6 (one of the other elements), so lets put it to light/dark
        mob:setLocalVar("State", math.random(7,8))
        mob:setLocalVar("Change", 1)
        mob:setLocalVar("Dispelled", 0)
        mob:setLocalVar("HP", mob:getHP()-1500)
    end

    if mob:getLocalVar("HP") >= mob:getHP() then -- we lost enough HP
        
        if mob:getLocalVar("State") == 7 or mob:getLocalVar("State") == 8 then -- Going from Light or Dark
            mob:setSpellList(562)
            mob:setMobMod(tpz.mobMod.MAGIC_COOL, 1)
            
        else -- Means we are in element phase, just dispel our own en-spell and let the other functions change stuff
            mob:setLocalVar("Change", 1)
            if mob:hasStatusEffect(tpz.effect.ENFIRE) then
                mob:delStatusEffect(tpz.effect.ENFIRE)
            elseif mob:hasStatusEffect(tpz.effect.ENAERO) then 
                mob:delStatusEffect(tpz.effect.ENAERO)
            elseif mob:hasStatusEffect(tpz.effect.ENSTONE) then
                mob:delStatusEffect(tpz.effect.ENSTONE)
            elseif mob:hasStatusEffect(tpz.effect.ENWATER) then
                mob:delStatusEffect(tpz.effect.ENWATER)
            elseif mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
                mob:delStatusEffect(tpz.effect.ENBLIZZARD)
            elseif mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
                mob:delStatusEffect(tpz.effect.ENTHUNDER)
            end
        end
        mob:setLocalVar("HP", mob:getHP()-1500)
    end



    if mob:getLocalVar("State") == 7 or mob:getLocalVar("State") == 8 then -- if we are light/dark and get an enspell, means we are changing to that element
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 1)
            mob:setLocalVar("Dispelled", 0)
        elseif mob:hasStatusEffect(tpz.effect.ENAERO) then 
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 4)
            mob:setLocalVar("Dispelled", 0)
        elseif mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 2)
            mob:setLocalVar("Dispelled", 0)
        elseif mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 3)
            mob:setLocalVar("Dispelled", 0)
        elseif mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 5)
            mob:setLocalVar("Dispelled", 0)
        elseif mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:setLocalVar("Change", 1)
            mob:setLocalVar("State", 6)
            mob:setLocalVar("Dispelled", 0)
        end
    else -- We are in an element phase and missing en-spell
        if not (mob:hasStatusEffect(tpz.effect.ENFIRE) or
            mob:hasStatusEffect(tpz.effect.ENAERO) or
            mob:hasStatusEffect(tpz.effect.ENSTONE) or
            mob:hasStatusEffect(tpz.effect.ENWATER) or
            mob:hasStatusEffect(tpz.effect.ENBLIZZARD) or
            mob:hasStatusEffect(tpz.effect.ENTHUNDER)) then
                mob:setLocalVar("Dispelled", 1)
        end
    end
        
    -- This block deals with def/mdef changes from dropping gears.
    if mob:getLocalVar("gears") == 3 and mob:getHPP() <= 49 then
        mob:AnimationSub(1)   -- 2 gears Should be done in mob families ASCAR remove if not needed
        mob:setMod(tpz.mod.DMGPHYS, 25)
        mob:setMod(tpz.mod.DMGRANGE, 25)
        mob:setMod(tpz.mod.DMGMAGIC, 25)
        mob:setLocalVar("gears", 2)
     elseif mob:getLocalVar("gears") == 2 and mob:getHPP() <= 25 then
        mob:AnimationSub(2)   -- 1 gear Should be done in mob families ASCAR remove if not needed
        mob:setMod(tpz.mod.DMGPHYS, 50)
        mob:setMod(tpz.mod.DMGRANGE, 50)
        mob:setMod(tpz.mod.DMGMAGIC, 50)
        mob:setLocalVar("gears", 1)
    end

    -- Below is the block to deal with changing forms.
    if mob:getLocalVar("Change") == 1 then
        mob:setLocalVar("Change", 0)
        formChange(mob)
    end

end

function onMobDeath(mob, player, isKiller)
  
end

function onMobDespawn(mob)

end