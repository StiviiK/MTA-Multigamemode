function BloodMoney:constructor()
  addRemoteEvents{"onBLMStartDownload"}
  addEventHandler("onBLMStartDownload", root, bind(BloodMoney.onDownloadStart, self))

  -- Add an password
  self.m_Password = "blm"

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function BloodMoney:destructor()
end

function BloodMoney:onPlayerJoin()
  -- Change HelpBar Text
  HelpBar:getSingleton():setText(HelpTexts.Gamemodes.BLM, false, self:getColor())
end

function BloodMoney:onPlayerLeft()
end

function BloodMoney:onDownloadStart()
  --Provider:getSingleton():requestFile(BLM_DOWNLOAD_FILE, bind(BloodMoney.onDownloadFinish, self))
  Gamemode.checkPassword(self, function () Provider:getSingleton():requestFile(BLM_DOWNLOAD_FILE, bind(BloodMoney.onDownloadFinish, self)) end)
end

function BloodMoney:onDownloadFinish()
  triggerServerEvent("onBLMDownloadFinished", localPlayer)
end
