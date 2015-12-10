function SuperS:constructor()
  -- Add events
  addRemoteEvents{"onSuperSDownloadFinished"}
  addEventHandler("onSuperSDownloadFinished", root, bind(SuperS.onDownloadComplete, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Load Maps
  self.m_Maps = {
    --MapManager:getSingleton():loadMap(self, "gamemodes/RnS/res/maps/SurvivalIsland/Map.map");
  }

  -- Create Maps
  for i, v in pairs(self.m_Maps) do
    --v:load()
  end
end

function SuperS:destructor()
end

function SuperS:onPlayerJoin(player)
  player:triggerEvent("onSuperSStartDownload", player)
end

function SuperS:onPlayerLeft(player)
end

function SuperS:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
end
