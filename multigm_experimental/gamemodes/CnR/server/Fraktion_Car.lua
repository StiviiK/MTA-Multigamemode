CopsnRobbers.FraktionsVehicle = inherit(Object)

local FraktionsVehicle = CopsnRobbers.FraktionsVehicle



function FraktionsVehicle:constructor(CNR_SELF,Team,model,position,rotation,color)
self.m_Model = model
self.Fraction = Team
self.m_Position = position
self.m_Rotation = rotation
self.m_Dimension = CNR_SELF:getDimension()
self.EngineState = nil
self.LightState  = false
self.Color = color or {0,0,0}
--self.m_Gamemode = gamemode

addEventHandler ( "onVehicleEnter", self, bind(FraktionsVehicle.onVehicleEnter, self) )
addEventHandler ( "onVehicleStartExit", self, bind(FraktionsVehicle.onVehicleStartExit, self) )
self.KeyBindSwitchEngine = function( player, key, keyState) self:SwitchEngine ( player, key, keyState) end
self.KeyBindSwitchLight  = function( player, key, keyState) self:SwitchLight ( player, key, keyState) end

self:setDimension(CNR_SELF:getDimension())
self:toggleRespawn( true )
self:setRespawnDelay( 10000 )
self:setRespawnPosition( self.m_Position,self.m_Rotation )
self:setDamageProof(false)
self:setColor(unpack(self.Color))
end

function FraktionsVehicle:destructor()
self:destroy()
end

function FraktionsVehicle:onVehicleEnter(thePlayer, seat, jacked)
		if self.EngineState == nil then
			self:setEngineState(false)   --Damit beim ersten mal motor aus ist
			self.EngineState = false	 --Damit beim ersten mal motor aus ist
		else
			self:setEngineState(self.EngineState) 
		end
			  

		bindKey(thePlayer,"x","down",self.KeyBindSwitchEngine)
		bindKey(thePlayer,"l","down",self.KeyBindSwitchLight)

end

function FraktionsVehicle:onVehicleStartExit(thePlayer, seat, jacked)
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
	self.LightState = not self.LightState
		if (self.LightState) then
			LightNummer = 2
		else
			LightNummer = 1
		end
	setVehicleOverrideLights(self, LightNummer)
	else
		if (isKeyBound (player,"x")) or (isKeyBound (player,"l")) then
			unbindKey(player,"x","down",self.KeyBindSwitchEngine)
			unbindKey(player,"l","down",self.KeyBindSwitchLight)
		end
	end
end

function CopsnRobbers:CreateFractionVehicle (Team,model,position,rotation,color)
local veh = createVehicle(model,position,rotation,Team)
setVehicleOverrideLights(veh, 1)
enew(veh,FraktionsVehicle,self,Team,model,position,rotation,color)
addVehicleSirens(veh,1,3,true,false,false)
return veh
end
