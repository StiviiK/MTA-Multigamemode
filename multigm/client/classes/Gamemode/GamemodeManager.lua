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
  addRemoteEvents{"onPlayerGamemodeJoin", "onPlayerGamemodeLeft", "onGamemodeDestruct", "UpdateGamemodeSync"}
  addEventHandler("onPlayerGamemodeJoin", root, bind(GamemodeManager.Event_OnPlayerGamemodeJoin, self))
  addEventHandler("onPlayerGamemodeLeft", root, bind(GamemodeManager.Event_OnPlayerGamemodeLeft, self))
  addEventHandler("onGamemodeDestruct", root, bind(GamemodeManager.Event_OnGamemodeDestruct, self))
  addEventHandler("UpdateGamemodeSync", root, bind(GamemodeManager.Event_UpdateGamemodeSync, self))

  local Gamemodes = {
    Lobby:new():setId(1);
    CopsnRobbers:new(Color.LightBlue):setId(2);
    RenegadeSquad:new(Color.Yellow):setId(3);
  }
  for k, v in pairs(Gamemodes) do
    --v:setId(k)
    self:addRef(v)

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
