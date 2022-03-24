-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Oupire
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN_CUSTOM_RANGE, 10)
    mob:setMod(tpz.mod.LIGHTDEF, 54)
    mob:setMod(tpz.mod.DARKDEF, 200)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
    mob:setMod(tpz.mod.LULLABYRES, 25)
    mob:setMod(tpz.mod.SLEEPRES, 80)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setLocalVar("spellstate", math.random(1,6))
end

function onAdditionalEffect(mob, target, damage)
    if mob:getLocalVar("spellstate") == 1 then -- Fire
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PLAGUE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 2 then -- Ice
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 3 then -- Wind
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 4 then -- Earth
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 5 then -- Thunder
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 6 then -- Water
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 100})
    end
end

function onMobFight(mob, target)

    -- Setup Attack Modifiers
    if mob:getHPP() <= 100 and mob:getHPP() >= 90 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 80)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 90 and mob:getHPP() > 80 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 60)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 40)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 80 and mob:getHPP() > 70 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 60)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 40)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 70 and mob:getHPP() > 60 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 40)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 60)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 60 and mob:getHPP() > 50 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 80)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 50 and mob:getHPP() > 40 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 100)
        mob:setMod(tpz.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 40 and mob:getHPP() > 30 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 80)
        mob:setMod(tpz.mod.QUAD_ATTACK, 20)
    elseif mob:getHPP() <= 30 and mob:getHPP() > 20 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 50)
        mob:setMod(tpz.mod.QUAD_ATTACK, 50)
    elseif mob:getHPP() <= 20 and mob:getHPP() > 10 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 30)
        mob:setMod(tpz.mod.QUAD_ATTACK, 70)
    elseif mob:getHPP() <= 10 and mob:getHPP() > 0 then
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 0)
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 20)
        mob:setMod(tpz.mod.QUAD_ATTACK, 80)
    end

    -- Phase Shifting

    if mob:getLocalVar("spellstate") == 1 then -- Fire
        mob:setSpellList(515)
        mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(tpz.effect.ENFIRE, 10, 0, 9000000)
        mob:setMod(tpz.mod.FIREDEF, 200)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        mob:setMod(tpz.mod.BLINK, 0)
        mob:setMod(tpz.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.ICEDEF, 128)
        mob:setMod(tpz.mod.WINDDEF, 128)
        mob:setMod(tpz.mod.EARTHDEF, 128)
        mob:setMod(tpz.mod.THUNDERDEF, 128)
        mob:setMod(tpz.mod.WATERDEF, 128)
        mob:setMod(tpz.mod.POISONRES, 50)
        mob:setMod(tpz.mod.PARALYZERES, 50)
        mob:setMod(tpz.mod.BINDRES, 50)
        mob:setMod(tpz.mod.SLOWRES, 50)
        mob:setMod(tpz.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:delStatusEffect(tpz.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(tpz.effect.ENAERO) then
            mob:delStatusEffect(tpz.effect.ENAERO)
        end
        if mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:delStatusEffect(tpz.effect.ENSTONE)
        end
        if mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:delStatusEffect(tpz.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:delStatusEffect(tpz.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 2 then -- Ice
        mob:setSpellList(510)
        mob:addStatusEffect(tpz.effect.ICE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(tpz.effect.ENBLIZZARD, 10, 0, 9000000)
        mob:setMod(tpz.mod.ICEDEF, 200)
        mob:setMod(tpz.mod.BINDRES, 100)
        mob:setMod(tpz.mod.PARALYZERES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(tpz.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        mob:setMod(tpz.mod.BLINK, 0)
        mob:setMod(tpz.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.FIREDEF, 128)
        mob:setMod(tpz.mod.WINDDEF, 128)
        mob:setMod(tpz.mod.EARTHDEF, 128)
        mob:setMod(tpz.mod.THUNDERDEF, 128)
        mob:setMod(tpz.mod.WATERDEF, 128)
        mob:setMod(tpz.mod.POISONRES, 50)
        mob:setMod(tpz.mod.SLOWRES, 50)
        mob:setMod(tpz.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:delStatusEffect(tpz.effect.ENFIRE)
        end
        if mob:hasStatusEffect(tpz.effect.ENAERO) then
            mob:delStatusEffect(tpz.effect.ENAERO)
        end
        if mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:delStatusEffect(tpz.effect.ENSTONE)
        end
        if mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:delStatusEffect(tpz.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:delStatusEffect(tpz.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 3 then -- Wind
        mob:setSpellList(511)
        mob:setMod(tpz.mod.BLINK, 1)
        mob:addStatusEffect(tpz.effect.ENAERO, 10, 0, 9000000)
        mob:setMod(tpz.mod.WINDDEF, 200)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        mob:setMod(tpz.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.FIREDEF, 128)
        mob:setMod(tpz.mod.ICEDEF, 128)
        mob:setMod(tpz.mod.EARTHDEF, 128)
        mob:setMod(tpz.mod.THUNDERDEF, 128)
        mob:setMod(tpz.mod.WATERDEF, 128)
        mob:setMod(tpz.mod.POISONRES, 50)
        mob:setMod(tpz.mod.PARALYZERES, 50)
        mob:setMod(tpz.mod.BINDRES, 50)
        mob:setMod(tpz.mod.SLOWRES, 50)
        mob:setMod(tpz.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:delStatusEffect(tpz.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:delStatusEffect(tpz.effect.ENFIRE)
        end
        if mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:delStatusEffect(tpz.effect.ENSTONE)
        end
        if mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:delStatusEffect(tpz.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:delStatusEffect(tpz.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 4 then -- Earth
        mob:setSpellList(512)
        mob:addStatusEffect(tpz.effect.ENSTONE, 10, 0, 9000000)
        mob:setMod(tpz.mod.EARTHDEF, 200)
        mob:setMod(tpz.mod.SLOWRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        mob:setMod(tpz.mod.BLINK, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.FIREDEF, 128)
        mob:setMod(tpz.mod.ICEDEF, 128)
        mob:setMod(tpz.mod.WINDDEF, 128)
        mob:setMod(tpz.mod.THUNDERDEF, 128)
        mob:setMod(tpz.mod.WATERDEF, 128)
        mob:setMod(tpz.mod.POISONRES, 50)
        mob:setMod(tpz.mod.PARALYZERES, 50)
        mob:setMod(tpz.mod.BINDRES, 50)
        mob:setMod(tpz.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:delStatusEffect(tpz.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(tpz.effect.ENAERO) then
            mob:delStatusEffect(tpz.effect.ENAERO)
        end
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:delStatusEffect(tpz.effect.ENFIRE)
        end
        if mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:delStatusEffect(tpz.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:delStatusEffect(tpz.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 5 then -- Thunder
        mob:setSpellList(513)
        mob:addStatusEffect(tpz.effect.SHOCK_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(tpz.effect.ENTHUNDER, 10, 0, 9000000)
        mob:setMod(tpz.mod.THUNDERDEF, 200)
        mob:setMod(tpz.mod.STUNRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(tpz.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.ICE_SPIKES)
        end
        mob:setMod(tpz.mod.BLINK, 0)
        mob:setMod(tpz.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.FIREDEF, 128)
        mob:setMod(tpz.mod.ICEDEF, 128)
        mob:setMod(tpz.mod.WINDDEF, 128)
        mob:setMod(tpz.mod.EARTHDEF, 128)
        mob:setMod(tpz.mod.WATERDEF, 128)
        mob:setMod(tpz.mod.POISONRES, 50)
        mob:setMod(tpz.mod.PARALYZERES, 50)
        mob:setMod(tpz.mod.BINDRES, 50)
        mob:setMod(tpz.mod.SLOWRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:delStatusEffect(tpz.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(tpz.effect.ENAERO) then
            mob:delStatusEffect(tpz.effect.ENAERO)
        end
        if mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:delStatusEffect(tpz.effect.ENSTONE)
        end
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:delStatusEffect(tpz.effect.ENFIRE)
        end
        if mob:hasStatusEffect(tpz.effect.ENWATER) then
            mob:delStatusEffect(tpz.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 6 then -- Water
        mob:setSpellList(514)
        mob:addStatusEffect(tpz.effect.ENWATER, 10, 0, 9000000)
        mob:setMod(tpz.mod.WATERDEF, 200)
        mob:setMod(tpz.mod.POISONRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(tpz.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
            mob:delStatusEffect(tpz.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(tpz.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(tpz.effect.SHOCK_SPIKES)
        end
        mob:setMod(tpz.mod.BLINK, 0)
        mob:setMod(tpz.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(tpz.mod.FIREDEF, 128)
        mob:setMod(tpz.mod.ICEDEF, 128)
        mob:setMod(tpz.mod.WINDDEF, 128)
        mob:setMod(tpz.mod.EARTHDEF, 128)
        mob:setMod(tpz.mod.THUNDERDEF, 128)
        mob:setMod(tpz.mod.PARALYZERES, 50)
        mob:setMod(tpz.mod.BINDRES, 50)
        mob:setMod(tpz.mod.SLOWRES, 50)
        mob:setMod(tpz.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(tpz.effect.ENBLIZZARD) then
            mob:delStatusEffect(tpz.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(tpz.effect.ENAERO) then
            mob:delStatusEffect(tpz.effect.ENAERO)
        end
        if mob:hasStatusEffect(tpz.effect.ENSTONE) then
            mob:delStatusEffect(tpz.effect.ENSTONE)
        end
        if mob:hasStatusEffect(tpz.effect.ENTHUNDER) then
            mob:delStatusEffect(tpz.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(tpz.effect.ENFIRE) then
            mob:delStatusEffect(tpz.effect.ENFIRE)
        end
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2106 then -- Bloodrake (Fire)
        mob:setLocalVar("spellstate", 1)
    elseif skill:getID() == 2111 then -- Eternal Damnation (Ice)
        mob:setLocalVar("spellstate", 2)
    elseif skill:getID() == 2110 then -- Wings of Gehenna (Wind)
        mob:setLocalVar("spellstate", 3)
    elseif skill:getID() == 2109 then -- Heliovoid (Earth)
        mob:setLocalVar("spellstate", 4)
        mob:setMod(tpz.mod.STONESKIN, 750)
    elseif skill:getID() == 2107 then -- Decollation (Thunder)
        mob:setLocalVar("spellstate", 5)
    elseif skill:getID() == 2108 then -- Nosferatu's Kiss (Water)
        mob:setLocalVar("spellstate", 6)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 478)
    player:addTitle(tpz.title.OUPIRE_IMPALER)
end

function onMobDespawn(mob)
    local respawn = math.random(14400, 18000)
    mob:setRespawnTime(respawn) -- 4 to 5 hours
    SetServerVariable("Oupire_Respawn", (os.time() + respawn))
end
