function Lobby:constructor()
  addRemoteEvents{"onLobbyDownloadFinished"}
  addEventHandler("onLobbyDownloadFinished", root, bind(Lobby.onDownloadComplete, self))

  -- Maps
  MapManager:getSingleton():loadMap(self, "gamemodes/Lobby/files/maps/Test.map"):load(MAP_LOADING_FAST)
end

function Lobby:destructor()
end

function Lobby:onPlayerJoin(player)
  player:triggerEvent("onLobbyStartDownload", player)
end

function Lobby:onPlayerLeft(player)
end

function Lobby:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
end
