-----------------------------------
-- Area: Ruhotz Silvermines
--  Mob: Ulbrecht
-----------------------------------
local ID = require("scripts/zones/Ruhotz_Silvermines/IDs")
require("scripts/globals/instance")
-----------------------------------

-- Try to give him some decent AI
function onMonsterMagicPrepare(mob, target)

    local rnd = math.random()
    local hpp = mob:getHPP()

    -- if target then
    --     target:PrintToPlayer("STATUS -> MP:" .. mob:getMP() .. " TP:" .. mob:getTP())
    --     local effectString = "EFFECTS -> "
    --     local effects = mob:getStatusEffects()
    --     for _,effect in ipairs(effects) do
    --         effectString = effectString .. effect:getType() .. ", "
    --     end
    --     target:PrintToPlayer(effectString)
    --     target:PrintToPlayer("onMonsterMagicPrepare random: " .. rnd)
    -- end

    -- Survival
    -- If under 30% then 50% chance to cure top priority
    if hpp < 30 and rnd < 0.5 then
        mob:setLocalVar("lastSpellID", 4)
        return 4 -- Cure IV
    end

    -- Buffs
    -- If does not have protect then 70% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.PROTECT) and rnd < 0.7 then
        return 45
    end
    -- If does not have shell then 30% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.SHELL) and rnd < 0.30 then
        return 50
    end
    -- If does not have regen then 20% chance to rebuff
    if not mob:hasStatusEffect(tpz.effect.REGEN) and rnd < 0.20 then
        return 110
    end
    
    -- Enfeeble/Dark spells sleep 10% drain 10% dispel 5% aspir 5%
    if rnd < 0.1 then
        return 253 -- sleep
    elseif rnd < 0.2 then
        return 245 -- drain
    elseif rnd < 0.25 then
        return 260 -- dispel
    elseif rnd < 0.3 and target:getMP() > 50 then -- make sure they have MP worthy of using aspir
        return 247 -- aspir
    end

    local effects = mob:getStatusEffects()
    local storm = 0
    for _,effect in ipairs(effects) do
        local effectType = effect:getType()
        if effectType >= tpz.effect.FIRESTORM and effectType <= tpz.effect.VOIDSTORM then
            storm = effectType
            break
        end
    end

    rnd = math.random() -- new random number needed here

    -- if target then
    --     target:PrintToPlayer("onMonsterMagicPrepare random2: " .. rnd)
    -- end

    if storm == 0 then
        return determineStorm(hpp, rnd)
    end
    
    -- Offensive spells
    local lastSpellID = mob:getLocalVar("lastSpellID")
    local switch = { -- cast T3 spell, then next time 60/10/30 cast T3/T1/Storm
        [178] = function()	-- FIRESTORM

            if lastSpellID == 146 then -- fire iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 144 -- fire i
                end
            end

            return 146 -- fire iii (if not last spell or 60%)
        end,
        [179] = function()	-- HAILSTORM

            if lastSpellID == 151 then -- blizzard iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 149 -- blizzard i
                end
            end

            return 151-- blizzard iii (if not last spell or 60%)
        end,
        [180] = function()	-- WINDSTORM

            if lastSpellID == 156 then -- aero iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 154 -- aero i
                end
            end

            return 156 -- aero iii (if not last spell or 60%)
        end,
        [181] = function()	-- SANDSTORM
            
            if lastSpellID == 161 then -- stone iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 159 -- stone i
                end
            end

            return 161 -- stone iii (if not last spell or 60%)
        end,
        [182] = function()	-- THUNDERSTORM
            
            if lastSpellID == 166 then -- thunder iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 164 -- thunder i
                end
            end

            return 166 -- thunder iii (if not last spell or 60%)
        end,
        [183] = function()	-- RAINSTORM
            
            if lastSpellID == 171 then -- water iii
                if rnd < 0.3 then -- new storm
                    return determineStorm(hpp, rnd)
                elseif rnd < 0.4 then
                    return 169 -- water i
                end
            end

            return 171 -- water iii (if not last spell or 60%)
        end,
        [184] = function()	-- AURORASTORM
            
            if lastSpellID == 4 and rnd < 0.3 then -- 30% chance for new storm if we have already cast cure iv
                return determineStorm(hpp, rnd)
            end

            return 4 -- cure iv
        end,
        [185] = function()	-- VOIDSTORM
            if rnd < 0.9 and (lastSpellID == 245 or lastSpellID == 247) then -- 90% chance to switch storm after use of drain/aspir
                return determineStorm(hpp, rnd)
            end
            if rnd < 0.8 then
                return 245 -- drain 80%
            else
                return 247 -- aspir 20%
            end
        end
    }

    local spellFunc = switch[storm];

    if spellFunc then
        local spellID = spellFunc()
        mob:setLocalVar("lastSpellID", spellID)
        return spellID
    end
    
    return 253 -- sleep (this should never be returned but just in case)
end

function determineStorm(hpp, rnd)
    -- If under 40% hp then 50% chance to buff auroras (will suggest cures)
    if hpp < 40 and rnd < 0.5 then
        return 119
    end

    local stormID = 113 + math.random(0,7)
    if stormID == 120 or stormID == 119 and hpp > 80 then -- dont buff auroras unless missing some HP
        return 99 -- sandstorm 
    else
        return stormID
    end
end

function onMobSpawn(mob)
    mob:setUnkillable(true)
    mob:SetMagicCastingEnabled(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(tpz.mobMod.STANDBACK_COOL, 12)
    mob:setLocalVar("specialThreshold", math.random(45, 55));
end

function onMobFight(mob, player)

    if mob:getHPP() < mob:getLocalVar("specialThreshold") then
        mob:messageText(mob, ID.text.MOST_IMPRESSIVE)
        mob:useMobAbility(2261)
        mob:setLocalVar("specialThreshold", 0)
    end

    local instance = mob:getInstance()
    if mob:getHPP() <= 20 and not instance:completed() then
        mob:messageText(mob, ID.text.STUDENT_BECOME_MASTER)
        instance:complete()
    end

    if os.time() >= mob:getLocalVar("stratagem_cooldown") and mob:getLocalVar("force_stratagem_tp") == 0 then
        --player:PrintToPlayer("force stratagem tp " .. mob:getTP(), 29)
        mob:setLocalVar("force_stratagem_tp", mob:getTP())
        mob:setTP(3000) -- if stratagem is ready, increase tp to 3000 to force it
    end
end

function onMobEngaged(mob, target)
    if mob:getLocalVar("dialog") == 0 then

        mob:SetMagicCastingEnabled(true)
        mob:useMobAbility(2303) -- use dark arts
        mob:messageText(mob, ID.text.MADE_YOUR_PEACE)
        mob:setLocalVar("dialog", 1)
        mob:setLocalVar("stratagem_cooldown", os.time())
        mob:setLocalVar("force_stratagem_tp", -1) -- prevent startup stratagem + ws
        mob:setTP(500) -- start with some TP
         
        mob:setMobMod(tpz.mobMod.NO_MOVE, 0) -- allow movement
    end
end

function onMobWeaponSkillPrepare(mob, target)

    -- if target then
    --     target:PrintToPlayer("STATUS -> MP:" .. mob:getMP() .. " TP:" .. mob:getTP())
    --     target:PrintToPlayer("onMobWeaponSkillPrepare-stratagem_CD: " .. os.time() - mob:getLocalVar("stratagem_cooldown"))
    -- end

    -- 2314: Parsimony
    -- 2315: Alacrity
    -- 2316: Manifestation
    -- 2317: Ebullience
    local stratagemBase = 2314
    -- stratagem not on cooldown, or has tabula rasa
    if os.time() >= mob:getLocalVar("stratagem_cooldown") then
        return stratagemBase + math.random(0,3)
    end

    if mob:hasStatusEffect(tpz.effect.TABULA_RASA) then
        local availableStratagems = {}
        if not mob:hasStatusEffect(tpz.effect.PARSIMONY) then
            table.insert(availableStratagems, 2314)
        end
        if not mob:hasStatusEffect(tpz.effect.ALACRITY) then
            table.insert(availableStratagems, 2315)
        end
        if not mob:hasStatusEffect(tpz.effect.MANIFESTATION) then
            table.insert(availableStratagems, 2316)
        end
        if not mob:hasStatusEffect(tpz.effect.EBULLIENCE) then
            table.insert(availableStratagems, 2317)
        end
        if (#availableStratagems > 0) then
            local stratagem = availableStratagems[math.random(#availableStratagems)]
            return stratagem
        end
    end

    -- 16: Wasp Sting
    -- 17: Viper Bite
    -- 18: Shadowstitch
    local weaponskillBase = 16
    -- if weaponskill not on cooldown, use one
    return weaponskillBase + math.random(0,2) -- 0, 1, or 2
end

function onMobWeaponSkill(target, mob, skill, action)
    local skillID = skill:getID()
    if skillID >= 2314 and skillID < 2318 then
        mob:setLocalVar("stratagem_cooldown", os.time() + 63)
        local forceStratagemTP = mob:getLocalVar("force_stratagem_tp")
        if forceStratagemTP > 0 then
            mob:setLocalVar("force_stratagem_tp", 0)
            mob:setTP(forceStratagemTP)
        end
    end
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRES, 10)
    mob:addMod(tpz.mod.INT, 10)

    mob:addListener("WEAPONSKILL_TAKE", "ULBRECHT_WEAPONSKILL_TAKE", function(target, user, wsid, tp, action)
        -- this should be high damage weaponskills but can't figure this out yet so, going with 30% chance

        if user:isPC() and math.random() < 0.3 then
            target:messageText(target, ID.text.PAINFUL_LESSON)
        end
    end)

    mob:addListener("MAGIC_START", "ULBRECHT_MAGIC_START", function(m, spell, action)
        if math.random(0,99) < 50 and spell:canTargetEnemy() then -- check offensive spells only
            m:messageText(m, ID.text.TRUE_TEACHING)
        end
    end)
end

function onMobDeath(mob, player, isKiller)
end

function onCastStarting(mob, spell)
    if mob:hasStatusEffect(tpz.effect.ALACRITY) then
        -- local target = mob:getTarget()
        -- local isPlayer = target and target:isPC()
        -- if target and isPlayer then
        --     target:PrintToPlayer("ALACRITY")
        -- end
        spell:castTime(spell:castTime()/10) -- 1000% increased cast speed
    end
end

function onSpellPrecast(mob, spell)
    -- local target = mob:getTarget()
    -- local isPlayer = target and target:isPC()

    if mob:hasStatusEffect(tpz.effect.EBULLIENCE) and
        (spell:getSkillType() == tpz.skill.HEALING_MAGIC or
        spell:getSkillType() == tpz.skill.ELEMENTAL_MAGIC or
        spell:getSkillType() == tpz.skill.DARK_MAGIC) then
            -- if target and isPlayer then
            --     target:PrintToPlayer("EBULLIENCE")
            -- end
        spell:multiplier(spell:multiplier() * 1.4) -- 40% potency increase

    end

    if mob:hasStatusEffect(tpz.effect.MANIFESTATION) and spell:canTargetEnemy() then
        -- if target and isPlayer then
        --     target:PrintToPlayer("MANIFESTATION")
        -- end
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setRadius(10)
        if(spell:getID() % 5 == 1) then -- t3 spells only (mod 5 == 1)
            spell:setAnimation(spell:getAnimation() + 30) -- t3 becomes ga-3
        end
    end

    if mob:hasStatusEffect(tpz.effect.PARSIMONY) then
        -- if target and isPlayer then
        --     target:PrintToPlayer("PARSIMONY")
        -- end
        spell:setMPCost(1) -- normally 50% but superpowered
    end
end