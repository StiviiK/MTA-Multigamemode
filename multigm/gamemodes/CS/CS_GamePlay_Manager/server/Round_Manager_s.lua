CS_Round = inherit(Object)

function CS_Round:constructor(GamePlayManager, GM)
self.GamePlayManager = GamePlayManager
self.GM = GM
self.WarmUpTime       = 10--3*60
self.MainGameTime     = 10--5*60
self.PauseTime        = 10
self.PerparingTime    = 5
self.GameRound        = 0
self.PlayerDied = function(...) self:onPlayerDied(...) end
end

function CS_Round:destructor()
--Reset

end

function CS_Round:Start()
PlayerManager:getSingleton():getWastedHook():register(self.PlayerDied)--EVENT onPlayerWasted
self:WarmUP_Start()
end



function CS_Round:WarmUP_Start()
outputChatBox("CS_Round:WarmUP_Start ,",root,255,0,0)


self.GamePlayManager:SpawnBothTeams(false) --- Spawn Both Teams
   
self.Pause_func = function(...) self:Pause(...) end

self:CreateGameTimer (self.WarmUpTime,self.Pause_func,4)--Warmup

end

function CS_Round:Pause(func)
outputChatBox("CS_Round:Pause ,",root,255,0,0)
self.GamePlayManager:FreezeAllPlayer(true)

self.Perparing_To_Start_func = function(...) self:Perparing_To_Start(...) end

self:CreateGameTimer (self.PauseTime,self.Perparing_To_Start_func,4)
end

function CS_Round:Perparing_To_Start()
--- Restart Stats
self.GamePlayManager:SpawnBothTeams(true)

self.Next_Round_func = function(...) self:Next_Round(...) end

self:CreateGameTimer (self.PerparingTime,self.Next_Round_func,3)
end

function CS_Round:Next_Round()
self.CheckWhoWin_func = function(...) self:CheckWhoWin(...) end

self:CreateGameTimer (self.MainGameTime,self.CheckWhoWin_func,2)
self.GamePlayManager:FreezeAllPlayer(false)
outputChatBox("CS_Round:Next_Round()",root,255,0,0)

end


function CS_Round:CreateGameTimer (Time,Func,GameModeStatusID)
if not Time and not type(Func) then outputChatBox("CreateGameTimer ERROR") end
if isTimer(self.Timer) then self:RemoveGameTimer() end
self.GamePlayManager:SetGameTime(Time*1000,true,{})
self.GamePlayManager:SetGameStatus(GameModeStatusID or 5)
self.Timer = Timer(Func,Time*1000,1)
end

function CS_Round:RemoveGameTimer ()
	if isTimer(self.Timer) then
		self.GamePlayManager:SetGameTime(0,true,{})
		killTimer(self.Timer)
		outputChatBox("RemoveGameTimer")
	end
end



function CS_Round:CheckWhoWin()
outputChatBox("Time over")
local CT,T       = self.GM.CS_TeamManager:WhoIsAlive ()
local TeamCounts = self.GM.CS_TeamManager:GetPlayerCountInTeam ()

outputChatBox("Alive CT:"..#CT.." Alive T"..#T)

	if TeamCounts >= MIN_PLAYER  then
		self:CreateGameTimer (self.PauseTime,self.Perparing_To_Start_func)
	end
end

function CS_Round:SetWinnerTeam(TEAM)

end

function CS_Round:onPlayerDied()
	if source:getSubGamemode() == self.GM then
	outputChatBox("CS_Round:onPlayerDied GameStatus:"..tostring(self.GamePlayManager.GameStatus))
		local TEAM = self.GM.CS_TeamManager:getPlayerTeam(source)

			if self.GamePlayManager.GameStatus == self.GamePlayManager.GameStatusTable[4] then --warmup
				self.GamePlayManager:RespawnPlayer(source)
			end

			
			if self.GamePlayManager.GameStatus == self.GamePlayManager.GameStatusTable[2] then --Started
					if     TEAM == "CT"  then
						outputChatBox("CT-OOO")
					elseif TEAM ==  "T"  then
						outputChatBox("T-OOO")
					elseif TEAM == "SPEC" then
						outputChatBox("SPEC-OOO")
					else
						outputChatBox("ERROR: PLAYER HAS NO TEAM")
					end
					
					self:CheckWhoWin()
			end

				
	end
end