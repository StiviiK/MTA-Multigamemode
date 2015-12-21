Performance = inherit(Singleton)

function Performance:constructor()
  self.m_AppName = Resource.getThis():getName()
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
