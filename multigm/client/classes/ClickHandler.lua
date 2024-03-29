-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/ClickHandler.lua
-- *  PURPOSE:     Class that handles clicks on elements
-- *
-- ****************************************************************************
ClickHandler = inherit(Singleton)

function ClickHandler:constructor()
	self.m_OpenMenus = {}
	self.m_Menu = {
		player = PlayerMouseMenu;
	}
	self.m_ElementMenu = {};
	self.m_ClickInfo = false
	self.m_DrawCursor = false

	addEventHandler("onClientClick", root,
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
		if state == "up" then
			self.m_ClickInfo = {button = button, absoluteX = absoluteX, absoluteY = absoluteY, element = element}
		end
	end
	)

	addEventHandler("onClientCursorMove", root,
	function(cursorX, cursorY, absX, absY, worldX, worldY, worldZ)
		-- Do not draw if cursor is not visible and is not on top of any GUI element
		if not isCursorShowing() or GUIElement.getHoveredElement() then
			self.m_DrawCursor = false
			Cursor.m_DrawCursor = true
			return
		end

		local element = getElementBehindCursor(worldX, worldY, worldZ)
		if not element then
			self.m_DrawCursor = false
			Cursor.m_DrawCursor = true
			return
		end

		local clickInfo = {button = "left", absoluteX = absX, absoluteY = absY, element = element}

		-- ClickHandler:dispatchClick returns true if there is a special mouse event available, false otherwise
		self.m_DrawCursor = self:dispatchClick(clickInfo)
		if self.m_DrawCursor then
			Cursor.m_DrawCursor = false
		else
			Cursor.m_DrawCursor = true
		end
	end
	)

	addEventHandler("onClientRender", root,
	function()
		if self.m_DrawCursor then
			local cx, cy = getCursorPosition()

			if cx then
				-- Convert relative coordinates to absolute ones
				cx, cy = cx * screenWidth, cy * screenHeight

				dxDrawImage(cx-18/2, cy-32/2, 24, 24, "res/images/GUI/Mouse.png", 0, 0, 0, Color.White, true)
			end
		end
	end
	)
end

function ClickHandler:invokeClick()
	if self.m_ClickInfo then
		self:dispatchClick(self.m_ClickInfo, true)
	end
	self.m_ClickInfo = false
end

function ClickHandler:clearClickInfo()
	self.m_ClickInfo = false
end

function ClickHandler:checkModels(model, ...)
	for k, v in pairs({...}) do
		if v == model then
			return true
		end
	end
	return false
end

function ClickHandler:dispatchClick(clickInfo, trigger)
	-- Focus if no element was clicked
	if trigger then Browser.focus(nil) guiSetInputEnabled(false) end

	-- Disabled clickhandler as long as the player is not logged in
	if not localPlayer:isLoggedIn() then return end

	-- Close all currently open menus
	if trigger then self:clearMouseMenus() end

	local element, button = clickInfo.element, clickInfo.button
	if not element or not isElement(element) then
		return false
	end
	local elementType = getElementType(element)
	local model = getElementModel(element)
	local playerX, playerY, playerZ = getElementPosition(localPlayer)
	local x, y, z = getElementPosition(element)
	local range = getDistanceBetweenPoints3D(playerX, playerY, playerZ, x, y, z)

	-- Phase 1: Check per-element handlers
	if element == localPlayer then
		if trigger then
			if button == "left" then
				SelfGUI:getSingleton():open()
			elseif button == "right" then
				outputChatBox(ColorToHex(Color.Yellow).."Hm, seems you're trying to right-click yourself.\nOkay... ehm, so you're retarded?", 255, 255, 255, true)
			end
		end
		return true
	end

	-- Phase 2: Check for Gamemode Peds
	if elementType == "ped" then
		if range <= 5 then
			for i, v in pairs(GamemodePedManager.Map) do
				if v.m_Ped == element then
					if trigger then
						if button == "left" then
							self:addMouseMenu(GamemodePedMouseMenu:new(clickInfo.absoluteX, clickInfo.absoluteY, v, (v:hasCustomColor() and v:getCustomColor())), element)
						end
					end
					return true
				end
			end
		else
			return false
		end
	end

	-- Phase 3: Check element types
	if self.m_Menu[elementType] then
		if trigger then
			if button == "left" then
				self:addMouseMenu(self.m_Menu[elementType]:new(clickInfo.absoluteX, clickInfo.absoluteY, element), element)
			end
		end
		return true
	end

	-- Phase 4:

	if self.m_ElementMenu[element]  then
		if self.m_ElementMenu[element]["Gamemode"] == localPlayer:getGamemode() then
			if trigger then
				if button == "left" then
					self.m_ElementMenu[element]["Menu"]:getSingleton():open()
				end
			end
			return true
		end
	end


	return false
end

function ClickHandler:addMouseMenu(menu, element)
	menu:setElement(element)
	table.insert(self.m_OpenMenus, menu)
end

function ClickHandler:addElementMenu(Gamemode,menu, element)
	self.m_ElementMenu[element] = {["Gamemode"] = Gamemode,["Menu"] = menu}
end

function ClickHandler:RemoveElementMenu(Gamemode,element)
	self.m_ElementMenu[element] = false
end


function ClickHandler:clearMouseMenus()
	for k, menu in ipairs(self.m_OpenMenus) do
		delete(menu)
	end
	self.m_OpenMenus = {}

	for k, Element in ipairs(self.m_ElementMenu) do
		----TODO
	end
end
