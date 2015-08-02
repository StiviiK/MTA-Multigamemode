Gamemode = inherit(Object)

-- pure virtual functions
Gamemode.constructor = pure_virtual
Gamemode.destructor = pure_virtual
Gamemode.onPlayerJoin = pure_virtual
Gamemode.onPlayerLeft = pure_virtual

function Gamemode:virtual_constructor()
end

function Gamemode:virtual_destructor()
  GamemodeManager:getSingleton():removeRef(self)
end

function Gamemode:setId(Id)
  self.m_Id = Id
end

function Gamemode:getId()
  return self.m_Id
end
