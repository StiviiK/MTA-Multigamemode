CS_MapLoader = inherit(Object)
CS_MapLoader.Map = {}

function CS_MapLoader:constructor(GM)
self.Gamemode = GM
self.GameMaps = {
[1] = {["Name"] = "de_dust2",["path"] = "gamemodes/CS/res/maps/de_dust2/"}
}
end

function CS_MapLoader:destructor()
self:RestoreMap()
end

function CS_MapLoader:LoadMap(MapID)
	self.MapName = self.GameMaps[MapID]["Name"]
	self.MapPath = self.GameMaps[MapID]["path"]
	
---LoadMapSettings
	self:LoadMapSettings(MapID)
	
---LoadMap


	self.Map_txd = engineLoadTXD ( self.MapPath..self.MapName..".txd" )
		           engineImportTXD ( self.Map_txd, 13051 )
				   
	self.Map_col = engineLoadCOL ( self.MapPath..self.MapName..".col" )
				   engineReplaceCOL ( self.Map_col, 13051 )
				   
	self.Map_dff = engineLoadDFF ( self.MapPath..self.MapName..".dff", 0 )
				   engineReplaceModel ( self.Map_dff, 13051 )
				   
	engineSetModelLODDistance(13051, 2000)

	
	 self.Map = createObject ( 13051, self.MapSettings["MapPos"][1]["position"],self.MapSettings["MapPos"][1]["rotation"] )
	 setElementDimension(self.Map,self.Gamemode:getDimension())
	outputChatBox("DIM ändern")
---LoadMap Objects	
	self:LoadMapObjects(MapID)

 self.Gamemode:MapIsReady(self.MapSettings)
end


function CS_MapLoader:LoadMapObjects(MapID)
--TODO
end

function CS_MapLoader:LoadMapSettings(MapID)
self.MapSettings = {}
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


function CS_MapLoader:RestoreMap()
		self.MapSettings = false
		
		self.Map:destroy()
		self.Map_dff:destroy()
		self.Map_col:destroy()
		self.Map_txd:destroy()	
		engineRestoreCOL(13051)
		engineRestoreModel(13051)
end