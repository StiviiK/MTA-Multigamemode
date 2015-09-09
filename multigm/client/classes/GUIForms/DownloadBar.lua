-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/GUIForms/DownloadBar.lua
-- *  PURPOSE:     DownloadBar class
-- *
-- ****************************************************************************
DownloadBar = inherit(GUIForm)

local Progress = 0
function DownloadBar:constructor(callback, callbackargs)
  GUIForm.constructor(self, screenWidth - screenWidth*0.175, screenHeight - screenHeight*0.13, screenWidth*0.16, screenHeight*0.11)
  Cursor:hide()

  self.m_Background = GUIRectangle:new(0, 0, self.m_Width, self.m_Height, tocolor(0, 0, 0, 150), self)
  GUIRectangle:new(self.m_Width*0.02, self.m_Height*0.07, self.m_Width - self.m_Width*0.04, self.m_Height*0.2, Color.Grey, self.m_Background)
  GUILabel:new(self.m_Width*0.02, self.m_Height*0.07, self.m_Width - self.m_Width*0.04, self.m_Height*0.2, "Downloading additional files...", self.m_Background)
    :setAlignX("center")
    :setAlignY("center")
  self.m_ProgressBar = GUIProgressBar:new(self.m_Width*0.02, self.m_Height*0.3, self.m_Width - self.m_Width*0.04, self.m_Height - self.m_Height*0.59, self.m_Background)
    :setForegroundColor(Color.Orange)
    :setBackgroundColor(Color.Clear)
  self.m_InfoLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.3, self.m_Width - self.m_Width*0.04, self.m_Height - self.m_Height*0.59, "File: -\nSize: - / -", self.m_Background)
    :setAlignX("center")
    :setAlignY("center")
    :setFont(VRPFont(self.m_Height*0.2))
  GUIRectangle:new(self.m_Width*0.02, self.m_Height - self.m_Height*0.25, self.m_Width - self.m_Width*0.04, self.m_Height*0.2, Color.Grey, self.m_Background)
  self.m_RemainingLabel = GUILabel:new(self.m_Width*0.02, self.m_Height - self.m_Height*0.25, self.m_Width - self.m_Width*0.04, self.m_Height*0.2, "Remaining: -", self.m_Background)
    :setAlignX("center")
    :setAlignY("center")

  self.m_Callback = callback
  self.m_CallbackArgs = callbackargs or {}
end

function DownloadBar:updateData(fileData, latentStatus)
  self.m_ProgressBar:setProgress(latentStatus.percentComplete)
  self.m_InfoLabel:setText(("File: %s\nSize: %s / %s"):format(fileData.path, sizeFormat(math.floor((fileData.size/100)*latentStatus.percentComplete)), sizeFormat(fileData.size)))
  self.m_RemainingLabel:setText(("Remaining: ~%sms"):format(latentStatus.tickEnd))
end

function DownloadBar:destructor()
  GUIForm.destructor(self)

  if self.m_Callback then
    self.m_Callback(unpack(self.m_CallbackArgs))
  end
end
