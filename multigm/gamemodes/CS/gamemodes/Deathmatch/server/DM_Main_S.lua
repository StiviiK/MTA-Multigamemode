function CS_Deathmath:constructor()
  addRemoteEvents{"CS_Deathmath_SpawnPlayer"}
  addEventHandler("CS_Deathmath_SpawnPlayer", root, bind(CS_Deathmath.SpawnPlayer, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  -- outputChatBox("CS_Deathmath:constructor",player,0,255,0)
  self.CS_TeamManager = CS_TeamManager:new (self)
  
  self.MapLoader      = CS_MapLoader:new(self)
  self.MapLoader:LoadMapSettings(STANDART_MAP)
  
  self.GamePlay_MG    = CS_GamePlayManager:new(self)

  

end



function CS_Deathmath:destructor()
-- delete(self.CS_MapLoader)
-- delete(self)
end

function CS_Deathmath:onPlayerJoin(player)
outputChatBox("CS_Deathmath:onPlayerJoin server",player,0,255,0)
-- outputChatBox("PLAYER GM:"..tostring(player:getGamemode()))
-- player:setPosition(125.16999816895,2675.9699707031,38.878318786621)
-- player:setFrozen(false)
-- toggleAllControls (player, false )
 
-- self.CS_TeamManager:addPlayerTeam (player,"CT")----TEST
-- outputChatBox("join:"..self.CS_TeamManager:GetPlayerCountInTeam())


end

function CS_Deathmath:SpawnPlayer(player,Pos,Rot)
-- outputChatBox("CS_Deathmath:onPlayerSpawnPlayer",player,0,255,0)

-- player:setPosition(Pos[1],Pos[2],Pos[3])
-- player:setRotation(Rot[1],Rot[2],Rot[3])
-- setCameraTarget(player,player)
end

function CS_Deathmath:onPlayerLeft(player)
outputChatBox("CS_Deathmath:onPlayerLeft server",player,0,255,0)
-- player:setFrozen(true)
-- toggleAllControls (player, true ) 
 
-- outputChatBox("leave:"..self.CS_TeamManager:GetPlayerCountInTeam())
	self.CS_TeamManager:RemovePlayerTeam (player)
    self.GamePlay_MG:CheckPlayer(player,self.CS_TeamManager:GetPlayerCountInTeam())

end

function CS_Deathmath:PlayerTeamSelected (player,Team)
     self.GamePlay_MG:CheckPlayer(player,self.CS_TeamManager:GetPlayerCountInTeam())
outputChatBox("Player Select Team: "..Team)
end

function CS_Deathmath:PlayerTeamRemove (player,Team)
-- triggerClientEvent(player,"CS_Deathmath_PlayerTeamRemove",player,player,Team)
end


