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

-- Short getters
function Gamemode:getId() return self.m_Id end
function Gamemode:getName() return self:getSyncInfo("Name") end
function Gamemode:getSyncInfo(key) return self.m_SyncInfo[key] end
function Gamemode:getDescription() return self:getSyncInfo("Description") end
function Gamemode:getDimension() return self:getSyncInfo("Dimension") end
function Gamemode:getColor() return self.m_Color end
