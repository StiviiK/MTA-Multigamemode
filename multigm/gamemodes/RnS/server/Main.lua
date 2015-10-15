function RenegadeSquad:constructor()
  -- Add events
  addRemoteEvents{"onRNSDownloadFinished"}
  addEventHandler("onRNSDownloadFinished", root, bind(RenegadeSquad.onDownloadComplete, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Load Maps
  self.m_Maps = {
    --MapManager:getSingleton():loadMap(self, "");
  }

  -- Create Maps
  for i, v in pairs(self.m_Maps) do
    v:load()
  end
end

function RenegadeSquad:destructor()
end

function RenegadeSquad:onPlayerJoin(player)
  player:triggerEvent("onRNSStartDownload", player)
end

function RenegadeSquad:onPlayerLeft(player)
end

function RenegadeSquad:onDownloadComplete()
  -- spawn the player
  local spawn = self:getSetting("Spawn")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
end
