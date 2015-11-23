function CopsnRobbers:TazerPlayer (player)
local CNR_SELF = self
outputChatBox("player tazert:"..player:getName())	
		--player.Tazered = true
		if not self.TazerPlayerTimer then self.TazerPlayerTimer = {} end
		if not self.TazerPlayerTimer[player] then self.TazerPlayerTimer[player] = {} end
		
		if player:getHealth() >= 50 then
			self:TazerVariante1(player)
		else
			self:TazerVariante2(player)
		end
		
		
		
		self.TazerPlayerTimer[player]["delay"] = setTimer(function()
		CNR_SELF:unTazerPlayer( player )
		end,15000,1)

end

function CopsnRobbers:onTazerShot()
self:TazerPlayer (source)
end


function CopsnRobbers:unTazerPlayer( player )
outputChatBox("player untazert:"..player:getName())	
 self:TazerRemove( player )

end

function CopsnRobbers:TazerRemove( player )
if self.TazerPlayerTimer and self.TazerPlayerTimer[player] and isTimer(self.TazerPlayerTimer[player]["delay"]) then
	killTimer(self.TazerPlayerTimer[player]["delay"])
	self.TazerPlayerTimer[player]["delay"] = false
end
end

function CopsnRobbers:TazerVariante1( player )
local CNR_SELF = self
		self.TazerPlayerTimer[player]["Variante1"] = setTimer(function()
		if not CNR_SELF.TazerPlayerTimer[player]["delay"] then if isTimer(self.TazerPlayerTimer[player]["Variante1"]) then killTimer(self.TazerPlayerTimer[player]["Variante1"])end return end
		local rot = player:getRotation()
		local random = math.random(1,2)
		if random == 1 then
		player:setRotation(0,0,rot.z-90)
		else
		player:setRotation(0,0,rot.z+90)
		end
		
		end,1500,-1)
end

function CopsnRobbers:TazerVariante2( player )

end