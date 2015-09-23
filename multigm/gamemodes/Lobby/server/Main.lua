function Lobby:constructor()
  -- Add events
  addRemoteEvents{"onLobbyDownloadFinished"}
  addEventHandler("onLobbyDownloadFinished", root, bind(Lobby.onDownloadComplete, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Create GameRooms
  self:addRoom("Lobby", -1)
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

  local Id = self:findFreeRoom()
  if Id ~= -1 then
    self:addToRoom(Id, client)
  else
    client:onInternalError(("%s-#%s"):format(self:getName(), RUNTIME_ERROR_NO_ROOM))
  end
end

function Lobby:findFreeRoom()
  local Id = 0
  while true do
    Id = Id + 1

    if Id > #self.m_Rooms then
      Id = -1
      break;
    end

    if self.m_Rooms[Id] then
      if self.m_Rooms[Id].maxplayers == -1 then
        break;
      else
        if #self.m_Rooms[Id].players < self.m_Rooms[Id].maxplayers then
          break;
        end
      end
    end
  end

  return Id
end