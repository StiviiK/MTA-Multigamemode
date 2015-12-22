function BloodMoney:constructor()
  -- Add events
  addRemoteEvents{"onBLMDownloadFinished"}
  addEventHandler("onBLMDownloadFinished", root, bind(BloodMoney.onDownloadComplete, self))

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

function BloodMoney:destructor()
end

function BloodMoney:onPlayerJoin(player)
  player:triggerEvent("onBLMStartDownload", player)
end

function BloodMoney:onPlayerLeft(player)
end

function BloodMoney:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
end
