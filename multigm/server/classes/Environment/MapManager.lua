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
    self:parseMapXML(gamemode, name)
  end

  return Map:new(gamemode, self.m_LoadedMaps[name].Objects)
end

function MapManager:parseMapXML(Gamemode, filePath)
  if not fileExists(filePath) then return end
  if not self.m_LoadedMaps[filePath] then return end

  Objects = {}
  local xml = XML.load(filePath)
  for k in pairs(xml:getChildren()) do
    local child
    child = xml:findChild("object", k-1)
    if child then
			local attributes = child:getAttributes()
			table.insert(Objects, {
				["model"] = attributes["model"],
				["posX"] = attributes["posX"],
				["posY"] = attributes["posY"],
				["posZ"] = attributes["posZ"],
				["rotX"] = attributes["rotX"],
				["rotY"] = attributes["rotY"],
				["rotZ"] = attributes["rotZ"],
				["id"] = attributes["id"],
				["collisions"] = (attributes["collisions"] == "true" and true) or (attributes["collisions"] == "false" and false),
				["alpha"] = attributes["alpha"],
				["doublesided"] = (attributes["doublesided"] == "true" and true) or (attributes["doublesided"] == "false" and false),
				["scale"] = attributes["scale"],
			})
		end
  end

  self.m_LoadedMaps[filePath] = {
    Objects = Objects;
    Parsed = true;
  }
end
