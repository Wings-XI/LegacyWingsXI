-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Cobraclaw Buchzvotch
-- Wrath of the Griffon Fight
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
-- No specific resists
-- Uses Tornado Edge at a higher frequency at lower HP

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1);
    mob:setMobMod(tpz.mobMod.MUG_GIL, -1);
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100);
    mob:setMod(tpz.mod.ATTP, -10) -- tuning, NM hits harder than videos from 2009
end

function onMobWeaponSkillPrepare(mob, target)
    local returnVal = 0
    
    if (mob:getHPP() <= 33) then
        if math.random() < 0.70 then
            returnVal = 2263 -- Tornado Edge
        end
    end

    return returnVal
end

function onMobDeath(mob, player, isKiller)
    if player:getQuestStatus(CRYSTAL_WAR, tpz.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_ACCEPTED then
        player:setCharVar("CobraClawKilled", 1)
    end
end
