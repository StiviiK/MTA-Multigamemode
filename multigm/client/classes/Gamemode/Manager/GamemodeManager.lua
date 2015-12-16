-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Gamemode/GamemodeManager.lua
-- *  PURPOSE:     GamemodeManager class
-- *
-- ****************************************************************************
GamemodeManager = inherit(Singleton)
GamemodeManager.Map = {}

function GamemodeManager:constructor()
  addRemoteEvents{"onPlayerGamemodeJoin", "onPlayerGamemodeLeft", "onGamemodeDestruct", "UpdateGamemodeSync", "RespawnGamemodePed", "DeleteGamemodePed"}
  addEventHandler("onPlayerGamemodeJoin", root, bind(GamemodeManager.Event_OnPlayerGamemodeJoin, self))
  addEventHandler("onPlayerGamemodeLeft", root, bind(GamemodeManager.Event_OnPlayerGamemodeLeft, self))
  addEventHandler("onGamemodeDestruct", root, bind(GamemodeManager.Event_OnGamemodeDestruct, self))
  addEventHandler("UpdateGamemodeSync", root, bind(GamemodeManager.Event_UpdateGamemodeSync, self))
  addEventHandler("RespawnGamemodePed", root, bind(GamemodeManager.Event_RespawnGamemodePed, self))
  addEventHandler("DeleteGamemodePed", root, bind(GamemodeManager.Event_DeleteGamemodePed, self))

  local Gamemodes = {
    self:addRef(Lobby:new(Color.Orange):setId(1));
    self:addRef(CopsnRobbers:new(Color.Green):setId(2));
    self:addRef(RenegadeSquad:new(Color.Yellow):setId(3));
    self:addRef(SuperS:new(Color.LightBlue):setId(4));
  }
  for k, v in ipairs(Gamemodes) do
    if v.onGamemodesLoaded then
      v:onGamemodesLoaded(#Gamemodes)
    end
  end
end

function GamemodeManager:destructor()
  for i, v in pairs(GamemodeManager.Map) do
    delete(v)
  end
end

function GamemodeManager.getFromId(Id)
  return GamemodeManager.Map[Id]
end

function GamemodeManager:addRef(ref)
  GamemodeManager.Map[ref:getId()] = ref
  return ref
end

function GamemodeManager:removeRef(ref)
  GamemodeManager.Map[ref:getId()] = nil
end

function GamemodeManager:Event_OnPlayerGamemodeJoin(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    gamemode:onPlayerJoin(source)
  end
end

function GamemodeManager:Event_OnPlayerGamemodeLeft(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    gamemode:onPlayerLeft(source)
  end
end

function GamemodeManager:Event_OnGamemodeDestruct(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    delete(gamemode)
  end
end

function GamemodeManager:Event_UpdateGamemodeSync(SyncInfo)
  for Id, data in pairs(SyncInfo) do
    local gamemode = self.getFromId(Id)
    if gamemode then
      for k, v in pairs(data or {}) do
        gamemode.m_SyncInfo[k] = v

        local f = gamemode.m_SyncChangeHandler[k]
        if f then f(v) end
      end
    end
  end
end

function GamemodeManager:Event_RespawnGamemodePed(Id)
  if GamemodePedManager.getFromId(Id) then
    local instance = GamemodePedManager.getFromId(Id)
    local m, p, r, d, i, g, c = instance:getModel(), instance:getPosition(), instance:getRotation(), instance:getDimension(), instance:getInterior(), instance:getGamemode(), instance:getCustomColor()

    delete(instance)
    self.getFromId(1).m_GamemodePeds[Id] = nil

    instance = GamemodePed:new(m, p, r, d, i, g, c)
    self.getFromId(1).m_GamemodePeds[instance:getId()] = instance
  end
end

function GamemodeManager:Event_DeleteGamemodePed(Id)
  if GamemodePedManager.getFromId(Id) then
    delete(GamemodePedManager.getFromId(Id))
  end
end
