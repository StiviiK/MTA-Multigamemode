CS_GamePlayManager = inherit(Object)

function CS_GamePlayManager:constructor(CS_DM_SELF)
self.CS_DM_SELF    = CS_DM_SELF
self.GameTimer     = false --Timer für die Dauer der runde
self.WarmUpTimer   = false --Aufwärmrunde Timer
self.GameStatus = false-- "Wait","Started","Preparing",""

self.CT_Win = 0
self. T_Win = 0
self.Round  = 0
self.Round = false
self.GameStatusTable = {"Wait","Started","Preparing","WarmUp","ERROR"}
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

function CS_GamePlayManager:SetGameTime(Count,Status,Color)
self.CS_DM_SELF:setSyncInfo("GameTime", {["Time"] = getRealTime(),["Status"] = Status,["Countdown"] = Count,["Color"] = Color})
end

function CS_GamePlayManager:AllownUseShop(Status)
self.CS_DM_SELF:setSyncInfo("CanUseShop", Status)
end

function CS_GamePlayManager:StartGame()

	if not self.Round then
		self.Round = CS_Round:new(self, self.CS_DM_SELF)
		:Start()
	end
	
end

function CS_GamePlayManager:StopGame()

	if  self.Round then
		if isTimer(self.Round.Timer) then self.Round:RemoveGameTimer() end
		delete(self.Round)
		-- outputChatBox("destructor")
		 
	end
	
end

function CS_GamePlayManager:FreezeAllPlayer(status)
local CS_DM = self.CS_DM_SELF
local CT = CS_DM.CS_TeamManager:getTeamPlayers("CT")
local T  = CS_DM.CS_TeamManager:getTeamPlayers("T")

	for ID,thePlayer in ipairs(CT) do
	
		thePlayer:setFrozen(status)
		toggleAllControls ( thePlayer, not status )
		outputChatBox("FreezeAllPlayer: "..thePlayer:getName())
	end

	for ID,thePlayer in ipairs(T) do
		thePlayer:setFrozen(status)
		 toggleAllControls ( thePlayer, not status ) 
		 outputChatBox("FreezeAllPlayer: "..thePlayer:getName())
	end

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
		if Freeze then thePlayer:setFrozen(true)     end
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
		if Freeze then thePlayer:setFrozen(true)     end
	end
end

function CS_GamePlayManager:RespawnPlayer(thePlayer)
outputChatBox("RespawnPlayer")
local CS_DM = self.CS_DM_SELF

local PlayerTeam = CS_DM.CS_TeamManager:getPlayerTeam(thePlayer)

if PlayerTeam == "CT" then
		local SpawnTable = CS_DM.MapLoader:getSettings("CT_Spawn")
		local x,y,z = SpawnTable[math.random(1,#SpawnTable)]["position"]
		local rx,ry,rz = SpawnTable[math.random(1,#SpawnTable)]["rotation"]
		local skin = 100
		local Int  = 0
		local Dim  = CS_DM:getDimension()
		--spawnPlayer(thePlayer,x,y,z,rz,skin,Int,Dim,false)
		spawnPlayer ( thePlayer, x,y,z,rz)
		thePlayer:setModel(skin)
		thePlayer:setDimension(Dim)
		thePlayer:setInterior(Int)
		setCameraTarget(thePlayer,thePlayer)

		
elseif PlayerTeam == "T" then
	

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
		setCameraTarget(thePlayer,thePlayer)

	end
end



