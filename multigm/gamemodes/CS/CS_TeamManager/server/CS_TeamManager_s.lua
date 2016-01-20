CS_TeamManager = inherit(Object)

function CS_TeamManager:constructor (GM)
self.GM_self = GM
self.Players = {["CT"] = {},["T"] = {},["SPEC"] = {}}
end

function CS_TeamManager:getTeamPlayers (Team)
return self.Players[Team]
end

function CS_TeamManager:addPlayerTeam (player,Team)
self:RemovePlayerTeam (player)
table.insert(self.Players[Team],player) 
player:getSubGamemode():PlayerTeamSelected(player,Team)

self.GM_self:setSyncInfo("Team_"..Team, self.Players[Team])

outputChatBox(player:getName().." Add Player Team:"..Team)
end

function CS_TeamManager:RemovePlayerTeam (player)



		for theKey,thePlayer in ipairs(self.Players["CT"]) do
			if thePlayer == player then
				table.remove(self.Players["CT"],theKey) 
				outputChatBox(thePlayer:getName().."Player Remove Team CT",player,255,0,0)
			end
		end
		
		for theKey,thePlayer in ipairs(self.Players["T"]) do
			if thePlayer == player then
				table.remove(self.Players["T"],theKey) 
				outputChatBox(thePlayer:getName().."Player Remove Team T",player,255,0,0)
			end
		end
		
		for theKey,thePlayer in ipairs(self.Players["SPEC"]) do
			if thePlayer == player then
				table.remove(self.Players["SPEC"],theKey) 
				outputChatBox(thePlayer:getName().."Player Remove Team SPEC",player,255,0,0)
			end
		end
end

function CS_TeamManager:GetPlayerCountInTeam () -- T and CT
return #self.Players["CT"] + #self.Players["T"]
end