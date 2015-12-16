function Lobby:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onLobbyStartDownload"}
  addEventHandler("onLobbyStartDownload", root, bind(Lobby.onDownloadStart, self))

  -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Reset GamemodePed dimension
	self:addSyncChangeHandler("Dimension", function (dim)
    for _, gamemode in pairs(GamemodeManager.Map) do
      for _, ped in pairs(gamemode.m_GamemodePeds) do
        ped:setDimension(dim)
      end
    end
	end)
end

function Lobby:destructor()
end

function Lobby:onGamemodesLoaded(numLoadedGamemodes)
  for i = 2, numLoadedGamemodes, 1 do
    GamemodePed:new(table.random(self:get("GamemodePedSkins")[i-1]), self:get("GamemodePedPositions")[i-1], self:get("GamemodePedRotations")[i-1], 0, self:getSetting("Spawn").Interior, GamemodeManager.getFromId(i))
  end
end

function Lobby:onPlayerJoin()
  for i, v in pairs(getElementsByType("player")) do
    v:setCollidableWith(localPlayer, false)
  end
  toggleControl("fire", false)
  toggleControl("jump", false)
  toggleControl("aim_weapon", false)

  if localPlayer:getLocale() then
    -- Change HelpBar Text
    HelpBar:getSingleton():setText(HelpTexts.General.Main, false, self:getColor())
  end
end

function Lobby:onPlayerLeft()
  for i, v in pairs(getElementsByType("player")) do
    v:setCollidableWith(localPlayer, true)
  end
  toggleControl("fire", true)
  toggleControl("jump", true)
  toggleControl("aim_weapon", true)
end

function Lobby:onDownloadStart()
  Provider:getSingleton():requestFile(LOBBY_DOWNLOAD_FILE, bind(Lobby.onDownloadFinish, self))
end

function Lobby:onDownloadFinish()
  triggerServerEvent("onLobbyDownloadFinished", localPlayer)
end
