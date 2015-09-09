-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/GUIForms/DownloadGUI.lua
-- *  PURPOSE:     DownloadGUI class
-- *
-- ****************************************************************************
DownloadGUI = inherit(GUIForm)
inherit(GUIMovable, DownloadGUI)
inherit(Singleton, DownloadGUI)

DownloadGUI.lastPercent = 0

function DownloadGUI:constructor()
  -- I have to "remake" a GUI Window manually, cause the GUI Window-Title Bar is too big
  GUIForm.constructor(self, screenWidth/2-150, screenHeight-60, 350, 50)

  GUIRectangle:new(0, 0, self.m_Width, self.m_Height, tocolor(0, 0, 0, 150), self)
  self.m_Titlebar = GUIRectangle:new(0, 0, self.m_Width, 25, Color.Grey, self)
  self.m_Titlebar.onLeftClickDown = function () self:startMoving() end
  self.m_Titlebar.onLeftClick = function () self:stopMoving() end

  self.m_CloseButton = GUILabel:new(self.m_Width-23, 0, 23, 23, "[x]", self):setFont(VRPFont(30))
  self.m_CloseButton.onLeftClick = function() delete(self) end
  self.m_CloseButton.onHover = function () self.m_CloseButton:setColor(Color.Red) end
  self.m_CloseButton.onUnhover = function () self.m_CloseButton:setColor(Color.White) end

  self.m_ProgressBar = GUIProgressBar:new(self.m_Width*0.01, self.m_Height - self.m_Height*0.13, self.m_Width - self.m_Width*0.02, self.m_Height*0.09, self)
    :setProgress(DownloadGUI.lastPercent)
    :setForegroundColor(Color.DarkBlue)
    :setBackgroundColor(Color.White)
end

function DownloadGUI:updateData(data, status)
  local name, compSize, currSize = data.path, sizeFormat(data.size), sizeFormat(math.floor((data.size/100)*status.percentComplete))
  outputDebug(name..", "..compSize..", "..currSize)

  DownloadGUI.lastPercent = status.percentComplete
  self.m_ProgressBar:setProgress(status.percentComplete)
end
