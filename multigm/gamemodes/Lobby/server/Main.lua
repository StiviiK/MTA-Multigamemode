function Lobby:constructor()
  addRemoteEvents{"onLobbyDownloadFinished"}
  addEventHandler("onLobbyDownloadFinished", root, bind(Lobby.onDownloadComplete, self))

  -- Create GameRooms
  self:addRoom("Lobby #1", 15)
  self:addRoom("Lobby #2", 15)
  self:addRoom("Lobby #3", 15)
  self:addRoom("Lobby #4", 15)
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
