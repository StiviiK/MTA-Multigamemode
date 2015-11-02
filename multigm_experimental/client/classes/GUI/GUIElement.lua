-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUIElement.lua
-- *  PURPOSE:     Base class for all GUI elements
-- *
-- ****************************************************************************

GUIElement = inherit(DxElement)

function GUIElement:constructor(posX, posY, width, height, parent)
	checkArgs("CGUIElement:constructor", "number", "number", "number", "number")
	if not (type(parent) == "table" or parent == nil) then -- temp debug
		outputConsole(debug.traceback())
	end
	assert(type(parent) == "table" or parent == nil, "Bad argument #5 @ GUIElement.constructor")

	DxElement.constructor(self, posX, posY, width, height, parent)

	-- Hover / Click Events
	self.m_LActive = false
	self.m_RActive = false
	self.m_Hover  = false
end

function GUIElement:performChecks(mouse1, mouse2, cx, cy)
	if not self.m_Visible then
		return
	end

	local absoluteX, absoluteY = self.m_AbsoluteX, self.m_AbsoluteY
	if self.m_CacheArea then
		absoluteX = absoluteX + self.m_CacheArea.m_AbsoluteX
		absoluteY = absoluteY + self.m_CacheArea.m_AbsoluteY
	end

	local inside = (absoluteX <= cx and absoluteY <= cy and absoluteX + self.m_Width > cx and absoluteY + self.m_Height > cy)

	if self.m_LActive and not mouse1 and (not self.ms_ClickProcessed or GUIElement.ms_CacheAreaRetrievedClick == self.m_CacheArea) then
		if self.onLeftClick			then self:onLeftClick(cx, cy)			end
		if self.onInternalLeftClick	then self:onInternalLeftClick(cx, cy)	end
		self.m_LActive = false

		if self ~= GUIRenderer.cacheroot then
			GUIElement.ms_ClickProcessed = true
			GUIElement.ms_CacheAreaRetrievedClick = self.m_CacheArea
		end
		--return true
	end
	if self.m_RActive and not mouse2 and (not self.ms_ClickProcessed or GUIElement.ms_CacheAreaRetrievedClick == self.m_CacheArea) then
		if self.onRightClick			then self:onRightClick(cx, cy)			end
		if self.onInternalRightClick	then self:onInternalRightClick(cx, cy)	end
		self.m_RActive = false

		if self ~= GUIRenderer.cacheroot then
			GUIElement.ms_ClickProcessed = true
			GUIElement.ms_CacheAreaRetrievedClick = self.m_CacheArea
		end
		--return true
	end

	if not inside then
		-- Call on*Events (disabling)
		if self.m_Hover then
			if self.onUnhover		  then self:onUnhover()         end
			if self.onInternalUnhover then self:onInternalUnhover() end
			self.m_Hover = false

			-- Unhover down the tree (otherwise the unhover routine won't be executed)
			for k, child in ipairs(self.m_Children) do
				if child.onUnhover		  then child:onUnhover()         end
				if child.onInternalUnhover then child:onInternalUnhover() end
				child.m_Hover = false
			end
		end

		return
	end

	-- Set hovered element (do it every time because it gets reset before each processing iteration)
	GUIElement.ms_HoveredElement = self

	-- Call on*Events (enabling)
	if not self.m_Hover then
		if self.onHover			then self:onHover()			end
		if self.onInternalHover then self:onInternalHover() end
		self.m_Hover = true
	end
	if mouse1 and not self.m_LActive and (not GUIElement.ms_ClickDownProcessed or GUIElement.ms_CacheAreaRetrievedClick == self.m_CacheArea) then
		if self.onLeftClickDown			then self:onLeftClickDown(cx, cy)			end
		if self.onInternalLeftClickDown then self:onInternalLeftClickDown(cx, cy) 	end
		self.m_LActive = true

		if self ~= GUIRenderer.cacheroot then
			GUIElement.ms_ClickDownProcessed = true
			GUIElement.ms_CacheAreaRetrievedClick = self.m_CacheArea
		end

		-- Check whether the focus changed
		GUIInputControl.checkFocus(self)
	end
	if mouse2 and not self.m_RActive and (not GUIElement.ms_ClickDownProcessed or GUIElement.ms_CacheAreaRetrievedClick == self.m_CacheArea) then
		if self.onRightClickDown			then self:onRightClickDown(cx, cy)			end
		if self.onInternalRightClickDown	then self:onInternalRightClickDown(cx, cy)	end
		self.m_RActive = true

		if self ~= GUIRenderer.cacheroot then
			GUIElement.ms_ClickDownProcessed = true
			GUIElement.ms_CacheAreaRetrievedClick = self.m_CacheArea
		end
	end


	if self.m_LActive and not mouse1 then
		self.m_LActive = false
	end

	if self.m_RActive and not mouse2 then
		self.m_RActive = false
	end

	-- Check on children
	for k, v in ipairs(self.m_Children) do
		if v:performChecks(mouse1, mouse2, cx, cy) then
			--break
		end
	end
end

function GUIElement.unhoverAll()
	local self = GUIElement.ms_HoveredElement
	while self do
		if self.m_Hover then
			if self.onUnhover		  then self:onUnhover()         end
			if self.onInternalUnhover then self:onInternalUnhover() end
			self.m_Hover = false
		end
		self = self.m_Parent
	end
	GUIElement.ms_HoveredElement = false
end

function GUIElement:updateInput()
	-- Check for hovers, clicks, ...
	local relCursorX, relCursorY = getCursorPosition()
	if relCursorX then
		local cursorX, cursorY = relCursorX * screenWidth, relCursorY * screenHeight

		self:performChecks(getKeyState("mouse1"), getKeyState("mouse2"), cursorX, cursorY)
	end
end

function GUIElement.getHoveredElement()
	return GUIElement.ms_HoveredElement
end

function GUIElement:isHovered()
	return self.m_Hover
end

-- Static mouse wheel event checking
addEventHandler("onClientResourceStart", resourceRoot,
	function()
		bindKey("mouse_wheel_up", "down",
			function()
				local hoveredElement = GUIElement.getHoveredElement()
				while hoveredElement do
					-- Trigger events up the tree
					if hoveredElement.onInternalMouseWheelUp then hoveredElement:onInternalMouseWheelUp() end
					if hoveredElement.onMouseWheelUp then hoveredElement:onMouseWheelUp() end
					hoveredElement = hoveredElement.m_Parent
				end
			end
		)
		bindKey("mouse_wheel_down", "down",
			function()
				local hoveredElement = GUIElement.getHoveredElement()
				while hoveredElement do
					-- Trigger events up the tree
					if hoveredElement.onInternalMouseWheelDown then hoveredElement:onInternalMouseWheelDown() end
					if hoveredElement.onMouseWheelDown then hoveredElement:onMouseWheelDown() end
					hoveredElement = hoveredElement.m_Parent
				end
			end
		)
	end
)

addEventHandler("onClientDoubleClick", root,
	function(button, absoluteX, absoluteY)
		local guiElement = GUIElement.getHoveredElement()

		if guiElement and guiElement:isVisible(true) then
			if button == "left" and guiElement.onLeftDoubleClick then
				guiElement:onLeftDoubleClick(absoluteX, absoluteY)
			end
			if button == "right" and guiElement.onRightDoubleClick then
				guiElement:onRightDoubleClick(absoluteX, absoluteY)
			end
		end
	end
)
