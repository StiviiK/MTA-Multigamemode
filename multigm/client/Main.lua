Main = {}

function Main.resourceStart()
	-- Instantiate Core
	core = Core:new()
end
addEventHandler("onClientResourceStart", resourceRoot, Main.resourceStart, true, "high+99999")

function Main.resourceStop()
	-- Delete the core
	delete(core)
end
addEventHandler("onClientResourceStop", resourceRoot, Main.resourceStop, true, "low-999999")