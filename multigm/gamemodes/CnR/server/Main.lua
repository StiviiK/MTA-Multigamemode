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
  --self:CreateAmmunationShops ()
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
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerLeft" )
-----------------------------------

player:setCameraTarget(player)

removeEventHandler ( "onPlayerWasted", player, self.WastedHandler )
local x,y,z = getElementPosition(player)
outputChatBox(x..","..y..","..z)
outputChatBox(debug.traceback())
end

function CopsnRobbers:onDownloadComplete()
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onDownloadComplete" )
-----------------------------------
  -- spawn the player

  -- local spawn = self:getSetting("SpawnCops")
  -- client:setPosition(spawn.Position)
  -- client:setRotation(0, 0, spawn.Rotation)
  -- client:setInterior(spawn.Interior)
  -- client:setDimension(self:getDimension())

 --CreatePlayerBlip
  
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
  client:setDimension(self:getDimension())

  self:GivePlayerFractionWeapons(client,FractionTable,SelectID)

  if CNR_DEBUG then
	LoadPosition (client)
  end
  

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
