Core = inherit(Object)

function Core:constructor ()
  outputDebug("Initializing core...")

  -- Small hack to get the global core immediately
	core = self

  -- Important Data
  self.ms_StartTime = getRealTime().timestamp
  self.ms_StartTick = getTickCount()


  if USE_REMOTE_API then
    -- Instantiate API
    self.ms_API = API:new()
    self:setAPIStatements()

    -- Connect to the API(-Server)
    self.ms_API:call(self.ms_API:getStatement("onConnect"))

    delete(self.ms_API)
  end

  if DEBUG then
    Debugging:new()
  end

  -- Establish database connection
	sql = MySQL:new(MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PW, MYSQL_DB, "")
	sql:setPrefix("multigm")

	-- Instantiate classes
  Provider:new()
  PlayerManager:new()
  GamemodeManager:new()

  -- instantiate all players
  for k, v in pairs(getElementsByType("player")) do
    enew(v, Player)
	end

  -- Generate Download-Package
  local gamemodes = {
    ["main"] = "";
    ["lobby"] = "gamemodes/Lobby/";
  }
  for name, path in pairs(gamemodes) do
    outputDebug(("Generating Package for %s..."):format(name:upperFirst()))

    local files = {}
    local xml = xmlLoadFile(("%smeta.xml"):format(path))
    for k, v in pairs(xmlNodeGetChildren(xml)) do
      if xmlNodeGetName(v) == "transferfile" then
        files[#files+1] = xmlNodeGetAttribute(v, "src")
      end
    end

    -- Create Data Package and offer it (On-Demand)
    local fileName = ("%s%s.data"):format(path, name)
    Package.save(fileName, files)
    Provider:getSingleton():offerFile(fileName, PROVIDER_ON_DEMAND)
  end
end

function Core:destructor ()
  if DEBUG then
    delete(Debugging:getSingleton())
  end

  delete(GamemodeManager:getSingleton())
  delete(PlayerManager:getSingleton())
  delete(sql)
end

function Core:onInternalError(error)
  for i, v in pairs(getElementsByType("player")) do
    v:kick("System - Core", ("An Internal Error occured! Error Id: %s"):format(error))
  end

  stopResource(getThisResource())
end

function Core:setAPIStatements()
  if (not self.ms_API) or (not instanceof(self.ms_API, API, true)) then return end
  local api = self.ms_API

  -- Set APIStatements
  api:setStatement("onConnect", "parameter", {"method=connect"})
  api:setStatement("onConnect", "callback", function () outputDebug("Connected") end)
  api:setStatement("onDestruct", "parameter", {"method=disconnect"})
  api:setStatement("onDestruct", "callback", function () outputDebug("Disconnected") end)
end
