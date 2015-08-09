PlayerSession = inherit(Object)

function PlayerSession:constructor(player, isGuest)
  local isGuest = isGuest
  if not isGuest then isGuest = false end
  player.m_Session = self

  self.m_Player = player
  self:setToken(hash("sha256", ("%s%s%s"):format(player:getName(), getRealTime().timestamp, player:getIP())))
  self:updatePlayerInfo(false)

  sql:queryExec("INSERT INTO ??_sessions (`Id`, `Name`, `Token`, `IP`, `Serial`, `Valid`, `sStart`, `sEnd`, `PlayerInfo`) VALUES (NULL, ?, ?, ?, ?, '1', ?, '0', ?);", sql:getPrefix(), player:getName(), self:getToken(), player:getIP(), player:getSerial(), getRealTime().timestamp, toJSON(self:getPlayerInfo()))
  self:setId(sql:lastInsertId())
end

function PlayerSession:destructor()
  sql:queryExec("UPDATE ??_sessions SET `sEnd` = ?, `Valid` = '0' WHERE `Id` = ?;", sql:getPrefix(), getRealTime().timestamp, self:getId())
end

function PlayerSession:setId(Id)
  self.m_Id = Id
end

function PlayerSession:getId()
  return self.m_Id
end

function PlayerSession:setToken(token)
  self.m_Token = token
end

function PlayerSession:getToken()
  return self.m_Token
end

function PlayerSession:setPlayerInfo(info)
  self.m_PlayerInfo = info
end

function PlayerSession:getPlayerInfo()
  return self.m_PlayerInfo
end

function PlayerSession:updatePlayerInfo(autoUpdate)
  if autoUpdate == nil then autoUpdate = true end

  self:setPlayerInfo({
    ["username"] = self.m_Player:getName();
    ["lastUpdate"] = getRealTime().timestamp;
    ["guestSession"] = self.m_Player:isGuest();
    ["gamemode"] = self.m_Player:getGamemode() and self.m_Player:getGamemode():getId() or 0;
    ["health"] = self.m_Player:getHealth();
    ["armor"] = self.m_Player:getArmor();
    ["position"] = {x = self.m_Player:getPosition().x; y = self.m_Player:getPosition().y; z = self.m_Player:getPosition().z};
    ["rotation"] = {x = self.m_Player:getRotation().x; y = self.m_Player:getRotation().y; z = self.m_Player:getRotation().z};
    ["interior"] = self.m_Player:getInterior();
    ["dimension"] = self.m_Player:getDimension();
    ["skin"] = self.m_Player:getSkin();
  })

  if autoUpdate then
    sql:queryExec("UPDATE ??_sessions SET `PlayerInfo` = ? WHERE `Id` = ?;", sql:getPrefix(), toJSON(self:getPlayerInfo()), self:getId())
  end
end
