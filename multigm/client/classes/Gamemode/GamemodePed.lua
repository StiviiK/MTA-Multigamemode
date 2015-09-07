-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Gamemode/GamemodePed.lua
-- *  PURPOSE:     Base GamemodePed class
-- *
-- ****************************************************************************
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

  if self.m_Gamemode.m_GamemodePeds then
    table.insert(self.m_Gamemode.m_GamemodePeds, self.m_Id, self)
  end
end

function GamemodePed:destructor()
  if isElement(self.m_Ped) then
    destroyElement(self.m_Ped)
  end

  GamemodePedManager:getSingleton():removeRef(self)

  if self.m_Gamemode.m_GamemodePeds then
    self.m_Gamemode.m_GamemodePeds[self:getId()] = nil
  end
end

function GamemodePed:getId()
  return self.m_Id
end

function GamemodePed:getPosition()
  return self.m_Position
end

function GamemodePed:getRotation()
  return self.m_Rotation
end

function GamemodePed:getGamemode()
  return self.m_Gamemode
end

function GamemodePed:getModel()
  return self.m_Model
end
