function CopsnRobbers:constructor()
  addRemoteEvents{"onCNRDownloadFinished"}
  addEventHandler("onCNRDownloadFinished", root, bind(CopsnRobbers.onDownloadComplete, self))

  addRemoteEvents{"onPlayerSelectTeam"}
  addEventHandler("onPlayerSelectTeam", root, bind(CopsnRobbers.onPlayerSelectTeam, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))

  -- Load Maps
  self.m_Maps = {
    MapManager:getSingleton():loadMap(self, "gamemodes/CnR/files/maps/LSPolice.map");
  }

  -- Create Maps
  for i, v in pairs(self.m_Maps) do
    v:load()
  end
end

function CopsnRobbers:destructor()
  -- Delete Maps
  for i, v in pairs(self.m_Maps) do
    delete(v)
  end
end

function CopsnRobbers:onPlayerJoin(player)

  player:triggerEvent("onCNRStartDownload", player)
end

function CopsnRobbers:onPlayerLeft(player)
self:DestroyPlayerBlip(player)--DestroyPlayerBlip
end

function CopsnRobbers:onDownloadComplete()

  -- spawn the player

  -- local spawn = self:getSetting("SpawnCops")
  -- client:setPosition(spawn.Position)
  -- client:setRotation(0, 0, spawn.Rotation)
  -- client:setInterior(spawn.Interior)
  -- client:setDimension(CNR_DIM)

 --CreatePlayerBlip
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
  client:setDimension(CNR_DIM)

  self:GivePlayerFractionWeapons(client,FractionTable,SelectID)
  self:CreatePlayerBlip(client)


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
