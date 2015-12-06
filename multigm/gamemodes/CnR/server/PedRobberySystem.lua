PedRobberySystem = inherit(Object)


function PedRobberySystem:constructor(instancePed)
self.instancePed = instancePed
self.CNR_SELF = self.instancePed.CNR_SELF
self.CanBeRobbed = true
self.isPedRobbed = false
self.AfterRobbTime = 30000
self.HowLongAimOnPedToRob = 1000
self.RespawnPedTime = 30000
self.WaitForMoney = 10000
self.RobTimer = false
self.WantedsForKillPed = 2
self.WantedsForRobbingShop = 2
self.RobbedMoney = 2000
self.MaxDistanceRob = 5
self.MaxDistanceMove = 50


self.OnPlayerTargetPedHandler = function(...) self:OnPlayerTargetPed(...) end
addEventHandler("onPlayerTarget"  , getRootElement(), self.OnPlayerTargetPedHandler )
end

function PedRobberySystem:destructor(ped)
removeEventHandler("onPlayerTarget", getRootElement(), self.OnPlayerTargetPedHandler )
end

function PedRobberySystem:OnPlayerTargetPed(targetElem)
local Robber = source
local PedHealth = getElementHealth(self)
local isPlayerAiming = getControlState (Robber, "aim_weapon" )
local DistancebetweenPedPlayer = getDistanceBetweenPoints2D ( Robber:getPosition().x,Robber:getPosition().y, self:getPosition().x ,self:getPosition().y )
	if self.isPedRobbed and targetElem == self and isPlayerAiming then
	outputChatBox("Verkäufer wurde schon ausgeraubt!!",Robber,255,0,0)
	end
	if targetElem and targetElem == self and isPlayerAiming and self.CanBeRobbed and DistancebetweenPedPlayer < self.MaxDistanceRob then

	local WeapSlot 	     = getPedWeaponSlot ( source )
	local AllowedWeaponSlot = {2,3,4,5,6}
	DebugOutPut("test:"..tostring(AllowedWeaponSlot[tonumber(WeapSlot)]).."| WeapSlot:"..tonumber(WeapSlot))
		if AllowedWeaponSlot[WeapSlot]  then


		if isTimer(self.RobTimer) then killTimer(self.RobTimer) self.RobTimer = false end
		self.RobTimer = setTimer(
		function() 
			if Robber and getControlState (Robber,  "aim_weapon" ) and PedHealth == getElementHealth(self) then 
			self:StartRob(Robber) 
			else
			if isTimer(self.RobTimer) then killTimer(self.RobTimer) self.RobTimer = false end
			end 
		end,self.HowLongAimOnPedToRob,1)
		
		end
	end

end


function PedRobberySystem:StartRob(Robber)
PedRobberySystem_self = self

	if self.CanBeRobbed then
		self.CanBeRobbed = false
		self.CNR_SELF:GivePlayerWanteds(Robber,self.WantedsForRobbingShop)
		setTimer(function() PedRobberySystem_self:RestartShopPed () DebugOutPut("RESTART: CanBeRobbed") end,PedRobberySystem_self.AfterRobbTime,1)
		setTimer(function() PedRobberySystem_self:GiveRobLoot(Robber) end,PedRobberySystem_self.WaitForMoney,1)
		----Animation----
		setPedAnimation( self, "SHOP", "SHP_Rob_React",3000,true,true)
		setTimer(function() setPedAnimation( PedRobberySystem_self, "SHOP", "SHP_Serve_End",0,true,true)    end,self.WaitForMoney-6000,1)
		setTimer(function() setPedAnimation( PedRobberySystem_self, "SHOP", "SHP_Rob_GiveCash",0,false) end,self.WaitForMoney-3000,1)
		setTimer(function() setPedAnimation( self,"ped", "facsurpm")								    end,self.WaitForMoney+2000,1)
		

		DebugOutPut("Start Rob "..self.instancePed.Shop_ID)
	end
end

function PedRobberySystem:RestartShopPed ()
DebugOutPut("PedRobberySystem:RestartShopPed "..self.instancePed.Shop_ID)
self:destructor()
self.instancePed:destructor()
self.instancePed:CreateSellerPed()
end


function PedRobberySystem:GiveRobLoot(Robber)
local DistancebetweenPedPlayer = getDistanceBetweenPoints3D ( Robber:getPosition(), self:getPosition() )
local money
if isPedDead(self.instancePed.SellerPed) 		then outputChatBox("Überfall fehlgeschlagen der Verkäufer ist Tot!!",Robber,255,0,0) return end

if DistancebetweenPedPlayer > self.MaxDistanceMove then outputChatBox("Du bist weggerannt Ünerfall fehlgeschlagen!!",Robber,255,0,0) return end
self.isPedRobbed = true
			if tonumber(getElementData(Robber,"RobbedMoney")) then
				 money = tonumber(getElementData(Robber,"RobbedMoney"))+self.RobbedMoney
			else
				 money = self.RobbedMoney
			end
			
setElementData(Robber,"RobbedMoney", money)
outputChatBox("Bringe das Geld in Sicherheit begebe dich zum ....money:"..money,Robber,0,255,0)

triggerClientEvent(Robber,"CreateMoneyDeliveryCheckpoint",Robber,self.CNR_SELF:getDimension())
end



function givePlayerRobbedMoney ()

local RobbedMoney = tonumber(getElementData(source,"RobbedMoney"))
outputChatBox("Du hast das Geld in Sicherheit gebracht!! +"..RobbedMoney.."€")
givePlayerMoney(source,RobbedMoney)
setElementData( source,"RobbedMoney", 0)
end
addRemoteEvents{"givePlayerRobbedMoney"}
addEventHandler("givePlayerRobbedMoney", root, givePlayerRobbedMoney)

function resetPlayerRobbedMoney ()
DebugOutPut("resetPlayerRobbedMoney")
setElementData( source,"RobbedMoney", 0)
end
addRemoteEvents{"resetPlayerRobbedMoney"}
addEventHandler("resetPlayerRobbedMoney", root, resetPlayerRobbedMoney)