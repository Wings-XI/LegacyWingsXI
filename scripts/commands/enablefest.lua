-----------------------------------------------------------------------
-- func: enablefest
-- desc: enables a "fest" and sets begin/end timestamps
-----------------------------------------------------------------------
require("scripts/globals/events/fests")

cmdprops =
{
    permission = 4,
    parameters = "iii"
};

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!enablefest {festType: 0,1,2...} {startTime} {endTime}: use https://www.unixtimestamp.com/ to generate UTC timestamps")
end

function onTrigger(player, festType, startTime, endTime)
    local now = os.time()

    -- validate fest type
    if festsData[festType] == nil or festsData[festType].name == nil then
        local listOfTypes = ""
        for x, y in pairs(festsData) do
            listOfTypes = listOfTypes .. x .. " - " .. y.name .. ", "
        end
        error(player, string.format("Invalid fest type. Choices: %s", listOfTypes))
        return
    end

    -- validate begin/end
    if not (startTime ~= nil and endTime ~= nil and now < startTime and startTime < endTime) then
        error(player, string.format("Invalid begin/end time for %s Fest, current os.time: %u, %s", festsData[festType].name, now, os.date("%Y/%m/%d %H:%M:%S", now)))
        return
    end

    local maxFestHours = 72
    if not (festsData[festType] == nil or festsData[festType].maxLengthHours == nil) then
        maxFestHours = festsData[festType].maxLengthHours
    end

    local maxFestLength = maxFestHours * 60 * 60
    if endTime - startTime > maxFestLength then
        error(player, string.format("%s Fest length greater than %u hours. Please shorten endTime", festsData[festType].name, maxFestHours))
        return
    end

    -- validate if fest is currently active
    if GetServerVariable("[Fest]Begin") < now and GetServerVariable("[Fest]End") > now then
        error(player, string.format("%s Fest is currently active, please wait until %s to schedule another", festsData[GetServerVariable("[Fest]Type")].name, os.date("%Y/%m/%d %H:%M:%S", GetServerVariable("[Fest]End"))))
        return
    end

    -- set server variables
    SetServerVariable("[Fest]Type", festType)
    SetServerVariable("[Fest]Start", startTime)
    SetServerVariable("[Fest]End", endTime)
    player:PrintToPlayer(string.format("%s Fest starts at %s and ends at %s (server time)", festsData[festType].name, os.date("%Y/%m/%d %H:%M:%S", startTime), os.date("%Y/%m/%d %H:%M:%S", endTime)))
end
