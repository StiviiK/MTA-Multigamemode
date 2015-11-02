SQL = inherit(Object)

function SQL:virtual_constructor()
	self.m_Async = true
end

function SQL:destructor()
	if self.m_DBHandle then
		destroyElement(self.m_DBHandle)
	end
end

function SQL:queryExec(query, ...)
	return dbExec(self.m_DBHandle, query, ...)
end

-- The prefix is to be used in all table names
-- Use ??_$tablename in SQL Statements
function SQL:getPrefix()
	return self.m_Prefix
end

function SQL:setPrefix(prefix)
	self.m_Prefix = prefix
end

-- Overloaded Function
-- Possible Signatures:
-- SQL:queryFetch(function callback, string query, ...) [[ asyncronous processing ]]
-- SQL:queryFetch(query, ...) [[ waits ]]
function SQL:queryFetch(...)
	if not self.m_DBHandle then
		core:onInternalError(RUNTIME_ERROR_MYSQL_CON_LOST)
	end

	local args = {...}
	if type(args[1]) == "string" then
		return self.dbPoll(dbQuery(self.m_DBHandle, ...), -1)
	else
		local query = args[2]
		local callback = args[1]

		-- Remove query and the callback from args
		table.remove(args, 1)
		table.remove(args, 1) -- 1 is correct here as after removing callback, query will be at position 1

		dbQuery(
			function(qh)
				local callbackArgs = { self.dbPoll(qh, -1) }
				callback(unpack(callbackArgs))
			end,
			self.m_DBHandle,
			query,
			unpack(args)
		)
	end
end

-- Overloaded Function
-- Possible Signatures:
-- SQL:queryFetchSingle(function callback, string query, ...) [[ asyncronous processing ]]
-- SQL:queryFetchSingle(query, ...) [[ waits ]]
function SQL:queryFetchSingle(...)
	if not self.m_DBHandle then
		core:onInternalError(RUNTIME_ERROR_MYSQL_CON_LOST)
	end

	local args = {...}
	if type(args[1]) == "string" then
		return self.dbPoll(dbQuery(self.m_DBHandle, ...), -1)[1]
	else
		local query = args[2]
		local callback = args[1]

		-- Remove query and the callback from args
		table.remove(args, 1)
		table.remove(args, 1) -- 1 is correct here as after removing callback, query will be at position 1

		dbQuery(
			function(qh)
				local callbackArgs = { self.dbPoll(qh, -1)[1] }
				callback(unpack(callbackArgs))
			end,
			self.m_DBHandle,
			query,
			unpack(args)
		)
	end
end

function SQL:asyncQueryFetch(...)
	if self.m_Async then
		self:queryFetch(Async.waitFor(), ...)
		return Async.wait()
	else
		return self:queryFetch(...)
	end
end

function SQL:asyncQueryFetchSingle(...)
	if self.m_Async then
		self:queryFetchSingle(Async.waitFor(), ...)
		return Async.wait()
	else
		return self:queryFetchSingle(...)
	end
end

function SQL:setAsyncEnabled(enabled)
	self.m_Async = enabled
end

-- The following method have to be implemented according to the underlying database type
SQL.dbPoll 			  = pure_virtual
SQL.lastInsertId 	= pure_virtual
SQL.constructor 	= pure_virtual
