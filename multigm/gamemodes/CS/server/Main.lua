--Deathmatch,Demolition,Bombdefusal

function CS:constructor()
 addRemoteEvents{"onCSDownloadFinished"}
  addEventHandler("onCSDownloadFinished", root, bind(CS.onDownloadComplete, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

	
 self.CS_GamemodeManager = CS_GamemodeManager:new()
 
 self.Deathmatch =  self.CS_GamemodeManager:CreateNewGamemode(CS_Deathmath)
 self.Demolition =  self.CS_GamemodeManager:CreateNewGamemode(CS_DEMOLITION)
 self.Bombdefusal = self.CS_GamemodeManager:CreateNewGamemode(CS_BOMB_DEFUSAL)

 
 -- self:AutoLogin ()
end

function CS:destructor()
outputChatBox("CS:destructor",getRootElement(),255,0,0)
delete(CS_GamemodeManager:getSingleton())
end

function CS:onPlayerJoin(player)
outputChatBox("CS:onPlayerJoin",player,255,0,0)
player:triggerEvent("onCSStartDownload", player)

player:setPosition(0,0,3)


end



function CS:onPlayerLeft(player)
outputChatBox("CS:onPlayerLeft",player,255,0,0)
end

function CS:onDownloadComplete()
outputChatBox("CS:onDownloadComplete",source,255,0,0)
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
outputChatBox("autologin")

end
