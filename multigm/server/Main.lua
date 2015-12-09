Main = {}

function Main.resourceStart()
	-- Save start time
	Main.coreStartTime = getRealTime().timestamp
	local start = getTickCount()

	-- Instantiate Core
	core = Core:new()

	outputDebug("Initialized core (Took: "..getTickCount() - start.."ms)")
end
addEventHandler("onResourceStart", resourceRoot, Main.resourceStart, true, "high+99999")

function Main.resourceStop()
	delete(core)
end
addEventHandler("onResourceStop", resourceRoot, Main.resourceStop, true, "low-99999")
