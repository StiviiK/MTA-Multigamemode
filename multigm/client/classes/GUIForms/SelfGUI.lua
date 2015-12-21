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
    if HelpBar:isInstantiated() then
      if HelpBar:getSingleton():isVisible() then
        delete(HelpBar:getSingleton())
        HelpBar:getSingleton():open(HelpTexts.General.Main)
      else
        delete(HelpBar:getSingleton())
        HelpBar:getSingleton():setText(HelpTexts.General.Main)
      end
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
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.25, self.m_Width*0.25, self.m_Height*0.06, _"Account-Typ:", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.3125, self.m_Width*0.25, self.m_Height*0.06, _"Spielzeit:", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.373, self.m_Width*0.25, self.m_Height*0.06, _"Rang:", tabGeneral)
  GUILabel:new(self.m_Width*0.3, self.m_Height*0.19, self.m_Width*0.4, self.m_Height*0.06, getPlayerName(localPlayer), tabGeneral)
  self.m_AccountTypeLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.25, self.m_Width*0.4, self.m_Height*0.06, "", tabGeneral)
  localPlayer:setPrivateSyncChangeHandler("AccountType", function (type) self:adjustGeneralTab(type, false, false) end)
  self.m_AccountTypeHelpLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.25, self.m_Width*0.03, self.m_Height*0.06, _"(?)", tabGeneral):setColor(Color.Orange)
  self.m_AccountTypeHelpLabel.onHover = function () self.m_AccountTypeHelpLabel:setColor(Color.White) end
  self.m_AccountTypeHelpLabel.onUnhover = function () self.m_AccountTypeHelpLabel:setColor(Color.Orange) end
  self.m_AccountTypeHelpLabel.onLeftClick = function () HelpBar:getSingleton():open(HelpTexts.Game.AccountType, true) end
  self.m_PlayTimeLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.3125, self.m_Width*0.4, self.m_Height*0.06, _("%s Stunde(n) %s Minute(n)", 0, 0), tabGeneral)
  self.m_RankLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.373, self.m_Width*0.4, self.m_Height*0.06, "", tabGeneral)
  localPlayer:setPrivateSyncChangeHandler("Rank", function (rank) self:adjustGeneralTab(false, rank, false) end)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.45, self.m_Width*0.8, self.m_Height*0.07, _"Game-Stats", tabGeneral)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.525, self.m_Width*0.25, self.m_Height*0.06, _"Job-Points (JP):", tabGeneral) -- TODO: Maybe another name?
  self.m_JobPointsLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.525, self.m_Width*0.4, self.m_Height*0.06, localPlayer:getPublicSync("JobPoints"), tabGeneral)
  self.m_JobPointsHelpLabel = GUILabel:new(self.m_Width*0.3, self.m_Height*0.525, self.m_Width*0.03, self.m_Height*0.06, _"(?)", tabGeneral):setColor(Color.Orange)
  self.m_JobPointsHelpLabel.onHover = function () self.m_JobPointsHelpLabel:setColor(Color.White) end
  self.m_JobPointsHelpLabel.onUnhover = function () self.m_JobPointsHelpLabel:setColor(Color.Orange) end
  self.m_JobPointsHelpLabel.onLeftClick = function () HelpBar:getSingleton():open(HelpTexts.Game.JobPoints, true) end
  localPlayer:setPublicSyncChangeHandler("JobPoints", function (jp) self:adjustGeneralTab(false, false, jp) end)

  -- Account
  local tabPoints = self.m_TabPanel:addTab(_"Shop")
  self.m_TabPoints = tabPoints
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.225, self.m_Height*0.12, _"Shop", tabPoints)

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
  localPlayer:setPrivateSyncChangeHandler("SessionInfo", bind(self.adjustSessionTab, self))
  GUILabel:new(self.m_Width*0.6, self.m_Height*0.2, self.m_Width*0.35, self.m_Height*0.525, HelpTexts.SelfGUI.TabSession.text --[[LOREM_IPSUM:sub(1, 296)]], tabSession)
    :setFont(VRPFont((self.m_Height*0.525)/10))
  self.m_UpdateSessionButton = VRPButton:new(self.m_Width*0.6, self.m_Height*0.75, self.m_Width*0.35, self.m_Height*0.07, _"Session updaten", true, tabSession)
  self.m_UpdateSessionButton.lastUpdate = 0
  self.m_UpdateSessionButton.onLeftClick = function ()
    if triggerServerEvent("Event_UpdatePlayerSession", localPlayer) then
      self.m_UpdateSessionButton.lastUpdate = getTickCount()
    else
      ErrorBox:new(_"Es ist ein interner Fehler aufgetreten!")
    end
  end
  self.m_DisableSessionButton = VRPButton:new(self.m_Width*0.6, self.m_Height*0.84, self.m_Width*0.35, self.m_Height*0.07, _"Session deaktivieren", true, tabSession)
  self.m_DisableSessionButton:setEnabled(false)

  -- Group
  local tabGroup = self.m_TabPanel:addTab(_"Gruppe")
  self.m_TabGroups = tabGroup
  self.m_GroupsTitleLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.225, self.m_Height*0.12, _"Gruppe", tabGroup)

  -- Settings
  local tabSettings = self.m_TabPanel:addTab(_"Einstellungen")
  self.m_TabSettings = tabSettings
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.35, self.m_Height*0.12, _"Einstellungen", tabSettings)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.145, self.m_Height*0.07, _"Sprache", tabSettings)
  self.m_LocaleChange = GUIChanger:new(self.m_Width*0.02, self.m_Height*0.19, self.m_Width*0.35, self.m_Height*0.07, tabSettings)
  for i = 1, #LANG, 1 do
    	self.m_LocaleChange:addItem(_(LANG[i]))
  end
  self.m_LocaleChange:setIndex(LOCALE[localPlayer:getLocale()])
  self.m_LocaleChangeButton = GUIButton:new(self.m_Width*0.02, self.m_Height*0.27, self.m_Width*0.35, self.m_Height*0.055, _"Speichern", tabSettings)
  self.m_LocaleChangeButton.onLeftClick = function () local _, index = self.m_LocaleChange:getIndex() triggerServerEvent("Player_changeLanguage", localPlayer, index) end

  GUILabel:new(self.m_Width*0.02, self.m_Height*0.34, self.m_Width*0.8, self.m_Height*0.07, _"Cursor Modus", tabSettings)
	self.m_CursorChange = GUIChanger:new(self.m_Width*0.02, self.m_Height*0.41, self.m_Width*0.35, self.m_Height*0.07, tabSettings)
	self.m_CursorChange:addItem("Normal")
	self.m_CursorChange:addItem("Instant")
	self.m_CursorChange.onChange = function(text, index)
		core:getConfig():set("HUD", "CursorMode", index - 1)
		Cursor:setCursorMode(toboolean(index - 1))
	end
	self.m_CursorChange:setIndex(core:get("HUD", "CursorMode", 0) + 1, true)
end

function SelfGUI:onShow()
  -- Update the Tabs
  self:TabPanel_TabChanged(self.m_TabGeneral.TabIndex)
  self:TabPanel_TabChanged(self.m_TabSession.TabIndex)
  self:TabPanel_TabChanged(self.m_TabGroups.TabIndex)
end

function SelfGUI:TabPanel_TabChanged(tabId)
  if tabId == self.m_TabGeneral.TabIndex then
    self:adjustGeneralTab(localPlayer:getAccountType(), localPlayer:getRank(), localPlayer:getJobPoints())
  elseif tabId == self.m_TabSession.TabIndex then
    self:adjustSessionTab()
  elseif tabId == self.m_TabGroups.TabIndex then
    self:adjustGroupTab()
  end
end

function SelfGUI:adjustGeneralTab(AccountType, Rank, JobPoints)
  local hours, minutes = math.floor(localPlayer:getPlayTime()/60), (localPlayer:getPlayTime() - math.floor(localPlayer:getPlayTime()/60)*60)
  self.m_PlayTimeLabel:setText(_("%s Stunde(n) %s Minute(n)", hours, minutes))

  if AccountType then
    self.m_AccountTypeLabel:setText(_(ACCOUNTTYPE[AccountType]))
    self.m_AccountTypeHelpLabel:setPosition(self.m_Width*0.295 + dxGetTextWidth(_(ACCOUNTTYPE[AccountType]), self.m_AccountTypeLabel:getFontSize(), self.m_AccountTypeLabel:getFont()) + 10, self.m_Height*0.25)
  end
  if Rank then
    self.m_RankLabel:setText(_(RANK[Rank]))
  end
  if JobPoints then
    self.m_JobPointsLabel:setText(tostring(JobPoints))
    self.m_JobPointsHelpLabel:setPosition(self.m_Width*0.295 + dxGetTextWidth(JobPoints, self.m_JobPointsLabel:getFontSize(), self.m_JobPointsLabel:getFont()) + 10, self.m_Height*0.525)
  end
end

function SelfGUI:adjustSessionTab()
  -- Set Token
  if self.m_TokenLabel:getText() == "" then
    local token = localPlayer:getPrivateSync("SessionToken")
    self.m_TokenLabel:setText(_("Token: %s", token))
    self.m_TokenCopyLabel:setPosition(self.m_Width*0.02 + dxGetTextWidth(_("Token: %s", token), self.m_TokenLabel:getFontSize(), self.m_TokenLabel:getFont()) + 10, self.m_Height*0.12)
  end

  -- Update Grid
  self.m_SessionGrid:clear()
  for i, v in pairs(localPlayer:getPrivateSync("SessionInfo")) do
    local i = i:upperFirst()
    if type(v) ~= "table" then
      self.m_SessionGrid:addItem(i, tostring(v))
    else
      for i2, v in pairs(v) do
        self.m_SessionGrid:addItem(i.."."..i2, tostring(v))
      end
    end
  end
end

function SelfGUI:adjustGroupTab()
end
