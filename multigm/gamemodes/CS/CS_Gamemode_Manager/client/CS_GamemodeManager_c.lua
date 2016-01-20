CS_GamemodeManager = inherit(Singleton)
CS_GamemodeManager.Map = {}

function CS_GamemodeManager:constructor()
  addRemoteEvents{"CS_onPlayerGamemodeJoin", "CS_onPlayerGamemodeLeft", "CS_onGamemodeDestruct", "CS_UpdateGamemodeSync"}
  addEventHandler("CS_onPlayerGamemodeJoin", root, bind(CS_GamemodeManager.Event_OnPlayerGamemodeJoin, self))
  addEventHandler("CS_onPlayerGamemodeLeft", root, bind(CS_GamemodeManager.Event_OnPlayerGamemodeLeft, self))
  addEventHandler("CS_onGamemodeDestruct", root, bind(CS_GamemodeManager.Event_OnGamemodeDestruct, self))
  addEventHandler("CS_UpdateGamemodeSync", root, bind(CS_GamemodeManager.Event_UpdateGamemodeSync, self))


  local Gamemodes = {
	self:addRef(CS_Deathmath   :new():setId(1 +SUBGAMEMODE));
	self:addRef(CS_DEMOLITION  :new():setId(2 +SUBGAMEMODE));
	self:addRef(CS_BOMB_DEFUSAL:new():setId(3 +SUBGAMEMODE));
  }
end

function CS_GamemodeManager:destructor()
  for i, v in pairs(CS_GamemodeManager.Map) do
    delete(v)
  end
end

function CS_GamemodeManager.getFromId(Id)
  return CS_GamemodeManager.Map[Id]
end

function CS_GamemodeManager:addRef(ref)
  CS_GamemodeManager.Map[#CS_GamemodeManager.Map+1] = ref
  return ref
end

function CS_GamemodeManager:removeRef(ref)
  CS_GamemodeManager.Map[ref:getId()] = nil
end

function CS_GamemodeManager:Event_OnPlayerGamemodeJoin(Id)
	if source:getGamemode() == CS:getInstance() then
	  local gamemode = self.getFromId(Id)
	  if gamemode then
		gamemode:onPlayerJoin(source)
	  end
	end
end

function CS_GamemodeManager:Event_OnPlayerGamemodeLeft(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    gamemode:onPlayerLeft(source)
  end
end

function CS_GamemodeManager:Event_OnGamemodeDestruct(Id)
  local gamemode = self.getFromId(Id)
  if gamemode then
    delete(gamemode)
  end
end

function CS_GamemodeManager:Event_UpdateGamemodeSync(SyncInfo)
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


