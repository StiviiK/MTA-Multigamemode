PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	--self.m_WastedHook = Hook:new()
	self.m_ReadyPlayers = {}

	-- Register events
	addRemoteEvents{"onPlayerReady", "Player_changeLanguage", "Event_UpdatePlayerSession"}
  addEventHandler("onPlayerConnect", root, bind(PlayerManager.playerConnect, self))
  addEventHandler("onPlayerJoin", root, bind(PlayerManager.playerJoin, self))
	addEventHandler("onPlayerReady", root, bind(PlayerManager.playerReady, self))
	addEventHandler("Player_changeLanguage", root, bind(PlayerManager.Event_ChangeLocale, self))
	addEventHandler("Event_UpdatePlayerSession", root, bind(PlayerManager.Event_UpdatePlayerSession, self))

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
  enew(getPlayerFromName(name), Player)
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
	self:spawnPlayer(client)

	client:triggerEvent("versionReceive", client, core:getVersion())
end

function PlayerManager:spawnPlayer(player)
	player:spawn(SPAWN_DEFAULT_POSITION, SPAWN_DEFAULT_ROTATION, SPAWN_DEFAULT_SKIN, SPAWN_DEFAULT_INTERIOR)
	player:setFrozen(true)
end

-- Events
function PlayerManager:Event_ChangeLocale(locale)
	source:setLocale(LOCALE[locale])
	source:getAccount():getSession():update()
end

function PlayerManager:Event_UpdatePlayerSession()
	if source:getRank() >= RANK.Developer then
		source:getAccount():getSession():update()
		source:triggerEvent("successBox", source, _("Deine Session wurde erfolgreich geupdatet!", source))
	else
		source:triggerEvent("errorBox", source, _("Zugriff verweigert.", source))
	end
end
