-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUIWindow.lua
-- *  PURPOSE:     GUI window class
-- *
-- ****************************************************************************
GUIWindow = inherit(GUIElement)
inherit(GUIMovable, GUIWindow)

function GUIWindow:constructor(posX, posY, width, height, title, hasTitlebar, hasCloseButton, parent)
	checkArgs("GUIWindow:constructor", "number", "number", "number", "number", "string")

	-- Call base class ctors
	GUIElement.constructor(self, posX, posY, width, height, parent)

	self.m_HasTitlebar = hasTitlebar
	self.m_HasCloseButton = hasCloseButton
	self.m_CloseOnClose = true

	-- Create dummy titlebar element (to be able to retrieve clicks)
	if self.m_HasTitlebar then
		--self.m_TitlebarDummy = GUIElement:new(0, 0, self.m_Width, 30, self)
		self.m_TitlebarDummy = GUIRectangle:new(0, 0, self.m_Width, 30, Color.Grey, self)
		self.m_TitlebarDummy.onLeftClickDown = function() self:startMoving() end
		self.m_TitlebarDummy.onLeftClick = function() self:stopMoving() end

		self.m_TitleLabel = GUILabel:new(0, 0, self.m_Width, 30, title, self)
			:setAlignX("center")
			:setAlignY("center")
	end

	if self.m_HasCloseButton then
		self.m_CloseButton = GUILabel:new(self.m_Width-28, 0, 28, 28, "[x]", self):setFont(VRPFont(35)) --GUIImage(self.m_Width - 40, 4, 35, 27, "res/images/GUI/close_button.png", self)
		--self.m_CloseButton.onHover = function(btn) btn:setColor(Color.Red) end
		--self.m_CloseButton.onUnhover = function(btn) btn:setColor(Color.White) end
		self.m_CloseButton.onLeftClick = bind(GUIWindow.CloseButton_Click, self)
	end
end

function GUIWindow:drawThis()
	-- Moving test
	--[[if self:isMoving() then
		self:updateMoveArea()
	end]]

	dxSetBlendMode("modulate_add")

	--dxDrawImage(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, "res/images/GUI/Window.png")
	-- Draw border (no longer a rectangle as causes issues with alpha)
	--dxDrawLine(self.m_AbsoluteX, self.m_AbsoluteY, self.m_AbsoluteX + self.m_Width, self.m_AbsoluteY)
	--dxDrawLine(self.m_AbsoluteX + self.m_Width - 1, self.m_AbsoluteY, self.m_AbsoluteX + self.m_Width - 1, self.m_AbsoluteY + self.m_Height - 1)
	--dxDrawLine(self.m_AbsoluteX, self.m_AbsoluteY + self.m_Height - 1, self.m_AbsoluteX + self.m_Width, self.m_AbsoluteY + self.m_Height - 1)
	--dxDrawLine(self.m_AbsoluteX, self.m_AbsoluteY, self.m_AbsoluteX, self.m_AbsoluteY + self.m_Height - 1)

	-- Draw background
	dxDrawRectangle(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, tocolor(0, 0, 0, 150))

	-- Draw logo
	if false then -- Should the logo be optional? | Todo: Since we haven't got a logo, disable that
		dxDrawImage(self.m_AbsoluteX + 10, self.m_AbsoluteY + self.m_Height - 29 - 10, 62, 29, "res/images/GUI/logo.png")
	end

	if self.m_HasTitlebar then
		-- Draw line under title bar
		dxDrawRectangle(self.m_AbsoluteX, self.m_AbsoluteY + 30, self.m_Width, 1, Color.White)
	end

	dxSetBlendMode("blend")
end

function GUIWindow:CloseButton_Click()
	if self.m_CloseOnClose then
		self:close()
	else
		(self.m_Parent or self):setVisible(false) -- Todo: if self.m_Parent == cacheroot then problem() end
		Cursor:hide()
	end
end

function GUIWindow:setTitleBarText (text)
	self.m_TitleLabel:setText(text)
	return self
end

--- Closes the window
function GUIWindow:close()
	-- Jusonex: Destroy or close, I dunno what's better
	delete(self.m_Parent or self)
end

function GUIWindow:setCloseOnClose(close) -- Todo: Find a better name
	self.m_CloseOnClose = close
	return self
end
