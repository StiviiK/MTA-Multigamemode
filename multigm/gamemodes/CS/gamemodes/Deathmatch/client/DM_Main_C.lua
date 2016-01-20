function CS_Deathmath:constructor()
--Handler--
  addRemoteEvents{"CS_Deathmath_PlayerTeamSelected","CS_Deathmath_PlayerTeamRemove"}
  
  addEventHandler("CS_Deathmath_PlayerTeamSelected", root, bind(CS_Deathmath.PlayerTeamSelected, self))
  addEventHandler("CS_Deathmath_PlayerTeamRemove"  , root, bind(CS_Deathmath.PlayerTeamRemove, self))
  -- outputChatBox("CS_Deathmath:constructor CLIENT")

  self.MapLoader       = CS_MapLoader:new(self)
  self.GamePlayManager = CS_GamePlayManager:new(self)
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
end

function CS_Deathmath:destructor()
-- delete(CS_Team_Select_Menu:getSingleton()) 
-- delete(self.CS_MapLoader)
delete(self)
self:DeletePlayerHud ()
end

function CS_Deathmath:onPlayerJoin()
outputChatBox("CS_Deathmath:onPlayerJoin client")
LoadingScreen_Menu:getSingleton()
self.MapLoader:LoadMap(1)
self:CreatePlayerHud ()

end

function CS_Deathmath:CreatePlayerHud ()
  Health_HUD:new(self)
  Weapon_HUD:new(self)
  Timer_HUD:new(self)
end

function CS_Deathmath:DeletePlayerHud ()
  delete(Health_HUD:getSingleton())
  delete(Weapon_HUD:getSingleton())
  delete(Timer_HUD :getSingleton())
end

function CS_Deathmath:onPlayerLeft()
outputChatBox("CS_Deathmath:onPlayerLeft client")
-- delete(CS_Team_Select_Menu:getSingleton()) 
self:DeletePlayerHud ()
end


function CS_Deathmath:PlayerTeamSelected()
-- local MapSettings = self.CS_MapLoader:getSingleton():getSettings()

-- local AllPosCount = #MapSettings ["T_Spawn"]
-- local Pos = MapSettings ["T_Spawn"][math.random(1,AllPosCount)]["position"]
-- local Rot = MapSettings ["T_Spawn"][math.random(1,AllPosCount)]["rotation"]
-- triggerServerEvent("CS_Deathmath_SpawnPlayer",localPlayer,localPlayer,{Pos.x, Pos.y, Pos.z},{Rot.x, Rot.y, Rot.z})
end


function CS_Deathmath:PlayerTeamRemove()

end

function CS_Deathmath:MapIsReady(MapSettings)
local Pos    = MapSettings ["Camera_T_Spawn"][1]["position"]
local LookAt = MapSettings ["Camera_T_Spawn"][1]["rotation"]
setCameraMatrix(Pos,LookAt)
LoadingScreen_Menu:getSingleton():Remove()
CS_Team_Select_Menu:getSingleton()
end