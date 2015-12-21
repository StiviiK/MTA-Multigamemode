CS_GamemodeManager = inherit(Singleton)
CS_GamemodeManager.Map = {}

function CS_GamemodeManager:constructor()
local Gamemodes = {};

  -- Gamemode Sync
  self.m_SyncPulse = TimedPulse:new(500)
  self.m_SyncPulse:registerHandler(self.updateSync)
    -- Manager Events
   addRemoteEvents{"CS_Event_JoinGamemode"}
   addEventHandler("CS_Event_JoinGamemode", root, bind(CS_GamemodeManager.Event_JoinGamemode, self))
end

function CS_GamemodeManager:destructor()

end

function CS_GamemodeManager:addRef(ref,Id)
  CS_GamemodeManager.Map[Id] = ref
  return ref
end

function CS_GamemodeManager.getFromId(Id)
  return CS_GamemodeManager.Map[Id]
end

function CS_GamemodeManager:CreateNewGamemode(NewGamemode,MaxPlayer)
local NewGM_ID     = #CS_GamemodeManager.Map+1
local NewGM        = NewGamemode:new():setId(NewGM_ID)
self:addRef(NewGM,NewGM_ID)
return NewGM
end

function CS_GamemodeManager:AddPlayerCSGamemode(player,Gamemode,CS_SELF)
 if player:getGamemode() then
    player:getGamemode():removePlayer(player)
  end
Gamemode:addPlayer(player)
end

function CS_GamemodeManager:Event_JoinGamemode(Id)
outputChatBox("CS_GamemodeManager ID:"..Id)

  source:fadeCamera(true, 0.5)

  if source:getGamemode() then
    source:getGamemode():removePlayer(source)
  end

  source:fadeCamera(true, 0.75)
  self.getFromId(Id):addPlayer(source)

end

function CS_GamemodeManager:RemovePlayerCSGamemode(player,Gamemode)
Gamemode:removePlayer(player)
--Hier noch add CS_lobby
end


function CS_GamemodeManager.updateSync()
  local SyncData = {}
  for i, gamemode in pairs(CS_GamemodeManager.Map) do
    SyncData[gamemode:getId()] = {}
    for k, v in pairs(gamemode.m_SyncInfoUpdate) do
  		SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
  	end
  	gamemode.m_SyncInfoUpdate = {}
  end

  if table.size(SyncData, true) > 0 then
    for i, v in pairs(getElementsByType("player")) do -- Todo: Improve?
      if v:isClientReady() then
        v:triggerEvent("CS_UpdateGamemodeSync", v, SyncData)
      end
    end
  end
end

function CS_GamemodeManager.sendInitialSync(player)
  local SyncData = {}
  for i, gamemode in pairs(CS_GamemodeManager.Map) do
    SyncData[gamemode:getId()] = {}
    for k, v in pairs(gamemode.m_SyncInfo) do
      SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
    end
  end

  if table.size(SyncData) ~= CS_GamemodeManager.Map then
    if player then
      if player:isClientReady() then
        player:triggerEvent("CS_UpdateGamemodeSync", player, SyncData)
      end
    end
  end
end