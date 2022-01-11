------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Elatha
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
mixins = {require("scripts/mixins/fomor_hate")}
------------------------------

function onMobSpawn(mob)
    -- All Mods Here Are Assigned For Initial Difficulty Tuning
    mob:addMod(tpz.mod.MAIN_DMG_RATING, 50)
    mob:addMod(tpz.mod.STR, 40)
    mob:addMod(tpz.mod.VIT, 20)
    mob:addMod(tpz.mod.INT, 65)
    mob:addMod(tpz.mod.MND, 20)
    mob:addMod(tpz.mod.CHR, 20)
    mob:addMod(tpz.mod.AGI, 20)
    mob:addMod(tpz.mod.DEX, 40)
    mob:setMod(tpz.mod.DEFP, 0)
    mob:setMod(tpz.mod.RATTP, 0)
    -- Raising Defense As Melee Was Doing Too Much Damage
    mob:addMod(tpz.mod.DEFP, 850)
    mob:addMod(tpz.mod.RATTP, 850)
    mob:addMod(tpz.mod.ACC, 100)
    -- Resistances Based On https://ffxiclopedia.fandom.com/wiki/Elatha
    mob:setMod(tpz.mod.EARTHDEF, 200)
    mob:setMod(tpz.mod.DARKDEF, 250)
    mob:setMod(tpz.mod.LIGHTDEF, 200)
    mob:setMod(tpz.mod.FIREDEF, 128)
    mob:setMod(tpz.mod.WATERDEF, 200)
    mob:setMod(tpz.mod.THUNDERDEF, 200)
    mob:setMod(tpz.mod.WINDDEF, 200)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.ICE_ABSORB, 100)
    mob:setMod(tpz.mod.STUNRES, 99)
    -- Adding Resbuild for Stun as it was too potent.
    mob:setMod(tpz.mod.RESBUILD_STUN, 33)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.POISONRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.RESBUILD_SLOW, 10)
    mob:setMod(tpz.mod.FASTCAST, 10)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Elatha
    mob:addStatusEffect(tpz.effect.ICE_SPIKES, 50, 0, 0)
    mob:addStatusEffect(tpz.effect.REGEN, 30, 3, 0)
    -- Increasing Enblizzard for Standard Attack Round to 100 (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129694&id=18305)
    mob:addStatusEffect(tpz.effect.ENBLIZZARD_II, 25, 0, 0)
    mob:addStatusEffect(tpz.effect.REFRESH, 50, 3, 0)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% En-Paralyze
    if target:hasStatusEffect(tpz.effect.PARALYSIS) == false then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 25})
    end
end

function onMobEngage(mob, target)
    -- Set 2 Hour Time Limit (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129696&id=18300)
    mob:setLocalVar("EFightTimer", (os.time() + 7200))
end

function onMobFight(mob, target)
    local fighttimer = mob:getLocalVar("EFightTimer")
    if os.time() > fighttimer then
        mob:disengage()
    end

   -- Blood Weapon
    -- Should Be Used Every 5 Minutes, Set to 50% Health As Baseline (https://ffxiclopedia.fandom.com/wiki/Elatha)
    local timer = mob:getLocalVar("EBloodWeaponTimer")
    if mob:getHPP() <= 50 then
        if os.time() > timer then
            mob:useMobAbility(695)
            mob:setLocalVar("EBloodWeaponTimer", os.time() + 300)
            mob:setLocalVar("EBloodWeaponFollow", 1)
            mob:AnimationSub(1)
        end
    end

    -- 20 Yalm Paralyze Aura Wtih Blood Weapon Active (https://ffxiclopedia.fandom.com/wiki/Elatha)
    -- This just silently removes and adds Paralyze. RIP Battlemod users' HUDs for the next 60 seconds.
    if mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) == true then
        local nearbyPlayers = mob:getPlayersInRange(20)
        if nearbyPlayers == nil then return end
        for _,v in ipairs(nearbyPlayers) do
            v:delStatusEffectSilent(tpz.effect.PARALYSIS)
            v:addStatusEffectEx(tpz.effect.PARALYSIS, tpz.effect.PARALYSIS, 25, 0, 5)
        end
    end

    -- Arena Style Draw-In
    -- Should Draw Into A Single Point In the Room, Draws In Anyone In Range (https://ffxiclopedia.fandom.com/wiki/Elatha)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getZPos() < -111.00 or target:getZPos() > -82.00) and os.time() > drawInWait then
        target:setPos(-140.25, 0.00, -100.00)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif (target:getXPos() < -155.00 or target:getXPos() > -122.00) and os.time() > drawInWait then
        target:setPos(-140.25, 0.00, -100.00)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end

    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "ELATHA_CTICK", function(mob)
        local retaliate = mob:getLocalVar("ERetaliate")
        local efollowup = mob:getLocalVar("EBloodWeaponFollow")

        if mob:AnimationSub() == 1 then
            -- Retaliation Should Cause Level Up And Always Be Blizzard IV With Instant Cast (https://ffxiclopedia.fandom.com/wiki/Elatha)
            if retaliate > 0 and not mob:hasStatusEffect(tpz.effect.SILENCE) then
                -- Perform Retalitory Blizzard IV
                mob:setMod(tpz.mod.UFASTCAST, 100)
                mob:castSpell(152)
                -- Perform Level Up
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                if levelupsum <= 15 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                mob:setLocalVar("ERetaliate", 0)
                mob:AnimationSub(0)
            -- Uses Shockwave Right After Bloodweapon (https://ffxiclopedia.fandom.com/wiki/Elatha)
            elseif efollowup > 0 then
                -- Use Shockwave
                mob:AnimationSub(0)
                mob:addTP(3000)
                mob:useMobAbility(52)
                mob:setLocalVar("EBloodWeaponFollow", 0)
            -- Resets States And Mods
            else
                mob:setLocalVar("ERetaliate", 0)
                mob:setLocalVar("EBloodWeaponFollow", 0)
                mob:setMod(tpz.mod.UFASTCAST, 0)
                mob:AnimationSub(0)
            end
        end
    end)

    -- Magic Retaliation and Level Up Function
    -- Should Always Retaliate When Taking Magic Damage and Level Up (https://ffxiclopedia.fandom.com/wiki/Elatha)
    mob:addListener("MAGIC_TAKE", "ELATHA_MAGIC_TAKE", function(target, caster, spell)
        if
            target:AnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            target:setLocalVar("ERetaliate", 1)
            target:addEnmity(caster, 1000, 1000)
            target:AnimationSub(1)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Elatha)
    mob:addListener("TAKE_DAMAGE", "ELATHA_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:addEnmity(attacker, 1000, 1000)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "ELATHA_WEAPONSKILL_TAKE", function(target, attacker, skillid, tp, action)
        target:addEnmity(attacker, 1000, 1000)
    end)

end

function onMobDisengage(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        DespawnMob(17449008)
        mob:setLocalVar("TotalLevelUp", 0)
        mob:setLocalVar("EFightTimer", 0)
        mob:setLocalVar("MobPoof", 1)
    end

end

function onMobDespawn(mob) 
    if mob:getLocalVar("MobPoof") == 1 then
        mob:showText(mob, zones[mob:getZoneID()].text.NM_DESPAWN)
        mob:setLocalVar("MobPoof", 0)
    end
    mob:removeListener("WEAPONSKILL_TAKE")
    mob:removeListener("TAKE_DAMAGE")
    mob:removeListener("MAGIC_TAKE")
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 534)
    player:setTitle(tpz.title.ELATHA_EXORCIST)
end