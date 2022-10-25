-- Scripts called during server startup or shutdown

require("scripts/globals/events/exp_fest")

function onServerInitialize()
    --print("onServerInitialize: called")
end

function onServerReady()
    --print("onServerReady: called")
	ExpFestInitialize()
end

function onServerCleanup()
    --print("onServerCleanup: called")
end
