
function CopsnRobbers:GivePlayerWanteds(player,Wanteds)
local Wanteds = tonumber(Wanteds)
	if player:getType() == "player" and type(Wanteds) == "number" then
		player:setData("Wanteds",player:getData("Wanteds") or 0+Wanteds)
	else
		outputDebugString("GivePlayerWanteds Error")

	end
end

function CopsnRobbers:GetPlayerWanteds(player)
	if player:getType() == "player" then
		return tonumber(player:getData("Wanteds") or 0)
	else
		outputDebugString("GetPlayerWanteds Error")

		
	end
end

function CopsnRobbers:TakePlayerWanteds(player,Wanteds)
local Wanteds = tonumber(Wanteds)
	if player:getType() == "player" and type(Wanteds) == "number" then
		player:setData("Wanteds",player:getData("Wanteds") or 0-Wanteds)
	else
		outputDebugString("TakePlayerWanteds Error")

	end
end

function CopsnRobbers:ResetPlayerWanteds(player)
	if player:getType() == "player" then
		player:setData("Wanteds",0)
	else
		outputDebugString("ResetPlayerWanteds Error")

	end
end


