-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUIMouseMenuNoClickItem.lua
-- *  PURPOSE:     GUI mouse menu item class
-- *
-- ****************************************************************************
GUIMouseMenuNoClickItem = inherit(GUIMouseMenuItem)

function GUIMouseMenuNoClickItem:constructor(posX, posY, width, height, text, parent)
	checkArgs("GUIMouseMenuNoClickItem:constructor", "number", "number", "number", "number")

	GUIElement.constructor(self, posX, posY, width, height, parent)
	GUIFontContainer.constructor(self, text, 1, VRPFont(self.m_Height))
	GUIColorable.constructor(self, Color.Orange)
	self:setBackgroundColor(tocolor(0, 0, 0, 220))
end

function GUIMouseMenuNoClickItem:drawThis()
	-- Draw background
	dxDrawRectangle(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, self.m_BackgroundColor)

	-- Draw item text
	dxDrawText(self.m_Text, self.m_AbsoluteX + 5, self.m_AbsoluteY + 3, self.m_Width - 10, self.m_Height - 6, self.m_Color, self.m_FontSize, self.m_Font)
end

function GUIMouseMenuItem:getBackgroundColor(color)
	return self.m_BackgroundColor
end

function GUIMouseMenuItem:setBackgroundColor(color)
	self.m_BackgroundColor = color
	self:anyChange()

	return self
end
