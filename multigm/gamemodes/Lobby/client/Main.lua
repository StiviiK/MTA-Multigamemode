function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))

  -- Create Gamemode Peds
  -- Gamemode Peds
  GamemodePed:new(0, Vector3(0, 0, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, self)
  GamemodePed:new(134, Vector3(0, 3, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, self)
  GamemodePed:new(12, Vector3(3, 3, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, self)
  GamemodePed:new(126, Vector3(3, 0, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, self)
end

function Lobby:destructor()
  --outputDebug("Lobby:destructor")
end

function Lobby:onPlayerJoin()
  source:setCollidableWith(root, false)
end

function Lobby:onPlayerLeft()
  source:setCollidableWith(root, true)
end

function Lobby:onDownloadStart()
  Provider:getSingleton():requestFile(LOBBY_DOWNLOAD_FILE, bind(Lobby.onDownloadFinish, self))
end

function Lobby:onDownloadFinish()
  triggerServerEvent("onLobbyDownloadFinished", localPlayer)
end
