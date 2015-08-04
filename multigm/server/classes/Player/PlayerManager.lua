PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	--self.m_WastedHook = Hook:new()
	self.m_ReadyPlayers = {}

	-- Register events
	addRemoteEvents{"onPlayerReady"}
  addEventHandler("onPlayerConnect", root, bind(PlayerManager.playerConnect, self))
  addEventHandler("onPlayerJoin", root, bind(PlayerManager.playerJoin, self))
	addEventHandler("onPlayerReady", root, bind(PlayerManager.playerReady, self))

	self.m_SyncPulse = TimedPulse:new(500)
	self.m_SyncPulse:registerHandler(bind(PlayerManager.updatePlayerSync, self))
end

function PlayerManager:destructor()
	for k, v in ipairs(getElementsByType("player")) do
		delete(v)
	end
end

function PlayerManager:updatePlayerSync()
	for k, v in pairs(getElementsByType("player")) do
		v:updateSync()
	end
end

function PlayerManager:playerConnect(name)
	local player = getPlayerFromName(name)
  enew(player, Player)
end

function PlayerManager:playerJoin()
  source:setName(getRandomUniqueNick())

	-- While download
	source:fadeCamera(true)
	source:setHudComponentVisible("all", false)
	showChat(source, false)
end

function PlayerManager:playerReady()
	showChat(client, true)
	outputChatBox("Download finished...", client)
end