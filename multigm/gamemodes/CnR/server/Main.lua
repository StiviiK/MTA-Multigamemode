function CopsnRobbers:constructor()
  addRemoteEvents{"onCNRDownloadFinished"}
  addEventHandler("onCNRDownloadFinished", root, bind(CopsnRobbers.onDownloadComplete, self))

  -- Maps
  MapManager:getSingleton():loadMap(self, "gamemodes/Lobby/files/maps/Test.map"):load(MAP_LOADING_FAST)
end

function CopsnRobbers:destructor()
end

function CopsnRobbers:onPlayerJoin(player)
  player:triggerEvent("onCNRStartDownload", player)
end

function CopsnRobbers:onPlayerLeft(player)
end

function CopsnRobbers:onDownloadComplete()
  -- spawn the player
  client:setPosition(4190.506, -1631.823, 636.10)
end
