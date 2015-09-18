DatabasePlayer = inherit(Object)
DatabasePlayer.Map = {}

function DatabasePlayer.get(id)
	-- Second return determines whether the account is offline
	if DatabasePlayer.Map[id] then
		return DatabasePlayer.Map[id], not isElement(DatabasePlayer.Map[id])
	end

	return DatabasePlayer:new(id), true
end

function DatabasePlayer.getFromId(id)
  return DatabasePlayer.Map[id]
end

function DatabasePlayer:constructor(id)
	assert(id)
	DatabasePlayer.virtual_constructor(self)

	self.m_Id = id
	DatabasePlayer.Map[id] = self
end

function DatabasePlayer:destructor()
	self:save()
end

function DatabasePlayer:virtual_constructor()
  self.m_Account  = false
  self.m_IsGuest  = false
	self.m_Locale   = "en"
	self.m_Id       = -1
	self.m_Health   = 100
	self.m_Armor    = 0
  self.m_Skin     = 0
	self.m_XP 	    = 0
  self.m_Money    = 0
	self.m_Gamemode = nil
	self.m_Rank 		= 0
end

function DatabasePlayer:virtual_destructor()
	if self.m_Id > 0 then
		DatabasePlayer.Map[self.m_Id] = nil
	end
end

function DatabasePlayer:load()
  if self:isGuest() then
    return false
  end
  DatabasePlayer.Map[self.m_Id] = self

  local row = sql:queryFetchSingle("SELECT Locale, Skin, XP, Money, Rank FROM ??_character WHERE Id = ?;", sql:getPrefix(), self:getId())
	if not row then
		return false
	end

	-- Set non element related stuff (otherwise just save it)
	self:setLocale(row.Locale)
	self:setXP(row.XP)
	self:setSkin(row.Skin)
  self:setMoney(row.Money)
	self:setRank(row.Rank)
end

function DatabasePlayer:save()
	if self:isGuest() then
		return false
	end

  return sql:queryExec("UPDATE ??_character SET Locale=?, Skin=?, XP=?, Money=?, Rank=? WHERE Id=?;", sql:getPrefix(), self:getLocale(), self:getSkin(), self:getXP(), self:getMoney(), self:getRank(), self:getId())
end

function DatabasePlayer:loadGuest()
	-- Reset data to Sync it
	self:setLocale(self.m_Locale)
	self:setXP(self.m_XP)
	self:setMoney(self.m_Money)
	self:setRank(self.m_Rank)
end

-- Short getters
function DatabasePlayer:isActive() return false end
function DatabasePlayer:isGuest() return self.m_IsGuest end
function DatabasePlayer:getId() return self.m_Id end
function DatabasePlayer:getSkin() return self.m_Skin end
function DatabasePlayer:getMoney() return self.m_Money end
function DatabasePlayer:getLocale() return self.m_Locale end
function DatabasePlayer:getXP() return self.m_XP end
function DatabasePlayer:getRank() return self.m_Rank end

-- Short setters
function DatabasePlayer:setSkin(Id) self.m_Skin = Id if self:isActive() then self:setModel(self.m_Skin) end end
function DatabasePlayer:setMoney(money) self.m_Money = money if self:isActive() then self:setPrivateSync("Money", self.m_Money) end end
function DatabasePlayer:setLocale(locale) self.m_Locale = locale if self:isActive() then self:setPublicSync("Locale", self.m_Locale) end end
function DatabasePlayer:setXP(XP) self.m_XP = xp if self:isActive() then self:setPrivateSync("XP", self.m_XP) end end
function DatabasePlayer:setRank(rank) self.m_Rank = rank if self:isActive() then self:setPrivateSync("Rank", self.m_Rank) end end
