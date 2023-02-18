-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zalsuhm
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/equipment")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/weaponskillids")
-----------------------------------

-- note: since we currently save floor progress on ANY exited floor, not just steps of 5 this will give players a slightly better gradient
function getRequiredWsPoints(nyzulFloorProgress)
    if (nyzulFloorProgress == 100) then
        return 250
    elseif (nyzulFloorProgress >= 80) then
        return 500 + (20 * (99 - nyzulFloorProgress))
    elseif (nyzulFloorProgress >= 60) then
        return 1000 + (40 * (79 - nyzulFloorProgress))
    elseif (nyzulFloorProgress >= 40) then
        return 2000 + (80 * (59 - nyzulFloorProgress))
    elseif (nyzulFloorProgress >= 20) then
        return 4000 + (160 * (39 - nyzulFloorProgress))
    elseif (nyzulFloorProgress > 0) then
        return 8000 + (320 * (19 - nyzulFloorProgress))
    else
        return 16000
    end
end

function getQuestId(mainJobId)
    return tpz.quest.id.jeuno.UNLOCKING_A_MYTH_WARRIOR - 1 + mainJobId
end

function onTrade(player, npc, trade)
    for i, wepId in pairs(BaseNyzulWeapons) do
        if npcUtil.tradeHasExactly(trade, wepId) then
            local unlockingAMyth = player:getQuestStatus(JEUNO, getQuestId(i))
            if unlockingAMyth == QUEST_ACCEPTED then
                local nyzulFloorProgress = player:getCharVar("NyzulClimbNumber") > 0 and 100 or player:getCharVar("Nyzul_RunicDiscProgress")
                local wsPoints = trade:getItem(0):getWeaponskillPoints()
                local requiredWsPoints = getRequiredWsPoints(nyzulFloorProgress)
                -- table located at https://ffxiclopedia.fandom.com/wiki/Unlocking_a_Myth_(Warrior)
                if wsPoints < (requiredWsPoints / 5) then
                    player:startEvent(10091)
                elseif wsPoints <= ((requiredWsPoints *4) / 5) then
                    player:startEvent(10092)
                elseif wsPoints < requiredWsPoints then
                    player:startEvent(10093)
                elseif wsPoints >= requiredWsPoints then
                    player:startEvent(10088, i)
                end
            end

            return
        end
    end
end

function onTrigger(player, npc)
    local mainJobId = player:getMainJob()
    local unlockingAMyth = player:getQuestStatus(JEUNO, getQuestId(mainJobId))
    local nyzulWeaponMain = isBaseNyzulWeapon(player:getEquipID(tpz.slot.MAIN))
    local nyzulWeaponRanged = isBaseNyzulWeapon(player:getEquipID(tpz.slot.RANGED))

    if unlockingAMyth == QUEST_AVAILABLE then
        if player:needToZone() and player:getCharVar("Upset_Zalsuhm") > 0 then
            player:startEvent(10090)
        else
            if player:getCharVar("Upset_Zalsuhm") > 0 then
                player:setCharVar("Upset_Zalsuhm", 0)
            end

            if nyzulWeaponMain or nyzulWeaponRanged then
                player:startEvent(10086, mainJobId)
            else
                player:startEvent(10085)
            end
        end
    elseif unlockingAMyth == QUEST_ACCEPTED then
        player:startEvent(10087)
    else
        player:startEvent(10089)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local questId = getQuestId(option)
    if csid == 10086 then
        if option == 53 then
            player:setCharVar("Upset_Zalsuhm", 1)
            player:needToZone(true)
        elseif option <= tpz.job.SCH then
            player:addQuest(JEUNO, questId)
        end
    elseif csid == 10088 and option <= tpz.job.SCH then
        local jobs =
        {
            [tpz.job.WAR] = tpz.ws_unlock.KINGS_JUSTICE,
            [tpz.job.MNK] = tpz.ws_unlock.ASCETICS_FURY,
            [tpz.job.WHM] = tpz.ws_unlock.MYSTIC_BOON,
            [tpz.job.BLM] = tpz.ws_unlock.VIDOHUNIR,
            [tpz.job.RDM] = tpz.ws_unlock.DEATH_BLOSSOM,
            [tpz.job.THF] = tpz.ws_unlock.MANDALIC_STAB,
            [tpz.job.PLD] = tpz.ws_unlock.ATONEMENT,
            [tpz.job.DRK] = tpz.ws_unlock.INSURGENCY,
            [tpz.job.BST] = tpz.ws_unlock.PRIMAL_REND,
            [tpz.job.BRD] = tpz.ws_unlock.MORDANT_RIME,
            [tpz.job.RNG] = tpz.ws_unlock.TRUEFLIGHT,
            [tpz.job.SAM] = tpz.ws_unlock.TACHI_RANA,
            [tpz.job.NIN] = tpz.ws_unlock.BLADE_KAMU,
            [tpz.job.DRG] = tpz.ws_unlock.DRAKESBANE,
            [tpz.job.SMN] = tpz.ws_unlock.GARLAND_OF_BLISS,
            [tpz.job.BLU] = tpz.ws_unlock.EXPIACION,
            [tpz.job.COR] = tpz.ws_unlock.LEADEN_SALUTE,
            [tpz.job.PUP] = tpz.ws_unlock.STRINGING_PUMMEL,
            [tpz.job.DNC] = tpz.ws_unlock.PYRRHIC_KLEOS,
            [tpz.job.SCH] = tpz.ws_unlock.OMNISCIENCE,
        }
        local skill = jobs[option]

        player:completeQuest(JEUNO, questId)
        player:messageSpecial(ID.text.MYTHIC_LEARNED, option)
        player:addLearnedWeaponskill(skill)
    end
end