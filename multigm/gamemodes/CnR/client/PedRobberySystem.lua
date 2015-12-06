function CopsnRobbers:CreateMoneyDeliveryCheckpoint(Dim)
local RandomDeliveryPoint = math.random(1,#CNR_LootDeliveryPoints)
local x = CNR_LootDeliveryPoints[RandomDeliveryPoint]["x"]
local y = CNR_LootDeliveryPoints[RandomDeliveryPoint]["y"]
local z = CNR_LootDeliveryPoints[RandomDeliveryPoint]["z"]

if self.MoneyDeliveryCheckpoint or self.MoneyDeliveryCheckpointBlip then self:DestroyMoneyDeliveryCheckpoint(source) end
DebugOutPut("CreateMoneyDeliveryCheckpoint")
self.MoneyDeliveryCheckpoint 	 = createMarker ( x,y,z, "cylinder", 4, 255, 0, 0, 255 )
self.MoneyDeliveryCheckpoint:setDimension(Dim)
self.MoneyDeliveryCheckpointBlip = createBlip   ( x,y,z, 41 )
self.MoneyDeliveryCheckpointHandler = function(...) self:GivePlayerRobberyMoney(...) end
addEventHandler ( "onClientMarkerHit", self.MoneyDeliveryCheckpoint, self.MoneyDeliveryCheckpointHandler )
end

function CopsnRobbers:GivePlayerRobberyMoney(hitPlayer, matchingDimension)
	if getElementType( hitPlayer ) == "player" and matchingDimension then
		triggerServerEvent("givePlayerRobbedMoney",hitPlayer)
		self:DestroyMoneyDeliveryCheckpoint(hitPlayer)
	end
end

function CopsnRobbers:DestroyMoneyDeliveryCheckpoint(Robber)
DebugOutPut("DestroyMoneyDeliveryCheckpoint")
	if self.MoneyDeliveryCheckpoint or self.MoneyDeliveryCheckpointBlip then
		self.MoneyDeliveryCheckpoint:destroy()	
		self.MoneyDeliveryCheckpointBlip:destroy()	 
		self.MoneyDeliveryCheckpoint = false
		self.MoneyDeliveryCheckpointBlip = false
		-- triggerServerEvent("resetPlayerRobbedMoney",Robber)
	end
end
