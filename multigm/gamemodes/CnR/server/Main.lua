function CopsnRobbers:constructor()
  addRemoteEvents{"onCNRDownloadFinished"}
  addEventHandler("onCNRDownloadFinished", root, bind(CopsnRobbers.onDownloadComplete, self))

  addRemoteEvents{"onPlayerSelectTeam"}
  addEventHandler("onPlayerSelectTeam", root, bind(CopsnRobbers.onPlayerSelectTeam, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Maps
  MapManager:getSingleton():loadMap(self, "gamemodes/CnR/files/maps/LSPolice.map"):load(MAP_LOADING_NORMAL)
end

function CopsnRobbers:destructor()

end

function CopsnRobbers:onPlayerJoin(player)

  player:triggerEvent("onCNRStartDownload", player)
end

function CopsnRobbers:onPlayerLeft(player)
self:DestroyPlayerBlip(player)--DestroyPlayerBlip
end

function CopsnRobbers:onDownloadComplete()

  -- spawn the player

  local spawn = self:getSetting("SpawnCops")
  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
  client:setDimension(CNR_DIM)

  self:CreatePlayerBlip(client)--CreatePlayerBlip
  addEventHandler ( "onPlayerWasted", client, bind(CopsnRobbers.Wasted,self) )
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


  client:setPosition(spawn.Position)
  client:setRotation(0, 0, spawn.Rotation)
  client:setInterior(spawn.Interior)
  client:setCameraTarget(client)
  client:setModel(Skin)
  client:setFraction(Fraction)
  self:GivePlayerFractionWeapons(client,FractionTable,SelectID)
--  client:setDimension()
outputChatBox("Hier Dimension einfügen und Fraction")
end

function CopsnRobbers:GivePlayerFractionWeapons(player,FractionTable,SelectID)
	for id,WeaponID in pairs(FractionTable[SelectID]["Weapons"]) do
		 giveWeapon ( player, WeaponID, 200 )
	end
end

function Player:setFraction(Fraction)
self.Fraction = Fraction
end

function Player:getFraction()
return self.Fraction
end
