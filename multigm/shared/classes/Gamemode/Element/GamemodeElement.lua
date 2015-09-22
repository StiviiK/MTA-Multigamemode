GamemodeElement = inherit(Object)

function GamemodeElement:virtual_constructor()
  outputDebug("GamemodeElement:virtual_constructor")

  -- Todo: Find a better name
  self.ms_RootElement = Element("root")
end

function GamemodeElement:virtual_destructor()
  for i, v in pairs(self:getRoot():getChildren()) do
    if isElement(v) then
      destroyElement(v)
    end
  end
  destroyElement(self.ms_RootElement)
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
