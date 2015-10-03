CopsnRobbers.FraktionsVehicle = inherit(Object)

local FraktionsVehicle = CopsnRobbers.FraktionsVehicle



function FraktionsVehicle:constructor(Team,model,position,rotation)


self.m_Model = model
self.Fraction = Team
self.m_Position = position
self.m_Rotation = rotation
self.m_Dimension = CNR_DIM
self.EngineState = false
self.LightState  = false
--self.m_Gamemode = gamemode

addEventHandler ( "onVehicleEnter", self, bind(FraktionsVehicle.onVehicleEnter, self) )
addEventHandler ( "onVehicleStartExit", self, bind(FraktionsVehicle.onVehicleStartExit, self) )
self.KeyBindSwitchEngine = function( player, key, keyState) self:SwitchEngine ( player, key, keyState) end
self.KeyBindSwitchLight  = function( player, key, keyState) self:SwitchLight ( player, key, keyState) end

self:setDimension(CNR_DIM)
self:toggleRespawn( true )
self:setRespawnDelay( 10000 )
self:setRespawnPosition( self.m_Position,self.m_Rotation )
self:setDamageProof(false)

outputChatBox("Fraction Car Created")
end

function FraktionsVehicle:destructor()
self:destroy()
end

function FraktionsVehicle:onVehicleEnter(thePlayer, seat, jacked)
outputChatBox("bindKey")

		self:setEngine(self.EngineState)---damit bei erstem einsteigen der motor aus ist
		bindKey(thePlayer,"x","down",self.KeyBindSwitchEngine)
		bindKey(thePlayer,"l","down",self.KeyBindSwitchLight)

end

function FraktionsVehicle:onVehicleStartExit(thePlayer, seat, jacked)
outputChatBox("unbindKey")
unbindKey(thePlayer,"x","down",self.KeyBindSwitchEngine)
unbindKey(thePlayer,"l","down",self.KeyBindSwitchLight)
end

function FraktionsVehicle:setEngine()
local State = not self.EngineState
self:setEngineState(State)
self.EngineState = State
end

function FraktionsVehicle:SwitchEngine ( player, key, keyState)
	if self ==  player:getOccupiedVehicle( ) then 
	outputChatBox("Switch EngineState "..tostring(self.EngineState))
	self:setEngine()
	else
		if (isKeyBound (player,"x")) or (isKeyBound (player,"l")) then
			unbindKey(player,"x","down",self.KeyBindSwitchEngine)
			unbindKey(player,"l","down",self.KeyBindSwitchLight)
		end
	end
end

function FraktionsVehicle:SwitchLight ( player, key, keyState)
	if self ==  player:getOccupiedVehicle( ) then 
	outputChatBox("Switch LightState")
	self.LightState = not self.LightState
		if (self.LightState) then
			LightState = 2
		else
			LightState = 1
		end
	setVehicleOverrideLights(self, LightState)
	else
		if (isKeyBound (player,"x")) or (isKeyBound (player,"l")) then
			unbindKey(player,"x","down",self.KeyBindSwitchEngine)
			unbindKey(player,"l","down",self.KeyBindSwitchLight)
		end
	end
end

function FraktionsVehicle:CreateFractionVehicle (Team,model,position,rotation)
local veh = createVehicle(model,position,rotation,Team)
enew(veh, FraktionsVehicle,Team,model,position,rotation)
return veh
end



FraktionsVehicle:CreateFractionVehicle("Cops",411,Vector3(1536,-1675,12.9),Vector3(0,0,0))