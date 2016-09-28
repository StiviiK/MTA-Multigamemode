API = inherit(Object)

function API:constructor(url, actions)
	self.ms_Url = type(url) == "string" and url or API_URL

	self.m_Statements = actions or {}
	self.m_SecurityToken = ""
end

function API:destructor()
	local instruction = self:getStatement("onDestruct")
	if instruction then
		self:call(instruction)
	end
end

function API:call(instruction, ...)
	if self.m_SecurityToken ~= "" then
		--outputDebug(("%s?token=%s&%s"):format(self.ms_Url, self.m_SecurityToken, #instruction.parameter > 1 and table.concat(instruction.parameter, "&") or unpack(instruction.parameter)))
		return fetchRemote(("%s?token=%s&%s"):format(self.ms_Url, self.m_SecurityToken, #instruction.parameter > 1 and table.concat(instruction.parameter, "&") or unpack(instruction.parameter)), instruction.callback, "", false, ...)
	else
		--outputDebug(("%s?%s"):format(self.ms_Url, #instruction.parameter > 1 and table.concat(instruction.parameter, "&") or unpack(instruction.parameter)))
		return fetchRemote(("%s?%s"):format(self.ms_Url, #instruction.parameter > 1 and table.concat(instruction.parameter, "&") or unpack(instruction.parameter)), instruction.callback, "", false, ...)
	end
end

function API:setStatement(action, statement, data)
	if not self.m_Statements[action] then
		self.m_Statements[action] = {}
	end

	self.m_Statements[action][statement] = data
end

function API:getStatement(action, statement)
	if statement then
		return self.m_Statements[action][statement]
	else
		return self.m_Statements[action]
	end
end
