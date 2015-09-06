-- ****************************************************************************
-- *
-- *  PROJECT:     vRoleplay
-- *  FILE:        client/classes/GUI/GUIScrollable.lua
-- *  PURPOSE:     GUI scrollable super class
-- *
-- ****************************************************************************
GUIScrollableArea = inherit(GUIElement)
local SCROLL_DISTANCE = 14

function GUIScrollableArea:constructor(posX, posY, width, height, documentWidth, documentHeight, verticalScrollbar, horizontalScrollbar, parent, space)
	GUIElement.constructor(self, posX, posY, width, height, parent)

	self.m_PageTarget = dxCreateRenderTarget(documentWidth, documentHeight, true)
	dxSetTextureEdge(self.m_PageTarget, "border", Color.Clear)

	self.m_ScrollX = 0
	self.m_ScrollY = 0
	self.m_DocumentWidth = documentWidth
	self.m_DocumentHeight = documentHeight
	self.m_ChangedSinceLastFrame = true

	if verticalScrollbar or horizontalScrollbar then
		self:createScrollbars(verticalScrollbar, horizontalScrollbar, space)
	end
end

function GUIScrollableArea:destructor()
	destroyElement(self.m_PageTarget)
	if self.m_HorizontalScrollbar then
		delete(self.m_HorizontalScrollbar)
	end
	if self.m_VerticalScrollbar then
		delete(self.m_VerticalScrollbar)
	end

	GUIElement.destructor(self)
end

function GUIScrollableArea:draw(incache)
	if self.m_Visible == false then
		return
	end
	-- Absolute X = Real X for drawing on the render target
	local refreshAbsolutePosition;
	refreshAbsolutePosition = function(element)
		for k, v in ipairs(element.m_Children) do
			v.m_AbsoluteX = element.m_AbsoluteX + v.m_PosX
			v.m_AbsoluteY = element.m_AbsoluteY + v.m_PosY
			refreshAbsolutePosition(v)
		end
	end
	local absx, absy = self.m_AbsoluteX, self.m_AbsoluteY
	self.m_AbsoluteX, self.m_AbsoluteY = 0, 0---self.m_ScrollX*2, self.m_ScrollY*2
	refreshAbsolutePosition(self)

	-- Draw Children to render Target
	dxSetRenderTarget(self.m_PageTarget, true)

	-- Draw Self
	if self.drawThis then self:drawThis(incache) end

	-- Draw children
	for k, v in ipairs(self.m_Children) do
		if v.draw then v:draw(incache) end
	end
	dxSetRenderTarget(self.m_CacheArea.m_RenderTarget or nil)

	-- Recreate AbsoluteX for the update() method to allow mouse actions
	self.m_AbsoluteX, self.m_AbsoluteY = absx, absy
	refreshAbsolutePosition(self)

	if GUI_DEBUG then
		dxDrawRectangle(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, tocolor(math.random(0, 255), math.random(0, 255), math.random(0, 255), 150))
	end

	--dxDrawImage(self.m_AbsoluteX, self.m_AbsoluteY, self.m_DocumentWidth, self.m_DocumentHeight, self.m_PageTarget)
	dxDrawImageSection(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, 0, 0, self.m_Width, self.m_Height, self.m_PageTarget)
end

function GUIScrollableArea:setScrollPosition(x, y)
	local oldScrollX, oldScrollY = self.m_ScrollX, self.m_ScrollY
	self.m_ScrollX, self.m_ScrollY = x, y

	if self.m_VerticalScrollbar then
		self.m_VerticalScrollbar:setScrollPosition(-self.m_ScrollY / (self.m_DocumentHeight-self.m_Height))
	end

	if self.m_HorizontalScrollbar then
		self.m_HorizontalScrollbar:setScrollPosition(self.m_ScrollX / self.m_DocumentWidth)
	end

	local refreshAbsolutePosition;
	refreshAbsolutePosition = function(element)
		for k, v in ipairs(element.m_Children) do
			v.m_AbsoluteX = element.m_AbsoluteX + v.m_PosX
			v.m_AbsoluteY = element.m_AbsoluteY + v.m_PosY
			refreshAbsolutePosition(v)
		end
	end

	local diffX, diffY = x - oldScrollX, y - oldScrollY
	for k, v in ipairs(self.m_Children) do
		v.m_PosX = v.m_PosX - diffX
		v.m_PosY = v.m_PosY + diffY
		refreshAbsolutePosition(v)
	end

	self:anyChange()
	return self
end

function GUIScrollableArea:getScrollPosition()
	return self.m_ScrollX, self.m_ScrollY
end

function GUIScrollableArea:resize(documentWidth, documentHeight)
	destroyElement(self.m_PageTarget)
	self.m_PageTarget = dxCreateRenderTarget(documentWidth, documentHeight, true)
	dxSetTextureEdge(self.m_PageTarget, "border", Color.Clear)

	self.m_DocumentWidth, self.m_DocumentHeight = documentWidth, documentHeight

	if self.m_VerticalScrollbar and self.m_DocumentHeight > self.m_Height then
		self.m_VerticalScrollbar:setVisible(true)
		self.m_VerticalScrollbar:setScrollerSize(self.m_Height/self.m_DocumentHeight * self.m_Height)
	else
		self.m_VerticalScrollbar:setVisible(false)
	end

	self:anyChange()
end

function GUIScrollableArea:createScrollbars(verticalScrollbar, horizontalScrollbar, space)
	-- We cannot create any scrollbar is this element does not have a parent
	if not self.m_Parent then
		return
	end

	if verticalScrollbar then
		self.m_VerticalScrollbar = GUIVerticalScrollbar:new(self.m_PosX + self.m_Width - 4, space or 0, 4, self.m_Height, self.m_Parent)

		if self.m_DocumentHeight <= self.m_Height then
			self.m_VerticalScrollbar:setVisible(false)
		end
	end
end

function GUIScrollableArea:onInternalMouseWheelUp()
	if self.m_ScrollY < 0 then
		local diff = SCROLL_DISTANCE
		if -self.m_ScrollY < SCROLL_DISTANCE then
			diff = -self.m_ScrollY
		end

		self:setScrollPosition(self.m_ScrollX, self.m_ScrollY + diff)
	end
end

function GUIScrollableArea:onInternalMouseWheelDown()
	local diff = self.m_DocumentHeight - self.m_Height + self.m_ScrollY
	if diff <= 0 then
		return
	end

	if diff >= SCROLL_DISTANCE then
		diff = SCROLL_DISTANCE
	else
		diff = diff % SCROLL_DISTANCE
	end

	self:setScrollPosition(self.m_ScrollX, self.m_ScrollY - diff)
end
