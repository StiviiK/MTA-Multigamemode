GamemodeElement = inherit(Object)

function GamemodeElement:virtual_constructor()
  outputDebug("GamemodeElement:virtual_constructor")

  -- Todo: Find a better name
  self.ms_RootElement = Element(("DummyRoot-%s"):format(self:getName()))
  self.ms_Elements = {}
end

function GamemodeElement:virtual_destructor()
  for i, v in pairs(self.ms_Elements) do
    destroyElement(v)
  end
  destroyElement(self.ms_RootElement)
end

-- Elements creation
function GamemodeElement:createVehicle(...)
  local veh = Vehicle(...)
  veh:setParent(self:getRoot())

  table.insert(self.ms_Elements, veh)
  return veh
end

-- Short getters
function GamemodeElement:getRootElement() return self.ms_RootElement end
function GamemodeElement:getRoot() return self:getRootElement() end
