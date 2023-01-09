-----------------------------------------------------------------------
-- func: enablefest
-- desc: enables a "fest" and sets begin/end timestamps
-----------------------------------------------------------------------
require("scripts/globals/events/fests")

cmdprops =
{
    permission = 2,
    parameters = ""
};

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getfest")
end

function onTrigger(player)
    local now = os.time()

    local festType = GetServerVariable("[Fest]Type")
    local FEST_START = GetServerVariable("[Fest]Start")
    local FEST_END = GetServerVariable("[Fest]End")
    -- validate fest type
    if festsData[festType] == nil or festsData[festType].name == nil then
        error(player, string.format("No fest currently defined. Use !enablefest to schedule one!"))
        return
    end

    player:PrintToPlayer(string.format("%s Fest starts at %s and ends at %s (server time)", festsData[festType].name, os.date("%Y/%m/%d %H:%M:%S", startTime), os.date("%Y/%m/%d %H:%M:%S", endTime)))
end
