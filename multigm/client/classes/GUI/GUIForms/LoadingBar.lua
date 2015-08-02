LoadingBar = inherit(Object)
LoadingBar.offSet = 0

function LoadingBar:constructor(text, callback, callbackargs)
  self.m_Height       = screenY*0.04
  self.m_Color        = tocolor(0, 0, 0, 250)
  self.m_Text         = text or "Loading Gamemode..."
  self.m_Font         = Font("Betmicua-Regular.otf", 9.9)
  self.m_FontSize     = 1
  self.m_Callback     = callback or false
  self.m_CallbackArgs = callbackargs or {}

  -- recalculate
  self.m_Width = dxGetTextWidth(self.m_Text, self.m_FontSize, self.m_Font) + (self.m_Height - 10) + 20
  self.m_PosX = screenX - 15 - self.m_Width
  self.m_PosY = screenY - 15 - self.m_Height - LoadingBar.offSet
  LoadingBar.offSet = LoadingBar.offSet + self.m_Height + 5


  self.m_RenderEvent = bind(LoadingBar.drawThis, self)
  addEventHandler("onClientRender", root, self.m_RenderEvent)
end

function LoadingBar:destructor()
  LoadingBar.offSet = LoadingBar.offSet - self.m_Height - 5
  removeEventHandler("onClientRender", root, self.m_RenderEvent)

  if self.m_Callback then
    self.m_Callback(unpack(self.m_CallbackArgs))
  end
end

function LoadingBar:setText(text)
  self.m_Text = text

  self.m_Width = dxGetTextWidth(self.m_Text, self.m_FontSize, self.m_Font) + (self.m_Height - 10) + 20
  self.m_PosX = screenX - 15 - self.m_Width
end

function LoadingBar:getText()
  return self.m_Text
end

function LoadingBar:drawThis()
  dxDrawRectangle(self.m_PosX, self.m_PosY, self.m_Width, self.m_Height, self.m_Color)
  dxDrawImage(self.m_PosX + self.m_Width - self.m_Height, self.m_PosY + 5, self.m_Height - 10, self.m_Height - 10, "files/images/GUI/download.png", getTickCount()*0.1)
  dxDrawText(self.m_Text, self.m_PosX + 5, self.m_PosY, self.m_PosX + self.m_Width - self.m_Height - 5, self.m_PosY + self.m_Height, tocolor(255, 255, 255, 200), self.m_FontSize, self.m_Font, "left", "center", true)
end
