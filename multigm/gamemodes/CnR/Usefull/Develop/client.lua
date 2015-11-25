local PlayerBlips = {}

function CopsnRobbers:CreatePlayerBlip (player)
PlayerBlips[player] = createBlipAttachedTo ( player, 0 )
local Fraction = self:getPlayerFraction(player)
	if Fraction then
		local Color = CNR_Fraction_Color[Fraction]
		self:SetPlayerBlipColor (player,Color[1],Color[2],Color[3])
	end
end

function CopsnRobbers:DestroyPlayerBlip ()
	if player and PlayerBlips[player] then
		PlayerBlips[player]:destroy()
	end
end

function CopsnRobbers:CreateAllPlayerBlip ()
  local AllPlayer = self:getRoot():getAllByType("player")
	  for theKey,thePlayer in ipairs(AllPlayer) do
			self:CreatePlayerBlip (thePlayer)
	  end

end

function CopsnRobbers:DestroyAllPlayerBlip ()
	  for theKey,thePlayer in ipairs(PlayerBlips) do
			self:DestroyPlayerBlip (thePlayer)
	  end
end

function CopsnRobbers:SetPlayerBlipColor (player,r,g,b)
	if player and PlayerBlips[player] then
		setBlipColor(PlayerBlips[player],r,g,b,255)
	end
end
