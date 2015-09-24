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
end

function SelfGUI:TabPanel_TabChanged(tabId)

end
