-----------------------------------
-- Area: Davoi
--  Mob: Deloknok
-- Involved in Quest: The First Meeting
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 12)
end

function onMobFight(mob, target)
    local theFirstMeeting = target:getQuestStatus(BASTOK, tpz.quest.id.bastok.THE_FIRST_MEETING)
    local martialArtsScroll = target:hasKeyItem(tpz.ki.SANDORIAN_MARTIAL_ARTS_SCROLL)

    if (theFirstMeeting == QUEST_ACCEPTED and martialArtsScroll == false and target:getCharVar("theFirstMeetingSpawnedNM")) == 0 then
        target:addCharVar("theFirstMeetingSpawnedNM", 1)
    end
end
