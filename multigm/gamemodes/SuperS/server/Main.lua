function SuperS:constructor()
  -- Add events
  addRemoteEvents{"onSuperSDownloadFinished"}
  addEventHandler("onSuperSDownloadFinished", root, bind(SuperS.onDownloadComplete, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Reigster Maps
  MapManager:getSingleton():registerMap("gamemodes/SuperS/res/maps/Lobby.map")
  MapManager:getSingleton():registerMap("gamemodes/SuperS/res/maps/Plants.map")
  MapManager:getSingleton():registerMap("gamemodes/SuperS/res/maps/Baustelle.map")

  -- Load Maps
  self.m_Maps = {
    MapManager:getSingleton():loadMap(self, "gamemodes/SuperS/res/maps/Lobby.map");
    MapManager:getSingleton():loadMap(self, "gamemodes/SuperS/res/maps/Plants.map");
    MapManager:getSingleton():loadMap(self, "gamemodes/SuperS/res/maps/Baustelle.map");
  }

  -- Create Maps
  for i, v in pairs(self.m_Maps) do
    v:load()
  end

  -- Instantiate classes
  SuperS.SweeperManager:new()
end

function SuperS:destructor()
  if self.m_Border then
    delete(self.m_Border)
  end

  -- Delete SweeperManager at last postion
  delete(SuperS.SweeperManager:getSingleton())
end

function SuperS:onGamemodesLoaded()
  -- Instantiate Lobby
  SuperS.Lobby:new()

  -- Instantiate extra classes
  SuperS.Sweeper.ItemManager:new()
  self.m_Border = SuperS.Border:new(unpack(self:get("BorderData")))
end

function SuperS:onPlayerJoin(player)
  player:triggerEvent("onSuperSStartDownload", player)

  -- Sync SweeperData
  SuperS.SweeperManager:getSingleton():syncClientData(player)

  -- Disable some controls
  player:toggleControl("fire", false)
  player:toggleControl("jump", false)
  player:toggleControl("aim_weapon", false)
end

function SuperS:onPlayerLeft(player)
  if player.m_SweeperId then
    delete(SuperS.SweeperManager:getSingleton().getFromId(player.m_SweeperId))
    player.m_SweeperId = nil
  end
end

function SuperS:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
end
