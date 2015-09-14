-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Core.lua
-- *  PURPOSE:     Core class
-- *
-- ****************************************************************************
Core = inherit(Object)

function Core:constructor()
	-- Small hack to get the global core immediately
	core = self

	-- Instantiate the localPlayer instance right now
	enew(localPlayer, LocalPlayer)

	-- Instantiate TranslationManager
	TranslationManager:new()


  if DEBUG then
		Debugging:new()
	end

	Cursor = GUICursor:new()
	Provider:new()
	GamemodePedManager:new()
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
	delete(Cursor)
	delete(Provider:getSingleton())
	delete(GamemodeManager:getSingleton())
	delete(GamemodePedManager:getSingleton())
end
