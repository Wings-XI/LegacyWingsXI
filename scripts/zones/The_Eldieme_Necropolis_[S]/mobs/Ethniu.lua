------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Ethniu
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins = {require("scripts/mixins/fomor_hate")}
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
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.RATTP, 0)
    mob:addMod(tpz.mod.DEFP, 750)
    mob:addMod(tpz.mod.RATTP, 750)
    mob:addMod(tpz.mod.ACC, 150)
    mob:addMod(tpz.mod.EVA, 100)
    -- Adding 10% Triple Since THF
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
    -- Resistances Based On https://ffxiclopedia.fandom.com/wiki/Ethniu
    mob:setMod(tpz.mod.EARTHDEF, 170)
    mob:setMod(tpz.mod.DARKDEF, 250)
    mob:setMod(tpz.mod.LIGHTDEF, 128)
    mob:setMod(tpz.mod.FIREDEF, 128)
    mob:setMod(tpz.mod.WATERDEF, 170)
    mob:setMod(tpz.mod.THUNDERDEF, 170)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.WINDDEF, 170)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.STUNRES, 99)
    -- Adding Resbuild for Stun as it was too potent.
    mob:setMod(tpz.mod.RESBUILD_STUN, 33)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.RESBUILD_SLOW, 10)
    mob:setMod(tpz.mod.FASTCAST, 10)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Ethniu
    mob:addStatusEffect(tpz.effect.REGAIN, 10, 3, 0)
    mob:addStatusEffect(tpz.effect.REGEN, 30, 3, 0)
    -- Increasing Enaero for Standard Attack Round to Equal 100 (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129696&id=18300)
    mob:addStatusEffect(tpz.effect.ENAERO, 50, 0, 0)
    mob:addStatusEffect(tpz.effect.REFRESH, 50, 3, 0)
    -- Revamping Movement Speed Bonus
    mob:addMod(tpz.mod.MOVE, 12)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% En-Silence
    if target:hasStatusEffect(tpz.effect.SILENCE) == false then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 25})
    end
end

function onMobEngage(mob, target)
    -- Set 2 Hour Time Limit (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129696&id=18300)
    mob:setLocalVar("EFightTimer", (os.time() + 7200000))
end

function onMobFight(mob, target)
    local fighttimer = mob:getLocalVar("EFightTimer")
    if os.time() > fighttimer then
        mob:disengage()
    end

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
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getXPos() > 175.00) and os.time() > drawInWait then
        target:setPos(152.955, -15.000, 272.959)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getYPos() < -18.00 and player:getXPos() > 137.00) and os.time() > drawInWait then
        target:setPos(152.955, -15.000, 272.959)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end

    -- Increases Triple Attack Rate To 80% While Perfect Dodge (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    if mob:hasStatusEffect(tpz.effect.PERFECT_DODGE) == true then
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 80)
    else
        mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
    end
    
    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "ETHNIU_CTICK", function(mob)
        local levelup = mob:getLocalVar("ELevelUp")

        if mob:AnimationSub() == 1 then
            if levelup > 0 then
                -- Perform Level Up
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                if levelupsum <= 25 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                mob:setLocalVar("ELevelUp", 0)
                mob:AnimationSub(0)
            -- Resets States And Mods
            else
                mob:setLocalVar("ELevelUp", 0)
                mob:AnimationSub(0)
            end
        end
    end)

    -- Magic Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    mob:addListener("MAGIC_TAKE", "ETHNIU_MAGIC_TAKE", function(target, caster, spell)
        if
            target:AnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            target:addEnmity(caster, 1000, 1000)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Ethniu)
    mob:addListener("TAKE_DAMAGE", "ETHNIU_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:addEnmity(attacker, 1000, 1000)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "ETHNIU_WEAPONSKILL_TAKE", function(target, attacker, skillid, tp, action)
        target:addEnmity(attacker, 1000, 1000)
    end)
end

function onSpellPrecast(mob, spell)
    if spell:getID() == (208 or 186 or 157 or 359 or 366) then
        mob:setLocalVar("ELevelUp", 1)
        mob:AnimationSub(1)
    end
end

function onMobDisengage(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        DespawnMob(17494093)
        mob:setLocalVar("TotalLevelUp", 0)
        mob:setLocalVar("EFightTimer", 0)
        mob:setLocalVar("MobPoof", 1)
    end
    mob:removeListener("WEAPONSKILL_TAKE")
    mob:removeListener("TAKE_DAMAGE")
    mob:removeListener("MAGIC_TAKE")
end

function onMobDespawn(mob) 
    if mob:getLocalVar("MobPoof") == 1 then
        mob:showText(mob, zones[mob:getZoneID()].text.NM_DESPAWN)
        mob:setLocalVar("MobPoof", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 497)
    player:setTitle(tpz.title.ETHNIU_EXORCIST)
end
