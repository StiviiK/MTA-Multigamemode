function CopsnRobbers:constructor()
  addRemoteEvents{"onCNRDownloadFinished"}
  addEventHandler("onCNRDownloadFinished", root, bind(CopsnRobbers.onDownloadComplete, self))

  addRemoteEvents{"onPlayerSelectTeam"}
  addEventHandler("onPlayerSelectTeam", root, bind(CopsnRobbers.onPlayerSelectTeam, self))

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
  self:SpawnFractionVehicles ()
  self:CreateAmmunationShops ()
  self:CreateShops ()
  self.WastedHandler = function() self:Wasted() end
  addEventHandler ( "onPlayerWasted", self:getRoot(), self.WastedHandler )
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
end

function CopsnRobbers:onPlayerLeft(player)
local Pos = player:getPosition()
outputChatBox(("onPlayerLeft Position: %s,%s,%s"):format(Pos.x,Pos.y,Pos.z),player,255,0,0)
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerLeft" )
-----------------------------------
self:Save_Player(player)

player:setCameraTarget(player)

removeEventHandler ( "onPlayerWasted", player, self.WastedHandler )
end

function CopsnRobbers:onDownloadComplete()
-----------CNR_DEBUG---------------
DebugOutPut( "CopsnRobbers:onDownloadComplete" )
-----------------------------------
  self:Load_Player(client)
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

function Player:setFraction(Fraction)
self.Fraction = Fraction
end

function Player:getFraction()
return self.Fraction
end

function CopsnRobbers:SpawnPlayer(player,x,y,z,rot,int,dim,skin,fraction)
		  player:setPosition(x,y,z)
		  player:setRotation(0, 0, rot)
		  player:setCameraTarget(player)
		  player:setModel(skin)
		  player:setFraction(fraction)
		  
		  player:setInterior(int)
		  if int ~= 0 then 
			 player:setDimension(dim)
		  else
			 player:setDimension(self:getDimension())
		  end 
		 self:ShowRadar(player)
end