------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
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
    mob:addMod(tpz.mod.AGI, 20)
    mob:addMod(tpz.mod.DEX, 40)
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.RATTP, 0)
    mob:addMod(tpz.mod.DEFP, 600)
    mob:addMod(tpz.mod.RATTP, 600)
    mob:addMod(tpz.mod.ACC, 100)
    -- Adding 10% Double Since WAR
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10)
    -- Resistances Based On https://ffxiclopedia.fandom.com/wiki/Lugh
    mob:setMod(tpz.mod.EARTHDEF, 170)
    mob:setMod(tpz.mod.DARKDEF, 250)
    mob:setMod(tpz.mod.LIGHTDEF, 128)
    mob:setMod(tpz.mod.FIREDEF, 170)
    mob:setMod(tpz.mod.WATERDEF, 170)
    mob:setMod(tpz.mod.THUNDERDEF, 170)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.WINDDEF, 170)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.FIRE_ABSORB, 100)
    mob:setMod(tpz.mod.STUNRES, 99)
    -- Adding Resbuild for Stun as it was too potent.
    mob:setMod(tpz.mod.RESBUILD_STUN, 50)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.FASTCAST, 10)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Lugh
    mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 50, 0, 0)
    mob:addStatusEffect(tpz.effect.REGAIN, 10, 3, 0)
    mob:addStatusEffect(tpz.effect.REGEN, 30, 3, 0)
    -- Increasing Enfire for Standard Attack Round to 100 (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129695&id=18303)
    mob:addStatusEffect(tpz.effect.ENFIRE_II, 100, 0, 0)
    mob:addStatusEffect(tpz.effect.REFRESH, 50, 3, 0)
    -- Revamping Movement Speed Bonus
    mob:addMod(tpz.mod.MOVE, 12)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% En-Paralyze
    if target:hasStatusEffect(tpz.effect.PLAGUE) == false then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PLAGUE, {chance = 25})
    end
end

function onMobFight(mob, target)

    -- Mighty Strikes
    -- Should Be Used Every 5 Minutes, Set to 50% Health As Baseline (https://ffxiclopedia.fandom.com/wiki/Lugh)
    local timer = mob:getLocalVar("LMightyStrikesTimer")
    if mob:getHPP() <= 50 then
        if os.time() > timer then
            mob:useMobAbility(688)
            mob:setLocalVar("LMightyStrikesTimer", os.time() + 300)
        end
    end

    -- Arena Style Draw-In
    -- Should Draw Into A Single Point In the Room, Draws In Anyone In Range (https://ffxiclopedia.fandom.com/wiki/Lugh)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getZPos() < 214.00 or target:getZPos() > 240.00) and os.time() > drawInWait then
        target:setPos(-196.076, -0.447, 220.810)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() < -218.00 or target:getXPos() > -175.00) and os.time() > drawInWait then
        target:setPos(-196.076, -0.447, 220.810)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end

    -- 20 Yalm Intimidate Aura Wtih Might Strikes Active (https://ffxiclopedia.fandom.com/wiki/Lugh)
    -- This just silently removes and adds Intimidate. Has 20% proc chance.
    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) == true then
        local nearbyPlayers = mob:getPlayersInRange(20)
        if nearbyPlayers == nil then return end
        for _,v in ipairs(nearbyPlayers) do
            local shouldintimidate = math.random(1, 10)
            if shouldintimidate >= 9 then
                if v:hasStatusEffect(tpz.effect.INTIMIDATE) == true then
                    v:delStatusEffectSilent(tpz.effect.INTIMIDATE)
                end
                v:addStatusEffectEx(tpz.effect.INTIMIDATE,tpz.effect.INTIMIDATE, 1, 0, 1)
            end
        end
    end
    
    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "LUGH_CTICK", function(mob)
        local levelup = mob:getLocalVar("LLevelUp")

        if mob:AnimationSub() == 1 then
            if levelup > 0 then
                -- Perform Level Up
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                if levelupsum <= 20 then
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
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Lugh)
    mob:addListener("MAGIC_TAKE", "LUGH_MAGIC_TAKE", function(target, caster, spell)
        if
            target:AnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            target:addEnmity(caster, 1000, 1000)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Lugh)
    mob:addListener("TAKE_DAMAGE", "LUGH_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:addEnmity(attacker, 1000, 1000)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "LUGH_WEAPONSKILL_TAKE", function(target, attacker, skillid, tp, action)
        target:addEnmity(attacker, 1000, 1000)
    end)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 34 then
        mob:setLocalVar("LLevelUp", 1)
        mob:AnimationSub(1)
    end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == (588 or 591 or 645) then
        mob:setLocalVar("LLevelUp", 1)
        mob:AnimationSub(1)
    end
end

function onMobDisengage(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        DespawnMob(17477708)
        mob:setLocalVar("TotalLevelUp", 0)
        mob:setLocalVar("LFightTimer", 0)
        mob:setLocalVar("MobPoof", 1)
    end
    mob:removeListener("LUGH_WEAPONSKILL_TAKE")
    mob:removeListener("LUGH_TAKE_DAMAGE")
    mob:removeListener("LUGH_MAGIC_TAKE")
end

function onMobDespawn(mob) 
    if mob:getLocalVar("MobPoof") == 1 then
        mob:showText(mob, zones[mob:getZoneID()].text.NM_DESPAWN)
        mob:setLocalVar("MobPoof", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 516)
    player:setTitle(tpz.title.LUGH_EXORCIST)
end
