-----------------------------------
-- func: setbag
-- desc: Sets the players bag size
-----------------------------------
require("scripts/globals/status");
require("scripts/globals/quests")

local bagparam =
{
    { bagsize = 30, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_I    },
    { bagsize = 35, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_II   },
    { bagsize = 40, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_III  },
    { bagsize = 45, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_IV   },
    { bagsize = 50, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_V    },
    { bagsize = 55, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VI   },
    { bagsize = 60, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VII  },
    { bagsize = 65, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII },
    { bagsize = 70, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_IX   },
    { bagsize = 75, questid = tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_X    },
    { bagsize = 80, questid = nil                                       },
}


cmdprops =
{
    permission = 3,
    parameters = "i"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!bagsize <30-80 and multiple of 5>")
end

function onTrigger(player, bagsize)
    -- Validate bag amount
    if bagsize == nil then
        player:PrintToPlayer("Please add a bag size.")
        return
    elseif bagsize < 30 or bagsize > 80 or (bagsize % 5 ~= 0) then
        player:PrintToPlayer("Invalid bag size.")
        return
    end

    local currentBagSize = player:getContainerSize(tpz.inv.INVENTORY)
    local adjustment = bagsize - currentBagSize

    for i = 1, 10 do
        if bagsize > bagparam[i].bagsize then
            player:completeQuest(tpz.quest.log_id.JEUNO, bagparam[i].questid)
        else
            player:delQuest(tpz.quest.log_id.JEUNO, bagparam[i].questid)
        end
    end

    -- Inform player and set bag size
    player:PrintToPlayer(string.format("Old Bag Size: %u", currentBagSize))
    player:PrintToPlayer(string.format("New Bag Size: %u", bagsize))
    player:changeContainerSize(tpz.inv.INVENTORY, adjustment)
    player:changeContainerSize(tpz.inv.MOGSATCHEL, adjustment)
end
