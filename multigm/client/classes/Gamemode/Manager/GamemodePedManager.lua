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
end

function GamemodePedManager:destructor()
  for i, v in pairs(GamemodePedManager.Map) do
    delete(v)
  end
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
