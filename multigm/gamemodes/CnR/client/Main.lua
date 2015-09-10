function CopsnRobbers:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onCNRStartDownload"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))

  -- Create Gamemode Peds (in Lobby)
  GamemodePed:new(0, Vector3(1713.793, -1655.604, 20.222), Vector3(0, 0, -90), 12, 18, self)
  GamemodePed:new(0, Vector3(1713.793, -1663.490, 20.222), Vector3(0, 0, -90), 12, 18, self)
  GamemodePed:new(0, Vector3(1729.256, -1647.652, 20.222), Vector3(0, 0, 90), 12, 18, self)
  GamemodePed:new(0, Vector3(1729.256, -1655.511, 20.222), Vector3(0, 0, 90), 12, 18, self)
end

function CopsnRobbers:destructor()
  --outputDebug("Lobby:destructor")
end

function CopsnRobbers:onPlayerJoin()
end

function CopsnRobbers:onPlayerLeft()
end

function CopsnRobbers:onDownloadStart()
  Provider:getSingleton():requestFile(CNR_DOWNLOAD_FILE, bind(Lobby.onDownloadFinish, self))
end

function CopsnRobbers:onDownloadFinish()
  triggerServerEvent("onCNRDownloadFinished", localPlayer)
end
