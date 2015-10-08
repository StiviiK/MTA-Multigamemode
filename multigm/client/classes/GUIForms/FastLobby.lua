FastLobby = inherit(GUIForm)
inherit(Singleton, FastLobby)

function FastLobby:constructor()
  GUIForm.constructor(self, 0, 0, screenWidth, screenHeight)
  self.m_Gamemodes = {
    -- [Id] = {NAME, false (current Gamemode), unlocked}
    {Name = "Lobby", Current = false, Active = true};
    {Name = "Cops'n'Robbers", Current = false, Active = true, Background = "files/images/backgrounds/cnr/cnr-bg.jpg"};
  }
  if localPlayer:getGamemode() then
    self.m_ScreenSource = DxScreenSource(self.m_Width, self.m_Height)
    self.m_ScreenSource:update()
    self.m_Gamemodes[localPlayer:getGamemode()].Current = true

    self.m_UpdateScreenSource = bind(self.updateScreenSource, self)
    addEventHandler("onClientRender", root, self.m_UpdateScreenSource)
  end
  self.m_Background = GUIImage:new(0, 0, self.m_Width, self.m_Height, "files/images/backgrounds/lobby/lobby-bg.jpg", self)

  local wPerImage = (self.m_Width - self.m_Width*0.105 - self.m_Width*0.005)/4
  local hPerImage = (self.m_Height - self.m_Height*0.3 - self.m_Height*0.008)/3
  for colum = 1, 4, 1 do
    for row = 1, 3, 1 do
      local currGamemode = colum + (row-1) * 4
      if not self.m_Gamemodes[currGamemode] then
        self.m_Gamemodes[currGamemode] = {Name = "Dummy", Current = false, Active = false}
      end

      local posX = self.m_Width*0.05 + self.m_Width*0.005*(colum-1) + wPerImage*(colum-1)
      local posY = self.m_Height*0.15 + self.m_Height*0.008*(row-1) + hPerImage*(row-1)
      local width, height = wPerImage, hPerImage

      if self.m_Gamemodes[currGamemode].Active then
        if self.m_Gamemodes[currGamemode].Current then
          self.m_Gamemodes[currGamemode].Image = GUIImage:new(posX, posY, width, height, self.m_ScreenSource, self.m_Background)
          self.m_Gamemodes[currGamemode].Label = GUILabel:new(0, 0, width, height, ("%s %s"):format(FontAwesomeSymbols.User, self.m_Gamemodes[currGamemode].Name), self.m_Gamemodes[currGamemode].Image)
          self.m_Gamemodes[currGamemode].Label:setFont(FontAwesome(height/4.25))
        else
          local img = self.m_Gamemodes[currGamemode].Background or "files/images/backgrounds/lobby/lobby-bg.jpg"
          self.m_Gamemodes[currGamemode].Image = GUIImage:new(posX, posY, width, height, img, self)
          self.m_Gamemodes[currGamemode].Label = GUILabel:new(0, 0, width, height, ("%s %s"):format(FontAwesomeSymbols.Gamepad, self.m_Gamemodes[currGamemode].Name), self.m_Gamemodes[currGamemode].Image)
          self.m_Gamemodes[currGamemode].Label:setFont(FontAwesome(height/4.25))
        end
      else
        self.m_Gamemodes[currGamemode].Image = GUIRectangle:new(posX, posY, width, height, tocolor(0, 0, 0, 150), self)
        self.m_Gamemodes[currGamemode].Label = GUILabel:new(0, 0, width, height, ("%s %s"):format(FontAwesomeSymbols.Lock, "Coming soon"), self.m_Gamemodes[currGamemode].Image)
        self.m_Gamemodes[currGamemode].Label:setFont(FontAwesome(height/5))
      end

      self.m_Gamemodes[currGamemode].Image.m_GamemodeId = currGamemode
      self.m_Gamemodes[currGamemode].Label:setAlignX("center")
      self.m_Gamemodes[currGamemode].Label:setAlignY("center")
      self.m_Gamemodes[currGamemode].Label.onHover = function (element)
        if self.m_Gamemodes[currGamemode].Active then
          element:setColor(Color.Orange)

          Animation.Move:new(element.m_Parent, 100, posX - 5, posY - 5)
          Animation.Size:new(element.m_Parent, 100, width + 10, height + 10)
          Animation.Size:new(element, 100, width + 10, height + 10)
          element:setFont(FontAwesome((hPerImage + 10)/4.25))
        end
      end
      self.m_Gamemodes[currGamemode].Label.onUnhover = function (element)
        if self.m_Gamemodes[currGamemode].Active then
          element:setColor(Color.White)

          Animation.Move:new(element.m_Parent, 100, posX, posY)
          Animation.Size:new(element.m_Parent, 100, width, height)
          Animation.Size:new(element, 100, width, height)
          element:setFont(FontAwesome(hPerImage/4.25))
        end
      end
      self.m_Gamemodes[currGamemode].Label.onLeftClick = function (element)
        if self.m_Gamemodes[currGamemode].Active then
          outputDebug(element.m_Parent.m_GamemodeId)
          triggerServerEvent("Event_JoinGamemode", localPlayer, element.m_Parent.m_GamemodeId, true)

          Camera.fade(false, 0)
          delete(self)
        end
      end
    end
  end

  -- Account Info
  --[[
  GUIImage:new(self.m_Width*0.01, self.m_Height*0.01, self.m_Width*0.05, self.m_Width*0.05, "files/images/backgrounds/user.png", self)
  GUILabel:new(self.m_Width*0.065, self.m_Height*0.01, self.m_Width*0.1, self.m_Width*0.03, localPlayer:getName(), self)
  GUILabel:new(self.m_Width*0.065, self.m_Height*0.045, self.m_Width*0.1, self.m_Width*0.025, "Level: 3", self)
  --]]

  -- Git Info
  self.m_GeneralInfo = GUILabel:new(self.m_Width*0.01, self.m_Height*0.935, self.m_Width*0.075, self.m_Height*0.03, ("%s About us."):format(FontAwesomeSymbols.Heart), self)
  self.m_GeneralInfo:setFont(FontAwesome(self.m_Height*0.03))
  self.m_GeneralInfo.onHover = function () self.m_GeneralInfo:setColor(Color.Orange) end
  self.m_GeneralInfo.onUnhover = function () self.m_GeneralInfo:setColor(Color.White) end
  self.m_GeneralInfo.onLeftClick = function () InfoBox:new("Not implemented!") end

  -- Facebook Info
  self.m_FacebookInfo = GUILabel:new(self.m_Width*0.01, self.m_Height*0.965, self.m_Width*0.15, self.m_Height*0.03, ("%s Visit us on Facebook."):format(FontAwesomeSymbols.Facebook), self)
  self.m_FacebookInfo:setFont(FontAwesome(self.m_Height*0.03))
  self.m_FacebookInfo.onHover = function () self.m_FacebookInfo:setColor(Color.Orange) end
  self.m_FacebookInfo.onUnhover = function () self.m_FacebookInfo:setColor(Color.White) end
  self.m_FacebookInfo.onLeftClick = function () InfoBox:new("Not implemented!") end

  showChat(false)
  toggleAllControls(false)

  self:moveToBack()
end

function FastLobby:destructor()
  GUIForm.destructor(self)

  showChat(true)
  toggleAllControls(true)
  removeEventHandler("onClientRender", root, self.m_UpdateScreenSource)
end

function FastLobby:updateScreenSource()
  self.m_ScreenSource:update()
  for i, v in pairs(self.m_Gamemodes) do
    if v.Current then
      if v.Image then
        v.Image:anyChange()
      end
    end
  end
end

bindKey("F3", "down", function()
  if FastLobby:isInstantiated() then
    delete(FastLobby:getSingleton())
  else
    FastLobby:new()
  end
end)
