-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Gamemode/GamemodePedManager.lua
-- *  PURPOSE:     GamemodePedManager class
-- *
-- ****************************************************************************
GamemodePedManager = inherit(Singleton)
GamemodePedManager.Map = {}

function GamemodePedManager:constructor()
  self.m_renderThis = bind(GamemodePedManager.drawThis, self)
  addEventHandler("onClientRender", root, self.m_renderThis)
end

function GamemodePedManager:destructor()
  for i, v in pairs(GamemodePedManager.Map) do
    delete(v)
  end

  removeEventHandler("onClientRender", root, self.m_renderThis)
end

function GamemodePedManager:addRef(ref)
  return table.push(GamemodePedManager.Map, ref)
end

function GamemodePedManager:removeRef(ref)
  GamemodePedManager.Map[ref:getId()] = nil
end

function GamemodePedManager.getFromId(Id)
  return GamemodePedManager.Map[Id]
end

function GamemodePedManager:drawThis()
  for i, v in pairs(GamemodePedManager.Map) do
    v.m_Ped:setHealth(1000)
  end
end
