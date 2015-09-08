GamemodeManager = inherit(Singleton)
GamemodeManager.Map = {}

function GamemodeManager:constructor()
  local Gamemodes = {
    Lobby:new("Lobby", "This is the Lobby.")
  }
  for k, v in pairs(Gamemodes) do
    v:setId(k)
    self:addRef(v)
  end

  -- Manager Events
  addRemoteEvents{"Event_DisableGamemode", "Event_JoinGamemode"}
  addEventHandler("Event_DisableGamemode", root, bind(self.Event_DisableGamemode, self))
  addEventHandler("Event_JoinGamemode", root, bind(self.Event_JoinGamemode, self))
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

function GamemodeManager:Event_DisableGamemode(Id)
  if source:getRank() >= RANK.Developer then
    delete(self.getFromId(Id))

    source:triggerEvent("successBox", source, "Action completed successfully!")
  else
    source:triggerEvent("errorBox", source, "Permission denied.")
  end
end

function GamemodeManager:Event_JoinGamemode(Id)
  if source:getGamemode() == self.getFromId(Id) then
    source:triggerEvent("errorBox", source, "You are already in this Gamemode!")
    return
  end

  if source:getGamemode() then
    source:getGamemode():removePlayer(source)
  end

  self.getFromId(Id):addPlayer(source)
  source:triggerEvent("successBox", source, "Gamemode joined successfully!")
end
