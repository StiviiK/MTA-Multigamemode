CopsnRobbers.ArrestSystem = inherit(Object)

local ArrestSystem = CopsnRobbers.ArrestSystem
ArrestPrisons = {}--Hier sind alle Gefängnise
--Strafen = "High","Medium","Low"

function ArrestSystem:constructor(CNR_SELF,MarkerGaragePos,ArrestPos,ArrestRot,ArrestInt,RespawnPos,RespawnRot,RespawnInt)
table.insert(ArrestPrisons,self)
self.m_Parent = parent
self.ArrestPos  = ArrestPos
self.ArrestRot  = ArrestRot
self.ArrestInt  = ArrestInt
self.CNR_SELF = CNR_SELF
self.RespawnPos = RespawnPos
self.RespawnRot = RespawnRot
self.RespawnInt = RespawnInt


self.ArrestetPlayers = {}
self.GarageMarker = Marker( MarkerGaragePos, "cylinder", 3, 255, 255, 0, 100 )
self.GarageMarker:setDimension(CNR_SELF:getDimension())
addEventHandler( "onMarkerHit", self.GarageMarker, bind(ArrestSystem.onHitArrestMarker,self) )
self:CreateCheckTimer()
end

function ArrestSystem:CreateCheckTimer()
if isTimer(self.CheckTimer) then return end
self.CheckTimer = setTimer(bind(ArrestSystem.CheckTime,self),1000,0)
end

function ArrestSystem:StopTimer()
	if isTimer(self.CheckTimer) then
		killTimer(self.CheckTimer)
	end
end

function ArrestSystem:CheckTime()
	if #self.ArrestetPlayers > 0 then
		local AllPlayer = self.CNR_SELF:getRoot():getAllByType("player")
		for theKey,thePlayer in ipairs(AllPlayer) do
	    if self.ArrestetPlayers[thePlayer] then
			local PlayerArrestTime = self.ArrestetPlayers[thePlayer]["ArrestTime"]
				if PlayerArrestTime <= 0 then
					self:SetPlayerFree(thePlayer)
				else
					self.ArrestetPlayers[thePlayer]["ArrestTime"] = PlayerArrestTime -1000
					DebugOutPut(thePlayer:getName()..":ArrestTime:"..self.ArrestetPlayers[thePlayer]["ArrestTime"])
				end
		 end
		end
	else
		self:StopTimer()
	end
end

function ArrestSystem:onHitArrestMarker(hitElement, matchingDimension)
	if matchingDimension and hitElement:getType() == "vehicle" then
		local occupants = getVehicleOccupants(hitElement) or {}

		for seat, occupant in pairs(occupants) do
			if (occupant and getElementType(occupant) == "player") then
                if self.CNR_SELF:GetPlayerWanteds(occupant) > 0  then
					occupant:removeFromVehicle()
					self:ArrestPlayer(occupant)
				end
			end
		end
	end
end


function ArrestSystem:destructor()
self:destroy()
end

function ArrestSystem:ArrestPlayer(player,ArrestedBy,FineHardness)

if not FineHardness then FineHardness = "Medium" end

local PlayerWanteds     = self.CNR_SELF:GetPlayerWanteds(player)
local FineMultiplikator = CNR_Arrest_Fine[FineHardness]
local CopPay 			= CNR_Arrest_Cops_Pay[FineHardness]
local ArrestTime        = self:ArrestTimeCalculator(PlayerWanteds) * FineMultiplikator
local ArrestFine        = self:MustPayCalculator(PlayerWanteds)    * FineMultiplikator

----Cop-----------
if ArrestedBy then
ArrestedBy:giveMoney(CopPay)
end
----Player--------


table.insert(self.ArrestetPlayers,player)
self.ArrestetPlayers[player] = {["ArrestTime"] = ArrestTime ,["ArrestFine"] = ArrestFine}

player.Arrested = true
self:CreateCheckTimer()
player:setInterior(self.ArrestInt)
player:setPosition(self.ArrestPos[math.random(1,#self.ArrestPos)])
player:takeMoney(ArrestFine)
self.CNR_SELF:ResetPlayerWanteds(player)
end

function ArrestSystem:MustPayCalculator(Wanteds)--verhaftungszeit
return Wanteds*1
end

function ArrestSystem:ArrestTimeCalculator(Wanteds)--verhaftungszeit
return Wanteds*1
end

function ArrestSystem:SetPlayerFree(player)--freilassen
table.remove(self.ArrestetPlayers,table.find(self.ArrestetPlayers,player))
player.Arrested = false
player:setInterior(self.RespawnInt)
player:setPosition(self.RespawnPos)
player:setRotation(self.RespawnRot)
DebugOutPut("Spieler Freigelassen"..tostring(#self.ArrestetPlayers))
end

function ArrestSystem:GetPlayerArrestTime(player)--verhaftungszeit
return self.ArrestetPlayers[player]["ArrestTime"]
end






function CopsnRobbers:CreateJails ()


------LSPD Jail------------
local LSPD = {}
LSPD.GarageMarkerPos = Vector3(1568.1192626953,-1694.7281494141,5)
LSPD.ArrestPos  = {Vector3(263.95,86.68,1001.04),Vector3( 264.22,82.28,1001.04)}
LSPD.ArrestRot  = {Vector3(0,0,90),Vector3(0,0,90)}
LSPD.ArrestInt  = 6
LSPD.RespawnPos = Vector3(1559,-1697.23,6.19)
LSPD.RespawnRot = Vector3(0,0,87)
LSPD.RespawnInt = 0

local LSPDJail = new(ArrestSystem,self,LSPD.GarageMarkerPos,LSPD.ArrestPos,LSPD.ArrestRot,LSPD.ArrestInt,LSPD.RespawnPos,LSPD.RespawnRot,LSPD.RespawnInt,self)

end
