Gamemode = inherit(Object)

-- pure virtual functions
Gamemode.constructor = pure_virtual
Gamemode.destructor = pure_virtual
Gamemode.onPlayerJoin = pure_virtual
Gamemode.onPlayerLeft = pure_virtual

function Gamemode:virtual_constructor(name, desc)
  self.m_Name = name or ""
  self.m_Description = desc or ""
  self.m_Players = {}
  self.m_Dimension = math.random(1, 3555) -- TODO: Add dimension manager
end

function Gamemode:virtual_destructor()
  GamemodeManager:getSingleton():removeRef(self)

  for _, v in pairs(self.m_Players) do
    self:removePlayer(v)
  end
end

function Gamemode:setId(Id)
  self.m_Id = Id
end

function Gamemode:getId()
  return self.m_Id
end

function Gamemode:addPlayer(player)
  if (type(self:getSetting("DownloadPath")) == "string") and (not fileExists(self:getSetting("DownloadPath"))) then
    player:onInternalError(("%s-#%s"):format(self:getName(), DOWNLOAD_ERROR_UNKOWN_FILE))
    return
  end

  table.insert(self.m_Players, player)
  self:onPlayerJoin(player)

  player:setGamemode(self)
  player:setDimension(self.m_Dimension)

  -- trigger to the client
  player:triggerEvent("onPlayerGamemodeJoin", player, self:getId())

  -- update the Session
  player:getSession():update()
end

function Gamemode:removePlayer(player)
  local idx = table.find(self.m_Players, player)
  if idx then
    self.m_Players[idx] = nil
    self:onPlayerLeft(player)

    if not isElement(player) then return end
    player:setGamemode(nil)
    player:setDimension(PRIVATE_DIMENSION_SERVER)
    player:spawn(SPAWN_DEFAULT_POSITION, SPAWN_DEFAULT_ROTATION, player:getSkin(), SPAWN_DEFAULT_INTERIOR)
    player:setFrozen(true)

    -- trigger to the client
    player:triggerEvent("onPlayerGamemodeLeft", player, self:getId())

    -- update the Session
    player:getSession():update()
  end
end

function Gamemode:sendMessage(msg, ...)
  for _, player in pairs(self.m_Players) do
    outputChatBox(msg, player, ...)
  end
end

-- Short getters
function Gamemode:getName() return self.m_Name end
function Gamemode:getDimension() return self.m_Dimension end
