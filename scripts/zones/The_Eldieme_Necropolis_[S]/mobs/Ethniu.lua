------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Ethniu
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
------------------------------

function onMobSpawn(mob)
    -- All Mods Here Are Assigned For Initial Difficulty Tuning
    mob:addMod(tpz.mod.MAIN_DMG_RATING, 50)
    mob:addMod(tpz.mod.STR, 50)
    mob:addMod(tpz.mod.VIT, 20)
    mob:addMod(tpz.mod.INT, 50)
    mob:addMod(tpz.mod.MND, 20)
    mob:addMod(tpz.mod.CHR, 20)
    mob:addMod(tpz.mod.AGI, 50)
    mob:addMod(tpz.mod.DEX, 50)
    mob:addMod(tpz.mod.DEFP, 75)
    mob:addMod(tpz.mod.RATTP, 75)
    mob:addMod(tpz.mod.ACC, 150)
    mob:addMod(tpz.mod.EVA, 100)
    -- Adding 10% Triple Since THF
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
    -- Adding 90% Double Attack To Make Up For Lack Of Dual Wield
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 90)
    -- Resistances Based On https://ffxiclopedia.fandom.com/wiki/Ethniu
    mob:setMod(tpz.mod.EARTHDEF, 170)
    mob:setMod(tpz.mod.DARKDEF, 240)
    mob:setMod(tpz.mod.LIGHTDEF, 128)
    mob:setMod(tpz.mod.FIREDEF, 128)
    mob:setMod(tpz.mod.WATERDEF, 170)
    mob:setMod(tpz.mod.THUNDERDEF, 170)
    mob:setMod(tpz.mod.ICEDEF, 170)
    mob:setMod(tpz.mod.WINDDEF, 170)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.STUNRES, 100)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.FASTCAST, 10)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Ethniu
    mob:addStatusEffect(tpz.effect.REGAIN, 10, 3, 0)
    mob:addStatusEffect(tpz.effect.REGEN, 30, 3, 0)
    mob:addStatusEffect(tpz.effect.ENAERO_II, 25, 0, 0)
    mob:addStatusEffect(tpz.effect.REFRESH, 50, 3, 0)
    mob:addStatusEffect(tpz.effect.MAZURKA, 12, 0, 0)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% En-Silence
    if target:hasStatusEffect(tpz.effect.SILENCE) == false then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 25})
    end
end

function onMobFight(mob, target)

    -- Perfect Dodge
    -- Should Be Used Every 5 Minutes, Set to 50% Health As Baseline (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    local timer = mob:getLocalVar("EPerfectDodgeTimer")
    if mob:getHPP() <= 50 then
        if os.time() > timer then
            mob:useMobAbility(693)
            mob:setLocalVar("EPerfectDodgeTimer", os.time() + 300)
        end
    end

    -- Arena Style Draw-In
    -- Should Draw Into A Single Point In the Room, Draws In Anyone In Range (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    if (target:getXPos() > 175.00) then
        print("Draw 1")
        target:setPos(152.955, -15.000, 272.959)
        mob:messageBasic(232, 0, 0, target)
    elseif (target:getYPos() < -18.00 and player:getXPos() > 137.00) then
        print("Draw 2")
        target:setPos(152.955, -15.000, 272.959)
        mob:messageBasic(232, 0, 0, target)
    end

    -- Increases Triple Attack Rate To 80% While Perfect Dodge (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) == true then
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 80)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
    else
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
        mob:setMod(tpz.mod.DOUBLE_ATTACK, 90)
    end
    
    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "LUGH_CTICK", function(mob)
        local levelup = mob:getLocalVar("LLevelUp")

        if mob:AnimationSub() == 1 then
            if levelup > 0 then
                -- Perform Level Up
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                if levelupsum <= 25 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                mob:setLocalVar("LLevelUp", 0)
                mob:AnimationSub(0)
            -- Resets States And Mods
            else
                mob:setLocalVar("LLevelUp", 0)
                mob:AnimationSub(0)
            end
        end
    end)

    -- Magic Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    mob:addListener("MAGIC_TAKE", "LUGH_MAGIC_TAKE", function(target, caster, spell)
        if
            target:AnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            caster:addEnmity(caster, 1000, 1000)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    mob:addListener("TAKE_DAMAGE", "LUGH_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        mob:addEnmity(attacker, 1000, 1000)
    end)
end

function onSpellPrecast(mob, spell)
    if spell:getID() == (208 or 186 or 157 or 359 or 366) then
        mob:setLocalVar("LLevelUp", 1)
        mob:AnimationSub(1)
    end
end

function onMobDisengage(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        mob:DespawnMob(17494093, 0)
        mob:setLocalVar("TotalLevelUp", 0)
    end
end

function onMobDespawn(mob)
    mob:messageBasic(tpz.zone.THE_ELDIEME_NECROPOLIS_S.NM_DESPAWN) -- Despawn Message
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 497)
    player:setTitle(tpz.title.ETHNIU_EXORCIST)
end
