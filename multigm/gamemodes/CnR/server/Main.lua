function CopsnRobbers:constructor()
  addRemoteEvents{"onCNRDownloadFinished","onPlayerSelectTeam","onTazerShot"}
  addEventHandler("onCNRDownloadFinished", root, bind(CopsnRobbers.onDownloadComplete, self))
  addEventHandler("onPlayerSelectTeam", root, bind(CopsnRobbers.onPlayerSelectTeam, self))
  addEventHandler("onTazerShot", root, bind(CopsnRobbers.onTazerShot, self))

  
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Load Maps
  self.m_Maps = {
    MapManager:getSingleton():loadMap(self, "gamemodes/CnR/res/maps/LSPolice.map");
  }

  -- Create Maps
  for i, v in pairs(self.m_Maps) do
    v:load()
  end

  ---Create all Jails----
  self:CreateJails ()
  self:CreateSchranken ()
  self:CreateTeleports ()
  self:CreateGates ()
  --self:CreateWeaponPickup ()
  self:CreateShops ()
  self:SpawnFractionVehicles ()
  self:CreateAmmunationShops ()
  self.WastedHandler = function() self:Wasted() end
  addEventHandler ( "onPlayerWasted", self:getRoot(), self.WastedHandler )
  
  
  ----------TESTTESTSET---

-- AutoLogin ()---Weg machen

  
end





function CopsnRobbers:destructor()
  -- Delete Maps
  for i, v in pairs(self.m_Maps) do
    delete(v)
  end
end

function CopsnRobbers:onPlayerJoin(player)
	-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerJoin" )
-----------------------------------
  player:triggerEvent("onCNRStartDownload", player)

  

  ZumTesten (self,player)
end

function CopsnRobbers:onPlayerLeft(player)

  ---Player Blip---
  local AllPlayer = self:getRoot():getAllByType("player")
  for theKey,thePlayer in ipairs(AllPlayer) do
	--  if not thePlayer == player then  
		thePlayer:triggerEvent("DestroyPlayerBlip", player)
	 -- end
  end
  
local Pos = player:getPosition()
-- outputChatBox(("onPlayerLeft Position: %s,%s,%s"):format(Pos.x,Pos.y,Pos.z),player,255,0,0)
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerLeft" )
-----------------------------------

player:setCameraTarget(player)
self:TazerRemove( player )
removeEventHandler ( "onPlayerWasted", player, self.WastedHandler )
self:Save_Player(player)
setElementData( player,"RobbedMoney", 0)
end

function CopsnRobbers:onDownloadComplete()
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onDownloadComplete" )
-----------------------------------
  self:Load_Player(client)
  
  ---Player Blip---
  local AllPlayer = self:getRoot():getAllByType("player")
	  for theKey,thePlayer in ipairs(AllPlayer) do
		 if thePlayer ~= client then  
			-- outputChatBox("Attach PlayerBlip to : "..client:getName().." #Allplayer:"..#AllPlayer)
			thePlayer:triggerEvent("CreatePlayerBlip", thePlayer,client)
		end
	  end
end


function CopsnRobbers:onPlayerSelectTeam (Fraction,Skin,SelectID)
  -- spawn the player

if Fraction == "Cops" then
   FractionTable = CNR_Cops
   spawn = CopsnRobbers:getSetting("SpawnCops")
else
   FractionTable = CNR_RobbersSkins
   spawn = CopsnRobbers:getSetting("SpawnRobbers")
end


  self:SpawnPlayer(client,spawn.Position.x,spawn.Position.y,spawn.Position.z,spawn.Rotation,spawn.Interior,dim,Skin,Fraction)

  self:GivePlayerFractionWeapons(client,FractionTable,SelectID)------Das ändern

  if CNR_DEBUG then
	LoadPosition (client)
  end
  

end

function CopsnRobbers:GivePlayerFractionWeapons(player,FractionTable,SelectID)
	for id,WeaponID in pairs(FractionTable[SelectID]["Weapons"]) do
		 giveWeapon ( player, WeaponID, 200 )
	end
end

function CopsnRobbers:ShowRadar(player)
  triggerClientEvent(player,"ShowRadar", player)
end

function CopsnRobbers:HideRadar()
  triggerClientEvent(player,"HideRadar", player)
end


function CopsnRobbers:SpawnPlayer(player,x,y,z,rot,int,dim,skin,fraction)
		  player:setPosition(x,y,z)
		  player:setRotation(0, 0, rot)
		  player:setCameraTarget(player)
		  player:setModel(skin)
		  self:setPlayerFraction(player,fraction)
		  
		  player:setInterior(int)
		  if int ~= 0 then 
			 player:setDimension(dim)
		  else
			 player:setDimension(self:getDimension())
		  end 
		 self:ShowRadar(player)
end








------------------TEST---------------------------

function ZumTesten (self,player)

	  addCommandHandler("gw",function(player,cmd,playername,wtds)
			  self:GivePlayerWanteds(getPlayerFromName(playername),tonumber(wtds))
			  outputChatBox("Give wanteds to "..playername.." :"..wtds)
	  end)

	  addCommandHandler("gf",function(player,cmd,playername) 
			  outputChatBox("Fraktion of "..playername.." :"..tostring(self:getPlayerFraction(getPlayerFromName(playername))))
	  end)

	  addCommandHandler("sf",function(player,cmd,playername,frak) 
		if getPlayerFromName(playername) and frak then
			 self:setPlayerFraction(getPlayerFromName(playername),frak)
		end
	  end)
end



function AutoLogin ()

										  setTimer(function()
										  
											for i, player in pairs(getElementsByType ( "player" )) do
										  if i == 1 then
										   Namex = "StiviK"
										  else
										   Namex = "Hans"
										  end
											
											Async.create(Account.login)(player, Namex, hash("sha256", teaEncode("krassespasswort", "mta")))
											  setTimer(function()
											JoinGamemodeTEST (player)
											  end,1000,1)
										  end
										  
										  end,1000,1)
end

function JoinGamemodeTEST (ply)
source = ply
self = GamemodeManager:getSingleton()
Id = 2
 if source:getGamemode() == self.getFromId(Id) then
    source:fadeCamera(true, 0.5)
    if fLobby ~= true then
      source:triggerEvent("errorBox", source, _("Du bist bereits in diesem Gamemode!", source))
    end
    return
  end

  if source:getGamemode() then
    source:getGamemode():removePlayer(source)
  end

  source:fadeCamera(true, 0.75)
  self.getFromId(Id):addPlayer(source)
  if fLobby ~= true then
    source:triggerEvent("successBox", source, _("Du bist dem Gamemode erfolgreich beigetreten!", source))
  end

end
