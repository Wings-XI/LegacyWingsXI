-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Karababa
-- Mission: Shield of Diplomacy
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
-----------------------------------
function onMobInitialize(mob)
    mob:setMod(tpz.mod.MATT, 60)
    mob:setMod(tpz.mod.MACC, 500)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)
    mob:setMod(tpz.mod.DEF, 350)
end

function onMobEngaged(mob, target)
    mob:showText(mob, ID.text.KARABABA_FIGHT)
end

function onMobFight(mob, target)
    local warp = mob:getLocalVar("warp")
    local talk = mob:getLocalVar("talk")

    if mob:getHPP() <= 90 and talk == 0 then
        mob:showText(mob, ID.text.KARABABA_OOF)
        mob:setLocalVar("talk", 1)
    elseif mob:getHPP() <= 80 and talk == 1 then
        mob:showText(mob, ID.text.KARABABA_OUCH)
        mob:setLocalVar("talk", 2)
    elseif mob:getHPP() <= 70 and talk == 2 then
        mob:showText(mob, ID.text.KARABABA_URGH)
        mob:setLocalVar("talk", 3)
    elseif mob:getHPP() <= 60 and talk == 3 then
        mob:showText(mob, ID.text.KARABABA_OOF)
        mob:setLocalVar("talk", 4)
    elseif mob:getHPP() <= 50 and mob:getLocalVar("powerup") == 0 then
        target:showText(mob, ID.text.KARABABA_ENOUGH)
        target:showText(mob, ID.text.KARABABA_ROUGH)
        mob:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, 999, 0, 60)
        mob:addMod(tpz.mod.MATT, 2000)
        mob:addMod(tpz.mod.MACC, 2500)
        mob:addMod(tpz.mod.DMGPHYS,-90)
        mob:addMod(tpz.mod.DMGMAGIC,-90)
        mob:addMod(tpz.mod.DEF,999)
        mob:setMobMod(tpz.mobMod.MAGIC_COOL,10)
        mob:setLocalVar("powerup", 1)
    elseif mob:getHPP() <= 40 and talk == 4 then
        mob:showText(mob, ID.text.KARABABA_OUCH)
        mob:setLocalVar("talk", 5)
    elseif mob:getHPP() <= 30 and talk == 5 then
        mob:showText(mob, ID.text.KARABABA_HURT)
        mob:setLocalVar("talk", 6)
    elseif mob:getHPP() <= 20 and warp == 0 then
        mob:setLocalVar("warp", 1)
    end

    mob:addListener("EFFECT_LOSE", "KARABABA_EFFECT_LOSE", function(mob, effect) 
        if effect:getType() == tpz.effect.MAGIC_ATK_BOOST then
            mob:setLocalVar("powerup", 2)
            mob:setMobMod(tpz.mobMod.MAGIC_COOL, 35)
            mob:addMod(tpz.mod.MATT, 60)
            mob:addMod(tpz.mod.MACC, 500)
            mob:setMod(tpz.mod.DMGPHYS,0)
            mob:setMod(tpz.mod.DMGMAGIC,0)
            mob:setMod(tpz.mod.DEF, 350)
        end
    end) 

    mob:addListener("MAGIC_STATE_EXIT", "KARABABA_MAGIC_STATE_EXIT", function (mob, spell)
        if spell:getID() == 261 then
            mob:leaveBattlefield(1)
            mob:SetMagicCastingEnabled(false)
            mob:setLocalVar("warp", 2)
            mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
        end
    end)

end

function onCastStarting(mob, spell)
    -- Flavor text for AM2 spells only, per capture
    if spell:getID() == 205 then
        mob:showText(mob, ID.text.KARABABA_FIRE)
    elseif spell:getID() == 207 then
        mob:showText(mob, ID.text.KARABABA_ICE)
    elseif spell:getID() == 209 then
        mob:showText(mob, ID.text.KARABABA_WIND)
    elseif spell:getID() == 211 then
        mob:showText(mob, ID.text.KARABABA_EARTH)
    elseif spell:getID() == 213 then
        mob:showText(mob, ID.text.KARABABA_LIGHTNING)
    elseif spell:getID() == 215 then
        mob:showText(mob, ID.text.KARABABA_WATER)
    elseif spell:getID() == 261 then
        mob:showText(mob, ID.text.KARABABA_QUIT)
    end
end

function onMonsterMagicPrepare(mob, target)
    local powerup = mob:getLocalVar("powerup")
    local rnd = math.random(1, 6)
    local warp = mob:getLocalVar("warp")

    if warp == 1 then
        return 261
    elseif rnd == 1 then
        if powerup == 1 then
            return 144
        else            
            return 205
        end
    elseif rnd == 2 then
        if powerup == 1 then
           return 149
        else
           return 207
        end
    elseif rnd == 3 then
        if powerup == 1 then
           return 154
        else
           return 209
        end
    elseif rnd == 4 then
        if powerup == 1 then
           return 159
        else
           return 211
        end
    elseif rnd == 5 then
        if powerup == 1 then
           return 164
        else
           return 213
        end
    elseif rnd == 6 then
        if powerup == 1 then
           return 169
        else
           return 215
        end
    end
end

function onMobDeath(mob, player, isKiller)
    mob:showText(mob, ID.text.KARABABA_QUIT)
end
