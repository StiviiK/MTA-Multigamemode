function SuperS:constructor()
  addRemoteEvents{"onSuperSStartDownload"}
  addEventHandler("onSuperSStartDownload", root, bind(SuperS.onDownloadStart, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function SuperS:destructor()
end

function SuperS:onPlayerJoin()
  -- Change HelpBar Text
  HelpBar:getSingleton():setText(HelpTexts.Gamemodes.RnS)
end

function SuperS:onPlayerLeft()
end

function SuperS:onDownloadStart()
  Provider:getSingleton():requestFile(RNS_DOWNLOAD_FILE, bind(SuperS.onDownloadFinish, self))
end

function SuperS:onDownloadFinish()
  triggerServerEvent("onSuperSDownloadFinished", localPlayer)
end
