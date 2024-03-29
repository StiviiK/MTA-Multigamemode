MapManager = inherit(Singleton)
MapManager.Map = {}

function MapManager:constructor()
	self.m_LoadedMaps = {}
end

function MapManager:destructor()
	for i, v in pairs(MapManager.Map) do
		delete(v)
	end
end

function MapManager:addRef(ref)
	return table.push(MapManager.Map, ref)
end

function MapManager:removeRef(ref)
	MapManager.Map[ref:getId()] = nil
end

function MapManager.getFromId(Id)
	return MapManager.Map[Id]
end

function MapManager:registerMap(name)
	if self.m_LoadedMaps[name] then return end
	self.m_LoadedMaps[name] = {
		Parsed = false;
		Objects = {};
	}
end

function MapManager:loadMap(gamemode, name)
	if not self.m_LoadedMaps[name] then return end
	if not self.m_LoadedMaps[name].Parsed then
		self.m_LoadedMaps[name] = {Objects = MapManager.parseMapXML(name), Parsed = true}
	end

	return Map:new(gamemode, self.m_LoadedMaps[name].Objects)
end

function MapManager.parseMapXML(filePath)
	if not fileExists(filePath) then return end

	local Objects = {}
	local xml = XML.load(filePath)
	for k in pairs(xml:getChildren()) do
		local child
		child = xml:findChild("object", k-1)
		if child then
		local attributes = child:getAttributes()
		table.insert(Objects, {
			["model"] = attributes["model"],
			["position"] = Vector3(attributes["posX"], attributes["posY"], attributes["posZ"]),
			["rotation"] = Vector3(attributes["rotX"], attributes["rotY"], attributes["rotZ"]),
			["id"] = attributes["id"],
			["collisions"] = (attributes["collisions"] == "true" and true) or (attributes["collisions"] == "false" and false) or true,
			["alpha"] = attributes["alpha"],
			["doublesided"] = (attributes["doublesided"] == "true" and true) or (attributes["doublesided"] == "false" and false) or false,
			["scale"] = attributes["scale"] or 1,
		})
		end
	end

	return Objects
end
