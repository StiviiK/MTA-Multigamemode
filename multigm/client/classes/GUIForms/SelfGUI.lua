SelfGUI = inherit(GUIForm)
inherit(Singleton, SelfGUI)

function SelfGUI:constructor()
  GUIForm.constructor(self, screenWidth/2-300, screenHeight/2-230, 600, 460)

  -- TODO: Find a better location
  localPlayer:setPublicSyncChangeHandler("Locale", function ()
    if SelfGUI:getSingleton():isVisible() then
      delete(SelfGUI:getSingleton())
      SelfGUI:getSingleton():show()
    else
      delete(SelfGUI:getSingleton())
      SelfGUI:getSingleton():hide()
    end
  end)

  -- Tabpanel
  self.m_TabPanel = GUITabPanel:new(0, 0, self.m_Width, self.m_Height, self)
  self.m_TabPanel.onTabChanged = bind(self.TabPanel_TabChanged, self)
  self.m_CloseButton = GUILabel:new(self.m_Width-28, 0, 28, 28, "[x]", self):setFont(VRPFont(35))
  self.m_CloseButton.onLeftClick = function() self:close() end
  self.m_CloseButton.onHover = function () self.m_CloseButton:setColor(Color.Orange) end
  self.m_CloseButton.onUnhover = function () self.m_CloseButton:setColor(Color.White) end

  -- General
  local tabGeneral = self.m_TabPanel:addTab(_"Allgemein")
  self.m_TabGeneral = tabGeneral
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.265, self.m_Height*0.12, _"Allgemein", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.8, self.m_Height*0.07, _"Account", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.19, self.m_Width*0.25, self.m_Height*0.06, _"Name:", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.25, self.m_Width*0.25, self.m_Height*0.06, _"Spielzeit:", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.31, self.m_Width*0.25, self.m_Height*0.06, _"Rang:", tabGeneral)
  GUILabel:new(self.m_Width*0.3, self.m_Height*0.19, self.m_Width*0.4, self.m_Height*0.06, getPlayerName(localPlayer), tabGeneral)
  self.m_PlayTimeLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.25, self.m_Width*0.4, self.m_Height*0.06, _("%s Stunde(n) %s Minute(n)", 0, 0), tabGeneral)
  self.m_RankLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.31, self.m_Width*0.4, self.m_Height*0.06, _(RANK[localPlayer:getRank()]), tabGeneral)
  localPlayer:setPrivateSyncChangeHandler("Rank", function (rank) self.m_RankLabel:setText(_(RANK[rank])) end)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.38, self.m_Width*0.8, self.m_Height*0.07, _"Gamemode", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.45, self.m_Width*0.25, self.m_Height*0.06, _"Name:", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.51, self.m_Width*0.25, self.m_Height*0.06, _"Spieler:", tabGeneral)
  self.m_GamemodeNameLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.45, self.m_Width*0.4, self.m_Height*0.06, localPlayer:getGamemode() and localPlayer:getGamemode():getName() or "Unkown", tabGeneral)
  self.m_GamemodePlayersLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.51, self.m_Width*0.4, self.m_Height*0.06, "0 / -1", tabGeneral)

  -- Statistics
  local tabStatistics = self.m_TabPanel:addTab(_"Statistiken")
  self.m_TabStatistic = tabStatistics
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.27, self.m_Height*0.12, _"Statistiken", tabStatistics)

  -- Session
  local tabSession = self.m_TabPanel:addTab(_"Sitzung")
  self.m_TabSession = tabSession
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.2, self.m_Height*0.12, _"Sitzung", tabSession)
  self.m_TokenLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.672, self.m_Height*0.06, "", tabSession)
  self.m_TokenCopyLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.125, self.m_Height*0.06, _"(kopieren)", tabSession):setColor(Color.Orange)
  self.m_TokenCopyLabel.onLeftClick = function()
    if setClipboard(localPlayer:getPrivateSync("SessionToken")) then
      InfoBox:new(_"Token wurde erfolgreich kopiert!")
    else
      ErrorBox:new(_"Token konnte nicht kopiert werden!")
    end
  end
  self.m_TokenCopyLabel.onHover = function () self.m_TokenCopyLabel:setColor(Color.White) end
  self.m_TokenCopyLabel.onUnhover = function () self.m_TokenCopyLabel:setColor(Color.Orange) end
  self.m_SessionGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.2, self.m_Width*0.525, self.m_Height*0.71, tabSession)
  self.m_SessionGrid:addColumn(_"Index", 0.5)
  self.m_SessionGrid:addColumn(_"Wert", 0.5)
  localPlayer:setPrivateSyncChangeHandler("SessionInfo", bind(self.Session_updateInfo, self))
  self.m_DisableSessionButton = VRPButton:new(self.m_Width*0.6, self.m_Height*0.84, self.m_Width*0.35, self.m_Height*0.07, _"Session deaktivieren", true, tabSession)
  self.m_DisableSessionButton:setEnabled(false)
  self.m_UpdateSessionButton = VRPButton:new(self.m_Width*0.6, self.m_Height*0.75, self.m_Width*0.35, self.m_Height*0.07, _"Session updaten", true, tabSession)
  self.m_UpdateSessionButton.lastUpdate = 0
  self.m_UpdateSessionButton.onLeftClick = function ()
    if (getTickCount() - self.m_UpdateSessionButton.lastUpdate) >= 1000*60*5 then
      if triggerServerEvent("Event_UpdatePlayerSession", localPlayer) then
        self.m_UpdateSessionButton.lastUpdate = getTickCount()
      else
        ErrorBox:new(_"Es ist ein interner Fehler aufgetreten!")
      end
    else
      ErrorBox:new(_"Du kannst deine Session nur alle 5 Minuten manuell updaten!")
    end
  end
  GUILabel:new(self.m_Width*0.6, self.m_Height*0.2, self.m_Width*0.35, self.m_Height*0.525, LOREM_IPSUM:sub(1, 296), tabSession)
    :setFont(VRPFont((self.m_Height*0.525)/10))

  -- Points
  local tabPoints = self.m_TabPanel:addTab(_"Punkte")
  self.m_TabPoints = tabPoints
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.185, self.m_Height*0.12, _"Punkte", tabPoints)


  -- Settings
  local tabSettings = self.m_TabPanel:addTab(_"Einstellungen")
  self.m_TabSettings = tabSettings
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.35, self.m_Height*0.12, _"Einstellungen", tabSettings)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.8, self.m_Height*0.07, _"Sprache", tabSettings)
  self.m_LocaleChange = GUIChanger:new(self.m_Width*0.02, self.m_Height*0.19, self.m_Width*0.35, self.m_Height*0.07, tabSettings)
  for i = 1, #LANG, 1 do
    	self.m_LocaleChange:addItem(_(LANG[i]))
  end
  self.m_LocaleChange:setIndex(LOCALE[localPlayer:getLocale()])
  self.m_LocaleChangeButton = GUIButton:new(self.m_Width*0.02, self.m_Height*0.27, self.m_Width*0.35, self.m_Height*0.055, _"Speichern", tabSettings)
  self.m_LocaleChangeButton.onLeftClick = function () local _, index = self.m_LocaleChange:getIndex() triggerServerEvent("Player_changeLanguage", localPlayer, index) end

end

function SelfGUI:onShow()
  -- Updaten Session Info
  local token = localPlayer:getPrivateSync("SessionToken")
  self.m_TokenLabel:setText(_("Token: %s", token))
  self.m_TokenCopyLabel:setPosition(self.m_Width*0.02 + dxGetTextWidth(_("Token: %s", token), self.m_TokenLabel:getFontSize(), self.m_TokenLabel:getFont()) + 10, self.m_Height*0.12)

  -- PlayTime
  local hours, minutes = math.floor(localPlayer:getPlayTime()/60), (localPlayer:getPlayTime() - math.floor(localPlayer:getPlayTime()/60)*60)
  self.m_PlayTimeLabel:setText(_("%s Stunde(n) %s Minute(n)", hours, minutes))
end

function SelfGUI:TabPanel_TabChanged(tabId)
  if tabId == self.m_TabSession.TabIndex then
    self:Session_updateInfo()
  end
end

function SelfGUI:Session_updateInfo()
  self.m_SessionGrid:clear()
  for i, v in pairs(localPlayer:getPrivateSync("SessionInfo")) do
    if type(v) ~= "table" then
      self.m_SessionGrid:addItem(i:upperFirst(), tostring(v))
    else
      for i2, v in pairs(v) do
        self.m_SessionGrid:addItem(i:upperFirst().."."..i2, tostring(v))
      end
    end
  end
end
