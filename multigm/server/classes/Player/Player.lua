Player = inherit(MTAElement)
inherit(DatabasePlayer, Player)
registerElementClass("player", Player)

function Player:constructor()
  self:setDimension(PRIVATE_DIMENSION_SERVER)
	self:setFrozen(true)

  self.m_PrivateSync = {}
	self.m_PrivateSyncUpdate = {}
  self.m_SyncListener = {}
	self.m_PublicSync = {}
	self.m_PublicSyncUpdate = {}
  self.m_JoinTime = getTickCount()
end

function Player:destructor()
  if self:isLoggedIn() then
    if not self:isGuest() then
      self:save()
    end

    delete(self.m_Account)
  end
end

function Player:loadCharacter()
	if not self:getAccount() then return false end -- player is not loggedin

  -- Reset Name
	self:setName(self:getAccount():getName())

  -- load stuff from DB
  if not self:isGuest() then
    self:load()
  else
    self:loadGuest()
  end

  -- Load element related stuff
  self:setHealth(self.m_Health)
  self:setArmor(self.m_Armor)
  self.m_Health, self.m_Armor = nil

  -- Sync important stuff
  self:setPrivateSync("Id", self:getId())
  self:setPrivateSync("joinTime", self:getJoinTime())
  self:setPrivateSync("LastPlayTime", self.m_LastPlayTime)

  -- unfreeze the player
  self:setFrozen(false)

  -- add the player to the lobby
  GamemodeManager:getSingleton().getFromId(1):addPlayer(self)
end

function Player:onInternalError(error)
  self:kick("System - Player", _("Ein interner Fehler is aufgetreten! Error Id: %s", self, error))
end

function Player:setPrivateSync(key, value)
	if self.m_PrivateSync[key] ~= value then
		self.m_PrivateSync[key] = value
		self.m_PrivateSyncUpdate[key] = key
	end
end

function Player:setPublicSync(key, value)
	if self.m_PublicSync[key] ~= value then
		self.m_PublicSync[key] = value
		self.m_PublicSyncUpdate[key] = true
	end
end

function Player:getPublicSync(key)
	return self.m_PublicSync[key]
end

function Player:getPrivateSync(key)
	return self.m_PrivateSync[key]
end

function Player:addSyncListener(player)
	self.m_SyncListener[player] = player
end

function Player:removeSyncListener(player)
	self.m_SyncListener[player] = nil
end

function Player:updateSync()
	local publicSync = {}
	for k, v in pairs(self.m_PublicSyncUpdate) do
		publicSync[k] = self.m_PublicSync[k]
	end
	self.m_PublicSyncUpdate = {}

	local privateSync = {}
	for k, v in pairs(self.m_PrivateSyncUpdate) do
		privateSync[k] = self.m_PrivateSync[k]
	end
	self.m_PrivateSyncUpdate = {}

	if table.size(privateSync) ~= 0 then
		triggerClientEvent(self, "PlayerPrivateSync", self, privateSync)
		for k, v in pairs(self.m_SyncListener) do
			triggerClientEvent(v, "PlayerPrivateSync", self, privateSync)
		end
	end

	if table.size(publicSync) ~= 0 then
		triggerClientEvent(root, "PlayerPublicSync", self, publicSync)
	end
end

function Player:sendInitialSync()
	triggerClientEvent(self, "PlayerPrivateSync", self, self.m_PrivateSync)

	for k, player in pairs(getElementsByType("player")) do
		triggerClientEvent(self, "PlayerPublicSync", player, player.m_PublicSync)
	end
end

function Player:triggerLatentEvent(...)
  return triggerLatentClientEvent(self, ...)
end

-- Short getters
function Player:isActive() return true end
function Player:getAccount() return self.m_Account end
function Player:isLoggedIn() return self.m_Id ~= -1	end
function Player:getGamemode() return self.m_Gamemode end
function Player:getJoinTime() return self.m_JoinTime end
function Player:getSession() return (self:getAccount() and self:getAccount():getSession()) end

-- Short setters
function Player:setGamemode(instance) self.m_Gamemode = instance end
