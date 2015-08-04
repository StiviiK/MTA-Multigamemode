GamemodeManager = inherit(Singleton)
GamemodeManager.Map = {}

function GamemodeManager:constructor()
  addRemoteEvents{"onPlayerGamemodeJoin", "onPlayerGamemodeLeft"}
  addEventHandler("onPlayerGamemodeJoin", root, bind(GamemodeManager.Event_OnPlayerGamemodeJoin, self))
  addEventHandler("onPlayerGamemodeLeft", root, bind(GamemodeManager.Event_OnPlayerGamemodeLeft, self))

  local Gamemodes = {
    Lobby:new()
  }
  for k, v in pairs(Gamemodes) do
    v:setId(k)
    self:addRef(v)
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
  if self.getFromId(Id) then
    self.getFromId(Id):onPlayerJoin(source)
  end
end

function GamemodeManager:Event_OnPlayerGamemodeLeft(Id)
  if self.getFromId(Id) then
    self.getFromId(Id):onPlayerLeft(source)
  end
end