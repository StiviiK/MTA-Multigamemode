function CS:constructor()
--Handler--
  addRemoteEvents{"onCSStartDownload"}
  addEventHandler("onCSStartDownload", root, bind(CS.onDownloadStart, self))

  -- CS_GamemodeManager:new()
  
  -- FirstPerson:new()
  SubGamemodeManager:new(self)
  

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS:destructor()
  -- delete(CS_GamemodeManager:getSingleton())
  
  -- delete(CS_Lobby_Menu:getSingleton())
end

function CS:onPlayerJoin()
-- showChat(false)
-- FirstPerson:getSingleton():CreateFirstPerson()
end





function CS:onPlayerLeft()
-- showChat(true)
-- FirstPerson:getSingleton():RemoveFirstPerson()
-- delete(CS_Lobby_Menu:getSingleton())

end

function CS:onDownloadStart()
  Provider:getSingleton():requestFile(CS_DOWNLOAD_FILE, bind(CS.onDownloadFinish, self))
end

function CS:onDownloadFinish()
  triggerServerEvent("onCSDownloadFinished", localPlayer)
  -- CS_Lobby_Menu:new(self)
  -- localPlayer:setPosition(
  -- CS_MapLoader:getSingleton().MapSettings["T_Spawn"][1]["position"]
  -- )
end
