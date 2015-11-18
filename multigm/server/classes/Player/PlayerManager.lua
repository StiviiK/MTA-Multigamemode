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
	client.m_ClientReady = true

	showChat(client, true)
	self:spawnPlayer(client)

	-- Send the inital Sync for the Player
	GamemodeManager.sendInitialSync(client)
end

function PlayerManager:spawnPlayer(player)
	player:spawn(SPAWN_DEFAULT_POSITION, SPAWN_DEFAULT_ROTATION, SPAWN_DEFAULT_SKIN, SPAWN_DEFAULT_INTERIOR)
	player:setFrozen(true)
	player:setCameraTarget(player)
end

-- Events
function PlayerManager:Event_ChangeLocale(locale)
	source:setLocale(LOCALE[locale])
	source:getAccount():getSession():update()
end

function PlayerManager:Event_UpdatePlayerSession()
	if ((getTickCount() - (source.m_LastSessionUpdate or 0)) >= 1000*60*5) or (source:getAccount():getType() >= ACCOUNTTYPE.Premium) then
		if source:getRank() >= RANK.User then
			source:getAccount():getSession():update()
			source:triggerEvent("successBox", source, _("Deine Session wurde erfolgreich geupdatet!", source))
			source.m_LastSessionUpdate = getTickCount()
		else
			source:triggerEvent("errorBox", source, _("Diese Funktion ist im Gast-Modus nicht verfügbar!", source))
		end
	else
		source:triggerEvent("errorBox", source, _("Du kannst deine Session nur alle 5 Minuten manuell updaten!", source))
	end
end
