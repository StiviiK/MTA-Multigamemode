MySQL = inherit(SQL)

function MySQL:constructor(host, port, user, password, database, unixpath)
	local connectString = ("dbname=%s;host=%s;port=%d;unix_socket=%s"):format(database, host, port or 3306, unixpath or "")
	self.m_DBHandle = dbConnect("mysql", connectString, user, password, "share=0;batch=1;autoreconnect=1;log=0;tag=gtasaonline")
	if not self.m_DBHandle then
		core:onInternalError(ERROR_MYSQL_CONNECTION_FAILED)
	end
end

function MySQL.dbPoll(qh, timeout)
	local result, numrows, errmsg = dbPoll ( qh, timeout)
	if result == nil then
		outputDebugString("[MySQL] dbPoll - result not ready yet" )
	elseif result == false then
	    outputDebugString("[MySQL] dbPoll failed. Error code: " .. tostring(numrows) .. "  Error message: " .. tostring(errmsg) )
	end
	return result
end

function MySQL:lastInsertId()
	return self:queryFetchSingle("SELECT LAST_INSERT_ID() AS ID;").ID
end
