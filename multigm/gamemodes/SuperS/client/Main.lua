function SuperS:constructor()
  addRemoteEvents{"onSuperSStartDownload"}
  addEventHandler("onSuperSStartDownload", root, bind(SuperS.onDownloadStart, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Add a password
  self.m_Password = "Kuchengeschmack"

  -- Instantiate classes
  self.SweeperManager:new()

  -- Update Lobby dim (when it is ready)
  self:addSyncChangeHandler("Dimension", function (dim)
    SuperS.Lobby:getSingleton():updateDimension(dim)
  end)
end

function SuperS:destructor()
  -- Delete SweeperManager at last postion
  delete(SuperS.SweeperManager:getSingleton())
end

function SuperS:onGamemodesLoaded()
  -- Instantiate Lobby
  SuperS.Lobby:new()
end

function SuperS:onPlayerJoin()
  -- Change HelpBar Text
  HelpBar:getSingleton():setText(HelpTexts.Gamemodes.SuperS, false, self:getColor())
end

function SuperS:onPlayerLeft()
  -- Destroy Lobby Shader
  delete(self.m_LobbyShader)
end

function SuperS:onDownloadStart()
  --Provider:getSingleton():requestFile(RNS_DOWNLOAD_FILE, bind(SuperS.onDownloadFinish, self))
  Gamemode.checkPassword(self, function () Provider:getSingleton():requestFile(RNS_DOWNLOAD_FILE, bind(SuperS.onDownloadFinish, self)) end)
end

function SuperS:onDownloadFinish()
  triggerServerEvent("onSuperSDownloadFinished", localPlayer)

  -- Create Lobby Shader
  self.m_LobbyShader = SuperS.Shader:new("gamemodes/SuperS/res/shader/swap.fx")
  self.m_LobbyShader:setTexture("gamemodes/SuperS/res/images/sign_tresspass2.png")
  self.m_LobbyShader:applyShaderValue("swap")
  self.m_LobbyShader:applyToWorldTexture("sign_tresspass2")
end
