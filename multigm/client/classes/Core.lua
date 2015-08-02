Core = inherit(Object)

function Core:constructor()
	-- Small hack to get the global core immediately
	core = self

	-- Instantiate the localPlayer instance right now
	enew(localPlayer, LocalPlayer)

  if DEBUG then
		Debugging:new()
	end

	Provider:new()
	GamemodeManager:new()

	-- Reqeust main.data
	Provider:getSingleton():requestFile("main.data", bind(Core.ready, self))
end

function Core:ready()
	-- Tell the server that we're ready to accept additional data
	triggerServerEvent("onPlayerReady", localPlayer)
end

function Core:afterLogin()
end

function Core:destructor()
end
