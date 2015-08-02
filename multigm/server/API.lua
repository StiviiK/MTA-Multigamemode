API = inherit(Object)

function API:constructor(url, actions)
  self.ms_Url = type(url) == "string" and url or API_URL

  self.m_Statements = actions or {}
  self.m_SecurityToken = "647aa0b4e396fa2caabdecc66f3bca22ee46cc911852999f64aef62f03804685"
end

function API:destructor()
  local instruction = self:getStatement("onDestruct")
  if instruction then
    self:call(instruction)
  end
end

function API:call(instruction, ...)
  return fetchRemote(("%s?token=%s&%s"):format(self.ms_Url, self.m_SecurityToken, table.concat(instruction.parameter, "&")), instruction.callback, "", false, ...)
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

--[[
local api = API:new()
api:setStatement("onConnect", "parameter", {"method=connect"})
api:setStatement("onConnect", "callback", function (responseData, errno) end)
api:setStatement("onDestruct", "parameter", {"method=disconnect"})
api:setStatement("onDestruct", "callback", function (responseData, errno) outputDebug(responseData) end)
delete(api)
]]
