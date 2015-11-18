Account = inherit(Object)
Account.Map = {}

function Account.login(player, username, password)
    if player:getAccount() then return false end
  	if (not username or not password) and not pwhash then return false end

    local row = sql:asyncQueryFetchSingle("SELECT Id, PublicKey FROM ??_account WHERE Name = ? ", sql:getPrefix(), username)
    if not row or not row.Id then
  		-- Error: Invalid username
  		return false
  	end

    local row = sql:asyncQueryFetchSingle("SELECT Id, Name, Type FROM ??_account WHERE Id = ? AND Password = ?;", sql:getPrefix(), row.Id, hash("sha256", teaEncode(password, row.PublicKey)))
    if not row or not row.Id then
    	-- Error: Wrong Password
    	return false
    end

    if DatabasePlayer.getFromId(row.Id) then
      -- Error: Already in use
    	return false
  	end

    -- Update last serial and last login
  	sql:queryExec("UPDATE ??_account SET LastSerial = ?, LastLogin = NOW() WHERE Id = ?", sql:getPrefix(), player:getSerial(), row.Id)

    player.m_Account = Account:new(row.Id, row.Name, row.Type, player, false)
    player:loadCharacter()
end
addEvent("accountlogin", true)
addEventHandler("accountlogin", root, function(...) Async.create(Account.login)(client, ...) end)

--[[
CLIENT:

local password = "krassespasswort"
local PRIVATE_KEY = "mta"
triggerServerEvent("accountlogin", localPlayer, "ACCOUNT", hash("sha256", teaEncode(password, PRIVATE_KEY)))

]]

function Account.register()
end

function Account.guest(player)
  if player:getAccount() then return false end

  player.m_Account = Account:new(0, getRandomUniqueNick(), 0, player, true)
  player:loadCharacter()
end

function Account.getFromId(id)
  return Account.Map[id]
end

function Account:constructor(id, username, type, player, guest)
  -- Account Information
  self.m_Id = id
  self.m_Username = username
  self.m_Player = player
  self.m_Type = type
  player.m_Account = self
  player.m_IsGuest = guest
  player.m_Id = self:getId()

  self.m_Session = Session:new(player)

  Account.Map[self.m_Id] = self
  DatabasePlayer.Map[player:getId()] = player
end

function Account:destructor()
  Account.Map[self.m_Id] = nil
  self.m_Player.m_Account = nil

  delete(self:getSession())
  self.m_Session = nil
end

function Account:getId()
  return self.m_Id;
end

function Account:getPlayer()
  return self.m_Player
end

function Account:getName()
  return self.m_Username
end

function Account:getSession()
  return self.m_Session
end

function Account:getType()
  return self.m_Type
end