SubGamemodeManager = inherit(Singleton)
SubGamemodeManager.Map = {}

function SubGamemodeManager:constructor()
  local SubGamemodes = {
    self:addRef(CS_Deathmath:new("Deathmatch", "Bla Bla Bla."):setId(1));
  }

  for k, v in ipairs(SubGamemodes) do
    if v.onSubGamemodesLoaded then
      v:onSubGamemodesLoaded(#SubGamemodes)
    end
  end
  self.m_LoadedSubGamemodes = #SubGamemodes

  -- Gamemode Sync
  self.m_SyncPulse = TimedPulse:new(500)
  self.m_SyncPulse:registerHandler(self.updateSync)


  -- Manager Events
  addRemoteEvents{"Sub_Event_DisableGamemode", "Sub_Event_JoinGamemode", "Sub_Event_RespawnGamemodePed", "Sub_Event_DeleteGamemodePed"}
  addEventHandler("Sub_Event_DisableGamemode", root, bind(SubGamemodeManager.Event_DisableGamemode, self))
  addEventHandler("Sub_Event_JoinGamemode", root, bind(SubGamemodeManager.Event_JoinGamemode, self))
  addEventHandler("Sub_Event_RespawnGamemodePed", root, bind(SubGamemodeManager.Event_RespawnGamemodePed, self))
  addEventHandler("Sub_Event_DeleteGamemodePed", root, bind(SubGamemodeManager.Event_DeleteGamemodePed, self))
end

function SubGamemodeManager:destructor()
  for i, v in pairs(SubGamemodeManager.Map) do
    delete(v)
  end
end

function SubGamemodeManager.getFromId(Id)
  return SubGamemodeManager.Map[Id]
end

function SubGamemodeManager:addRef(ref)
  SubGamemodeManager.Map[ref:getId()] = ref
  return ref
end

function SubGamemodeManager:removeRef(ref)
  SubGamemodeManager.Map[ref:getId()] = nil
end

function SubGamemodeManager:Event_DisableGamemode(Id)
  if source:getRank() >= RANK.Developer then
    outputDebug(("[SubGamemodeManager] %s forced Gamemode destruction! [Id: %d]"):format(source:getAccount():getName(), Id))

    delete(self.getFromId(Id))
    source:triggerEvent("successBox", source, _("Aktion erfolgreich ausgeführt!", source))
  else
    source:triggerEvent("errorBox", source, _("Zugriff verweigert.", source))
  end
end

function SubGamemodeManager:Event_JoinGamemode(Id, fLobby)
  if source:getGamemode() == self.getFromId(Id) then
    source:fadeCamera(true, 0.5)
    if fLobby ~= true then
      source:triggerEvent("errorBox", source, _("Du bist bereits in diesem Gamemode!", source))
    end
    return
  end

  if source:getGamemode() then
    source:getGamemode():removePlayer(source)
  end

  source:fadeCamera(true, 0.75)
  self.getFromId(Id):addPlayer(source)
  if fLobby ~= true then
    source:triggerEvent("successBox", source, _("Du bist dem Gamemode erfolgreich beigetreten!", source))
  end
end

function SubGamemodeManager.updateSync()
  local SyncData = {}
  for i, gamemode in pairs(SubGamemodeManager.Map) do
    SyncData[gamemode:getId()] = {}
    for k, v in pairs(gamemode.m_SyncInfoUpdate) do
  		SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
  	end
  	gamemode.m_SyncInfoUpdate = {}
  end

  if table.size(SyncData, true) > 0 then
    for i, v in pairs(getElementsByType("player")) do -- Todo: Improve?
      if v:isClientReady() then
	  outputChatBox("UpdateSubGamemodeSync")
        v:triggerEvent("UpdateSubGamemodeSync", v, SyncData)
      end
    end
  end
end

function SubGamemodeManager.sendInitialSync(player)
  local SyncData = {}
  for i, gamemode in pairs(SubGamemodeManager.Map) do
    SyncData[gamemode:getId()] = {}
    for k, v in pairs(gamemode.m_SyncInfo) do
      SyncData[gamemode:getId()][k] = gamemode.m_SyncInfo[k]
    end
  end

  if table.size(SyncData) ~= SubGamemodeManager.Map then
    if player then
      if player:isClientReady() then
        player:triggerEvent("UpdateSubGamemodeSync", player, SyncData)
      end
    end
  end
end

function SubGamemodeManager:Event_RespawnGamemodePed(Id)
  -- if source:getRank() >= RANK.Administrator then
    -- outputDebug(("[SubGamemodeManager] %s respawned GamemodePed! [Id: %d]"):format(source:getAccount():getName(), Id))

    -- triggerClientEvent("RespawnGamemodePed", source, Id)
    -- source:triggerEvent("successBox", source, _("Aktion erfolgreich ausgeführt!", source))
  -- else
    -- source:triggerEvent("errorBox", source, _("Zugriff verweigert.", source))
  -- end
end

function SubGamemodeManager:Event_DeleteGamemodePed(Id)
  -- if source:getRank() >= RANK.Administrator then
    -- outputDebug(("[SubGamemodeManager] %s deleted GamemodePed! [Id: %d]"):format(source:getAccount():getName(), Id))

    -- triggerClientEvent("DeleteGamemodePed", source, Id)
    -- source:triggerEvent("successBox", source, _("Aktion erfolgreich ausgeführt!", source))
  -- else
    -- source:triggerEvent("errorBox", source, _("Zugriff verweigert.", source))
  -- end
end
