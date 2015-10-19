lp = getLocalPlayer()

function outputMyPosition()
local x,y,z = getElementPosition(lp)
local rx,ry,rz = getElementRotation(lp)
outputChatBox("--Position: "..x..","..y..","..z)
outputChatBox("--Rotation: "..rx..","..ry..","..rz)
end
addCommandHandler("omp",outputMyPosition)

-----------------------------------------------




function CopsnRobbers:constructor()
  --outputDebug("Lobby:constructor")
  addRemoteEvents{"onCNRStartDownload"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))

   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  
  

end

function CopsnRobbers:destructor()
end

function CopsnRobbers:onPlayerJoin()
if self.Radar then
	self.Radar:show()
else
	self.Radar = new(MiniMap)
end
-- self:CreatePlayerBlip()
self.FractionSelectionMenu = FractionSelectionMenu:new(self)
end

-- function CopsnRobbers:CreatePlayerBlip()
-- if lp == source then return end
 -- source.MapBlip = createBlip( 0, 0, 0 )
 -- source.MapBlip:setDimension(CNR_DIM)
-- end

function CopsnRobbers:onPlayerSelectTeam(Team,Skin,SelectID)
self.Radar:show()
end







function CopsnRobbers:onPlayerLeft()

 HudComponentVisible(false)
 -- Delete Fraction Selection Menu
	self.FractionSelectionMenu:delete ()
	
 -- Restore custom Arrow
	Engine.restoreCOL(1318)
	Engine.restoreModel(1318)
 -- Hide Radar
	self.Radar:hide()
end

function CopsnRobbers:onDownloadStart()
  Provider:getSingleton():requestFile(CNR_DOWNLOAD_FILE, bind(CopsnRobbers.onDownloadFinish, self))
end

function CopsnRobbers:onDownloadFinish()
  triggerServerEvent("onCNRDownloadFinished", localPlayer)

  -- Load custom Arrow
  EngineCOL("gamemodes/CnR/res/col/EntranceMarker.col"):replace(1318)
  EngineTXD("gamemodes/CnR/res/txd/EntranceMarker.txd"):import(1318)
  EngineDFF("gamemodes/CnR/res/dff/EntranceMarker.dff", 0):replace(1318)
  HudComponentVisible(true)
end


function HudComponentVisible(State)
setPlayerHudComponentVisible (  "all", State )
end
