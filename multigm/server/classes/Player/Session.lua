Session = inherit(Object)

function Session:constructor(player)
  self.m_Player = player
  self:setToken(hash("md5", ("%s%s%s"):format(player:getAccount():getName(), getRealTime().timestamp, player:getIP())))

  sql:queryExec("INSERT INTO ??_sessions (`Id`, `Name`, `Token`, `IP`, `Serial`, `Valid`, `sStart`, `sEnd`) VALUES (NULL, ?, ?, ?, ?, '1', ?, '0');", sql:getPrefix(), player:getName(), self:getToken(), player:getIP(), player:getSerial(), getRealTime().timestamp)
  self:setId(sql:lastInsertId())
  self:update()

  self.m_Player:setPrivateSync("SessionToken", self:getToken())
end

function Session:destructor()
  sql:queryExec("UPDATE ??_sessions SET `sEnd` = ?, `Valid` = '0' WHERE `Id` = ?;", sql:getPrefix(), getRealTime().timestamp, self:getId())
end

function Session:setId(Id)
  self.m_Id = Id
end

function Session:getId()
  return self.m_Id
end

function Session:getPlayer()
  return self.m_Player
end

function Session:setToken(token)
  self.m_Token = token
end

function Session:getToken()
  return self.m_Token
end

function Session:setPlayerInfo(info)
  self.m_PlayerInfo = info
end

function Session:getPlayerInfo()
  return self.m_PlayerInfo
end

function Session:update()
  self:setPlayerInfo({
    ["username"] = self.m_Player:getName();
    ["accountname"] = self.m_Player:getAccount():getName();
    ["lastUpdate"] = getRealTime().timestamp;
    ["guestSession"] = self.m_Player:isGuest();
    ["gamemode"] = (self.m_Player:getGamemode() and self.m_Player:getGamemode():getId()) or 0;
    ["health"] = self.m_Player:getHealth();
    ["armor"] = self.m_Player:getArmor();
    ["position"] = {x = self.m_Player:getPosition().x; y = self.m_Player:getPosition().y; z = self.m_Player:getPosition().z};
    ["rotation"] = {x = self.m_Player:getRotation().x; y = self.m_Player:getRotation().y; z = self.m_Player:getRotation().z};
    ["interior"] = self.m_Player:getInterior();
    ["dimension"] = self.m_Player:getDimension();
    ["skin"] = self.m_Player:getSkin();
    ["onlineSince"] = self.m_Player:getJoinTime();
    ["locale"] = self.m_Player:getLocale();
  })
  self.m_Player:setPrivateSync("SessionInfo", self:getPlayerInfo())

  sql:queryExec("UPDATE ??_sessions SET `PlayerInfo` = ? WHERE `Id` = ?;", sql:getPrefix(), toJSON(self:getPlayerInfo(), true), self:getId())
end
