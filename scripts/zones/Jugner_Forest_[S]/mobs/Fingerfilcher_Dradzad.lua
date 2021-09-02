-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Fingerfilcher Dradzad
--   Spawned for: Wotg Sandy Quest - Claws Of The Griffon
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100) -- immune to sleep
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.ATTP, 15) -- hits a bit harder than his level
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);
end

function onMobWeaponSkillPrepare(mob, target)
     local hasteEffect = mob:getStatusEffect(tpz.effect.HASTE)
     local counterstanceEffect = tpz.effect.COUNTERSTANCE

     if (mob:getHPP() <= 33) then
        -- at low HP, prefer to buff if not buffed
        if (hasteEffect == nil) then
            return 2202
        elseif (counterstanceEffect == nil) then
            return 2201
        else
           return 0
        end
     end

     return 0
end

function onMobRoam(mob)
end

function onMobWeaponSkill(target, mob, skill)
    if (skill:getID() == 2201) then -- Orcish Counterstance
        mob:showText(mob, ID.text.VOKBROKGREG)
    elseif (skill:getID() == 2202) then -- Berserker Dance
        mob:showText(mob, ID.text.VOKBROKGREG_THREE_TIMES)        
    end
end

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_ACCEPTED then
        player:setCharVar("FingerfilcherKilled", 1)
    end
end
