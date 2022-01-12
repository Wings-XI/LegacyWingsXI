------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Tethra
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
    mob:addMod(tpz.mod.DEFP, 750)
    mob:addMod(tpz.mod.RATTP, 750)
    mob:addMod(tpz.mod.ACC, 100)
    -- Resistances Based On https://ffxiclopedia.fandom.com/wiki/Tethra
    mob:setMod(tpz.mod.EARTHDEF, 170)
    mob:setMod(tpz.mod.DARKDEF, 240)
    mob:setMod(tpz.mod.LIGHTDEF, 170)
    mob:setMod(tpz.mod.FIREDEF, 128)
    mob:setMod(tpz.mod.WATERDEF, 170)
    mob:setMod(tpz.mod.THUNDERDEF, 170)
    mob:setMod(tpz.mod.WINDDEF, 128)
    mob:setMod(tpz.mod.ICEDEF, 200)
    mob:setMod(tpz.mod.SILENCERES, 100)
    mob:setMod(tpz.mod.STUNRES, 99)
    -- Adding Resbuild for Stun as it was too potent.
    mob:setMod(tpz.mod.RESBUILD_STUN, 33)
    mob:setMod(tpz.mod.BINDRES, 100)
    mob:setMod(tpz.mod.GRAVITYRES, 100)
    mob:setMod(tpz.mod.SLEEPRES, 100)
    mob:setMod(tpz.mod.POISONRES, 100)
    mob:setMod(tpz.mod.PARALYZERES, 100)
    mob:setMod(tpz.mod.LULLABYRES, 100)
    mob:setMod(tpz.mod.EARTH_ABSORB, 100)
    mob:setMod(tpz.mod.LIGHT_ABSORB, 100)
    -- Status Effecs Based On https://ffxiclopedia.fandom.com/wiki/Tethra
    mob:addStatusEffect(tpz.effect.REGEN, 30, 3, 0)
    mob:setMod(tpz.effect.FAST_CAST, 25)
    -- Increasing Enstone to 100 Per Attack Round (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129692&id=18306)
    mob:addStatusEffect(tpz.effect.ENSTONE_II, 100, 0, 0)
    mob:addStatusEffect(tpz.effect.REFRESH, 50, 3, 0)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    -- 25% En-Petrify https://ffxiclopedia.fandom.com/wiki/Tethra
    if target:hasStatusEffect(tpz.effect.PETRIFICATION) == false then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 25})
    end
end

function onMobEngage(mob, target)
    -- Set 2 Hour Time Limit (http://wiki.ffo.jp/wiki.cgi?Command=HDetail&articleid=129692&id=18306)
    mob:setLocalVar("TFightTimer", (os.time() + 7200000))
end

function onMobFight(mob, target)
    local fighttimer = mob:getLocalVar("TFightTimer")
    if os.time() > fighttimer then
        mob:disengage()
    end


    -- Arena Style Draw-In
    -- Should Draw Into A Single Point In the Room (https://ffxiclopedia.fandom.com/wiki/Tethra)
    local drawInWait = mob:getLocalVar("DrawInWait")

    if (target:getZPos() > -64.00) and os.time() > drawInWait then
        target:setPos(113.621, 8.584, -81.806)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end

    if mob:getCurrentAction() == tpz.act.MAGIC_CASTING then
        mob:setMod(tpz.mod.FIRE_ABSORB, 100)
        mob:setMod(tpz.mod.WATER_ABSORB, 100)
        mob:setMod(tpz.mod.DARK_ABSORB, 100)
        mob:setMod(tpz.mod.LTNG_ABSORB, 100)
        mob:setMod(tpz.mod.ICE_ABSORB, 100)
        mob:setMod(tpz.mod.WIND_ABSORB, 100)
        -- Nullify All Physical Damage
        mob:addMod(tpz.mod.UDMGPHYS, -100)
        mob:addMod(tpz.mod.UDMGRANGE, -100)
    else
        mob:setMod(tpz.mod.FIRE_ABSORB, 0)
        mob:setMod(tpz.mod.WATER_ABSORB, 0)
        mob:setMod(tpz.mod.DARK_ABSORB, 0)
        mob:setMod(tpz.mod.LTNG_ABSORB, 0)
        mob:setMod(tpz.mod.ICE_ABSORB, 0)
        mob:setMod(tpz.mod.WIND_ABSORB, 0)
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
    end

    -- Combat Tick Logic
    mob:addListener("COMBAT_TICK", "TETHRA_CTICK", function(mob)
        local magicretaliate = mob:getLocalVar("TMagicRetaliate")
        local abilityretaliate = mob:getLocalVar("TAbilityRetaliate")
        local abilitylevelup = mob:getLocalVar("TAbilityLevelUp")

        if mob:AnimationSub() == 1 then
            -- Magic Retaliation Should Always Be Stone IV And Instant Cast (https://ffxiclopedia.fandom.com/wiki/Tethra)
            if magicretaliate > 0 then
                -- Instant Cast
                mob:setMod(tpz.mod.UFASTCAST, 100)
                -- Cast Stone IV
                mob:castSpell(162)
                -- Clear Vars
                mob:setLocalVar("TMagicRetaliate", 0)
                mob:removeListener("PLAYER_ABILITY_USED")
                mob:AnimationSub(0)
            -- Retaliates JAs With Instant Cast Stone IV and Level Up (https://ffxiclopedia.fandom.com/wiki/Tethra)
            elseif abilityretaliate > 0 then
                -- Instant Cast
                mob:setMod(tpz.mod.UFASTCAST, 100)
                -- Cast Stone IV
                mob:castSpell(162)
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                -- Level Up
                if levelupsum <= 25 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                -- Clear Vars
                mob:setLocalVar("TAbilityRetaliate", 0)
                mob:removeListener("PLAYER_ABILITY_USED")
                mob:AnimationSub(0)
            -- Uses Level Up When JA Used (https://ffxiclopedia.fandom.com/wiki/Tethra)
            elseif abilitylevelup > 0 then
                local levelupsum = mob:getLocalVar("TotalLevelUp")
                -- Level Up
                if levelupsum <= 25 then
                    mob:useMobAbility(2460)
                    mob:setLocalVar("TotalLevelUp", levelupsum + 1)
                end
                -- Clear Vars
                mob:setLocalVar("TAbilityLevelUp", 0)
                mob:removeListener("PLAYER_ABILITY_USED")
                mob:AnimationSub(0)
            -- Resets States And Mods
            else
                mob:setLocalVar("TAbilityLevelUp", 0)
                mob:setLocalVar("TAbilityRetaliate", 0)
                mob:setLocalVar("TMagicRetaliate", 0)
                mob:setMod(tpz.mod.UFASTCAST, 0)
                mob:AnimationSub(0)
            end
        end
    end)

    -- Manafont
    -- Should Be Used Every 5 Minutes, Set to 50% Health As Baseline (https://ffxiclopedia.fandom.com/wiki/Tethra)
    local timer = mob:getLocalVar("TManafontTimer")
    if mob:getHPP() <= 50 then
        if os.time() > timer then
            mob:useMobAbility(691)
            mob:setLocalVar("TManafontTimer", os.time() + 300)
        end
    end

    -- Job Ability Functions
    -- Retaliates With Instant Stone IV And Level Up If Targeted (https://ffxiclopedia.fandom.com/wiki/Tethra)
    -- Starts Level Up Sequence When Any Other Ability Is Used (https://ffxiclopedia.fandom.com/wiki/Tethra)
    mob:addListener("PLAYER_ABILITY_USED", "TETHRA_PLAYER_ABILITY_USED", function(mob, player, ability, action, target)
        --Retaliate and Level Up
        if ability:getID() == (46) then
            mob:setLocalVar("TAbilityRetaliate", 1)
            mob:AnimationSub(1)
        -- Level Up
        else
            mob:setLocalVar("TAbilityLevelUp", 1)
            mob:AnimationSub(1)
        end
    end)

    -- Magic Handling
    -- Mob Should Retaliate With Instant Cast Stone IV (https://ffxiclopedia.fandom.com/wiki/Tethra)
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Tethra)
    mob:addListener("MAGIC_TAKE", "TETHRA_MAGIC_TAKE", function(target, caster, spell)
        if
            target:AnimationSub() == 0 and
            spell:tookEffect() and
            (caster:isPC() or caster:isPet())
        then
            target:setLocalVar("TMagicRetaliate", 1)
            target:addEnmity(caster, 1000, 1000)
            target:AnimationSub(1)
        end
    end)

    -- Enmity Handling
    -- Mob Should Have Little To No Enmity Control (https://ffxiclopedia.fandom.com/wiki/Tethra)
    mob:addListener("TAKE_DAMAGE", "TETHRA_TAKE_DAMAGE", function(mob, amount, attacker, attackType, damageType)
        if attackType == tpz.attackType.PHYSICAL then
            mob:addEnmity(attacker, 1000, 1000)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "TETHRA_WEAPONSKILL_TAKE", function(target, attacker, skillid, tp, action)
        target:addEnmity(attacker, 1000, 1000)
    end)

end

function OnSpellPrecast(caster, target, spell)
    if spell:getID() == 210 then
        if caster:hasStatusEffect(tpz.effect.MANAFONT) == true then
            spell:setAoE(tpz.magic.aoe.RADIAL)
            spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
            spell:setRadius(15)
        end
    end
end

function onMobDisengage(mob)
    local levelupsum = mob:getLocalVar("TotalLevelUp")
    if mob:getHPP() < 100 or levelupsum > 0 then
        DespawnMob(17494213)
        mob:setLocalVar("TotalLevelUp", 0)
        mob:setLocalVar("TFightTimer", 0)
        mob:setLocalVar("MobPoof", 1)
    end
    mob:removeListener("WEAPONSKILL_TAKE")
    mob:removeListener("TAKE_DAMAGE")
    mob:removeListener("MAGIC_TAKE")
    mob:removeListener("PLAYER_ABILITY_USED")
end

function onMobDespawn(mob) 
    if mob:getLocalVar("MobPoof") == 1 then
        mob:showText(mob, zones[mob:getZoneID()].text.NM_DESPAWN)
        mob:setLocalVar("MobPoof", 0)
    end
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 496)
    player:setTitle(tpz.title.TETHRA_EXORCIST)
end