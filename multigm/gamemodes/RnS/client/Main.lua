function RenegadeSquad:constructor()
  addRemoteEvents{"onRNSStartDownload"}
  addEventHandler("onRNSStartDownload", root, bind(RenegadeSquad.onDownloadStart, self))
end

function RenegadeSquad:destructor()
end

function RenegadeSquad:onPlayerJoin()
end

function RenegadeSquad:onPlayerLeft()
end

function RenegadeSquad:onDownloadStart()
  Provider:getSingleton():requestFile(RNS_DOWNLOAD_FILE, bind(RenegadeSquad.onDownloadFinish, self))
end

function RenegadeSquad:onDownloadFinish()
  triggerServerEvent("onRNSDownloadFinished", localPlayer)

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Change HelpBar Text
  HelpBar:getSingleton():setText(HelpTexts.Gamemodes.RnS, false, self:getColor())
end
