-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Player.lua
-- *  PURPOSE:     Player class
-- *  NOTE: This overwrites the base MTA-Player class!
-- *
-- ****************************************************************************
Player = inherit(MTAElement)
registerElementClass("player", Player)

function Player:virtual_constructor()
	self.m_PublicSync = {}
	self.m_PrivateSync = {}
	self.m_PrivateSyncChangeHandler = {}
	self.m_PublicSyncChangeHandler = {}

	self.m_JoinTime = getTickCount()
	self.m_Gamemode = nil
end

function Player:getPublicSync(key)
	return self.m_PublicSync[key]
end

function Player:getPrivateSync(key)
	return self.m_PrivateSync[key]
end

function Player:onUpdateSync(private, public)
	for k, v in pairs(private or {}) do
		self.m_PrivateSync[k] = v

		local f = self.m_PrivateSyncChangeHandler[k]
		if f then f(v) end
	end
	for k, v in pairs(public or {}) do
		self.m_PublicSync[k] = v

		local f = self.m_PublicSyncChangeHandler[k]
		if f then f(v) end
	end
end

function Player:setPrivateSyncChangeHandler(key, handler)
	self.m_PrivateSyncChangeHandler[key] = handler
end

function Player:setPublicSyncChangeHandler(key, handler)
	self.m_PublicSyncChangeHandler[key] = handler
end


addRemoteEvents{"PlayerPrivateSync", "PlayerPublicSync"}
addEventHandler("PlayerPrivateSync", root, function(private) source:onUpdateSync(private, nil) end)
addEventHandler("PlayerPublicSync", root, function(public) source:onUpdateSync(nil, public) end)

-- Short setters
function Player:setGamemode(gamemode) self.m_Gamemode = gamemode end

-- Short getters
function Player:getId() return self:getPrivateSync("Id") end
function Player:isLoggedIn() return self:getId() ~= nil end
function Player:getRank() return self:getPrivateSync("Rank") end
function Player:getLocale() return self:getPublicSync("Locale") end
function Player:getPlayTime() return math.floor(self:getPrivateSync("LastPlayTime") + (getTickCount() - self.m_JoinTime)/1000/60) end
function Player:getGamemode() return self.m_Gamemode end
