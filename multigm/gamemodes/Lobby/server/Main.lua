function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyDownloadFinished"}
  addEventHandler("onLobbyDownloadFinished", root, bind(Lobby.onDownloadComplete, self))
end

function Lobby:destructor()
  --outputDebug("Lobby:destructor")
end

function Lobby:onPlayerJoin(player)
  player:triggerEvent("onLobbyStartDownload", player)
end

function Lobby:onPlayerLeft(player)
end

function Lobby:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:spawn(spawn.Position, spawn.Rotation, client:getSkin(), spawn.Interior)
end
