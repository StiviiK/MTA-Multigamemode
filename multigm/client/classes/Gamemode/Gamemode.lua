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

function Gamemode:virtual_constructor(name)
  self.m_Name = name
  self.m_GamemodePeds = {}
end

function Gamemode:virtual_destructor()
  GamemodeManager:getSingleton():removeRef(self)

  for i, v in pairs(self.m_GamemodePeds) do
    delete(v)
  end
end

function Gamemode:setId(Id)
  self.m_Id = Id
end

function Gamemode:getId()
  return self.m_Id
end

-- Short getters
function Gamemode:getName() return self.m_Name end
