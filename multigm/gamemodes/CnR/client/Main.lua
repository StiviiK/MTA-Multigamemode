lp = getLocalPlayer()

function outputMyPosition()
local x,y,z = getElementPosition(lp)
local rx,ry,rz = getElementRotation(lp)
outputChatBox("--Position: "..x..","..y..","..z)
outputChatBox("--Rotation: "..rx..","..ry..","..rz)
end
addCommandHandler("omp",outputMyPosition)

function outputMyMatrix()
outputChatBox(("--Matrix: %s , %s , %s , %s , %s , %s "):format(getCameraMatrix ()))
end
addCommandHandler("omm",outputMyMatrix)

-----------------------------------------------




function CopsnRobbers:constructor()

  addRemoteEvents{"onCNRStartDownload"}
  addEventHandler("onCNRStartDownload", root, bind(CopsnRobbers.onDownloadStart, self))
  
  addRemoteEvents{"CreateFractionSelectMenu"}
  addEventHandler("CreateFractionSelectMenu", root, bind(CopsnRobbers.CreateFractionSelectMenu, self))
   -- Load translation file
  TranslationManager:getSingleton():loadTranslation("en", self:get("TranslationFile"))
  

-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:constructor" )
-----------------------------------

end

function CopsnRobbers:destructor()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:destructor" )
-----------------------------------
end

function CopsnRobbers:onPlayerJoin()

if not self.Radar then
	self.Radar = new(MiniMap)
end

self:CreateWeaponSelectionEvent ()
self:ShopGUI_Event ()

	---------------------------CNR_DEBUG------------------------------------
				if CNR_DEBUG then
					
					for i = 1,2 do
					outputChatBox("\n",tocolor(0,255,0))
					end
					outputChatBox("### CNR_DEBUG Enabled ###",tocolor(0,255,0))
				end
	-----------------------------------------------------------------------
	
	-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onPlayerJoin" )
-----------------------------------
end


function CopsnRobbers:onPlayerSelectTeam(Team,Skin,SelectID)
	self.Radar:show()
end







function CopsnRobbers:onPlayerLeft()
-----------CNR_DEBUG---------------
-- DebugOutPut( "CopsnRobbers:onPlayerLeft" )
-----------------------------------

 HudComponentVisible(false)
 -- Delete Fraction Selection Menu
	
	if not CNR_DEBUG then
	self.FractionSelectionMenu:delete ()
	end
 -- Restore custom Arrow
	Engine.restoreCOL(1318)
	Engine.restoreModel(1318)
 -- Hide Radar
	self:DestroyWeaponSelection ()	
	self.Radar:hide()
	self.ShopGUI_destructor()
end

function CopsnRobbers:onDownloadStart()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onDownloadStart" )
-----------------------------------

  Provider:getSingleton():requestFile(CNR_DOWNLOAD_FILE, bind(CopsnRobbers.onDownloadFinish, self))
end

function CopsnRobbers:onDownloadFinish()
-----------CNR_DEBUG---------------
 -- DebugOutPut( "CopsnRobbers:onDownloadFinish" )
-----------------------------------
  triggerServerEvent("onCNRDownloadFinished", localPlayer)

  -- Load custom Arrow
  EngineCOL("gamemodes/CnR/res/col/EntranceMarker.col"):replace(1318)
  EngineTXD("gamemodes/CnR/res/txd/EntranceMarker.txd"):import(1318)
  EngineDFF("gamemodes/CnR/res/dff/EntranceMarker.dff", 0):replace(1318)
  HudComponentVisible(true)
end


function HudComponentVisible(State)
setPlayerHudComponentVisible (  "all", State )
setPlayerHudComponentVisible (  "radar", false )
setPlayerHudComponentVisible (  "radio", false )
setPlayerHudComponentVisible (  "area_name", false )
setPlayerHudComponentVisible (  "vehicle_name", false )
end
