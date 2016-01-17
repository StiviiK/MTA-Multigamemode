SubGamemode = inherit(Object)
inherit(GamemodeElement, SubGamemode)

-- pure virtual functions
SubGamemode.constructor = pure_virtual
SubGamemode.destructor = pure_virtual
SubGamemode.onPlayerJoin = pure_virtual
SubGamemode.onPlayerLeft = pure_virtual

function SubGamemode:new(...)
  local inst = new(self, ...)

  self.m_Instance = inst
  return inst
end

function SubGamemode:virtual_constructor(color)
  self.m_SyncInfo = {}
  self.m_SyncChangeHandler = {}
  self.m_SubGamemodePeds = {}
  self.m_Color = color
end

function SubGamemode:virtual_destructor()
  SubGamemodeManager:getSingleton():removeRef(self)

  for i, v in pairs(self.m_SubGamemodePeds) do
    delete(v)
  end
end

function SubGamemode:setId(Id)
  self.m_Id = Id

  return self
end

function SubGamemode:addSyncChangeHandler(key, handler)
  self.m_SyncChangeHandler[key] = handler

  return self
end

-- Short getters
function SubGamemode:getId() 		  return self.m_Id end
function SubGamemode:getName() 		  return self:getSyncInfo("Name") end
function SubGamemode:getSyncInfo(key) return self.m_SyncInfo[key] end
function SubGamemode:getDescription() return self:getSyncInfo("Description") end
function SubGamemode:getDimension()   return self:getSyncInfo("Dimension") end
function SubGamemode:getColor() 	  return self.m_Color end
function SubGamemode:getInstance()    return self.m_Instance end
