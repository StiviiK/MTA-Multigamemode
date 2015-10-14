function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Create Gamemode Peds
  GamemodePed:new(0, Vector3(1713.793, -1663.490, 20.222), Vector3(0, 0, -90), PRIVATE_DIMENSION_CLIENT, self:getSetting("Spawn").Interior, self)
  GamemodePed:new(0, Vector3(1729.256, -1647.652, 20.222), Vector3(0, 0, 90), PRIVATE_DIMENSION_CLIENT, self:getSetting("Spawn").Interior, self)
  GamemodePed:new(0, Vector3(1729.256, -1655.511, 20.222), Vector3(0, 0, 90), PRIVATE_DIMENSION_CLIENT, self:getSetting("Spawn").Interior, self)

  -- Update Gamemode Ped Dimension
  self:addSyncChangeHandler("Dimension", function (dim)
    for i, v in pairs(self.m_GamemodePeds) do
      v.m_Dimension = dim
      v.m_Ped:setDimension(dim)
    end
  end)
end

function Lobby:destructor()
  --outputDebug("Lobby:destructor")
end

function Lobby:onPlayerJoin()
end

function Lobby:onPlayerLeft()
end

function Lobby:onDownloadStart()
  Provider:getSingleton():requestFile(LOBBY_DOWNLOAD_FILE, bind(Lobby.onDownloadFinish, self))
end

function Lobby:onDownloadFinish()
  triggerServerEvent("onLobbyDownloadFinished", localPlayer)
end
