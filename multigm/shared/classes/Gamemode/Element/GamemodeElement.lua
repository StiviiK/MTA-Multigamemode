GamemodeElement = inherit(Object)

function GamemodeElement:virtual_constructor()
  self.ms_RootElement = Root:new()
end

function GamemodeElement:virtual_destructor()
  delete(self.ms_RootElement)
end

-- Elements creation
function GamemodeElement:createVehicle(...)
  local veh = Vehicle(...)
  veh:setParent(self:getRoot())

  return veh
end

function GamemodeElement:createPed(...)
  local ped = Ped(...)
  ped:setParent(self:getRoot())

  return ped
end

-- Short getters
function GamemodeElement:getRootElement() return self.ms_RootElement end
function GamemodeElement:getRoot() return self:getRootElement() end
