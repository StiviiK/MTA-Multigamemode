GUICursor = inherit(Singleton)

function GUICursor:constructor()
  self.m_drawCursor = false
  self.m_ClickInfo = false
  self.m_CursorInfo = false

  self.m_ClickHook = Hook:new()
  self.m_MoveHook = Hook:new()
  self.m_ClickHook:register(bind(GUICursor.onClick, self))
  self.m_MoveHook:register(bind(GUICursor.onCursorMove, self))

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

  addEventHandler("onClientRender", root, bind(GUICursor.drawThis, self))

  bindKey("b", "down", function()
    showCursor(not isCursorShowing())
  end)
end

function GUICursor:destructor()
  delete(self.m_ClickHook)
  delete(self.m_MoveHook)
end

function GUICursor:drawThis()
  if self.m_drawCursor then
    local cx, cy = getCursorPosition()
    if cx then
      cx, cy = cx * screenX, cy * screenY
      dxDrawImage(cx-18/2, cy-32/2, 24, 24, "files/images/GUI/Mouse.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
  end
end

function GUICursor:onClick()
  -- Check for GamemodePeds
  for i, v in pairs(GamemodePedManager.Map) do
    if v.m_Ped == self.m_ClickInfo.element then
      v:dispatchClick(self.m_ClickInfo)
      break
    end
  end
end

function GUICursor:onCursorMove()
  -- Check for GamemodePeds
  for i, v in pairs(GamemodePedManager.Map) do
    if v.m_Ped == self.m_CursorInfo.element then
      self.m_drawCursor = true
      setCursorAlpha(0)
      return
    end
  end

  self.m_drawCursor = false
  setCursorAlpha(255)
end
