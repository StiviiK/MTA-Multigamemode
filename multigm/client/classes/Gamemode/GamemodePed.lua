GamemodePed = inherit(Object)

function GamemodePed:constructor(model, position, rotation, dimension, gamemode)
  self.m_Id = GamemodePedManager:getSingleton():addRef(self)
  self.m_Model = model
  self.m_Position = position
  self.m_Rotation = rotation
  self.m_Dimension = dimension
  self.m_Gamemode = gamemode

  self.m_Ped = Ped.create(self.m_Model, self.m_Position)
  self.m_Ped:setDimension(self.m_Dimension)
  self.m_Ped:setRotation(self.m_Rotation)

  self.m_Ped:setFrozen(true)
end

function GamemodePed:destructor()
  if isElement(self.m_Ped) then
    destroyElement(self.m_Ped)
  end
end

function GamemodePed:getId()
  return self.m_Id
end

function GamemodePed:getPosition()
  return self.m_Position
end

function GamemodePed:dispatchClick(info)
  outputTable(info)
end

--[[
GamemodePed:new(0, Vector3(0, 0, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, GamemodeManager.getFromId(1))
GamemodePed:new(134, Vector3(0, 3, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, GamemodeManager.getFromId(1))
GamemodePed:new(12, Vector3(3, 3, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, GamemodeManager.getFromId(1))
GamemodePed:new(126, Vector3(3, 0, 3), Vector3(0, 0, 0), PRIVATE_DIMENSION_SERVER, GamemodeManager.getFromId(1))
]]
