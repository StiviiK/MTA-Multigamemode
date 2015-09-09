-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/GUIForms/DownloadBar.lua
-- *  PURPOSE:     DownloadBar class
-- *
-- ****************************************************************************
DownloadBar = inherit(GUIForm)

function DownloadBar:constructor(callback, callbackargs)
  GUIForm.constructor(self, screenWidth - screenWidth*0.155, screenHeight - screenHeight*0.06, screenWidth*0.14, screenHeight*0.04)

  self.m_Background = GUIRectangle:new(0, 0, self.m_Width, self.m_Height, tocolor(0, 0, 0, 225), self)
  GUILabel:new(self.m_Width*0.02 + self.m_Height*0.75 + self.m_Height*0.25, self.m_Height - self.m_Height*0.8, self.m_Width*0.45, self.m_Height*0.75, "Downloading", self.m_Background):setFont(VRPFont(self.m_Height*0.7))
  self.m_Label = GUILabel:new(self.m_Width*0.02 + self.m_Height*0.75 + self.m_Height*0.25 + self.m_Width*0.425, self.m_Height - self.m_Height*0.7, self.m_Width*0.6, self.m_Height*0.75, "(click for info)", self.m_Background):setFont(VRPFont(self.m_Height*0.55))
  self.m_Label.onHover = function () self.m_Label:setColor(Color.LightBlue) end
  self.m_Label.onUnhover = function () self.m_Label:setColor(Color.White) end
  self.m_Label.onLeftClick = function () DownloadGUI:new() end
  self.m_Image = GUIImage:new(self.m_Width*0.02, self.m_Height - self.m_Height*0.85, self.m_Height*0.75, self.m_Height*0.75, "files/images/GUI/download.png", self.m_Background)

  self.m_Callback = callback
  self.m_CallbackArgs = callbackargs or {}
end

function DownloadBar:update()
  self.m_Image:setRotation(getTickCount()*0.1)
end

function DownloadBar:destructor()
  GUIForm.destructor(self)

  if DownloadGUI:isInstantiated() then
    delete(DownloadGUI:getSingleton())
  end

  if self.m_Callback then
    self.m_Callback(unpack(self.m_CallbackArgs))
  end
end
