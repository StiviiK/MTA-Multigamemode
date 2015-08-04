GUICursor = inherit(Singleton)

function GUICursor:constructor()
  self.m_ClickInfo = false
  self.m_CursorInfo = false
  self.m_ClickHook = Hook:new()
  self.m_MoveHook = Hook:new()

  addEventHandler("onClientClick", root,
    function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, element)
      if state == "up" then
        self.m_ClickInfo = {button = button, absoluteX = absoluteX, absoluteY = absoluteY, element = element}
        self.m_ClickHook:call(self.m_ClickInfo)
      end
    end
  )

  addEventHandler("onClientCursorMove", root,
    function(cursorX, cursorY, absX, absY, worldX, worldY, worldZ)
      self.m_CursorInfo = {buttonLeft = getKeyState("mouse1"), buttonRight = getKeyState("mouse2"), absoluteX = absX, absoluteY = absY, element = getElementBehindCursor(worldX, worldY, worldZ)}
      self.m_MoveHook:call(self.m_CursorInfo)
    end
  )
end

function GUICursor:destructor()
  delete(self.m_ClickHook)
  delete(self.m_MoveHook)
end
