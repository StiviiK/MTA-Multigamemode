GamemodeManager = inherit(Singleton)
GamemodeManager.Map = {}

function GamemodeManager:constructor()
	local Gamemodes = {
		self:addRef(Lobby:new("Lobby", "This is the Lobby."):setId(1));
		self:addRef(CopsnRobbers:new("Cops'n'Robbers", "Cops'n'Robbers Gamemode"):setId(2));
		self:addRef(RenegadeSquad:new("Renegade Squad", "RenegadeSquad Gamemode"):setId(3));
		self:addRef(SuperS:new("Super Sweeper", "SuperSweeper Gamemode"):setId(4));
		self:addRef(CS:new("Counter-Strike", "Counter-Strike Gamemode"):setId(5));
		self:addRef(BloodMoney:new("Blood Money", "BloodMoney Gamemode"):setId(6));
	}

	for k, v in ipairs(Gamemodes) do
		if v.onGamemodesLoaded then
			v:onGamemodesLoaded(#Gamemodes)
		end
	end
	self.m_LoadedGamemodes = #Gamemodes

	-- Gamemode Sync
	self.m_SyncPulse = TimedPulse:new(500)
	self.m_SyncPulse:registerHandler(self.updateSync)


	-- Manager Events
	RPC:registerFunc("Event_DisableGamemode", bind(GamemodeManager.Event_DisableGamemode, self))
	RPC:registerFunc("Event_JoinGamemode", bind(GamemodeManager.Event_JoinGamemode, self))
	RPC:registerFunc("Event_RespawnGamemodePed", bind(GamemodeManager.Event_RespawnGamemodePed, self))
	RPC:registerFunc("Event_DeleteGamemodePed", bind(GamemodeManager.Event_DeleteGamemodePed, self))

	--[[
	addRemoteEvents{"Event_DisableGamemode", "Event_JoinGamemode", "Event_RespawnGamemodePed", "Event_DeleteGamemodePed"}
	addEventHandler("Event_DisableGamemode",    root, bind(GamemodeManager.Event_DisableGamemode   , self))
	addEventHandler("Event_JoinGamemode", 	  root, bind(GamemodeManager.Event_JoinGamemode      , self))
	addEventHandler("Event_RespawnGamemodePed", root, bind(GamemodeManager.Event_RespawnGamemodePed, self))
	addEventHandler("Event_DeleteGamemodePed",  root, bind(GamemodeManager.Event_DeleteGamemodePed , self))
	--]]
	end

function GamemodeManager:destructor()
	for i, v in pairs(GamemodeManager.Map) do
		delete(v)
	end
end

function GamemodeManager.getFromId(Id)
	return GamemodeManager.Map[Id]
end

function GamemodeManager:addRef(ref)
	GamemodeManager.Map[ref:getId()] = ref
	return ref
end

function GamemodeManager:removeRef(ref)
	GamemodeManager.Map[ref:getId()] = nil
end

function GamemodeManager:Event_DisableGamemode(client, Id)
	if client:getRank() >= RANK.Developer then
		outputDebug(("[GamemodeManager] %s forced Gamemode destruction! [Id: %d]"):format(client:getAccount():getName(), Id))

		delete(self.getFromId(Id))
		client:triggerEvent("successBox", client, _("Aktion erfolgreich ausgeführt!", client))
	else
		client:triggerEvent("errorBox", client, _("Zugriff verweigert.", client))
	end
end

function GamemodeManager:Event_JoinGamemode(client, Id, fLobby)
	if client:getGamemode() == self.getFromId(Id) then
		client:fadeCamera(true, 0.5)
		if fLobby ~= true then
		client:triggerEvent("errorBox", client, _("Du bist bereits in diesem Gamemode!", client))
		end
		return
	end

	if client:getGamemode() then
		client:getGamemode():removePlayer(client)
	end

	client:fadeCamera(true, 0.75)
	self.getFromId(Id):addPlayer(client)
	if fLobby ~= true then
		client:triggerEvent("successBox", source, _("Du bist dem Gamemode erfolgreich beigetreten!", client))
	end
end

function GamemodeManager.updateSync()
	local SyncData = {}
	for i, gamemode in pairs(GamemodeManager.Map) do
		SyncData[gamemode:getId()] = {}
		for k, v in pairs(gamemode.m_SyncInfoUpdate) do
			SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
		end
		gamemode.m_SyncInfoUpdate = {}
	end

	if table.size(SyncData, true) > 0 then
		for i, v in pairs(getElementsByType("player")) do -- Todo: Improve?
		if v:isClientReady() then
			--v:triggerEvent("UpdateGamemodeSync", v, SyncData)
			RPC:callCustom("UpdateGamemodeSync", v, SyncData)
		end
		end
	end
end

function GamemodeManager.sendInitialSync(player)
	local SyncData = {}
	for i, gamemode in pairs(GamemodeManager.Map) do
		SyncData[gamemode:getId()] = {}
		for k, v in pairs(gamemode.m_SyncInfo) do
		SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
		end
	end

	if table.size(SyncData) ~= GamemodeManager.Map then
		if player then
		if player:isClientReady() then
			--player:triggerEvent("UpdateGamemodeSync", player, SyncData)
			RPC:callCustom("UpdateGamemodeSync", player, SyncData)
		end
		end
	end
end

function GamemodeManager:Event_RespawnGamemodePed(client, Id)
	if client:getRank() >= RANK.Administrator then
		outputDebug(("[GamemodeManager] %s respawned GamemodePed! [Id: %d]"):format(client:getAccount():getName(), Id))

		triggerClientEvent("RespawnGamemodePed", client, Id)
		client:triggerEvent("successBox", client, _("Aktion erfolgreich ausgeführt!", client))
	else
		client:triggerEvent("errorBox", client, _("Zugriff verweigert.", client))
	end
end

function GamemodeManager:Event_DeleteGamemodePed(client, Id)
	if client:getRank() >= RANK.Administrator then
		outputDebug(("[GamemodeManager] %s deleted GamemodePed! [Id: %d]"):format(client:getAccount():getName(), Id))

		triggerClientEvent("DeleteGamemodePed", client, Id)
		client:triggerEvent("successBox", client, _("Aktion erfolgreich ausgeführt!", client))
	else
		client:triggerEvent("errorBox", client, _("Zugriff verweigert.", client))
	end
end
