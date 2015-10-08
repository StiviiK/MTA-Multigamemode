-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUIHorizontalScrollbar.lua
-- *  PURPOSE:     GUI form class (base class)
-- *  NOTE:		   I decided to use an extra horizontal image, because otherwise we've to swap width and height (-> mess)
-- *
-- ****************************************************************************
GUIHorizontalScrollbar = inherit(GUIScrollbar)

function GUIHorizontalScrollbar:constructor(posX, posY, width, height, parent)
	self.m_CursorMoveHandler = bind(GUIHorizontalScrollbar.Event_onClientCursorMove, self)
end

function GUIHorizontalScrollbar:onInternalLeftClickDown(cx, cy)
	local x, y = self:getPosition(true)
	local scrollerX = x + GUI_SCROLLBAR_ELEMENT_MARGIN + self.m_ScrollPosition * self.m_Width
	local scrollerY = y + GUI_SCROLLBAR_ELEMENT_MARGIN
	local scrollerWidth, scrollerHeight = 49, self.m_Height - 2*GUI_SCROLLBAR_ELEMENT_MARGIN

	-- Is the cursor on top of the slider?
	if cx > scrollerX and cy > scrollerY and cx < scrollerX+scrollerWidth and cy < scrollerY+scrollerHeight then
		-- Attach moving event
		addEventHandler("onClientCursorMove", root, self.m_CursorMoveHandler)
		self.m_Scrolling = true
	end
end

function GUIHorizontalScrollbar:onInternalLeftClick()
	if self.m_Scrolling then
		self.m_Scrolling = false

		-- Remove cursor move handler
		removeEventHandler("onClientCursorMove", root, self.m_CursorMoveHandler)
		self.m_CursorOffset = nil
	end
end

function GUIHorizontalScrollbar:Event_onClientCursorMove(_, _, cursorX, cursorY)
	local currentX = self.m_ScrollPosition * self.m_Width
	local cursorOffX = cursorX - self.m_AbsoluteX
	local diff = cursorOffX - currentX
	self.m_CursorOffset = self.m_CursorOffset or diff
	local newX = currentX + diff - self.m_CursorOffset
	if newX < self.m_Width-49-GUI_SCROLLBAR_ELEMENT_MARGIN then
		self:setScrollPosition(newX / self.m_Width)

		-- Call scroll handler
		if self.m_ScrollHandler then
			self.m_ScrollHandler(self:getScrollPosition())
		end
	end
end

function GUIHorizontalScrollbar:drawThis()
	-- Draw scroll bar (rectangle)
	--dxDrawImage(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, "res/images/GUI/scrollbar_horz.png")
	dxDrawRectangle(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, Color.Grey)

	-- Draw scrollbar element
	--dxDrawImage(self.m_AbsoluteX + GUI_SCROLLBAR_ELEMENT_MARGIN + self.m_ScrollPosition * self.m_Width, self.m_AbsoluteY + GUI_SCROLLBAR_ELEMENT_MARGIN, 49, self.m_Height - 2*GUI_SCROLLBAR_ELEMENT_MARGIN, "res/images/GUI/scrollbar_horz_element.png")
	dxDrawRectangle(self.m_AbsoluteX + GUI_SCROLLBAR_ELEMENT_MARGIN + self.m_ScrollPosition * self.m_Width, self.m_AbsoluteY + GUI_SCROLLBAR_ELEMENT_MARGIN, 49, self.m_Height - 2*GUI_SCROLLBAR_ELEMENT_MARGIN, self.m_Color)
end
