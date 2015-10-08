-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUICursor.lua
-- *  PURPOSE:     GUI custom cursor class
-- *
-- ****************************************************************************
GUICursor = inherit(Object)

function GUICursor:constructor()
	self.m_Counter = 0
	self.m_CursorFunc = function(button, state)
		if self.m_CursorMode then -- is instant?
			showCursor(state == "down")
		else
			if isCursorShowing() then
				self.m_Counter = 0
				showCursor(false)
			else
				showCursor(true)
			end
		end
	end

	--[[
	if not core:get("HUD", "CursorMode", false) then
		core:set("HUD", "CursorMode", 1)
	end

	self:setCursorMode(toboolean(core:get("HUD", "CursorMode", false)))
	--]]
	self:setCursorMode(false)
end

function GUICursor:destructor()
	--setCursorAlpha(255)
	--removeEventHandler("onClientRender", root, self.m_FuncDraw)
end

function GUICursor:draw()
	local cursorX, cursorY = getCursorPosition()
	if cursorX then
		cursorX, cursorY = cursorX*screenWidth, cursorY*screenHeight
		dxDrawImage(cursorX, cursorY, 12, 20, "res/images/GUI/Cursor.png", 0, 0, 0, Color.White, true)
	end
end

function GUICursor:check()
	if self.m_Counter <= 0 then
		self.m_Counter = 0
		GUIElement.unhoverAll()

		if not getKeyState("b") then
			showCursor(false)
		end
	else
		showCursor(true)
	end
end

function GUICursor:show()
	self.m_Counter = self.m_Counter + 1
	self:check()
end

function GUICursor:hide(force)
	self.m_Counter = self.m_Counter - 1
	if force then
		self.m_Counter = 0
	end

	self:check()
end

function GUICursor:setCursorMode(instant)
	self.m_CursorMode = instant

	if instant then
		self:hide()

		--[[
		unbindKey(core:get("KeyBindings", "KeyToggleCursor", "b"), "down", self.m_CursorFunc)
		bindKey(core:get("KeyBindings", "KeyToggleCursor", "b"), "both", self.m_CursorFunc)
		--]]
		unbindKey("b", "down", self.m_CursorFunc)
		bindKey("b", "both", self.m_CursorFunc)
	else
		self:hide()

		--[[
		unbindKey(core:get("KeyBindings", "KeyToggleCursor", "b"), "both", self.m_CursorFunc)
		bindKey(core:get("KeyBindings", "KeyToggleCursor", "b"), "down", self.m_CursorFunc)
		--]]
		unbindKey("b", "both", self.m_CursorFunc)
		bindKey("b", "down", self.m_CursorFunc)
	end
end
