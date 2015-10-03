
function Player:GivePlayerWanteds(Wanteds)
local Wanteds = tonumber(Wanteds)
	if self:getType() == "player" and type(Wanteds) == "number" then
		self:setData("Wanteds",self:getData("Wanteds") or 0+Wanteds)
	else
		outputDebugString("GivePlayerWanteds Error")

	end
end

function Player:GetPlayerWanteds()
	if self:getType() == "player" then
		return tonumber(self:getData("Wanteds") or 0)
	else
		outputDebugString("GetPlayerWanteds Error")

		
	end
end

function Player:TakePlayerWanteds(Wanteds)
local Wanteds = tonumber(Wanteds)
	if self:getType() == "player" and type(Wanteds) == "number" then
		self:setData("Wanteds",self:getData("Wanteds") or 0-Wanteds)
	else
		outputDebugString("TakePlayerWanteds Error")

	end
end

function Player:ResetPlayerWanteds()
	if self:getType() == "player" then
		self:setData("Wanteds",0)
	else
		outputDebugString("ResetPlayerWanteds Error")

	end
end


