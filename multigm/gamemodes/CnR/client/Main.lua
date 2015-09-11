function CopsnRobbers:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onCNRStartDownload"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))
end

function CopsnRobbers:destructor()
  --outputDebug("Lobby:destructor")
end

function CopsnRobbers:onGamemodesLoaded(numLoadedGamemodes)
  -- Create Gamemode Ped (in Lobby)
  GamemodePed:new(0, Vector3(1713.793, -1655.604, 20.222), Vector3(0, 0, -90), 12, GamemodeManager.getFromId(1):getSetting("Spawn").Interior, self)
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
