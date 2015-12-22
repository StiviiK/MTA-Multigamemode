-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Gamemode/Gamemode.lua
-- *  PURPOSE:     Base Gamemode class
-- *
-- ****************************************************************************
Gamemode = inherit(Object)
inherit(GamemodeElement, Gamemode)

-- pure virtual functions
Gamemode.constructor = pure_virtual
Gamemode.destructor = pure_virtual
Gamemode.onPlayerJoin = pure_virtual
Gamemode.onPlayerLeft = pure_virtual

function Gamemode:new(...)
  local inst = new(self, ...)

  self.m_Instance = inst
  return inst
end

function Gamemode:virtual_constructor(color)
  self.m_SyncInfo = {}
  self.m_SyncChangeHandler = {}
  self.m_GamemodePeds = {}
  self.m_Color = color
end

function Gamemode:virtual_destructor()
  GamemodeManager:getSingleton():removeRef(self)

  for i, v in pairs(self.m_GamemodePeds) do
    delete(v)
  end
end

function Gamemode:setId(Id)
  self.m_Id = Id

  return self
end

function Gamemode:addSyncChangeHandler(key, handler)
  self.m_SyncChangeHandler[key] = handler

  return self
end

function Gamemode:checkPassword(yesCallback, noCallback, wrongCallback)
  Camera.setMatrix(0, 0, 0, 0, 0, 0)
  PasswordBox:new(self.m_Password or self:getName(),
    function ()
      if yesCallback then
        yesCallback()
      end
      Camera.setTarget(localPlayer)
    end,
    function ()
      if noCallback then
        noCallback()
      else
        triggerServerEvent("Event_JoinGamemode", localPlayer, 1, true)
      end
      Camera.setTarget(localPlayer)
    end,
    function ()
      if wrongCallback then
        wrongCallback()
      else
        triggerServerEvent("Event_JoinGamemode", localPlayer, 1, true)
      end
      Camera.setTarget(localPlayer)
    end
  )
end

-- Short getters
function Gamemode:getId() return self.m_Id end
function Gamemode:getName() return self:getSyncInfo("Name") end
function Gamemode:getSyncInfo(key) return self.m_SyncInfo[key] end
function Gamemode:getDescription() return self:getSyncInfo("Description") end
function Gamemode:getDimension() return self:getSyncInfo("Dimension") end
function Gamemode:getColor() return self.m_Color end
function Gamemode:getInstance() return self.m_Instance end
