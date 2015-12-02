HelpBar = inherit(GUIForm)
inherit(Singleton, HelpBar)

function HelpBar:constructor()
  GUIForm.constructor(self, screenWidth*0.84, 0, screenWidth*0.16, screenHeight, false)

  self.m_HelpLabel = GUILabel:new(screenWidth - screenWidth*0.055/ASPECT_RATIO_MULTIPLIER , screenHeight - screenHeight*0.125, screenWidth*0.05/ASPECT_RATIO_MULTIPLIER, screenHeight*0.1, FontAwesomeSymbols.QuestionCircle)
    :setFont(FontAwesome(screenHeight*0.1))
  self.m_HelpLabel.onHover = function () self.m_HelpLabel:setColor(Color.Orange) end
  self.m_HelpLabel.onUnhover = function () self.m_HelpLabel:setColor(Color.White) end
  self.m_HelpLabel.onLeftClick = function ()
    self:open()
  end

  self.m_Rectangle = GUIRectangle:new(self.m_Width, 0, self.m_Width, self.m_Height, tocolor(0, 0, 0, 200), self)
  self.m_TitleLabel = GUILabel:new(self.m_Width*0.05, self.m_Height*0.01, self.m_Width*0.9, self.m_Height*0.1, _"Hilfe", self.m_Rectangle):setColor(Color.Orange)
  self.m_SubTitleLabel = GUILabel:new(self.m_Width*0.05, self.m_Height*0.1, self.m_Width*0.9, self.m_Height*0.04, "Kein Text", self.m_Rectangle):setColor(Color.Orange)
  self.m_TextLabel = GUILabel:new(self.m_Width*0.05, self.m_Height*0.15, self.m_Width*0.9, self.m_Height*0.8, LOREM_IPSUM, self.m_Rectangle):setFont(VRPFont(self.m_Height*0.029))

  self.m_CloseButton = GUILabel:new(self.m_Width*0.75, self.m_Height*0.035, self.m_Width*0.25, self.m_Height*0.05, FontAwesomeSymbols.ArrowRight, self.m_Rectangle)
    :setColor(Color.Orange)
    :setFont(FontAwesome(self.m_Height*0.05))
	self.m_CloseButton.onLeftClick = function() self:close() end
	self.m_CloseButton.onHover = function () self.m_CloseButton:setColor(Color.White) end
	self.m_CloseButton.onUnhover = function () self.m_CloseButton:setColor(Color.Orange) end

  -- Blend it out
  self:setVisible(false)
end

function HelpBar:destructor()
end

function HelpBar:open(...)
  if self:isVisible() then return end

  -- Reset color according to the current gamemode
  local color = localPlayer:getGamemode():getColor() or Color.Orange
  self.m_TitleLabel:setColor(color)
  self.m_SubTitleLabel:setColor(color)
  self.m_CloseButton:setColor(color)
  self.m_CloseButton.onUnhover = function () self.m_CloseButton:setColor(color) end

  -- Set the text
  self:setText(...)

  -- Fade the bar in
  self:fadeIn()
end

function HelpBar:close()
  if not self:isVisible() then return false end

  -- Fade the bar out
  self:fadeOut()

  -- Reset text, if temporary
  if self.m_TemporaryHelp then
    setTimer(function ()
      self:setText(self.m_OldText, false)
      self.m_TemporaryHelp = false
      self.m_OldText = false
    end, 500, 1)
  end
end

function HelpBar:fadeIn()
  -- Call super.open()
  GUIForm.open(self)

  self.m_Rectangle:setPosition(self.m_Width, 0)
  Animation.Move:new(self.m_Rectangle, 500, 0, 0)

  self.m_HelpLabel.onUnhover()
  self.m_HelpLabel:setVisible(false)
end

function HelpBar:fadeOut()
  self.m_Rectangle:setPosition(0, 0)
  Animation.Move:new(self.m_Rectangle, 500, self.m_Width, 0)

  setTimer(function ()
    -- Call super.close()
    GUIForm.close(self)

    -- Show HelpLabel
    self.m_HelpLabel:setVisible(true)
  end, 500, 1)
end

function HelpBar:setText(tbl, temporary)
  if not tbl then return false end
  if temporary then
    self.m_TemporaryHelp = true
    self.m_OldText = {title = self.m_SubTitleLabel:getText(), text = self.m_TextLabel:getText()}
  end

  -- Set the translated text
  self.m_SubTitleLabel:setText(_(tbl.title))
  self.m_TextLabel:setText(_(tbl.text, tbl.format ~= nil and unpack(tbl.format) or unpack({})))
end
