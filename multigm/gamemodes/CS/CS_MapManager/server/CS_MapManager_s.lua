CS_MapLoader = inherit(Object)
CS_MapLoader.Map = {}

function CS_MapLoader:constructor()
self.GameMaps = {
[1] = {["Name"] = "de_dust2",["path"] = "gamemodes/CS/res/maps/de_dust2/"}
}


end

function CS_MapLoader:destructor()
delete(self)
end

function CS_MapLoader:LoadMapSettings(MapID)
self.MapSettings = {}
self.MapName = self.GameMaps[MapID]["Name"]
self.MapPath = self.GameMaps[MapID]["path"]

	-- self.MapName 
local Items = {"Camera_CT_Spawn","Camera_T_Spawn","Bomb_Place_A","Bomb_Place_B","CT_Spawn","T_Spawn","MapPos","WaitForPlayer_Camera"}	 
local xml = XML.load(self.MapPath.."Info.xml")

	for i= 1,#Items do
		for k in pairs(xml:getChildren()) do
			local child
			child = xml:findChild(Items[i], k-1)
			if child then
			  local attributes = child:getAttributes()
				  if not self.MapSettings[Items[i]] then self.MapSettings[Items[i]] = {} end
					  table.insert(self.MapSettings[Items[i]], {
						["position"] = Vector3(attributes["posX"], attributes["posY"], attributes["posZ"]),
						["rotation"] = Vector3(attributes["rotX"], attributes["rotY"], attributes["rotZ"]),
						["id"] = attributes["id"]
					  })
				 end
		  end
	end
end

function CS_MapLoader:getSettings(item)
return self.MapSettings[item]
end