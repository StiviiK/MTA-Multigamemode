function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))
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
