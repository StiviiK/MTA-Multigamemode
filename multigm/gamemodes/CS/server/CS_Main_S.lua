
--Deathmatch,Demolition,Bombdefusal

function CS:constructor()
  addRemoteEvents{"onCSDownloadFinished","SpawnPlayer","CS_Event_SetPlayerTeam"}
  addEventHandler("onCSDownloadFinished", root, bind(CS.onDownloadComplete, self))
  addEventHandler("CS_Event_SetPlayerTeam", root, bind(CS.addPlayerTeam, self))
   -- Load translation file
  -- TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  self.SubGamemodeManager = SubGamemodeManager:new(self)
  
  self:AutoLogin ()
end

function CS:destructor()
delete(self.SubGamemodeManager)
-- outputChatBox("CS:destructor",getRootElement(),255,0,0)
-- delete(CS_GamemodeManager:getSingleton())
end

function CS:addPlayerTeam(player,Team)
player:getSubGamemode().CS_TeamManager:addPlayerTeam (player,Team)
end

function CS:onPlayerJoin(player)
SubGamemodeManager.sendInitialSync(player)  --SubGamemodeManager

-- outputChatBox("CS:onPlayerJoin",player,255,0,0)
player:triggerEvent("onCSStartDownload", player)

player:setPosition(0,0,3)
setTimer(function()
SubGamemodeManager:getSingleton().Map[1]:addPlayer(player)
end,2000,1)

end



function CS:onPlayerLeft(player)
    if player:getSubGamemode() then
		player:getSubGamemode():removePlayer(player)
	end
-- outputChatBox("CS:onPlayerLeft",player,255,0,0)
end

function CS:onDownloadComplete()
-- outputChatBox("CS:onDownloadComplete",source,255,0,0)
-- self.CS_GamemodeManager:AddPlayerCSGamemode(source,self.Deathmatch,self)
end


















function CS:AutoLogin ()

										  setTimer(function()
										  
											for i, player in pairs(getElementsByType ( "player" )) do
										  if i == 1 then
										   Namex = "StiviK"
										  else
										   Namex = "Hans"
										  end
											
											Async.create(Account.login)(player, Namex, hash("sha256", teaEncode("krassespasswort", "mta")))
											  setTimer(function()
											    for i =1,6 do
	outputChatBox("   ")
  end
outputChatBox("-------------")
											self:JoinGamemodeTEST (player)
											  end,1000,1)
										  end
										  
										  end,1000,1)
end

function CS:JoinGamemodeTEST (ply)
source = ply

  if source:getGamemode() then
    source:getGamemode():removePlayer(source)
  end

  self:addPlayer(source)


end
