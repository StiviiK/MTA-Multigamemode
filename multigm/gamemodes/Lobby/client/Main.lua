function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))

  -- Create Gamemode Peds
  GamemodePed:new(0, Vector3(1713.793, -1655.604, 20.222), Vector3(0, 0, -90), 12, 18, self)
  GamemodePed:new(0, Vector3(1713.793, -1663.490, 20.222), Vector3(0, 0, -90), 12, 18, self)
  GamemodePed:new(0, Vector3(1729.256, -1647.652, 20.222), Vector3(0, 0, 90), 12, 18, self)
  GamemodePed:new(0, Vector3(1729.256, -1655.511, 20.222), Vector3(0, 0, 90), 12, 18, self)
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
