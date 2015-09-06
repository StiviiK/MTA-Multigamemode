-- ****************************************************************************
-- *
-- *  PROJECT:     vRoleplay
-- *  FILE:        client/classes/GUI/GUIWebView.lua
-- *  PURPOSE:     GUI webview wrapper class (better integration)
-- *
-- ****************************************************************************
GUIWebView = inherit(GUIElement)

function GUIWebView:constructor(posX, posY, width, height, url, transparent, parent)
    GUIElement.constructor(self, posX, posY, width, height, parent)

    self.m_IsLocal = url:sub(0, 7) ~= "http://" and url:sub(0, 8) ~= "https://"
    self.m_Browser = Browser.create(width, height, self.m_IsLocal, transparent)
    self.m_PauseOnHide = true

    self.m_CursorMoveFunc = bind(self.onCursorMove, self)
    self.m_UpdateFunc = bind(self.update, self)
    addEventHandler("onClientCursorMove", root, self.m_CursorMoveFunc)
    addEventHandler("onClientPreRender", root, self.m_UpdateFunc)
    addEventHandler("onClientBrowserCreated", self.m_Browser, function() source:loadURL(url) end)
    addEventHandler("onClientBrowserDocumentReady", self.m_Browser, function(...) if self.onDocumentReady then self:onDocumentReady(...) end end)
    addEventHandler("onClientBrowserInputFocusChanged", self.m_Browser, function(gainedFocus) guiSetInputEnabled(gainedFocus) end)
end

function GUIWebView:destructor()
    removeEventHandler("onClientCursorMove", root, self.m_CursorMoveFunc)
    removeEventHandler("onClientPreRender", root, self.m_UpdateFunc)
    self.m_Browser:destroy()

    GUIElement.destructor(self)
end

function GUIWebView:drawThis()
    dxDrawImage(self.m_AbsoluteX, self.m_AbsoluteY, self.m_Width, self.m_Height, self.m_Browser)
end

function GUIWebView:update()
    -- Request redraw
    self:anyChange()
end

function GUIWebView:setVisible(state, ...)
    -- TODO: Looks like this function is never called?
    if self.m_PauseOnHide then
        self.m_Browser:setRenderingPaused(not state)
    end

    GUIElement.setVisible(self, state, ...)
end

function GUIWebView:getUnderlyingBrowser()
    return self.m_Browser
end

function GUIWebView:callEvent(eventName, ...)
    local code = ("mtatools._callEvent('%s', '%s')"):format(eventName, toJSON({...}))
    return self.m_Browser:executeJavascript(code)
end

function GUIWebView:onInternalLeftClick()
    self.m_Browser:focus()
    guiSetInputEnabled(true)

    self.m_Browser:injectMouseUp("left")
end

function GUIWebView:onInternalLeftClickDown()
    self.m_Browser:injectMouseDown("left")
end

function GUIWebView:onInternalRightClick()
    self.m_Browser:injectMouseUp("right")
end

function GUIWebView:onInternalRightClickDown()
    self.m_Browser:injectMouseDown("right")
end

function GUIWebView:onInternalMouseWheelDown()
    self.m_Browser:injectMouseWheel(-20, 0)
end

function GUIWebView:onInternalMouseWheelUp()
    self.m_Browser:injectMouseWheel(20, 0)
end

function GUIWebView:onCursorMove(relX, relY, absX, absY)
    if not isCursorShowing() then
        return
    end

    local guiX, guiY = self:getPosition(true)
    self.m_Browser:injectMouseMove(absX - guiX, absY - guiY)
end

function GUIWebView:setPausingOnHide(state)
    self.m_PauseOnHide = state
    return self
end

function GUIWebView:isPausingOnHide()
    return self.m_PauseOnHide
end
