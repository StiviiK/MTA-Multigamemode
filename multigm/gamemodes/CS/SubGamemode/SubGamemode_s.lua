﻿SubGamemode = inherit(Object)
inherit(GamemodeElement, SubGamemode)

-- pure virtual functions
SubGamemode.constructor = pure_virtual
SubGamemode.destructor = pure_virtual
SubGamemode.onPlayerJoin = pure_virtual
SubGamemode.onPlayerLeft = pure_virtual

function SubGamemode:new(...)
  local inst = new(self, ...)

  self.m_Instance = inst
  return inst
end

function SubGamemode:virtual_constructor(name, desc, maxPlayers)
  self.m_Name = name or ""
  self.m_Description = desc or ""
  self.m_Players = {}
  self.m_Dimension = DimensionManager:getSingleton():getFreeDimension()
  self.m_SyncInfo = {}
  self.m_SyncInfoUpdate = {}
  self.m_MaxPlayers = maxPlayers or -1

  -- Set important SyncInfo
  self:setSyncInfo("Name", self:getName())
  self:setSyncInfo("Description", self:getDescription())
  self:setSyncInfo("Dimension", self:getDimension())
  self:setSyncInfo("CurrPlayers", #self.m_Players)
  self:setSyncInfo("MaxPlayers", self.m_MaxPlayers)
end

function SubGamemode:virtual_destructor()
  SubGamemodeManager:getSingleton():removeRef(self)
  DimensionManager:getSingleton():freeDimension(self:getDimension())

  for _, v in pairs(self.m_Players) do
    self:removePlayer(v)
  end

  triggerClientEvent("onSubGamemodeDestruct", root, self:getId())
end

function SubGamemode:setId(Id)
  self.m_Id = Id

  return self
end

function SubGamemode:addPlayer(player)
  if self.m_MaxPlayers == -1 or #self.m_Players < self.m_MaxPlayers then
    if (type(self:getSetting("DownloadPath")) == "string") and (not fileExists(self:getSetting("DownloadPath"))) then
      player:onInternalError(DOWNLOAD_ERROR_UNKOWN_FILE)
      return
    end

    table.insert(self.m_Players, player)
    self:onPlayerJoin(player)
    self:setSyncInfo("CurrPlayers", #self.m_Players)

    player:setSubGamemode(self)
    player:setDimension(self.m_Dimension)
    player:setFrozen(false)
    player:setParent(self:getRoot())

    -- trigger to the client
    player:triggerEvent("onPlayerSubGamemodeJoin", player, self:getId())

    -- update the Session
    player:getSession():update()
  else
    SubGamemodeManager:getSingleton().getFromId(1):addPlayer(source)
    source:triggerEvent("errorBox", source, _("Dieser SubGamemode ist bereits voll!", source))
  end
end

function SubGamemode:removePlayer(player)
  local idx = table.find(self.m_Players, player)
  if idx then
    self.m_Players[idx] = nil
    self:onPlayerLeft(player)
    self:setSyncInfo("CurrPlayers", #self.m_Players)

    if not isElement(player) then return end
    player:setSubGamemode(nil)
    player:spawn(SPAWN_DEFAULT_POSITION, SPAWN_DEFAULT_ROTATION, player:getSkin(), SPAWN_DEFAULT_INTERIOR)
    player:setDimension(PRIVATE_DIMENSION_SERVER)
    player:setFrozen(true)
    player:setParent(getRootElement())

    -- trigger to the client
    player:triggerEvent("onPlayerSubGamemodeLeft", player, self:getId())

    -- update the Session
    player:getSession():update()
  end
end

function SubGamemode:sendMessage(msg, ...)
  for _, player in pairs(self.m_Players) do
    outputChatBox(msg, player, ...)
  end
end

function SubGamemode:setSyncInfo(key, value)
  if self.m_SyncInfo[key] ~= value then
		self.m_SyncInfo[key] = value
		self.m_SyncInfoUpdate[key] = true
	end
end

-- Short getters
function SubGamemode:getId() return self.m_Id end
function SubGamemode:getName() return self.m_Name end
function SubGamemode:getDescription() return self.m_Description end
function SubGamemode:getDimension() return self.m_Dimension end
function SubGamemode:getInstance() return self.m_Instance end
