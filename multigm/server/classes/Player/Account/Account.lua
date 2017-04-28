Account = inherit(Object)
Account.Map = {}

function Account.login(player, username, password)
	if player:getAccount() then return false end
	if (not username or not password) then return false end

	if not username:match("^[a-zA-Z0-9_.%[%]]*$") then
		--player:triggerEvent("loginfailed", "Ungültiger Nickname. Bitte melde dich bei einem Admin!")
		outputDebug("Ungültiger Nickname. Bitte melde dich bei einem Admin!")
		return false
	end

	-- Ask SQL to fetch ForumID
	vrp:queryFetchSingle(Async.waitFor(self), ("SELECT Id, ForumID, Name, RegisterDate FROM ??_account WHERE %s = ?"):format(username:find("@") and "email" or "Name"), vrp:getPrefix(), username)
	local row = Async.wait()
	if not row or not row.Id then
		--player:triggerEvent("loginfailed", "Fehler: Spieler nicht gefunden!")

		-- NO VRP Account!
		outputDebug("Fehler: Spieler nicht gefunden!")
		return
	end

	local Id = row.Id
	local ForumID = row.ForumID
	local Username = row.Name
	local RegisterDate = row.RegisterDate

	-- Ask SQL to fetch the password from forum
	board:queryFetchSingle(Async.waitFor(self), "SELECT password, registrationDate FROM wcf1_user WHERE userID = ?", ForumID)
	local row = Async.wait()
	if not row or not row.password then
		--player:triggerEvent("loginfailed", "Fehler: Falscher Name oder Passwort") -- "Error: Invalid username or password"
		outputDebug("Fehler: Falscher Name oder Passwort")
		return false
	end

	if false --[[pwhash]] then
		if pwhash == row.password then
			Account.loginSuccess(player, Id, Username, ForumID, RegisterDate, pwhash)
		else
			player:triggerEvent("loginfailed", "Fehler: Falscher Name oder Passwort") -- Error: Invalid username or password2
			return false
		end
	else
		local param = {["userId"] = ForumID; ["password"] = password;}
		local data, errno = Account.asyncCallAPI("checkPassword", toJSON(param))
		if errno == 0 then
			local returnData = fromJSON(data)
			if not returnData then outputConsole(data, player) return end
			if returnData.error then
				--player:triggerEvent("loginfailed", "Fehler: "..returnData.error)
				outputDebug("Fehler: "..returnData.error)
				return false
			end
			if returnData.login == true then
				--Account.loginSuccess(player, Id, Username, ForumID, RegisterDate, row.password)
				sql:queryFetchSingle(Async.waitFor(self), "SELECT * FROM ??_character WHERE Id = ?", sql:getPrefix(), Id)
				local row = Async.wait()
				if not row then
					Account.createCharacter(Id)
				end

				player.m_Account = Account:new(Id, Username, ACCOUNTTYPE.GOD, player, false)
    			player:loadCharacter()
				outputDebug("LOGIN SUCCESS!")
			else
				--player:triggerEvent("loginfailed", "Fehler: Unbekannter Fehler")
				outputDebug("Fehler: Unbekannter Fehler")
			end
		else
			outputDebugString("Error@FetchRemote: "..errno)
		end
	end

    --player.m_Account = Account:new(row.Id, row.Name, row.Type, player, false)
    --player:loadCharacter()
end
RPC:registerFunc("accountlogin", Async.create(Account.login))
--addEvent("accountlogin", true)
--addEventHandler("accountlogin", root, function(...) Async.create(Account.login)(client, ...) end)

--[[
CLIENT:

local password = "krassespasswort"
local PRIVATE_KEY = "mta"
triggerServerEvent("accountlogin", localPlayer, "ACCOUNT", hash("sha256", teaEncode(password, PRIVATE_KEY)))

drun Async.create(function () Account.login(getRandomPlayer(), "StiviK", hash("sha256", teaEncode("krassespasswort", "mta"))) end)()
]]

--[[
function Account.register(player, accountname, password)
	if player:getAccount() then return false end
	if (not accountname or not password) then return false end

	-- Check for existing Account
	local row = sql:asyncQueryFetchSingle("SELECT Id FROM ??_account WHERE Name = ?;", sql:getPrefix(), accountname)
	if row then
	-- Error: Account exists already
		return false
	end

	-- Create Account
	local PublicKey = genPublicKey(player, accountname)
	sql:queryExec("INSERT INTO ??_account (Name, PublicKey, Password, Type) VALUES (?, ?, ?, 0);", sql:getPrefix(), accountname, PublicKey, hash("sha256", teaEncode(password, PublicKey)))

	-- Fetch Account Id
	local Id = sql:lastInsertId()

	-- Create Character
	sql:queryExec("INSERT INTO ??_character (Id, Rank, Locale, Skin, XP, Money, PlayTime) VALUES (?, ?, 'en', 0, 0, 1, 0);", sql:getPrefix(), Id, RANK.User)

	-- Create FriendId
	local FriendId = genFriendId(Id, accountname)
	sql:queryExec("INSERT INTO ??_friends (Id, Name, Friends) VALUES (?, ?, '[ [ ] ]');", sql:getPrefix(), FriendId, accountname)
	sql:queryExec("UPDATE ??_character SET FriendId = ? WHERE Id = ?;", sql:getPrefix(), FriendId, Id)

	-- Log into the Account
	return Account.login(player, accountname, password)
end
RPC:registerFunc("accountregister", function (client, ...) Async.create(Account.register)(client, ...) end)
--addEvent("accountregister", true)
--addEventHandler("accountregister", root, function (...) Async.create(Account.register)(client, ...) end)


CLIENT: (client sends already hashed (with PRIVATE_KEY) password!)

local password = "krassespasswort"
local PRIVATE_KEY = "mta"
triggerServerEvent("accountregister", localPlayer, "ACCOUNT", hash("sha256", teaEncode(password, PRIVATE_KEY)))
--]]

function Account.guest(player)
	if player:getAccount() then return false end

	player.m_Account = Account:new(0, getRandomUniqueNick(), 0, player, true)
	player:loadCharacter()
end

function Account.getFromId(id)
	return Account.Map[id]
end

function Account.createCharacter(id)
	-- Create Character
	sql:queryExec("INSERT INTO ??_character (Id, Rank, Locale, Skin, XP, Money, PlayTime) VALUES (?, ?, 'en', 0, 0, 1, 0);", sql:getPrefix(), id, RANK.User)

	-- Create FriendId
	--local FriendId = genFriendId(id, accountname)
	--sql:queryExec("INSERT INTO ??_friends (Id, Name, Friends) VALUES (?, ?, '[ [ ] ]');", sql:getPrefix(), FriendId, accountname)
	--sql:queryExec("UPDATE ??_character SET FriendId = ? WHERE Id = ?;", sql:getPrefix(), FriendId, id)
end

function Account:constructor(id, username, type, player, guest)
	-- Account Information
	self.m_Id = id
	self.m_Username = username
	self.m_Player = player
	outputDebug(type)
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

function Account.asyncCallAPI(func, postData)
	fetchRemote(("https://exo-reallife.de/ingame/userApi/api.php?func=%s"):format(func), 1, Async.waitFor(), postData, false)
	return Async.wait()
end
