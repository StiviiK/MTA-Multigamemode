function CopsnRobbers:Wasted ( ammo, attacker, weapon, bodypart )
local CNR_SELF = self
local player = source
local PlayerPos = source.position
local LowestDistance = false
local LowestDistanceID = false


if attacker then
	if self:getPlayerFraction(attacker) == "Cops" and player:GetPlayerWanteds() > 0 then 
-------If Cop kill Player with wanteds-----------
		for i = 1,#ArrestPrisons do
				local Distance = getDistanceBetweenPoints2D ( PlayerPos.x, PlayerPos.y, ArrestPrisons[i].RespawnPos.x,ArrestPrisons[i].RespawnPos.y )

			if LowestDistance == false then
				LowestDistance = Distance
				LowestDistanceID = i
			else
				if Distance < LowestDistance  then
				LowestDistance = Distance
				LowestDistanceID = i
			end
		end
		
			ArrestPrisons[i]:ArrestPlayer(player,attacker,"High")

		end
	end
end

-------------------------------------------------




for i = 1,#CNR_Spawns_Hospital do
local Distance = getDistanceBetweenPoints2D ( PlayerPos.x, PlayerPos.y, CNR_Spawns_Hospital[i]["Pos"].x, CNR_Spawns_Hospital[i]["Pos"].y )

		if LowestDistance == false then
			LowestDistance = Distance
			LowestDistanceID = i
		else
			if Distance < LowestDistance  then
			LowestDistance = Distance
			LowestDistanceID = i
		end
	end

end


	setTimer(function()
		local Pos = CNR_Spawns_Hospital[LowestDistanceID]["Pos"]
		local Rot = CNR_Spawns_Hospital[LowestDistanceID]["Rot"]
		local Int = CNR_Spawns_Hospital[LowestDistanceID]["Int"]
		local Skin = player:getModel()
		local Dim  = CNR_SELF:getDimension()

		player:spawn(Pos.x,Pos.y,Pos.z,Rot.z,Skin,Int,Dim)
	 end,5000,1)
end
