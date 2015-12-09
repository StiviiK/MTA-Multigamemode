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

	-- Instantiate ConfigManager
	self.m_Config = ConfigXML:new("config.xml")
	if self:get("Account", "PrivateKey", false) ~= "mta" then -- TODO: Change this block later
		self:set("Account", "PrivateKey", "mta")
	end

	-- Instantiate TranslationManager
	TranslationManager:new()

	-- Instantiate classes
  if DEBUG then
		Debugging:new()
	end

	Performance:new()
	Version:new()
	Cursor = GUICursor:new()
	Provider:new()
	GamemodePedManager:new()
	GamemodeManager:new()

	-- Request main.data
	Provider:getSingleton():requestFile("vmg.data", bind(Core.ready, self))
end

function Core:ready()
	-- Tell the server that we're ready to accept additional data
	triggerServerEvent("onPlayerReady", localPlayer)
end

function Core:afterLogin()
	-- Instantiate classes
	HelpBar:new()

	-- Create bindings
	SelfGUI:new():close()
	addCommandHandler("self", function () SelfGUI:getSingleton():open() end)
	bindKey("F2", "down", function() SelfGUI:getSingleton():toggle() end)

	bindKey("F3", "down", function()
	  if FastLobby:isInstantiated() then
	    delete(FastLobby:getSingleton())
	  else
	    FastLobby:new()
	  end
	end)

	-- Set default text @ HelpBar
	HelpBar:getSingleton():setText(HelpTexts.General.Main)
end

function Core:destructor()
	delete(Cursor)
	delete(Provider:getSingleton())
	delete(GamemodeManager:getSingleton())
	delete(GamemodePedManager:getSingleton())

	-- Delete Config at last position
	delete(self:getConfig())
end

function Core:getConfig()
	return self.m_Config
end

function Core:get(...)
	return self:getConfig():get(...)
end

function Core:set(...)
	return self:getConfig():set(...)
end
