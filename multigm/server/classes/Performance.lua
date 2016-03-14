Performance = inherit(Singleton)
addRemoteEvents{"Event_CleanMemoryUp"}

function Performance:constructor()
  self.m_AppName = Resource.getThis():getName()
  self.m_PerformanceData = {
    luaTimings  = {arg1 = "-", arg2 = "-", arg3 = "-"};
    luaMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
    --libMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
    --packetUsage = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-", arg5 = "-", arg6 = "-", arg7 = "-"};
  }

  -- Create update timer
  setTimer(bind(self.update, self), 500, 0)

  -- Event Zone
  addEventHandler("Event_CleanMemoryUp", root, bind(self.Event_CleanMemoryUp, self))
end

function Performance:update()
  local s = getTickCount()

  -- Update luaTimings
  local luaTimings = {self:getLUATimings()}
  for i, v in pairs(luaTimings) do
    if self.m_PerformanceData.luaTimings["arg"..i] ~= v then
      self.m_PerformanceData.luaTimings["arg"..i] = v
    end
  end

  -- Update luaMemory
  local luaMemory = {self:getLUAMemory()}
  for i, v in pairs(luaMemory) do
    if self.m_PerformanceData.luaMemory["arg"..i] ~= v then
      self.m_PerformanceData.luaMemory["arg"..i] = v
    end
  end

  --[[
  -- Update libMemory
  local libMemory = {self:getLibMemory()}
  for i, v in pairs(libMemory) do
    if self.m_PerformanceData.libMemory["arg"..i] ~= v then
      self.m_PerformanceData.libMemory["arg"..i] = v
    end
  end

  -- Update packetUsage
  local packetUsage = {self:getPacketUsage()}
  for i, v in pairs(packetUsage) do
    if self.m_PerformanceData.packetUsage["arg"..i] ~= v then
      self.m_PerformanceData.packetUsage["arg"..i] = v
    end
  end
  --]]

  -- Send Performance data to client
  self:sendPerformanceData()
end

function Performance:sendPerformanceData()
  for i, v in pairs(Element.getAllByType("player") --[[self.m_Players]]) do
    if v:isClientReady() then
      triggerClientEvent(v, "receivePerformanceStats", v, self.m_PerformanceData)
    end
  end
end

function Performance:getLUATimings()
  local luaTimingsColumns, luaTimingsRows = getPerformanceStats("Lua timing", "", self.m_AppName)

	for i, row in ipairs(luaTimingsRows) do
		local results = split(table.concat(row, ";"), ";")
		return results[1], results[2], results[3]
	end
end

function Performance:getLUAMemory()
	local luaTimingsColumns, luaTimingsRows = getPerformanceStats("Lua memory", "", self.m_AppName)

	for i, row in ipairs(luaTimingsRows) do
		local results = split(table.concat(row, ";"), ";")
		return results[1], results[2], results[3], results[4]
	end
end


function Performance:getLibMemory()
	local luaTimingsColumns, luaTimingsRows = getPerformanceStats("Lib memory", "", self.m_AppName)

	for i, row in ipairs(luaTimingsRows) do
		local results = split(table.concat(row, ";"), ";")
		return results[1], results[2], results[3], results[4]
	end
end

function Performance:getPacketUsage()
	local luaTimingsColumns, luaTimingsRows = getPerformanceStats("Packet usage", "", self.m_AppName)

	for i, row in ipairs(luaTimingsRows) do
		local results = split(table.concat(row, ";"), ";")
		return results[1], results[2], results[3], results[4], results[5], results[6], results[7]
	end
end

-- Events
function Performance:Event_CleanMemoryUp()
  if source:getRank() <= RANK.User then
    -- TODO: Cheating user?
    return
  end
  if source:getRank() >= RANK.Administrator then
    collectgarbage()
  end
end
