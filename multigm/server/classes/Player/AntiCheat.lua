AntiCheat = inherit(Singleton)

function AntiCheat:constructor()
  -- Add remote Events
  addRemoteEvents{"AntiCheat:Event_CheckPlayer"}
  addEventHandler("AntiCheat:Event_CheckPlayer", root, bind(AntiCheat.Event_CheckPlayer, self))

  self.m_IgnoredPlayers = {}
  self.m_CheckPlayersPule = TimedPulse:new(1000*60*15)
  self.m_CheckPlayersPule:registerHandler(bind(AntiCheat.checkPlayer, self))
end

function AntiCheat:destructor()
  delete(self.m_CheckPlayersPule)
end

function AntiCheat:ignorePlayer(player)
  table.insert(self.m_IgnorePlayers, player)
end

function AntiCheat:report(offense, player)
  outputServerLog(("AntiCheat:report(%s, %s, %i)"):format(player:getName(), offense.Name, offense.Severity))
  player:triggerEvent("warningBox", player, ("AntiCheat violation detected!\nName: %s\nSeverity: %s"):format(offense.Name, CheatSeverity[offense.Severity]))
  if offense.Severity >= CheatSeverity.High then
    -- TODO: Count High+ violations for Kick, Ban, etc.
  end

  sql:queryExec("INSERT INTO ??_cheatlog (UserId, Name, Severity, SessionId, SessionToken) VALUES(?, ?, ?, ?, ?)", sql:getPrefix(), player:getId(), offense.Name, offense.Severity, player:getSession():getId(), player:getSession():getToken())
end

-- AnitCheat Check Methods
function AntiCheat:checkPlayer(player)
  if player and isElement(player) then
    if not self.m_IgnoredPlayers[player] then
      if player:isLoggedIn() then
        player:triggerEvent("AntiCheat:Event_RequestData", player)
      end
    end
  else
    for i, v in pairs(Element.getAllByType("player")) do
      if not self.m_IgnoredPlayers[v] then
        if v:isLoggedIn() then
          v:triggerEvent("AntiCheat:Event_RequestData", v)
        end
      end
    end
  end
end

function AntiCheat:Event_CheckPlayer(data)
  -- Calculate Position desync
  -- When the Player is jumping the desync is very high! (TODO: Find a propper method to check if the player is jumping)
  if source:isOnGround() then
    if data.Position then
      outputDebug((Vector3(unpack(data.Position)) - source:getPosition()).length)
      if (Vector3(unpack(data.Position)) - source:getPosition()).length > 1 then
        self:report(CheatOffense.PositionDesync, source)
      end
    else
      self:report(CheatOffense.FakeData, source)
    end
    if data.Rotation then
      outputDebug((Vector3(unpack(data.Rotation)) - source:getRotation()).length)
      if (Vector3(unpack(data.Rotation)) - source:getRotation()).length > 1 then
        self:report(CheatOffense.RotationDesync, source)
      end
    else
      self:report(CheatOffense.FakeData, source)
    end
  end
end
