CS_GamePlayManager = inherit(Object)

function CS_GamePlayManager:constructor(CS_DM_SELF)
self.CS_DM_SELF    = CS_DM_SELF
self.GameTimer     = false --Timer für die Dauer der runde
self.WarmUpTimer   = false --Aufwärmrunde Timer
self.GameStatus = false-- "Wait","Started","Preparing"
self.Round  = 0
self.CT_Win = 0
self. T_Win = 0

self.GameStatusTable = {"Wait","Started","Preparing"}
end

function CS_GamePlayManager:destructor()

end

function CS_GamePlayManager:CheckPlayer(player,GameModePlayersCount)
-- 1.) wenn spieler join  dann 
-- 2.) wenn spieler leave dann

		if GameModePlayersCount >= MIN_PLAYER then -- genug spieler
			self:StartGame()
			outputChatBox("Enough Player")
		else -- nicht genug spieler
			self:StopGame()
			outputChatBox("Waiting for Player")
		end
		
end

function CS_GamePlayManager:SetGameStatus(GameStatusID)
self.GameStatus = self.GameStatusTable[GameStatusID]
self.CS_DM_SELF:setSyncInfo("GameStatus",self.GameStatusTable[GameStatusID])
end

function CS_GamePlayManager:SetGameTime(Count,Status)
self.CS_DM_SELF:setSyncInfo("GameTime", {["Time"] = getRealTime(),["Status"] = Status,["Countdown"] = Count})
end

function CS_GamePlayManager:StartGame()
self:StartWarmUp()
self:SpawnBothTeams(false)--Spawnen aber nicht freezen
end


function CS_GamePlayManager:FreezeAllPlayer(status)
local CS_DM = self.CS_DM_SELF
local CT = CS_DM.CS_TeamManager:getTeamPlayers("CT")
local T  = CS_DM.CS_TeamManager:getTeamPlayers("T")
	for ID,thePlayer in ipairs(CT) do
	
		thePlayer:setFrozen(status)
	end

	for ID,thePlayer in ipairs(CT) do
		thePlayer:setFrozen(status)
	end

end

function CS_GamePlayManager:StopGame()
self.GameStart = false
if isTimer(self.GameTimer)   then killTimer(self.GameTimer  ) end
if isTimer(self.WarmUpTimer) then killTimer(self.WarmUpTimer) end
-- outputChatBox("StopGame")
end

function CS_GamePlayManager:StartWarmUp()
outputChatBox("WarmUp On")

self:SetGameStatus(3)

self:SetGameTime(WARMUP_TIME,true)

self.WarmUpTimer = setTimer(function()

	outputChatBox("WarmUp Ende")
	self:FirstRound()
	
end,WARMUP_TIME,1)

end

function CS_GamePlayManager:FirstRound()
outputChatBox("FirstRound")
self:SpawnBothTeams(true)
----------TODO: Takeall weapons
self:SetGameStatus(2)
self:SetGameTime(15*1000,true)

self.WarmUpTimer = setTimer(function()
self:FreezeAllPlayer(false)	
end,15*1000,1)

end

function CS_GamePlayManager:OnPlayerDied()
outputChatBox("OnPlayerDied")
--- getplayerTeam T/CT
--- 

end

-- triggerClientEvent(player,"CS_onStartWarmUp")
-- triggerClientEvent(player,"CS_onFirstRound")
-- triggerClientEvent(player,"CS_NextRound")

function CS_GamePlayManager:NextRound()

outputChatBox("NextRound")


end

function CS_GamePlayManager:StopRound()
outputChatBox("NextRound")


end

function CS_GamePlayManager:SpawnBothTeams(Freeze)
local CS_DM = self.CS_DM_SELF

local CT = CS_DM.CS_TeamManager:getTeamPlayers("CT")
local T  = CS_DM.CS_TeamManager:getTeamPlayers("T")

	for ID,thePlayer in ipairs(CT) do
		local SpawnTable = CS_DM.MapLoader:getSettings("CT_Spawn")
		local x,y,z = SpawnTable[math.random(1,#SpawnTable)]["position"]
		local rx,ry,rz = SpawnTable[math.random(1,#SpawnTable)]["rotation"]
		local skin = 100
		local Int  = 0
		local Dim  = CS_DM:getDimension()
		--spawnPlayer(thePlayer,x,y,z,rz,skin,Int,Dim,false)
		spawnPlayer ( thePlayer, x,y,z,rz)
		thePlayer:setModel(skin)
		thePlayer:setInterior(Int)
		thePlayer:setDimension(Dim)
		setCameraTarget(thePlayer,thePlayer)
		if Freeze then thePlayer:setFrozen(true) end
	end
	
	for ID,thePlayer in ipairs(T) do
	    local SpawnTable = CS_DM.MapLoader:getSettings("T_Spawn")
		local x,y,z = SpawnTable[math.random(1,#SpawnTable)]["position"]
		local rx,ry,rz = SpawnTable[math.random(1,#SpawnTable)]["rotation"]
		local skin = 100
		local Int  = 0
		local Dim  = CS_DM:getDimension()
		spawnPlayer(thePlayer,x,y,z,rz)
		thePlayer:setModel(skin)
		thePlayer:setDimension(Dim)
		thePlayer:setInterior(Int)
		thePlayer:setDimension(Dim)
		setCameraTarget(thePlayer,thePlayer)
		if Freeze then thePlayer:setFrozen(true) end
	end
end




function CS_GamePlayManager:LoadNewMap(MapID)

end
