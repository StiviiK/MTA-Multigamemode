local __enums = {}
function enum(targetVar, name)
	if __enums[name] then
		__enums[name].maxNum = __enums[name].maxNum+1
	else
		__enums[name] = {maxNum = 1}
	end

	-- Register in global namespace
	_G[targetVar] = __enums[name].maxNum

	-- Register mainly for addons
	__enums[name][__enums[name].maxNum] = targetVar

	return __enums[name]
end

function getEnums()
	return __enums
end

function enumFields(name)
	local i = 0
	local maxNum = __enums[name].maxNum
	return (
		function()
			i = i + 1
			if i ~= maxNum then
				return i, __enums[name][i]
			end
		end
	)
end

function table.size(tab, recursive)
	local i = 0
	for _, v in pairs(tab) do
		if type(v) == "table" and recursive then
			i = i + table.size(v, true)
		else
			i = i + 1
		end
	end
	return i
end

function table.find(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
	end
	return nil
end

function table.findAll(tab, value)
	local result = {}
	for k, v in pairs(tab) do
		if v == value then
			table.insert(result, k)
		end
	end
	return result
end

function table.compare(tab1, tab2) -- This method is for debugging purposes only
	-- Check if tab2 is subset of tab1
	for k, v in pairs(tab1) do
		if type(v) == "table" and type(tab2[k]) == "table" then
			if not table.compare(v, tab2[k]) then
				return false
			end
		elseif type(v) == "number" and type(tab2[k]) == "number" then
			if not floatEqual(v, tab2[k]) then
				return false
			end
		elseif v ~= tab2[k] then
			return false
		end
	end

	-- Check if tab1 is subset of tab2
	for k, v in pairs(tab2) do
		if type(v) == "table" and type(tab1[k]) == "table" then
			if not table.compare(v, tab1[k]) then
				return false
			end
		elseif type(v) == "number" and type(tab1[k]) == "number" then
			if not floatEqual(v, tab1[k]) then
				return false
			end
		elseif v ~= tab1[k] then
			return false
		end
	end

	return true
end

function table.removevalue(tab, value)
	local idx = table.find(tab, value)
	if idx then
		table.remove(tab, idx)
	end
end

function table.copy(tab)
	local temp = {}
	for k, v in pairs(tab) do
		temp[k] = type(v) == "table" and table.copy(tab) or v
	end
	return temp
end

function getRandomUniqueNick()
	local randomNick
	repeat
		randomNick = "Guest_"..math.random(1, 99999)
	until (not getPlayerFromName(randomNick))

	return randomNick
end

function addRemoteEvents(eventList)
	for k, v in ipairs(eventList) do
		addEvent(v, true)
	end
end

function sizeFormat(size)
	local size = tostring(size)
	if size:len() >= 4 then
		if size:len() >= 7 then
			if size:len() >= 9 then
				local returning = tostring(size/(1024*1024*1024))
				returning = returning:sub(1, 4)
				return returning.." GB";
			else
				local returning = tostring(size/(1024*1024))
				returning = returning:sub(1, 4)

				return returning.." MB";
			end
		else
			local returning = tostring(size/1024)
			returning = returning:sub(1, 4)
			if returning:sub(4, 4) == "." then
				returning = returning:sub(1, 3)
			elseif returning:sub(3, 3) == "." then
				returning = returning:sub(1, 2)
			elseif returning:sub(2, 2) == "." then
				returning = returning:sub(1, 1)
			end
			return returning.." KB";
		end
	else
		return size.." B";
	end
end

function string.upperFirst(self)
	return ("%s%s"):format(self:sub(1, 1):upper(), self:sub(2, self:len()))
end


function delay(f, ...)
	setTimer(f, 50, 1, ...)
end

function table.push(self, ...)
	local args = {...}
	local index
	local v
	if #args == 1 then
		index = #self + 1
		v     = args[1]
	else
		index = args[1]
		v     = args[2]
	end

	self[index] = v

	return index
end

_coroutine_resume = coroutine.resume
function coroutine.resume(...)
	local state,result = _coroutine_resume(...)
	if not state then
		return outputDebugString(tostring(result), 1)	-- Output error message
	end
	return state,result
end

function math.getPlainInfoFromEuler(position, rotation, size)
	-- Build entity matrix and calculate the normal
	local mat = Matrix(position, rotation)
	local normal = mat.forward

	local startpos = position
	local endpos = mat:transformPosition(size)

	return startpos, endpos, normal
end

function unpackVector(vector)
	if vector.x and vector.y and vector.z and vector.w then
		return vector.x, vector.y, vector.z, vector.w
	elseif vector.x and vector.y and vector.z then
		return vector.x, vector.y, vector.z
	elseif vector.x and vector.y then
		return vector.x, vector.y
	end
end

function math.determinante(a, b, c)
	return a:cross(b):dot(c)
end

function math.getAngle(vec1, vec2)
	return math.acos(vec1:dot(vec2)/(vec1.length * vec2.length))
end

function math.line_plane_intersection(linepos, linedir, planepos, planev1, planev2)
	local posoffset = linepos - planepos
	local n = planev1:cross(planev2)
	if math.abs(n:dot(linedir)) < 1.0e-3 then
		return false
	end

	local r = math.determinante(planev1, planev2, posoffset) / math.determinante(planev1, planev2, -linedir)

	return linepos + r * linedir
end

function toHex(num)
	return (("0x%X"):format(num))
end

function resolveError(hash)
	assert(type(hash) == "string", "Bad Argument @ resolveError [Exepected <<Error-Hash>> at argument 1, got "..type(hash).."]")
	return table.find(_G, hash)
end
