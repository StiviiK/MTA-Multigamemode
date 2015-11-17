function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Create important stuff when the Dimension is available (e.g. GamemodePeds)
	self:addSyncChangeHandler("Dimension", function (dim)
    if table.size(self.m_GamemodePeds) == 0 then
  		GamemodePed:new(math.random(280, 286), Vector3(1713.793, -1655.604, 20.222), Vector3(0, 0, -90), dim, self:getSetting("Spawn").Interior, GamemodeManager.getFromId(2), GamemodeManager.getFromId(2):getColor())
  		GamemodePed:new(math.random(163, 166), Vector3(1713.793, -1663.490, 20.222), Vector3(0, 0, -90), dim, self:getSetting("Spawn").Interior, GamemodeManager.getFromId(3), GamemodeManager.getFromId(3):getColor())
  		GamemodePed:new(0, Vector3(1729.256, -1647.652, 20.222), Vector3(0, 0, 90), dim, self:getSetting("Spawn").Interior, self)
  		GamemodePed:new(0, Vector3(1729.256, -1655.511, 20.222), Vector3(0, 0, 90), dim, self:getSetting("Spawn").Interior, self)
    end
	end)
end

function Lobby:destructor()
end

function Lobby:onPlayerJoin()
  for i, v in pairs(getElementsByType("player")) do
    v:setCollidableWith(localPlayer, false)
  end
end

function Lobby:onPlayerLeft()
  for i, v in pairs(getElementsByType("player")) do
    v:setCollidableWith(localPlayer, true)
  end
end

function Lobby:onDownloadStart()
  Provider:getSingleton():requestFile(LOBBY_DOWNLOAD_FILE, bind(Lobby.onDownloadFinish, self))
end

function Lobby:onDownloadFinish()
  triggerServerEvent("onLobbyDownloadFinished", localPlayer)
end
