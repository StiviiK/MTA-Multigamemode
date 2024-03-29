Core = inherit(Object)

function Core:constructor ()
	outputDebug("Initializing core...")

	-- Small hack to get the global core immediately
	core = self
	-- Important Data
	self.ms_StartTime = getRealTime().timestamp
	self.ms_StartTick = getTickCount()

	-- Load config
	Config:new()

	if USE_REMOTE_API then
		-- Instantiate API
		self.ms_API = API:new()
		self:setAPIStatements()

		-- Connect to the API(-Server)
		self.ms_API:call(self.ms_API:getStatement("onConnect"))
	end

	if DEBUG then
		Debugging:new()
	end

	-- Establish database connection
	sql = MySQL:new(Config.get('mysql')['main']['host'], Config.get('mysql')['main']['port'], Config.get('mysql')['main']['username'], Config.get('mysql')['main']['password'], Config.get('mysql')['main']['database'], Config.get('mysql')['main']['socket'])
	sql:setPrefix(Config.get('mysql')['main']['prefix'])
	vrp = MySQL:new(Config.get('mysql')['vrp']['host'], Config.get('mysql')['vrp']['port'], Config.get('mysql')['vrp']['username'], Config.get('mysql')['vrp']['password'], Config.get('mysql')['vrp']['database'], Config.get('mysql')['vrp']['socket'])
	vrp:setPrefix(Config.get('mysql')['vrp']['prefix'])
	board = MySQL:new(Config.get('mysql')['board']['host'], Config.get('mysql')['vrp']['port'], Config.get('mysql')['board']['username'], Config.get('mysql')['board']['password'], Config.get('mysql')['board']['database'], Config.get('mysql')['board']['socket'])
	board:setPrefix(Config.get('mysql')['board']['prefix'])

	-- Instantiate TranslationManager
	TranslationManager:new()

	-- Register Maps
	MapManager:new()
	--MapManager:getSingleton():registerMap("gamemodes/Lobby/res/maps/Test.map")
	MapManager:getSingleton():registerMap("gamemodes/CnR/res/maps/LSPolice.map")

	-- Instantiate classes
	RPC = RPC:new()
	Performance:new()
	Provider:new()
	PlayerManager:new()
	GamemodeManager:new()
	DimensionManager:new()

	-- instantiate all players
	for k, v in pairs(getElementsByType("player")) do
		enew(v, Player)
	end

	-- Generate Download-Package
	local gamemodes = {
		{"Main", "", "vmg.data"};
		{"Lobby", "gamemodes/Lobby/", "lobby.data"};
		{"Cops'n'Robbers", "gamemodes/CnR/", "cnr.data"};
		{"Renegade Squad", "gamemodes/RnS/", "rns.data"};
		{"Super Sweeper", "gamemodes/SuperS/", "supers.data"};
		{"Counter-Strike", "gamemodes/CS/", "CS.data"};
		{"Blood Money", "gamemodes/BloodMoney/", "blm.data"};
	}

	for _, v in ipairs(gamemodes) do
		outputDebug(("Generating Package for %s..."):format(v[1]))

		local files = {}
		local xml = xmlLoadFile(("%smeta.xml"):format(v[2]))
		for k, v in pairs(xmlNodeGetChildren(xml)) do
			if xmlNodeGetName(v) == "transferfile" then
				files[#files+1] = xmlNodeGetAttribute(v, "src")
			end
		end

		-- Create Data Package and offer it (On-Demand)
		local fileName = ("%s%s"):format(v[2], v[3])
		Package.save(fileName, files)
		Provider:getSingleton():offerFile(fileName, PROVIDER_ON_DEMAND)
	end
end

function Core:destructor ()
	if DEBUG then
		delete(Debugging:getSingleton())
	end

	delete(GamemodeManager:getSingleton())
	delete(MapManager:getSingleton())
	delete(PlayerManager:getSingleton())
	delete(RPC)

	-- Delete this at last position
	delete(sql)

	if self.ms_API then
		delete(self.ms_API)
	end
end

function Core:onInternalError(error)
	for i, v in pairs(getElementsByType("player")) do
		v:kick("System - Core", ("Internal Error occured! Hash: %s"):format(error))
	end

	stopResource(getThisResource())
end

function Core:getStartTime()
	return Main.coreStartTime
end

function Core:logError(RayID, errHash, debugInfo, player)
	sql:queryExec("INSERT INTO ??_errlog (sRayID, lRayID, Type, Timestamp, AccountId, ErrHash, ErrSource) VALUES (?, ?, ?, NOW(), ?, ?, ?);", sql:getPrefix(), RayID:sub(1,8), RayID, 1, player:getId(), errHash, toJSON(debugInfo))
end

function Core:setAPIStatements()
	if (not self.ms_API) or (not instanceof(self.ms_API, API, true)) then return end

	-- Set APIStatements
	self.ms_API:setStatement("onConnect", "parameter", {"method=connect"})
	self.ms_API:setStatement("onConnect", "callback",
		function (returnJSON, errno)
			if errno == 0 then
				local result = fromJSON(returnJSON)
				if result.status then
					outputDebug("[API] Connected succesfully!")
         			--outputDebug(("[API] Using Token: %s"):format(result.result))

					self.ms_API.m_SecurityToken = result.result
				else
					outputDebug(("[API] Failure. Server returned: %s"):format(result.message))
				end
			else
				outputDebug(("AN INTERNAL API ERROR OCCURED! [Id: %s]"):format(tostring(errno)))
				delete(self.ms_API)
			end
		end
	)

	self.ms_API:setStatement("onDestruct", "parameter", {"method=disconnect"})
	self.ms_API:setStatement("onDestruct", "callback",
		function ()
			outputDebug("Disconnected")
		end
	)
end
